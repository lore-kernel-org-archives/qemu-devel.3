Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3928AD6EBFD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGyJH-0005rr-DG; Fri, 29 Nov 2024 05:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tGyJF-0005rO-3l
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:33:13 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tGyJD-0001UW-Kt
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:33:12 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so304762566b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732876390; x=1733481190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXJ6HW1nN5mggE0fLVWeH4H4Bs/Jql1OpaGTmx1GQo8=;
 b=mephaf4kb4izOnqoPNPr6b/Z0zaUiG61Jmo+hWD0oMAg2i0gB7NYTnX5Gv2QXR5XEM
 96WN6nDWo1XeZWPEaWx3T7E/GOcXebBo3/V42I5Cvak7Qf00yX8KibPMw85xXJOMU6Eg
 gysSaQVsp2YYpE0ylGBv4dSluxPbNNoZjPIFjm4RkLNOmkyMoCFpIwl0FrvuGmQ+vT6M
 WzmwVcdm0rU2RZDHjQW61XEFVaWybLtTKSuHEfVevTUmaD/aad0Yf0brCrZMZl0Y+7xZ
 Gd/PW0XrC8RtYH9Gojn6yrxj7n8BWztgmse7SeUg+i/YKaT0E+j+eJtgc0H/aN8d324g
 ydhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732876390; x=1733481190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXJ6HW1nN5mggE0fLVWeH4H4Bs/Jql1OpaGTmx1GQo8=;
 b=G9o567OZalqcoTurrL43ZkD2g//MRGyoYJrIiUW7pW0HAKGCQNQHc0YyojBGZR4ays
 +X+BMsBIqcofnisU1qpx22dpnqH0f3wDmdoVF7T2VQwYjnNQ2uMOe4UkI7IxybMu1TPU
 g2gHYqbixHIAcMZ+A42fNVYx28Mhpo7jCXbtQ/TBN77VTRSxbkKw9iAcUli31JwGsm6U
 +qfxqbqSTVRGWThuwrKOPEzeuB4e/ftEwynW/5S9wiU9FXh30Wq//TMfoOhaScVO15kR
 3QfkKIs+3+70PnPn6cEbJ/oWrQTi6UvYz28+yVIO6TajRlDtkrQay7G8gtlJZMKHK4gJ
 o3AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXasb646ZrHC7bSOdpy3lEgIOcyYKJwuzcOZLQ7nRGdh09G7deQ6QnkRLBDPdhuhXawlopLVg+HhjHB@nongnu.org
X-Gm-Message-State: AOJu0YwErLpjXgzKS6pSIVmvmKDWN+5tW+mbEwq3qMzi32Vm9JteRr+J
 YKWc5sH51rz+ww/bROCoDQkBFD+BBL8JdkhVZX+mxXDBXIx/R47E
X-Gm-Gg: ASbGnctQFH7q3MfTGv5y3t+ARtldbBCERbiDhC1dDxWKVOV9r1sFE7acwY8LNQLlHxR
 Esvjcyet18fGm49Xw0iBPzTLfxDfogFgQLtrwGLqmwnmylFYYE+tlaG0jcRCFA86HbRSuqTLb98
 HSQ4iYJM9o99nsOEvzfl31ATqwAmJNnihtfKDFWRKBt7QfRsMysbrpGTU5dbd2nFy7t3re3kfS4
 X4zxM9DBsNSGTEPiZ9wiLrdxrT4TXXCivROUJMQdpjItCtYHHPWw0nPgic=
X-Google-Smtp-Source: AGHT+IEQVv6woXeDsHkvJ5y2fGtiXtJqlAK2NvGRMO6u74vpDHUqaK/QeiXzyahSd72ojN8vlkaang==
X-Received: by 2002:a17:906:310e:b0:a9a:76d:e86c with SMTP id
 a640c23a62f3a-aa58107180emr1033661366b.49.1732876389923; 
 Fri, 29 Nov 2024 02:33:09 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:4166:755a:3476:5f1c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599953c81sm160300266b.184.2024.11.29.02.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 02:33:09 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] chardev/char-mux: shift unsigned long to avoid 32-bit
 overflow
Date: Fri, 29 Nov 2024 11:32:38 +0100
Message-Id: <20241129103239.464061-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129103239.464061-1-r.peniaev@gmail.com>
References: <20241129103239.464061-1-r.peniaev@gmail.com>
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

Allthough the size of MAX_MUX is equal to 4 and likely will never
change, this patch changes type of constant to unsigned long to
be on the safe side.

Also add a static compile check that MAX_MUX never bigger than
`sizeof(d->mux_bitset) * BITS_PER_BYTE`.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index bda5c45e6058..9d67b8bd9ab8 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -316,6 +316,8 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
 {
     unsigned int bit;
 
+    QEMU_BUILD_BUG_ON(MAX_MUX > (sizeof(d->mux_bitset) * BITS_PER_BYTE));
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


