Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DD9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfT7-0008W3-6J; Thu, 12 Dec 2024 04:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfSy-0008Uy-Hi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:26:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfSv-0004Io-Ii
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:26:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso3904875e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733995595; x=1734600395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yo7mpFIo9pjBH61QcJ3QSlduE8OS7dL11fHaPt4toi0=;
 b=InA+i+zRWks7MUecxObZowYWF0XGwRirJTCP91kAEqjd4mAfYfWBllFItfsci6pMmH
 zNYI9A16LWHHIR0mkGapSynIFs5GlfBeLmqTMix0VIqC6M5J0qfAwMNacC4GLR87948L
 8pj5QbuwhwcVE/ElzDdg5WqNjBLOoLYyEwbb49FCn6NTEEFt/ILVJ7QwLvAy3+Jcj6Dd
 Wz4tdVpDvVR1/TcC/E5nYUTv7gH8bTbd+b6+A1i70sFe8PkxH8luh3byVjdP0qjxm3g0
 stdtLaCPB9+kHQ0YemeP0syxvnNwxEbVZFLrXhWQVWecBXKBDgwncZdH0VVmx29k/5DW
 S0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733995595; x=1734600395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yo7mpFIo9pjBH61QcJ3QSlduE8OS7dL11fHaPt4toi0=;
 b=QMB68F53NKeYRe9HYc4mPkeGujnSnn69Vh3QxnmhUfRvsaXDw+aLlIQa/TiASglfbh
 es7iKgWzrLt/b5VHwrJG8V0ziauIZ8JuwV5uMQKzbT84afkfAR1KFmhX5cutXdiKM67X
 pPckqIstuYXqWbHuM0P6dlIQ4C3WM21yMB7lYPRgGWUAu5P9UplbVD9fFwTRyKOLZDUx
 lgJIaynFQ/c4FKMT9DLa3JmTYe0Nby/0AqN1FnrXl3NgS0r4+uP6MDyzxVDzmAnHxs++
 4WkVj+jq/rkVMh0nSQOQXYUyc5Nj+x1AMeLrCnEcRzujuFw8RAZWo8lJjdRvxXZIXouH
 fmwg==
X-Gm-Message-State: AOJu0Yyv6Ni/vD4qDdumZ/W1PkhBqTIemWY5lrjh4CFfZA52SP+A3V1C
 0UpbV9ZNBGuuuF6gUFd1swvtI8Gpm+4oSGF3+kj1Oy7e1IXfxIJ7r3O0+HVX0fstXorjmfUNz//
 I
X-Gm-Gg: ASbGncuiOVWLD7PNL6dpKrpZHaCnBnimBV/KqfgoRDcxjbgKAwJVGw/fs+Pai507o7v
 U1UwiWl3Y6URBuLkPo54oAy2Oy8AkIm6T3aHyyuUCo+q/jD7aK4sKMlJgl89f/dYDqX3Ho90+zM
 pCfSbFqiVbeIwosc5jse6rrUMIhlWiMfO/jKei3mPA6GDNXQOBSP8MK5/I3OJE5O33XLihpIY8e
 WLFmdVPacPUGS47Fxf4KOUDyakxBhYIuXB8an4zBQxrEHsTygBpGMYDrxub1zcxl/eJ8993yHXX
 qsxz3ka/77a9rmgQN6B7lAMr3ANH+c4=
X-Google-Smtp-Source: AGHT+IF2Y9TLq0Ugx/IiFi2x4g8RuYyWJnRoGKWbIzOaJGj7++hF0QFsnNqqo3h1UOB6O8jtZwotIw==
X-Received: by 2002:a05:600c:3109:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-43622883cbfmr24767175e9.30.1733995595197; 
 Thu, 12 Dec 2024 01:26:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255531b1sm11115665e9.2.2024.12.12.01.26.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 01:26:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Haozhong Zhang <haozhong.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] system/meson: Restrict libSDL/libpmem/libdaxctl CPPFLAGS
 to vl/physmem
Date: Thu, 12 Dec 2024 10:26:30 +0100
Message-ID: <20241212092632.18538-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Extracted from a huge branch where files are moved from
specific_ss[] to system_ss[] after exec/ headers are reworked.

Philippe Mathieu-Daudé (2):
  system: Restrict libSDL CPPFLAGS to vl.c
  system: Restrict libpmem and libdaxctl CPPFLAGS to physmem.c

 system/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.45.2


