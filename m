Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2CEC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZi-00043K-CV; Tue, 18 Mar 2025 17:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueYA-0001NI-Iv
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:39 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY9-0000r8-3K
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:38 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223fb0f619dso104391975ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333556; x=1742938356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoCYXpmxTadp3XapZ6TJFD3hsb+jhxzWsNPz+aVP0mI=;
 b=n2ypuDcQ/YTKF8rBzdJBaRpigsUjrWvu9wtDRfZMRF7DYvW8ErzJ656qKBWI9rvsd+
 u/86nihvF5p54YZYOvbM6p9xECg3Ls2h5hA4JgsGJLHBI+8RJ/7+myiOxtoShDUbx7s2
 0p/phlOKxh1yQa3Rpe+j7X+EGwXlMPy64O0J34t8QOXB3uBbVL0B88TgQHY47AcadnaG
 3lYH6mfYf+s+l0LLOzZYWqpD1wE60BPb1OqkJ+RkOOmFOHSTE2fyZfB04z13b0m51Y0g
 QQhglOg4A6tOuFHSNYKf5NfJdceLesz/RnGst7q2xxsjNUw6WrVatYy9oSmd8MXkAioZ
 PXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333556; x=1742938356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BoCYXpmxTadp3XapZ6TJFD3hsb+jhxzWsNPz+aVP0mI=;
 b=rIIuSXKQhZAvlIE2hruhm3NoINEayW83aaMKX+pc9LLG0cCRza9T+xn9WyxvwJY4LP
 1JnFhCjlu254B4UYkbxZfj9mIWrTJH8b0x9rp+wxB3QmdbKv3XtQFDDw3y8erwrNpMQp
 0k0ISZA6SALwpFymkNu7tzOkqAH6KW4LH9cPYMcE17pXS+a61mUK0qcMCO/A2dSzhQ/Q
 18Pn3bA2kI+uauoNgiYu8u30fFE1shaL4Z8wuHlDa6RkNWJkaEDJS+hZNKcWIl4TZMGA
 /ZLZ655wea6UeSkj4q7VTcSyIivnoQoDDbu9RuvoxUl9kteYX9f7E5kFwcFXFncOhG3x
 BCfw==
X-Gm-Message-State: AOJu0YwR2mex6JkL6LncI7+mYTwwefbndsPshxHNSoeK1YEHL7W4ahQ+
 FQe+QQZfCiF4FZcqLDS0rrwufDixiguXd0VfdoKSdhUh9a1ctRXoNVJBYnMnMt96grLq7tUJrda
 J
X-Gm-Gg: ASbGnct/IcaaHviV9/qJ3/1e3pcuaHMck3PG8GzKiejbhVjb8KcO8UKSiW2GsBB1QLd
 UVb6TvVj0sZn+R9RETsMNldQCCzexD2Yw8LtN3yqZTINYfibjCy+rSB7q6QgltTPmIkc3EsmaiS
 RcOQ202nuv8NWaXPhlKTNuLRSLytakEI3Soa7b4SfF5F9ujpzieC1a1zNb3TdztKT5XY86BQs7U
 vAV7Nwyk3QyxAcFil3PMNo3h4mRxrbfbVEkFMB9lZqn2xHLriY6HqA/HFlWKk//i4qbtz4Pd1mf
 YmMIbkP/i4Os13LSPwSO0UhnivX+h3Q14upbZlBXoLnkUdy1M/M8Z1u/ikZ83nkhELgwN6qN43J
 +f3dCB4wcdNc=
X-Google-Smtp-Source: AGHT+IGGXV0hQ+jNfIB45E9pZx0JCYvDDd+C168JazbGPvrPtoX/sOCaGEnewfeRvERQxOKyWmNm+Q==
X-Received: by 2002:a17:90b:3cd0:b0:2fe:8217:2da6 with SMTP id
 98e67ed59e1d1-301be1e72f6mr261005a91.22.1742333555786; 
 Tue, 18 Mar 2025 14:32:35 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 36/42] include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in
 css.h
Date: Tue, 18 Mar 2025 14:32:01 -0700
Message-ID: <20250318213209.2579218-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


