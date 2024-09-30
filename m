Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461A3CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBL5-0005h7-K2; Mon, 30 Sep 2024 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBL3-0005dp-6P
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:01:01 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBL1-0003g6-AM
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:01:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca6603aso4750296a12.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683257; x=1728288057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dt537SuyKX8S7JgDRKIhn/HH1R6QVwglbjLetvuqYf0=;
 b=G/jtgVKdVuHgxz/nrLFTiQ/HbQ6BT5IUG3YYGsV2h99SldLxswUi4DFD3M2akT1cSD
 +vfiEtyCWSy6qKVenTxN0pgH2IQjOGVXi1aP+HjAqGWt2ZFexf1lT3QqCE5i0PYPiZJg
 qodHsu0v8uou18Q7VHiRsepMCtfpoo9kym6ihfTVvm4doM8n39XIjy+aHe58v30L93PI
 fQyp5RCfTYHej2USARxCD7beiSreTVLPTqXttvrNtw0y7TNts8P/BMgUuw8JUokBEyWK
 4X/VGFr9+x15XeLVJg+fQNg/XwQxPqOgfW58lT8njEBq8ntoJ/Ta+k/8krjFN4YnhVxJ
 EAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683257; x=1728288057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dt537SuyKX8S7JgDRKIhn/HH1R6QVwglbjLetvuqYf0=;
 b=hgIcueZcPXnD2tberq5jlEl+xfauoFIJKjVnFq6jkadPcSzTxJPTGWEFXy7QDzmlwH
 1cZkf8BpuuFNHOk0iYRUji9pck23CUshW7hz+to8xlyNaTLusXkLqv8JrDAkL0TMcAj6
 M7Gm7Us96vkCn4f4u9SqeUxIWnGubfA/AI0FVGT92sdORftMbmyK2HO9JUXa3GTMshmF
 9MHRt73gtQoanRkxc59X1ggQPFd1CTTjs9qBcnZjJaSLYsg/9EW0R9vjwstv48/hoUyn
 WdSXToHIdIZ13nDYalANgfJPxCp25xfVCNXuE2l+TSkhIto9kzEgp4Q+60KznOGoMW0w
 fkmg==
X-Gm-Message-State: AOJu0YwaXhptLO1v8+P/XsfvTgyOKkoCwwR/NxTzdzZUtWdC6QkQVbaH
 zrrKKOzeJCxjCcxZegUYzPnuCfqgfB5IdzdakB52y3v7pQhBYa3S9/99oNvvefYMmb7K5zBejPq
 UbaE=
X-Google-Smtp-Source: AGHT+IFFqjO07Ex6VXaJnBp0fLXrztRoPGuiC1qPJjA4ACoyyr6faMY/cMGoyF46pDMcCkFmfDJSuA==
X-Received: by 2002:a05:600c:310e:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-42f58488779mr69873155e9.23.1727681705036; 
 Mon, 30 Sep 2024 00:35:05 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57debe5csm94870215e9.24.2024.09.30.00.35.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:35:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 01/13] qemu/bswap: Introduce ld/st_endian_p() API
Date: Mon, 30 Sep 2024 09:34:38 +0200
Message-ID: <20240930073450.33195-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Introduce the ld/st_endian_p() API, which takes an extra
boolean argument to dispatch to ld/st_{be,le}_p() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO: Update docstring regexp
---
 include/qemu/bswap.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index ad22910a5d..ec813a756d 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -433,4 +433,23 @@ DO_STN_LDN_P(be)
 #undef le_bswaps
 #undef be_bswaps
 
+#define lduw_endian_p(big_endian, p) \
+                     (big_endian) ? lduw_be_p(p) : lduw_le_p(p)
+#define ldsw_endian_p(big_endian, p) \
+                     (big_endian) ? ldsw_be_p(p) : ldsw_be_p(p)
+#define ldl_endian_p(big_endian, p) \
+                    (big_endian) ? ldl_be_p(p) : ldl_le_p(p)
+#define ldq_endian_p(big_endian, p) \
+                    (big_endian) ? ldq_be_p(p) : ldq_le_p(p)
+#define stw_endian_p(big_endian, p, v) \
+                    (big_endian) ? stw_be_p(p, v) : stw_le_p(p, v)
+#define stl_endian_p(big_endian, p, v) \
+                    (big_endian) ? stl_be_p(p, v) : stl_le_p(p, v)
+#define stq_endian_p(big_endian, p, v) \
+                    (big_endian) ? stq_be_p(p, v) : stq_le_p(p, v)
+#define ldn_endian_p(big_endian, p, sz) \
+                     (big_endian) ? ldn_be_p(p, sz) : ldn_le_p(p, sz)
+#define stn_endian_p(big_endian, p, sz, v) \
+                    (big_endian) ? stn_be_p(p, sz, v) : stn_le_p(p, sz, v)
+
 #endif /* BSWAP_H */
-- 
2.45.2


