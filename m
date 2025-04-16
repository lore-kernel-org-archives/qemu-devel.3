Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40897C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4y0z-0006tf-76; Wed, 16 Apr 2025 04:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xxg-0002hW-Qt; Wed, 16 Apr 2025 04:17:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xxf-000628-8i; Wed, 16 Apr 2025 04:17:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so5949267b3a.1; 
 Wed, 16 Apr 2025 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791450; x=1745396250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p61XeamrPryy5y8KZD/my/LXyq845Q2ZSQbHbgzzrSA=;
 b=DTrPu4QtspWcduqt7XhmyWRVq531YxIFdxLuwHBpufCUrulXDZPsqQkRL/Q8Tksi/I
 4EM0CqqvzGZwe4UI+9jYDYxcqFi0mMT7LA448t2mLDI8XM52jzBQLXHE4Qwv4DnR4wME
 WhCnTNzwutifFFR/bG0UVRl7NVE6aTenYTwXOmArCpVnYT5/XcvXlUmF5PojikqwQVH3
 FqRSbl1qTf0/u5rzct8uRFXc8z5896fFHFvoLw/1s4+DPYdVnQSUDblMsnW1ZSZDvp55
 sy9pwifAelo4ISonID84V/DvG9CvoKsA2dZz2Tr1KfFeoWglO95/BgMeGucb6TFKCb+b
 zofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791450; x=1745396250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p61XeamrPryy5y8KZD/my/LXyq845Q2ZSQbHbgzzrSA=;
 b=hFk6KDIe9ada/JlV1/+0vakQXwr/DzZO7rXT8U02ezGhvRLbI3qWS26uIfKsNC0zYV
 GLlcuBbfNTxV67Qrw68qYiuH4pnJBcyBnvpGE9GwG9xwt9Kyf0Hq/iEylb6DT/6dfF0O
 Unfte71bFye6mcCrA83Dbu3Lmmk5FJmdQBUZX8Vhv19TH6146e8Z5lnnsLzyA3Qm2aYn
 Koj9wUskb/ksOl2SW+qBPrPHckCMxLm8pivFYdXwjktkpIVM4tAzglR15FOVAIYebXHB
 ClXGMbSFNuw5+mp5GnkhMEekPfPKad/F2K+zmqp1oTAPMmwUFkeSe1vq6APrB6gyIBEL
 2Hww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkN+ZVenvN5LqeTDgi+Oy6Qdub+/1GicHf6FVjWqHtiz4VD03lNzIePoaUx4Hts1QN1Fq6OTt+NUN0Dw==@nongnu.org,
 AJvYcCVhHZA/6Tjy4Ih0mUSGQvpA2bK48PJadhy1NXmuReTUtTXjqwBpqXytiEFT6k7VRejmix8SCDIZvQ==@nongnu.org,
 AJvYcCW9eXbJEOE2yNiJlaTDlF8NxKiQG3Gwr0afj+6dFBvK/bImK4Ynq4W47GSpiSCIFELlS/qF803kXS4=@nongnu.org,
 AJvYcCXduc4Wqdgj4b0PCQzFM2NoasMM2CoZmzZx9bAXtaLkQKVXj1tV0ck5oZXWpHjjXqiw0ouKw4tLZ9OiEg==@nongnu.org
X-Gm-Message-State: AOJu0YyvPyrx/nvaJfm0KU6TNR5KKuvBq5DAmTo3SDfpJd4pivtQz2rW
 gGOS68kcWNcTRwcjbuJJ/35wAZmF1C9Jem9/c6ogxrkHRKj0cWXKRZXgTfKR
X-Gm-Gg: ASbGncvmttbatwmRfVX4eTILeXB1bK+buuv0wbn656sA2B0nm07o/CrJkqcP7QVwW1+
 Mz0TNyXa3/tV4eEmU7ph6mbuSyY4SD2yWFNYz/skAnXe3j/Iv2rQANovqzErahKE+3jlTNWQRkF
 ooYPa68SZzoH/yM5v4MLmwKr6U5h0Oz2Ys4MxfudgcuV7hSsoFH0wJjp9N36Ku9nEui0W3QpRJf
 T+iEKvUI1oJY9b75j52KVwV9qDzUurq7IrB/m0hToTWHD4b2kIqQYXw32kdMkisHSDhZggZrnps
 klWMEa3Y8wxC9iEAuMyuaiN+brg66NpLgJETF9Z0TCK6g5tNZB/kyH2WTnTZ7ffhoxvW
X-Google-Smtp-Source: AGHT+IG+HhXY9MccZflP2IGJae4uZu0y23mzWOU0azhXj3wrV5kpmm22SzyuVnini2IXqkIH9KI0Sg==
X-Received: by 2002:a05:6a00:2e84:b0:736:42a8:a742 with SMTP id
 d2e1a72fcca58-73c26735170mr1091929b3a.11.1744791450203; 
 Wed, 16 Apr 2025 01:17:30 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:17:29 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 19/19] MAINTAINERS: Update MAINTAINERS file for wasm-related
 files
Date: Wed, 16 Apr 2025 17:14:24 +0900
Message-Id: <185cfff812b952abb24e25dfcc8bab7c65da6214.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..74a102c594 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3903,6 +3903,16 @@ F: tcg/tci/
 F: tcg/tci.c
 F: disas/tci.c
 
+WebAssembly TCG target
+M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
+S: Maintained
+F: configs/meson/emscripten.txt
+F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+F: util/coroutine-wasm.c
+F: os-wasm.c
+F: include/system/os-wasm.h
+F: stubs/emscripten.c
+
 Block drivers
 -------------
 VMDK
-- 
2.25.1


