Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BF4C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYA-0007Oh-RT; Thu, 23 May 2024 19:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXt-0007Hg-Ar; Thu, 23 May 2024 19:08:26 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXp-0005h0-Sj; Thu, 23 May 2024 19:08:24 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7e2188592c2so318279639f.0; 
 Thu, 23 May 2024 16:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505700; x=1717110500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhygXDBZg+JQn2qxKoQkSIcRFlUQ8KZZKKQvsFJqt9A=;
 b=bIBqqslnw5DJr9icjxrLfi/k1zcW9FVeOOdoUpHcY0cFLKPy5O4zG5oxQWH3GflxL+
 cDrzTqmMokB1GdU+yNC7UhX7gnh/AnOrJm9nKfxg8T8A3kw6Wk1IVENL0QkIpWhqjq8m
 nBm+Ibl0V8RYC/HaDJ6p2cHXqBf4tR/opjyar/kB030tYGp6fSkui6t8hHtFgvshfEl/
 bwWXa+qrdyv1jNNXXVYmROhjfQL1s69ptKmYK5OhypxLQQwsAwAgqD6IBjnXRroGFDAS
 4WD37/6Oy7RUDJHE2XpVXB5WSyr81b1/FDWiV3jNShUoQuD5WMuZNsQvSWwGPlpJOfka
 pd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505700; x=1717110500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhygXDBZg+JQn2qxKoQkSIcRFlUQ8KZZKKQvsFJqt9A=;
 b=QTEZV+uErsrVmhttyWLd7U0fvNakPujWvKthxibFRiTZDGnk4EIUDKXIp47RLPXj1P
 iX6uRIijwl/f+VfT4VNz3C0U5b8WnB1OtGX2x8GeBCpLvxgZU3tSKTT5ObA+CMm8L6eI
 fTJfLlXggDwRQMc24KLikMnSw74GBo2sJMn8CnYK2MSMro5SZOgYEDChLSVFU93zuu5p
 u67onfiubLDSoFWB0MGo+gyBqrNjV/NUpeVbau2bXZvUyZTJEasa5+JGm9aFcxOi+IT4
 mWEZv0v71g1dlBOFlhAFXZKgsUZN056XOU0ttJ4Zod870wbaLxWDUd8HbCSvhTmPbsKG
 8poQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUhd5O2H0+Bv8wSt0IpiPiETGv5MYlwU47d92tnU5yMZV4A6ng+eaJXpsYHtLyF16xMTeKQYDWqeoXb420Za9Y4hc4
X-Gm-Message-State: AOJu0Yws+VR8X5sfEcH/96vjswTqL1jcGV6rcF7aULsmKk6gVQmKj6Ls
 tUiQevr3BwRIMupCWRSHmtW3W/v9u3sKnZMUB0Sq4TgzeBN+1AxmWm23aA==
X-Google-Smtp-Source: AGHT+IGbXc2+Ecvkh2rE5MztJHsGTRv3ZL99khph0WiN92XqZLuMD7X3KiUmFDYs1BXGwMrlET7BWQ==
X-Received: by 2002:a5d:960b:0:b0:7e1:80f7:fe0 with SMTP id
 ca18e2360f4ac-7e8c54c7983mr99558939f.11.1716505699724; 
 Thu, 23 May 2024 16:08:19 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 07/72] target/ppc: Fix embedded memory barriers
Date: Fri, 24 May 2024 09:06:40 +1000
Message-ID: <20240523230747.45703-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd30.google.com
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

Memory barriers are supposed to do something on BookE systems, these
were probably just missed during MTTCG enablement, maybe no targets
support SMP. Either way, add proper BookE implementations.

Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/misc-impl.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index cb1a2b707e..7574317600 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -34,8 +34,7 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
      */
     if (!(ctx->insns_flags & PPC_MEM_SYNC)) {
         if (ctx->insns_flags & PPC_BOOKE) {
-            /* msync replaces sync on 440, interpreted as nop */
-            /* XXX: this also catches e200 */
+            tcg_gen_mb(bar | TCG_BAR_SC);
             return true;
         }
 
@@ -75,6 +74,7 @@ static bool trans_EIEIO(DisasContext *ctx, arg_EIEIO *a)
     if (!(ctx->insns_flags & PPC_MEM_EIEIO)) {
         if ((ctx->insns_flags & PPC_BOOKE) ||
             (ctx->insns_flags2 & PPC2_BOOKE206)) {
+            tcg_gen_mb(bar | TCG_BAR_SC);
             return true;
         }
         return false;
-- 
2.43.0


