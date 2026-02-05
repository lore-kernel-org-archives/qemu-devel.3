Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7EAECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38A-0004R3-7J; Thu, 05 Feb 2026 12:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37w-0004OD-GQ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:49 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37v-0001O0-1g
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:48 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-409521ba360so814632fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312404; x=1770917204;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xchTvRXDopeFhHTzzGAKlb2fx4OMmGzGafglYF0U11M=;
 b=f9O1Qr4XImQR9sFMJzEJmEPRr4tGj9Dh6jdcYAC+la36lDwa7MimP5jrcGe+l9e5dO
 1P0HPhy2oG39a6LIINVHY8Br2yIto+q0IVkdFpU8EV2KkwkL8klZaV998x4IxP/9Cuec
 5xE5JPWzinQKAAQH9biMv42zFyq4+eNqIW/PmyG/SLZpuYNarYy7ZrnYAsu2lEktKmgQ
 KxascgVCBa266TMAeXaYZX4fn4clxL0NlKCjxvathrIqQZPGKe+10M+zUHFlwwEFWP1K
 xDKObRZkRdulfknIQX/JWAnG6rhnzAxCmnXT7ogm5eWoXadQqTfG0/3QicT8cuSpxRw/
 6e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312404; x=1770917204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xchTvRXDopeFhHTzzGAKlb2fx4OMmGzGafglYF0U11M=;
 b=T2bj99MPebMp7Bv0gzaW1LkTpd8fAKcjITXmwQWZYMvSPLtuHD/UiWFQWusgbyBwOC
 45LKt5ztO0ivCbVr9E2SAZEMEQ/MCH/uA2Z7TgQfvvpluUjxTJV8XBaUliyOoSOoOHUK
 H/ksDn7VP+neSKiChxxK0IBl4m575WxQ2DWtYa5GUD60iwXHev04IdYWmcw0ssdbLkAM
 6g6Tr5BGx6D2dhVSx9XCUbH8/QlvNU3vs8gqUcjwPI+6fisNCUfesm0yI4da5UU2G/+q
 TJAEo8ci0EAwsri4jarggqXHOPKlWE5Fusqg97jQMrgauDGvs3ChNaRCzyJ3p6F3xwfn
 7aiw==
X-Gm-Message-State: AOJu0YyefJsqn0afnK/KrmwCm/jo6dlQR0slBmEFVYg9vwh5C+5EI08w
 ktOZO7elTjKAzJMg4xyzyUIqwgCvJ5Vl5eU4Fcuus3daFHNjZYYraFWFDO2SAwgz+nQ=
X-Gm-Gg: AZuq6aKlXIS77QRkF56Lfayc9DqtLPKhHT7Wa5jZWdgbkrH4UHJjZYrU36DIClCd6F1
 IhmM0I1Q0CdcOgoFDk0RVzKY40mXoySyLRF2neeGs40q12YSGJ3csq4DyZwKgt/jlusmM7sTGG+
 zJJv04lThejhin4bkPF54fqj42KIo/Tx/BTqLsFIpX7A72JGr63j0bkyHcGZATA5sa2btMlsCLO
 uRap1EG1P98mbtjj330jeoY5BV/XiqbuV+wOJc7vSefcpItBtValU4POBfqmCfkU2nPvwePooEi
 YzAWd/G5DMo1EpMpdCaJa/Bof6BO9XH6gwSt1z2JmVzpkFKvDWxA3rQoY+TpUXzrYfpeNJzkLcL
 DzV11hLy4GmT5hP7+2LMvtmkI7HG9PMaqVa+bN2GDdfOkvxnSdSIchDSMhCC4GEz0Cox8XLjUMA
 ==
X-Received: by 2002:a05:6870:1496:b0:3e8:9bbb:36b7 with SMTP id
 586e51a60fabf-40a96c9af03mr17378fac.22.1770312404137; 
 Thu, 05 Feb 2026 09:26:44 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:43 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:37 -0700
Subject: [PATCH 04/24] bsd-user: Add target_uuid structure for uuidgen syscall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-4-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xOfrPG+2HTEm06LBNkR6fD7Pm/EfGz9LUDjXCsBlwzA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLa9aCEc4BOGamZxxNmhfM2XK7N93SkilwGd
 gcKZo/NwLSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 AEyPD/4+VYKS/+yXA0faZJ0Z39EBEy2wFey6qwKdfd+56SDKV9w9JtudrEeUEbqVzPkaCmxvuVe
 DHBYcQu9/ryMj03nGgtRrHU0Dt5/ywJ1nia79gUlAcWehgEMhUPwAABLx8yAi9NLQqusVJKFUMy
 pt+ACcIKHihLNIS2WepUdDrVDZwapz05Ijdk3UOSdw284DAnRIHBYL0xvtPHV4ZCzdqOiC1jfJF
 ER8a97yEEhyfq1x5I7tzKbbu9m+fGx7PqTcB4bsM7ukxOGZWiGWdsjrN1AQWRMOK8iTYlzTh+yU
 C2X7PhS44aL6Po/TOLXxRRGkKsz16zTv1ByHOC/cOLEtiX9qb68A9WFv5X510kWz4MiF7TpXgc7
 iJZW+UD21kQ48+F6FUHqTYeDVi4Mu0VslybEJTOgxXde/awljqpkI1AqW14oKqrp5P7XczONJPw
 peizzEhQvPmwGLkT68q38yXrqIi83ljSTFU3cFUT/1ZNrbglovoE+nt02grDinynj9jKZlll5lo
 h1ZCf5vNP/FwFW0oOdMKKztgMXXtc5VO4HayaO+/o+G9tS6Uq5wwTeE6mA4N3DVPE/XggGJbVYd
 XaZDvM5FkkVhvOsaUy13wCpT9i2QKDa+pl90ROonrqgx6/QXs1UUHStS072TRjKKHA6y7td9Dgg
 WBg0MaJQ8ddO8dA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2c.google.com
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

Add the target ABI definition for struct uuid, needed for uuidgen(2)
syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 98bdf8cc1a..62b9bc752b 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -503,6 +503,20 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
+/*
+ * sys/uuid.h
+ */
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
 
 #define safe_syscall0(type, name) \
 type safe_##name(void) \

-- 
2.52.0


