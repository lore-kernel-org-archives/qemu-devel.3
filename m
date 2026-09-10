Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096BDC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4py5-0005NX-9R; Thu, 10 Sep 2026 21:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ9-0001m7-1g
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPz-0007Hs-Cc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49e625d5a2fso750245e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083778; x=1789688578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lQw6tClcEuh8wmhjZmi7xrA9dHVcRR/JsHSDd6qTuHg=;
 b=XvkbJ+6UZce+Y2U5p7yL5OXZ778dT5M47tZMtmN0AJuK9Eews1rMKMWPMeyjtSSwRn
 KHk8o/Ivm8ZDhA6tT2boT4Sz0/dQZM5oJ2H65nX222ko2tfl6oL0eQ4RKzVKp03vl1AV
 5+Sh0h5PfPQYfl6lAo7MTq0yEscA+e6Ws8Rq/gZSnzwdCmOJ/+vkinXhjwMOB5e7DFZt
 G5wdxjwSYXjoCG8U5NE2+4OWnf7FuvphQzAZ8hdAUKtfdvQmsiKkdMmg2ZFewQgMfr1S
 +HXmAFn5TlYdESpKievJ054q93nSxr9sSQm0oZzQOo8bHE7eXtUn9nKn7Yd6zep9QztP
 L+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083778; x=1789688578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lQw6tClcEuh8wmhjZmi7xrA9dHVcRR/JsHSDd6qTuHg=;
 b=Q4dFvCyYCAkAUSznNVEjrOECcf07ySh6uBeKtJPE9k2Idl8Q3Rm9GDxygoSrQDbHHB
 khTzh62HpMTSBYoG/MEH93RzQxmU3WZKj956Bfi73ewPIcj7TeieDsNlReiYAb/t3/Lm
 eQN3y1pxz8Th746SPNpFuDPGpku9euRDDTTSX+/83YJhDNa1jutOxmlRS8xcqMqin2wO
 VR0NF/0XZR4+uCjr/u2W6XLEynzsvlE4wpBBmti0hV/ZB+3Q7wX/vQ5UHtX78FMSFpNb
 /Et62F5VWCCL/bJQ6S88sxEceseb00kV3V+TfO1zqDAIGxV4kNbgdiYto4mb4r5CBNmo
 QAEg==
X-Gm-Message-State: AFuF++lto1M3O+Uyhenys1nwT636/8FCwGif1aiafMi0sCJp0PdLkYPy
 xAOIfGd3Je/XxPKCtCdyLi65JPJ9wzVkxiHjgsT2aFRSlkMqcupMSpWbh8MSdgkKO7g=
X-Gm-Gg: AYBFou0WFfYgapluol7d7M/QTeyWxo99t3vFERjd2ekYX8OvrFv665laxVbkuR1ZJ7u
 9Q9AQJj/0Pg/oo77E4Ah5DVqVXUCn8mlp/GNVnULN0Zm2nENbzFfVODMCDDwZkxmHI1Z5yGG/QN
 pLItVEFi5StJyYpoJltUWVMQOq2bCi0ZAypMfumc+PehGP7H9ApC92IIJYO0qfSBSNxcj70YWo0
 HF0t+U5myl8Qihi9QbDAqWa0pP3p4438LjxArTnIFAHOKYt9AE/aurHWPg2VfqwigTGXAT4JZag
 2PsNpzSdlmpzuCVZ/qhIqhCnGIOD2hfjKhlBfQz8Khpf9kIWdpkxtZ+FsI13CeZUWh8Bh80hlEW
 mBDEmTcXPLvSSgzgp03+JW7Xq8Apx7e15ytJwEsqwwOrEBvf9wEY0KjW+26lxY7K59PBOhCvsHZ
 Ny/7aV1KYf/OJBW1wVbOJqmUoGlogeSKpgny2qTA8QW+VGFSkTPD3YDDebY0jALIjrmdIzEw==
X-Received: by 2002:a05:600c:6309:b0:49c:ff3c:973f with SMTP id
 5b1f17b1804b1-49e619c45f9mr13340125e9.24.1789083777646; 
 Thu, 10 Sep 2026 16:42:57 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:57 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 26/29] iotests: rename parallels-read-bitmap to parallels-bitmap
Date: Fri, 11 Sep 2026 01:42:19 +0200
Message-ID: <20260910234222.3039975-27-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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

From: Denis V. Lunev <den@openvz.org>

The test is about to cover storing a bitmap as well, so its name stops
being accurate. Rename it on its own, as the patch which changes what a
test does should not be the one which moves it.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 .../tests/{parallels-read-bitmap => parallels-bitmap}           | 2 +-
 .../tests/{parallels-read-bitmap.out => parallels-bitmap.out}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/qemu-iotests/tests/{parallels-read-bitmap => parallels-bitmap} (99%)
 rename tests/qemu-iotests/tests/{parallels-read-bitmap.out => parallels-bitmap.out} (100%)

diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
similarity index 99%
rename from tests/qemu-iotests/tests/parallels-read-bitmap
rename to tests/qemu-iotests/tests/parallels-bitmap
index f5a1f33907..814b56b32c 100755
--- a/tests/qemu-iotests/tests/parallels-read-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Test parallels load bitmap
+# Test parallels dirty bitmaps
 #
 # Copyright (c) 2021 Virtuozzo International GmbH.
 #
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
similarity index 100%
rename from tests/qemu-iotests/tests/parallels-read-bitmap.out
rename to tests/qemu-iotests/tests/parallels-bitmap.out
-- 
2.53.0


