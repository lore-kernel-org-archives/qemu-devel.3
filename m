Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDCEC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOw-0004VQ-Rl; Sat, 02 Aug 2025 19:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOa-0003pz-0x
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:11 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOU-0001pM-H6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:03 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6196ca9a2edso834220eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176321; x=1754781121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSCLNq+Taq3Oq2BlU4mdWkvovoZ3XyBtNGOx6Dfu8X0=;
 b=qI5LaksGC+kIdrLNkDg7/iRCm8BRIekllF59jV3/Ia3Egw2EfLqgnS21z9nl+fyixn
 2ncxaS77oaBdX8FFJqrTvTyGWE2/cx3d/dtDZm0nCUpnfmVtEgShjGUO0gJsT9UremiQ
 hnIYTIR4oaq73f6j1YGwmBSQ9y7FTerzzMT5T6/JIy0AWSMFMC8R7crTRngXCKijZpOF
 CIuPsf3WNMSkZ/i0rzytM2ipe6lCecKSXeYB90CpvbxJ9ajPub4s5dzOOR89+e2Lvt9j
 3q2PTNDHQjdRZZ4RllPPQiGvyZyVHavFnVphiPkxEX15VVruQMsizkk0YCrq5yIcFTvG
 FuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176321; x=1754781121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSCLNq+Taq3Oq2BlU4mdWkvovoZ3XyBtNGOx6Dfu8X0=;
 b=xPGHHWOxJfFItcVGAD5wRIgchOpQH2zNiYUc53bPrDs8o5OXiIi7NLES+brsFqHTn5
 76UsBa1qAtsM63ed8M7DLFP/Uu85FNaVXCCO1r5K4d/eSrJMB5dx+NxMmdjaUPoiRwlv
 WIIBeFbg2FBw51esTzPLI1/tJiwFl/hWjB3eGbHEoAv2zF94f3EYgxlbQHuh6pCTOR1o
 73jK8PLVhhHPXPQVWMLBcZqiVd60oRVjxDC7ZHDVoohdctrfmN8zWbm4/PKD94YeCdoW
 bKdZ+dZ1YY6qiuvSKuQGNwzQEIfrPB8GhoFXhWV84E6E9MO0323zrNa2k4gNXqo2Vj9Z
 Cmrw==
X-Gm-Message-State: AOJu0YyApsBu4SPXPFE2cAyLZMbNvwM3oHiJ3fyJ612DuRSclclkpyvx
 p+ouATXwYbQ6kJcZ3kn+TMsELLmy96D9H76xpqpSD8MVrpsFSv0YF/k1RI/1vJr4Yh7DYEBspA2
 0z1A5ueE=
X-Gm-Gg: ASbGnctwLYxZqaHFEWbj5rPV5OMIgzqadIqO3db611gFViQnscQWycBMqMNZF+XixGo
 hIX9yjTMm0ROn029Sl84iz4QXT01vltVcj6yWmib2I1oz8jczBBrKXKKIREda/UceTDCEG4LWZC
 Az8GauYtZm+51qHIvSFXvAkghB0VKqt7vWjhWuq+0l365OiNPQMbyXTIp86sVA45A9MtGvZOqre
 LG3TrrBZxCwIW8d7rg/g0EbxuEbdwgfZBPT7T27/Qj3sXqDOrzFZaeQUEKZPHMoiX+H+Dh+ncMh
 z/AWUiWxEYc33f9SeEuOAJsK7F9Lcap3IFDlFaQXkOyoIkw8gtFl9wvwqDYkKdtZggNHF+732hg
 PnpV46JGPbfDWR7P3WsQmoEjPgqrOO9hGu1017rTYscbhC3U6OOSH
X-Google-Smtp-Source: AGHT+IF8fFFNe4OYCDuS0ZxsOI9WkWq9ktHNFNwj6r2fhV5FAySlHJII1f2MTNltMXbdx9jMVplDKw==
X-Received: by 2002:a05:6820:c019:b0:619:950f:1d5c with SMTP id
 006d021491bc7-619950f261fmr1121646eaf.1.1754176321330; 
 Sat, 02 Aug 2025 16:12:01 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 65/95] linux-user: Replace init_guest_commpage macro with
 function
Date: Sun,  3 Aug 2025 09:04:29 +1000
Message-ID: <20250802230459.412251-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

Turn the fallback macro into a function.  This will produce
a link error if the other macros are set up incorrectly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ec5b1b586f..0299bb852b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1115,7 +1115,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #define HI_COMMPAGE 0
 #define LO_COMMPAGE -1
 #ifndef HAVE_GUEST_COMMPAGE
-#define init_guest_commpage() true
+bool init_guest_commpage(void) { return true; }
 #endif
 #endif
 
-- 
2.43.0


