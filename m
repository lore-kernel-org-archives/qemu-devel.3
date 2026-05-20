Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF830CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPev1-000185-UB; Wed, 20 May 2026 07:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wPeut-00013Q-38
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:16:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wPeuB-0000YS-Mh
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:16:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0046078so42069395e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1779275757; x=1779880557; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZGRA2ZojEl7XdcqtHZyPxFqLvZGrLtACN8c+gO8jGE=;
 b=XH59t/eatl+p2sIEhRmVMDqrszn0IGvDUpAy375z8/RLcp9wC1C++c7p9GPjNw8FRB
 OFlB9KaxTIBOGYoHuKuz25tJcKoiJkx/b/Npa9DmOvUXRsn87p3C9No6KaMwar8C9s09
 NQ/qzjnu4yXviYI0XRnM+JFaEj11AVI4fkP15qgTOGEurbqdYfQoYCnNkanCP2l+s0jp
 X/fzIjw/ceaX8xmzrRWK572XO7E6ynXyTaWWovzTvXv8EopKg63PhQkxcrpUhsPd5gsP
 hG8h7KD4bhu1An372MtB6uo2F0Wc+nV7PHZBXi2TLo2xiKVZK0osImk224JZZBOfDrLt
 YpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779275757; x=1779880557;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZGRA2ZojEl7XdcqtHZyPxFqLvZGrLtACN8c+gO8jGE=;
 b=ILvXK7G1w2mMZXadlC475xoU0JxZ+kN77WGxLwBcN7bDCfcEvB4ymJxUOsFs/lzz7D
 nuGvQZ2mgHN+Jbq5Pc6ephSZJkz5FMNPcFgNnew1IPTZA8mT9StsJYjPjNT19Hx6qcN7
 kKeBg5CG0a4Rpu5ZpijHFhw8hejJkmgyWNchPlpEQ6uMAfkatPxpCyr8tDNI1EnWRTpC
 aBInmABD52dkYXYWTwp/JSP9MzsMyFoHjlzTvQpeBwXYKbyB3IvtDFRd7+kCEsSjq4M1
 5NnKGOQZ3Af67ElLeVAtBctZ+MjlHjuco7FAAB508C2tIciW1qpTQc9T4jO/uMFR/f6t
 WHcw==
X-Gm-Message-State: AOJu0Yw4sFYsQhzn0k6LjbnAQ6GQ0GXcCiMoJjResG1cWUaLLMrqjrtk
 1Olcq0mz8ulegv+hbsAKDMk6p6isEiZAVBQ215mO1kiqvoi1zxk5WS8J1819rNSwBzo=
X-Gm-Gg: Acq92OGWtoGwwa7wubYvnEMaXJCTDzbB+r7w8/mBvv+nN7/42+UO/J9its36xgwjNH2
 kEBj8OLe6BGxWBOAseKLtPI0JAl7kK3nSsEadMXXvXYqnB5PCqYrpLZuOMOys11EW7WHAXVJOaR
 updch6bgRaVB68Ie0ORuDXKCPGAkMk7rFapuPGbHnNGOEKL25GZo7W+nE8zwMDzQ4ZIK6hrvbp6
 mka2/pZvaWh4ZXZ57FKa4jtLQvgwnRMbXQJEtaZPuAZV4xQ14Xc2EXH/6yLbOb5t78CASC4CDPy
 L4nPCwF1t8XiYs+6C4O9LVHqWK8K9f8r1bob5g7/teFGXUIp0cJmMkPtAqruPO1AMfK+YSeBG3f
 k2xa9T8yG8HfYXe69v1MyVKatw11p5a2pEw0Xm1vJsnBN6WsUVc6tfPCpbRaTEqEfyX+JSOxNbA
 g63vIjUT7lcJT8nEucF18ZHju05cjbhABuNEQ8xr9JnoSPdMCrg7dW1WR9csv0H8E8TjASZH1qX
 XPj1+9ZDXxkjtomxUHkw1qgKA==
X-Received: by 2002:a05:600c:6592:b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-48fe62f8861mr378081455e9.23.1779275756850; 
 Wed, 20 May 2026 04:15:56 -0700 (PDT)
Received: from [127.0.1.1]
 (2a0a-a54a-ed40-0-9db4-bb9-3f9b-5d0a.ipv6dyn.netcologne.de.
 [2a0a:a54a:ed40:0:9db4:bb9:3f9b:5d0a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab527asm435952445e9.11.2026.05.20.04.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 04:15:56 -0700 (PDT)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
Date: Wed, 20 May 2026 13:15:20 +0200
Subject: [PATCH] docs/devel/qom: Fix some editing errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-qom-v1-1-baad87fefe4f@9elements.com>
X-B4-Tracking: v=1; b=H4sIAMeXDWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMD3cL8XF1zM1Nj85REM3PjJDMloMqCotS0zAqwKdGxtbUAH1iT+VU
 AAAA=
X-Change-ID: 20260520-qom-76537da673b6
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779275756; l=1488;
 i=j.neuschaefer@9elements.com; s=20260513; h=from:subject:message-id;
 bh=hHn+I2LChySRnTEdwAhplKu+rldCFOx+xxZIuYzAzKc=;
 b=10DCoiv0oGhAs9/nY7n2EOO9PQxrxs3UHd7XPBogOQWbQQ7SJ8afExwWmFyIixNLb6ML3w2j7
 UIPWRKAVsjrBOzn0hANhN63I4Wnkl4xXZYa4UiRfXyP8Bo7Fm7M7ssO
X-Developer-Key: i=j.neuschaefer@9elements.com; a=ed25519;
 pk=mytxDu9ALv0FsWdexvpDMisghxetVpsZ8NdmY/FGsgY=
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=j.neuschaefer@9elements.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"devices have an two additional [...]" -> "devices have two additional",
and also a case of "were" vs. "where".

Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
---
 docs/devel/qom.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 5870745ba27b108726da0756aa2b90109d5e0bd6..935bb1004a7839c8e963985e765c866d5b980c53 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -435,14 +435,14 @@ OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
 Device Life-cycle
 =================
 
-As class initialisation cannot fail devices have an two additional
+As class initialisation cannot fail, devices have two additional
 methods to handle the creation of dynamic devices. The ``realize``
 function is called with ``Error **`` pointer which should be set if
 the device cannot complete its setup. Otherwise on successful
 completion of the ``realize`` method the device object is added to the
 QOM tree and made visible to the guest.
 
-The reverse function is ``unrealize`` and should be were clean-up
+The reverse function is ``unrealize`` and should be where clean-up
 code lives to tidy up after the system is done with the device.
 
 All devices can be instantiated by C code, however only some can

---
base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
change-id: 20260520-qom-76537da673b6

Best regards,
-- 
J. Neuschäfer <j.neuschaefer@9elements.com>


