Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58226C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xwJ-0001RE-JF; Wed, 16 Apr 2025 04:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwB-0001B2-9W; Wed, 16 Apr 2025 04:16:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xw9-0005lu-6r; Wed, 16 Apr 2025 04:16:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so7522174b3a.0; 
 Wed, 16 Apr 2025 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791357; x=1745396157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLrrsrQZzD72xGTbhwYlmsLnhFUFIFLCF7fWNU0pNNM=;
 b=UgNa8+igYjK1RgjVuLXnp1Sj2z6srH9CGU5RMymGbVdtqCuYwWGDmKnYDr3RnfrpTg
 wjgjM1yKl8YexdxVqnxzOHQjMnpU6yri8C6oJpyz4vX9etYg+OU9/yAMIUpJxKk10dPB
 pemUZuHriuPRBoq1hdttc+2vWQxA3QxDFudBPb+XwaWVU2RPWXHtBLivjHHfw7iO+qSh
 AUr0taDYPaCCetgSanMFk2vQEDS3i89OMM+VGKfdRs6iOk1r5C6OidktPqCe1vm37uc+
 wi/lfgJ5KOsvMPTu2vTwmvYJ6q8HMC99SZr+oMiZzYMIAKqxv4xFTJHCrXhoG0+HcSsW
 5O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791357; x=1745396157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLrrsrQZzD72xGTbhwYlmsLnhFUFIFLCF7fWNU0pNNM=;
 b=Q0Ae/IuVOKP/OWnGyBMTkG27hgjMbewB0YCP9yXKlfcQuxA3xTVET0aJehPmxAnxrW
 ZtiqmYIKmHZMcsac8ro6XoKCZ4VZuZfukw7lMBWEWJ40PVQwrjDx7BJjtYFb+3mi7fr0
 5ugehlVD29656Gv75KqfMUcO+N34N+6EK9PoXPVIj8a3DHXa23i3QExLUyghuPJYowcL
 YORwJYevaZiNg2YeN5BzskGKlW7jGEB/qi+N2qeK1QbYuT9JAnmxTFW1Oy+AY1CGgW9B
 5ydVH4I9H+uRXRVEbkPbty+nWRXNsIL52v8EifXTbZlpdq4mcKeMjJEUAHiw1fXyQxaH
 UlvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHL6Rt+LrW4UVO1YEjZ7okg3XYheypPYDiH8lMdQ/x1sce1fshjwZh8GzMhcnmwywpiJ+hJYTQmg==@nongnu.org,
 AJvYcCWIlchQBi3TPij8ogw/r46mKO0w8g9DEHn9SYBwOXkKxhB222geZxvLuEjNBhQbqGD7GVHCsUW2AY99GQ==@nongnu.org,
 AJvYcCX9rjjuodktQKDqhb+IhGlKcAQOG7LRq4GQzSgNQTWsYaWU1kr8AhggK+H9ocv7CklCjYgzWNcFJxWmBg==@nongnu.org,
 AJvYcCXVYo65yXz8zyimtdP2eyAqbLQr60MWhd5cDB7zFEtKctpJfstN5ItC5N7f4LlcMr/GvyAZ+ZW2sb8=@nongnu.org
X-Gm-Message-State: AOJu0YwGlY3J5S7jAI98FjaoCl8LyOttXxrgibxsyen9WgOD7TRfJ6v6
 2uqG8rgpNW+VhEJlHWpHNe1NwzS5ePXAyZtlIGlsrSlmxJxIBqpvHUmR+DAr
X-Gm-Gg: ASbGncufbyNLWDfa7bcCjpGzy0iJM684CyEpVtQwDE0qBfbEBaiahjQ1ilKDFg3YTVA
 CM8qAyibA9mGMsV2B4i3udjMaPlkw8EZzuswTCeTR9dzD7Rd5RdCtp5ZLXRkKNYde8vTZbStpU8
 f31dtjnZHpipV7gZopfSn0da+oRkB4Q0uxoUweF61l3rTExr74DEL7jka175gOXKN/H/kgOQ9DU
 FRrrISOtwjqY88xGVWxBeNSYmnq8Mr4/c03TgyVpvWRdIFo4P7j+8hBw0Ig3t00wNIsBYUknFAD
 UO1lVygeZDsBJxRV0eE35EHoN+DahH0MdVd2oWCXk/ieXS3EvgEyOS2Tkw==
X-Google-Smtp-Source: AGHT+IElp/3KeYgC/T6jv5Txgk/XiOizl7AfYjlspAIvyy7iNx5MfvQinIdw27QmjbVp2QBCODsp4g==
X-Received: by 2002:a05:6a00:aa8d:b0:736:a973:748 with SMTP id
 d2e1a72fcca58-73c267f8ba4mr1454869b3a.22.1744791356930; 
 Wed, 16 Apr 2025 01:15:56 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:15:56 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 07/19] hw/net/can: Fix type conflict of GLib function pointers
Date: Wed, 16 Apr 2025 17:14:12 +0900
Message-Id: <4ddec141849368fa77f9fd68942f09f5338ef9c6.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x431.google.com
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call using g_slist_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index dc242e9215..013ebc10dc 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1278,7 +1278,7 @@ static void tx_fifo_stamp(XlnxVersalCANFDState *s, uint32_t tb0_regid)
     }
 }
 
-static gint g_cmp_ids(gconstpointer data1, gconstpointer data2)
+static gint g_cmp_ids(gconstpointer data1, gconstpointer data2, gpointer d)
 {
     tx_ready_reg_info *tx_reg_1 = (tx_ready_reg_info *) data1;
     tx_ready_reg_info *tx_reg_2 = (tx_ready_reg_info *) data2;
@@ -1318,7 +1318,7 @@ static GSList *prepare_tx_data(XlnxVersalCANFDState *s)
             temp->can_id = s->regs[reg_num];
             temp->reg_num = reg_num;
             list = g_slist_prepend(list, temp);
-            list = g_slist_sort(list, g_cmp_ids);
+            list = g_slist_sort_with_data(list, g_cmp_ids, NULL);
         }
 
         reg_ready >>= 1;
-- 
2.25.1


