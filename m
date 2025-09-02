Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0455CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQno-0001nD-Rq; Tue, 02 Sep 2025 09:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQng-0001Al-Ss
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnZ-0004Zn-OF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3dae49b117bso536338f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818701; x=1757423501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=klJLauKcTBQRkj6rhNvhA6dvevN6/JOhKIhhGyaIW80=;
 b=fyEEtnK3UMBbT2u1ttTBGxMTvP/3XHACFjH594eHNUQRIihiCZy081plDkTHKIXmUm
 lQr7/0srZ+asbqjgywA5ynYRe+2mDkrUXSXPC7N3WkdSNMTRqDOOUHRg+bTr2ho0fitW
 dpzqAnLRdJNXu8xyPCH5HN4h2tjr2oFBu9SYowoTe51uNKqOVmBZIrqgee8796qJXAFa
 rgwivRGRNdA5Jt3m3XWzXPuaFQ4/97kNiCGp5yCh5QjRsJr6WR93s/aO9bg30ejZX/ZN
 zp/Q372jpxBtVAC+AJuJtJ6KWh4/3zaFnvmjsrONDgTn6DJGEhe4hN/y7MsVVBC5Y4aF
 HuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818701; x=1757423501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klJLauKcTBQRkj6rhNvhA6dvevN6/JOhKIhhGyaIW80=;
 b=jusp/sF8ox8WKL+h49m2mYMHzjTORQg+QtuIoOreA1UT9vzUnKlqLoeuOkIRrMH/ui
 5ROMxK3rbt+9eBpjlKpcXiIKmUf/coNwTdirV1DfMLaBdud/szGdq/Sn8wjkzYGoshID
 DE3Lfkf63d/GHkQM/L6ep8hhyyAIYkR9nFWSDDvGG+nCPr7ZY9nTD7y4k8IHJnVPM4LP
 FFokTDSLCCnyyDopyrrQMDxDOBWA6I4xiWSRnR4sauSBlZpmo0k2TBV1EsPs2yVOG4ov
 xyUfHS0yaYckJ+2aJM1EyNYVcZkJDjz8Mm/SbKJ4u7U9No79uB7ozrTn9HLP/L66T73B
 ykdA==
X-Gm-Message-State: AOJu0Yz6YHOAIPElsvZqozfnbSbNimfIUAAYPzTALxuXAPLcapBnh3+t
 l1xuREp44BLqFB12BH4pkY+HWwyodceFYRSrl49+W91p87oGdYRuNFNLIeX41ZJFj14CdX/tgFo
 GGQVh
X-Gm-Gg: ASbGnctOtROvCEx1ju5Dt3mdX7Qvr/3EFu+odhwa8dBkh3ggTJOrthWiTJKIuRhJWVE
 fM8VAnZ32omg6y2c5rKyhHDZjQcrZwTIUbKDYBwi60cfQK+V+8o+Fiu36QMqRvKq5jUezt9WNVC
 Edi63+HnrceIUkUKrwNNO2ycjwoTxLnSD4jZRl3eAbOzmHW+Q59aCCHnK2VtPeAZ95gM+BAu4d3
 Q5G40VchaIcgWn9tWRlAcS9pL5d1DjZlJL1cpE4rGKor+L5C3HzQitm6pXjM9hTnG3rFbLmsjEU
 /xz3fUs1lz9y3A/2t34yRBg1DFJs4QougPHrbKYcoVUwc3SdrbJWGn9Jo5//+cqd9FIayMaYcpV
 0CTaxGtxG8DY3XOldWTgWThuUa35o0uXK+Or0GunC5Id28YhcOazpcewEbYzED0Me4DjJFuOdAA
 rYBliQaf0=
X-Google-Smtp-Source: AGHT+IGu1SVSuUut4oxN/MiQNLZh2+ig7pA7fvoad0M5PGCC5UH3u1BWLxazjTaXQC6K9FLtAX5riA==
X-Received: by 2002:a05:6000:18a8:b0:3d9:9347:b2f9 with SMTP id
 ffacd0b85a97d-3d99347bb3fmr3059103f8f.34.1756818701245; 
 Tue, 02 Sep 2025 06:11:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0f85c287fsm17751634f8f.52.2025.09.02.06.11.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/39] target/mips: fix TLB huge page check to use 64-bit shift
Date: Tue,  2 Sep 2025 15:09:55 +0200
Message-ID: <20250902131016.84968-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Denis Rastyogin <gerben@altlinux.org>

Use extract64(entry, psn, 1) instead of (entry & (1 << psn)) to avoid
undefined behavior for shifts by 32–63 and to make bit extraction intent explicit.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Message-ID: <20250814104914.13101-1-gerben@altlinux.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/system/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index eccaf3624cb..1e8901556d6 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -652,7 +652,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         return 0;
     }
 
-    if ((entry & (1 << psn)) && hugepg) {
+    if (extract64(entry, psn, 1) && hugepg) {
         *huge_page = true;
         *hgpg_directory_hit = true;
         entry = get_tlb_entry_layout(env, entry, leaf_mop, pf_ptew);
-- 
2.51.0


