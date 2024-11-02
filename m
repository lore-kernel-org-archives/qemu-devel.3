Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A571E677FA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 11:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7C17-0004vf-PZ; Sat, 02 Nov 2024 07:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7C0x-0004tJ-0o
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:09:55 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7C0u-00048t-RF
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:09:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so325607566b.1
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730545789; x=1731150589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bn41lV8OWrMbF78lEwpUR1Om6rYilhKSEGly8aX69dA=;
 b=kasUKJJzY13UEtqy5lZDiX5MGFu+OPa2uQxcgTfOSpz5i2RKQB2mOL4e1C/CbjYOgK
 n8SC8hieOTXV+tY4TOMecp9xS90yiefoZzvsBuga5OTzyr7oRMDxPkGBoSkoKcraBrmQ
 Liee1VFW8dT0MLgzDXvkMZiZwVk81SXvil49JW7kVGrLHbMWusRViEKvYCv73+Bi28Sr
 JNCt+yMjRAhaU/v/kmxjoogYDqJnkj10G9wCnF3IfYnunUNs7TyK42GkS4xC1ffxyKqz
 8J3zpIa2sKIYHdOKVRnu0EBNrhjhKX+EuG9yz4SWRiGYxWlpNtpO7YCdwYl+10OVSlc0
 hSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730545789; x=1731150589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bn41lV8OWrMbF78lEwpUR1Om6rYilhKSEGly8aX69dA=;
 b=mcEPj/lJTkbLTBJ17JRvtzEny7J+wKHqfxgXm0Bv73oCXHlLFSIdSl3ip+xf41rCzY
 1PffPMhToQ8m4ONzC4PJIFNL/y5xi2NqLUv8B82Hp+SihlzI/z2H/WsIVFzvociEjZ4d
 YWM3lSwe10S0Cm5tJEAxWiVEFzVOW4XDRVWg2ZmzjPJn5WWU2rAvgvoIA9ah4Zo01ahZ
 YQnI+C8qxyidMqggFpTDdS4k2EfF8lIjc5y0JHkbyqDctN5DXcA3ZtEgzenBd0HCRKIM
 wn/+v9Z1qPXxgwDQ33GxeYSnrn3kkCYYCZ/Mcq4puFz4pZJroG76UsWkSH9oLVPvywUC
 jsuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQM3ZwueZhwRBKjlqD/pZJd2m+5l+RpXIrTvPkAlpmzuWJ9b3ajZ8gPJ8YETYSCs5INB6py2F5U9Uh@nongnu.org
X-Gm-Message-State: AOJu0YwlIWx0LWoUO8KRt6R8CtJOa9vGVdskTr5eb+C9xIBeThp1bn2R
 RvUCuAvSkkM8Ur/e9nUxJYh9CvLvMZYEicsphtnbxTV+gxu1m6v1
X-Google-Smtp-Source: AGHT+IFiq80po0X8NeDtcqtbGc8S/P+JDA6Ce7Jbo3+KGh2p/WGFiTF1tYE/bNPuqVppe3Gh2kGnRw==
X-Received: by 2002:a17:906:c113:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-a9e508a9546mr1052955866b.11.1730545788778; 
 Sat, 02 Nov 2024 04:09:48 -0700 (PDT)
Received: from finn.fritz.box ([185.237.96.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e56684912sm294991066b.200.2024.11.02.04.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 04:09:48 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] chardev/char-mux: shift unsigned long to avoid 32-bit
 overflow
Date: Sat,  2 Nov 2024 12:07:18 +0100
Message-Id: <20241102110719.682399-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241102110719.682399-1-r.peniaev@gmail.com>
References: <20241102110719.682399-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62a.google.com
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

Allthough the size of MAX_MUX is equal to 4 and likely will never
change, this patch changes type of constant to unsigned long to
be on the safe side.

Also add a static compile check that MAX_MUX never bigger than
`sizeof(d->mux_bitset)`.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index bda5c45e6058..355520714979 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -316,6 +316,8 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
 {
     unsigned int bit;
 
+    QEMU_BUILD_BUG_ON(MAX_MUX > sizeof(d->mux_bitset));
+
     bit = find_next_zero_bit(&d->mux_bitset, MAX_MUX, 0);
     if (bit >= MAX_MUX) {
         error_setg(errp,
@@ -325,7 +327,7 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
         return false;
     }
 
-    d->mux_bitset |= (1 << bit);
+    d->mux_bitset |= (1ul << bit);
     d->backends[bit] = b;
     *tag = bit;
 
@@ -341,7 +343,7 @@ bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
         return false;
     }
 
-    d->mux_bitset &= ~(1 << bit);
+    d->mux_bitset &= ~(1ul << bit);
     d->backends[bit] = NULL;
 
     return true;
-- 
2.34.1


