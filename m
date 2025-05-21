Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EDDC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXA-0000X8-RS; Wed, 21 May 2025 12:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX7-0000Va-Vh
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWz-0006AM-Iw
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:09 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so1368890266b.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845779; x=1748450579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyeYYqMYC8X2+dV5gz2/MugVkO2QuYgUium08NisyJE=;
 b=X8/C0O13FYVTGPatTF/DKYGtCRbMUxFs3eGBLSztER3le8zgVu9O2pcmSISqc4F/BL
 fyIUuINp0lHxFfg4K8WFe3Ri/zZ6hwEfiZyY/RUgrJZtnTVMD1OIsJ2GHrZ8JgUl+Gef
 cBxo9P+G28lLKEkj9cqwKEO+FUFksubf8T25J6P47NvxyiEOSIL+DuVHX1dU5YvqcmDQ
 Iz0vpxw9aYnhq/sm1fumiiSamUSG2mEG2ezfgcW3bvoQod2WuycqrYYXSJoo4nJ5nGq8
 BwZM2Z++68aB1Yj+O7nZvQbqmZclqUjDHJeD0PoIt12hMKt0tY8QPfSii3BXg/EZAXb8
 5QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845779; x=1748450579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyeYYqMYC8X2+dV5gz2/MugVkO2QuYgUium08NisyJE=;
 b=JsNYciuXTC6+9nb5EXwdOTZu5BIT1MVat0h9q3ZsZtB2OPHoDn+WnwvMjxea7dPv0r
 HjBpuzRtdVrzzXpcm1ufQtnDLKdjt3PX21zr7r7Q7Xz/PB4ry54v0Kl30kGUwEGqlb61
 EUdq1Vpzl6ckkVegNCuO+sXAGppDIYKPRdzmoelep7Tpfalh/3WnND5I4uHLCNtWyWGk
 Jz30p48lOT89Axt+QibuMpWt391rhb+AJVhZP8RD7HHMtHp1BGUStxKdqUUwW0zzsLUb
 fTdNhgbs7pb5HLUu6lN8AaCR7Vu5bkYd0XOIpuWTjQcMfcDfwg47FIk1RkU2ndyPcJ1T
 h4Gg==
X-Gm-Message-State: AOJu0YxuxcmYgz/jS+sNZmz0280nZSlIr/edbI+ihPQy3Feq8VPN7PIG
 4GnY9BipwnW3/z9Pj5kchDMnVV/vMNlE3uB7+5Uu75JPEltiec/7JYV7qr9M1esWouc=
X-Gm-Gg: ASbGncsrqrPNesbGsvbB2es+wpuNlaVhGORxaq0CIy0jLEsbmLn1X/mEMnR2BCtxgri
 GBszmwjsEb2026yuRNeT3TuO1SrsMGIyK2+YsQDAcrkaLzzLEG6R/OHH6atcHZkypJiaOaRU3Ht
 3bri9e3nPEoPWGsO1ugj8VgoSl4KNi1l0ZFykrPcv+oPMd7PlkC70YVA8vayejpgFb6Dt3NmXeC
 bLteeTkkyXwRqThWUYuKobznwn9xgs8TIOgaUSbz2sbaoVxEjzKkJ4CqAY1O/wSGgVYUNuuYj+3
 kv5pvSC0uYAhJ5h3x3SDD+dnD4iTYNdQ0H08w6cfWN12i2g5gyVtZanM/ws1uDo=
X-Google-Smtp-Source: AGHT+IEH5GmqN314cH13qD1p6HiS3PjlqQp/ycrl0O0i/fSY6CSjDf7UhSTjWB72qLfn0nJkQi2qNg==
X-Received: by 2002:a17:907:97d2:b0:ad2:59c4:83 with SMTP id
 a640c23a62f3a-ad52d5badb3mr2011067666b.42.1747845779413; 
 Wed, 21 May 2025 09:42:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4967c9sm924730066b.129.2025.05.21.09.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1C565F9FD;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 09/20] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Wed, 21 May 2025 17:42:39 +0100
Message-Id: <20250521164250.135776-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Seeing as I've taken a few patches to here now I might as well put
myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
it is not my core focus. If someone with more GPU experience comes
forward we can always update again.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - s/M:/S:/ for the maintainer entry
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 818d7b9d5f..8dfb393c06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2673,7 +2673,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.39.5


