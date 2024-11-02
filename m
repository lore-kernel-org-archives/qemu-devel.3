Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A0E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7DhN-0004Ls-Jp; Sat, 02 Nov 2024 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhG-0004K9-IS; Sat, 02 Nov 2024 08:57:42 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhE-0003X1-U0; Sat, 02 Nov 2024 08:57:42 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso432236566b.1; 
 Sat, 02 Nov 2024 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730552259; x=1731157059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mx+nl2IW6DkUrQc3MJ4fS8N2lPDs89yRdABbw5KHKCs=;
 b=iYqTr+dmBrFDPbvB3563KDcSLNQ3ocqJp4gJO4Rkthu2YTqn9YgANWoMNwwNVHpdz5
 QzXdj2NUAAOsEgwy3vP+H1KT5P6ZlWhnHaDFtiCQR5fSp8q6yA4L4nYzFbxE+DsbM7xd
 ZBLcMWIsCmHkaJ705M5JLt8c5l6dUkDs8RLRpuU30OnhPVas6MU2HZ0QseTMiG/kJ2Mo
 jlPltxBtjBib0FrrIIwuvlt4KZvISETg+5VzXm9//mozn6fNaS0qLC/uF053AlWZ4F8n
 6+naYVfZUs6XWpRdSHqV7J9DuQU/D7oJ4TXjqK25S3UWt2wWaSKWzH2TFO50NvgXYKrJ
 jm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730552259; x=1731157059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mx+nl2IW6DkUrQc3MJ4fS8N2lPDs89yRdABbw5KHKCs=;
 b=O1HyXIc/f81OdqlF4w0QDN5f3JEkVNwUVqo3wo3K5RgzjUGk4FDdzxZ4Feda7MSGgj
 VYC1C8SbheWxTBgBMaWKfHhnsHAaeyCTlKBpRSZRfIclYPw43gFRrOB6NwBX7zbWtwQl
 gj/bvtK20fUtpSCnYp+9ex2VyTPyKKkSPppraR2MbNkE0LEu3N0msbQLFZO48aUN8CPz
 JJig9J8zR39HM1xllZk51LXS3JPAhFUDFG5sgPPX0IGvRjAixEtX+Si76EE0CTITOW9R
 mpKyU4/wU9YWP6WkTIRu+TbCdVkdpFGzAavl6lQy5z5+L32AE3l+4auUcHwvoQ1wumY7
 llXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhkB6KPuqKrcCsh3v7Oi2na3yVTOivnDMcv38JgFZSylqKbF7kQzbymaMMR3riKiM4vojmqP8hkg==@nongnu.org
X-Gm-Message-State: AOJu0YwCnXm6Bd20MsDltJAL92cie+H9CjGggUBkFrhcakRktnMow+BB
 kQtqGw+1xo19qCejAkWVtY6sfa2YLmV2FK2oxgN1mqG+fHjJr/T8Onz8Ag==
X-Google-Smtp-Source: AGHT+IGYVWdqoqKX4lchw/3I5lA7Q8kKq276xS3DBKxf3NI0T1nZYpmnYOjIf2Ub78WWfBUc6CQLog==
X-Received: by 2002:a17:907:9719:b0:a9a:67a9:dc45 with SMTP id
 a640c23a62f3a-a9de5d6eb93mr2624029066b.3.1730552258571; 
 Sat, 02 Nov 2024 05:57:38 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e566846a7sm305836666b.206.2024.11.02.05.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 05:57:37 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 3/5] hw/net/lan9118_phy: Fix off-by-one error in MII_ANLPAR
 register
Date: Sat,  2 Nov 2024 13:57:22 +0100
Message-ID: <20241102125724.532843-4-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102125724.532843-1-shentey@gmail.com>
References: <20241102125724.532843-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Turns 0x70 into 0xe0 (== 0x70 << 1) which adds the missing MII_ANLPAR_TX and
fixes the MSB of selector field to be zero, as specified in the datasheet.

Fixes: 2a424990170b "LAN9118 emulation"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/lan9118_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index d2dcd732ac..d8fc9ddd3a 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -54,7 +54,7 @@ uint16_t lan9118_phy_read(Lan9118PhyState *s, int reg)
         val = s->advertise;
         break;
     case 5: /* Auto-neg Link Partner Ability */
-        val = 0x0f71;
+        val = 0x0fe1;
         break;
     case 6: /* Auto-neg Expansion */
         val = 1;
-- 
2.47.0


