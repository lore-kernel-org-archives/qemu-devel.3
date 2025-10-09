Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A44DCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRO-0000F1-Vy; Thu, 09 Oct 2025 03:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRN-0000EX-5O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRA-0004UF-ND
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enfkQAB8afdi5HCkMd+8fUqs4ubojxDRXj46eZbewuM=;
 b=P+eEIIPkvjoQhHeogfyysZgxCiZmxrlCLBg9xH6MrMP32X4XjOEbhqXagZFJXKiAIyQtam
 wQL+Qkgpwkg7d14pUh0hYtxcPQiPEhjRKQ6/RjRFoA9WONk94Qb95sNoBQsY7fY5dmetLI
 ySkGSmLSFVL2sE2TCRBTEDseDAdxT/c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-WCy23cOUOTyf5dmPWK1_Pw-1; Thu, 09 Oct 2025 03:51:42 -0400
X-MC-Unique: WCy23cOUOTyf5dmPWK1_Pw-1
X-Mimecast-MFC-AGG-ID: WCy23cOUOTyf5dmPWK1_Pw_1759996301
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e44b9779eso2992405e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996299; x=1760601099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enfkQAB8afdi5HCkMd+8fUqs4ubojxDRXj46eZbewuM=;
 b=wwTO8RFqCYYRgB1N+GYXn86sre3xBK8YRdB+tWOukxdjkT7TmZGO2OOq7uvkfFS7cS
 JJY8ezglojEezeFMGUYhy3aFJhK3/2Fm9lg9Ds5dRvplckdyTjdUKaS2cbGduKGNEPR8
 53adoivGekXqVlW/wzXU92gYp2pMIqeRLb7MkVDiBWmVM7ynDG6G/Jb0y6lle44pXOyd
 3hiktENA1umcBy4cDq8hrBIMFt+F/o63dxuhLEz9mR8PznFiI+rCjjY6K8AVT82yFJ9S
 Y3xPQTDlSNr076I2PgSle0lWPYCQhTbQltuo0q0UuTx2kx4qwD+IMkN+vpQVSdJTneIh
 tQLg==
X-Gm-Message-State: AOJu0YwouEq2wENQ+8oIbs7xrTRjq4qfyLWiiZMFnqTwMb0Iln66eTgz
 w4avKzXPMXRyggewHtvIlu/edLoZ0DUX1+/JO3PK4JEYeU4vZcUwtGCJl2JE1Bd4TX4vc9nTpYW
 CUji0608SN+Y+6OGUekpDzJbOte/RNpdd0k+LaU7LZEn2yxW4ceCUxphDwy2eH4ucG9HJlJPykB
 /do/lql/8QXiRm31loHSEx1vXWmR1KD2ICficWFXNwCUc=
X-Gm-Gg: ASbGncuNleDgXnkXtO8wOTzwx3cb/pXs0N6rZ5xFLUpBv+ih81WMQ2kLjI3h5WwrXKI
 FQdoOGqQAVe5mHoNNLrWwMiPgxwqE0KtRkCz/nupbGxD54YnzVud37jbwPCT6c5lbtfKgtbashL
 fcPgYg2lUpVGROXlNC+1O5PYd8PBfjrL29B2OclQ+iVDq6z0zCjFt5PAYY6CEsqw50yIG8/+MtL
 aPlzRC3zAG+TpjRtqDyhKyK5L2WlZFud03YjIn3hH9m1R6nSEJI+ZGeZ8Z694O4nFMQezvcV9cO
 i59LSpUUEILmvyR9gp6UlFo485Pi0jgy4AC3bfs5LycsK/I/dpa9TvVYJA0tyeL/bDD1U9ZLBw6
 PMAjRM9FGaz8HVyRvibltLjKu28mY1g4T4uY6/s8Q0Q0qgNCd
X-Received: by 2002:a05:600c:350b:b0:46e:6603:2ab0 with SMTP id
 5b1f17b1804b1-46fa9aeff11mr49207175e9.24.1759996299524; 
 Thu, 09 Oct 2025 00:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5NFNS7fTmrtKuMLaFbOaFqaWRkR64tkdDlWsWyHf+EX4GYm+0O095HCTakqMF2G1+M7x9Sw==
X-Received: by 2002:a05:600c:350b:b0:46e:6603:2ab0 with SMTP id
 5b1f17b1804b1-46fa9aeff11mr49206885e9.24.1759996299039; 
 Thu, 09 Oct 2025 00:51:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf112fdbsm34023845e9.8.2025.10.09.00.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 32/35] docs: Add mshv to documentation
Date: Thu,  9 Oct 2025 09:50:22 +0200
Message-ID: <20251009075026.505715-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Added mshv to the list of accelerators in doc text.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-27-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst |  2 +-
 docs/devel/codebase.rst        |  2 +-
 docs/glossary.rst              |  7 +++----
 docs/system/introduction.rst   |  3 +++
 qemu-options.hx                | 16 ++++++++--------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 798cb4631df..fc2743658d4 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -53,7 +53,7 @@ Those hosts are officially supported, with various accelerators:
    * - SPARC
      - tcg
    * - x86
-     - hvf (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
+     - hvf (64 bit only), mshv (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
 
 Other host architectures are not supported. It is possible to build QEMU system
 emulation on an unsupported host architecture using the configure
diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 2a3143787a6..69d88271178 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -48,7 +48,7 @@ yet, so sometimes the source code is all you have.
 * `accel <https://gitlab.com/qemu-project/qemu/-/tree/master/accel>`_:
   Infrastructure and architecture agnostic code related to the various
   `accelerators <Accelerators>` supported by QEMU
-  (TCG, KVM, hvf, whpx, xen, nvmm).
+  (TCG, KVM, hvf, whpx, xen, nvmm, mshv).
   Contains interfaces for operations that will be implemented per
   `target <https://gitlab.com/qemu-project/qemu/-/tree/master/target>`_.
 * `audio <https://gitlab.com/qemu-project/qemu/-/tree/master/audio>`_:
diff --git a/docs/glossary.rst b/docs/glossary.rst
index 4fa044bfb6e..2857731bc44 100644
--- a/docs/glossary.rst
+++ b/docs/glossary.rst
@@ -12,7 +12,7 @@ Accelerator
 
 A specific API used to accelerate execution of guest instructions. It can be
 hardware-based, through a virtualization API provided by the host OS (kvm, hvf,
-whpx, ...), or software-based (tcg). See this description of `supported
+whpx, mshv, ...), or software-based (tcg). See this description of `supported
 accelerators<Accelerators>`.
 
 Board
@@ -101,9 +101,8 @@ manage a virtual machine. QEMU is a virtualizer, that interacts with various
 hypervisors.
 
 In the context of QEMU, an hypervisor is an API, provided by the Host OS,
-allowing to execute virtual machines. Linux implementation is KVM (and supports
-Xen as well). For MacOS, it's HVF. Windows defines WHPX. And NetBSD provides
-NVMM.
+allowing to execute virtual machines.  Linux provides a choice of KVM, Xen
+or MSHV; MacOS provides HVF; Windows provides WHPX; NetBSD provides NVMM.
 
 .. _machine:
 
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 4cd46b5b8f9..9c57523b6c2 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -23,6 +23,9 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
   * - Xen
     - Linux (as dom0)
     - Arm, x86
+  * - MSHV
+    - Linux (as dom0)
+    - x86
   * - Hypervisor Framework (hvf)
     - MacOS
     - x86 (64 bit only), Arm (64 bit only)
diff --git a/qemu-options.hx b/qemu-options.hx
index 075f4be2e3e..56db4bf9e5e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -28,7 +28,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hvf, nvmm, whpx or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hvf, nvmm, whpx, mshv or tcg (default: tcg)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
@@ -66,10 +66,10 @@ SRST
 
     ``accel=accels1[:accels2[:...]]``
         This is used to enable an accelerator. Depending on the target
-        architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available.
-        By default, tcg is used. If there is more than one accelerator
-        specified, the next one is used if the previous one fails to
-        initialize.
+        architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be
+        available. By default, tcg is used. If there is more than one
+        accelerator specified, the next one is used if the previous one
+        fails to initialize.
 
     ``vmport=on|off|auto``
         Enables emulation of VMWare IO port, for vmmouse etc. auto says
@@ -226,7 +226,7 @@ ERST
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
-    "                select accelerator (kvm, xen, hvf, nvmm, whpx or tcg; use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hvf, nvmm, whpx, mshv or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
@@ -241,8 +241,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
 SRST
 ``-accel name[,prop=value[,...]]``
     This is used to enable an accelerator. Depending on the target
-    architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available. By
-    default, tcg is used. If there is more than one accelerator
+    architecture, kvm, xen, hvf, nvmm, whpx, mshv or tcg can be available.
+    By default, tcg is used. If there is more than one accelerator
     specified, the next one is used if the previous one fails to
     initialize.
 
-- 
2.51.0


