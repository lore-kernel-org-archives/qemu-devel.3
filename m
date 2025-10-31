Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE9ECCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwh-0004XB-JV; Fri, 31 Oct 2025 14:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwZ-0004SF-Ve
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwL-0006DZ-LD
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711810948aso19099565e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935608; x=1762540408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PZmkhsZKvN6EJpvyQwrzTxRS8P0qQq1BnzId2LTKpiQ=;
 b=qBydAEdxLeL/i6kXXgL1q/MEAyVS5WE4asmuaDMwPHoz8qNqKjmFrtTPuonFvGknEq
 31H/aX9o9/uX3f3eVan77vNEAXEK/GA5AEP6nzdtlAPX76PdlGVYCkek8SthvawZyazq
 2GCCEoAR4G/g7xh0qfn5ejdTJVQk5jXTwOc9gMNahV398klCx9wBGc6g43j/ViQPnL4U
 0cUZTXZCJqdMSV2t6Us6Q4+3ONFS8p0t/OlceO2BRoKddySbXAQakUXmhyuwPcwgVH9f
 2jy5i10SDGXGt5Np/nFhVz7nuw5wDU7hedznzl4i7y4YqcSi/CASpDtsQ3xmoB0joI6v
 KOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935608; x=1762540408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZmkhsZKvN6EJpvyQwrzTxRS8P0qQq1BnzId2LTKpiQ=;
 b=Of16l4cdswghrDXmHhM1iyc8wvS7dyRiMpfKTqtjzvLIdq45a7dQPiAncrhwlbJy3G
 r0NXDH5X+blhZTivdSbEVuwxvJP412G9NRXj7a+sQ3fvIgC3hnFBZer4+rUElQ1upGTM
 pdb9EDbmFSMvXJLUQwLTg0wwlDVCsQJphXZlgRCPgZZZ/70etzNXR4dIe7rPntRvLcm6
 jhI/efUKz67YlR8odfD5XGKYwU2e6/brGhgxIJC4f1pFnI7d2OimIlf/UFWwNtBsPAKp
 DHFxMPB9mNLgZrtdOnyCWw7ppRc+cWh8+DxWjHczGeJyNpCjPLU0/Zdcs4yi7KUw7sON
 PP+g==
X-Gm-Message-State: AOJu0YycIY2mLcnzuOzPJLO54HQ2cunjJhFVk7566+zIgg2Z3LCqtyXj
 lyqhMjdCT7MaquhOnsM/waK+SvAjHseAaDwyQFoiiHIB3SwXz6G9MHLJYB8C6afWtv8TPsuzFa5
 HzyVk
X-Gm-Gg: ASbGncv30ocIqxToWxNtkVoVRyXRI89T/cCmTHPSmadTp89SWHZJNdBvGApqEcpkeBn
 FgHAk+ieuwkzbfyRYOlwvjLPDcQeMLeFxPh7q25Vxwlkp1UXjpOgQYZ8JRgGmyrz9/T1G09K2Ni
 /kK8mtw/8pBfQhaqBzGe3/BgAD9D3NoMZ2883JR2H150GSc4bFsv2G/vkPhQK0astY7vs3bfhnF
 NsvQYteNb/Ba3sL6EODfMItcZ3608uflBO0UekTtQ3Gu3p1QReMSqlg+ZFkFI37FTl9BWqwW1B0
 heApk8NwhLvtLi6rjzPFMem1UZi5hXYHZYf6FJCuA+Az9aVPSUYSg5EpXn8rPHRUIpUFcvOdxfi
 TZANL+l5ZrFYglvUyhej3S8UB8mUSLrgpkC8YVkBO1Y62HfN/AJADK9f9MEoaXY+xa7VUsxRIXb
 kKRsMMJg==
X-Google-Smtp-Source: AGHT+IELf41mK8kyYCIbDwZQuZUmQQLjoUXDt24qNV3IYlU2UlyP2/Qo4Yy6MkrN/Zc4X1yqO3U8Xg==
X-Received: by 2002:a5d:64c3:0:b0:428:436d:7d7e with SMTP id
 ffacd0b85a97d-429bd6f08a9mr3857114f8f.60.1761935608128; 
 Fri, 31 Oct 2025 11:33:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/38] accel/hvf: Mention hvf_arch_init_vcpu() must run on vCPU
 thread
Date: Fri, 31 Oct 2025 18:32:48 +0000
Message-ID: <20251031183310.3778349-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hvf_arch_init_vcpu(), along with hvf_put_guest_debug_registers()
and hvf_put_gdbstub_debug_registers(), calls hv_vcpu_set_sys_reg(),
which must run on a vCPU. Mention they also must.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h | 3 ++-
 target/arm/hvf/hvf.c     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 8fce627b08c..0c335facc3b 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,11 +71,12 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+/* Must be called by the owning thread */
+int hvf_arch_init_vcpu(CPUState *cpu);
 /* Must be called by the owning thread */
 int hvf_arch_vcpu_exec(CPUState *);
 /* Must be called by the owning thread */
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fdf8df09d4b..8095cb0805a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2119,6 +2119,7 @@ void hvf_arch_remove_all_hw_breakpoints(void)
  * Update the vCPU with the gdbstub's view of debug registers. This view
  * consists of all hardware breakpoints and watchpoints inserted so far while
  * debugging the guest.
+ * Must be called by the owning thread.
  */
 static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
 {
@@ -2157,6 +2158,7 @@ static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
 /*
  * Update the vCPU with the guest's view of debug registers. This view is kept
  * in the environment at all times.
+ * Must be called by the owning thread.
  */
 static void hvf_put_guest_debug_registers(CPUState *cpu)
 {
-- 
2.43.0


