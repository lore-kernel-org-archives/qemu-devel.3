Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77138C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWQ-0004kU-DZ; Wed, 12 Mar 2025 23:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWH-0004hc-FE
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW0-0007od-LP
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:03 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2241053582dso12852075ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837547; x=1742442347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWzBKO1/To0wCT8nmaMy44WaiVDHmmm+TeyiC/0cSSM=;
 b=Jn83QHQmKzbeHgi60eZcye8J0C6hV+kz/60MJTR/AzCcWswXWe82sH9eQVm79Ps6c3
 XZ16lzZGdUXToTTdXUGXClMp1EZhNyqWcxlRMhno01ZJcGDCrb1La5gin4z+5Y57+Ryc
 VBLhN6mNz5ohqJQCbD4SQtOpwd5+I5uoVYBC+N+yg3SqAibR3QVw7u+up7lRm0y9B8Vf
 B637rcaXqeN5f/Spxv42GsGjru78AMGqBTpjd3OAe0+/UvwzY/B20xDOkjORv1o/WL1W
 0kXp4JNzu3XjN5cbH30IrWHje1PRSYnyYGtMT/g5L89q+Y5zukxL0ZO6SlRJXVIGCMFK
 hPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837547; x=1742442347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWzBKO1/To0wCT8nmaMy44WaiVDHmmm+TeyiC/0cSSM=;
 b=lfccvN+upIYwHcSpL4Qt1xEW4a/jCIXdG2evdfmzQ0PYW+wizg6bHibU01+bpS03wP
 PllU9xP/ZOl/Vg2x5zgPhxZV2JfmUrY0xI4uFAtieSIDqPOZu9KsquwTUrzrmxSnK821
 1FYxS+N83Vd39J05PopU/WmCPaQSHHfZ9YWXxrYbGFYwMms1o0YFTShNdOaOl0TvslSO
 A1ZQeC7Q02BvoBuATUg8ET9zVEi6G1YePEQW/bFUrhvWXKlDt5dXXzoVLd6btcaT9zIv
 NNyPK2RP2BYREvwT8f5Pf1lphoR5+AGx8lccG0BfZYiRT4TycFkBF5NrH6zm2+2w3ccn
 kz4g==
X-Gm-Message-State: AOJu0Yz4bulcZe/U2AWkM3acgpCs9Ec78I0PK+Ntz/GELAyVoS+pEuLg
 slpDSrfGxBOos5VF1G2xL9GW/OKdWi1cgtY+h64Y1bBGDRCGBJWqRdlQMKD8AVermQnLGykzX4M
 u
X-Gm-Gg: ASbGncuJR8zEB5NW3jBqe4skKTzepTwEX0UxikkzHGvqwz740MB/GJjVR4aO2W/qMdp
 Iy0JBTS1qd3GA1XBvOc0zVOmwgoTmxBYsxJbbfB0wydqmMPMyAfNvnY4fAZWAijZ9uGQbS9uLJg
 AhGcwSoI+Ly4VRa12V7jjk4c4B9FqLu6yheDsTsorgRP0pGKQhQg/NVB9w8uJNVtyVIhTiSBEOJ
 DLM3QBlbS+qhilpiFQrUOkNrr8bLMk26w1mmR7L/D6mfTRII+C3uvTPKXGq6eJ3/JPH7N+oqaor
 CM2tc+/zkRWzLnLSWWGtdDVMqbLvFpfjVP97epidfME4ep2sFu4IzhIINVwotTn11r/O8EY7ncw
 4
X-Google-Smtp-Source: AGHT+IHuM9nTYXQ78i5GwdOtHpevzF+oRd4E9azon2ZhFkfEm0L0PCFzGrZhWWp38KupVCrt438/KA==
X-Received: by 2002:a17:902:e5d2:b0:21f:859a:9eab with SMTP id
 d9443c01a7336-22428ab8647mr364309085ad.37.1741837547216; 
 Wed, 12 Mar 2025 20:45:47 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 26/37] hw/core: Move unconditional files to libsystem_ss,
 libuser_ss
Date: Wed, 12 Mar 2025 20:45:06 -0700
Message-ID: <20250313034524.3069690-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Many of the headers used by these require CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0ed..547de6527c 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,7 +26,7 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
-system_ss.add(files(
+libsystem_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
   'gpio.c',
@@ -46,7 +46,7 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
-user_ss.add(files(
+libuser_ss.add(files(
   'cpu-user.c',
   'qdev-user.c',
 ))
-- 
2.43.0


