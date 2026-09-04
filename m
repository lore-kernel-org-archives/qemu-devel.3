Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1B3C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQK-0001gn-DN; Fri, 04 Sep 2026 08:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQI-0001fn-Tp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQF-0000hn-R5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so653457f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526414; x=1789131214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XUkDyBtHnyENMgpO/P1nSAPBdpBC7ODMYbtYEBkq9vM=;
 b=Hc2Nv1Ca7azc52qOhO+qBia+tFOEzXdoklbPz2GB4BcoprCASJl8Q0ilyclxtVj8R6
 mKeaj8kgJAwzHHUDe2ch/wC5HJi8l3nwwmMEyCK+dnvmPmATAe9Z8uSKwEnAx/7c3I1K
 BXPbG3eBg7QAx+mpNcZUKAuk918+9nmSfGtfU4aqu6XwXv4c+KqV1xmVSHbdG9Xan31Y
 fNdqWO3MqOk7oqSODhYMFPzYbflJGu8lCqpPRnColo1hvu7ChMUC04uY8oP+hs/Ea+6u
 4Qdeda/r2ebT0XV5fxYawP2rzUBXxWXcWWaIoSb70lrOm1P+kqoV+ieic7LtD1S9S/Q8
 ARzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526414; x=1789131214;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUkDyBtHnyENMgpO/P1nSAPBdpBC7ODMYbtYEBkq9vM=;
 b=JjQT6n3op9mPbAHeypyvH1efYIruIiNpJiqwkYAJx/2RxCVmD5cw/j2XAxyfgDVopF
 W4Qbbmdc4QL+3lH6Eiq0HhNZ9lD6zcB29z4V15DQFuTxFdNwMIEAJ6UnEvTgfYMSTn7z
 PjEMWUxIZA58zSG4kJhCj7dsBwOfSgoCGoUIWnAfCHVUKQGRh/WiVtuP0GOh8x1AS6uo
 OmRYUVWQT/17O6rPyPLa2rGMcNmX7gOWPbHVXLuA63RKfYA8/MzVZsK3E5MB0Tl5rLuK
 bimtcMc5tTgA5SbgV7vBL+raQxAIzaOYR/TgFPZr/q52G1QrX4J2aRxU6r3O7qNCS7Te
 ZgRA==
X-Gm-Message-State: AFuF++lHzv7jWoi2XnWAVhLQ9tZ1ewOY4FIP5OlL+ZlulkDCBm6Fuu7S
 aoMFt4KXTtB9kmADAsViP7aBE1BohAQgxFDEM0zfc29wKm9qJA198Yy9buyizLvOyxQ=
X-Gm-Gg: AYBFou0d8xK6Vme7csu3okXwc5WFPHV+cjGWNHBJEJD9blQaaNpuNhzH/QfYebcK8IR
 0++Xr3w8KYqFZuY49xYvFN116IBO3YgRTjeWMWpHpsVEIYdL2rZ1bqTMLV376QQO4+jf4XqBnjW
 koI86q6DSrOBQ+LeEKuCDGcDdJzvDEHMHE7mKBPoUzfb6cHwBN8aXspn6ce2pJOZiWpHf7UlazM
 y4nYqTk2VRg8/S81ttzS9VyUyf/kWv8wRmDdonGNRTdtxqM9EPdbkSFYu5DkWKuCKcUFSTuFx0E
 DHBz6o6GoJPD6kXmjmzxkLwBVLWnQHfWTmzFJJ5DHxbQr4yEAX7ApeLBCHFgQGDv+CSnyay5jSl
 peMak7bMyIKkzH3/8K8BSyvRQ2raFX6PZ7ttkKgBBnuA151nBIqO14pn31ZEd/e5cuUrj4wyZlb
 5Zc/LK/WydALb4Ew5kjue2i2Tbf25q6h7e0J/pSvZv4tZLeM8K6jLKiJEjMSVB
X-Received: by 2002:a05:6000:712:b0:485:7ca5:b870 with SMTP id
 ffacd0b85a97d-4858707f19cmr7969482f8f.4.1788526414301; 
 Fri, 04 Sep 2026 05:53:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858bcefd59sm3457453f8f.19.2026.09.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 771F76199F;
 Fri, 04 Sep 2026 13:46:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 051/105] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Date: Fri,  4 Sep 2026 13:45:05 +0100
Message-ID: <20260904124604.2207440-52-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Due to missing endian.h header, BYTE_ORDER, LITTLE_ENDIAN and BIG_ENDIAN
were undefined. Thus, for following code, the first branch was always
taken:
 #if BYTE_ORDER == LITTLE_ENDIAN
 #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
     |(rol(block->l[i],8)&0x00FF00FF))
 #elif BYTE_ORDER == BIG_ENDIAN
 ...

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-52-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
index 0081bd76577..0fcbc3ed605 100644
--- a/tests/tcg/multiarch/sha1.c
+++ b/tests/tcg/multiarch/sha1.c
@@ -21,6 +21,7 @@ A million repetitions of "a"
 
 #define SHA1HANDSOFF
 
+#include <endian.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdint.h>
-- 
2.47.3


