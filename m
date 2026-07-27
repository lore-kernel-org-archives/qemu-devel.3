Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B09BC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKEQ-0006Nd-5W; Mon, 27 Jul 2026 08:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1woKE0-0006MQ-HX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1woKDy-0007WM-Pq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785154464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7AYftsPdDtLkdlDOsXtc3pbVkUtvdzqqem7Vbzn+RE=;
 b=EHnwBoMDvMJI7OlHv6GcCs9UCmbv+DzRuOHs+Pdi8xUZNS/nL+h8ZstQ4OeuHGGArxTpW1
 uCEhraUqvRkn5I2zWOkgHVx4TYqvExVfYEiwp63YBoBSZv4Txb6ojkjme87xG7bLyAUpzg
 f3IB+ihqWV+o9gHTYjHO7OJWPdaK8DU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-iMBCfNU6MlKdwNyh7Nv8OQ-1; Mon,
 27 Jul 2026 08:14:21 -0400
X-MC-Unique: iMBCfNU6MlKdwNyh7Nv8OQ-1
X-Mimecast-MFC-AGG-ID: iMBCfNU6MlKdwNyh7Nv8OQ_1785154457
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0B77195609E; Mon, 27 Jul 2026 12:14:16 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCF6B18001E0; Mon, 27 Jul 2026 12:14:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@kernel.org>, Hendrik Brueckner <brueckner@linux.ibm.com>, Joshua
 Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jared
 Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/5] more hardening fixes for s390
In-Reply-To: <20260727115052.24289-1-borntraeger@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 27 Jul 2026 14:14:13 +0200
Message-ID: <87ldawsk8a.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 27 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Cornelia, Eric, Matt,
>
> here are 5 more fixes for hardening QEMU against invalid input. Nothing
> is strictly a security issues as defined in the policy. For example
> https://qemu-project.gitlab.io/qemu/system/security.html says assert /
> abort: If triggering the code path requires kernel privileges (or root
> account access) in the guest, asserts/aborts in QEMU are a self
> inflicted denial of service. These will not be treated as security
> flaws, at most hardening bugs.
> And if anyone can provide invalid boot loader content it can provide
> anything to boot if secure boot is not available.
> We should fix those anyway, probably even for 11.1 

Fixing: yes. For 11.1: how easy are they to trigger? For the bios fixes,
I assume you need a broken/crafted disk image; I assume that for the
other two, you need some buggy/misbehaving guest. Did you actually
manage to trigger this via some kind of test case?

>
> Conny, I did not rebuild the s390-ccw, I assume you will do that?

Yes, the bios rebuild will be done by whoever ends up applying the
patches.

>
> Christian Borntraeger (1):
>   hw/char/sclpconsole-lm: avoid guest triggerable assert
>
> Joshua Daley (4):
>   s390x/ipl: validate num_comp against iplb length before iterating
>   pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
>   pc-bios/s390-ccw: bounds-check zipl menu entry index before array
>     write
>   pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in
>     zipl_print_entry
>
>  hw/char/sclpconsole-lm.c    |  3 ++-
>  hw/s390x/ipl.h              |  6 ++++++
>  pc-bios/s390-ccw/bootmap.c  |  6 ++++--
>  pc-bios/s390-ccw/helper.h   | 10 ++++++++++
>  pc-bios/s390-ccw/menu.c     | 36 +++++++++++++++++++++++++++++-------
>  pc-bios/s390-ccw/s390-ccw.h |  2 +-
>  6 files changed, 52 insertions(+), 11 deletions(-)


