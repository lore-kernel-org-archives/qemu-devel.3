Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EFCFEFB5D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzbi-0000OI-3Q; Fri, 27 Feb 2026 10:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbb-0000MP-Tc
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:16 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbZ-0005l0-VU
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:15 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65c01595082so3649460a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772205492; x=1772810292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59eiI6npbSEHoSIPmne/fFwXd4gpVLw2rM2Kjlt50WI=;
 b=YJynN4VGvp16r97+a+xKXF9x8dDw9xc7dwCRZ+ddGLYsn6FJm7MlikOLixhXJM70yx
 XHAnOBxJd7C5yBuWhY8MS5UeNGvmsiSMQUkrcKnbEyKBNurhQbl2NLL9q94t5dCv8dPc
 3iCMz/ja2Z3aUDo6eDOQu+YaRAL1qL6Mvo53kC61WB7g36ozUHyOv3Z774MMz9k5vtsR
 9+b2WOrTm6R/VFzHQ2NKhMRB8/NKGqt/V83ZxSpd3oN8ZKEkAU3FUqotlqpYQX9eFJb0
 mmljK8/Rqzn415bohauXlcSZAIeJ9fYBJxKHm3cmXZSxyiiXul4b2pgREF2Kmc14S7Hq
 FMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772205492; x=1772810292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=59eiI6npbSEHoSIPmne/fFwXd4gpVLw2rM2Kjlt50WI=;
 b=FrVIdd3qeHy4WH0HxmDOa//jiZkS0+bxLELPlR4nCxKtJw4+MKhYoi5+pQcVKg/KiK
 q1t8bYIpNtAPff0vv0svVZaL7kWH19ERe7uSz0ZTNzHxc3POvTDdxfbatDilbHXjEu02
 wmFY12BAMFz1h0N0NnlN9ttNOaNgkNHB282RHUY2UZnNlSECVAnELHc4rkqa87+8mV8o
 XHoR29ddqXnQcbk7mzeN18vL2ChfqaQIU3yQPz5OpMH7n+f1hNw7P6afrcUs4L/ZlRBT
 TGSeNtg+PMZZV5drLAwB7khmYK5VqpCvXh0EVDQCjouMa7hmTLXQlE5Sv9VTcYYV1I69
 qVVQ==
X-Gm-Message-State: AOJu0Yzsqi2cxoILXllqfri1/a9zUx0bsG2yA9bS2nGKGunEEuQjTlnU
 LN+4tkqxlZ+bttWft35kEf5ewYzOVzeltCiwYqVqKf5zZ/HfMyu2LjRXfZCPN4ngWGo=
X-Gm-Gg: ATEYQzxTVy+FzJyqIx9GVyycHr0K9oKqTYYiXdTM/W8XJ2j9dCPhThyV4WWORDb4LKc
 aqmHZQVW+96Ny0Q3m/nvkH1d+Re94irZOYH9UYwAVU480TVPxNNz+jDpURlVTDOypOO2nzvvP5v
 pbsl6eL9tQTcv0cmnDF+TulZtos9pcR5LiEjnL0jE3r/GxBxl1um/2vHTzSLgMQBZy+r8AbxVIZ
 Ro3834GlmSLvny4DOhC/sjQYgA1WT5F04urlNxC4Rb+ZIAo5GnRY0JfoH91B5Z1rWcewv4vHl7k
 NqTMQkG4QRSpbLFhlzV9tbu/lDA/LOMlhDAJEg9I4SKGWB5cBS8Xa6VUoS8m2HD9nFVpFUr6U2C
 bA5mAxgVSJwyMfVCqBD59B/geh88/2jM4Gid8NYHa3+tuqjMuFwmkYRgnqMdRt8IxHVVP/CdV4P
 NuxJiTzY55n7+PoP7YjWVVEdY=
X-Received: by 2002:a05:6402:40cd:b0:65b:a2b5:5320 with SMTP id
 4fb4d7f45d1cf-65fddcf1734mr2110102a12.26.1772205492163; 
 Fri, 27 Feb 2026 07:18:12 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6d068sm1363738a12.21.2026.02.27.07.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:18:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CBCB5F8C7;
 Fri, 27 Feb 2026 15:18:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>
Subject: [PULL 3/7] tests/vm: bump OpenBSD to the current 7.8 release
Date: Fri, 27 Feb 2026 15:18:00 +0000
Message-ID: <20260227151805.2335641-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227151805.2335641-1-alex.bennee@linaro.org>
References: <20260227151805.2335641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260226185303.1920021-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 5222041b855..d1289d78d24 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.7/amd64/install77.iso"
-    csum = "da0106e39463f015524dca806f407c37a9bdd17e6dfffe533b06a2dd2edd8a27"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.8/amd64/install78.iso"
+    csum = "a228d0a1ef558b4d9ec84c698f0d3ffd13cd38c64149487cba0f1ad873be07b2"
     size = "20G"
     pkgs = [
         # tools
-- 
2.47.3


