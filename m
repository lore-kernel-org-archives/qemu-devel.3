Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB690CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1LV-0006Gp-Jy; Thu, 06 Nov 2025 09:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH1LU-0006GG-0L
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:52:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH1LR-0006by-NE
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:52:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so818717f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762440732; x=1763045532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zaI8dwX6Y2BdaaWy6Agd0/TSyHU8TUnREyK7ku3Rgz0=;
 b=jlb1fgSo4aVz8jl5d00Fs5/dFifhyMR6O3/Qh5WdEuo7JAfd2dojCj/TGlKpPXLQI9
 OkC6SRn6tloeJuGMRRAX9cdtkLPn2sqwqUZB9KU2ouyQCUUAvrHgxrVLo2TeB9I90vcm
 ha6x4dP6vs7kYAA/KHk94CpO0c5c9dACLGtx5nYnQ/U3x+yPFucsqInl6vPN3rdjYUee
 jEKaAI3PlmDmcLoWxWUQehBvhm0lah7cBHA4cn9XbFdN1rdjhr7z7cAYdm3SjiNyP3Rm
 c+Prhbw8wWIs3uzHwHfMTskYxkZ8vJyiTDSyHKWhhV4pjiwwppmfKah9eDuF/erZu9Ve
 stOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762440732; x=1763045532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zaI8dwX6Y2BdaaWy6Agd0/TSyHU8TUnREyK7ku3Rgz0=;
 b=Ahq+8OClRgoc2WK8qErA61lue5xYVvX4GmzWpLmn5l+RnpR3ipb6P6mI+48371SJxI
 H9CzHcQBjnJNhUSNXj+Ten29dWEXMOwQ4wPEdYH1GeAJQkQC/2580aH7r4yFh8AV+fzo
 w72K3hBx6b1GNyQM3qaPFId3dQ5wyo2udO0x/VKelGcFj+avHw7yZHdESfH1BMOHz07o
 TXPquPHfRJ1goX24+muIiI54eB3JVr8JlshWk6nl/HnDP1zUK9tRy5+ROiUSDQIFeIEm
 SmfTMoe8FzWr1HmXuIkjb8DL7Ye2VbpGN2Q2n01F5FUJUdjQ5fpr7PtSsGqaVHV1y7yh
 GHYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjDPl+/CkeyK/93E+McpqnJoB/v50IGFGEm7Kob3xPTESW2uQOupf+5tRE8FkJrkAhd0IxoIpJPi4k@nongnu.org
X-Gm-Message-State: AOJu0YwyvvVPx4oFfUd4VXedSbPtlxU8NDSHR9VpvMSS/1l6wiqn4F49
 6tVJh9bKXaWjSF8Cf1VMeJWrGd9cnpoDKIgIaB+XNx0Gty1NIZuCgBsUvAybXASI3b0=
X-Gm-Gg: ASbGncs1QUBhrrXudYWMMLoDbbugk2qWA4d5DtA1zhD0cBaMXtj5SPkC24ZixeKMtyS
 Xkuy8nkcdduluRdP04+CeM4ssujld/vXnG+9Djs23Hwz3ly0MdbcTvWZPI/hPJPnYH6zOhvTGOB
 +lE2GJ+LIybSTUZTKlBndwpmrz2r9CDns2la9vVMh3c6aETcw+yYJc5nAc/Dema+69nRjJLPOAa
 GHRPsJ2Lhswztfj2UpTqPFYYNU0/VATNu15G4e2l7h+xA41AnhEqJH5SB9bjSkcb38B5Y+4ljGA
 DH09Kx6Mrm139cRC8OSo6MLyBwAKrhsMsR1IhzJMQpSBkQPTFediDhvWV0rSvDXPUK2Qq3wQkWH
 k3MRU3vCO2BwDZ8n1Q/Zbm9pfax+b5E5rgTHhaKL636McvjAe4e+9UChaJIs1CWgSEKj/QoIBEu
 4s5Yxsp69R2+KwelIi
X-Google-Smtp-Source: AGHT+IHjFsjMpxEgFpio8KVQEl5zJait4ivfHU5hGH9axzMaL7P7WlFSRKWsM2k/j2Jt+NwYUxRw8w==
X-Received: by 2002:a05:6000:26c2:b0:429:cc6b:e011 with SMTP id
 ffacd0b85a97d-429e33063b4mr6566070f8f.36.1762440731924; 
 Thu, 06 Nov 2025 06:52:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb47721bsm5694891f8f.25.2025.11.06.06.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 06:52:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 0/2] xlnx-dp: fix a couple of fuzzer bugs
Date: Thu,  6 Nov 2025 14:52:07 +0000
Message-ID: <20251106145209.1083998-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset fixes a couple of bugs found ages ago by fuzzer,
where a guest that tells the device to do silly things can
trigger an assert() or abort():

 https://gitlab.com/qemu-project/qemu/-/issues/1415
 https://gitlab.com/qemu-project/qemu/-/issues/1418
 https://gitlab.com/qemu-project/qemu/-/issues/1419
 https://gitlab.com/qemu-project/qemu/-/issues/1424

None of them are really very interesting, but the fixes are
straightforward.

thanks
-- PMM

Peter Maydell (2):
  hw/display/xlnx_dp.c: Don't abort on AUX FIFO overrun/underrun
  hw/display/xlnx_dp: Don't abort for unsupported graphics formats

 hw/display/xlnx_dp.c | 81 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

-- 
2.43.0


