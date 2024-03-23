Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81995C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 06:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnuk4-0005wK-ED; Sat, 23 Mar 2024 02:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnujz-0005vY-Gf
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rnujl-0007cN-9w
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 02:20:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1df01161b39so21371665ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711174812; x=1711779612;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yO/wNaLl7/OjHdUZtag034ckT+zewaxx7h5WeHbtBDg=;
 b=nwNCNW4kgOhhkuSYneCFKftkrOyf7F8I0ZhncS5p0WPULqqlVZQQy5LlpHEoV6dZvY
 67PpOX/TBBQH4d7PWdlblFxiKkB6dCvxojqKATbu2v9EFTQSi0y4Tm71w6QF68hYywGv
 y0EkJLoVFpT1cUF7RoG5cTq/w38M216r4HSXYOBuSER6bAGEOVzcToTWVX+8l00xhfdc
 X52xyqs2akMJBFS1Y5T6OlYJbxn4mXMceFHBAEMe16JcOCVsoimypz+gjSMttOEnY7Y5
 mGOu7rMHxfyxTBVl2YMrG0SZM3fuYrfcWkq+Mbuq5Hkfu0iphRCD38XBENnXTAOvGcgc
 aIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711174812; x=1711779612;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yO/wNaLl7/OjHdUZtag034ckT+zewaxx7h5WeHbtBDg=;
 b=C56WnoZYf+rvMFlX+XPUBqUkPx1Wx+jf6IAIJbKIBfe1HSJ2TQC4uTpiED/RUHcIfG
 W/3d8zOLWSEDLkg3bWVnAD+d5RW9Qo1uRnCv1SIP5C+pZMmkKSCx7EIdignEU9TqZV28
 AjYKFIdtPeFehqy4vt4Q4bs65f1y62BH0JoJOX1kl9DQEmEwGYhyAavsA2s5nym1BR+u
 8T9wSr0wsDGJGFzfxWAYmvOssHc4O1Myb10pxezi6dduILwxh5UNy4dwXObZVP3x4Im1
 Iq6KqXYNiL3TltKV7w4g74I+CiJG9j7bkPCwTv/r7ug6CHLPj8x9SqJmrT5supuswhg8
 fyVw==
X-Gm-Message-State: AOJu0YxYqbj6GjQ+vWPYxGjg2HfGKC/U9UKzTc/Ot9yKZP/BbY6BARRj
 /sSfheR+DjlUanBt1aYDv7TTkEvSNxIgocaGQAn2Mrwa8rQ+dVCATIINg/YAyRI=
X-Google-Smtp-Source: AGHT+IEOQRYh4fe8rQLvq8sF3WM4u9pPd71bFLuNdoB2ZOl1/5aFxXT8OLq7E4yMKaTb5Q+zNvsnEQ==
X-Received: by 2002:a17:903:1247:b0:1dc:b691:85f4 with SMTP id
 u7-20020a170903124700b001dcb69185f4mr1872143plh.16.1711174811675; 
 Fri, 22 Mar 2024 23:20:11 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 b6-20020a170902650600b001def18c0cedsm829977plk.179.2024.03.22.23.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 23:20:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/3] Fixes for "ui/cocoa: Let the platform toggle
 fullscreen"
Date: Sat, 23 Mar 2024 15:20:00 +0900
Message-Id: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJB0/mUC/12MOw7DIBAFr2JtHSJ+inEq3yNygWEdbxGIIEK2L
 O4e4jLlvDeaAzImwgz37oCEhTLF0EBeOnCrDU9k5BuD5FJzJQxbaMPM+lmYHp1UN8uhue+E59H
 Ux9R4pfyJaT+zRfzW/0IRjDOlF2GNHmbuh9HbPdB2dfEFU631CxqRcjSbAAAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

This series contains patches for regressions caused by commit 91aa508d0274
("ui/cocoa: Let the platform toggle fullscreen").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Added a comment to [QemuCocoaView fixAspectRatio:]. (Peter Maydell)
- Renamed [QemuCocoaView fixAspectRatio:] parameter to match the
  comment. (Peter Maydell)
- Noted that "ui/cocoa: Use NSTrackingInVisibleRect" fixes mouse
  movement tracking. (Peter Maydell)
- Link to v1: https://lore.kernel.org/r/20240318-fixes-v1-0-34f1a849b0d9@daynix.com

---
Akihiko Odaki (3):
      ui/cocoa: Fix aspect ratio
      ui/cocoa: Resize window after toggling zoom-to-fit
      ui/cocoa: Use NSTrackingInVisibleRect

 ui/cocoa.m | 90 ++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 35 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240318-fixes-7b187ec236a0

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


