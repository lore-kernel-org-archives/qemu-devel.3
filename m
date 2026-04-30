Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C0FCD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV91-0002zK-Ll; Thu, 30 Apr 2026 13:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8V-0002Lh-0a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8R-0005HQ-SW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P54di0kfAOuwaF9b+vABHbPOahrAfQkSVqDBXMzuc3g=;
 b=NGfzEjWSS8vgDHDAW66RZJu15yO99CZSNNh//ju4GbaoXXDol5tX7Jadmf9i0UaVSyRIu3
 CoF5owEeQgISKBiwlyoZRvccY+M5Tzbmt+GpS/dFzju8iAu9gBQ8m3YERvkkDxpRYd0vp6
 xBSvJanvBxP1k6V47ZDtgddfzkUK5Nw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-gkr7Sax3MIiYNmkgMdACNQ-1; Thu, 30 Apr 2026 13:25:08 -0400
X-MC-Unique: gkr7Sax3MIiYNmkgMdACNQ-1
X-Mimecast-MFC-AGG-ID: gkr7Sax3MIiYNmkgMdACNQ_1777569908
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eb82634cbeso237979885a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569908; x=1778174708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P54di0kfAOuwaF9b+vABHbPOahrAfQkSVqDBXMzuc3g=;
 b=UuctR0nJbseCMKk4Si4fAmtyKadCKr/zfdYAIQpneKdaSvvNw7QGupyW4ZmpvwslXY
 ZFR7zgzLsSZtmsBFBjWU+11yr5ljcleigDJtZDMPFjqlYRnzONnl/JwY/TUqq31WBgQ1
 /zaOqnC8tB73JKsY0tH9mMlwlsjc6Pwcxt2ow92yLrCL4lBMOtt0QOerFxrMC2M0SKcW
 J+tnqneN+u/nTzC8/2o/ms5ZNaikmOCqRlndRiIsLnSxVjGYZeZNMZvSJPtqtLaIupMY
 TwBwj2X5rrgP/HO8miTEyY2bU6c8mFjHPonEJoO5IKglWkmQL2/f/R/LqOfhyEUjWiWG
 tW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569908; x=1778174708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P54di0kfAOuwaF9b+vABHbPOahrAfQkSVqDBXMzuc3g=;
 b=aEGsGy+hcOWjeGWupR4BS62g6m6Mrr8pUQW17oqfpg+/JGk9pkRw3VDrOtfXkfLQf9
 j/siimoT/aQ36WceQMYJwiVgUdwIWJM9z6vAGQSD2oEEq7SzDN56/T6hX2QldhSWLPrn
 xr21qj9tUs9dEVRZFnc1qhu5WVIpwD7CUC1C4/wP5+MShnFca/dHEA1cIHB+0s5nNhV5
 626fvAAlbRPgxVvJHtzI0FlBrF8zMwf5dZxJ1TqcezIYHVHFqlFuH7WieaEDxwouUFb/
 HTdeaN7SPm0pthQTBE91J8RlAKTeFinZzpYFy/ihtDUzCRBsrpFHVvzitl7ONvhB4W3+
 YGiw==
X-Gm-Message-State: AOJu0Yxzokepz9qhbRBIY4sk/vtoxqsxoiLNs+zMlwK6YuoWKErexHIZ
 mcO2xdf9w2QBtRuHvfg5ZgncjCnns99GI0q6efS652JENcUUhRhyzo6Znlb61YgFaUmtDpZ5bBW
 qbs05AONQcGMIHDX+XbAfSlrTDv4uiAdHJxB+7zoBWyae5kKsmgPEkGfpXOZp3OE1ZUFY3XE2cD
 qwdVDDUTRCxhTt+sL5CzNYQkpwqUwPoj/+P1G1bZIL
X-Gm-Gg: AeBDiev0TqRoB9vuBAu7jiRxsFKkuFQftyIDaC0/BLWUnfMq5Pd3WMqGIHDxWZShpXa
 oLXCh88HxePvpIibMjHQ1OKOeba0PDpWrKY0RHyVVKK6vRB7qC5g08y1Qx7Mlsg/S8sfUapm8/a
 VyMRn4Zrb5ZNIyUuYxW+Em7WMZ8zxMoTDAYVf6vkUPUQkAkSEYZs+3bNCak6k6fzX43TCgDIfmH
 g74BR3LAbkXJrqDbQ3TcQdC4BWKBL9aeU5MpPPvFXFSyJtZC6atTOeiXHebU7uJu5GTKtMh/pQr
 mfl/6BWgc+sd2oc3GbAKenXfRnU2GNPC5fw8Xrjqf8q5k79MPA5mR3VCYbr1Vhy2KveEhkUsnqA
 TgJ0Ky6Le5zKDqUUb5qlfY91gzTUsI5nTfERI9B9/JUzTBeM1TmLLMdMzpIFo8zPTsSuL4EObSI
 BWNOC4/0xvXBksq94Yi4Nk8vY5OQ9yHLrH/uI=
X-Received: by 2002:a05:620a:4887:b0:8cd:8bfb:a64 with SMTP id
 af79cd13be357-8fa88f2edf2mr621418485a.31.1777569907586; 
 Thu, 30 Apr 2026 10:25:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4887:b0:8cd:8bfb:a64 with SMTP id
 af79cd13be357-8fa88f2edf2mr621409985a.31.1777569906902; 
 Thu, 30 Apr 2026 10:25:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb15ca74bsm24494585a.20.2026.04.30.10.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:25:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 58/58] whpx: i386: documentation update
Date: Thu, 30 Apr 2026 19:22:04 +0200
Message-ID: <20260430172204.1006673-59-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-38-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/whpx.rst | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
index 3e1979028c9..9909e86831b 100644
--- a/docs/system/whpx.rst
+++ b/docs/system/whpx.rst
@@ -63,7 +63,7 @@ additional functionality compared to ``-device ramfb``, but is
 incompatible with Windows's UEFI GOP implementation, which
 expects a linear framebuffer to be available.
 
-Some tracing options
+Accelerator options
 --------------------
 
 x86_64
@@ -75,6 +75,11 @@ to undocumented MSRs.
 ``-d invalid_mem`` allows to trace accesses to unmapped
 GPAs.
 
+``-accel whpx,ssd=off`` disables the separate security domain feature,
+as in a BTB flush when entering/exiting the guest. This results in a
+significant MMIO performance increase at the detriment of security
+mitigations.
+
 Known issues on x86_64
 ----------------------
 
@@ -96,45 +101,22 @@ MMX, SSE or AVX instructions for access to MMIO memory ranges.
 Attempts to run such guests will result in an ``Unimplemented handler``
 warning for MMX and a failure to decode for newer instructions.
 
-``-M isapc``
-^^^^^^^^^^^^
-
-``-M isapc`` doesn't disable the Hyper-V LAPIC on its own yet. To
-be able to use that machine, use ``-accel whpx,hyperv=off,kernel-irqchip=off``.
-
-However, in QEMU 11.0, the guest will still be a 64-bit x86
-ISA machine with all the corresponding CPUID leaves exposed.
-
-gdbstub
-^^^^^^^
-
-As save/restore of xsave state is not currently present, state
-exposed through GDB will be incomplete.
-
-The same also applies to ``info registers``.
-
-``-cpu type`` ignored
-^^^^^^^^^^^^^^^^^^^^^
-
-In this release, -cpu is an ignored argument. 
-
 PIC interrupts on Windows 10
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 On Windows 10, a legacy PIC interrupt injected does not wake the guest
 from an HLT when using the Hyper-V provided interrupt controller.
 
-This has been addressed in QEMU 11.0 on Windows 11 platforms but
-functionality to make it available on Windows 10 isn't present.
+As such, on Windows 10, using the Hyper-V interrupt controller is
+disabled by default. You can enable it via ``-M q35,pic=off`` which
+disables the PIC. In that configuration, using a UEFI is recommended.
 
-Workaround: for affected use cases, use ``-M kernel-irqchip=off``.
+On this release, ``-M kernel-irqchip=`` is not expected to be manually
+set during normal operation. It remains as a debugging option.
 
 Known issues on Windows 11
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Nested virtualisation-specific Hyper-V enlightenments are not
-currently exposed.
-
 arm64
 -----
 
-- 
2.54.0


