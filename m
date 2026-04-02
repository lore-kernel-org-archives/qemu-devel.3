Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCC0CC6B01
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Aae-00067m-95; Thu, 02 Apr 2026 01:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w8Aac-000650-Ki
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w8Aaa-0003Qt-7J
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775107650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hzJJJPWuO1xNvmFJ4D5drzTJ6kgRdHItv4niYy6sz4=;
 b=FylvGpd9k/aG1NUyzQv20NphYJMquWf1T8JCMc/VT5K375mgsQM/bHBy2f0kN8fHwk3fbu
 MPOlwJ5nhPWfzGRduURlo651OZNw0i/6mcmwNl23kD/8/FYw+hnvdTzDcoqa+hImyBpcqd
 rSo/dyFRjrv1fNLrY9yCceGQkdyWnTU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-JBqIzqMiOE-UHMLmu9eRag-1; Thu,
 02 Apr 2026 01:27:28 -0400
X-MC-Unique: JBqIzqMiOE-UHMLmu9eRag-1
X-Mimecast-MFC-AGG-ID: JBqIzqMiOE-UHMLmu9eRag_1775107647
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ABE819560B4; Thu,  2 Apr 2026 05:27:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9127B30001A2; Thu,  2 Apr 2026 05:27:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B614821E6A28; Thu, 02 Apr 2026 07:27:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?5pmP6b6Z6b6Z?= <yanlonglong@kylinos.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  John Snow <jsnow@redhat.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06?= Re: =?utf-8?B?5Zue5aSNOg==?=
 Re: [PATCH] hw/ide: resolve core crash caused
 by optical drive pop-up during virtual machine startup
In-Reply-To: <2t5ely5d6lr9-2t5ka4g42q3q@nsmail8.2--kylin--1>
 (=?utf-8?B?IuaZj+m+mem+mSIncw==?=
 message of "Thu, 02 Apr 2026 09:17:30 +0800")
References: <2t5ely5d6lr9-2t5ka4g42q3q@nsmail8.2--kylin--1>
Date: Thu, 02 Apr 2026 07:27:23 +0200
Message-ID: <87v7eavsn8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

=E6=99=8F=E9=BE=99=E9=BE=99 <yanlonglong@kylinos.cn> writes:

> hi Maintainers :
>
> Do you have any further questions?  I encountered this issue in a product=
ion environment,
> and resolving it in the repository resolved the problem =EF=BC=9BIf you d=
o not agree,  or may be
> change to :
>
> assert(blk_is_available(s->blk));

I'm not the maintainer, I'm just trying to help.  You're not making it
easy, to be frank.

We don't apply patches just because they make a crash go away.  We need
to understand both the bug and the patch.

Working backwards from just the patch to an understanding of the bug is
not practical.  That's why I asked you for a reproducer and/or detailed
analysis of the bug.  Your reply:

    This bug occurs in VDI environments: When a virtual machine boots
    up, the appearance of a CD drive may trigger a core crash. This
    issue has been observed in our internal production environment, and
    our internal testers have already conducted regression testing. You
    may implement this method for testing purposes

This gives us precious little to work with.

What kind of virtual machine?  How do you make a CD drive appear?  Does
it crash always or only sometimes then?  If sometimes, how often?  Stack
backtrace of the crash?  What did your regression testing find, if
anything?  I could go on.  I believe you're sitting on a wealth of
information.  You can't expect us to spend our limited time to
rediscover what you already have, can you?


