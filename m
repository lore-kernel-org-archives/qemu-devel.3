Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1A3E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Kp-0005S5-Fx; Sun, 12 Jan 2025 17:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Kn-0005J5-C7
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:29 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Kl-0006v0-Pt
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:21:29 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1818706f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720486; x=1737325286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZ+oTr2+oExZOJr5kMbRlsZawz728meOH00rrdIgtF8=;
 b=ieTdYGu0GQu+O+cp4g4bGpJLQQjSUOqiPKjgxweyqNRq3oNLC61jCfFY4e9DTxVIOk
 ojInaBdoYJMmoSGQOfb5WGusuAknagx2rwNredsB/XZk1UczOLOSX8MrtMeWUGUUDRL9
 5ocN5JUYWFd8xo2tFw311InGMs4vU3eDIdlMuSnBf3SvFjC10wp2dkg85XMt7RBZcGdN
 5VsyTIUKFWApNd/AG3uKpQI561gowglOXRmqNNinUoaFCa5H0154WPtEgDsVpIF4xrCt
 T/3Sz2TAnOrmSTheWqGPMEEBBtd/pNHsopb3XfoxQxYkTC6EsLz2BGVDcD2cS0ADsQ57
 C9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720486; x=1737325286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZ+oTr2+oExZOJr5kMbRlsZawz728meOH00rrdIgtF8=;
 b=YEi9zUuWTU4xvez36fCbm3Pb0wFJ5EN3KxTZJ+6G6PZ4nFfu/YLSevE9KqgP5TOCg5
 6IdIihwUfk6dNmSOTJRb6ytfHADkL8O/fwiiegXmda/saYN/Vuo85Ujp0GOkl4ZZfoXv
 0ioIHGwwoZytI3deCOdiJcJyXM4WWmCduyU4/OVsoBSn5CcK2T9BthOxuiKu7WqipFEK
 g4s7zuDjbWZ3hAY9Fne3RG42wtLiIiyTsnn1Lj+7mf4dtsEUk1pBzTkdYIopnnsV0L4g
 t6xtrm5WZT+kCMD/bGD5qVOWKECUwA9sKTRIu0o9f9oAjf6+TiaRdxTYCRguTpJ8TPJv
 TsqQ==
X-Gm-Message-State: AOJu0YzKtJcw1ilrOpHzqvVS7FwQ6O4SKbLnxCsR4CO2nT/3aytpGNXB
 IEwbvVx/quns6t5eeK+GXz2eMggiuZTo7/ueKf+H0fZY45/lGAsrh8vaBC8NVRD8FS+inLFo53R
 wYEM=
X-Gm-Gg: ASbGncu8l83fYuDPJKq/gM5eqhFsoA7RymYiA3S6E15iZKtWlEGnTfC+UPYcME9VNVq
 hKrY44Cifo6bxXEfl3P6ujUg0/IMq6/2pYynolanUCiG3B1l55l3+nW43NsBL4W1Znk6sUdNG2U
 EUoGiX/DztBU1DTvZUdf5V2OkpqTTzm6Pbk8F2Z9dNjKdapRFc3pCSNHMFFzmrdnOndY+ptyLrS
 sIM5Hbr6Y+PpmTR6WZXIs0jh6d1TlaeYL6092eKwvdI/rhETUvdEy/ccWNscD4N8dD3ihSiukP4
 jpVVjkXOJA7QXhSli3LpgrdTWUwCGJA=
X-Google-Smtp-Source: AGHT+IEGFkkxTFZF1jf/BHt2EVBZd8Ktnq9fdT/COYSwypXSB9iH4vluW6eYb9TVQrcRiRnkAkH6oA==
X-Received: by 2002:a05:6000:1569:b0:38a:a117:3da8 with SMTP id
 ffacd0b85a97d-38aa11741d0mr4699287f8f.49.1736720486129; 
 Sun, 12 Jan 2025 14:21:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a9fcb7a11sm5065626f8f.75.2025.01.12.14.21.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:21:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 48/49] MAINTAINERS: Update path to coreaudio.m
Date: Sun, 12 Jan 2025 23:17:24 +0100
Message-ID: <20250112221726.30206-49-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Commit 8b46d7e2dc8e ("audio: Rename coreaudio extension to use
Objective-C compiler") renamed coreaudio.c to coreaudio.m.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250111-maintainers-v1-1-faebe6ef0fec@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0727579cdec..ec898a3cbc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2800,7 +2800,7 @@ M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Odd Fixes
 F: audio/
 X: audio/alsaaudio.c
-X: audio/coreaudio.c
+X: audio/coreaudio.m
 X: audio/dsound*
 X: audio/jackaudio.c
 X: audio/ossaudio.c
@@ -2822,7 +2822,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Odd Fixes
-F: audio/coreaudio.c
+F: audio/coreaudio.m
 
 DSound Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
-- 
2.47.1


