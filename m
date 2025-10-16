Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F31CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mtz-00068b-24; Thu, 16 Oct 2025 08:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtw-00067K-B4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mti-00086H-BH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso396341f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616949; x=1761221749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x1nv4sVC6bAaj10+koLwfZ6TzTnUm6H+r4SdUg6myZQ=;
 b=FG0bVDT74JgbnhHP4KgMRLribogI769Ze7zQtU0GKAS0e3oywKpF5xZ7MKjbRtWOEN
 hh6sj+hbQfwmokPM06V1/uuSeNf5GoKNn/1foT7z+GSNF7II2CHsmaUeOJeKpCtPZIQp
 n7cMVVZBi3ma4Gu01NqSKvEeVLquSRB+okyG35BA835DPkHZkiwum1R/lhSpPAbrc3dW
 fNM5nlrDnyjetBl0fLvsIraO3NsquUHxDUO4k2OLGd/BEtZDGBbhkBDY+DJcvDqIMe6H
 YzRJpODsiJcZMOiwcWkgWraAO43l9I+Q4E2LGijcRfKzfM9GKyDnQ4iYb0B+2ZuOhr4z
 hyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616949; x=1761221749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1nv4sVC6bAaj10+koLwfZ6TzTnUm6H+r4SdUg6myZQ=;
 b=nDISLSKs1+Ls6vE2ztADuv0QIM9X7iGb0Js9ifcBlaxDC76rtXiQT7UMgYj/8XTO5z
 fYEzVmuSZxm7mJRQ2u8lp9eLr/u0vVL9dIikzg1+RpfLQ3JYII5Le+sGIFAp8vWcxlaO
 w+Yt2JT9d25Vy1aer+Q2cQHWv4m8ZsOKKnqEarbwskLSTgtF3XCDaxMLxzLKS8Ab1bCS
 zWBQqDazvJ85Ikr3/CEb4Ec70DPqBT78ML8pMpxDQLuwIgay3N7RWEI+xcH5nzqGS+Tz
 vOzTD+XGpskShPiour79yiYF+rr/PXzIsanZgXX3U3PDIqMfqFc7ccDcCP0iz6SNiueC
 Zs8w==
X-Gm-Message-State: AOJu0YzHJw1pj+QD6VYUgKefP/hSGkhW/efw8z7XudG+sjEQOVWIvwpm
 tYQTHxRUtSgqtMp8uxDlEFaiQW0p0Q4Kkiwq6tebHSkJmTsh9qP1h0fwBJdnlImoRWMjcY2ajHW
 kIXzrb/M=
X-Gm-Gg: ASbGncv69JvScI4SOrcWNUN2QjQ+6LYuEYPjBv1OFU492EHa/ghwUPSxQTtnD82jB06
 DgVd7Cgr2dgWl+xpCRdfbJ7YpvmeyXYw4nieJsZewazxc01FrNzzc0FKLTUlGaCDRwqYgcfu9SX
 1H8MkNJlp8O/vBtnfkrnrQzCSyesmFtFDraBRjK+33lyd2nogF7AaIPXlKXqOFzmnS1JxVI/yyY
 Aao9d63qIRtU+uap18XOoVxihu0TvzDgqzpbkWGWFGbXks2hvFkx093l5kx+HAM6UefhKCp9Ulk
 roXDCuRwJGOgWXVHzHK8Hn6L/Bq5jJE5Jz7p9Bhnpr58kgsERWcY5J7IBMqNVDtTfD3i93p9Wrp
 bQBh7tAJxBf+HTRanA45C8PVp3d4JYbr15BaGiumPG9i0XcbOo+aXO19sNp+vXJKRChGX7wegXu
 UWoOOahLdNR4KGaTGcOOjQhwWafUkhrOcDmioQGB1U8EZigWdBMWxEW7PLUdL6XrsQ
X-Google-Smtp-Source: AGHT+IEIG7Sy1SiBRSBgzk2PHUyo6rgw9z3MyEx1j6n12B3pkRqZUcBBojbfUe5aDC9Fh0AR7Xt3fA==
X-Received: by 2002:a05:6000:1449:b0:425:8559:5d17 with SMTP id
 ffacd0b85a97d-4266e7dfebfmr19812497f8f.30.1760616948896; 
 Thu, 16 Oct 2025 05:15:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf70fsm32908119f8f.27.2025.10.16.05.15.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:15:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/75] target/alpha: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT64()
Date: Thu, 16 Oct 2025 14:14:19 +0200
Message-ID: <20251016121532.14042-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

All these CPUAlphaState fields are of uint64_t type (except
the @fir[] array which uses float64, expanded to the same
type definition). Use the appropriate VMSTATE_UINT64() macro.

There is no functional change (the migration stream is not
modified), because the Alpha targets are only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/alpha*
  configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
  configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20250925005137.59378-1-philmd@linaro.org>
---
 target/alpha/machine.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 5f302b166da..6828b123ca1 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -25,8 +25,8 @@ static const VMStateInfo vmstate_fpcr = {
 };
 
 static const VMStateField vmstate_env_fields[] = {
-    VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
-    VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
+    VMSTATE_UINT64_ARRAY(ir, CPUAlphaState, 31),
+    VMSTATE_UINT64_ARRAY(fir, CPUAlphaState, 31),
     /* Save the architecture value of the fpcr, not the internally
        expanded version.  Since this architecture value does not
        exist in memory to be stored, this requires a but of hoop
@@ -41,27 +41,27 @@ static const VMStateField vmstate_env_fields[] = {
         .flags = VMS_SINGLE,
         .offset = 0
     },
-    VMSTATE_UINTTL(pc, CPUAlphaState),
-    VMSTATE_UINTTL(unique, CPUAlphaState),
-    VMSTATE_UINTTL(lock_addr, CPUAlphaState),
-    VMSTATE_UINTTL(lock_value, CPUAlphaState),
+    VMSTATE_UINT64(pc, CPUAlphaState),
+    VMSTATE_UINT64(unique, CPUAlphaState),
+    VMSTATE_UINT64(lock_addr, CPUAlphaState),
+    VMSTATE_UINT64(lock_value, CPUAlphaState),
 
     VMSTATE_UINT32(flags, CPUAlphaState),
     VMSTATE_UINT32(pcc_ofs, CPUAlphaState),
 
-    VMSTATE_UINTTL(trap_arg0, CPUAlphaState),
-    VMSTATE_UINTTL(trap_arg1, CPUAlphaState),
-    VMSTATE_UINTTL(trap_arg2, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg0, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg1, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg2, CPUAlphaState),
 
-    VMSTATE_UINTTL(exc_addr, CPUAlphaState),
-    VMSTATE_UINTTL(palbr, CPUAlphaState),
-    VMSTATE_UINTTL(ptbr, CPUAlphaState),
-    VMSTATE_UINTTL(vptptr, CPUAlphaState),
-    VMSTATE_UINTTL(sysval, CPUAlphaState),
-    VMSTATE_UINTTL(usp, CPUAlphaState),
+    VMSTATE_UINT64(exc_addr, CPUAlphaState),
+    VMSTATE_UINT64(palbr, CPUAlphaState),
+    VMSTATE_UINT64(ptbr, CPUAlphaState),
+    VMSTATE_UINT64(vptptr, CPUAlphaState),
+    VMSTATE_UINT64(sysval, CPUAlphaState),
+    VMSTATE_UINT64(usp, CPUAlphaState),
 
-    VMSTATE_UINTTL_ARRAY(shadow, CPUAlphaState, 8),
-    VMSTATE_UINTTL_ARRAY(scratch, CPUAlphaState, 24),
+    VMSTATE_UINT64_ARRAY(shadow, CPUAlphaState, 8),
+    VMSTATE_UINT64_ARRAY(scratch, CPUAlphaState, 24),
 
     VMSTATE_END_OF_LIST()
 };
-- 
2.51.0


