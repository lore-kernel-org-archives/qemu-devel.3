Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E1C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3l-00082C-RX; Mon, 10 Feb 2025 10:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2q-0007Ex-1X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:50:01 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2n-0004iX-Tr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso11749205e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202596; x=1739807396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ach7bnbaT/M/a9OUubHchNVXpLnBww1JCB9bAXJ6NA4=;
 b=phrMCiuc8RYsAjsa2q7ds8dsMLc/bvHG0RqlYFbLXz6TfIk4o95sUIeo1E9bYlWgPJ
 kdoxxTboMAxqFkK+t55KvNTwzkfmKT/1aW52G8ygS5ASL7K8R+zRkr4bT4uYsiT8osDa
 3DIkzb8F1ac+48x7wKBX3vGizm/vhWVaFi46fj9mH75NSWjkyaDs+eYYjENUS6EUA8CX
 uI/XFrO59EF12uCnIf1EjjEJ61dfVqfyk70waQzh1WKeN5CoqLUMCoJ/Yw7shWF+pLs7
 jo4SL49dXFQ8XMfSnBn3GBV4GlfSdSN6eV8ryU5biv0EKvme3Ni2aVVfuql2nDuki9GD
 B/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202596; x=1739807396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ach7bnbaT/M/a9OUubHchNVXpLnBww1JCB9bAXJ6NA4=;
 b=KawwfRDAKBNhZiHYtShdYgkaWVknDJiFlFXkGUX8/WL33PXfqLTLOxKmHZRqIUpAwv
 arE8A4h+oTZPMBXpw+hgka/cAhcrub1p/C1AGrD4hPSwUrAkhje9ZIW7P/yt/R2MSwVM
 EJE7FXrmIK15O/JGtzSzeXGr4dXSGkm0YYx+T/zIW+rYNXUSw8npCWlNyYpNnGFY+fuD
 U44rQ5Ci2rhHn75w/9I/E0kJ2MbwGiouGfpL4v7Gm+OvAFa+DQVfhof/H/DxmLThUQgC
 oOZmkTs/ShZIbfO0aic1RQHdzoLEe++COUMvV4+v2uexx8Cds/cKFKijWvOwLYUk0Tok
 xyRw==
X-Gm-Message-State: AOJu0YxdXozUdDz3Wilp1CrzJsbUvjIF2Rx3Vjxi9ZQjeB9Fqt+9CJL/
 MmocLZIRsx+5TgERevkdNj5fRxqOFY6EcRAAy4PJqnmlX+knMJBOz9MqtXgvQJE+8SRS9vY8iFM
 k
X-Gm-Gg: ASbGnctQ1ZE2maOwd4d3dUwcSPAi5dlx7JsoYihHxu6a/oJndMb5NWjRpxcrZreFJu6
 kE6oaGXhYi43x/Y8+Y/uaYicbYcLs5k43uKR1u3WHKtx2Oje1s5QAdBaBaDv2GEeYkk0iw28514
 U0Bld6yTFkj58tKSnGu2Q2+kvhxbG8K+ACmB5YHxjoh7TGI+bQsLqh94WBY3Muh2yDEa9jLSR2G
 9BlWW8SwKvyj7ozaSxqEr6gWkKcSR2yWzb/kKnN4e6hxSVYVxTaHoRt9B+sYNj7shUO6mK6vHA7
 VqxpOXNblqLgLxHd9Ozl
X-Google-Smtp-Source: AGHT+IFoe3+CxYVZ3JWf9BaCNW341TLW+JBqwXnDt62weu737nTif8sq5dh/WAPUO38MheV24JADww==
X-Received: by 2002:a7b:c342:0:b0:42c:baf1:4c7 with SMTP id
 5b1f17b1804b1-43912d150bbmr136614685e9.4.1739202596379; 
 Mon, 10 Feb 2025 07:49:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] qemu-options: Deprecate -old-param command line option
Date: Mon, 10 Feb 2025 15:49:41 +0000
Message-Id: <20250210154942.3634878-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The '-old-param' command line option is specific to Arm targets; it
is very briefly documented as "old param mode".  What this option
actually does is change the behaviour when directly booting a guest
kernel, so that command line arguments are passed to the kernel using
the extremely old "param_struct" ABI, rather than the newer ATAGS or
even newer DTB mechanisms.

This support was added back in 2007 to support an old vendor kernel
on the akita/terrier board types:
 https://mail.gnu.org/archive/html/qemu-devel/2007-07/msg00344.html
Even then, it was an out-of-date mechanism from the kernel's
point of view -- the kernel has had a comment since 2001 marking
it as deprecated. As of mid-2024, the kernel only retained
param_struct support for the RiscPC and Footbridge platforms:
 https://lore.kernel.org/linux-arm-kernel/2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@app.fastmail.com/

None of the board types QEMU supports need param_struct support;
mark this option as deprecated.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20250127123113.2947620-1-peter.maydell@linaro.org
---
 docs/about/deprecated.rst | 13 +++++++++++++
 system/vl.c               |  1 +
 2 files changed, 14 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 29de49351d1..a4c7d642236 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -68,6 +68,19 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
+``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``-old-param`` command line option is specific to Arm targets:
+it is used when directly booting a guest kernel to pass it the
+command line and other information via the old ``param_struct`` ABI,
+rather than the newer ATAGS or DTB mechanisms. This option was only
+ever needed to support ancient kernels on some old board types
+like the ``akita`` or ``terrier``; it has been deprecated in the
+kernel since 2001. None of the board types QEMU supports need
+``param_struct`` support, so this option has been deprecated and will
+be removed in a future QEMU version.
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/system/vl.c b/system/vl.c
index db8e604ebab..aa91047c480 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3469,6 +3469,7 @@ void qemu_init(int argc, char **argv)
                 nb_prom_envs++;
                 break;
             case QEMU_OPTION_old_param:
+                warn_report("-old-param is deprecated");
                 old_param = 1;
                 break;
             case QEMU_OPTION_rtc:
-- 
2.34.1


