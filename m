Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31104CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTC-00077S-1X; Thu, 02 Oct 2025 23:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WT4-000733-El
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSt-0001Da-UP
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f5d497692so2484633b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462091; x=1760066891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9e72oUIBV4vzVLXmEifMrDsgj+nHpDSwe09C+KGtro=;
 b=IxY/2aAcMBIduCK9POWooZOI3isaxbiY25LPDzRDwAjVjPqw2/Jpj2rK8FMPwDBNdZ
 q47X+hMlz0feRiKIj6L5poFleH3uayT9dd/ZyiqJksLMpEHifjxlFFem7zdCQUsXc//n
 G73V/8+NCcZVTMSrQIfLTFyztNq4eBPHFI0YArp0BhVf9md/KOfT48uYPFkzJ3POyWIj
 blNxxZifq/KeZL3TadqNgeEBvD9wFDBMW8YDyLej+3Is6QnUrPpESLnbk/aO1qNWjsCN
 ZJfnVYXt5vANEbTyDZ5h48UxAQwiZV0wHdldyAhCPz47enfIZ2zQaIErMrph/9xGFbq6
 n4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462091; x=1760066891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y9e72oUIBV4vzVLXmEifMrDsgj+nHpDSwe09C+KGtro=;
 b=SZytnSFEGZYb/JakxYR4680HIE5BefVLM+0ONk4EN/eG80QOCsfdmYh2K4AiLDZ42l
 0+7m98OEQS2ZbuyCOrwB3ZR4Cz4ZBihpZ4rkJz3IpHqA8NgZlIcAWzLC8dR/ld3JsG2r
 eaZtL1DWI4wLdvUzzNfmdbeljNmzzMf9+ej/Ra38ykdkgzj+kuHzZZLpHCNNkyXs/45x
 T5U2CMacpGAESSJp220x16I5UB57CWKlUIaHnKe2cx9ID5t7gCRR7EziAOFW2bxjpxm3
 U+F5eGjrwmpj97dexIkTOc/r8vQkGo/Y7eat7n9617uwHhWC5O+79QSqHbyVoZGaC1gC
 Jtmw==
X-Gm-Message-State: AOJu0YxqWLFD6iDkYe8yJ4KwFB8yij2ZewPAVid5VnIZDLlBCY8sQCc+
 L7Rt3Kk9etP5DASl8udhj+1Gl5xA0IAF6sZTdkiTjpcDxMu6nUhgdUQ0dNHXLg==
X-Gm-Gg: ASbGncvg2mQJs+7arTEJpwmUitywO4Gw3usJOOSt7VcNj0Z87gL2/uNkqwZPxhP/3ki
 jTUD8zus96btkaQ+4bkjDp3r5ux6yET74piSrHZ1BRfze2S1/TTb2meVf+ZvgbQfGl/ZcZLa65U
 sHY94o0VEIRRLcvqw+XDYUojeL3yBLnZk61lC0D+Zf32JwZFLK8UkzQVMUEOX+hEtLsPPD14vJE
 gPXzKuvY+erSvDeJNuy3S8wzacBjk046PRkmbTucefqSuh3RvmEXbXjIAQokLzx+8r3Id1Ye7qF
 YPCmKfhHCdZQ1Lx4Mv8jP4zWENsHNYAxl8U2ERNg3GG3yp/bcsibNKYhTSAIsh2t0LhjoKI4aGP
 2j0aaDdxpbVNRzSOCoiiRWkTMzVe4DzrcRwO+RC4+LX1Xr3v4G+BqmVygjWBurzAKuHDKjdCqGy
 TExZAbrGv/+3mhMy+nsF6l93fNNuOS6sVYg5p5xX8EJq/AuRaYZwOy
X-Google-Smtp-Source: AGHT+IG3pnF1r84L4DG663uJSXqt9ylMDyCs8ERyZaJxPUiAd3kodRHObQ9+dccFVlY0Ey373IrDug==
X-Received: by 2002:a05:6a20:3d95:b0:2e5:c9ee:96ee with SMTP id
 adf61e73a8af0-32b6208e887mr2003497637.37.1759462090648; 
 Thu, 02 Oct 2025 20:28:10 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/26] hw/intc: Save time_delta in RISC-V mtimer VMState
Date: Fri,  3 Oct 2025 13:27:02 +1000
Message-ID: <20251003032718.1324734-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

In QEMU's RISC-V ACLINT timer model, 'mtime' is not stored directly as a
state variable. It is computed on demand as:

    mtime = rtc_r + time_delta

where:
- 'rtc_r' is the current VM virtual time (in ticks) obtained via
  cpu_riscv_read_rtc_raw() from QEMU_CLOCK_VIRTUAL.
- 'time_delta' is an offset applied when the guest writes a new 'mtime'
  value via riscv_aclint_mtimer_write():

    time_delta = value - rtc_r

Under this design, 'rtc_r' is assumed to be monotonically increasing
during VM execution. Even if the guest writes an 'mtime' value smaller
than the current one (making 'time_delta' negative in signed arithmetic,
or underflow in unsigned arithmetic), the computed 'mtime' remains
correct because 'rtc_r_new > rtc_r_old':

    mtime_new = rtc_r_new + (value - rtc_r_old)

However, this monotonicity assumption breaks on snapshot load.

Before restoring a snapshot, QEMU resets the guest, which calls
riscv_aclint_mtimer_reset_enter() to set 'mtime' to 0 and recompute
'time_delta' as:

    time_delta = 0 - rtc_r_reset

Here, the time_delta differs from the value that was present when the
snapshot was saved. As a result, subsequent reads produce a fixed offset
from the true mtime.

This can be observed with the 'date' command inside the guest: after loading
a snapshot, the reported time appears "frozen" at the save point, and only
resumes correctly after the guest has run long enough to compensate for the
erroneous offset.

The fix is to treat 'time_delta' as part of the device's migratable
state and save/restore it via vmstate. This preserves the correct
relation between 'rtc_r' and 'mtime' across snapshot save/load, ensuring
'mtime' continues incrementing from the precise saved value after
restore.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911-timers-v3-1-60508f640050@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..318a9c8248 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -323,9 +323,10 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
+            VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
             VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
                                   num_harts, 0,
                                   vmstate_info_uint64, uint64_t),
-- 
2.51.0


