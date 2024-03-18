Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157CDC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBDa-00084f-6w; Mon, 18 Mar 2024 07:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDX-000843-Jj
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:47 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDW-0006zV-5A
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:47 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-513e10a4083so1946809e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710761504; x=1711366304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6qFVEtjnBNyYIKhYM/YbU7sKs/Pl5l+VfwM1ydNA6OE=;
 b=CZ2jhm/gKFTGxQxDdO5cFcxRw487Z4RfgODQsRa1XOW0JUQn8LJPEAKCuge0HTsmiV
 n3rY5tYtYees9eHMN8vpX4uM3jwOLCa8dCmOtlxMl1XjzBCRgB3nSX7otnnyDYOWUnNH
 y4BDx30ybXMZgFQqFuEq8wM6De7u1OjCI3bIEYz/SnDxVndvRNseoJ7805FH2Iacg0jp
 LZKjtb+Tlossxe+gy2h5kz5Y66rcptG8/dZymS0BbN5y+PctWUyAgx4IUd4dZLy9jPdI
 h5UKOqTrthXecx/Ir1KdC2V5U/uAX1BBhIRXj0vQMMNb30d2klIIXhKXnVHy7QDwubfy
 J3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710761504; x=1711366304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qFVEtjnBNyYIKhYM/YbU7sKs/Pl5l+VfwM1ydNA6OE=;
 b=PLx2vew/EMLyV510MkC1/BKbt9GVccrK+MbRjBrzLczino+9lrowfgdhPJ+9vXuqPe
 7v5VOJn/lPCECt9HJhYxm9xQEvdk0roZqSRjjS38jEVoQRx9kO7PT8jFhLa3E1NmZ5lP
 jK356sHMCN5SPTlFCCLiFQBIebByrjzB488TgLIg4hJAslP77LySCAFwclnIuDLBnm42
 EIriCqsUlE4SWOVH1qdud1zbKL2pOOXCM2xkH7ilfvjfXtoyZaZjiuRs78J7uihwk8Tq
 gTZ+l2iOeKCx3QegvDpZcuVvjoKVLWyhYx0bi8QgOjf5qUwLPHgUrIT8ydiPfNU5bbAk
 +S5Q==
X-Gm-Message-State: AOJu0YzcToImpJk6WH28hf04rGdiLA+Bm5JWnpUXoaivkkIGtX050WC1
 fKACDipYAneJW/m9Jvs+Jp/YGQCtCIrfBJ6s3TuOyB9ZiAjfPiIUEC9moT8mKhGQLw50fIM/8L2
 2
X-Google-Smtp-Source: AGHT+IFb4/xTtr77HNHSJ7WzvW2vSrhynefj+rO6yvdUc/90oOXiPs8K3bRhnmvXNXI2WiGec+Gaaw==
X-Received: by 2002:a05:6512:201:b0:512:fc00:7c6 with SMTP id
 a1-20020a056512020100b00512fc0007c6mr7886810lfo.51.1710761503668; 
 Mon, 18 Mar 2024 04:31:43 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 h4-20020a05600c350400b00414128462c2sm2046822wmq.33.2024.03.18.04.31.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 04:31:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 0/3] ui/display: Introduce API to change console
 orientation
Date: Mon, 18 Mar 2024 12:31:37 +0100
Message-ID: <20240318113140.88151-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since v1:
- Move rotate_arcdegree to QemuGraphicConsole (Akihiko)

Hi,

The idea behind this series is to reduce the use of the
'graphic_rotate' global. It is only used by the Spitz
machine, so we could convert the '-rotate' argument to
a sugar property on the PXA2XX_LCD_TYPE model, but since
the Spitz machine has been deprecated recently (commit
a2531bb855 "Deprecate various old Arm machine types") it
doesn't seem worthwhile. So just extract the API to change
console orientation.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  ui/console: Introduce API to change console orientation
  hw/display/pxa2xx_lcd: Set rotation angle using
    qemu_console_set_rotate
  ui/console: Add 'rotate_arcdegree' field to allow per-console rotation

 include/ui/console.h    |  3 +++
 hw/display/pxa2xx_lcd.c |  1 +
 ui/console.c            | 23 +++++++++++++++++++++++
 ui/input.c              |  9 ++++-----
 4 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.41.0


