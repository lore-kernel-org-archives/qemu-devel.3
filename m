Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D174C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78qT-0002a8-TU; Thu, 17 Sep 2026 05:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x78qS-0002a0-6u
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x78qQ-0003lP-Gt
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789638952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJkYp24uepgUOt/YopWOEa4skRRAuWzpvhyp/uhJX8w=;
 b=RnCZ5UpRcthovjAiH7zyLdYkB6U7WVBEryaTMNAbjGG88Rhz1qEAnQQj6nj17Tc1pdmsjm
 /jSMquJKgG5e1hCg3O75xG4HygHZ8JfmWLJFco/TjW5xTRttSsfD5UE6kwLrNPi9W9ebMP
 Y8Du0Ero+FT7Auuo8GVT2cQFZqlkO94=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-ja7wdK4wNHm_vADi5qxZwA-1; Thu,
 17 Sep 2026 05:55:51 -0400
X-MC-Unique: ja7wdK4wNHm_vADi5qxZwA-1
X-Mimecast-MFC-AGG-ID: ja7wdK4wNHm_vADi5qxZwA_1789638950
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34C151828AF0; Thu, 17 Sep 2026 09:55:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56D1430001B9; Thu, 17 Sep 2026 09:55:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB32621E6A04; Thu, 17 Sep 2026 11:55:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: qemu-devel@nongnu.org,  jasowang@redhat.com,  mst@redhat.com
Subject: Re: [PATCH] util/error, hw/net/virtio-net: fix NULL pointer
 dereference in error_vprepend
In-Reply-To: <410859ee-80a6-41f1-8b40-7e5014a6bd10@swemel.ru>
 (=?utf-8?B?ItCd0LjQutC+0LvQsNC5CdCX0L7RgNC40L0iJ3M=?= message of "Wed, 16
 Sep 2026 16:48:19 +0300")
References: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
 <87h5jp8iqc.fsf@pond.sub.org>
 <410859ee-80a6-41f1-8b40-7e5014a6bd10@swemel.ru>
Date: Thu, 17 Sep 2026 11:55:46 +0200
Message-ID: <87o6dw42xp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

=D0=9D=D0=B8=D0=BA=D0=BE=D0=BB=D0=B0=D0=B9 =D0=97=D0=BE=D1=80=D0=B8=D0=BD <=
zorin@swemel.ru> writes:

> Hello!
>
> This is not AI-generated content. We have a dedicated team of engineers w=
ho monitor and analyze security events (ranging from ASan/TSan sanitizers t=
o PVS-Studio) and perform statistical analysis (from cppcheck to SVACE and =
white bear). This is a strict requirement from our Quality Assurance depart=
ment, which is mandatory for compliance with our government and commercial =
contracts. Unfortunately, I cannot share our internal security tools (espec=
ially since they are tailored to our environment and won't work for you). H=
owever, I can share what our engineers flag as potentially dangerous cases =
during their research. Since the patches we submit address long-standing vu=
lnerabilities, we have to maintain them on our side for years, as they rare=
ly get fixed in your upstream. If you think these findings are outdated or =
redundant, fine. I'll try to convince our researchers to drop it=E2=80=94le=
tting them know that the upstream developers consider this work completely =
unnecessary.
>
> P.S. We are backporting these from Debian 10 (even though the current rel=
ease is Debian 13).
> P.P.S. I used AI for correcting translate (I not good knowled english)
>
> nice day

When I smell AI, I ask.  This isn't me judging the patch submitter.
It's simply my duty as a maintainer to make a reasonable effort to
ensure patch submitters know what they're doing.

According to the commit message, your patch is about three separate
issues:

1. error_vprepend() crashes when misused

   Yes it does, and that's deliberate.  If you can see a away to get it
   to crash, there's a bug in need of fixing further up the call chain.
   We'd appreciate a patch then.  Alternatively, a reproducer and/or
   stack backtrace, or even static analysis.

2. vhost_user_net_save_state() and vhost_user_net_load_state() misuse
   error_reportf_err()

   They do.  Have you searched for additional instances of this bug?
   Question, not a demand!

3. A cosmetic issue in an error message nearby.

   Yup, there's a double space.  You could go the extra mile and search
   for additional instances.  Again, not a demand.

We prefer one patch per issue, although nearby trivial cleanups can
sometimes be thrown in.  Doing 3 together with 2 is fine.


