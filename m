Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90810109C028
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Pze-0004eo-Vk; Wed, 25 Mar 2026 11:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzR-0004b1-Od
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:50 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzQ-0007za-Aj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:49 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so2884241f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451867; x=1775056667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGrRVHKmEX4IQk7MCycV3cbvFt2/hR4jH0QSvJAAcyQ=;
 b=dYpMoroFSX5aJl4vJQkeqwj+xvsBexx3X7fKjtaG0UKV/TmLs8+TqjjsF2UyGiiP+Y
 URMdjrXWg0iup8zZESfDZbnbpux9M24C/SMph3O9xgrW8lE9hCEMX8KCCDnPEZfSW4yb
 KsjA6bSf9al1W9/us4oLfgSqypIno1VfmaP8jYhavI7njnsDeWKn8lTYCrNY0N8sV0Pl
 7h9kXZPXfyvh3K+eH6jFp4bhM04XeI838po4jHXYmU4nYTh52ffZVcJK+2KacORLFUP2
 zzxjlW7tvk7cBCqxw1KyFarOHQsx1TXbm8XpE7ztKLiSQxGMwRYwzsyuI7btTnVhWQxG
 gurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451867; x=1775056667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AGrRVHKmEX4IQk7MCycV3cbvFt2/hR4jH0QSvJAAcyQ=;
 b=XIQZqyDxWD3kyunJSF4FiRyYb8pAn/ayKg2+lC09ciZ5U5fli/e7wWimReXkGd/EUP
 qM1P4Jz401bVx/Iwth2Mvwu31KER31QeL49GUf5Qr8NtAT6nGm65o6HCtcuEgWGgaJQB
 SgAtprpzd5Eycp/jNOpfhe5c42lmdpqVYuEIZDTICSSNIoNLQ7Mqbu5XuAYcI4iSYitw
 a3do4cVN2wT/mesbYl7RwBoEEcArOgazgPbF/R54joSqtQXD5Y3Q5KNP+iGorgECe6OV
 B+MKi9ZKxl9pW3VM+aWcHjzxGOytfoMY48fvDoH45mxRLAzh4lCLL9WFDgOq4vcbxtip
 MFug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2rnJ0HgYrXFvyCSMir1fByIAJgGrBTKZfz4+CKD84zymfOfnVFz70oWJ+QEqtu3Jrroiun/PWU8DG@nongnu.org
X-Gm-Message-State: AOJu0YzYEankCW2k0oeZD5rzm+JTioenthhR1568aZO7p2MQmNNgszZF
 e0Yf+QoWk/haAJs/QBdgPgLHX3hPAzAZpGCIHANl0ekK0mIl9GJ9UIgEn+rpqB4RguU=
X-Gm-Gg: ATEYQzwWSrNf3f4z4zR3lHcdVZERNIKIXEfymS+psMl3TlIKAsqwEegqAA3ikTvi4gz
 2VTLlvjs0LVryTLcpswOrSvNZ1UsVnaqd5gc2uhWvIPU+fPl2ZulnoUvKnpzgoBuz2ZB2AiQnBZ
 YPiXTDDi3q412fe6tEpFIT1Vv+tewdCIvdob91O+ekSR52A9zOEvPsj3EWCvFXTj/7iGfXdvOFJ
 hqsjS2uj34R8z7qUnYpYboC1WeiZlkuzOFIXffRjQqKlHmjFZUeU+nOwcsYNXUe2tEPp/n9Q8N8
 9aEHQYK6qYvC33Tv1LwqFXRkcjM24k/B436qqNihRI0XqaOX4drdF1s8VOI0YoJ4KRKZXBdHBc4
 tqoPlaNOyFdBL5xxLx1e9Y8ZeF6USYjyNXnw3Tw8J3NjnUMI4bprUvFu/zeassjFMTQp1pw9i6M
 dtA34BDz23Jjfu4S0SAjo7f/HkX59uMEHia3mZKMzfHTXaZRAf6zIN7DmAuFwdskUCIfU1uTOP
X-Received: by 2002:a5d:5d0a:0:b0:439:cd10:aaf1 with SMTP id
 ffacd0b85a97d-43b88a960a6mr5401366f8f.53.1774451866504; 
 Wed, 25 Mar 2026 08:17:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e708asm340519f8f.36.2026.03.25.08.17.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 08:17:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-11.0? 2/6] hw/core: Move compat_props_add() to
 'hw/core/boards.h'
Date: Wed, 25 Mar 2026 16:17:24 +0100
Message-ID: <20260325151728.45378-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

compat_props_add() is only used by board models, no need
to expose it to any device model. Restrict by defining it
only in "hw/core/boards.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h | 10 ++++++++++
 include/hw/core/qdev.h   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index f85f31bd90d..b7138f2715e 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -804,6 +804,16 @@ struct MachineState {
         } \
     } while (0)
 
+static inline void
+compat_props_add(GPtrArray *arr,
+                 GlobalProperty props[], size_t nelem)
+{
+    int i;
+    for (i = 0; i < nelem; i++) {
+        g_ptr_array_add(arr, (void *)&props[i]);
+    }
+}
+
 extern GlobalProperty hw_compat_10_2[];
 extern const size_t hw_compat_10_2_len;
 
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979ccb..778617787c7 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -421,16 +421,6 @@ typedef struct GlobalProperty {
     bool optional;
 } GlobalProperty;
 
-static inline void
-compat_props_add(GPtrArray *arr,
-                 GlobalProperty props[], size_t nelem)
-{
-    int i;
-    for (i = 0; i < nelem; i++) {
-        g_ptr_array_add(arr, (void *)&props[i]);
-    }
-}
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
-- 
2.53.0


