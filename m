Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DF2CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGIyf-0001Vq-Ju; Mon, 12 Oct 2026 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGIye-0001VE-48
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:34:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGIyb-0002b8-R5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:34:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so14393925e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791822852; x=1792427652; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m3tuILlDJ7A9cBDe6X5WRWk+S7xXVHPkR7syxJi6tRU=;
 b=T64jFGf6QVoYx15Xk3STpfN7FKnon4XRcCStwBI/YhvpZHaeR1CVJQvN0KsAqith0C
 nynCpwsLYwSY0EeB0vAUfs7OEM5FeU59OynuIseHC0cKHYB7gYwUe+jy9ff1c0Ls8tW7
 YukQ2PkpHrcurBbVCm4bKplIHk7doctd0xMgGri9ypc6+IUay68ubBh/zCa7o/bLDZrt
 5T41Zhz0H+YXMbuE1grGWQQXg3/AFCyTx5APsu2A8FEgUvh/yUMs96GfGjs/O/joKb1A
 YKViDq9+xEW+a+UE4wu6owejCTIYe0k36fP+bTf8+GtnVjHslF97peAyxEPEu8+Heu+u
 XERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791822852; x=1792427652;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m3tuILlDJ7A9cBDe6X5WRWk+S7xXVHPkR7syxJi6tRU=;
 b=bDhmtyjLniIXuZcZJ4XaGFYO38LvIjcFULWd/ZSPWksdTZQUhdqItdOGqokrE3JxRK
 kiJ6Ev0ibH+EUteV2rmLZeCVDSee6ezpkorFmeN5sZ2umtEN+VkdkdHFg8BEYZknH3NC
 l5cowrKApFL6FXVwRXgao7sM4v2S9V8M/4ffn9t6EBZuhN7TWqNMht4OJnAb1MkE5U4Q
 0/MqOIhuzYq0jLvvIqOoS7DaO3XnCOi3Jl8XEiFM1KJrND1ddoW2zTuTu0WxjYJeagsL
 hx63WOzMBTn7Pr7R8ReCaB2xuMc15bkJ0TCrNqhXBb0zavOkdHUvlHiaosV/nXrHlUcv
 eoQA==
X-Gm-Message-State: AFq9FYJnCDB2cpgnvc/fjk3SunBCFHoppMWYzHDFrBjDqoYpQd5754xN
 +ab0oqX0HbR1QsD2P3c+zHjaFP5/0Lu3endNR+TZX9hxnsP0orIwfpek
X-Gm-Gg: AYBFou3GvdeDvwaOvvOapTycu+iEFCs9LJeFRmSdUdzYx/WRHpBfkLgqZq/2BgY5kqa
 wxxBsbAx+Oiw5nQhqnF41BTmce2EEwceaMjMclF7cJ+Uvd29rdIj0ieV0ACifLyw68uMxvX8ae/
 XIGsbHlSodM6X+i7/Vh+5LI7PaeokvFiL6B5l5vHVgDF+9AVA0/Z6Z4e1IynN2oAcyR+VEADTn7
 5tNVUtUhB2pL38Brt9UBmybxIv6zTibBY3MkE5cXy+xw2SbYK9vG48cHMwW4JnCgs85JSUVeQ7L
 jzaaHzfUvHREby3hnLfwKbBsLFiao9h5cIPq1DXjkMw20Ky0kbN+6jcX/7uu1+Qyme4kwMSpshL
 VBvhCmMCBS8QFtu/yykmouN1itmsWloRnQXvnrx3S9d2Gu/SW/bgrV9k/8kjMYO0IQuie5rxkAM
 nqRJSx2IuMtHIbcjv9T5BHoguFRG4XUgHiAI9YU8cvwU7mRw8PWSzz9qctiipdWmKSuJ+GMWmLy
 bvzf3sVa3W76x/YlGKTvz7eO1g=
X-Received: by 2002:a05:600c:524d:b0:4a1:702f:c736 with SMTP id
 5b1f17b1804b1-4a18e446461mr198588435e9.3.1791822851791; 
 Mon, 12 Oct 2026 09:34:11 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2e0dbsm318115155e9.11.2026.10.12.09.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:34:11 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 18:33:20 +0200
Subject: [PATCH TRIVIAL] docs: fix a few typos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-typos-in-docs-v1-1-75f2e1cd888e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwMz3ZLKgvxi3cw83ZT85GJdY7PktJSkpFRToxRjJaCegqLUtMwKsHn
 RSiFBnmGejj5KsRCJ4tKkrNTkEpBpSrW1ALka0Jh6AAAA
X-Change-ID: 20261006-typos-in-docs-36cfdbbe52d3
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc@lmichel.fr>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jason Wang <jasowangio@gmail.com>, Yuri Benditovich <ybendito@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Gautam Menghani <gautam@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org, 
 qemu-trivial@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791822850; l=8624;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=16QmF9OW4eu5qk8bc+ZouDAxDNZ5AImmaRZA0CGJGnc=;
 b=c0muxBsmMvmlYxJRFyBDFgxaAbncnf+WzKxii4i/MpXdFR0NaBV85EY0QDYetJyqCXMtaYQIC
 0Uxw/HB3BsFBnLs24GvN8S8gttmFea6JNvylenGZI41W/dpNnsX2zKQ
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 docs/devel/clocks.rst                 | 2 +-
 docs/devel/control-flow-integrity.rst | 2 +-
 docs/devel/docs.rst                   | 2 +-
 docs/devel/ebpf_rss.rst               | 2 +-
 docs/devel/multi-process.rst          | 6 +++---
 docs/devel/submitting-a-patch.rst     | 2 +-
 docs/interop/vfio-user.rst            | 2 +-
 docs/specs/ppc-spapr-hcalls.rst       | 2 +-
 docs/specs/ppc-spapr-xive.rst         | 2 +-
 docs/system/security.rst              | 2 +-
 docs/user/main.rst                    | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index 16de32147b..997b09c6a4 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -280,7 +280,7 @@ so you can use this to model clock controller devices which
 have guest-programmable frequency multipliers or dividers.
 
 Similarly to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
-the clock state was modified; that is, if the multiplier or the diviser
+the clock state was modified; that is, if the multiplier or the divisor
 or both were changed by the call.
 
 Note that ``clock_set_mul_div()`` does not automatically call
diff --git a/docs/devel/control-flow-integrity.rst b/docs/devel/control-flow-integrity.rst
index 3d5702fa4c..466888bdf1 100644
--- a/docs/devel/control-flow-integrity.rst
+++ b/docs/devel/control-flow-integrity.rst
@@ -39,7 +39,7 @@ are planning to also enable fuzzing, then Clang 11+ is needed (more on this
 later).
 
 Given the use of LTO, a version of AR that supports LLVM IR is required.
-The easies way of doing this is by selecting the AR provided by LLVM::
+The easiest way of doing this is by selecting the AR provided by LLVM::
 
  AR=llvm-ar-9 CC=clang-9 CXX=clang++-9 /path/to/configure --enable-cfi
 
diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
index a7768b5311..7fe7e44429 100644
--- a/docs/devel/docs.rst
+++ b/docs/devel/docs.rst
@@ -5,7 +5,7 @@ QEMU Documentation
 
 QEMU's documentation is written in reStructuredText format and
 built using the Sphinx documentation generator. We generate both
-the HTML manual and the manpages from the some documentation sources.
+the HTML manual and the manpages from the same documentation sources.
 
 hxtool and .hx files
 --------------------
diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index ed5d33767b..85ef547623 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -31,7 +31,7 @@ Not for all packets, the hash can/should be calculated.
 
 Note: currently, eBPF RSS does not support hash reporting.
 
-eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap configurations:
+eBPF RSS turned on by different combinations of vhost-net, virtio-net and tap configurations:
 
 - eBPF is used:
 
diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
index 4ef539c0b0..cafe2aaba7 100644
--- a/docs/devel/multi-process.rst
+++ b/docs/devel/multi-process.rst
@@ -158,7 +158,7 @@ IOMMUs introduce another level of complexity, since the address given to
 the guest virtio device to DMA to or from is not a guest physical
 address. This case is handled by having vhost code within QEMU register
 as a listener for IOMMU mapping changes. The vhost application maintains
-a cache of IOMMMU translations: sending translation requests back to
+a cache of IOMMU translations: sending translation requests back to
 QEMU on cache misses, and in turn receiving flush requests from QEMU
 when mappings are purged.
 
@@ -573,7 +573,7 @@ live migration
 When a remote process receives a live migration indication from QEMU, it
 will set up a channel using the received file descriptor with
 ``qio_channel_socket_new_fd()``. This channel will be used to create a
-*QEMUfile* that can be passed to ``qemu_save_device_state()`` to send
+*QEMUFile* that can be passed to ``qemu_save_device_state()`` to send
 the process's device state back to QEMU. This method will be reversed on
 restore - the channel will be passed to ``qemu_loadvm_state()`` to
 restore the device state.
@@ -853,7 +853,7 @@ intx irq descriptor
 
 The irq descriptors are created by the proxy object
 ``using event_notifier_init()`` to create the irq and re-sampling
-*eventds*, and ``kvm_vm_ioctl(KVM_IRQFD)`` to bind them to an interrupt.
+*eventfds*, and ``kvm_vm_ioctl(KVM_IRQFD)`` to bind them to an interrupt.
 The interrupt route can be found with
 ``pci_device_route_intx_to_irq()``.
 
diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 5ccd09a397..cd08881dfb 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -241,7 +241,7 @@ Use B4
 ~~~~~~
 
 The `b4`_ tool, used for Linux kernel development, can also be used for QEMU
-development. It is packaged in most distros and PyPi. The QEMU source tree
+development. It is packaged in most distros and PyPI. The QEMU source tree
 includes a ``b4`` project configuration file at the root: ``.b4-config``.
 
 Example workflow to prepare a patch series:
diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 1c92f442d2..3428241dae 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -1505,7 +1505,7 @@ Neither the request or reply have a payload.
 --------------------------------
 
 This message can be used to coalesce multiple device write operations
-into a single messgage.  It is only used as an optimization when the
+into a single message.  It is only used as an optimization when the
 outgoing message queue is relatively full.
 
 Request
diff --git a/docs/specs/ppc-spapr-hcalls.rst b/docs/specs/ppc-spapr-hcalls.rst
index 6cdcef2026..550026ea55 100644
--- a/docs/specs/ppc-spapr-hcalls.rst
+++ b/docs/specs/ppc-spapr-hcalls.rst
@@ -20,7 +20,7 @@ to an implementation specific range in PAPR.
 ``H_RTAS (0xf000)``
 ===================
 
-RTAS stands for Run-Time Abstraction Sercies and is a set of runtime services
+RTAS stands for Run-Time Abstraction Services and is a set of runtime services
 generally provided by the firmware inside the guest to the operating system. It
 predates the existence of hypervisors (it was originally an extension to Open
 Firmware) and is still used by PAPR and LoPAR to provide various services that
diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
index f47f739e01..8b83942a29 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -171,7 +171,7 @@ native exploitation mode* is selected should contain:
 - ``reg``
 
   contains the base address and size of the thread interrupt
-  managnement areas (TIMA), for the User level and for the Guest OS
+  management areas (TIMA), for the User level and for the Guest OS
   level. Only the Guest OS level is taken into account today.
 
 - ``ibm,xive-eq-sizes``
diff --git a/docs/system/security.rst b/docs/system/security.rst
index 75e39caede..1bd8423866 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -107,7 +107,7 @@ an issue as a normal bug.
   possibility of large memory peaks and apply countermeasures to
   provide continuity of host operations. It is typical for the Linux
   OOM killer to reap the process triggering host memory overcommit
-  in the case of exccessive usage, offering a degree of protection.
+  in the case of excessive usage, offering a degree of protection.
   As such, bugs which can lead to excessive/unbounded memory allocations
   will usually not be classified as security flaws, but should be
   fixed as hardening bugs.
diff --git a/docs/user/main.rst b/docs/user/main.rst
index a8ddf91424..aef33bfd9a 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -23,7 +23,7 @@ System call translation
 System calls are the principle interface between user-space and the
 kernel. Generally the same system calls exist on all versions of the
 kernel so QEMU includes a generic system call translator. The
-translator takes care of adjusting endianess, 32/64 bit parameter size
+translator takes care of adjusting endianness, 32/64 bit parameter size
 and then calling the equivalent host system call.
 
 QEMU can also adjust device specific ``ioctl()`` calls in a similar

---
base-commit: d7a65d1793d691d356a56833620f7d1e6f5d653b
change-id: 20261006-typos-in-docs-36cfdbbe52d3

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


