Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E76FC7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 21:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTSLP-0007SF-E5; Sun, 22 Jun 2025 17:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLL-0007Qh-EN
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:15 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLI-00058v-P2
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2598659b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750628110; x=1751232910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=25BK3mEW4G1zMeuhH0wNV8gaIgnu+hHyrT3N/EdWX7c=;
 b=BHlh2FwPIExKCtw4oC2Afb3P+BSnnbPTJAAt7TTnl8UWX6FFSNqDJUYgJ6LXYYigj3
 7V7AUMP2Gc3hR3YTiwuGCEhJiX81XgP5VRO/B/cNdvTURgarTD0fHgZ6vcLhsDnbYZ72
 iQd/sNLx6HYMoa/uoPMoISfs+iSOdnCBBGYCAr3nNCN/jDnuWsiZXaewAzu04YEa1o2E
 ZCyrYBjfPERACRUvJ9yDL7v29bXxAKMWidnZzmfsmk+HhhjagMmk/gb6N6e12hzr3dBd
 zdb5hdOGmUlMEzO7SISc8NvJHRKb306XXRk832OqYEtGkOr9rQ/Ag5pKfLVxyQsDeCpv
 NEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750628110; x=1751232910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=25BK3mEW4G1zMeuhH0wNV8gaIgnu+hHyrT3N/EdWX7c=;
 b=Cw1ic+HBQmMEqWUzNOSKj6pd8ASRzQ6GZ9TWRTvL0MrE86Y+2o/TNo7nGgDlmub0ni
 vYxz5t9aRiyEbkVQd2Rz+RwYsrur8Ik5xQ28gem1TelgJUWrzk4bX1aLufSaSUF0NDF4
 qMkm9Zho6wTzPoi/udqX1tSAn/ahHTW8PKyoTsLHEbZG6aNR3Ul934gF++qaMbJkpmUJ
 +pJ5sHFUaH09oB8jXvaXDbkf0ANFRhS8/khTgm3xy9yyWKLc09PHjPemGDJuQHq7fMTP
 olgwo8imMfeDbshe8KuMbgMFybur3jD6YSfJylnHc0E/9Qn+NrnFscIzVeLDyjnFNoKH
 4DFw==
X-Gm-Message-State: AOJu0YyVPE68aJPK8oyMwi/orXbrzxeLIMPMPhXxchpToq26orj8mZsn
 NKYBelZaPeLyYnGUqqFawPrHDDPIjV4J2jLGSVecOPdXZwazAD/PYi5K/CZUyQAP9WQjcksMEvn
 VC5ssYec=
X-Gm-Gg: ASbGncuQNT1F2uanfPbpjpovtLSZaUtCB3aZP/lL3PJP3SBeVfncX3mGeAU/pOSUJQ1
 kGblfN3b6VDuIxEdfEB1gbnpaTzriVLXZ+C9UCeCRFox/hU5QrOx3TNMcWQU3VBKp1V+eL6G7N6
 BJF07KTVDugvvHnBZyezyFZ/jU/Cw1LjZq0EDbuwRuh5lUxUFnqRxyWgBsZ7XJHPIbCFwrx+Ogp
 R7wWIKGTaww4t/jwFHeSlfdn9vxiNPBemSt++6O14OqZTS7gesV1quPcvCIcRjV0N5o4i8rZ4pW
 G+CGZsPuWZDWxETbV8EcqQOA8wM1ij2H0MjC/ELjaJLRofNx4SpTay+6s9vCIjyOt2VLUpFQQYo
 NSH8pUShJt7DiGNz1jpvoZLmecwWGKSc=
X-Google-Smtp-Source: AGHT+IH2qUEjebEvxrOBnyk06GyAxYJR+VGzraBJx61kdwNBUGRd3tqJRHhUxCNQboswZWv0daY9iA==
X-Received: by 2002:a05:6a00:1393:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-7490f592146mr13183697b3a.12.1750628110327; 
 Sun, 22 Jun 2025 14:35:10 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a69f3e2sm6479842b3a.159.2025.06.22.14.35.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 14:35:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/arm: SME1/SVE2 fixes
Date: Sun, 22 Jun 2025 14:35:06 -0700
Message-ID: <20250622213509.277798-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Supercedes: 20250622175052.180728-1-richard.henderson@linaro.org
("target/arm: Fix SME vs AdvSIMD exception priority")

A couple of fixes for EC_SMETRAP, plus some insns that missed
being updated for non-streaming.


r~


Richard Henderson (3):
  target/arm: Fix SME vs AdvSIMD exception priority
  target/arm: Fix sve_access_check for SME
  target/arm: Fix 128-bit element ZIP, UZP, TRN

 target/arm/tcg/translate-a64.c | 30 +++++++++++++++++-------
 target/arm/tcg/translate-sve.c | 43 ++++++++++++++++++++++++----------
 2 files changed, 51 insertions(+), 22 deletions(-)

-- 
2.43.0


