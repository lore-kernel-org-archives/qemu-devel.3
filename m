Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1807CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DPX-0002Nw-9p; Fri, 10 Oct 2025 09:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DPA-0002GQ-By
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOk-0007uR-0t
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso11553165e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103771; x=1760708571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glWOQWNC3/3zXE9lsfJz0FVW5jre8WEcmZkI6CO0cfo=;
 b=EFzhVWxfOGOZcgMwM9IZKXokT9pM8ZaxsVx0y+xggG2iFyg4aIEDYLSDcVU5g7sF52
 uZr8q+j/itYmHi7aKYu5K87C/zW0lFN6RBeXgqDhTF/OLwr8akBkRU2lHl4xnDM+16RE
 ehieUmfoPZN94sO0dQHUSoxndbq61L6TcyHJxWN6wyxOOJIChDbzcVsvC9VfDvKhBOPB
 hk+oXPpX8ZFPD61JYAvMKL2EOoTgxivzlk6FBvmTXGbpr3gidJwL74j8/TdmpKTXNwws
 0CJEVofJQBj9DmkGmaC4KOYizzWRg2uZfbULufQSticK0ufTM0+OPvOX6px4IEPGOArc
 fx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103771; x=1760708571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glWOQWNC3/3zXE9lsfJz0FVW5jre8WEcmZkI6CO0cfo=;
 b=ctdzfB03mgGBLfCRVcpVUumhpk4h7Y9MIY7bCVnxNCG0CpcxcxfWTR12dWFnDgJamU
 fCqFCCFnB+R4Uc3V/9X0eFJZ6ndBXUo+gl0kiJLJXS0NpCroOVb1sUBltYOc34/rfJVS
 iOJVsnkT6botwUMTl0DBtExilabdhLlsKP8G/hIAXGYS/AZewj3GrF5jHky/39In2jCs
 cdsPf4T0vG00OAU/9Q+VhhqviycE/S1+cI9rYLKZsuc3B336F81wEWL6V29s77Z6npwN
 MWffN/vWX/EaXQ54Hz9toFEzkDkikWkFZshMkcpUlLZ3FbNHSKlyuyTTfQGhL5e1vfVC
 zJjQ==
X-Gm-Message-State: AOJu0YzFlX3Ri8O6+8D0zhwX+Nn7rA0CDG4M1pT+qCfrzPDVoVWzKYJB
 NFD5z7RbM2+k4vcOEXwBeCd79N3SCuAqrb5U8yEK81Ln1mssfpxqVD63Z/Qc0GctJDUnferqNWz
 6NrqoqNo/1Q==
X-Gm-Gg: ASbGncv4dCJxW+gdfmGiSFP8kCPlWDYaHgsySACWqkALyxZ7AAMheA+L/G5ypZy1Pn2
 VCiqV0P0yuR49SfYfkgFGRv8WXE6Zg6ovzTXd/TNashQtA2di8zKQhABE95XegRQSHcKh2F+uCA
 qy5ePQEtQZvUXGiPXQT9vHW2i22JSnIrszjQbG9M1ArGS8oYdwZR5OlsPxY6AMxfNlb8lKv20ZJ
 8dV0pkZhjm8PiQjdFEF1vvJfk+d9dv9VJW9Oa58LwQToC0GBTmLXVIO1bBeZq4cdY0o3zAiDdum
 rp9vezPD56ZYr5e+ftie9Klul4Krwf1vYBKnFUqL8XQ0StGhZYKXON/j6ZPCNS3oZOSCU/j3yaU
 Lrv1Pkqv39QD7W4TRnOGyDMNiyuuwcg1kPlYj7yF+UrRdZ7EIB9Mf2YY7Sb4moGcuNTvlZ7XU5M
 Tgcy3KykYSfvgsnUUypsU=
X-Google-Smtp-Source: AGHT+IFj/ht5sl+sluGOMrkKYrfsxcYSRA4eSOSl5wJQr2sAZXH/Rlebae2Q4vcDEqBBJVKVMRb4Fw==
X-Received: by 2002:a05:600c:1e86:b0:46e:4784:cdf5 with SMTP id
 5b1f17b1804b1-46fa9a9f254mr89740875e9.15.1760103770793; 
 Fri, 10 Oct 2025 06:42:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm4250770f8f.37.2025.10.10.06.42.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:42:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 04/16] net: Replace HOST_BIG_ENDIAN #ifdef with runtime if()
 check
Date: Fri, 10 Oct 2025 15:42:13 +0200
Message-ID: <20251010134226.72221-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/net.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/net.c b/net/net.c
index 27e0d278071..11d1f7616a6 100644
--- a/net/net.c
+++ b/net/net.c
@@ -593,28 +593,26 @@ bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types)
 
 int qemu_set_vnet_le(NetClientState *nc, bool is_le)
 {
-#if HOST_BIG_ENDIAN
+    if (!HOST_BIG_ENDIAN) {
+        return 0;
+    }
     if (!nc || !nc->info->set_vnet_le) {
         return -ENOSYS;
     }
 
     return nc->info->set_vnet_le(nc, is_le);
-#else
-    return 0;
-#endif
 }
 
 int qemu_set_vnet_be(NetClientState *nc, bool is_be)
 {
-#if HOST_BIG_ENDIAN
-    return 0;
-#else
+    if (HOST_BIG_ENDIAN) {
+        return 0;
+    }
     if (!nc || !nc->info->set_vnet_be) {
         return -ENOSYS;
     }
 
     return nc->info->set_vnet_be(nc, is_be);
-#endif
 }
 
 int qemu_can_receive_packet(NetClientState *nc)
-- 
2.51.0


