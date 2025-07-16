Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5766DC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 00:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubpyf-0005W1-Kd; Tue, 15 Jul 2025 20:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubpyd-0005T1-Iv
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 20:26:27 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubpyb-0002YW-S8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 20:26:27 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7e0d65a87e8so329588485a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752625584; x=1753230384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oxgqE0WCspBFRJxj7t9XnY9yStgxjGadVomj2GNaNB0=;
 b=Rc4l7zC4fZt40jrp8aUpETCSLEMrIoJvihMWpsPmuz4dUnDg1lapcEJD2UK13fyPmu
 Y6vqMwWWPpoy8+DDU5n2XGMQBd2nsOFsbsI3acj1EAA8Z68bK82G5pu2ykxA/dtqc+au
 qbAE1YLamo98cD4i3SbweC2rOHNche+dvo/v2PeEHtP3Y5sQzI3lKdQYuZDKLy158Sxn
 +mtZytGNQ9dNsqLyy8loDeyc5esNXst4GaRyyVSb59j3n3zb2Ha1pCpHkXDg4OWENfWc
 IoQZioUR8kTnjZiuZA5fdiQF7EkB8Wmn27sXRUOJ5GcLplQh1HxZwNMblcnpoqbtj2yw
 jSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752625584; x=1753230384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oxgqE0WCspBFRJxj7t9XnY9yStgxjGadVomj2GNaNB0=;
 b=fnfp5HH01b31fLTxvrQGDY49SbMvQ+NVmvx5AE1kVFDzpGYchm6YAgDRlq8uDY0e3H
 ct9gE2scJXx9nJLacIi2CN3Ri7UCPHGRy/AsFXzZiv3NGr6mZeij4O+nDyYzSG3Hzakw
 fXVR9Aqf96JrMIYQ9+KR/8DJqPy5p217BBZ69QzC3h5YLgoIqJTffFFFuUvK6/c+7eFL
 iXHJFc+1whiQSspDOn8H7zVHivyZxWcthQ1DYMkOPqRQSGs5X0H71QNgqDJlZZL/ChxC
 Y3GalesiPMBInGbB+hnXLOaAKnWuvzP6jO5d6AdOCB+1fym/X1fyJ4NltREz/mkA3Aig
 ltXw==
X-Gm-Message-State: AOJu0Ywfxfe5YBksxeoipjeyvWcocnaNJDcHAC22wOH4jz95FYm6UEa6
 b4TyXiq6jKB6W2xJ37z+/e8E6PMOX8wq0AhRV4lswdUcNzgwi18bF4ZBHDmQEA==
X-Gm-Gg: ASbGncuWMPlQxbL8X9RdkPi1Ge8lj+jJT2UbJ4aSbnP+b9eyw53ObaWBJKlJysLc/jm
 RD0EI37cjYbRHlkQNq1ZpM8cN5QFODI+hDBvDHYBGJ0zzd534rzkiSqsRH76uczJ3AIU0q6cYG7
 203QiDARSlJLLq+DiNQq3tEmNEjcoTxtERqwrWDFGVLpdLaZVry7dNhoDoM7o9Hompr5w8Ffy1O
 dlM0d4I1Zge/9c8Ftmps8rMuPPD2OVfgFynVqqOjmMbOzSYg5IHyQtUZ573ucbHWLK8dGuF0ec9
 ifwoqdmottI7BTCjdPsE6Dz7Q4HcpKqIklbtfb9Czm20TZBCgLGFk781VwcClbS4jfClSJXSDCY
 nfAH/hTGNphA2dYAXtSoC9+xOWSbXvXgZoYjA//HVonqitDQ=
X-Google-Smtp-Source: AGHT+IHq2EczeakNZa0HOtcvAg3bxjhAtvPq9eIyHkBLZSCfR3PBewVFqaGEkTYjzQqVrSc56VPumw==
X-Received: by 2002:a05:620a:4445:b0:7d3:c4c7:75d6 with SMTP id
 af79cd13be357-7e342b6838dmr193955785a.47.1752625583800; 
 Tue, 15 Jul 2025 17:26:23 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:cc77:a278:6e60:d8ba])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e1861fe700sm382830285a.99.2025.07.15.17.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 17:26:23 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] hw/misc/max78000_aes: Comment Internal Key Storage
Date: Tue, 15 Jul 2025 20:26:22 -0400
Message-Id: <20250716002622.84685-1-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=jackson88044@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Coverity Scan noted an unusual pattern in the
MAX78000 aes device, with duplicated calls to
set_decrypt. This commit adds a comment noting
why the implementation is correct.

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/misc/max78000_aes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/max78000_aes.c b/hw/misc/max78000_aes.c
index 0bfb2f02b5..d883ddd2b6 100644
--- a/hw/misc/max78000_aes.c
+++ b/hw/misc/max78000_aes.c
@@ -79,6 +79,12 @@ static void max78000_aes_do_crypto(Max78000AesState *s)
         keydata += 8;
     }
 
+    /*
+     * The MAX78000 AES engine stores an internal key, which it uses only
+     * for decryption. This results in the slighly odd looking pairs of
+     * set_encrypt and set_decrypt calls below; s->internal_key is
+     * being stored for later use in both cases.
+     */
     AES_KEY key;
     if ((s->ctrl & TYPE) == 0) {
         AES_set_encrypt_key(keydata, keylen, &key);
-- 
2.34.1


