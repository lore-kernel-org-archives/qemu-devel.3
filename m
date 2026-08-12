Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0ACC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu859-0005aO-8i; Wed, 12 Aug 2026 08:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wu854-0005Yi-8e
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wu852-0003DA-Ra
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786537750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M34EEtiewfcYwN/r2XFr6daG8bTebw/L3AJ6mjWi7tc=;
 b=PPXKcb1Un680xlzWCaP7jTiQXOFp9t48xvCG/Kg9+u6KrygyKJj9N9Mnu7G/aTVpU81wUV
 2cyRj0RK6OioxhwGHdSRPQVI5bxUxQ3OE3jVg3vHm39DZ4ztSWPyNZyvICs2fbxFtob69l
 MCzZUNIN8NGgnmJP3KFXDKgkJhnuwPw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-_YJ0rMHCPRWgoNFrSBIEgg-1; Wed,
 12 Aug 2026 08:29:00 -0400
X-MC-Unique: _YJ0rMHCPRWgoNFrSBIEgg-1
X-Mimecast-MFC-AGG-ID: _YJ0rMHCPRWgoNFrSBIEgg_1786537737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED9E21800990; Wed, 12 Aug 2026 12:28:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FFBB180034C; Wed, 12 Aug 2026 12:28:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus
 Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-s390x@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Corey Minyard <minyard@acm.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, David Hildenbrand
 <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, "Dr.
 David Alan Gilbert"
 <dave@treblig.org>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Eric Blake
 <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/7] hw/s390x/virtio-ccw: Always inject NMI to first CPU
In-Reply-To: <20260811154930.13915-3-philmd@oss.qualcomm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
 <20260811154930.13915-3-philmd@oss.qualcomm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Wed, 12 Aug 2026 14:28:52 +0200
Message-ID: <87fr0jr08r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 11 2026, Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =
wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> We can trigger NMI from HMP or QMP.
>
> QEMU maps the NMI to the s390x per-CPU 'RESTART' interrupt.
> Linux guests usually setup this interrupt to trigger kdump
> or crash. Such crashdump can be triggered in QEMU by HMP
> "nmi" or QMP "inject-nmi" commands.
>
> Using QMP, since we can not select a particular CPU, the first
> CPU is used (CPU#0). See the documentation from commit 795dc6e4
> ("watchdog: Add new Virtual Watchdog action INJECT-NMI"):
>
>   @inject-nmi: a non-maskable interrupt is injected into the
>                first VCPU (all VCPUS on x86) (since 2.4)
>
> While we can select a particular CPU on HMP, the guest behavior
> is expected to be the same if using CPU #N or CPU #0. Since
> always using CPU#0 simplifies API maintainance, update s390_nmi()
> to inject NMI to the first CPU.

In theory, we could have different actions setup for different cpus. In
practice, Linux does not do that, and I'm not sure if anything else we
might run does -- especially as we always end up with CPU 0 for QMP
anyway.

So I'm fine with getting rid of the different behaviour between HMP and
QMP, especially as it allows simplifying the code.

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  qapi/machine.json          | 7 ++++---
>  qapi/run-state.json        | 6 ++++--
>  hw/s390x/s390-virtio-ccw.c | 4 +---
>  hmp-commands.hx            | 5 +++--
>  4 files changed, 12 insertions(+), 10 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>


