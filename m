Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15816E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN29f-0007uP-Hf; Sun, 15 Dec 2024 22:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29c-0007qN-7x
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:52:20 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN29a-000632-Cd
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:52:19 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e3167b90dso1685317a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321137; x=1734925937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=spFCfWUcYWDptT5OCbNvdDc39rBMG+A8VeYPh7bk8sM=;
 b=o6T8R/u0SYX9j6VftvD4a0HG1uzi8roT4muOadHpQ3487ptSuuJ58X7pgwhvVGliO6
 pzbrdGs21OpyFYkV9eJrbN8kcKQfNxl0298wAjtoIlaCyIfl2GNmAGYz4OfUcI3/xihX
 EDlJ8PPr4IjIy144evqmJbJIZgrc9gbv7+wY6oaiFFeCs425359MUh1mm3ZiLb5hpiwl
 7z5Aw78Rlwk3RFZdjS6Gf6n609u8ceZ3yj066uQHjq4sq/0kLV/X9WlJxuM72GFMA3n5
 /U9fFVVV/1oav4DfhlEm6UTtzm4KDaOA80oy8+vQZ4cB5EZbWhMOpwA5Pin6If563mAL
 ZbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321137; x=1734925937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spFCfWUcYWDptT5OCbNvdDc39rBMG+A8VeYPh7bk8sM=;
 b=m0ANcBLsmD63/IGfyTVRSd9zdKztMg4gTdqHLEv0pq5Llt1f4Hb2/2s8TfIw+Oq2cV
 uqLKW6AVDvdeb/5OmmMQYLFan4MVG/5/mxiIqsv866//dUNTnlKc9TgfLs0umnYpL3em
 30CVSKrPzZRg5zF0A1j+IEDDfNlJEYwHKKYyfvZERYf2eIDT6odmgjCsPtWYoOIkw73F
 Q0iK1Gn68OC8+YNFfiUypESFn4er/lvzojyavkhkbNurbgonBm1SoyAJqa4NPMim+DJL
 bL37XXIP0iuxJwqKoLWXJ+D6NFxG3QSsOyqoMzCzUW4jNkSbGX2+coOJO9C8jr8ERA9a
 574w==
X-Gm-Message-State: AOJu0Yz8qDG9TSm+p0s3WDwmuYdwMAijHXJFqk3HuNAOtFHxWAn70JMj
 XVKdEdNZIa+axSjqGqB4/rKtEj9n25WwXiEjWikei6KlBmN2L8ir4vlxhSCX146SXGMsv35NNLW
 vCql5Nlmp
X-Gm-Gg: ASbGncu1Zp0CnNSEC5G4nMqY0BkLrY9r5CTIeb/6y1CGHfSBLitmb4hOYpqJCGnwSIp
 bRRKZlZACotpXyVHnKn4YTOlAZqSxXfNNXwVhnQdCRE6427MCOYojaPVf9+25iWEMQeACPoyWzR
 Up0hs+GJGEoHWR5obX9ekb30l/LeHQH0TfLfWLxLe48qzF9vwUL0daxicAJy7QlsbUJzQ0Hp7kY
 9gN+I+zL3XcnnbxDpHI6EGQ/IVTvTzBG89BG19d9365drpqOuI8yEubnOImeU2q9Y0aldZ2hu+x
 Bnmm7vF8/7CrUG6ovB1EossRtelKGFdg7s7Q0XdgYAI=
X-Google-Smtp-Source: AGHT+IEsJrzTX1VhrUiBDqfn1Lmz8QomYlOmhgVXcu04eYg6INIRp24v77w9EPuUJgdOij1iDKA2Rg==
X-Received: by 2002:a05:6830:658a:b0:71d:f9f1:7f3a with SMTP id
 46e09a7af769-71e3ba3f255mr4976777a34.24.1734321137307; 
 Sun, 15 Dec 2024 19:52:17 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:52:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/24] hw/core/qdev-properties: Constify Property argument to
 PropertyInfo.print
Date: Sun, 15 Dec 2024 21:51:08 -0600
Message-ID: <20241216035109.3486070-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

There is exactly one instance of this method: print_pci_devfn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-properties.h     | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 447767688b..bf27375a3c 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,7 +34,7 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     bool realized_set_allowed; /* allow setting property on realized device */
-    int (*print)(Object *obj, Property *prop, char *dest, size_t len);
+    int (*print)(Object *obj, const Property *prop, char *dest, size_t len);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
                               const Property *prop);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 22ea1ed358..1034e9b580 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -869,7 +869,7 @@ out:
     visit_end_alternate(v, (void **) &alt);
 }
 
-static int print_pci_devfn(Object *obj, Property *prop, char *dest,
+static int print_pci_devfn(Object *obj, const Property *prop, char *dest,
                            size_t len)
 {
     int32_t *ptr = object_field_prop_ptr(obj, prop);
-- 
2.43.0


