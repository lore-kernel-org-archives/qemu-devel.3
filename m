Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E220C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sex56-0007iF-EQ; Fri, 16 Aug 2024 09:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sex52-0007gm-As
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:33:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sex50-0000xO-6r
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:33:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428163f7635so15661985e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723815200; x=1724420000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QrtOZIjmVH3biFn3NBGJOVqrNEwQZIehQby9RM852o4=;
 b=LG+qyo/ux8JMpXEFYLYnmZsfHOJs5x72jFtZNTaUHVLzsSYmayVoUaMqpE4fW4TC9b
 ZE+FjIiWVphboCB/W1Pzj5Pr4pYt9sWc21yb60LDt1ecK2tSDfQAfdBKjHyrKwYTqTcX
 iZXJkHfwUnwfeBT9T0WvYfLloqsLPcqkpKXTRJ6XuH23UrD09LI1xo4OXBJvEK7fyo83
 EyKtomg5yQF5Qf1cqyMZ/1whOSA15N2EPOlellooEQyEDdaW20+ThL576MDe79RTM8YA
 e2SjtDaq3ZCl8T8dMbQ8uQICaAigFGv35REtpkZXMfUo+BK90V0ijc0DV+WiSVdtoUGg
 CIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723815200; x=1724420000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrtOZIjmVH3biFn3NBGJOVqrNEwQZIehQby9RM852o4=;
 b=Syf8PNUrUlf7u6AjR20LyPBCSGK5+0aQPW5yEbECrxAciGg/DKv8HmqN/uD5k8AzV1
 zxeqdykvcGFgImYfv5q5vK0onIngiNgEEzucjtDXma0vhsC08x7/nzoNfscqObhSCT8b
 nKw7TnX8t7kP/MMuH06uqwFkS8px1l56hzdcQy8LrZnJIFEt14JF2qiPJsB/HsrXPvsd
 vjJf5w06kid6MZ14s3po23K41Lktq97+Q5P1+p/AqSG+Qg6q+/HGAzxvPnFvBK5DmhW7
 L63DueRZ78f/p0meBBkhL6x2II9iqFNtGrswUX9c6PwxAuAlqp9ws9P2wKKUA1fzNa1+
 mr/A==
X-Gm-Message-State: AOJu0Yzq0GCxLqsrYGUwU3phMZwnk5pbE1CzA1UYG8he5fZ3DGrMoIKC
 FdSvb3DpM9BGemwu7/52G11pkTOB0759+x0HyhO7QW769KxXetGvhTGWbpNJFCSdwrVTC6s1gas
 f
X-Google-Smtp-Source: AGHT+IEHR2GdlLPZLIUIRe2kSgCdaBbHxER5w/yXx9Aqa6p/MIxnXTqtW9csGSWWsxKD9oKnQuXGyg==
X-Received: by 2002:adf:ef8a:0:b0:368:4c54:ae27 with SMTP id
 ffacd0b85a97d-371946573a6mr1915523f8f.36.1723815199976; 
 Fri, 16 Aug 2024 06:33:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718989708esm3718279f8f.70.2024.08.16.06.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:33:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH for-9.2] docs/devel: Remove nested-papr.txt
Date: Fri, 16 Aug 2024 14:33:18 +0100
Message-Id: <20240816133318.3603114-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

docs/devel/nested-papr.txt is entirely (apart from the initial
paragraph) a partial copy of the kernel documentation
https://docs.kernel.org/arch/powerpc/kvm-nested.html

There's no benefit to the QEMU docs to converting this to rST,
so instead delete it. Anybody needing to know the API and
protocol for the guest to communicate with the hypervisor
to created nested VMs should refer to the authoratitative
documentation in the kernel docs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm going through converting .txt documents (which end users
will basically never see) to rST format (which appears in our
HTML manuals). For this file, though, since almost all the
contents are just a copy of an authoritative source that
lives elsewhere, it didn't seem to me worth keeping it.

Perhaps the cap-nested-papr machine property should be
documented in docs/system/ppc/pseries.rst, but that is
a pre-existing omission: would somebody who knows more
about the pseries machine than I do like to propose a
docs tweak there?
---
 docs/devel/nested-papr.txt | 119 -------------------------------------
 1 file changed, 119 deletions(-)
 delete mode 100644 docs/devel/nested-papr.txt

diff --git a/docs/devel/nested-papr.txt b/docs/devel/nested-papr.txt
deleted file mode 100644
index 90943650db9..00000000000
--- a/docs/devel/nested-papr.txt
+++ /dev/null
@@ -1,119 +0,0 @@
-Nested PAPR API (aka KVM on PowerVM)
-====================================
-
-This API aims at providing support to enable nested virtualization with
-KVM on PowerVM. While the existing support for nested KVM on PowerNV was
-introduced with cap-nested-hv option, however, with a slight design change,
-to enable this on papr/pseries, a new cap-nested-papr option is added. eg:
-
-  qemu-system-ppc64 -cpu POWER10 -machine pseries,cap-nested-papr=true ...
-
-Work by:
-    Michael Neuling <mikey@neuling.org>
-    Vaibhav Jain <vaibhav@linux.ibm.com>
-    Jordan Niethe <jniethe5@gmail.com>
-    Harsh Prateek Bora <harshpb@linux.ibm.com>
-    Shivaprasad G Bhat <sbhat@linux.ibm.com>
-    Kautuk Consul <kconsul@linux.vnet.ibm.com>
-
-Below taken from the kernel documentation:
-
-Introduction
-============
-
-This document explains how a guest operating system can act as a
-hypervisor and run nested guests through the use of hypercalls, if the
-hypervisor has implemented them. The terms L0, L1, and L2 are used to
-refer to different software entities. L0 is the hypervisor mode entity
-that would normally be called the "host" or "hypervisor". L1 is a
-guest virtual machine that is directly run under L0 and is initiated
-and controlled by L0. L2 is a guest virtual machine that is initiated
-and controlled by L1 acting as a hypervisor. A significant design change
-wrt existing API is that now the entire L2 state is maintained within L0.
-
-Existing Nested-HV API
-======================
-
-Linux/KVM has had support for Nesting as an L0 or L1 since 2018
-
-The L0 code was added::
-
-   commit 8e3f5fc1045dc49fd175b978c5457f5f51e7a2ce
-   Author: Paul Mackerras <paulus@ozlabs.org>
-   Date:   Mon Oct 8 16:31:03 2018 +1100
-   KVM: PPC: Book3S HV: Framework and hcall stubs for nested virtualization
-
-The L1 code was added::
-
-   commit 360cae313702cdd0b90f82c261a8302fecef030a
-   Author: Paul Mackerras <paulus@ozlabs.org>
-   Date:   Mon Oct 8 16:31:04 2018 +1100
-   KVM: PPC: Book3S HV: Nested guest entry via hypercall
-
-This API works primarily using a signal hcall h_enter_nested(). This
-call made by the L1 to tell the L0 to start an L2 vCPU with the given
-state. The L0 then starts this L2 and runs until an L2 exit condition
-is reached. Once the L2 exits, the state of the L2 is given back to
-the L1 by the L0. The full L2 vCPU state is always transferred from
-and to L1 when the L2 is run. The L0 doesn't keep any state on the L2
-vCPU (except in the short sequence in the L0 on L1 -> L2 entry and L2
--> L1 exit).
-
-The only state kept by the L0 is the partition table. The L1 registers
-it's partition table using the h_set_partition_table() hcall. All
-other state held by the L0 about the L2s is cached state (such as
-shadow page tables).
-
-The L1 may run any L2 or vCPU without first informing the L0. It
-simply starts the vCPU using h_enter_nested(). The creation of L2s and
-vCPUs is done implicitly whenever h_enter_nested() is called.
-
-In this document, we call this existing API the v1 API.
-
-New PAPR API
-===============
-
-The new PAPR API changes from the v1 API such that the creating L2 and
-associated vCPUs is explicit. In this document, we call this the v2
-API.
-
-h_enter_nested() is replaced with H_GUEST_VCPU_RUN().  Before this can
-be called the L1 must explicitly create the L2 using h_guest_create()
-and any associated vCPUs() created with h_guest_create_vCPU(). Getting
-and setting vCPU state can also be performed using h_guest_{g|s}et
-hcall.
-
-The basic execution flow is for an L1 to create an L2, run it, and
-delete it is:
-
-- L1 and L0 negotiate capabilities with H_GUEST_{G,S}ET_CAPABILITIES()
-  (normally at L1 boot time).
-
-- L1 requests the L0 to create an L2 with H_GUEST_CREATE() and receives a token
-
-- L1 requests the L0 to create an L2 vCPU with H_GUEST_CREATE_VCPU()
-
-- L1 and L0 communicate the vCPU state using the H_GUEST_{G,S}ET() hcall
-
-- L1 requests the L0 to run the vCPU using H_GUEST_RUN_VCPU() hcall
-
-- L1 deletes L2 with H_GUEST_DELETE()
-
-For more details, please refer:
-
-[1] Linux Kernel documentation (upstream documentation commit):
-
-commit 476652297f94a2e5e5ef29e734b0da37ade94110
-Author: Michael Neuling <mikey@neuling.org>
-Date:   Thu Sep 14 13:06:00 2023 +1000
-
-    docs: powerpc: Document nested KVM on POWER
-
-    Document support for nested KVM on POWER using the existing API as well
-    as the new PAPR API. This includes the new HCALL interface and how it
-    used by KVM.
-
-    Signed-off-by: Michael Neuling <mikey@neuling.org>
-    Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
-    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
-    Link: https://msgid.link/20230914030600.16993-12-jniethe5@gmail.com
-- 
2.34.1


