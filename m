Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072B6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPYJ-000146-Vf; Fri, 09 May 2025 11:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uDPYG-00013R-K2
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:22:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uDPYE-0007Fi-2h
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:22:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a0bdcd7357so1577041f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746804131; x=1747408931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3L8IJ7smViU/9Uzo6s+QEqifWFFE9joZ/9cY8U16AU=;
 b=dNaQqEdFq75sT9/sVEVxswdcC8MXhrxeSK/bArJusxEkLjTv88s6TfqjDoMuhiKT9L
 l0kwA3rusS9yj5uShcwnK8HvZKoVXu9vuZXmDlKKjxcBiAcRPDWR475D1TmlkE7z55wP
 AHgUKhFOLpab8ZejINPDck7jEoXo1scCmK0e296JmH4AiGEQ51njkt6fPBghv8mkNv/0
 ANhAsxjCrTtPFGYJj8jfTho8j86Qa6hZPBPMvpyxUJUyz/jI0IdYN8id8xSHLd5PWbq8
 Rz1BurdpL89DauULcY4lnc2xjC9Dq5MetMDg1Rq+6r/MSMJHfGAEk1aB15eyIWQALkmg
 85MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804131; x=1747408931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3L8IJ7smViU/9Uzo6s+QEqifWFFE9joZ/9cY8U16AU=;
 b=iEpcAw/b+amjEuYe7D71/CY8dEab+SWdxabYVx/pzRbr/zgUIcNcqKw39eFbLKC3QA
 nb0gmYr2HFd58ID7OKB0gpTNjPESfq6MPnVtpjxZOGKFBUv1oGHhyH1T7UhGmZn+8diL
 KboBphfMdlwb3mGWQr68t60wEhDvA6IAObNuYzFDTpOsCkth1VCbau9+2U6fSscT10NX
 XC5mV3A4Y76TNkrTiYsNmJMjophzMrBu8m1DbalgkVgKBX0X9gYnHKOc8buKIplmkfhq
 B4RjVJZj8IqcoYfVApDfXTBibO5/awk8L9pSCTgMZe6ZLF3LXFu69js2xj335DIQKQHa
 OmPA==
X-Gm-Message-State: AOJu0Yzf2FTBDnzQ7PjAgjsms1ni+Zj4PtrANUpEraL6AgRfM8wyfNOR
 xdgOKk9NfMRZWthrgCBXDjfE5hTeobmis9Wz/yK0EeNb5CPajPkfL6EIQiF3okO2o3B2rUD/gI2
 9h/s=
X-Gm-Gg: ASbGncvBZRJcmZqnRXH0T/sXSJIw7P4Ej3bAhTPg2hAa/jLEcsiJs2jHraC/qv+wXOg
 zSJxdB1P3x89w6aAdBNjnMg9Y0bZrkC5nZmqW8evhkHlgmhRx11pcJOTolApzLFEhlyIVdWzt+B
 BwDb1N5Y1PO9zwtRwjjxhYa29XtH2n6VQMqaQok1s0pi6Y4ijMCR6/EE26A6AYewypqnUS74mto
 cR1mtnVCSUztHWMAAJs+prpbkcMKfMh0rtgi5AN2zi9r151CjFcqII6Q4UVDI5NYuovhbqb+Vwl
 a9o+3bBoN7oSRizM/0bjwoWSmkIt9QJuat6AhNEz0DWWMiiGcMyYAXNqZdwm+m57lNtVUw==
X-Google-Smtp-Source: AGHT+IF3vVv1IG7UetPvXYgwUy6xO7Ann44GxXpkx3dB6hlBYUqvuUt4VMMw3LfDpbItgFKuoOaw4Q==
X-Received: by 2002:a05:6000:2481:b0:3a0:bb2b:14e3 with SMTP id
 ffacd0b85a97d-3a1f647864fmr3530730f8f.33.1746804131241; 
 Fri, 09 May 2025 08:22:11 -0700 (PDT)
Received: from xps13.. (83.69.114.89.rev.vodafone.pt. [89.114.69.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ecb46sm3611817f8f.30.2025.05.09.08.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:22:10 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH] docs/devel/testing/functional: Fix typo
Date: Fri,  9 May 2025 16:21:58 +0100
Message-ID: <20250509152201.19085-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wr1-x434.google.com
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

Fix the duplication of the word 'run'.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/devel/testing/functional.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 8030cb4299..9e56dd1b11 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -274,7 +274,7 @@ speed mode in the meson.build file, while the "quick" speed mode is
 fine for functional tests that can be run without downloading files.
 ``make check`` then only runs the quick functional tests along with
 the other quick tests from the other test suites. If you choose to
-run only run ``make check-functional``, the "thorough" tests will be
+run only ``make check-functional``, the "thorough" tests will be
 executed, too. And to run all functional tests along with the others,
 you can use something like::
 
-- 
2.43.0


