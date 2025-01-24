Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE1AC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 04:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBbU-0002Br-3u; Thu, 23 Jan 2025 23:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbS-0002BY-92
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:34 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbQ-0004Yu-4H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:34 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166f1e589cso41115135ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737694050; x=1738298850;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XoZBI74SlZwwbO24VXdqLYNF8GahLiUfCPvebySixDI=;
 b=Hk+6jYGsXd0tcBiSdjXdVBdfHGk19pJKhVIOT77z/T0+YuKtBla1VIX8g/0WgLyyLC
 k7rhmFFkzv0EAIZpoX5hU07g0G3vNqXxpqYmJsZ573/K6ATdAPeXCO7zyG3/C5r5qbNw
 f0BxvBbeVIrtOlde9jshZPmHLABxw+/HnkCvKIglvsM2ITBk92XztMDu6kv249W/79zv
 XujfoHlwWDRh3W5yP+Gr9D4Sdd+xhjyvmT/S9qSp4cny3MfO14W85COP1G7oUK7bKZJb
 Lsxc50x3uij1HYaGIpjqCuk83ZTFkodvUxD9MNPxZLJg+R23viwlabjVhr1JRX4hxVyI
 kHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737694050; x=1738298850;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XoZBI74SlZwwbO24VXdqLYNF8GahLiUfCPvebySixDI=;
 b=DPEla7OzCASSZsjS6AYUmdoUbFTar6pn6iAGy3OXKdRQQJDb3SZukYge/bThx31LOG
 y7uAHyCuUOvSOVP5Wn5ZTTTwGA1h9eGvY2FSzuH8ipj6KymwomiTDifExNGAbPwXVUcf
 YfeMH8o4f5jEv8AMaGdAqvxUfG74dG5jDmjArFu9ORFWu3qS/8TYp0YHh3xhPEm3FMiQ
 1C/nt3W4ezQibyz+3Yg0ucJjizI1vmPKcRVzUOcUh5LopNJ+u5RhDoZ9ZTos1Em3kat1
 l/d7OWIIW50m03TEUwENQk3Up2Dh7Y/F3e8H7kVAf3RheVoIKOaqg5MjAONnQDLoP5eT
 VI1w==
X-Gm-Message-State: AOJu0YwPM2c7nRuJX0wRp0q6C/OPF7a6DVn3bJKEetHLDOjBxdrBkNjN
 U3KuPIZkTyRksw8SPoBPmD6IMh5Ncm+Tnp4mpNkYBp1tL6i4s8O1Q8fOXSvU7qk=
X-Gm-Gg: ASbGncsLkl/NEl4qOf3Fn2c6zMkBPrfZ4hrZRU54QnV2AyZjzW/whifeU2hzF0F6/d4
 rwzoB4QiTMBSlIN5YZA9myaxeCeKo7bQuGxLKsanLodue0FXBZ+csn2Mf/XywW7BWSpTrOau6Xn
 eXsJhrOS1Qv7929hh4gi/zYG2+WQmaN7BT1YtGO26Q/W46fT3Ym0M9UufVpszqqLrK0VhZHsoP5
 hv757iiBSzFw4sAwzsUPwtfE78UJeLR9ZuWHLjGK/KM32mQkTSdPpf3jr5OqUZhvlveyQXarHBL
 UbltSJj1
X-Google-Smtp-Source: AGHT+IHu4miph+aT8jnN2Bwme23opVdPgJ5NJ2ptoB6FH7OacHtvABsInpX90kd3chTfueSloNZPTw==
X-Received: by 2002:a05:6a20:9149:b0:1e6:5323:58d1 with SMTP id
 adf61e73a8af0-1eb2159018bmr43155346637.26.1737694050317; 
 Thu, 23 Jan 2025 20:47:30 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72f8a761166sm842635b3a.118.2025.01.23.20.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 20:47:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 0/5] coreaudio fixes
Date: Fri, 24 Jan 2025 13:47:10 +0900
Message-Id: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8bk2cC/2XMSw7CIBSF4a0YxmJ4lzpyH8YBT8vAYkBJm6Z7l
 zYOMA7Pzf3+BWSXgsvgfFhAciXkEMc6xPEAzKDGu4PB1g0IIhxh1EMTk1NvGyI0vWQCdQ5baUD
 9fybnw7S3rre6h5BfMc17utDt+q1g3lQKhQhqq4U2mmvf+4tV8ximk4kPsGUKa2nXUlapl5Z5x
 Sr27I/yhhLaUl6pkB21nhHMFfqh67p+AKDrjOIZAQAA
X-Change-ID: 20250109-coreaudio-c984607e1d8c
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series contains two fixes for coreaudio. See each one for details.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v6:
- Added patch "coreaudio: Remove unnecessary explicit casts".
- Link to v5: https://lore.kernel.org/qemu-devel/20250123-coreaudio-v5-0-6873df4215a0@daynix.com

Changes in v5:
- Added patch "coreaudio: Improve naming", removing verbose names like
  outputDeviceID and audioDevicePropertyBufferFrameSize altogether.
- Link to v4: https://lore.kernel.org/r/20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com

Changes in v4:
- Splitted patch "audio: Add functions to initialize buffers" from
  patch "coreaudio: Initialize the buffer for device change".
- Changed the message of patch "coreaudio: Commit the result of init in
  the end" to tell that early returns happen when there is a fatal error
  or the device gets unplugged.
- Link to v3: https://lore.kernel.org/r/20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com

---
Akihiko Odaki (5):
      coreaudio: Remove unnecessary explicit casts
      coreaudio: Improve naming
      coreaudio: Commit the result of init in the end
      audio: Add functions to initialize buffers
      coreaudio: Initialize the buffer for device change

 audio/audio_int.h |   2 +
 audio/audio.c     |  24 +++++--
 audio/coreaudio.m | 206 ++++++++++++++++++++++++++++--------------------------
 3 files changed, 127 insertions(+), 105 deletions(-)
---
base-commit: 7433709a147706ad7d1956b15669279933d0f82b
change-id: 20250109-coreaudio-c984607e1d8c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


