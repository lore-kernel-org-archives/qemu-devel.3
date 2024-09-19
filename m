Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A96BCDD57B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwo-0006TR-J0; Thu, 19 Sep 2024 09:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwY-0005bm-UJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwW-000169-BB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so7860475e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751490; x=1727356290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GJ3T7V06j5SeC8WLjBRAZGv39MO7ps0i73GVtRbGI+U=;
 b=h2R7AAGt42/tO3Vq7oQnLZ5umhwO5nIbrVm7PYQAUYPNJIfnwhGZJcxFY32xq7UfSA
 xIFnAgaB86fbQgBcv7p9omdnx3KLn/v4DfyQf2tr++8166fYGkWrJ+DoZnBITJpvfkTu
 bEALHBaWOiPRhS2wjIHGjOz7P8LLW7DImrIde/lW3aS9AukSXlkmQow7nl3bdvZCbqzb
 rpYs2fAz/1jKFO3MnF8OlvFhnOfcgN67dgidYBu3TH0yEd5C4ytfzQxL/MO+ptAYY3Am
 O2uNA8oi+2OUTOEtyx+CmrRmH+9nSqbjAcrz3xuJ2r4uI8/gHFhsvbTX+oRtJEtoWtZ2
 ZE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751490; x=1727356290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJ3T7V06j5SeC8WLjBRAZGv39MO7ps0i73GVtRbGI+U=;
 b=f2ycUfYo0nBJhBcLqKqk0yTcFvymXDFYvpZxdPaWlUFiIzHT55u66NJwhAwvvWw8iq
 fPO1Rv1e4gdRe400DqmJpkVmfmVexpuLkZimH2c5WqYetddRRavZHNjWkXhyh2kijdSP
 +DNY56uuWqAmu/kJJ3zisIjI1anDuCo1r99gooIJnZL59BznGufNRg57T02bUdgtDGWG
 1wj4a4Q+HEoNFzntJf7dq0b7AjFhdmvirYztmqpFcTCh+jVGkkPpb4163l6gv8ohzcsN
 oae3fsA3Ftr3vk939hAvZ5oNFiPyihFbiGtaDBgak1IzW8bNvoT8qM5IEZ3GZMnlYaTn
 k5LA==
X-Gm-Message-State: AOJu0Yx2n4QrDpSjTDitxdIlJfhee942ryM70/3Pz0Otsd7qh53eUHsn
 sjDl30Dcsu6NBe/dZl1Ouu/rH/bS4fufIuVdv9ZOyrEHcNzCMxepy5yZFGhQC/yICkgB/9hBtcc
 4
X-Google-Smtp-Source: AGHT+IG9fNNU3svTMXjspO4yglnsMyjg177coSysAKvBvXsEbbTb3coZp0v6wz1YvTHSe6EPgQ+7cg==
X-Received: by 2002:a05:600c:4fc2:b0:42c:af2a:dcf4 with SMTP id
 5b1f17b1804b1-42cdb56ae3dmr160130205e9.27.1726751490007; 
 Thu, 19 Sep 2024 06:11:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/38] docs/devel: Remove nested-papr.txt
Date: Thu, 19 Sep 2024 14:11:06 +0100
Message-Id: <20240919131106.3362543-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

docs/devel/nested-papr.txt is entirely (apart from the initial
paragraph) a partial copy of the kernel documentation
https://docs.kernel.org/arch/powerpc/kvm-nested.html

There's no benefit to the QEMU docs to converting this to rST,
so instead delete it. Anybody needing to know the API and
protocol for the guest to communicate with the hypervisor
to created nested VMs should refer to the authoratitative
documentation in the kernel docs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-id: 20240816133318.3603114-1-peter.maydell@linaro.org
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


