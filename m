Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E54D1624A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUX-0006d9-T1; Mon, 14 Oct 2024 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-0006cO-VB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:43:59 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUJ-00056M-0D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:43:48 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a0474e70eso192037266b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906225; x=1729511025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaYY9X9pUCStJ66Iupj9x96nWBsnt7lR9iGUBryB4Dk=;
 b=WlEXveOnqGqOt7egtrmFb/iIGlyX/65lCx0zEw+WMBYn51iNejmGCzrPmTZsm1FXXe
 O+UyZ3LfSz5+dIrTWZuNG2OqEWh4CFyZdS2yVXTRO9qiOwEOfMh19AL6+llXx8y+q/+x
 lpRburbI/fqXkXOcjbCNqUAzEWKoDbJ+t52UYqCdz4xJCf1MGYVVZfAgDN05SqcN3n+G
 ViPnFx/OMHNHp7CX5Igg/0wH8SwfbLJQ1l5giAznzw7MDraSOahcPUhugRVmdPtBBDEW
 S3KO9r/4NYUgBHX+1bxEG+w9w8H7SM3s8G1h2pJmAUOJ3zuognwFCjdb9BaseX+IUWNf
 Ow3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906225; x=1729511025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaYY9X9pUCStJ66Iupj9x96nWBsnt7lR9iGUBryB4Dk=;
 b=RVaCvccBAv1eiZ6IXLubYTW4B75TI2LBv5zU/hnRp26AhGCTTGqZnZnXXEmOUHZunc
 StJNe4Smp1CmagbYf53zIPfNYqpDIdg7goRfp9dCH10jHP2xNCqlmHwNMx+Xut311+qh
 kxD4gC4mURLrGD5PGAog3eq/oORNPxmu9LeLIzg/FAh2Mtb6XlB7l+9FG+sL8VEQ3Btc
 /ljy1N8XSTTQW/olxf74sLpJHlyyKFVjmYcGh0YkpaNybvnj9rkhPj8pv9skLM2JqD8Y
 9xZ+/oWv7MaiE5x+2o70V0YyCjFLbpA6gH73amyiqWFcQC6S0s9RgQur8IAJP+Q9RzfQ
 JBpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX80TykRNwLSd18VMOCr8F/i5Uo4UD5O93LYlpGaele4owFI1+ezxP/p3wIxMb8eMJFr5ykJJvyCS6H@nongnu.org
X-Gm-Message-State: AOJu0YxsWSJME0DvbARBrGFnw+1QQrXBdEIIXCQTjL7DdXgsiWxzOgVR
 dCmyFnKojBmLvLEUhULfBmq8oDaNzGUUIrlE4IdxNc2pVEUn8kYX
X-Google-Smtp-Source: AGHT+IE4w50uuU7dEjW9unNDc65rOX7MfH3nc2sGkKI9teFEIjvZILC4zAQkr7N4hLss8n30Xxgmpg==
X-Received: by 2002:a17:907:1b1f:b0:a99:e1a1:473f with SMTP id
 a640c23a62f3a-a99e3ea59ddmr811732366b.57.1728906224654; 
 Mon, 14 Oct 2024 04:43:44 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:44 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/8] chardev/char: fix qemu_chr_is_busy() check
Date: Mon, 14 Oct 2024 13:41:28 +0200
Message-Id: <20241014114135.389766-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
References: <20241014114135.389766-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x629.google.com
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

`mux_cnt` struct member never goes negative or decrements,
so mux chardev can be !busy only when there are no
frontends attached. This patch fixes the always-true
check.

Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index c0cc52824b48..f54dc3a86286 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
         MuxChardev *d = MUX_CHARDEV(s);
-        return d->mux_cnt >= 0;
+        return d->mux_cnt > 0;
     } else {
         return s->be != NULL;
     }
-- 
2.34.1


