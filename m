Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C33C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zt-0001K8-TL; Thu, 20 Aug 2026 12:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zq-00011T-0l
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zo-0005mk-C0
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2pZ3TNdmbGWedDLlhzGSJjXY8HLIJb58UA/0+I2Zf0=;
 b=jTCqa+uBFjgOnIg853D2tZ7thPWI9k3OgSsi3X/yumoump2pgIBpDq/VQUKhUv46deMT2N
 r2/7ClqgHc5/k72li3yRf4jpa636WWYj6i74mUCSBEDXeH0OMuZqD8mlEWaiIk7R4rzT9B
 xq2t2l/G8i4267ycXj2sBKfhaKvHju4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-7Xzvb9NxNJ6ka9Umcrhs5g-1; Thu, 20 Aug 2026 12:52:01 -0400
X-MC-Unique: 7Xzvb9NxNJ6ka9Umcrhs5g-1
X-Mimecast-MFC-AGG-ID: 7Xzvb9NxNJ6ka9Umcrhs5g_1787244721
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso67226f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244720; x=1787849520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f2pZ3TNdmbGWedDLlhzGSJjXY8HLIJb58UA/0+I2Zf0=;
 b=mmDFd6ofulLsSV6nAZ3AHFCs9dMJvbhwpgEI2BxwZdHrMqm/sXrF/QL56szWppRi7Y
 NFvn7XAaCF11Avx7H/+7TySgl9QAknWy6ZM+xTxwUm5JK7RuBAJeRFtpKs23kQ1x1jw2
 JOo7G4dQYgSWiBCy2rhZ09FJYe1elhnwBI038wi1FrVsPjJYFgTKMJE6Zv80BSxEa5N3
 VxcF3ynZSqjnBEk39GF/OQdswhz/N3jojxI3OKkEhg4Uc4chh0o5V43PWuOHpUX8GzuZ
 bUbedtoqIo3xPaIqms3iXNWz4K0kacUb20+L+Vo9ZTOb4YGR+utrls94XZFRjpyFVAVG
 2YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244720; x=1787849520;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f2pZ3TNdmbGWedDLlhzGSJjXY8HLIJb58UA/0+I2Zf0=;
 b=Qf3cZtVEZRGqyjWiZMujk9Ohy5IPkbUKcNl5NTUvLkbglm06ey5MXhCxctHaM+CLpj
 sgi3CTFvOHl9xHOjbKL98OLQjphBc1aTlumGgomvo5PgvNXOvizXZCXI4rje4XWZHlkF
 ToHljM8tGEXj2YO4Hn+pysgA6cbEYLrxDDt/v42kl8Ca6JbyD1M/g16NddXEOOaMTjgN
 BcP1RP4tXAH+bW0Tckp5Nu8gjUWQG5+EjmER+kzz+NtiLZYzEzUdZOuoBsxhb1ib5KdZ
 dRzi8X/le5MkTqs3eGyJLpH/4iO3INU9f6DAAn4uqiiZe7Z6D6pDMLTAGF3xTwNy1JQE
 pLYQ==
X-Gm-Message-State: AFuF++mmTkQYxiYyAEgFYMbi51vs25LyF1GcN3LlNwpMCwzqUCBulHMR
 2vVqCqSs++872/KSUZIu98nY32A7E5WgnOxZW7DF59l1bJZ/KMx3DjoWJrwf+opdbQ2tzm8VIzd
 imRNggTYOKR6JfPuHxkn6CtWT+o0FsTL/QqLF0fFT8E+pJThenad16+LN8qvf7TXM3EFIx/v9KF
 8tCUQPP7xyaOEOkhH+Eu9xN45+B/lLQWpgTIQVCcvO
X-Gm-Gg: AR+sD138lje5YYQStltyLGkyfkXGct9KBCtrty1yzW89hEM4kzavpReOHTpsBzJ5xI7
 /s898tUhXshBFWjoO75aC+vBlGEYZy/nDkQnDDrGqfcCxDf66IQKMjNCKZnGitMvBmP+Ms7pmWG
 ua3dTLu7ILR2RQ0zjDflqO2JOASgsF3ohdt5myaeEeLPbi1alUXce/3TaehTWVxdz12F0xJczdG
 jW1SuXJmAg7Fp/w6HjSQbsmCiVWte04ebYFumCrdFrBuPxLreXjMH16sjdl8IizXaJy5VCieeL0
 fgGuX07ne+ZemQV5rizY01DbOtD5EUzKaFaDJyU1iBg8Dn7h83fWMGKMfJH7dJJCJRzPv+es8Ui
 3wcj9SdnuTPLG7Tb5sSVTojmHsiI/enNSvihC5y16hgTrw/ZTb0j/3vx/yIJsb9sFds/HQSVg/i
 oHfho=
X-Received: by 2002:adf:e184:0:b0:482:a9c4:bfd6 with SMTP id
 ffacd0b85a97d-482c0b67a8cmr6399f8f.7.1787244720646; 
 Thu, 20 Aug 2026 09:52:00 -0700 (PDT)
X-Received: by 2002:adf:e184:0:b0:482:a9c4:bfd6 with SMTP id
 ffacd0b85a97d-482c0b67a8cmr6318f8f.7.1787244720288; 
 Thu, 20 Aug 2026 09:52:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c78sm13886905f8f.2.2026.08.20.09.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 44/53] rust: update Cargo.lock
Date: Thu, 20 Aug 2026 18:49:47 +0200
Message-ID: <20260820164957.1895963-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Apply change corresponding to bff64138882 ("rust: fix incorrect dependency
in Cargo.toml", 2026-06-17).

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index cbb3ca15f77..c94c2386d94 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -184,7 +184,6 @@ dependencies = [
  "glib-sys",
  "migration-sys",
  "qom-sys",
- "system-sys",
  "util-sys",
 ]
 
@@ -431,6 +430,7 @@ version = "0.1.0"
 dependencies = [
  "common",
  "glib-sys",
+ "hwcore-sys",
  "migration-sys",
  "qom-sys",
  "util-sys",
-- 
2.55.0


