Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2213FC35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdj3-00014U-BB; Sat, 14 Sep 2024 21:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdj2-0000zk-3x
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdj0-00049y-Jv
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2068bee21d8so35516785ad.2
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362409; x=1726967209;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nyASwxYCvsAWNh9neSNt2c74xLjhwEcHZ/10RfBTDG4=;
 b=hiDR48N6aDcvyk8H+iKvRXOqMTDTtTV516zlxxv8hYxyJcyOXsYu6tiWaaNJd9h3RP
 7zsw+slMHSUZkVWCaa/yiLOJn0CoeAjuQJfHCXtaO+hxIihgVfHTcVpVzxZw7yC1CQbd
 NfD8C3RstBwau952/WUZ4hLR/WaxVSN/iaiCINPi2n51s8MAu7tFp3uIZbuN/KzC2zjs
 vBRIWEAPQcc1qNQrKeFEKbbQ7mQ3zy4HsMmRE3l8ZY33jNyADo1rCCzI6FjK8y+8ecf/
 Rm2diPTqBKyN2O5zVdlko1tfxci941+5lmHRTz1OvvmeD0P1rbgQhWL4DJfw4659Z/Zf
 SQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362409; x=1726967209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyASwxYCvsAWNh9neSNt2c74xLjhwEcHZ/10RfBTDG4=;
 b=aLIHkFzwjIN3TJgwQS7VuQH/aZIc5BnXdx45qun3EZGo/jizSc8dRBCJiQurVsK032
 ambrFsoMeI4icRFLc+ROW8apvW6bSs/9tysUHqwGfFtl5zJCArioAx8P9NxiAql/svnC
 kza4a3MzAwj/mNc47tMf1m38Rwe+B4PwRbvirIf8MG+joP9mttJIIfrrjaCNTVe+weKU
 9qDFWhjyIfIeJQiwtUpjE5gn60GI7AROA8t314Mxhdf53jbNSU6knM+CozMOinEMbhvZ
 iOxTdF2hPSYIPyXZ72JYuNPCwYhKZLxjibdKln26S5IsFcIq62Ha7TUSsvX3rfcHZiwC
 typQ==
X-Gm-Message-State: AOJu0Ywq3BRojZDGAoBYYY/ZuXhn/zPYN139J+pqhs+1Ua+YKpfEJt1b
 I+3ftD5UzQfZC1pvTN4Sl2Huk5TvzycZjwUmQwLIrs8haBgvHBWpngl8FbmGyNQ=
X-Google-Smtp-Source: AGHT+IHgpNugcE3lXIRjZoDH3JdOq3mqlLpmE4nNvjSoxswpdwMiTt+008Pzku+Vt/Ta1svudNcKcg==
X-Received: by 2002:a17:902:da8d:b0:205:6552:1099 with SMTP id
 d9443c01a7336-2076e31f984mr179183195ad.8.1726362409213; 
 Sat, 14 Sep 2024 18:06:49 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-207947666a3sm14713435ad.308.2024.09.14.18.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:06:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:06:39 +0900
Subject: [PATCH 1/7] net: checksum: Convert data to void *
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-queue-v1-1-b49bd49b926d@daynix.com>
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Convert the data parameter of net_checksum_calculate() to void * to
save unnecessary casts for callers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/checksum.h | 2 +-
 net/checksum.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 7dec37e56c78..188e4cca0b7f 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -30,7 +30,7 @@ uint32_t net_checksum_add_cont(int len, uint8_t *buf, int seq);
 uint16_t net_checksum_finish(uint32_t sum);
 uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
                              uint8_t *addrs, uint8_t *buf);
-void net_checksum_calculate(uint8_t *data, int length, int csum_flag);
+void net_checksum_calculate(void *data, int length, int csum_flag);
 
 static inline uint32_t
 net_checksum_add(int len, uint8_t *buf)
diff --git a/net/checksum.c b/net/checksum.c
index 1a957e4c0b10..537457d89d07 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -57,7 +57,7 @@ uint16_t net_checksum_tcpudp(uint16_t length, uint16_t proto,
     return net_checksum_finish(sum);
 }
 
-void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
+void net_checksum_calculate(void *data, int length, int csum_flag)
 {
     int mac_hdr_len, ip_len;
     struct ip_header *ip;
@@ -101,7 +101,7 @@ void net_checksum_calculate(uint8_t *data, int length, int csum_flag)
         return;
     }
 
-    ip = (struct ip_header *)(data + mac_hdr_len);
+    ip = (struct ip_header *)((uint8_t *)data + mac_hdr_len);
 
     if (IP_HEADER_VERSION(ip) != IP_HEADER_VERSION_4) {
         return; /* not IPv4 */

-- 
2.46.0


