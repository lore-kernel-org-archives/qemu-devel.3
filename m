Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3662C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWT-0004mD-Eb; Wed, 12 Mar 2025 23:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWL-0004iL-Fy
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW7-0007qB-0x
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-219f8263ae0so9608395ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837553; x=1742442353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cK/VzX5+27up7sPHovhu1C3y4s6cAm//kFke6QWtfCA=;
 b=umdgWDlRG+qrrszkBxR/iUUadNR6oX3XdoojGmN+376NTqf4QhnI1vBrv1nXKSS2Q2
 uf5ttV+qUiQVrJle82NVvBLz/GKjuuWHbRE2zGMtjC2gdF2P5DuRn0tiavCkJNgi75ps
 0eKAKDJWtUedFU2DevfBrJmIqCE+gfU6asxNrh5A2n+uImLXyPWy2nO4B/+S6ajBb15O
 mnMRDY/ZDHrSA0x8bXYKDVsATcWcL4LVsA5ETInEm+3kIf9dD9l0hNgyvljZ6Tya9hiH
 M+KBWED2nyZRAtdhPRfAEUzcw3ecIc8qe4Uw9bi8EsMx0V2sk1JiAIDab8Bi0dM5gPy5
 ooSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837553; x=1742442353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cK/VzX5+27up7sPHovhu1C3y4s6cAm//kFke6QWtfCA=;
 b=FIr8J7H8hq5PTvfdKpmV8nvW44Tw96tO9BJz+nKvmnr7v6daEco9k253671lGoTsYx
 s4N4GC0UNoxDzOlsOSOYLNldB7WzOhKo3lPV3jKEKngKbr85Hd7kt6AW4oDzmSqnt+R5
 EjjyjilfjaE1SbliH0juesV81DolhWDF/GIyVdaNFXDKaUaY2eWEqOKvgvgfw8Nez81m
 AhCWVTO2kzFLUmgXp0LLrRJItLysZr6r6aUsx0vl6FenYE9frrHYhU7O++Rsuj8MJdPQ
 /0rKCNhP005f8mxGlOyNK6mpjMkYD/a0IA3el6Lxw1tooqBN7JRMYuNzo9y1tAZkOmFB
 4s9A==
X-Gm-Message-State: AOJu0Ywwt8zJD4at5O1cdhlg2zqYtVNQlSDIJwiqG1hvdspcbyrhWO+8
 dp6RdTqv+LGxjERoztQznS3yRKiSWS38CswktmULPP7kskHFj3IkE/41FGsw7zfmjzqSwrLzck8
 U
X-Gm-Gg: ASbGncu8G059ZnKgQ3whovfo0B7wKXCBvsbi0gemN3t8REpFxjPKO+BLkoAiO8N8W+Y
 u/lpXHtU1e4pVH5YRQIPaTFeGSWCHMBh0xm7EY0WePARmEczKHYAGVxKNgF/Ae5caCuBKjyZU6l
 4IsuNgq8/Dg4XX6+hFQ3fzjlaAognp6IvPQINEuAiGv3rood5/1wnw5k1WEvACy1GlJlUGe184k
 RIVnZ3RRuKolNL5tI6BnSEuwzH2XcjJD37pe11ztGONiiA7g0nbMBLR22s/SIvlagZA6dnBY/7H
 AYvUzoz/XzT91FsTinSq2lILsVybgP4Qn9jRLiHNnqUykF5HjwmUoJD9jIx+Rt5TmpUl6wEldTI
 FPc8Ii968OsQ=
X-Google-Smtp-Source: AGHT+IEAQCW3BsFe8Fe/PRPzRrUTmeY5wtBpG7UqN4EVl16KzHyc9gOfWxUG1oJT8L1XeCpIr58V3g==
X-Received: by 2002:a05:6a20:c6c1:b0:1f5:59e5:8ad2 with SMTP id
 adf61e73a8af0-1f58cb40fa8mr15841909637.24.1741837552982; 
 Wed, 12 Mar 2025 20:45:52 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 33/37] include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in
 css.h
Date: Wed, 12 Mar 2025 20:45:13 -0700
Message-ID: <20250313034524.3069690-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/s390x/css.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index cd97e2b707..965545ce73 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -238,7 +238,6 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
 
-#ifndef CONFIG_USER_ONLY
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
@@ -262,7 +261,6 @@ int css_enable_mss(void);
 IOInstEnding css_do_rsch(SubchDev *sch);
 int css_do_rchp(uint8_t cssid, uint8_t chpid);
 bool css_present(uint8_t cssid);
-#endif
 
 extern const PropertyInfo css_devid_ro_propinfo;
 
-- 
2.43.0


