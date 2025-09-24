Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4142ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnM-0007sv-HK; Wed, 24 Sep 2025 15:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uly-0006w7-1Z
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:29 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujw-0007pa-KA
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:21 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3306b83ebdaso155565a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740475; x=1759345275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y6GMBnkWH9fyHQshpdSniNoZ8n9TEP3JfhOL3KJlw4=;
 b=B31lPl7eytz5ISm/tMNaVKVWkKCndSz8W/u1AGCMYRKpJFIAd1yNXfVbsLX96+PFMi
 cvWs5ZuLNJ7NWS+FBYGM1X+WJ36Bm04nWJaHlIU0tqu7H0lAFT6wNKTvZOS8AeOhTMap
 ey63EcNZKW5ef65DDPhZqhMMFY4vVEv2FNj/8CvkBfIB7xAL7+x9E4jQ/q5kcdNDnlpd
 3QSTwz7SnV9zSb6IliHmvnDvsOUfbCNAnzLvwoauTSAiSn6V6u1Z9KUAMRk95JYdhqXr
 M5KegMjiYWfaGZdfIWxvLPqae8r+jHdB3Qu9g3v5qQ8OVXSKvikWKNIycLRroVWlcZq0
 kYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740475; x=1759345275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3y6GMBnkWH9fyHQshpdSniNoZ8n9TEP3JfhOL3KJlw4=;
 b=esrQzEj3RyDvZFJ4pcKMzaJzKQpRsc1GOg2eaAr9JoJ/U4z+U/k9m9pChjnFRTjtx6
 vBvgbSSAyBWevEN89pJEdPxXFyhAQqzsHyXp1MLmfBIk1CDaWqY0K4BKtcE9K5ATsqto
 zKx6hPp4ft/69yGtSahQQ6YYOPVhsbZthuCJu0v6UzcAZu6QS5qvCJ9X6Ho1RxjyjxjW
 EzLq8RKIf4gcO0u7SKXPgLKYG64rk1B67LoG0nKaiO5MGo4XzktgDqBWp+MURBmtgFvt
 q9C9hyKoyUvIMKV3ln+9e9zzwMhV0qlbUvjyOqVQc/nbEhEdnmF+xo/JLMDztmbBbbgo
 TNyA==
X-Gm-Message-State: AOJu0YzDZaiA2kSwyNV4iB/RkHQjkCxUJACgqyZtY5MJzDu3m9wnM7kw
 mx1inAJyeTGd0urSBHEvEDj8gU4/4NolsLWApMfekDd+ZQ1LmqxHU+cCdStgcDFTqGCg6KDcaTU
 5Asn8
X-Gm-Gg: ASbGnctVf3zjupp/QQGfkWsAcxRNnxufM+z9msz1Nv65k5OUki5Ddk0kMhymlbaTNJ5
 wkeid33aaGKZtdphSpPQXsdOhfKvY7TEyf/9ncXAjas+RKk1JGwTQWs2M+CQ9lRYu/q+yEpkqBY
 b+ASFUqpwqqT8pRqzrVRihyifts40h8F3GMbt5LWdCz88/KEEPSQkmC22qR8xwFYArBS3kX8ges
 W7Ksqhgb+mn1uuZtcDeCXWqrtKjyeYNANtiHpTRCAFJIhC2PeBH0hmlE0KVDVGCB6f0Vc5BPcXB
 uJfnNtHK3fJ5k0Vu0puQuvYrbDIsNd0HDa4hFYYjQp9Lk4MsxwJk1TuVybiKrREIZniFdox4AgJ
 cmasZwDiwQyr5TqTs56htB/qvYP0B1m6jI6+bAFQ=
X-Google-Smtp-Source: AGHT+IHq9+ns+icvb4uFyD5tprR6CZsAGGpCh+gUAqhFy8k2TPVufRumOKWzfnmPnA8kmFZLrrViGQ==
X-Received: by 2002:a17:90b:380f:b0:329:e703:d00b with SMTP id
 98e67ed59e1d1-3342a2f8adfmr733933a91.19.1758740474593; 
 Wed, 24 Sep 2025 12:01:14 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 10/32] target/sparc: Loosen decode of RDTBR for v7
Date: Wed, 24 Sep 2025 12:00:43 -0700
Message-ID: <20250924190106.7089-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: e8325dc02d0 ("target/sparc: Move RDTBR, FLUSHW to decodetree")
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 77b2f54fdf..242ec42016 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -226,7 +226,7 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
 
 {
   FLUSHW    10 00000 101011 00000 0 0000000000000
-  RDTBR     10 rd:5  101011 00000 0 0000000000000
+  RDTBR     10 rd:5  101011 ----- - -------------
 }
 
 {
-- 
2.43.0


