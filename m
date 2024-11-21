Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0AFD7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAde-0000Dc-9f; Thu, 21 Nov 2024 12:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdb-0008JH-8H
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdR-0001bW-CM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so9587965e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208787; x=1732813587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2cXoagg5snV6gxdAo5ZfjchRqkc6JtoTLiiI4l/hqk=;
 b=dn3pCMwrGZkx+rm6vtUWQgXXSuizfv0bQ2yh+60TOmmHoymSHiDXiuRvyCsVEe9krS
 bcFO0khR/80xwFWcoW0TgNkHnpEguyuab4N9pYnNhPywnuggtXjBq2doqnV/JcFLoozr
 8nXXqSiMVV2QgrjHpdI/1wWtPRgb1oXU6XrFvfwK+EY7qG+0i7nJgYqEa7oVfIdOkpkK
 DEYewKg0+qdIUQl9HJw2S+A9ebW5AIPpRenemCdLkThcVs/EbJtgb5tMj7umgQDc6iA7
 JxswnXZ9aR5Ij0g1bw0pMZS0OWtd34PSjy8NcBxz6uH1fdFzH7rGKsxPGvXaeHcXmGN9
 wtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208787; x=1732813587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2cXoagg5snV6gxdAo5ZfjchRqkc6JtoTLiiI4l/hqk=;
 b=ZUHXfpQPzegW4PuCSvwum5KkkZ2ON0e6nQbMxL07OigaMIc/sLytJxIOFoJWgumYmb
 J5iXNjFAo7fEcfYIdobnuHL7FupotttImtPdjiQHs5JXUVfozT4RHUrgeib5MP6GBe2+
 yU53BEnyiqg4+VoAk2YEe9sF4UreqhLhOn2KZQEBAclsw4uYlBoWS+fRNKl5LyLmLvrv
 VBWyYTDcK8CdPJV0qnu4wkUPXfmhhZGG0jBAAM6RX9OgusciA5cmzaRxHi+LkAjfFNNV
 dcVQWuR74FcBSRKYbd+ZmwuhE4tRYN3ej0Q/m/NlPFo1ExEfDjlLEEmL2NXSYCU6PXrO
 k89g==
X-Gm-Message-State: AOJu0YzhiHCJT7XBzqdQzbLtqM+FLqOFzXJyDBLaE5qYhu1XuvBAPHK1
 o7D3BsLVcj91uXiaZhLEkhFsnrDV0BspthcnjN+m2aSi90lWuawpmvV4qUpZM/U=
X-Gm-Gg: ASbGncu5QArTaSi1oray+ESAJYFWLebErqEy95RE0ZLOGOSJ0tnX9Ennv+u8txPCz88
 e6yo8VafJpqdTrTmGAszY9XZ1kYbi7rtWAieqs8XWlN5PPfTcwIX1CcAIyr7bVOR6k/WKTKnsaV
 Yh6w5FJvu1mzLMS1AMM+bT1Yx4dm8toA7f2K/bCqxFROLIXTdfNXEFZY/AMAeori9S6l4a0bK9I
 D2Zn/QOZ2MWH6pEjgCmMDDanmWHyXFjLT8cLy+xGrfaoGBL
X-Google-Smtp-Source: AGHT+IGS8oxFqM8nBpxBZmpDH9qtzJfwcGP7wntLdgJWAQOszTwiOI0LLAGIHD0qVfYkjRuCJolIOQ==
X-Received: by 2002:a05:600c:c0d:b0:431:5194:1687 with SMTP id
 5b1f17b1804b1-433489d4a00mr69349705e9.18.1732208785570; 
 Thu, 21 Nov 2024 09:06:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46426d7sm61115695e9.36.2024.11.21.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5435E60435;
 Thu, 21 Nov 2024 16:58:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 21/39] tests/functional: update the aarch64 tuxrun tests
Date: Thu, 21 Nov 2024 16:57:48 +0000
Message-Id: <20241121165806.476008-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now there are new upto date images available we should update to them.
With the new rootfs the blk I/O errors also go away on arm64be.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
---
 tests/functional/test_aarch64_tuxrun.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_aarch64_tuxrun.py b/tests/functional/test_aarch64_tuxrun.py
index da56aee4ed..75adc8acb8 100755
--- a/tests/functional/test_aarch64_tuxrun.py
+++ b/tests/functional/test_aarch64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunAarch64Test(TuxRunBaselineTest):
 
     ASSET_ARM64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/arm64/Image',
-        'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64/Image',
+        'b74743c5e89e1cea0f73368d24ae0ae85c5204ff84be3b5e9610417417d2f235')
     ASSET_ARM64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/arm64/rootfs.ext4.zst',
-        'bbd5ed4b9c7d3f4ca19ba71a323a843c6b585e880115df3b7765769dbd9dd061')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64/rootfs.ext4.zst',
+        'a1acaaae2068df4648d04ff75f532aaa8c5edcd6b936122b6f0db4848a07b465')
 
     def test_arm64(self):
         self.set_machine('virt')
@@ -32,11 +32,11 @@ def test_arm64(self):
                            rootfs_asset=self.ASSET_ARM64_ROOTFS)
 
     ASSET_ARM64BE_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/arm64be/Image',
-        'e0df4425eb2cd9ea9a283e808037f805641c65d8fcecc8f6407d8f4f339561b4')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64be/Image',
+        'fd6af4f16689d17a2c24fe0053cc212edcdf77abdcaf301800b8d38fa9f6e109')
     ASSET_ARM64BE_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/arm64be/rootfs.ext4.zst',
-        'e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64be/rootfs.ext4.zst',
+        'f5e9371b62701aab8dead52592ca7488c8a9e255c9be8d7635c7f30f477c2c21')
 
     def test_arm64be(self):
         self.set_machine('virt')
-- 
2.39.5


