Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C139CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6a1-0008WG-0L; Thu, 04 Jun 2026 07:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV6Zx-0008QF-QR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:49:42 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV6Zr-0006fG-Rj
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780573762; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=awJP1iJv8hxAOuTYj8GogTC9LiqZOzIlh/dNK3rXvCU=;
 b=dgw2dvu1ZX2mDbW1YoP6Uz+PV/7YbuC00XBtzPYwr+hy2ylaJ2lZ7iA7u8qqd5UUYGsiVJDbQ2jGckYrzQIPYsVaLuVP+Tpw0eegq4ArKfj4O6z3M3vk6LCQUgtW+KZxgooIAI73SojjqHbtxZTBGM6Cr+tBiKPp9BPyffZSLFc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R681e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0X4AA0e._1780573760; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X4AA0e._1780573760 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 04 Jun 2026 19:49:21 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] io/channel-socket: move cmsg memset into fd-passing
 branches
Date: Thu,  4 Jun 2026 19:49:10 +0800
Message-ID: <20260604114920.74663-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aiE6XZrUOCqJ1wdk@redhat.com>
References: <20260529021324.52124-1-guobin@linux.alibaba.com>
 <aiE6XZrUOCqJ1wdk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

On Wed, Jun 04, 2026 at 08:42:xx +0000, Daniel P. Berrangé wrote:
> QEMU builds with -ftrivial-auto-var-init=zero always set so this
> control variable will always be zero-initialized by the compiler
> making the following memset() pointless/redundant.

You're right, I missed the -ftrivial-auto-var-init=zero flag in
meson.build.  The memset() is indeed redundant and the performance
rationale in the patch description doesn't hold.

I'll drop this patch.

Thanks for the review.

Bin Guo

