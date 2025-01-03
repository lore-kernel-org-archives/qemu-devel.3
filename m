Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E4AE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 08:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTdMa-0002cP-6t; Fri, 03 Jan 2025 03:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMM-0002a9-KU
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:55 -0500
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1tTdMK-0007dx-3M
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 03:48:46 -0500
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5038mSAe1820053
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Fri, 3 Jan 2025 00:48:32 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5038mSAe1820053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024121701; t=1735894112;
 bh=v9t1vPUsMjv2QDMvofWwMGRgvrdfi8yOuOAIZ7ajsoo=;
 h=From:To:Cc:Subject:Date:From;
 b=kK9K1f7nu8ykl1MG3bxgCMB+kxXN6Cnj3/GYg9QTYw9wg098c9OVtGuLvmuiE3kJX
 NMIk1aF9xRuuceVlbaAifCnDEkOjDTFmY/HlJz0RQ6Awy59JGB3XHUdFxqGTQ8RPdZ
 0Cge0QPQfRcsuu0boN96iWVqDs2UxL4fcKANx7akkn9WssYwG7dqujM19U7IvnqVnP
 OO5/o6i/cvfVTNvCVHrQ08INOKAzfDo5iwHbZDvjVU5NHsJqQgbjmMSFMh4G6qZOQn
 GImmD8gfZX4ODbbsS7ZjFS9k8L/f68xrVXv8Ogbl4wsGUbHvVSJ472rT8DAKKZeCI0
 xra3ulp/nrZ7w==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xin3.li@intel.com
Subject: [PATCH v1 0/3] target/i386: Add the immediate form MSR access
 instruction support
Date: Fri,  3 Jan 2025 00:48:24 -0800
Message-ID: <20250103084827.1820007-1-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The immediate form of MSR access instructions are primarily motivated by
performance, not code size: by having the MSR number in an immediate, it
is available *much* earlier in the pipeline, which allows the hardware
much more leeway about how a particular MSR is handled.

This new CPU feature is advertised through bit 5 of CPUID.7.1.ECX, which
needs to be added as a new CPU feature word.

WRMSRNS doesn't become a required feature for FERD, and Linux has removed
the dependency, as such remove the dependency from Qemu.


Xin Li (Intel) (3):
  target/i386: Remove FRED dependency on WRMSRNS
  target/i386: Add a new CPU feature word for CPUID.7.1.ECX
  target/i386: Add the immediate form MSR access instruction support

 target/i386/cpu.c | 27 ++++++++++++++++++++++-----
 target/i386/cpu.h |  4 ++++
 2 files changed, 26 insertions(+), 5 deletions(-)


base-commit: 1ada452efc7d8f8bf42cd5e8a2af1b4ac9167a1f
-- 
2.47.1


