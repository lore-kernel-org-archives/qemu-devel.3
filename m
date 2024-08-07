Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EEEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbuX-0000zh-6z; Wed, 07 Aug 2024 04:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbuV-0000tg-G5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:20:43 -0400
Received: from terminus.zytor.com ([198.137.202.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbuT-0007Fr-0a
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:20:43 -0400
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4778IDpe735187
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 7 Aug 2024 01:18:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4778IDpe735187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024071601; t=1723018697;
 bh=QL9mGtdxGEoJ7LmZv1od9L07EiNIKIqpnoWywqqH9bw=;
 h=From:To:Cc:Subject:Date:From;
 b=C/AAeu9QCYaK43aRz2VLFC6crUU+Ckz2OoCa38Amb2ZUK3IOslvSrTuJATRpRgYBm
 3DQwpTkPIKqaXqZuTYpwiiAMSyhnXbZ9z8BOKbkvy82I7pP3hSLSlGWbGHBE5jNcRY
 ZProDFw5ZIdYR2qyW7m6N9jdRzL/TTD/pC0WJ6ESubS26AvA4G2I3r24Hc1B7hYmAB
 QftEo+STd6JTfFQa7KKX1ziScSEJkYmj9WtNzrsjuOBpcRjDR8wzPx4jWq+a97SZzk
 QOD4h5XI2jH1Mrg4NOqyyP3MsemRb0Tb+QgtCXSso1ynt6HBoEDCrkPea6jn8FuT+C
 oGoBwbbWR+NMA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, lei4.wang@intel.com,
 zhao1.liu@intel.com, xin3.li@intel.com
Subject: [PATCH v1 0/3] target/i386: Add nested FRED support
Date: Wed,  7 Aug 2024 01:18:09 -0700
Message-ID: <20240807081813.735158-1-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.137.202.136; envelope-from=xin@zytor.com;
 helo=terminus.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch set adds nested FRED support to allow KVM to run a nested
guest with FRED enabled.


Lei Wang (1):
  target/i386: Raise the highest index value used for any VMCS encoding

Xin Li (Intel) (2):
  target/i386: Delete duplicated macro definition CR4_FRED_MASK
  target/i386: Add VMX control bits for nested FRED support

 target/i386/cpu.c     | 4 ++--
 target/i386/cpu.h     | 7 +------
 target/i386/kvm/kvm.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 9 deletions(-)


base-commit: 6d00c6f982562222adbd0613966285792125abe5
-- 
2.45.2


