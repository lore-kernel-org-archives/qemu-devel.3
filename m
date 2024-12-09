Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD3EE77182
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVS-0006Oe-TI; Mon, 09 Dec 2024 15:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVB-0006Gz-It
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:09 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVA-0003F6-9N
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:09 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa67af4dc60so282399566b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776627; x=1734381427;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krA8fyL06OMuWhugQwkTM4Lyyjdxb/hlEgT8wYfNtek=;
 b=DkUsGM+KIIwkBxED9MqBqpJHwgDBcD6lkysQ8SbbbwolQElrnW3/7Zzyhz+CfULahK
 n3RHaFywC/Cl+OAlKteWSRlmkiQaXWa7rxOVJ2YqNAPVQVXhZYayBNa64QnaKWx6EKMC
 /qHShBzTzcBmpICw1sm3RU2iP+0aDyMFouSEacD+Bl3a2Ra5HPXrjtsn5ilXfPr4cT8Y
 Jz9hvjZNXKb9DhSxKnCr3pHsQIdIB5EyrJiGDVEdHcGxVPoKjXqzF6OXz1H1Bl/34ODG
 HHk4cGidKyf/lv6K6IUXe1C1wOnPDjm5RmBNU2DBsECZW2FbsH1COgWQgGLoE0VlSw65
 6r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776627; x=1734381427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krA8fyL06OMuWhugQwkTM4Lyyjdxb/hlEgT8wYfNtek=;
 b=wU1yLiNiON3UYvtVlAJBopSDWDCJJTSq45iSAAgSnR8FhqDDYlmBiNwXfa7obqU5wB
 ii7Vg+9BW5qQ9bGArIJ86naKf0+BSUp9fmLdXfTcWsWLbdvP64ip+mkC9/BFdhhoHFfN
 G78jPRbJTJozRZo4EnDCVdjWKreODV5AnS9NsrFqh30VbqSYbGR1UQE7R3oYZIk5VhEe
 nKIfZIsRGlqIGsl99CuwWZEF5gugE1qHUWggojcOp1wvXvjtTjno60LI/49wsJqNWvzV
 mzL34LKJAmTYokxFwHo36OgalTfr+1jJOWO0PVyaXuTh/KVeqFAsx2dg0s5FoCbiprEM
 QXAw==
X-Gm-Message-State: AOJu0YykmxOcYlpKytd2GPzC/B6IZrAUToYC5GrHhb2c1YFL/ZVBBHRV
 S+q076x6BEoccg6BYrmOrI8iV3AX9/A7GsBKXAomVThAa9VjP+1DPLYoBmClBMf2+k/olwyFkrs
 RmA==
X-Gm-Gg: ASbGncsrZHdztH+8vB9h9/FtoP62kOat7IM4tl7vtltEdLN6MChllmsAxZ3dxD7g9iy
 i6HGKgB25g70KsqPorfdAJNFwefGn28LLQy2il6MlPaXhqAA3ZQDJ6EBItlkcbM98F1toNwpypa
 dV5wToGnEzWCCylTG+iqm51QJhoAi2er2omAoe7HGA87BUI1TK+t9FRY2FqiFSY2r/KDFU9A4UR
 jWuVw6ustC/oXPqsvwMpkBiFlcU+KXQ/oA/uS4HiD0ErwPlPJg/ZHXLad4zfOoS8ho5H9aC/x5E
 7JEMOz+fSauBFtII5G3sq5qNofwvkQ==
X-Google-Smtp-Source: AGHT+IGgYAERzRBwAhCxDsdhEYv5W+Jsd6e8CC7QdEOBvUYGE+tR8QXY7+Jt1+n08n5gXMqgtFr/ig==
X-Received: by 2002:a17:907:9554:b0:aa6:7d82:5414 with SMTP id
 a640c23a62f3a-aa67d825937mr591543966b.30.1733776626628; 
 Mon, 09 Dec 2024 12:37:06 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:05 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 08/11] i386/hvf: Variable type fixup in decoder
Date: Mon,  9 Dec 2024 21:36:26 +0100
Message-Id: <20241209203629.74436-9-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::636;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x636.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

decode_bytes reads 1, 2, 4, or 8 bytes at a time. The destination
variable should therefore be a uint64_t, not a target_ulong.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/x86_decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 79dfc30408..6c7cfc820f 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -61,8 +61,8 @@ uint64_t sign(uint64_t val, int size)
 static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
                                     int size)
 {
-    target_ulong val = 0;
-    
+    uint64_t val = 0;
+
     switch (size) {
     case 1:
     case 2:
-- 
2.39.3 (Apple Git-146)


