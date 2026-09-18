Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D9C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA7-0005Lz-1d; Fri, 18 Sep 2026 00:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA5-0005LZ-US
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:21 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA4-0004AN-Jl
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:21 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-804f7045f3eso85169a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705519; x=1790310319;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3X5p8HsBP/JRwDiZ+tLss6J0kLBzgb+35YGZ9nZAIkM=;
 b=Ar5m7M6+2stON7O3XnvGqa/QXEoMcD1fPriHBhgMTMo8/kKrEJMHqqSHE8rs6t3zmq
 TAM2TyHLYvaruEg1244HjROLTlbKZ3II99JEWNF5k2EUPVvzxR4seZhvBMYsAFsS+Vsa
 XKtmYfNkgXrMRl7qkxEuKj02ROM+4XJ/f6X2aCbycEI/R68CR6hPCXNKms5uMcS2AIYE
 3abjdCOSMhv3zCg+XBjdB0KpZrXsZBCOZLd26p9USYUvpKyO97Dn0GjhlOua1GyxadVo
 00rWi4Sg5DeF2QAJR7peoCsl3n9tE06EDOMsV9jznsI20sZXaKQXUasxqY5rMSabHCEL
 Gp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705519; x=1790310319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3X5p8HsBP/JRwDiZ+tLss6J0kLBzgb+35YGZ9nZAIkM=;
 b=KfjNICq2Sw3UwjS4j/jO7neFGdynU50eON38NceErFPIpXvjgjS8tAE+t/M3ho9dQV
 CZXPgXFVsnmFFxBvLGG6usgSywYbs+uktXOPNMMjYML+Hm3e5HEkJeREnpgXC7kGZdHl
 AjDi+BTB42sdIlb2ZBct5zujxwQ9GlwPzDthzRvSfroXU5Mouep0NWMEtv9C97Alb6pC
 2BnmBlkiNnC3vhQjuCvXj/DF3zR1J901N2m9+Ew12jfrMb+sEscq/CKtymeGTki5ib99
 3EPc4GeHwEfDf+GHVVcK2VtaavNpFl4D0cRBI53V+2/mGD8hI2/T6E+LDWnYzWDH1Whl
 fD7A==
X-Gm-Message-State: AFuF++miACG+bbxb1yVtPMAyq9Ws8Mx0cRYRcgU1SvPq/TYCqpJR9S7t
 NyjpuHj5C1FGgC1HFdemOmGxd9cidkneGXXBkirFVj8Pe7ZoDZk2+NTPSMQYSPqy+S7jxl0lSkm
 vuIF7oo8=
X-Gm-Gg: AYBFou3KVahsRJJb1fy4cKVHKDDy6dQYaNZntUbfrQwAF+6QQm351iYlDfifvSysQjV
 V/VgH4fd50SWn7adam52dF38ctx/faMdXa/ZeFFhVlmRT6zDvXpRo1eKnWBxq4ExOZB0deOZlM3
 lTQjATfax0rRZst4RYMJlBI1o6Hsp5RaP4BKF1uZ4ChI54begh1AOQYVg5G7cZVEG2In9NZvbna
 Potq3x+fCfpBFHRiIeAYjWmv5N4EdCUgaWGOeXCiv4jWUxuMUj02piFUfatd+/wIMbdCpAXNDeP
 eTJzxA+++Yt83M6IB7MOIWNx8po8km+bqe6yHeRyWblwakwNNttRtO8uHH8oh1ZPBl+Kad9Zz8k
 o2RLQJ5WurYlI3LSupH3vm3WaSv5w9DltadL8Ts/puAZf5dz3J0Q0YUctUnRV5MfUhwEEvzzh80
 V1HwXUnYnoT5mWOGHgFaqlvv6eeJuQNO3z5mNTlLeMqDJHehjppckNuwgi0Ewh5Dhbuz+q
X-Received: by 2002:a05:6830:4908:b0:801:21a3:f304 with SMTP id
 46e09a7af769-80de38ecd14mr1655320a34.20.1789705519652; 
 Thu, 17 Sep 2026 21:25:19 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:19 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/41] bsd-user: Move sys/uuid.h defines
Date: Thu, 17 Sep 2026 22:23:51 -0600
Message-ID: <20260918042422.38713-11-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Diff reduction to blitz. Move sys/uuid.h to the location in the blitz
branch.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4af79669e2..47aa01fbb5 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -418,6 +418,21 @@ struct target_freebsd_flock {
 /* user: vfork(2) semantics, clear signals */
 #define TARGET_RFSPAWN (1U << 31)
 
+/*
+ *  sys/uuid.h
+ */
+
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 /*
  * from sys/procctl.h
  */
@@ -459,21 +474,6 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
-/*
- * sys/uuid.h
- */
-#define TARGET_UUID_NODE_LEN    6
-
-struct target_uuid {
-    uint32_t    time_low;
-    uint16_t    time_mid;
-    uint16_t    time_hi_and_version;
-    uint8_t     clock_seq_hi_and_reserved;
-    uint8_t     clock_seq_low;
-    uint8_t     node[TARGET_UUID_NODE_LEN];
-};
-
-
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.55.0


