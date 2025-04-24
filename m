Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03715C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ks2-0007eF-R6; Wed, 23 Apr 2025 20:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00014h-2Z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq7-0004i7-Sr
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:21 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-ae727e87c26so226500a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455998; x=1746060798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJ2cS34T9TygiGdt7kSeE7/VKgkXyAOO0ltlqEGVaUs=;
 b=Ev8jWi8BxL9FDPKwhJqZQKemBKUwl078+877o7P3B8Wl4vgB4zVGAu2qReAeFZwh59
 uMZz3uXRCimCvJgnA7YbHEp2/zFyIhRew+T7Ufpk1kKGMtni7NVDJdDUS7RhK4xQvYDE
 ZiROG5roEIgJuoMjw+S2kSCQh+7mtiaHfC07SmpxrCx5nsL+1rdhhbaiPmsGNlBPuehR
 Hl3yNubqWHmNUDWk7aqGp2LTzM0qcVgwzZG+SEhylA3R5gQ/mT8ZyPEDMXl5z+mHOT4P
 7J+ZyQbZThM3iof9rh/MwC6gOYbWSSGJSnj+YZQXJOB4z1dnyGs0aw4oEd3EKv7lxILY
 C5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455998; x=1746060798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJ2cS34T9TygiGdt7kSeE7/VKgkXyAOO0ltlqEGVaUs=;
 b=ZGFtb6BOwei/p94QE6cUiu+a1FT5DsjpXBNXI9hNH6LAebBi4ydidhC7RL/d80Cum/
 NugMm2+noj1TzDe7HSeto7MMUUTErdbadnbJWY9fZe875hVmhKeYlUAw7/OIh0qiUJ7z
 IpKcufaenrxZHdiYsyH2CzA/INlMEgah6G9fcUnepHR0v/Hesr70dq/aUcwbtcyvlQxu
 WgQ4+tCRwpYfLST0s8y0rLD7nBRffp76u+RcKncV7eO1kfXQPJavzDtWEszyL5rAKbfz
 jNqaIokEwzU+tAGoO7GNnl5EsM6qQHmsaZ1p6i9g71HHKjOmdg72saD4ZIRA1fgNGQjW
 mvkw==
X-Gm-Message-State: AOJu0Yz4OLnzLZlzuAbdGU1Y1VLbVb9H0Lmey3vkBflzFJ+lpLepi1Y7
 0vb9FB7eM39kRXyR0G0Mry4wXauENCRqK7iIhMVImsVgsYI2ji3uHMHSeEgHUTh/jF+zDokmDOd
 i
X-Gm-Gg: ASbGncufqES+fNavNAMsF7XeL3bY7l3Re/6BTaqyFxgkV+LF/MDEkflnGsADgQgHEEt
 H6LJKti/GW/tzLT9d/D2IQqRG3f5tmaauq7PAjfelctPGHB4J58qZxu8L9+zKdCMZOwJBO5PZ/j
 q/r725L5ZW5n/KBeTLE9ZMzkPJrQ4PV9Ja7dvVxwqj/L3g+NqnbosJSPeGdOboqOr8kJABmikjC
 Bt7KGT8QTYMNTegi1Q2w8Qvkgeb39E+F7RtaywuNN/AYtUkLfFLC3HwWQ08dPxzOtmnfy6b+scx
 klXCc4Dt+Yx6+cwaPqekZWXDZU7xV6wEth8/305oKWry4jWhK73kDPXonQfm0shOBknsQZ6i4Tw
 =
X-Google-Smtp-Source: AGHT+IGDEVjf3Mwpinhph1f/TbmTJpuJy/LY1Ul+492dzxRTM+iZxpcf/vus2RNcP2w2ZQehavn0Tw==
X-Received: by 2002:a05:6a21:78a5:b0:1f5:7c6f:6c8a with SMTP id
 adf61e73a8af0-20444f4142dmr784541637.35.1745455998096; 
 Wed, 23 Apr 2025 17:53:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 055/148] include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in
 css.h
Date: Wed, 23 Apr 2025 17:48:00 -0700
Message-ID: <20250424004934.598783-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
index dbf919bdd2..0b0400a9d4 100644
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


