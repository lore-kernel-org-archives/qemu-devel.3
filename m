Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB26CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmu-0001U3-K9; Tue, 26 May 2026 10:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmr-0001MM-PI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmq-0001UR-6H
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ed9336049so489578f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805779; x=1780410579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aUwhoNUYBmu7k7QFzTRgfW3y4sYDCp0LrlYK7tGJv6g=;
 b=jWt6GZCyMq/w9rh7MRr1UX8xVk4AYOTaXQ1jGqeWf7iV1bNNs66iSb6/Da2MB8FLBl
 lVGgv+I5lqnWWcGaEO6R8CFxTWt1n4Knl0Vei+juh0hj9IM1smH8kXXZxppSYKjKG7fw
 U9swl1KriZtVAgfXMIYgA+ulDoptHRS2n0JZJAKzj/6TXBWTC4ZQaqRx0bWdzIlqtFh5
 EiY9R9xiFK6nVJCjWDpavXHp+Dfw0ltD9M6bOcIo0EouLpxqNWS4fvAqQ6KeDQMjzUDP
 dbs19AdSYUrzCFukUya0IJm6LaBKpIPx7Ha2L3teVKmqL2dt0OCQEUQXcRB3gnDG4/Fa
 KGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805779; x=1780410579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aUwhoNUYBmu7k7QFzTRgfW3y4sYDCp0LrlYK7tGJv6g=;
 b=iPixztH1USA6H53rGq6Gqa3I/oCiXYlvXEIKmz8RjcbXTW95I57N+H4vrsQlsaldIZ
 eXraqnxYOsyXX5/KfM+vjRqPSEHoIE5hMRE2wwjWjU3en1NFd8WBvo0gAGqdzPXKhm3e
 UvvVwFS9iLRBSxRJLTYUWF0XcimVyc4X29VgyzM7TCZbKxQKdmdz1rF6j5tdtAZsEbTj
 TvT5vOgFdhMV7eR/CXIJctXt7DJVoUMfi8UdlwmvI60O5FMGX1OW3xqevNX9NnAYPA0U
 GxQy7Fg6WZ66m2zERatRvsA+GeuPfQDfvcwx3qjlHplHdVIgsU0l0tbrivcvrJCF6yEy
 PwXg==
X-Gm-Message-State: AOJu0YwOW31LnGxbwcQNiq64gv7w2ENKVjAf1bfi5IJnwmx2sYMlIAyy
 Msso8hlnOc+zCIrTdEHgcl/fl8vaJJqhTlw122RXwyDZb15VBGY2qeqEkGDaZ4lq/qtVY4Uaw0K
 RtycO
X-Gm-Gg: Acq92OEZgYdBWvMHmi1B/Zu/EYLZnHXGEs93OsIoZEn/79IyiSfbrgGoDTk54Sa+F7s
 Mcei2UzzACsfVSozc6u7AQLbhohhTYHaA9QAT0TzfBCUUwD1jIfYtAqhrgAwENF1/hLK5LY8dEY
 PJkecQoyhPBw4vnrAJAEAHVujcAGRB2g0zLMe8sNVE2HykEhTlbBYhKvPNrVwhQi5r3b+2TUng1
 O3yEAWCBvtvAldUQrgh/zOUCSz3P6F1ra3QWZSFBu3ovK3TCPQhAkSj4D+s7/RNI7WjyZf5WMLO
 rnZAGxi2UDmFBPNLjzWNnNQLwvWZzbP+7ZsCOnE7uc5XTY6DfY0HMo9AyGv66nhoRH0uAFVB2lr
 XxQTurzyftSe75+t8yvmRXYjiJp+rbIqSAOsPHEag2tQ4isbpvoXL0oYjSVzKXvKGOXVztbQpsu
 petwvRuQLE0vtZsiWqwlp5AFTpkrW/l5tpoz7bYSBUpTyHOwrUHTQJZR8m1pR0q95oumC5dDfhM
 Ln03AHPfnCl+Jhf5yaWxOTv8fwH0l0=
X-Received: by 2002:a05:6000:25e1:b0:449:9aee:4575 with SMTP id
 ffacd0b85a97d-45eb389fd2emr30055302f8f.30.1779805778754; 
 Tue, 26 May 2026 07:29:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/54] target/arm: Enable FEAT_FPMR for -cpu max
Date: Tue, 26 May 2026 15:28:44 +0100
Message-ID: <20260526142850.2326589-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index da5f7efce2..e44b3016be 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -77,6 +77,7 @@ the following architecture extensions:
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
+- FEAT_FPMR (Floating-point Mode Register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index c5ffe21368..ceeeee5315 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -219,6 +219,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
     GET_FEATURE_ID(aa64_lse128, ARM_HWCAP2_A64_LSE128);
     GET_FEATURE_ID(aa64_faminmax, ARM_HWCAP2_A64_FAMINMAX);
+    GET_FEATURE_ID(aa64_fpmr, ARM_HWCAP2_A64_FPMR);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ff0c2b1c47..a377f67b9c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1297,6 +1297,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
-- 
2.43.0


