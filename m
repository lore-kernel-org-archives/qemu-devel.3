Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBCDC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWXm-0002e4-6W; Mon, 10 Feb 2025 11:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXV-0002NT-Hr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXT-0002kp-Pt
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439473da55aso6329395e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204497; x=1739809297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A8vKzvJntcfDLl4x023hOjYDJprcH7GJTUjK0i7OfMQ=;
 b=X1Kua6wPhPPngD6gQKPrZ9eZTKYtCKsOEMsmwTSlh4Yic6CiCTQVf6n+G5kUvtYw/X
 WNqoXN+QY1WISUWLhOD21EkA8sDcDbi8ATIe9ZhBpEYsIUEMY7EFtBvMflXOrAJv8zvY
 Ng+v6A1b2CaY7ZzVRBy8Xr/ao0XWbwY/Tmph2FZHe500oiM2zkQgIe+ZH1HzYP1pRY/h
 23fmEncM+COtXE0kEOAHdLqg5KuUD1Egt8LUovm/keONfXXm3m6rhd6m9Smdmp+iikjb
 EUyvaDUbWlpvMA9JxFCHFu3HcM3VFasq8jXoxlQDqpMNWfdVRY0JfWxu005CVCecR6EZ
 3BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204497; x=1739809297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A8vKzvJntcfDLl4x023hOjYDJprcH7GJTUjK0i7OfMQ=;
 b=UAHPuZmbxgl38UqlTDYI0R1z7azIRob9Q5MtU7hP3JTuPZf24w792uL/SJpWj0QrGN
 5NuVffk/z+lEF8cXVhrwW/QFhLug7BdqTXMebegitr4d8qASDJNxpZEwEx4Tay/nacA7
 uC8Pbcymc4qgMGjPqKlw3wUwT+X6jwm5noEqe7Ok4FLajPIHjdjVy0bH733/OMgjNGdr
 jJ/ugCRvrsV9EUbsXN/VB4izQSVbWQlh8seiDCkNUGlx3HbViTMHGBO5Gp6Ol/5TP5dx
 /FlZ0sLHSqNIt3cUbUrBQLkuzTwMif4aLb57+vvS/JM1BCn3/F5dJuH3LBxKYCB+NvOn
 a41w==
X-Gm-Message-State: AOJu0YylNU1uYfnDZIyU2S4ULa0DPYbbuYXo7Z81x9rPlxe677QxQzOw
 2urmGlyVVg0IC1rIV6XkHfBxjQLTHwJeTQevv0l+7r37Idue2XnvOOK/Z3zbfcM+h8TGkPRfCxp
 VQkg=
X-Gm-Gg: ASbGncu+0PP9S39myCPIzk3LFc9LGgoePCdS5FDRQKJDrMXVfvNJUM+kjmd7a9cqYRc
 yBXiS4JdZFvE7TTJB82uWUk3BYZPNR0tQJg/F0N/IzqNuIW8sF2K059V5eITulU9CKq0ZOz7Q2R
 1SPaJwECyVfi8ec1u3Qu5mySOs/8zCZtkX2O7J6DAg7O+k7wceVsCpA2sv0bC2+DtFjblMx06RK
 Y48olMgFBPr8VjQWl0wLIn7lJszuIoEQD7P8qf5gSUpv5IhJArxOxySM90sc0T+7yQxbrSv8LGI
 DOJ+XoY6+bePSnBryEpmw0sZB0DsC27GB+ywAm4Q4Zjqbgnw47iv7UKSoHN0sMFzuQ==
X-Google-Smtp-Source: AGHT+IF1HaUxZgxMwiyTeaYctg9avRRdsp7NqnZRQbxBV7ybW+9EZyEi0n1685kyrGM+or3CpZMp9w==
X-Received: by 2002:a05:600c:3b8e:b0:434:f925:f5c9 with SMTP id
 5b1f17b1804b1-4392497d8ebmr116767405e9.6.1739204497502; 
 Mon, 10 Feb 2025 08:21:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439429c0790sm42168005e9.2.2025.02.10.08.21.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 08:21:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] crypto/tlscreds: QOM style cleanups
Date: Mon, 10 Feb 2025 17:21:29 +0100
Message-ID: <20250210162135.14123-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Style cleanup to avoid spreading bad examples:

Prefer accessing parent via QOM cast macro,
avoid using internal 'parent_obj' field.

Philippe Mathieu-Daudé (6):
  crypto/tlscredsx509: Rename 'creds' -> 'x509_creds'
  crypto/tlscredsx509: Access QOM parent via QCRYPTO_TLS_CREDS() macro
  crypto/tlscredspsk: Rename 'creds' -> 'psk_creds'
  crypto/tlscredspsk: Access QOM parent via QCRYPTO_TLS_CREDS() macro
  crypto/tlscredsanon: Rename 'creds' -> 'anon_creds'
  crypto/tlscredsanon: Access QOM parent via QCRYPTO_TLS_CREDS() macro

 crypto/tlscredsanon.c | 47 ++++++++++++++-------------
 crypto/tlscredspsk.c  | 61 ++++++++++++++++++-----------------
 crypto/tlscredsx509.c | 75 ++++++++++++++++++++++---------------------
 3 files changed, 96 insertions(+), 87 deletions(-)

-- 
2.47.1


