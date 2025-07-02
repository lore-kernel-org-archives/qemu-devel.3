Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89344C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwq-0006nB-Cs; Wed, 02 Jul 2025 06:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwk-0006jl-01
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:10 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwW-0001LM-1C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:09 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60c4f796446so11257287a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453032; x=1752057832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/APTWbGW7rZ8FBTlao+ogZlUyv21mF4KMebEL0i1Uo=;
 b=tquqdmFEXOrD64QDeV+D7NEv8HnnfR/vsxqIcWZ0kORi5bt8b36OF2nXvGCAhQ6KGC
 FZgdwg+4zDZJ5G5aRWiZImzw+NnyOH6DJschQnDB5+kxPiBR8B/eIaViMUnPSi40h+PO
 NMn8kOS7RF4m5vwEo+gkDRWDjwAFypMjU2ocWUJwhS3U4IW/hsmGsR221mkJ4l+FrNwG
 V3+Fl3/LZytB3RciZCfMTa99LQnZAUKj/3Wc6UWsIOzfFr7/drvPJo8pk+TbvFovfG9B
 C2cH5Vf7X+jwtGhi9eIhLIIFfcQRhEjj6hmJHnKdlkedJMVbU0TRRVaGaKMPfEeANaXG
 VlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453032; x=1752057832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/APTWbGW7rZ8FBTlao+ogZlUyv21mF4KMebEL0i1Uo=;
 b=IaEWM0j9qzbQrYCyAati5Q9cejKMVM4+89ZZV4UE3457kz6d56ttbNGBRWC3jGbKlt
 YjAXwNjNkq3cfCW2nvjA8L092uePCoi7WnL28UQiaTNOuY82xDEasri3aLGilPv6Wmbv
 xYP+RwijM19p0W1KciIJD3cXgZ5VtfgvwmhBm8DBxytRHN4n/YnZk1qiVDQCP31ohGOy
 2Dlhr3fH9SmfoaDDnSgxu3f99SwrwSJGp0EJwiUaZInIOdYbxYzc1qksjaarl2uHzEEa
 e5R/KSSZ8xZuPB7OXeQgim6Jb7yVca6FxqXvsfvGcyLGN8TVFL/lPJREEwo83erNNyBQ
 FKJA==
X-Gm-Message-State: AOJu0Yz9cI8EamFhqhmihO0XVQF3TWVcc28E4KZ1jPZaF0hhDntavf+P
 hmaib68DvPc2iW125TrJHdaexWA3CMwCwHQv1XKcXhFbdjgSmiG15r+b7R+XuB68wyY=
X-Gm-Gg: ASbGncsdFriLqyPGCkaGLF7DiT+UlBe7ygaZrZiGfwOuyxmsayyRVM0mPyedgMfMJdJ
 0voZ3wO87zbDXqgWpdyAl96fqRYa0VgVU19+OxU+kKNnA06lS5XhctwFei5lqwiGWSlykWd3D9S
 Lov10RFKhquSEUGM9Vhbta9csbbMLt7U43OH11bqO1eL+Ldlg/l+lBkQM1Rve78b2jON4VJ98h4
 x4/LsV2Lyhf+OpuQomzMYvwlWTzSO4sdm/ZanwzDTwqNeSpEgsTpOH4OIPl41TOQFa2eQguNVnM
 v9w89XZuCiXKB3L8kP/AFcdMAI23GU74QD5YVVD1Y1APyvutp//VwMCZ/WqVmS0=
X-Google-Smtp-Source: AGHT+IGzzoGLef2j1InBSp7Ldl4ec5QQIv5LCZ/8v9PEdNzOfjVJkkTPD5mthpk+7JUAc36IYOpb8w==
X-Received: by 2002:a05:6402:274b:b0:609:7e19:f12c with SMTP id
 4fb4d7f45d1cf-60e53619ac6mr1847639a12.24.1751453032476; 
 Wed, 02 Jul 2025 03:43:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c831a037csm9250294a12.49.2025.07.02.03.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 23E2A5F926;
 Wed, 02 Jul 2025 11:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/15] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Wed,  2 Jul 2025 11:43:34 +0100
Message-ID: <20250702104336.3775206-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250603110204.838117-8-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-14-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 850588fb64..52f0164edf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2684,7 +2684,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.47.2


