Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5D6FC5907
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVdn-0001Rh-TA; Thu, 26 Feb 2026 02:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVdk-0001Q3-8K
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:18:28 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVdg-0008Nz-I0
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:18:27 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so4373255ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 23:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772090303; x=1772695103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OpflKE2DNWvd/n7WqUURydxOraSugj+yhOqZu5kSeew=;
 b=EY4A6V2HodQaygsb79yxFi9sTyrKw6zti2zTlEHpN4NxxMFDMEt9z9NImqRds6lbFT
 cv964UBcJWQqk/vNL7oLd2LkRBZm/doRmMztzdwOlpqiFfTszpCsxvHhSZFgXDxH5QsU
 tGd3nzT7CqL0tpvJu+eOETnq8BKazuU1/bAW0W+NFdJP8JUmSer8yduFtUBj6WFolyVY
 YRmW3MG2hWKli9Tnq8/9Q+RDkb4NAji4KM+chAHLA7FUlnvP5QNChOHfCSnbRjU9z5gm
 YcGlv3l/HUDu+9W1a50ST9sHJhr+Z7wSWP3C00NCvvJhcMvXxgMmJ51oXrLWXNmQLyIi
 0v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772090303; x=1772695103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpflKE2DNWvd/n7WqUURydxOraSugj+yhOqZu5kSeew=;
 b=Raz00R7ePOPPze6rWhRsSdY6Mt6q2uhI7oMedF5l0JzSc2TKtdOWUO/8OOEYtZZF6H
 yGiYklXnKE4kYI3INh4tqmQWo3KHRJ7iLKoE7GQrv3u7vG3FJGSx38OJnG7TY7atrWfQ
 PTTQIzxK+Dc0rcdykXZthJaciMao7m7GHQJQUAcoDvUHmgYsta+VKYMjZSUZRXNqCzjk
 W+y1URu3YvtaqkcR4UZ9Vjqa1GrWPqXxsVMlIdpJj7d643E1s3wQXyk3V7xKHgqNN2A/
 C4OZkCMM1xNwuX+u7MBacfnHpr06FaejfiKNFK+veHe0Of64I+6XVp4J0qRHDyrEHc0S
 W9AQ==
X-Gm-Message-State: AOJu0Yw6dHlFZAm335O9mF7+1NFZW4ZuojWgoYf0D6aoZ2bhxZZY/NAZ
 JBr++cGl8Zn0oZUZ/UicveGZyXKUDzKGZzBQuGBbS+zF8vj2BqbfdQfSGwe/ZYMchoXRMzKoEdH
 VSO8eZ7eSMXFitVl5nvueC6NA67AGYLnvqimeelbX60idBr3vEZGXE29ybCbMFmINiacbjUIa0V
 6pb2Hos0tdOioeqHzFy0il+rhOZo3ANpRBJi0Ct25APj5B
X-Gm-Gg: ATEYQzzfZFkDUNZlekrtIZxr5kXtE4piteKzFJqw8eR1T7yqnVBPN+imLYkrEFbPXNU
 vTt0QWNsHYIaeTBhBkBqtNwiP5yopuj/KFvO+d1G4YSFHr/LOFmsk1NcAzxF/iNST3QQDlrStkC
 C9ZtFW6ub4k0KW9aBUOkpxdRljVk0bVaY3kEkLAG5rFaGAzwMhr+7PL8Xu3uB/Q933hNXTWDepz
 AtP4oS4R1NO4lE+bQFQ8Z6wWoZZ+C6Wd8JZdiMRFDnzA0jqsaAaq3smbCbI1maC+6ZI4r4DzuWL
 LaaAYUB0+6GsZy8eazBaxvLSALlTtGhAXVUs6MhFUsxQuKX/+rhDOFv0JsnuAs9iytPozuunKaA
 sYPNuMG3tzOfwGwjatXIfL4CmbZsYUWGFo696jWbkw0DnwWgfmu4dpw5uL06N4SuSNL1vIR1LaG
 C2X2vWwuZFbXIdRD+IuG9wmVe9iJxDTgJKZsFuZy5uwqh4erGjBEQmnqQyPYLZR0bFOWrCUwzfj
 el9ezTEe68yaXTUFWVRk/Im4MQ=
X-Received: by 2002:a17:903:32c8:b0:2aa:f0d6:bf3b with SMTP id
 d9443c01a7336-2ad7455d873mr187746455ad.53.1772090302633; 
 Wed, 25 Feb 2026 23:18:22 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739ff37f1sm1296179b3a.40.2026.02.25.23.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 23:18:22 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 0/2] fpu: Fix OCP FP8 E4M3 conversion issues
Date: Thu, 26 Feb 2026 15:18:13 +0800
Message-ID: <20260226071817.1417875-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x633.google.com
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

This series fix following issues related to OCP FP8 E4M3 conversion.

- Numeric overflow to E4M3 produces incorrect exponent values due to a
  missing local variable update after calling uncanon_e4m3_overflow.
- Converting infinity to E4M3 incorrectly raises OF|NX exception flags.

Changes in version 2:
- The “fpu: Simplify OCP FP8 E4M3 NaN classification in parts_canonicalize”
  patch has been removed. This change retains the flexibility to classify NaNs.

rnax

Max Chou (2):
  fpu: Fix repacking issues in the uncanonical step for E4M3 overflow
  fpu: Fix unexpected exception flags when converting infinity to OCP
    E4M3

 fpu/softfloat-parts.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.52.0


