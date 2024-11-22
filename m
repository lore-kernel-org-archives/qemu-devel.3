Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C34E65D27
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELpE-0005bv-Ji; Fri, 22 Nov 2024 00:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELp7-0005ai-RJ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:17 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELp6-0006Re-C9
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:17 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71809fe188cso805500a34.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251795; x=1732856595;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pcm3TKfU601RmQ0HaOlFX8GbZkHqQu7xV7Of6HtMoeg=;
 b=REm8Sq0QFBOqVmD8h1bz83p3uEGQsSxmFzLy0vI81mKqKF8dYqUx5owV9WRHHbQAxe
 Qr4uuXd6pM74e/KTy5EgnMSPoxh1+NQI1TsJfaC6mMN0XXBBQEWMmf8tJDEzUhvkWzbZ
 pL+//QeBbB6WcFFom5tJxYoM5O0YoOfPJYpwvAXx+jDxcygkmwnTRN9s07sqGVMsDy+Y
 iezAEcHUgKsxFo2eg8AHiWEQiCIJYoCovIQkcVqEnnXxZt7KnMk5V7frs+GWbk5vsD07
 olQ4RmWgrEcKkvG1KFEimgTZ3XKhDJlvMC4YHoF6FOU9RUCNOAX1PAjkDo0lnhaBzLIv
 inkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251795; x=1732856595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcm3TKfU601RmQ0HaOlFX8GbZkHqQu7xV7Of6HtMoeg=;
 b=vY4qdd4eM0MCfwAB3VaFyLbnwi4rXhQcmN7b50FA0DjyB3G0g2U308LtMkYE5qwjhp
 MeMWbdSOvm2KcJ8Y7nM3mkxNs2j6Ww9eCOCENQ257mfuQak7gVeBUKUxZaDv6rt430cT
 o34t6ZLGd+2y1vc42YE9sz5w6dd5kinoyNNQqIT+0nMoBT9LGcCIp7h440mLU3ezJZqu
 XStEra8kL8eTXs9ZKdWrJJXIa77Wjn+DLpab72Nwo2Zff0ZN6nZ4CXQrBu7DJFVrgot2
 IVFvPzhoyCVNhj0ihakS5dk/OICUTDkDnAw+CCNsUGXP6N7yMBasvt6DNRAuNLp4Bqfa
 0yqw==
X-Gm-Message-State: AOJu0YyKQSwzXj3BDCzQfGNF6CPffqrRG2FID3hvB/0OvyJQJrb6npIT
 g2/pNj3WQit0RXYNcp180Nom4sK9rfy3T+f9jmAOVyb73NigoYIypZcIf33Bz5IAHJM9TocZcqP
 uYpA=
X-Gm-Gg: ASbGnctcBBh8Cl8o29TGW2xvBp1DLttGxmGXR3oeQfjgwuCcUkUizLVBDbFC7n74LZD
 yYS2Z8dG6volg1jkV6AtVLn40g7eRMDxuNXXwknnynsCJlgA7y7aUf1CM3m0VtP8paw2gXu9Laa
 w4Jah/GmeJYO+3Co6ue+fgArnnqIGpE18GJ+bYDobfdD/OiMN8xmaYJK1+wzt+ncO1kxgvAE3Dg
 +5bJF5Lv+ihidQFo7L8S1w2aQm/+DsDl+ldPSrISapwCuNnJ7TOjA==
X-Google-Smtp-Source: AGHT+IFNp0hK2u+oec6bmfkHzf0MJB4ja6oLn1GXy+v+Eqf8y+X5aa7khf2LTpWSRYijqviDZla4kg==
X-Received: by 2002:a05:6830:39ea:b0:718:12b5:1ed3 with SMTP id
 46e09a7af769-71c04cd9145mr1148737a34.23.1732251794881; 
 Thu, 21 Nov 2024 21:03:14 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-71c0378d05csm280819a34.36.2024.11.21.21.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:03:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 22 Nov 2024 14:03:07 +0900
Subject: [PATCH v3 1/6] net: checksum: Convert data to void *
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-queue-v3-1-f2ff03b8dbfd@daynix.com>
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
In-Reply-To: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x335.google.com
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


