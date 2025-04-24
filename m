Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B5CC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmo-0005FK-75; Wed, 23 Apr 2025 20:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmm-0005Ei-R3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kml-0004L2-5a
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso385177b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455789; x=1746060589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQDWD7G5b/boKxwucW1CWyw2g1Xfmx+JyPZ32ubzOao=;
 b=yckCBl+2vACm86P/7yeGTwvO+ROCsfpNpaC0DvlS/u1yY1Yk1X3ZYeK0Y8NAoWHp4Z
 xh02YrlIIRxrRfOt0Eloq80B7E2o2SpLfUuJ9SE9lBF7AvosqR4eY69u+ROkAbeS/Czt
 ZwLoQTKBS+/KRq0AZFBb6lgQvmiITWsOgY0trTtkvedcSp3lGga4g+eYOh3EJCnrG2df
 Gd5McA0jWrhDHs6Rmpo5g4j7HvOnUSUnB0zI2/61tKL84Lp1pXkZvKWpzNCUbk5Oj9AD
 4IHPyV0PkCWI777ftepFCkq7qm03NdYQFg1wGeAER43lcc1qiOSrT7wNDZQKE58TWf0n
 4EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455789; x=1746060589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQDWD7G5b/boKxwucW1CWyw2g1Xfmx+JyPZ32ubzOao=;
 b=GZ52bmIDs4D1eJ++A1W5ZQx1+AGy+RVEP/n0Ykv4jiYZnEpxc4iXXVqeCXxs/Nfysl
 0fqjLvWXWiAOPVyehtIq84c6fqmTNVaGHPv8KqIa3u93Lv4b8kd0dubYQgiw0Ei/EXGO
 hZPdnLGA5/I6nd6QaUMRxxted2Hh4NZtanBuO1JMyvjv5Ddgkc4CwJh9oEZNkQABIoSZ
 YTHQTgsub2DdTo/UD0E7u2/An9Y0Eqs4/Yu6A7iTuMwNKvn10KTK7PisrlvqZ/CbI9sZ
 FmNwkaRlyGJXaHD9Y4yLy3YAuPMdqPYysVii1RTmAamole3Us+UXeUpHpPW1Dx6LVu3e
 Bu0g==
X-Gm-Message-State: AOJu0YzjwQnYOyaziGGthMGVG+cYgntdhuFIeAbCao7+M90/O8aj/H2a
 yB2K2G75Km6y0gYluGgPte0c9WE6oNwauXn+h56BXgvvFDckFlaPzPLKqrsM0He/mPAGDMPz+oJ
 r
X-Gm-Gg: ASbGncvjeNuexZmbnQivlJcTHzib0CAD8P/icP93qJowuW9DghONiVOXb4WJ1TYwLrK
 0d32/5/WpVumyRbj6pGl/s+8wcPZb+Od2Dx0AwSM0QZcQdp9ZTNZyWlO+GOdUGN59Zba17Cw6uM
 39SulB87Gsd2C/Fh8gTiyhkNZdDkUJL4ihveLI12jmTzr7XW+lr+PKo4sDWtMUT6Oebc7qKL4Jo
 LuhupwE+lklchTPOIMOYi6K5lmGQYCuTgMKdRGUGqQ8msSFdIQKO/xvJ8udICe9g4n9+/8hfSEV
 zmLkCRJtLoADPNb2u7z8ZatwmCsBgn0c3sDaFxHQSA27IGz0NLFqnEF9QQvqt8NDvcBfniQRsRg
 kpuvQ0UarRw==
X-Google-Smtp-Source: AGHT+IGpRM1YVKog9/4kWI3+rQ1c55m+Dnn4f3JdNeolMVmRhGUDkUq6vbjr+ofr6qkX9Cp7RJYENw==
X-Received: by 2002:a05:6a00:a909:b0:73e:96f:d4c1 with SMTP id
 d2e1a72fcca58-73e246400d0mr938242b3a.13.1745455789537; 
 Wed, 23 Apr 2025 17:49:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 018/148] system/ioport: make compilation unit common
Date: Wed, 23 Apr 2025 17:47:23 -0700
Message-ID: <20250424004934.598783-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-19-pierrick.bouvier@linaro.org>
---
 system/ioport.c    | 1 -
 system/meson.build | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 55c2a75239..89daae9d60 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -26,7 +26,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
diff --git a/system/meson.build b/system/meson.build
index 4f44b78df3..063301c3ad 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
-  'ioport.c',
   'globals-target.c',
 )])
 
@@ -13,6 +12,7 @@ system_ss.add(files(
   'dirtylimit.c',
   'dma-helpers.c',
   'globals.c',
+  'ioport.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
-- 
2.43.0


