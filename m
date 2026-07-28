Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB5C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojtY-0003e6-Ge; Tue, 28 Jul 2026 11:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtX-0003aH-1F
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtV-0002jt-4a
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so7069f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253139; x=1785857939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfUxWo9DRfnzypPrGvcp6jHwrWI7DnwyNSb11uKFohg=;
 b=b7sK9nZXoiD1GhYKAGMcusAU8sugsyFFkLMCBTiEnbYeXXPcV/CC/FCI9p6TlNTC6o
 RlURB68TsS42Jl8FmYRCv3yjz6Xd69cLV7TUd6BMBkLzhJkBaTkcFPM62LO/DPDoYXrM
 FVsGr8l3A2cwbx9faG2j3GJvGgmAhAhnsx/5sZqU//qEZ3RqEPU5kw6ffmRefHMb/KBf
 9nvvz4Wca+LkFsOS1AsY/Fup1foYlpuWKEYZs8tVr9WO7lpFM9TqX7705fQ3UK6ULBwI
 LT7MzgcZuZTfFa642B8rOREVHxnumX7CSONXXxuMmnCgqDciqieWJmKS2BkAGY5s4Wne
 8byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253139; x=1785857939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yfUxWo9DRfnzypPrGvcp6jHwrWI7DnwyNSb11uKFohg=;
 b=WGIMvbjn2V2nkuxOoqctk+tGZ1sAYJM+G1jdDlVDiOnLu9o0S9x23NVO6URYwBlCm4
 ClngnaPK17hd24mp/RKgpJyjYvJdSJRJR4StyJDh5q59edhl/9+2aoIQWr0VN5Iuq2cG
 nhtYg7YURek0vXkii8gNh37ogBOoxRea7cJgLSr4EHqhyg+AJ9R84BGelm6QsjZntrzM
 7FK5rtRVTFFsc1PE/bJ7xSoQt3C5xxb8quPN0+tuWBMqGRMz79pXNNmmT005Bklga8XW
 PmHon4cfFCwKalv3V0gN9Jd9tiNMyWsItkBsKqi+kPac6cM7MtTptsBw6NvDuft/VVGI
 DCwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roh3A9V9MbvDgROSbUM2EoVdrpVCU5k1qPLCrEv5HWpDvx2F5RsXXyFKUHH+hKfJaXvf4D2vHarQ+NS@nongnu.org
X-Gm-Message-State: AOJu0YxpXmbOeOpQP/7wZIJGMkCG6k+EbZvQycZImoWqk/ETU/E3lGG6
 gG7Ibnoe/6Dd9uE5aobYmYBgBDhIFq41yp/8K3QR6BjKQy7ypDuijxdqj2CiXx6FVru9xyg0FIs
 pQMbN
X-Gm-Gg: AR+sD119joIxY6W2MdETmt/eDdMjAFU/oIl9ESKaX4l+vYKsggqQVqNpVGOjMl0THTi
 Fjc0Qm3u7DI7qj6XXatbzVIIsq6QyuLLk4Hr2OkDleOR9CHbUsKHf8bs0Oo0hyhMuzVumzOZhHo
 QkOHrtDV75Zi/28gETvI8qrAAU4ZW/iqulwkd1KsLKJtev1rtU7vhNUuOowNy8+W9SZ/CiwNdBk
 AY3OC6pu+2aaJCaEhCTitR7CXJemb2AsFiWd813/qkW5rJmWrjfgTJAWJZUHFAb/VBB1xOPJHtL
 B6+Si52tv6cfA+XTm+XQr0l+so5OjCx3eq2EVpJTa+IUxDQ0JYrSovWPKg0DnITuvha+6ni4qE4
 tPZCyvnMpJhKktW+aJcpm1/Cz47O/rqN/z6/hq8oVejVkMLmUmrkm9+LBfvy6C+sLHRBoxD5ZXw
 ==
X-Received: by 2002:a05:6000:200e:b0:47e:1d9a:1123 with SMTP id
 ffacd0b85a97d-47fb1e60ec0mr3523553f8f.3.1785253139597; 
 Tue, 28 Jul 2026 08:38:59 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:59 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 7/9] parallels: avoid fatal abort on large bitmap L1 table
Date: Tue, 28 Jul 2026 17:38:47 +0200
Message-ID: <20260728153849.601939-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=den@openvz.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

parallels_load_bitmap() allocated the L1 table with g_new(), which
aborts the whole process on allocation failure instead of returning
an error.

Use g_try_new() and fail the open normally.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels-ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 704e16e1de..7f6ab6b0d2 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -169,7 +169,13 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     }
 
     if (bf.l1_size != 0) {
-        l1_table = g_new(uint64_t, bf.l1_size);
+        l1_table = g_try_new(uint64_t, bf.l1_size);
+        if (!l1_table) {
+            error_setg(errp, "Failed to allocate the bitmap L1 table "
+                       "(%" PRIu32 " entries)", bf.l1_size);
+            goto fail;
+        }
+
         for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
             l1_table[i] = ldq_le_p(data);
         }
-- 
2.53.0


