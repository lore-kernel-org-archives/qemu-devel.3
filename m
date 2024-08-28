Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5426EC54FC6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxb-0004lT-4r; Wed, 28 Aug 2024 09:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxY-0004aA-8j
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:40 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxW-0002LS-Kt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:40 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5343617fdddso10161062e87.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852616; x=1725457416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TioKTDrezjGBN9Jcmp/sTjzMEyHQIz8aegXHEzpJf9U=;
 b=SkPP/0NWh0ECHQSIp7SMA48UjzmUGJPsQ4RHZ2LG9O1urKGDlVaWWsLfUBkBNoaCNu
 ojRaEx+wGSj7IgqygZmszpmOxx7XeD815PB0eEk3SvZbnTQl2NGkIwFDXzPBm+tp4L9C
 y5jhvWBVQumlmwAyC3om9MpcvkEZmClVytlzvLl6LeKGnQt7vXucAmFhU75JlAg9FASC
 I0T2JnMcV/lgEF9PheSSoRY0JzajHZmvziJSPpdicxcY/oe75PQLhpuG8vATz8WNoZeg
 Vkx7Znj0nf6rv19Jef75iUA/HFvf6FR6dhTMOzIPNPDzLLMxdBirNOlzD1FqQC2a1jP4
 OGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852616; x=1725457416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TioKTDrezjGBN9Jcmp/sTjzMEyHQIz8aegXHEzpJf9U=;
 b=bD8VoAOhZs6e8ZYssu9wcvWSAHA0dW9GEWJYStUXC03nZlkjG+TcykqdeHTu1JwAk1
 CLkjDcJbTqRikeK89Ticup3HNzxldGqB3bBmOInvgCuaGtcn9LWFzeVyQsyGluKiOJf7
 1U0bREzeIbYAPxq/kz6AS295HTeLoVw2TsGgSgIk0+l9/6bPqmPMWZ+EXRyQvHZ/Cyuy
 h5193ubp6VYZuSHrWCu0DCvLHgtY4zDp1U7geoj39DW0WR4b/zSeFJicyc5Nb/b4HTC2
 zJyZx7V9KguNjZt+n6e6ZZS9fAwSRPO9quCjF/QVIyIoiy1wzRrGxlBQBUeJKxx6Xn1P
 cZyQ==
X-Gm-Message-State: AOJu0YwP2Kh2qcm/BXqVxQYkLDzRUAr6KlGdW/84HWw/gV8eCqy8TK2Y
 AwAORzLhdD8WzXbiyHf4U4TkGtec/cr/YSJ8hjbVQYXRxdXrQh5pZlVpWA==
X-Google-Smtp-Source: AGHT+IF6uYwPlwAVSOYp/jnB/u4VZiluvymBfHayhPGIX1WJhZlJmPVjLiWwB4VkBfQ/V1qQzE/FQw==
X-Received: by 2002:a05:6512:10d6:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-5343887e18fmr13902110e87.42.1724852616307; 
 Wed, 28 Aug 2024 06:43:36 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:35 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 7/7] vfio/igd: correctly calculate stolen memory size for
 gen 9 and later
Date: Wed, 28 Aug 2024 15:43:28 +0200
Message-ID: <20240828134328.94528-8-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We have to update the calculation of the stolen memory size because
we've seen devices using values of 0xf0 and above for the graphics mode
select field. The new calculation was taken from the linux kernel [1].

[1] https://github.com/torvalds/linux/blob/7c626ce4bae1ac14f60076d00eafe71af30450ba/arch/x86/kernel/early-quirks.c#L455-L460

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0751c43eae..a95d441f68 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -488,11 +488,18 @@ static int igd_get_stolen_mb(int gen, uint32_t gmch)
         gms = (gmch >> 8) & 0xff;
     }
 
-    if (gms > 0x10) {
-        error_report("Unsupported IGD GMS value 0x%x", gms);
-        return 0;
+    if (gen < 9) {
+        if (gms > 0x10) {
+            error_report("Unsupported IGD GMS value 0x%x", gms);
+            return 0;
+        }
+        return gms * 32;
+    } else {
+        if (gms < 0xf0)
+            return gms * 32;
+        else
+            return gms * 4 + 4;
     }
-    return gms * 32;
 }
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
-- 
2.46.0


