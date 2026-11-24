Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3C606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=Jc6pD2WC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVmBh-0005fl-9G; Tue, 24 Nov 2026 03:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVmBf-0005fb-CN
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 03:47:39 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVmBc-0008Jq-Tg
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 03:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795510046; bh=6L8Ceo6aDnvq7yIJs8gSH7Lx0W7DzpylhsMcs7QxgzY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Jc6pD2WCS6VTO0SrRcPfoN4rqD44NbpXfQyCXeWTDipaFrWoy76/2XTT4ctiIyaym
 Z9RYO9B2PveyIpbHuWxXyV9/MyjFYFvVAHxfPxNlLaVkLijZI0tQ2R3Qo899r/E1ft
 9W4Vm2qBunt5VJbIXXtRr0YAZI9qSvJvLBq//3uk=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id AD87F203B0;
 Tue, 24 Nov 2026 09:47:26 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E7F4821E6A04; Tue, 24 Nov 2026 09:47:34 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V20 00/14] iothread: Support tracking and querying
 IOThread holder
In-Reply-To: <CAK3tnv+rQ+fKF1UPGj7+RLt81PyULojVT6TG3pjbma3Fffr1dw@mail.gmail.com>
 (Zhang Chen's message of "Tue, 24 Nov 2026 14:09:37 +0800")
References: <20261113092605.942292-1-zhangckid@gmail.com>
 <CAK3tnv+rQ+fKF1UPGj7+RLt81PyULojVT6TG3pjbma3Fffr1dw@mail.gmail.com>
Date: Tue, 24 Nov 2026 09:47:34 +0100
Message-ID: <87ik1mhazd.fsf@pond.sub.org>
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

Zhang Chen <zhangckid@gmail.com> writes:

> Hi Stefan and Markus,
>
> A gentle ping on v20. All 14 patches have Reviewed-by tags, and I
> checked that the series still applies cleanly to master (2bfbe39d0f).
>
> Thanks
> Chen

I have no objections to merging this for 12.0 once we're out of freeze.

Stefan, would you like to take care of it?

