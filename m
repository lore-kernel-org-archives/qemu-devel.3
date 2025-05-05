Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483CAC3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1A-0004LZ-SL; Sun, 04 May 2025 21:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0k-0003w3-OW
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0a-0002Vj-8M
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fb0f619dso45251375ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409959; x=1747014759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=NSboboA6wc6lHfWnXK39vWO5g+nsy/ByF0hF29qNePpUErhho+2yYHDAKkfKK3dZpk
 tfO+boFMQdaimH3UTpxvmQFDUAgfqpDhchImYA1jgSvH8GiXuHOe4Nb8COS73jDU1HPO
 kdiOmf8MkxNmjROZ60PIyD63UXnvOrGumXh++wdNNj7qwYIftoPzeAQMrjKgcS76mIJn
 RVOEa5v7Ydr5VhqAf5Okh39zkLaxFi3UYLaH5m86Px0cFLmn24XW2l04kurFEfkYCS4t
 ak5DVQ89l1MytxCQPB9eum6/ZWPpYk5HCmBXczV6+hMlTGX36KrpdoOIXbcGIlgyCosD
 4ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409959; x=1747014759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=FwV1FVR5kRYFpYM+PHcdzVB2mILzAWzVXpyBaqBziZ6jOjTaETnSD1Asv8UbZsiJpU
 v1IuWQ7xRrvdPCX7VPRSddnl8fx3aE/9v6YkWwOzqHKOQ+oy0jz5dSq/m08eB8QGvjon
 FT9PFaZ5QK50eB2RAPR+qX+S241XipBES27n9tbDPEavYfV2yFIIU8lbal2hofKz2t49
 tDHuamBLNB+5f0lfwfw2AWzm/sUuVJC23kYOtClcyv3ZKdAR9lvRxdoQaXupv4SFtoQc
 dgWHMBewyG9bWgbT5AfLeEAS4ocdONPHXHqUt4yE82K0D+lk3cBeMXKQK/8rxydGQcIg
 gXTA==
X-Gm-Message-State: AOJu0Yw1AVWwYAJS5m4m42pyUacIG1HmtG0AEDaprcl81GAe++i5tnwu
 XSEVDGJ3G+jNPO7QMOA9K/J2lwYEtK1EduHwabgfA/97BXgBDOJVgmXkFwBMn6rViJm7C4Z1eIn
 18VM=
X-Gm-Gg: ASbGnctT6Ml77mhWfklVCqrZ0uJ+QgrXdScEz/YO91X5YqAc85hcOXahaBLOtM+h705
 AU3bF3DrUQxwu0BkD+qp8/HSY/4OHwh3uFFF/EAdvrJXJXGiHMxNmeLsrhhiVVAqPssd8EH1Yh2
 +SacYFWp2sQk+ewd0f6TJZMkOLDDs14HjBWdsX6LVzD0JsTLaCn/xW3+7aQRZ1ggQDbv35G+PgN
 NZ0u4edJG8IIZB6nvKDJSg0rxpmY3N0rEwZhsPL4pMEwypQvJoOqnJcBz9g9f0drH40r8jFbo4m
 6SY4Wbxngxo3PTQ4f6aKZsV2oRU76DWn5WNLWtJy
X-Google-Smtp-Source: AGHT+IH2XYPu0agU5NsK+ys/z2YA1Zwc0j1DLfKUy1KfhckHrNgq8q2AagzIWxHqSSDuA5GNwLG8hg==
X-Received: by 2002:a17:903:2283:b0:224:910:23f6 with SMTP id
 d9443c01a7336-22e1037eb17mr163332895ad.45.1746409959031; 
 Sun, 04 May 2025 18:52:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 12/48] target/arm/cpu: compile file twice (user,
 system) only
Date: Sun,  4 May 2025 18:51:47 -0700
Message-ID: <20250505015223.3895275-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c39ddc4427b..89e305eb56a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
+arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
@@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
 )
 
 arm_system_ss = ss.source_set()
+arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
@@ -30,6 +31,9 @@ arm_system_ss.add(files(
 ))
 
 arm_user_ss = ss.source_set()
+arm_user_ss.add(files('cpu.c'))
+
+arm_common_system_ss.add(files('cpu.c'), capstone)
 
 subdir('hvf')
 
@@ -42,3 +46,5 @@ endif
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
+target_common_arch += {'arm': arm_common_ss}
+target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.47.2


