Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372A1C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpoP-0001cN-09; Mon, 08 Apr 2024 10:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtpoL-0001bf-Uz
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:17:26 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtpoJ-0002tq-3G
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:17:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e67286bf5so1066195a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712585841; x=1713190641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/7W7IvtAkF1IEm16XTVrZzndvYUloGN8MiRSdIzHpX0=;
 b=RqqFru+Fw+a8c08ULEP7UFSXEr32xwoacidzK1kiPPr3dkNFWq28iXGHfjPEhNRZ2j
 p49OQ9gXfDJis4TtbJNj3K4/D9wj+Bur6VZdBM/SCozyPkOwQSdWiWbfnTyKFCUE5ct0
 7DpTWsb+Fx1xx9/tkMq5Y5yGciACmqJeVts1hpJJ9t+GKNPmRrRtHPnF9jm5yFw0O7xq
 slb838ABT5WmVjYrdkiPEYyLja4BBhcN7VSMXYkXBQFRLfjhGrooLZ7AvDDOoSoP/pEf
 bXjiUiE/uj40zX96X0ucxkJYVvD1XsqHnO/KCYeC0nRvfMp0TMEhgNHhAl5Xr/kVW0Xb
 EI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585841; x=1713190641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/7W7IvtAkF1IEm16XTVrZzndvYUloGN8MiRSdIzHpX0=;
 b=XrnT4381LEDUtZaAEEWm2cuYxK7YFS0I50o5vHXDCothnbwne3tV+/+hf06moxw+pK
 rkbxX/vtAEQMFoimTMXK/gPqWNgkMU0p0TTh1LpreOSo7DQLFuTCbFCvFV6Djte5VU9h
 oSeicNyrLTBnRTzDbt3KOwL3oaW/dhSguEmn/WYEh38pO2rxjyxWwXaJxpOj5Jo+/Adt
 u7y2+l4se3uD5TA5NQyprM3ymb/m7GFLPvPOZTbVPRDAvfIDhBMpceV5A2/FHedmnYnu
 JswUS6bFg90TpHLiFxZBL+hlefU7iTsjrUvJ/PX2FXkjeDzPp+3JEpUzKMETnNTqtveo
 EeKA==
X-Gm-Message-State: AOJu0YzS0p4mnoXW2ZXc3fxISD1vZ8K+81pstZ8N0cNSiWtONOML/4Dw
 W1pInDNhZMotaEUKyTq0nPmPjiwgIxIv0s6V7ZgpIjQha7mkwPxlZUKadHL187xyw1YYNIh2ek2
 r
X-Google-Smtp-Source: AGHT+IEvGdmLytMVNozVQ53NoDuszP97wb2eA3UdTId7bTegaP7Ywd+FDOcrbhbGUkka6tWbkfao9Q==
X-Received: by 2002:a17:906:6a17:b0:a51:c1f7:93 with SMTP id
 qw23-20020a1709066a1700b00a51c1f70093mr6070542ejc.13.1712585840900; 
 Mon, 08 Apr 2024 07:17:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 en1-20020a17090728c100b00a51adace6ebsm3895589ejc.79.2024.04.08.07.17.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 07:17:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org
Subject: [PATCH-for-9.0? 0/2] hw/sd/sdcard: Avoid OOB in sd_read_byte()
Date: Mon,  8 Apr 2024 16:17:15 +0200
Message-ID: <20240408141717.66154-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Since this is Fix day, I went over this old bug:
https://gitlab.com/qemu-project/qemu/-/issues/487
It happens to be a QEMU implementation detail not
really related to the spec.

Philippe Mathieu-Daudé (2):
  hw/sd/sdcard: Avoid OOB in sd_read_byte() during unexpected CMD switch
  hw/sd/sdcard: Assert @data_offset is in range

 hw/sd/sd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.41.0


