Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61E2CC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeND-0005VA-C1; Tue, 13 Oct 2026 11:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGeNA-0005UA-T0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:25:01 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGeN9-0001vr-5i
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:25:00 -0400
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2D9B23F596
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791905098;
 bh=HqUPDUBj1k2RWrJuif2f/Ohkgu9iWZHBLOAtboeSD0Y=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=Johd6/lzofp3m6qvGUqF3NTVw0qiQK8MSQalZicUpsnOEMFCHos2IcFUyXy5eonWC
 C1pot4HWnmxvki+a2H/GlMmt1tgLH4qrqnWOB0KuuxGx+KVTwLjO8cRjX24yYQ75mC
 Uspt2D8FlB5I+ZiIlhhJv4d5b42Nh2lQkEDAvRo960YjfZuH6b0abHG5eBFLDpuAhY
 ziWngz3ngaoueKgB6+sVXWi/lEZZxYTRQkGaiZVNdTOLK+om9uA5WR5IwWB/7bSCpe
 3lLD3nx/imnqkVyMQIBlDBJKkpOnp62e2FdP1FPO6jO3X+xq/VzEWdwn5w74JbQ1jN
 RwIT48x1whlws9FNRl9XDpSrcH5omNI2XqaXJjIQl4Wzo8pjhbvFVAhcRT0yYzcoVs
 vqPRluTjHPvP3f+lSNX0e/UQYyyaB3MNc8KJFN2G6QUBVSC2IAmbKRMQWGWSpKre8A
 VN74SE/5o+3qFJEbk1Fmyj3pEmGx2zYkTeWuOG2YknWox1inDJMV0DNCDcEt1N8spQ
 /xGbR1aUDnc1K98IWvo6VselA18z6txB57RWH2V0J/4+ZdYDOCrRaUj8SPXzZdw6Uc
 6uAvQRmzafRfYq5/Xm6Dy+AZroyYwK6/Zb6KLCevHjztXTQ6SIM0ewMWSscK2oSJyS
 jRIFv2FAQusmzKqvHaZLtdeU=
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81eddfe28b4so46292957b3.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905097; x=1792509897;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HqUPDUBj1k2RWrJuif2f/Ohkgu9iWZHBLOAtboeSD0Y=;
 b=FxLYCdWbZkvBVRqEpiBhUQJgwiiX0lIAtj5KTmY/1qoG7K7HLjRW1BSSi3eGWk86ot
 J25eKLOUcfroDuNnYuXkIabIAypU6YNX6rK9uZmWQ+ra9LDvMKHrJBWTBntiH/PGEaVR
 YljeZhUdGQQnLDhfaHlWhCloINLLXEvQxiULDQlVqRGy140moeG9z5z9P0+mkSZ/xD2L
 NfP/Rzpw49v8MYOZdSH4ROt6HxrwDJTv2qWpbN0DmL+Vu6WiLSB7taRte0nZWjxhy0yX
 gdJ382pOeDejmjKyEfIxTflsWc+hBl6N7v4u8DyayO6enh5SuezObOLyYilQcLquGMId
 UnTQ==
X-Gm-Message-State: AFq9FYL19kDMgSEtjebg8uWmqjS0ceKzWtt0bnOL6boftZLewGdeZYe4
 mUFNQdJJJGt5VUTLsA33enF72NIJqKoRXxbJONX6z7SX/S1C2rVBn6lGGgkg+KCNnU7aHO9XzWn
 xPXO/JnQajpTU3Y5yrE5/frlLPpwXvZqZSe1VlxW+EmRJYHsJQVsAwIyK/TTjnWw0C7wiNj81
X-Gm-Gg: AYBFou2zRb/WYEz+FNI9QDwCEb4J0biTDzw+FxkI0mWvJLratdVP1I8kLvE91YwihBF
 1jB+AG3bv9fuuheTB3cE7WJehKxqeuFQK3X020kqiXFhhA6cEB2b/Ru/xhsJy7gLgQ0Gcox33qR
 zJ840+udBBZhE++qNBBnhzdxR5hDyqzohAT/OniN2JcBXE9tlQqLVZgolnknHJne/wB7Xy4ei3P
 3mGnGSqld62T37aUeAnByEHuTLN5OM6S+Wv+oUPqYs51JKElEo01CfYnvIueE2/yjcSdy0pmRiJ
 AZtRpzMpXLjiDkyppHz5xi/LZHFtX7f8Nm+/B5t8lzy+e0A1s2AiPGCgri9gsAT+lEJhKx9XiCq
 TUxaNPDdTsqFsCZMKb1AjDJWtjoNHTZswTOjo/TxU4Pel6Q==
X-Received: by 2002:a05:690c:4f8a:b0:8ae:a9c6:2740 with SMTP id
 00721157ae682-8b07ee51851mr35519537b3.48.1791905096558; 
 Tue, 13 Oct 2026 08:24:56 -0700 (PDT)
X-Received: by 2002:a05:690c:4f8a:b0:8ae:a9c6:2740 with SMTP id
 00721157ae682-8b07ee51851mr35519387b3.48.1791905096107; 
 Tue, 13 Oct 2026 08:24:56 -0700 (PDT)
Received: from [127.0.1.1] ([97.87.60.46]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b07ee8603fsm47203617b3.4.2026.10.13.08.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:24:55 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 13 Oct 2026 10:21:59 -0500
Subject: [PATCH v2 2/2] util/coroutine: Reduce default idle pool max size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-set-default-pool-size-v2-2-f4fd6f2a3303@canonical.com>
References: <20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com>
In-Reply-To: <20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 alex.ramirez@canonical.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=EeFg9E+pl6OpEC4aN5Rr8tjHu/FFrwTvTbsT27oXzSk=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqzk1D6fSF22gzNVKarO5DA8GLn6zWlg+EkwTp+
 29mT1iFHU6JAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas5NQwAKCRD5KICs4jod
 uTfWDACUQ/wtCWxAc2mXuO3z+cYwVfFaOdC7AwOc9+lo3muX7M1Bc2TwuwaLzLfCqLDDEtPieFU
 YALmdpWjltyp7E+KUpdRu3DHMZ6ue96vu9NyibpqOY8goWuefs1YEC2hpoSq3OFJ3D4ZsE9KzHo
 7c/j0g6PlZl6XnjTb/im/zCTJCtZ69GuIeR5cV8tVNSW/FrPT96QVMxwtU4k/wMAf9jzhLVU1T4
 pAf66KQ/AxehPfGDsU24/ZlCC/h+dXTdSvxE+b2wU0mdkn7bbI4QcOYtM/Ddm95Sp3PMJkcgXR/
 l3/PT7DwDaW68WGElWt53ZIWEZ4CwenMOQ9FcqNX21Z1UaVHUSDQOEEMAVTFRAQB5S6swyhy+Wn
 l57AlTjz6ignXpSMqS2iJ6KejC8L22TMP0XOeKGYyJP+itaYGKJtBBmR50gQCqDv/5w7nyWUjCB
 biIC60ji3fxowYgBdW9ryB93DW6idaoKA6LW264TyUQLJ3oMxzWjqrdEniLPmA81RZXXQ=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

If g_file_get_contents fails (AppArmor or other LSM), use a more
conservative default max size for the idle coroutine pool; this avoids
any possibility of the failure described in 86a637e48104 unless the host
kernel is configured with a low vm.max_map_count.

This change is motivated by a discussion of backport risk:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 5af61995437..cfe10c033e4 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -366,6 +366,11 @@ static unsigned int get_global_pool_hard_max_size(void)
 #ifdef __linux__
     g_autofree char *contents = NULL;
     int max_map_count;
+    /*
+     * Read from /proc might fail due to LSM; use (DEFAULT_MAX_MAP_COUNT - 5000)
+     * for distributions that don't change the kernel default
+     */
+    int default_pool_hard_max_size = 60530 / 2;
 
     /*
      * Linux processes can have up to max_map_count virtual memory areas
@@ -378,7 +383,7 @@ static unsigned int get_global_pool_hard_max_size(void)
         /* contents has trailing newline, remove it before conversion */
         g_strchomp(contents);
         if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
-            return UINT_MAX;
+            return default_pool_hard_max_size;
         }
         /*
          * This is an upper bound that avoids exceeding max_map_count. Leave a
@@ -395,7 +400,7 @@ static unsigned int get_global_pool_hard_max_size(void)
     }
 #endif
 
-    return UINT_MAX;
+    return default_pool_hard_max_size;
 }
 
 static void __attribute__((constructor)) qemu_coroutine_init(void)

-- 
2.53.0


