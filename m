Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2228BCFC293
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 11:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0fre-0007g9-54; Tue, 15 Oct 2024 07:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0frV-0007fh-2B
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:37:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0frR-0005EY-05
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 07:37:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so4544598f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728992226; x=1729597026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gdwXexYvM2Az81H0FuzwQ/GzEWh5Z5lRMjEDR0oLERk=;
 b=q7zlWPK0LnoBmcRZiK8Pi1F1sQtsrfOvXyfPiv55wXRpaiTdbxi+oYLoC4G7iMagYr
 EE67JMoFJXn9kUJc1ZobdvWHA/xG/lxraS6rtuZsWMXQEFb0jhAI9+jA7UJtBiAxPawC
 IhxHp9QW/70iChD2FHE5BmAa3t+lWwGn5ux5Ar5u/JJD/kPFLjCmjXyd11SqKjhBnEj+
 WE8lYJX1QXBsFK6uuNM7k0CdFI8KierXYV5RvTRYEAp+fjXBp1ct+3TJfWmN4DwAnTyA
 U6X5Fnnh77MAtiyiGbqRLwN/8TRlAOxdwcTZ9dqryQHsypYmAptfk5POMFURYCcNmCZE
 GaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728992226; x=1729597026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdwXexYvM2Az81H0FuzwQ/GzEWh5Z5lRMjEDR0oLERk=;
 b=g1u6LbyUwwqxwVZ+p0qup5zOfFl8heDvcBHBfIHSmWt9WnmhXeU1im74eemLL0aus/
 XRNTnLqtTcrIJIpBoqGx1PZ16sKexbPgeQ/SV7ExTLJw74aPqTQ8juw1xGRhijrJJpJU
 6Td2dyX9R0CdFDTTZC2Zr10KLZMouJRIrPgQ2W4N7/Vj3OZ+5JWrQ8V7+MtEpduM3kDs
 /T2DuSwUyzwtXsixby7c2SqcwtWBEsTHuWLx2XfzSdZxcWZHtk+1XNc8hX2v0xwUZ44f
 k+y7ZuJrFp7wdJaMToE/7fh1aSyoWZGSXwmf6SJpOWATTz8SWR8aHxtQGrIkv2OdBi9l
 Ec3Q==
X-Gm-Message-State: AOJu0YzxnThdUcqkQfUFKwKsRHGxjdI9As6sJepozXRcMZ70X64+emA1
 uS1YQaCT62cnzArrpINiZd9Yve6juqhg/5+ahyH7wkKfV5IypmqdTNtzg8LGeiSIN8BmyyrD5+A
 2
X-Google-Smtp-Source: AGHT+IHcCdy3QVPz3eDkdB8PTE5+nS3xFc1FddcpxblXR/G3LfRmLSUmEinqHyoOP6msvsG3jsJGPQ==
X-Received: by 2002:a5d:4809:0:b0:37d:5318:bf0a with SMTP id
 ffacd0b85a97d-37d5ff27c25mr8922872f8f.1.1728992226231; 
 Tue, 15 Oct 2024 04:37:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc40f94sm1339329f8f.106.2024.10.15.04.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 04:37:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/qtest: Raise the ide-test timeout
Date: Tue, 15 Oct 2024 12:37:05 +0100
Message-Id: <20241015113705.239067-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The ide-test occasionally times out: on the system I run
vm-build-openbsd on, it usually takes about 18 seconds, but
occasionally hits the 60s timeout, likely when the host machine is
under heavy load.  I have also seen this test hit its time limit on
the s390x CI runner.

Double the timeout for this test so that it won't hit its timeout
even when the host is running more slowly than usual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b207e386965..e8be8b3942d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -4,6 +4,7 @@ slow_qtests = {
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
+  'ide-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
-- 
2.34.1


