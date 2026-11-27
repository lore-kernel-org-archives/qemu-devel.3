Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D5606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=oPl4i8q/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWsk5-0001YP-9T; Fri, 27 Nov 2026 04:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWsk3-0001XY-W9
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:59:44 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWsk2-00019r-Dt
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795773571; bh=E1+I9Pv0uh6fOz6I2lkLhywBpZ46AdYcqTYsP6cAtU0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=oPl4i8q/Amxuq6jlJHVTALF8yOs1PXGUrjMSxWExniOIy8VaX8tRFIN6zmgi2mdEJ
 reVNF9L3mqxewUgc4W+b2QTTdYEn1qFmWrRohMwBzGl2GlIJiVhHfE/pSUtkQctWzR
 P8ngDH5CNgG4trlvFaJwIZbc8dBJpjtrCv2qQ5xc=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 42F9520E22
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 10:59:31 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2D7A21E6A04; Fri, 27 Nov 2026 10:59:40 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,  eblake@redhat.com,  stefanha@redhat.com,  Peter
 Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH] file-posix: Fix loss of QAPI feature
 'dynamic-auto-read-only'
In-Reply-To: <20261124152218.2562390-1-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 24 Nov 2026 16:22:18 +0100")
References: <20261124152218.2562390-1-armbru@redhat.com>
Date: Fri, 27 Nov 2026 10:59:40 +0100
Message-ID: <87se0mtx0z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Markus Armbruster <armbru@redhat.com> writes:

> Recent commit 691094b7091b added a variant member to BlockdevOptions
> branch 'host-device' by changing the branch type to new struct type
> BlockdevOptionsHostDevice that has the old branch type
> BlockdevOptionsFile as base.  This is a perfectly reasonable thing to
> do.  However, since a type only inherits its base's members, and not
> its features or conditions, this lost BlockdevOptionsFile's feature
> 'dynamic-auto-read-only'.
>
> Considering we are in deep freeze, fix the regression the stupidest
> and safest way possible: copy the feature from BlockdevOptionsFile to
> BlockdevOptionsHostDevice.
>
> Reported-by: Peter Krempa <pkrempa@redhat.com>
> Fixes: 691094b7091b ("file-posix: Add 'accept-read-only-device' option")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued for 11.2.

