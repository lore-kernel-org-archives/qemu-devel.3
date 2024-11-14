Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24396D68B26
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBae5-0000gQ-Ho; Thu, 14 Nov 2024 09:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBae2-0000fY-OF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:16:26 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBae0-0005hS-HS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:16:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so6201885e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731593782; x=1732198582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cl4ZO8ew2BAiajP9BAvW5+7ZXDojU8B2khh55fONv8=;
 b=lY4oVxKQQPKtfjWHd4ITfc66T4qH8fKdEFfYCrHoIcOetEPWg3vwc6X0AG/ZyJPHCg
 a2+C91b5iCoWXskYGAHYhM9RdBhht2KVbh9BSleuF9+cdgforsDSQnOBGD1v81zwgN28
 FxlcMr1H3Gg52WCXuu/HCGYDIWV7uvCizAX7LbSxhHTLflnPm1OPRWLEfJuGefZYA3AX
 OexDWzUmfavQ/1SEs/1GWE7l5rQLi7dSWC+8vXX6qxJzgvpYVc/OZdGV3+uxqVaLqcqU
 KQxyQqks7Kjw6FrPJo85kvrbjWa2omFGv7BeAu7+7rNJP4YcS8BWTkaNg+h/DwIZbWnR
 k6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731593782; x=1732198582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cl4ZO8ew2BAiajP9BAvW5+7ZXDojU8B2khh55fONv8=;
 b=oo0lO9FJu0iftJPj+SQZudCjGeWBhsblqi56K+C23q8iP3Gyy/whITKvm6Woj156nO
 9nma0bWR+DfG7JU8OEGuFl/RcoWmLI4JHtPm1rJSTwjkVhry6UX0l9oqtczRuyNHXoZK
 mY0r2OmZoGUdai8spN248BMDQYaBMEHJNE4ubY98c4OiExS+rMCdf8Qwr1vGjFll9Gx+
 Bkupk37tLUAq2mbUvpsSJWfgRKyZ+kf0zVL/6kLZr8Mni+eA0fJMctW3UUjFmI0qX5bh
 7K13D/p2loXbG6Gsq93pPHbSBzRe+UKIne+kdqIgbW5n9joX79x/fBgcUVxXU7kDvIxG
 ivoQ==
X-Gm-Message-State: AOJu0YxeanaQ0ZVZchYm0XvRSr+G6AcjfVBgz1As3/+FO8eMpwoOcLi2
 xkQIzwbMKNNE8Cjhf5WngZog4rSZYnaCX8/BrqYoxkiNs7AGiBNOOhcRMZgZrFz0gzSWJtK3wbb
 U
X-Google-Smtp-Source: AGHT+IG2wrca8tT5UP+FOUeYBpZwDEq02SsCuJUhW3cWRZ2h/jdFyAlv32bApVEqAxX+uBjLp1tySw==
X-Received: by 2002:a05:600c:4f04:b0:42e:d4a2:ce67 with SMTP id
 5b1f17b1804b1-432b7505d19mr234484085e9.17.1731593782490; 
 Thu, 14 Nov 2024 06:16:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da244915sm24941655e9.3.2024.11.14.06.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:16:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yuri Benditovich <ybendito@redhat.com>
Subject: [PATCH v2 2/2] net: mark struct ip_header as QEMU_PACKED
Date: Thu, 14 Nov 2024 14:16:19 +0000
Message-Id: <20241114141619.806652-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114141619.806652-1-peter.maydell@linaro.org>
References: <20241114141619.806652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The ip_header is not actually guaranteed to be aligned. We attempt to
deal with this in some places such as net_checksum_calculate() by
using stw_be_p and so on to access the fields, but this is not
sufficient to be correct, because even accessing a byte member
within an unaligned struct is undefined behaviour. The clang
sanitizer will emit warnings like these if net_checksum_calculate()
is called:

     Stopping network: ../../net/checksum.c:106:9: runtime error: member access within misaligned address 0x556aad9b502e for type 'struct ip_header', which requires 4 byte alignment
    0x556aad9b502e: note: pointer points here
     34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                 ^
    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../net/checksum.c:106:9 in
    ../../net/checksum.c:106:9: runtime error: load of misaligned address 0x556aad9b502e for type 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
    0x556aad9b502e: note: pointer points here
     34 56 08 00 45 00  01 48 a5 09 40 00 40 11  7c 8b 0a 00 02 0f 0a 00  02 02 00 44 00 43 01 34  19 56
                 ^

Fix this by marking the ip_header struct as QEMU_PACKED, so that
the compiler knows that it might be unaligned and will generate
the right code for accessing fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 3b80b6e07f3..14c34f530fe 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -56,7 +56,7 @@ struct ip_header {
     uint8_t  ip_p;           /* protocol */
     uint16_t ip_sum;         /* checksum */
     uint32_t ip_src, ip_dst; /* source and destination address */
-};
+} QEMU_PACKED;
 
 typedef struct tcp_header {
     uint16_t th_sport;          /* source port */
-- 
2.34.1


