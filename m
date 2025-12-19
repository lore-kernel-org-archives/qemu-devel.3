Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D8CD7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfYg-0002o4-N4; Fri, 19 Dec 2025 13:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYe-0002na-Ll
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYc-0002gf-2o
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso17625475e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766170228; x=1766775028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UJ2aqjupyxC2xcUJwXce3FiO2FjBmXdNqReGGc14jhM=;
 b=bubbGvo9JZv7AGdxy7fOby3q2N84NQXpnZ7RBToN1a/h81xKBFnOx5SSXtzJYwRf4d
 QtIOvT6gB6GqW2E/scf5i0b8Itj0F2qtV7j9c8MW4RdryjrDg2GbtDWWGomw24TyUPVB
 bxMIQtTV90N8SvrRecbQYcjS5IuF8hqWkDx03PQbXpaQqpbnrZ2oHN89X2Yd7XiKf9Wq
 xzbLKyU+F9pQr9LyF8b6Tg0gUDcphzvqdsGxI5asCOMk/KOqRfS4mkzLzOrNX18CmgX3
 wIWORVbBX9MCa3TDlbsERmd8VIARw99qDqtLuUSeg5XxE6ZE2gH8g6RiMLTYuwoYpOg3
 rn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766170228; x=1766775028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJ2aqjupyxC2xcUJwXce3FiO2FjBmXdNqReGGc14jhM=;
 b=KqVfFAF5ZUH63KysmsEvvJjv9IK/YV6moSL1fybxmiNsuuxMYbhGcFssq+Bgagd6R4
 uwnbgMEbvAsu8Up4ogflJZsdm/aJKMV8rtOBhEvk1V/YItihOPUbBwNfkfCrsmGNybgl
 B64oReV5z5bdpQ+BQDrM4/BPRXWvn4JjCx1jxsFltwCNBf+eKM9xKdG29ysvCeSo39K/
 tk9kbLT4f9QoQFx/wCPGRPxW3PvOh1gypm9bhJAMiqgfXRbDdCbvLwGF7Ba+O127+hUq
 0OzdmUFKaZue0LUdtw7Q6FbgoyrV5AlSeAlGzvNNMRKX6VSQlReyPZuTF+1kMAhjCrIR
 dJlQ==
X-Gm-Message-State: AOJu0YwEJ2Ohdr11M28RFPyNnU6beC7nOUyidDSQFj8HKET9is0RTfKX
 9JNz4p/rcCuhOL1hYu7WC9m43WqxGvqNuqB6vx4UOtVfSw8TA2ZuQPxZHrOzngysD7dV4QXTyTX
 gP4HhSQ8=
X-Gm-Gg: AY/fxX4Vg3shfv3tBySGaSZx9zj2LL7dnK2ZRffyEEZ3CCT2Ss9U7R352+l0eqoy1da
 Lb28Zj/w6KgxKNx0rIL7wPfmyRfY2ifzg1CMwoqmhiGbY0KWGNPkqyMdE/9M7zmcwBBK0MCbJhe
 dcN/CWiCAIbmuh8YI2x76q7rTnokuXlRo1DYTxXoQ3goEmii0FIJFKhDmWSO0j/OsgcInS5HnGA
 g9UXK4y0r5kofrNBiCJYqZzacp0rVnnxFGzfSqTziIAwTc25v0x7sYcPy6TDmSzleb/GZ4XnuDd
 nqiqKzMuA7p4RQYq1A7v6mC7gOzKraxwsriBcenj+vqHeEMbqSF3DndUTxpD0xvCSK/AYDw6ufH
 NXu+LJTCXCZQR+qoq+tI+5VLOj6XlDFARfRIPAyrsh7e6OlkYf7TjmEtSwKO5kRntOnIYZIGrGW
 DJ+qbVwC7qiA7jU+Zn5jcCow+kL8by22bzqDDZeUcFvkIZCPj17mU1X4ptngCg
X-Google-Smtp-Source: AGHT+IGclccwu0zavK0u49gMex4Cx3WK/MX62dYaGF8PPW1Gmh7u6A5CwsG3Zb6Td6fJdOrHT2AbYA==
X-Received: by 2002:a05:600c:608e:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-47d18be1812mr44618005e9.16.1766170227607; 
 Fri, 19 Dec 2025 10:50:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm59749035e9.8.2025.12.19.10.50.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:50:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] target/hexagon: Stop using the legacy native-endian
 APIs
Date: Fri, 19 Dec 2025 19:50:22 +0100
Message-ID: <20251219185025.97318-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

v2: patch #2 was incomplete

Hexagon is always little-endian, making the conversion easy.

Philippe Mathieu-Daudé (3):
  target/hexagon: Inline translator_ldl()
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  configs/targets: Forbid Hexagon to use legacy native endianness API

 configs/targets/hexagon-linux-user.mak |  1 -
 target/hexagon/macros.h                |  6 +++---
 target/hexagon/op_helper.c             |  6 +++---
 target/hexagon/translate.c             | 11 +++++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.52.0


