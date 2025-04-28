Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F98C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9I9t-0002Kb-LD; Mon, 28 Apr 2025 02:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9j-0002Ig-Nf; Mon, 28 Apr 2025 02:39:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9I9i-0006ns-3R; Mon, 28 Apr 2025 02:39:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22423adf751so44601245ad.2; 
 Sun, 27 Apr 2025 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822389; x=1746427189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sXRxpcTPXlWeCW9VyVkVrsS4eG/L50janz5xzL80Y6M=;
 b=YXY65bmFDZMHHBCwKnWXhVVzW0XnPI6vhLLW4xEkGeUOWuSBQu6LrEHcttFRc20ZJK
 ehkxOwE5HFxjQ1PiUADZdS1RJo3xFdthUMlc4x1rV+JfJNp4ctzhmNUuzsfTkSKr/zUV
 PCLaJW60YVf5x8vf4dZ19CqIOhZqQJ4zgDB7j1KlKysDKVpPsGAMdLbnz5lmcSuhD9uq
 y76oHwDs23McwA2oDIhYP3kKsvkNboz+DmgPp+LDVLdTDbAkn4v8qeeS8r7wAJpwLncx
 UPAGLkdAs/Wn+4a1CcNqa3F6C4fAmyy9tAz1P2oKWxXFP7VwxynXVRy/pxhZJLh5Mb1p
 t7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822389; x=1746427189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXRxpcTPXlWeCW9VyVkVrsS4eG/L50janz5xzL80Y6M=;
 b=jpbxvj4Ip+Ekzdm3eRp6zaOfRj1QbubYc21W6972MB5LIK6N1Om5r31x4yuNqFXhpB
 BjZ9moepaBx9Apl1ujybQ+PnC1BtHv11fMlHJ060PUgtCXILUHPlx2S0TqyVFc3NprPv
 zyZnBidH9SDd8+jElf8IE0SBjde/xcIDvH7+dk0ShAWEfTQqNwoFUrAlvJor24NHC8++
 ypMXc0pmwZD7i8aoPAWIde8afC3UDmCcQlGd2In+tvBsQYN9HK2lHcujqRc6a8yv00dT
 1CVcuBuBJhwhswQbJ5TCoMK3z41nPNB4VkaxO9jWo1oLL9jBgB7W8fLwLs3hP1UFeJmH
 uXVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeyuUGq5mvroaTc91uwLOUKpI2BU8ZoUzBERZl1FJZshq1H2BZPK7v2TP73zeV0vnZeMFVh8Vn/7Qy3w==@nongnu.org,
 AJvYcCX9osWeitHRS2vlSkHyn8yunY8c6bHTh024fZNiN1Jl+hbOUCxAAzW8Vln+ZpwJt9Z8rNxaplRD6g==@nongnu.org,
 AJvYcCXSgP6BP/ccoOsVW2kqkVHx3c5WSt+x9a00i8NW8V3l2pfOkmLRS1Uzd2a6fDr8QSwB5oclaHsH+/vUeQ==@nongnu.org,
 AJvYcCXl5wBwofeyXXV0+RF/4g8MgxHvesgL66EH3vcteS/LqPPw5A1/ZRiKClI04UTIW7M/CaVtosLLGCo=@nongnu.org
X-Gm-Message-State: AOJu0Yz3YIh/GsazYCVEQHqZhlsQF08Sbm1hBT9BWlxmS7N+7dYwWxAE
 cheY1PDJH2AmXv3Y99ryYOd4pkVgx5JdUI4ge+DBBdi9wSF5xr7rtnv5eIom
X-Gm-Gg: ASbGncvkvsexVpzN6fTIL6IbPyxh54DaC6VVcrr1MtghWcGWKtPobLN9IBnUpDjK1zU
 8EGSRvOMBk13aYj/NLUdKBsOYkC9aqR2bCdy5F78mv2cCTR9NjJFTwlvJLuZN9yMsXPFENuTIlH
 Ma/aQHqdNRpSWb0OPt9oB/NxdOLbwyZvnH1cdNvBNvvmezksHn98uHwnSHbIe0O95zV+YQamksJ
 BkSjuh9UM3iycRlNPHGsmIrQmUH1EE+GtrVc4+4ZtzLAaAe47mJzCvqmTnIY01WK2YVDblsuMGz
 bHM+tjd7C7P3ev6jfRdo/wgqNuj0/nvfC7BHYg==
X-Google-Smtp-Source: AGHT+IFrZH8PrQNIR1i1QyW1F4U8cydPPxpBJ7fMsIckNZPcgjOFtfm3xC65ZGB6y11sDLsbKqifGA==
X-Received: by 2002:a17:903:32c8:b0:223:fb3a:8631 with SMTP id
 d9443c01a7336-22dbf5fc2aemr168535235ad.24.1745822388742; 
 Sun, 27 Apr 2025 23:39:48 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:39:47 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 01/20] hw/core/loader.c: Fix type conflict of GLib function
 pointers
Date: Mon, 28 Apr 2025 15:38:50 +0900
Message-ID: <2898d818d4eb82a3604509ef3ec8646f0d0deafd.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62e.google.com
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

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V3:
- This commit is included in this series sololy to ensure successful
  builds. It has already been picked up by a pull request, so please ignore
  it.

diff --git a/hw/core/loader.c b/hw/core/loader.c
index a3aa62d132..b792a54bb0 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1410,7 +1410,7 @@ typedef struct RomSec {
  * work, but this way saves a little work later by avoiding
  * dealing with "gaps" of 0 length.
  */
-static gint sort_secs(gconstpointer a, gconstpointer b)
+static gint sort_secs(gconstpointer a, gconstpointer b, gpointer d)
 {
     RomSec *ra = (RomSec *) a;
     RomSec *rb = (RomSec *) b;
@@ -1463,7 +1463,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
     /* sentinel */
     secs = add_romsec_to_list(secs, base + size, 1);
 
-    secs = g_list_sort(secs, sort_secs);
+    secs = g_list_sort_with_data(secs, sort_secs, NULL);
 
     for (it = g_list_first(secs); it; it = g_list_next(it)) {
         cand = (RomSec *) it->data;
-- 
2.43.0


