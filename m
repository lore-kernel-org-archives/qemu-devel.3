Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0673FC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 11:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpoCM-0001M0-PT; Thu, 28 Mar 2024 07:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rpoCA-0001F2-37
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:45:22 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rpoC8-0003BD-6P
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 07:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=2bubmrvspE2aFcM8ILSkBeZg0NZ7Q0IvPI2c2ThzZIc=; b=sABqrCVKkdc8IBE
 F1ys/enmZ0S7uxIhCC3J5dv9tzgVDdKxZBHxqJcUXOdehBn0Ej9b+O6AbHjfvuQK+XUTR0ekj41rs
 FMG4syBsIF3Q1FFgSZoU9okWp3LpBzZJfULQ7+hzBbjj43Wso3dGHbtG1KqOHCEbIZ4GT5T7nqxjV
 Bg=;
Date: Thu, 28 Mar 2024 12:44:58 +0100
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: Ideas on dealing with mttcg_enabled/use_icount globals
Message-ID: <sjm4vf6arqcb5grgeudw2pgvbrgoowdz36dtliz5a5jvtxrk4q@nsx2vufs7k6b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Phil,

I've been staring myself blind trying to deal with
qemu_tcg_mttcg_enabled()/icount_enabled() and I'm wondering if you have
an ideas.

I'm leaning towards moving these globals to some TCG accelerator
specific state (TCGState?) that's initialized once we know how many/what
cpus are in the system. The problem is then making sure all uses have 
access to this state.

For qemu_tcg_mttcg_enabled() there is one trickier use in
tcg_region_init(). We probably need to delay the initialization of the
tcg region until we know the cpus in the system, this is getting close 
to the configuration/initialization order issues we've discussed 
previously so I'm not sure how easy this would be.

As for icount_enabled(), I'm not entirely sure yet, its uses are a lot 
more scattered throughout the codebase and I'm still going through them.

Cheers,
-- 
Anton Johansson
rev.ng Labs Srl.

