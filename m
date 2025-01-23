Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64836C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 07:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tarUB-0007SI-EY; Thu, 23 Jan 2025 02:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarU9-0007RM-C3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:41 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tarU6-0006CE-Cq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 02:18:41 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166360285dso9122825ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 23:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737616716; x=1738221516;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gx+3ifqR1D1jVa1Nds3XYoXQW6+Hs/sLQJEEUihZhG8=;
 b=Qexbd/crwymIMdhxUDDaThYz1+ZrY04gk7iLuKA1E5XBdo0wERmHOOKoHK5MjbkQZ2
 51+ByCGRTx1l78G+BJxCEnjMgB91qu1yJAYVol2mPps/3XNEzTLv/4Alvf/11120pSs0
 P6lNevpKnG4J84114Y5swCM8B+7krzfl2I/T5/wiB8H6cJEl7RpCm9Zm7SzfpiuMDqFj
 VotJ12YYnKjHoH4B31Jsf6q6hd9w52BkJVgSq2ZEI1P6EyRs4jgkf99ytHLBy/oSgvep
 l3MoACfHq3Q9SuKMQacUiCj0im+3wI6IWGYj67h+LJeXlwUcCNKSzOfkBIgyZJvf8o2y
 qNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737616716; x=1738221516;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gx+3ifqR1D1jVa1Nds3XYoXQW6+Hs/sLQJEEUihZhG8=;
 b=D/nMpqzX98YSS4d3I9BMEoQeCTinuFdSv2pG3aY4iQ/t6XmMA9Q0cM9o7NxcXm7wZ9
 KWkkt+DNxelML/4zEs9XaIutitX204FYvkrzD1JkPK9GYgDOo/VVlMrVsTeQpCdFqEAa
 S+qyi/HxoRipQrGbNt0orwXx3IlvVSJdla6U8KCxQBfZ3ofw8sqCi+r+O8YZcP3I2x4T
 NxBE37dCBRglIC0YFJWGJUO+KQR2OY9yd4lHu8R8g/ZxtkXXhndnCERpXK4RPME/owih
 XNj9r4rcdwExybJ26MZT4tUygPkU+EPFhAOz8vC6eRuke9yu5EA8cPZYF9qUU6KESQ+R
 pBPg==
X-Gm-Message-State: AOJu0YyLO3E1hg6DXz+pK5bakan5VwJocQ4uoPY/trHw2dJNg5+ubQiQ
 YVpisiAEY9dqzn94dmAiF1mYX/tJO9UxCaak6wCyKpn+Y6gMjkAHdBOwHeHiz/0=
X-Gm-Gg: ASbGncuQTT4WT7bKMKDVOT0F4fE1pYgpKve0qXJRatjOd+NdSmkz5P20j0LINxoK+aA
 x2YRP7f6EWWeYbmm9qW2ptDgXmcn9Cje2OqjMpO8vZgdHod4FnXTIobTHwFX7xq12FdEttKVuu4
 1uxkCZ/UOw6SnbyzqQXJqV0QelSvDQnxl5nNPdYNRAa0BIlFqAUkiU96DGH1PdQ31QpQVh/XH80
 nv0ibsjfCL/dPup/O+U4P6GXD5uXaFE/j8/GXPWIebo/XOO3TIIq5hAU0spOVFmEKWOwGmQBCP0
 Zk1cNMm+
X-Google-Smtp-Source: AGHT+IFo4S3OSVIeSv9AjcT7z4dx2ez1e9X8LUJBKtO+jIkhxBWMicvY8SE7Sq7dCZvrYLY++Hq6pw==
X-Received: by 2002:a05:6a00:4289:b0:725:cfa3:bc76 with SMTP id
 d2e1a72fcca58-72daf92bbcamr33341345b3a.4.1737616715733; 
 Wed, 22 Jan 2025 23:18:35 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-aaa24c1b4f5sm9042312a12.37.2025.01.22.23.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 23:18:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/4] coreaudio fixes
Date: Thu, 23 Jan 2025 16:18:28 +0900
Message-Id: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETtkWcC/1WMyw6CMBBFf4XM2poCLQ9X/odx0cdUZiE1rTYQw
 r9biAtcnpt7zgIRA2GES7FAwESR/JhBngowgxofyMhmhopXkpe8Z8YHVB9Lnpm+Ew1vsbSdgfx
 /BXQ07a3bPfNA8e3DvKdTva2/SikPlVQzzrTVjTZaate7q1XzSNPZ+CdsmSSOantURVZdZ4VTI
 stO/Knrun4BJsVyEN4AAAA=
X-Change-ID: 20250109-coreaudio-c984607e1d8c
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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
Akihiko Odaki (4):
      coreaudio: Improve naming
      coreaudio: Commit the result of init in the end
      audio: Add functions to initialize buffers
      coreaudio: Initialize the buffer for device change

 audio/audio_int.h |   2 +
 audio/audio.c     |  24 +++++--
 audio/coreaudio.m | 204 ++++++++++++++++++++++++++++--------------------------
 3 files changed, 126 insertions(+), 104 deletions(-)
---
base-commit: 7433709a147706ad7d1956b15669279933d0f82b
change-id: 20250109-coreaudio-c984607e1d8c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


