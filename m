Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A8DD12D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 06:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAO6f-0006kB-U9; Mon, 11 Nov 2024 01:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6U-0006jE-IK
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:51 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6S-0000ec-LX
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:40:50 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cdbe608b3so41254435ad.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 22:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731307247; x=1731912047;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pcm3TKfU601RmQ0HaOlFX8GbZkHqQu7xV7Of6HtMoeg=;
 b=EvCnIlpKLaEdDxaAhXv3vQRk0TX07Mg5SwaSNUU5EXSmvhZHG1yFxMTtIH2sO2TzYA
 /kcURRUpKzBBBXpCC1p1Uv+v6oPRcpSPeuj2m9augUlSvpLAPegSZbZ8zklmCMxva7hO
 VG4+HMu0MR14rgJNthxXX0XgRiZ1Nc69+j+KnBe//zg4Vka5HcmxuK9rITgEzHFmMN3M
 nvd2EwaQqA6hnaejjTdnRicMK+bRXysCGk8LETMYpXmjWGa9cy7oI0z9fzuhD1U8sp98
 laPygwQZX1cl98x3v8wAP8RnLSJ5WeYPOYAX+WKlWpwslHSkBeLs2F6us+98Mq0k38hj
 DVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731307247; x=1731912047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcm3TKfU601RmQ0HaOlFX8GbZkHqQu7xV7Of6HtMoeg=;
 b=ie/OoBI63t/ph878rdmGbK5Sss6EKwOeWSDwpqcDJM0X7ZHQyRIuE6ZmmKbtIftXyH
 E9+prr7enz2nAuLkkSPTpqVr/IsNRSOa5VBOkYUcMO2uYUPKjKjsuD5EsvS+3OZREPYb
 A52b5cfmDQ4Po6zYuLiKiPnwwrDEzky7QwncC6VqjndZuO1gV0aZqRqwnYFntiglF+gY
 UCO1XCRn1Otkt/24a0aBxKLtNPGg/YputN0U/AuPMkQnP4VXQL5Kux606XZ1qsrBefIO
 TgsBf/v+NcObtOQxXiWH1pIrUQEMd269wWr+lyhQ4HudgXLCOme9IslU/S7k8/lcm4Il
 o/kQ==
X-Gm-Message-State: AOJu0YwLx3o/J6ZFwooLebnzC+m5E3bGNAfAfWU0ACapvsEnivTWEeS0
 9AGGdx2mOpycBY5+dvHFi7hPcH3K/1p+wbYG+RL6g+7bXpzZ0aQldKioPiAzN+U=
X-Google-Smtp-Source: AGHT+IFG+NV9N7pZBuK0NILGjfQCnzQXU937TWZovCxgRrjEZt4rZSfXFO5Xyw8qXEi8aHtdEX1Apg==
X-Received: by 2002:a17:903:298c:b0:20c:ee32:759f with SMTP id
 d9443c01a7336-211835d8bc0mr173901275ad.39.1731307247144; 
 Sun, 10 Nov 2024 22:40:47 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21177dc7de7sm69635665ad.47.2024.11.10.22.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 22:40:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Nov 2024 15:40:18 +0900
Subject: [PATCH v2 1/6] net: checksum: Convert data to void *
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-queue-v2-1-2f7883a1004f@daynix.com>
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
In-Reply-To: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
2.47.0


