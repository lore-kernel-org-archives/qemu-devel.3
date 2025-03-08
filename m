Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D886C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr277-0003Lh-75; Sat, 08 Mar 2025 16:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr275-0003KP-BD
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr273-0000xf-D3
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:43 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so2554240f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470820; x=1742075620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+USVfbqbvkxo8yt5Lac5ZRGOWAYMoefLOeZ1OEowSg=;
 b=l5l3baq4ovIEU+hRhKAbKGHUBJaOEZSEx3kXewXLV3TXxn0xN06rz9LJ39kYbKugmy
 2vXFO9gwN/D+dq8CnI3+Euc+wtCfGvgnDmSP5lsrdRCdDB95RXmkDcNJxBEUrKcGvGxH
 WlUkNKclmf2LwK+t9uEiXgv5TbqY9Km7uuRwEeKsdf6ExSMxACKHO6M+k+TKRYFu45Js
 wH+nWRb1bwL59F01rrA2bFBg9q8aKmIiSTF12MOOhdxK0puhnHVrvOGY1r/fvsJGkNAi
 Xs20p3WFn1Ava4tD4EXD6ea6GGcGz02OuUbJYv8lVyc7xzWakjq+s3DssfEuDabi/AMx
 4N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470820; x=1742075620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+USVfbqbvkxo8yt5Lac5ZRGOWAYMoefLOeZ1OEowSg=;
 b=wR5IJG45FTFuVBQM3n+Q1/dZMtttSDNPqekI506kTPcFcmZnFjWyYbNWPyTvIS5VDS
 XSk98/hGljpPVbYPKUGVfCbLBhlVxfEG32CMD41nNG5E6H64CyX7Qiutx51/Bqt9u/in
 HveMtUu6HTYmCuJUJA2KR6yiML+7CiX37eA2PCsOpomXHhnAzaGfYaCu73ZZRO4pnQZi
 tANs57NtQXf2CeH1R/nrU4XKJT5qUoaHGC89T6l1JmotgiRjSkNgl/A5Vb6HpJsL/sfd
 OnbOG4z18E3R1bNoZhwF0rBLORXFy97uvfr7GIruh3YMSrbn5N+LIzVSW4UVMHBJMrfO
 oWqw==
X-Gm-Message-State: AOJu0YyTMhVWq2a7LckwO5sFJfM2FIp8a5XHi09FG4m2TRzDR+VwIzRp
 QnYyM2GKDXtcCTglIO9nYYvIE7uUKyDBeD9q3Y6obYwUXwJ2VfTgsQAjb21qHeW+38KuIBs1FEw
 9
X-Gm-Gg: ASbGnct/OmGFF+CfszC0DbsS9RK1iQeG0JZtMONUIHPcFn0xb3QVX6DZkbxbwTo5PSf
 ZRGdmG5tUrVgkpQ/BZZrlI0mV+lU2OUr+oNfX8KaaYDqSyocelWs1KXGf7rAJ/i3prSDKCnZfiO
 O8/uTRNYS5qHCFWWjlxKf0m3SbpND2OObMsA+uuHbQtYa7O+vvB779/jEIqk7ezyoQdwScbQ9A8
 tM3wqlIoKakT3l5t2YtxFfH8q5L1HPY6nzP6AvoQtj6EJRx/7m013V8rNgTxSet3qUwkpB0gWFe
 jFls25JlPwVuJU41X92R5sE+cX5mDaOY0GtFJ4R+SPZxVtI=
X-Google-Smtp-Source: AGHT+IFFmEi2/mv2d0F+zM2LgcBkryGZf/wxb5vRykCsNmntVoKvhdH+gSpWFOrB35NusKOCDAs+tg==
X-Received: by 2002:a5d:47cc:0:b0:38d:bccf:f342 with SMTP id
 ffacd0b85a97d-39132db8b3cmr6610895f8f.43.1741470819840; 
 Sat, 08 Mar 2025 13:53:39 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cb82sm10210678f8f.51.2025.03.08.13.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 955E8611FD;
 Sat,  8 Mar 2025 21:53:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 31/31] MAINTAINERS: remove widely sanctioned entities
Date: Sat,  8 Mar 2025 21:53:26 +0000
Message-Id: <20250308215326.2907828-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

The following organisations appear on the US sanctions list:

  Yadro: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=41125
  ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890

As a result maintainers interacting with such entities would face
legal risk in a number of jurisdictions. To reduce the risk of
inadvertent non-compliance remove entries from these organisations
from the MAINTAINERS file.

Mark the pcf8574 system as orphaned until someone volunteers to step
up as a maintainer. Add myself as a second reviewer to record/replay
so I can help with what odd fixes I can.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-32-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 756432add4..70510a7952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2546,8 +2546,7 @@ F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
 pcf8574
-M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
-S: Maintained
+S: Orphaned
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
@@ -3659,10 +3658,10 @@ F: net/filter-mirror.c
 F: tests/qtest/test-filter*
 
 Record/replay
-M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
+R: Alex Bennée <alex.bennee@linaro.org>
 W: https://wiki.qemu.org/Features/record-replay
-S: Supported
+S: Odd Fixes
 F: replay/*
 F: block/blkreplay.c
 F: net/filter-replay.c
-- 
2.39.5


