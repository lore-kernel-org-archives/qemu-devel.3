Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA90CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 01:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKoF9-000311-A3; Sun, 16 Nov 2025 20:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEY-0002VD-HN
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:48 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEV-0005wr-Jg
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:45 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8824888ce97so58076126d6.2
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 17:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763343642; x=1763948442; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m2A5GWnHOQC8XSLxxTgeSs8GTkOh183X479Ep5HPGBQ=;
 b=m2ifpCDp/dAbLCxqeVN7URcvZXVFtVPg251V4P+UgUi0ZTEk4S66BNkNciyGT71TcN
 t3BcMDW7ONtdgUDjfT+qdoddzYIV+3uLll60qVWXvNx1GTLBJKhCaCG2ejEs0YOKQQZd
 hYRePwcTTCiwC26w52kKccGlZVjwbG5j/43GwBZQEeiDaUeFMjPWukt61VFVz063Fo1e
 LmKUe5ysg8nXPNIRyvqO/IonxdKNbkZLViSrWdpiIhD1O2iC2aYzyVVlk+GN4PvCQ4h3
 IO0GzOD8fWX0C0vB9npfs0fWI6KJlwd/rYT3FDJKI/ewDYXz05tvvtP60u0asOA2HE76
 c0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763343642; x=1763948442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m2A5GWnHOQC8XSLxxTgeSs8GTkOh183X479Ep5HPGBQ=;
 b=fIAXYVTE0AzpJnnl5dUqbF9mjks6l4iHdRoaKpcwYOnG2/Zr7FAJMSjR8GVbo32AQL
 K2kZG1TPkD/caWxZg9IjZGCIELMh6REb40aui9u6dOXPnw1GsqqVc+ZerUpYL5DQG7Q/
 qzQ7d6Sal1FT4hgouCF+L6NQCQ2NhkU6dOciukp2YXRE2tuIVAzt/0Djsv2c+8sZeDHk
 /anDaXhHXZvIOEZgtPcvdp/drO4VQ5XeTSG0IywWgrVPOCkblZHK24ygsbzTa1XBduBQ
 8Z+JZM48CA+kFSKzuQnXoMiKP9p/YX/XyqQqcRoxVyGr0b/AYi9RPomWOEcS3EUzgF1K
 RVDg==
X-Gm-Message-State: AOJu0YytFdLDYZqWSHzxEQ7D+ZZHyhvCTd9XixWAADEMrMzWy9Ef6ZDW
 KKKnYSJgV74oiuuw2KqmRuSkjEx2yU5sH4ekFAbLT4CZzEmFL9FRhGmT
X-Gm-Gg: ASbGnctNxPJ8rdrwtj03f7W0NmcXh8+/kqdzXGwH/kFBU64ua/MOqrfoZIlA/Qx0uQe
 oTd5Ie0T9SfUSR/N12l0JNSm7Xdya2VKOmCy/2+TlUAI7vXjODHH35jgpSeC/pU+sh90fstraJd
 AEgqm/WcBYAEbcE3dddsxoLvpugxjGwtNb71lyJvhFXlIzy3qZfVXakAxRh+yk5YdGt6RlbIuSg
 NH2FlCDT1wwAbSo1Y0JbAUSHZbHwdlViJTMNf0eYz1dCsUVmbfDMDHSvAAPeYHSePg20A14yO/y
 Tk4KcskUB6iNxB3o7lBVR6ZaWhF3MLvo4CdXKz5nIrKKZ+4TQoqgIWb+qR9GLqNDseHLjd0cEHh
 1FGYPZ/FEDa+umQgPOgzSvwwynprlcj3FeM3qJS8jL91k3Q7DqHjw+At1u9A9IxhSgRRIOaDT6t
 y4y5/HurLjgBbPy/12PoY=
X-Google-Smtp-Source: AGHT+IHvgumXTfQ60PCLEj6Zwrc4I3xFmLGgf/blQagn4A1FwGjDEaJ9YxsCKNwx28ro1x3iLOyZLg==
X-Received: by 2002:a05:6214:234e:b0:880:4ec0:417a with SMTP id
 6a1803df08f44-8829272618dmr159798076d6.55.1763343642435; 
 Sun, 16 Nov 2025 17:40:42 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm18246551cf.30.2025.11.16.17.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 17:40:41 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Sun, 16 Nov 2025 20:40:18 -0500
Subject: [PATCH RFC v2 01/10] target/arm: explicitly disable MTE4 for max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-feat-mte4-v2-1-9a7122b7fa76@gmail.com>
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
In-Reply-To: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763343639; l=1507;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=c/+Syb9Ieiqx7Vbsr+h6scCyHLibAd0uOiBYc91rJtI=;
 b=hQKZNO43Xtn9ZcbpMlL1tpg6a4d4xomBYBOZ5sYwmU1KutGQXbK6MrD05ya6PBnL6h9rLI4gf
 yQh6iu2WvaWD2x0OJ0PhihYbfJU9Qiyz39TVDXf2F9UmPTMdX7/Px/+
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Previously, the bits used to advertise the various MTE4 features were
not explicitly set for -cpu max. This commit calls out these bits and
explicitly unsets them. At the end of the patch series, a second commit
will explicitly set all of them.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..ca9557f4cf 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1281,8 +1281,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
+    t = FIELD_DP64(t, ID_AA64PFR1,
+            MTEX, 0);   /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 0);    /* FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 0);   /* FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 0);    /* FEAT_MTE_PERM */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */

-- 
2.51.2


