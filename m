Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DF6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu0-0004jt-EC; Fri, 10 Jan 2025 08:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEto-0004dr-9r
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:04 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtm-0004hz-17
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1104061f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515080; x=1737119880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gORGJy2GCY2KK1VZjuEcImpumochX7MYm18gsh46kk4=;
 b=uYI9j8MITQJm82PGJQcjBcoPdMSREbYlBxuZAxxwzlOdUZ62bMXJRLcob2n6ivYbDf
 46o+E4fIpkVc9pGDFiVG67jAMEQ56OFUIpumcX3ZW9kUdXLL1PZdXPIwyJlYc1tZAo9C
 WX4bEbRMO0+DmArS1hWQ9ekR0z+6BN4Bps95mSUSEYHAhw4OZaM4lj+/+OXHufTbj9AH
 zqCWf97DwNAStFRuzGJGITIOsbNrv1Bzv0EinoYkxG8ryK7eZ6R9Qpk6d3omsX0yGvnS
 BLi4Je426lR5gWOKSGcSBCTMbCNPv10XmaE85UXUUDA4g/SM4g0nPpQ2V0NtQ0UKADL4
 Jejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515080; x=1737119880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gORGJy2GCY2KK1VZjuEcImpumochX7MYm18gsh46kk4=;
 b=aFVZ5CFsKRRT/cjEX1O89fmwcPDiX3PcXtrUK02XKbnl82yo7ZCJltaAnV3Gthi/nS
 jNXEHEFmKLqA083lDDHnfUcatfmtCoRVFF6jH00vdum1i4g8J1HTnH9F1BxF6t7jxdsT
 OXTpmIYELZcrq2Mvz3yW/xj5F6nDAujTtxKVfTj44OZub1h0oCApIEBPGMSqiTyi40Dw
 Wm8ejA0L6W+dpJSzVgkIBftklfHZje2G89dSP+/iLqlQOnA6STAIKPejneBHm4iY6VtI
 3JmFDvZmqccC2mUVIOUPskge6w+4abNllsHl40Ap/nFn4OJXkgjFHh8d84O5m25L/W1R
 jH9A==
X-Gm-Message-State: AOJu0YzZDm7lHiEV8Pf0SpggkBd5Sz6vM0KR2vpLLXJb2rCUrX6vVsTq
 gRuonYHehNTZVNizuFqT0F9l5TfRAbhcMSYkHI4CxxBagAJk47fHu+xlBUmaZl8=
X-Gm-Gg: ASbGncumeMXd6EnvCh8pP/yeCYttWhrF/1VIToFScgd13Gf3nWibxv+4kQn6OayfCwj
 06vo82iFPREg3QMG42fjHAFhhjNWB5RtUn5h6VLweZGoIGHUvabcUuRHmHAiPNeKfoOe6mp65iT
 oFAeCwEUVL9Fq1EHMbBNFyjMUf3C/nnXTfJvEteXmYNAEe9K+zNKggMuiAJZAgTRn5EAG5RzzI4
 Tim4jSmCFS5lZ6aNDfIjf0MadUMjdeKxYGd6hH4KVJhr9RNKlbF4R4=
X-Google-Smtp-Source: AGHT+IFnOtyXIJMGt8cYX2xcVSe2KiFsQ5YJOLn3Oh/998qIN/+RxTS1EI8cfi8rnhu1VABryuIyVQ==
X-Received: by 2002:a05:6000:4024:b0:385:f220:f788 with SMTP id
 ffacd0b85a97d-38a873556c6mr9960215f8f.48.1736515080027; 
 Fri, 10 Jan 2025 05:18:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92f60sm86260255e9.40.2025.01.10.05.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CE5F95FC6C;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org (open list:e500)
Subject: [PULL 08/32] tests/functional: update the ppc32 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:30 +0000
Message-Id: <20250110131754.2769814-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-9-alex.bennee@linaro.org>

diff --git a/tests/functional/test_ppc_tuxrun.py b/tests/functional/test_ppc_tuxrun.py
index 50b76946c4..5458a7fb71 100755
--- a/tests/functional/test_ppc_tuxrun.py
+++ b/tests/functional/test_ppc_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunPPC32Test(TuxRunBaselineTest):
 
     ASSET_PPC32_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/ppc32/uImage',
-        '1a68f74b860fda022fb12e03c5efece8c2b8b590d96cca37a8481a3ae0b3f81f')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc32/uImage',
+        'aa5d81deabdb255a318c4bc5ffd6fdd2b5da1ef39f1955dcc35b671d258b68e9')
     ASSET_PPC32_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/ppc32/rootfs.ext4.zst',
-        '8885b9d999cc24d679542a02e9b6aaf48f718f2050ece6b8347074b6ee41dd09')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc32/rootfs.ext4.zst',
+        '67554f830269d6bf53b67c7dd206bcc821e463993d526b1644066fea8117019b')
 
     def test_ppc32(self):
         self.set_machine('ppce500')
-- 
2.39.5


