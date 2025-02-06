Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E62CC0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg87a-0004PE-Ah; Thu, 06 Feb 2025 15:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83q-0007z9-HR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:20 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83j-00019b-Cl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:18 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso2320582a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872054; x=1739476854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnQh28yKnEDfzPKxdGTxeUvOcx1IudwgVUfrYPpNYMc=;
 b=MJSotjm6bs3YMG7YibmHsa5ZSpalQdAHYc6XbwS9zV1gnGDmULD/RecQiOddt3sMis
 s83yXNmL23ynoYWqMQC+54H6v5fPj8ogRi67flQJ/M6xg+YnVlaGQHbEJmkB4r/cZCqA
 c7RxBnfTgvpTXm6vHn85rFPJEAEp65SwR3h9JJKrCpf+yc5cRxbe3ZEtiqKFmfeAn+1F
 1/ZE/7l5VvOx/zi/rB9sSsMhQy+OEP1N86hY321i6lJt4S9K+a/bjIv8iNrgzowHgGXU
 HPgBlX2KXlH21zN8iloZEQN9CHdzJKZx27x+P8avl78eGHQza9hTZ47T5ezVZ8XDgHj3
 QbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872054; x=1739476854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnQh28yKnEDfzPKxdGTxeUvOcx1IudwgVUfrYPpNYMc=;
 b=ecSEJ+ejvpGx4gOhRSszrwjlwzjwxNsgZDlKrI0hJmjmTbY3qc0LK6+kLAC+jWVm3h
 0DDG3tA146DL033l+cTnS1lE8CPIkwJ+EKGGo0bf1eLq92TDFjPgGjhO7iwhtBwl0kiV
 1KsLTJ224K/1zyMIYUx6jz+20gcbXjwiHXrXTiQn90lkfLf0VED5ZWgK87Ap0OabGDh8
 rTGm9vOznQyFf68xQlr5nozM165m01p46NDEST/tUZVYIYPbxANN0qqLxAcctxj12FD9
 QGJxSOgBgrY4/EU473aW5LmH5VFSj8sJxXFIlmQdS/euYybIbpsD10Kwq4KBdLRoxE/z
 fSEA==
X-Gm-Message-State: AOJu0Ywuowynti1UDXeXMAkGEpwZaW6AlrGSlblgjkxiBB4IlpD7I8W3
 WmWe3O34jHl5vAPlgG8TFaXDv+Ws7RdkUb9Hq3ckpw9+HBKb3kiMQTaDtvFpOBYNB/FjijWQEo6
 n
X-Gm-Gg: ASbGncuZWZN/KtPaDgJmkKJfw8vFemyjp3gm5a3ULMP5uf4HkyMxrIhZMRbhps0Sjps
 FQhDqAa2vZQKzagsNGvDV+wy3KQeiYAtt10IPcGLueh0N65NgVgKBpJtFmmPq/q5eL5HX2sjp9X
 fWFDRwkmjVnxf2a/IiO/DJaIxvE5Z53hIVsiqNkJ+LqcXU9gMgfDqgaAzpHxRNJIKGD2DmM6S/O
 Zq/VBYIF2ZwEixyRG76F1XgFs3tIbs5fch4Ze7SRV9vfmLSuXK0rjoGvjbca6FMFRGaNb2uvwY4
 omKOrH69Bof2DmdkEiksloxNO+hZjfFx4DNuAYzS/xLDRyE=
X-Google-Smtp-Source: AGHT+IEDt8B+O1Fys0dL9yVsjqvKtNS4THfNi9nOFNLETqdSWOkmSPPzT9wVZxvKZL8XgfvzDEEwsQ==
X-Received: by 2002:a17:90b:360a:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2fa22b8d188mr772524a91.0.1738872054347; 
 Thu, 06 Feb 2025 12:00:54 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 50/61] target/arm: Implement SME2 FRINTN, FRINTP, FRINTM,
 FRINTA
Date: Thu,  6 Feb 2025 11:57:04 -0800
Message-ID: <20250206195715.2150758-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 9 +++++++++
 target/arm/tcg/sme.decode      | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a993870812..a4c683e12f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1303,3 +1303,12 @@ TRANS_FEAT(SCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_sf)
 TRANS_FEAT(UCVTF, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_gvec_vcvt_uf)
+
+TRANS_FEAT(FRINTN, aa64_sme2, do_zz_fpst, a, float_round_nearest_even,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTP, aa64_sme2, do_zz_fpst, a, float_round_up,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTM, aa64_sme2, do_zz_fpst, a, float_round_down,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
+TRANS_FEAT(FRINTA, aa64_sme2, do_zz_fpst, a, float_round_ties_away,
+           FPST_A64, gen_helper_gvec_vrint_rm_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e2d3668567..dffd4f5ff8 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -750,3 +750,12 @@ SCVTF           11000001 001 00010 111000 ....0 ....0       @zz_2x2
 SCVTF           11000001 001 10010 111000 ...00 ...00       @zz_4x4
 UCVTF           11000001 001 00010 111000 ....1 ....0       @zz_2x2
 UCVTF           11000001 001 10010 111000 ...01 ...00       @zz_4x4
+
+FRINTN          11000001 101 01000 111000 ....0 ....0       @zz_2x2
+FRINTN          11000001 101 11000 111000 ...00 ...00       @zz_4x4
+FRINTP          11000001 101 01001 111000 ....0 ....0       @zz_2x2
+FRINTP          11000001 101 11001 111000 ...00 ...00       @zz_4x4
+FRINTM          11000001 101 01010 111000 ....0 ....0       @zz_2x2
+FRINTM          11000001 101 11010 111000 ...00 ...00       @zz_4x4
+FRINTA          11000001 101 01100 111000 ....0 ....0       @zz_2x2
+FRINTA          11000001 101 11100 111000 ...00 ...00       @zz_4x4
-- 
2.43.0


