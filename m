Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAE0CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MwN-00029J-TF; Thu, 16 Oct 2025 08:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwG-000262-PH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwA-0008RV-9H
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so428927f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617106; x=1761221906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VQ2Gd5+2h6IYgns+2XMmOdyOU9XnsS3HXby7kOkNXdo=;
 b=Q6FrJg61sl+tzoHEJCzu3DXZKqYH8iDN2yWI9pbmHIAjOhjFBr/a7wmFJEMEqHwWJ1
 volQkGYW8F8T/Fc9IGUb8QDouKkd1BlboTgQWdt2WZ3vX/Yfk2ROxHMvGN7QhdLm0rKW
 txwX3RUf9mc6J4S4EBmk3HOscG1ffSrtaEGoXRRTUcDdiFRDtM+WtQD79bNCaEQcAbSj
 +q1V3BkkEwcT0JVuBQZXpcKOPdGFMk5PaR5olCbcMxCpL88kJ1gNLRVDAAiYqrrfRZ01
 KHuxRUDeIX/5qK97bqrn1cYuvesbqpb0RQ1Hex+wnIJth5hbMJnKK2AOlPtOZEBrOKA1
 +9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617106; x=1761221906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQ2Gd5+2h6IYgns+2XMmOdyOU9XnsS3HXby7kOkNXdo=;
 b=FkuUv94amYs+I6Xe6SAp1+LJYkZuiLC6OjNmb0fV4q9Ozd+Gu43t7BOIfqPSyO+8Jj
 Yoe11klf2BTfz35JrTvwAxO8UsJ70KIHeervsQBMcaREtXA+DNwTqej5vS3uxLXzVzvo
 vNACiIJ+kyJB/enVVsJLds8o+zgJnyNq0NvMEnI8AlqUx+Gtqvj2RpJqE8LXmmeq8WaM
 wI9i7MxjvVCCB24VOzGHLrfrScdHiLrZT/KRZ3y5VrhJ4o3yFM51Lm2oapQTfhsP+LEi
 gPhVARvUT+tVTeMvL750JkTEdTyAaMCXTcR8KRPtmt8mgu2TXxjiKQ9lcsc2gIEW9pif
 v4pw==
X-Gm-Message-State: AOJu0YxrHQXe507uCaEUHgWklfPXcc4AloSccTLzcAuGGGvAfecnUtc+
 fhMxUbS5xYMeZz3UYyOW7x+ve6l3tgZUOUIqVWuqbb4b90u0qvxfW0IbbI04338wM72bqDeAD3o
 aMB0HMs0=
X-Gm-Gg: ASbGnctqDVVaNdqVYYGjw1HPCgtejtWqt/uwJ0OyL3fimrWQScfk6dvzz/4m3M9znv9
 3VRNpxdi/wHvMLKrThfD8Yjedf6NAi3k9cursbxYP1v2Epz3aWSF5q2kdWQ3CT9nGc2fXhDE06O
 H/4xlYlE/UO9fm4s/FcFJqIWvVN6eIaJls9WxF5+LoNCPOqSM9Xml0Xw1pMaapuiasQaz4nxqDG
 3tMb2aloW077j8E4fDWriIwLRMcOrqdnEFWrwPqEEAu7o291cO+m8LvgT9lvP9VT2JHdcVP43vQ
 4d2XavRpA7WyZcOl6paGo+5K+3Z3PGUzfQ7cC0Nw6Regq4aJyq/FtCY8HAPa8VGmM8IIA94P9u+
 LuLAFVZKobO6fr9Ne7jTas1CIjNASVdYHljy9DZ3NYftRcCnFWuewteftbZwHOc33PkYEYH1xVY
 mNWqusnMn6CxPziqlVfb0xF2vCt5Mi+/7qvhdJch9dWxKq65VGpAcohsL5XN7zd6tC
X-Google-Smtp-Source: AGHT+IGtKFk982d94/g2zuIvTp969mKJfHlC4f3vxKfMMUZLU4USEFX9j+iE5sxyD3ubH9IgYGyIQg==
X-Received: by 2002:a05:6000:2287:b0:425:7e33:b4a9 with SMTP id
 ffacd0b85a97d-42704a62705mr31853f8f.0.1760617106356; 
 Thu, 16 Oct 2025 05:18:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d404sm34778799f8f.3.2025.10.16.05.18.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/75] target/openrisc: Replace MO_TE -> MO_BE
Date: Thu, 16 Oct 2025 14:14:53 +0200
Message-ID: <20251016121532.14042-38-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

We only build the OpenRISC targets using big endianness order:

  $ git grep TARGET_BIG_ENDIAN configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:2:TARGET_BIG_ENDIAN=y
  configs/targets/or1k-softmmu.mak:2:TARGET_BIG_ENDIAN=y

Therefore the MO_TE definition always expands to MO_BE. Use the
latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-12-philmd@linaro.org>
---
 target/openrisc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 1a43e5ab6f7..3d9dfd663aa 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -61,7 +61,8 @@ typedef struct DisasContext {
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    /* The SR_LEE bit sets the (little) endianness, but we don't implement it. */
+    return MO_BE;
 }
 
 static inline bool is_user(DisasContext *dc)
-- 
2.51.0


