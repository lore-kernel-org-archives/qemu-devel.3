Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCB2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lKX-0003EM-O6; Tue, 14 Oct 2025 16:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lKP-00032X-Jl
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:09:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJE-0005Rs-Tw
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:09:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27d3540a43fso56645995ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472465; x=1761077265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvgyMGsMGCO23ydvUvmFS9TDLif2EzsiRI0mh1tWq9w=;
 b=nPYPsRamvZ8hlVtY2m+B5XLaXGgIoVfAjbvi4xYx6Z5G578qQTV7YBoonx3RZ7vKLa
 eVJAfavytHG20o+5831rBXlRC95+Zftlr5fefO7pMzNpdqzZh/qvDsUfhi96qQwD6Caq
 BfFbm7anAzRZOtqMZcQN3AW3zbTOwtkPFudTQvI5dtNmwGBvI8TF3yRhV1+I866S1AFE
 dmxhb21efoufROn1TJIZV+h7dEAv8Myhz8Zjcdq+bwmoZ+X8RqpFLpWhZv82a3dPnxgb
 f2pS5/ObLZWtuiwIyEE42XYw4dmlrmPJ85748/KNhDaOEE04OUzmgyxt1/r6ckdI+LAT
 qU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472465; x=1761077265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvgyMGsMGCO23ydvUvmFS9TDLif2EzsiRI0mh1tWq9w=;
 b=rq+cs/zVeVFAZD55Gr94Xy9Gt4eWTxB7Z25iiMJwoFet+c1eTwGxV6ag6qKtObdj90
 waxvmViUbwIZJjwYFxCFKgBEldpTAnUvF+7UHn7dWBZRbud4mqieyw9ypwD3WeHG3aLY
 JxocWfmscEo14FyKJ1sDtdqfNO8szRj7UXO0uZuVgKCPs10oTweMTW0XN4XLw/JeXYKy
 A/d4e5NZSzSTwausdM2nJiIvV2bIO5ovp7kUIF7tdaepMF81sB4MeNTpJBabxsJWUixx
 gRwBv1LDjWeoyElWQqcUQ0rQiQxxwS8+ElpJyMCBkqNDxSTPS6ptYpaf3PNz3HIAr1G6
 2G9Q==
X-Gm-Message-State: AOJu0YzUjdLOj6eaeBn2hK5xcRlv4309UP4ZjwuTUf8SES4u9g5WiufU
 SUjdysel3WDroxbg1d9JANq6QV167oryKWQIEGLpd7KGjY6PD1i9aKGRuI3rEmO7K34Uw80xCUQ
 Zkwieqow=
X-Gm-Gg: ASbGncvzu/KssmaFnBIXX92sNKBWU1byxxDDK9ObyFN5AlHfaH7tEWflGmRkljEdVL1
 j7vBS3EsWc0uLAwZc1bbUfxoqiChEQUDgRn15w1okpjeKNWhlrAVq3bL6FR17wVdq9w3elx22ff
 LcDPclpssxLje/2E1Ccb/yrUA4nr91Fplvw0vGH+ij3v92+X29tApjzn7uN1ntB7eollExLaVaW
 dv4TQyyQh7w9S/hOjras9IuEWNhgV24UcRipAz8aKJNkMCE6enrq4N/GHv6ZLX3+7Dehy25uRa6
 fmfYJINJ1zI3ikitr93dw3p8XQZMahwms15NvwX5Ui1iPjg8G2DgIR+m5laObKE0zK9W0MTk9RC
 3/pfcmWjMI3HoM7JxRR5sigDIFakRFx70/qSnXacMuRB0M70Vjcg=
X-Google-Smtp-Source: AGHT+IGVUSlOtmXSrAxpQFUx/nQbqRv0knhx1iUsgwfzkGZuiIlN6uD8MrHUMp+SW/2gAqy1lODlWg==
X-Received: by 2002:a17:902:e943:b0:264:f714:8dce with SMTP id
 d9443c01a7336-290272c2542mr318983735ad.36.1760472465174; 
 Tue, 14 Oct 2025 13:07:45 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 37/37] NOTFORMERGE: Enable FEAT_SYSREG128,
 FEAT_SYSINSTR128 for cpu max
Date: Tue, 14 Oct 2025 13:07:18 -0700
Message-ID: <20251014200718.422022-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Do not merge yet, because both of these are enabled
if and only if FEAT_D128 is also enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..058d5c0ec1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1254,6 +1254,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
+    t = FIELD_DP64(t, ID_AA64ISAR2, SYSREG_128, 1);   /* FEAT_SYSREG128 */
+    t = FIELD_DP64(t, ID_AA64ISAR2, SYSINSTR_128, 1); /* FEAT_SYSINSTR128 */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
-- 
2.43.0


