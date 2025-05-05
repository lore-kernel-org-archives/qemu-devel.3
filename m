Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D15DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1R-0005XX-86; Sun, 04 May 2025 21:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl11-000480-V3
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:08 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0y-0002ez-R3
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:07 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so3473723b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409981; x=1747014781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=xeJXNk69BFAH1KCfczn+5cIQiDMUt8Gur2hfl1NnSFeVUP1fU4qZ+M5w/Z8K8MRDGr
 y6T+cCblyOhdRCAW8WsBCETG513U46PtCmYCts3Kvi7CyrXXygRs2EGiHTOqnFoilhNU
 X78jzDRM/qGkvvFBFrqVNW0bUO9kqxnXapBXWGq1up3CmGx7Uws1O0V1rXu85GToyWdT
 oCT2fetGu0zas1yoQy1olzZyZ2XdrcvJhZ53fZ79FhPNAwMrJxW//h5lCrFPywDrBZ+i
 OK1ciHXA11otfiMRzSGaRtX3+ubi0gPnKMjfE5lLk6aW6eb5YEzF1mvj+kWbuc/+UIEA
 Diug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409981; x=1747014781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=GED9Eyz2rrmQI9Q9C3XoS0I1UB6OErkS3hP7TTuT/L2u4L9X1judAGsoHwbhWkpUT3
 HfjRp0DZxsmdo0VKwuZ6JxH3IukvIatplwLfLFtYq6gueVHzsAOhV6StfGuh9yF8VMWq
 AWOUE4TG2tBVf2bo8ipKCwnvAh245SMWR/cR8A63A+ol7TS/nKrDhaIe29PQDoc3dndh
 zj0KSCKfcf1RqyocOJjJvK/8EhreeXYr4pMnItZCHuXv5xhuJt/6r1Q+dYIBbFS7cMh7
 U6uPKA1TRCjFCUPhMnCSWS9wVGdmtpHg835Cw+4KjRV+2s7x3ohyts3iG/dAz/nMlbse
 1dag==
X-Gm-Message-State: AOJu0YxoFHaucN2YIdFkYfWqQn7D67s7HnjYrcQDvy78/hHyzBB3jxID
 qgKcqbqlyhvBGS4kg5nuGST7UyTTXFniDaI8f7YDbxsowZwt15UoA0c6/ueZiY5gdq4owV5smpW
 8A7E=
X-Gm-Gg: ASbGncva+ZTRe6BJbqxAYUKQD4XfPDPWHwCe03SD9U4XexjEV/aLCrW7Hyvg4qIJh/i
 HWvm/tTUNOeBTkgfOFo54CkmRJ4nbSz+/pDOAIZaZ9NUyqLyE3BZ3fBZ0tQdYnKaGLPNUP/GXWA
 ++JmOMFlyVoQGl9rrpYfJ56qbx5mtApAy0CO3bR3N9VulNp8BAa3Wjk311E8bQm++mP4665BRY3
 9B37HyhHZvu2M5+imIx+7f/Zk0jkN9UjJ/ec8ZPrmz8Ct6dtKmgzkszDcILbW/tF7P0R3+nEPx6
 3klk4QPiD1LgvMBM2RovgymVHVutwRpY72Pja6kl
X-Google-Smtp-Source: AGHT+IHfI0k8vkxFfPNj2aCSH0PSyH++uXGXhOEGH/b7PGVfp4DeG6fFush3rZ7gI58mdIV36AorCw==
X-Received: by 2002:a05:6a00:4c0e:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-7406f0b0434mr9256730b3a.8.1746409980959; 
 Sun, 04 May 2025 18:53:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:53:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 35/48] target/arm/kvm-stub: compile file once (system)
Date: Sun,  4 May 2025 18:52:10 -0700
Message-ID: <20250505015223.3895275-36-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 29a36fb3c5e..bb1c09676d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
@@ -32,6 +32,7 @@ arm_user_ss.add(files(
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
-- 
2.47.2


