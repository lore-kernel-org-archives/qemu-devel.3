Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD71C3601A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 05:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1emu-0002Bg-AG; Mon, 07 Apr 2025 01:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1emd-00029M-If
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 01:12:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1emW-0008AF-5B
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 01:12:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736ee709c11so3134879b3a.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744002741; x=1744607541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zusCch9FImW6oGncn8OA5zMm4oNmCGZArYeLzS3lho0=;
 b=BDPBnRJPR+tc4Nx2KQOOiDIkWJkfh5S7CxsyDcSeeFpMJOdKcNsL0WEu/uVCFDxlf5
 kGtQPrz+VtwtTPRY5noserLepDB5BSOPCIdqY6kXkKw+/RboIDa+dqxoWm5s4WNUwTwR
 7cgSbw185IxDyhzP/b8WvLhENfTMSXc7ApSwmDaeFoBNSV/mxs/F7z7p5iIwIJBd4khZ
 6FEHQ7JOOjpvrDvYoKQ186Uyi4vaOe4vjCuFsWfVBjEomYc2uZimoluJIdTNkdnk2kT2
 Y1vZujyyZk2xc3dQyFp9IQHBkxJTgprLUQ6up+WE4Zi3WMle5V2U2jry42olE3AZBqMA
 icEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744002741; x=1744607541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zusCch9FImW6oGncn8OA5zMm4oNmCGZArYeLzS3lho0=;
 b=u/RrBWM4vFZVxOC7apMbEGJFls7YUir3G4VVw8eBdEU0+sY3eeJAUMiJx/zrwNhRrp
 CEBFHkYrfiBqgATtzgsErd23lJC8/YC0uXDIBWSJGfAsdLPjU7MOwcilY5CgwYWZGkof
 qUIhLVDLs+S9gX1oxK5+uMMRDcElB1s33ZG6rv7VkfPfGQgH0728UK9l0APgRndQi7tH
 uQWeTX9aPEt9Nhg156Vd1rtl0a/4weQZr7YeFwee8eejykTp8NnH+VIUBJcV6uBAIm5L
 HHCVPem+k3FNrpw2G/1LI+ekCgNi/MxCLWmhw4eIWZCBDEypo5rRyO/s9oalTUP8yDk9
 sXZA==
X-Gm-Message-State: AOJu0YxUoj3VW57f8M3oxMoMCv0OOXpbi20s/hT1tZ1OryxN5x4hU/Z1
 tlxP6abkHja7mjYxzSHFlLHjarlPxeKYCQXrRcLTUPjwEtFX+siBYw7JEw==
X-Gm-Gg: ASbGnctYnlqJWsrXOGCyQpCrWNJwl5aVwVxq6crlIlcDJBaO4qyKmERODJd30EKZJZX
 qdJaqbV4EDmNsQNbThkdYfArzbUN2ZodGqUJPEGc+ck/i60B5/2rrBSgv2oI92YL2zjCjlW+/xr
 D+45r4QL+3Emrj/jVom5nQDukqxhpVaw2tPuCSIu7EqO7GJfDKotkhIt1e2VKqrlFEvBxlK8kbN
 fEncY8495vEii9i5rdZqII7+EYkcSZ6O3pnOLZFyd9vQfoJp4wKMCZEabxpOdlh0qhGS7ZIrozM
 Xt52OMbcELVDAaXLzt6nhxM5dl4+8LY+M17NE9Y2QcAyLCKR5SWG2uSGABEvg9OgGZdO+IW9uio
 sb7otMtb7K68yKlCD0MLdzD93sSvLydBVR0Uiz9FXVDl4WGJsBgU=
X-Google-Smtp-Source: AGHT+IGgfMJetmxIvhXbB0T4hWFqk6573zn3Ghdb23wrEGhRzCxixfK2YdVS/GNv/NBzQ6ZK7mwf1Q==
X-Received: by 2002:a05:6a00:399e:b0:736:6151:c6ca with SMTP id
 d2e1a72fcca58-739e6fa9c2fmr13743846b3a.4.1744002741457; 
 Sun, 06 Apr 2025 22:12:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc41ae31sm6435665a12.72.2025.04.06.22.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 22:12:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/1] riscv-to-apply queue
Date: Mon,  7 Apr 2025 15:12:13 +1000
Message-ID: <20250407051214.95248-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 53f3a13ac1069975ad47cf8bd05cc96b4ac09962:

  Merge tag 'pull-tcg-20250403' of https://gitlab.com/rth7680/qemu into staging (2025-04-04 10:23:17 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250407-1

for you to fetch changes up to d31d37fded414959713678d2e9e6bc1afab5f376:

  docs: deprecate RISC-V default machine option (2025-04-07 10:12:40 +1000)

----------------------------------------------------------------
Sixth RISC-V PR for 10.0

* Deprecate the default RISC-V machine

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      docs: deprecate RISC-V default machine option

 docs/about/deprecated.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

