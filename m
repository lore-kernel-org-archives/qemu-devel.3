Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4865606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=Mbp7JmKD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWskn-0002Mt-Rq; Fri, 27 Nov 2026 05:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWskU-0002DL-HI
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:00:10 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xWskS-0002q2-Tx
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795773597; bh=yH9VCzmGlhG0D95O4xyeKIJOssWCiMgR4xIo6emGLm4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Mbp7JmKDfubzpkSNj87BxbkseRzllCBXtkWaQCIiuy+gAF4axsWXNGSmABVrsCGL2
 ticm8nuDqoEChCWDW8BFp4Vw7VD4XEF3cGCxbOMm1YHiDqT3UcsBtc2DWmezI0q6JV
 EOC2TYhMBas0OLsOkVIBF66YNXdCj1b/v50WIqrg=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 9D4DF20E22
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 10:59:57 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F6D021E6A04; Fri, 27 Nov 2026 11:00:07 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: qemu-devel@nongnu.org
Cc: anisinha@redhat.com,  berrange@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH 0/1] qom: Really add 'confidential-guest-reset' feature
In-Reply-To: <20261124154310.2569390-1-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 24 Nov 2026 16:43:09 +0100")
References: <20261124154310.2569390-1-armbru@redhat.com>
Date: Fri, 27 Nov 2026 11:00:07 +0100
Message-ID: <87o6batx08.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Markus Armbruster <armbru@redhat.com> writes:

> Feature 'confidential-guest-reset' was added two releases ago broken.
> Nobody noticed so far.  My patch fixes it, but I wonder whether we
> should just drop the feature entirely.
>
> Either way, is it worth doing for 11.2?  I'm leaning towards yes.
>
> Opinions?

Queued for 11.2.

