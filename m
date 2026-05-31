Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A4CD6E5D
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 15:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTiB3-0001TC-NJ; Sun, 31 May 2026 11:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1wTiB2-0001Sj-C6
 for qemu-devel@nongnu.org; Sun, 31 May 2026 11:34:12 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1wTiB0-00066L-QC
 for qemu-devel@nongnu.org; Sun, 31 May 2026 11:34:12 -0400
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-36dac5d5d05so97789a91.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780241649; x=1780846449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vLoZ31hwfq44UN2n4LvdkzlXAdAKJFZLv48jde8pkZ0=;
 b=FpHm1bIXuBYXR3BYRNgO5+7jicPUWPLp1fKa69dCg6w4d+vtgzuZhcpmPK6LeCew3w
 6hSQFnQ1lHxPtlc0eWxKS1JQpNCoruZa39Cfoei25rvq8V86qhzxCk1oIXhrm+/I7nO0
 iRNM+XNLFkZqUVTeKlIFponI3Y1I2RH0XkzjrWOO1BVsebZ553KR8SbRNxUaOTGj29Ls
 vxi9JAibVgstQ71Ga2WH+JFgkNi5adp/3qW2pGQP7E3QmjtaqPAvkTfjU4uoeT7vpyd3
 Hgx22/RsamNR25P/Gjuj/3qDy9dRGmT3q2Y94nQeDOGxn7pBdUNmYLMWLYyjiTVDFVex
 UeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780241649; x=1780846449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLoZ31hwfq44UN2n4LvdkzlXAdAKJFZLv48jde8pkZ0=;
 b=F0qsQQHbskg6TyvA6kcQ07W9UCa51NZHwaS+I20TWrFIo71FhAlHtFgLRpKI23q9Ga
 MCAFx1EhkgDwDuRt8lxtoVD13EHmA708oYxJ4mTidKCcp48f1o5zrgx+MCuhIRXQAbyu
 jmtIBniMTAmOZfBUDIy71QZHiwNUXAr506TDnyhSUtrF9MZgPpkN36cxJHMc/92u4ePU
 8QlR0HTdwOKruh6kswHK4M9NWrdx3VAcHpqFqG8MLsx83iJdhSV0xnlifZ7VfRLnpkdS
 I4TSwVcpXOWY4ibHBxhpVWlT6230+ON7eEwZFvTF678cAx1uHW7vmIx3B2IF0Tm8J2G/
 2I1Q==
X-Gm-Message-State: AOJu0Yx8rLk9Ju56ueV0HuQgeuSESx14uziuFHlNzZ5hvbc1Q3bTpvSR
 Qkp2HtkeB0dHK2PqAwcky+XedbK1xhiJPe2LeDjY1e6VFfNyhwzwt+4VBrM/W59qfIo=
X-Gm-Gg: Acq92OEzAo3wmpFCCGzWIHCDzJBrBqicbfHEULg90zKgb+A2VzTdZgOwym+CjtQPiNG
 ROV/HNrA8Um3u5lSvNiIp0vpZKaLG1gVbhY+1SpBtxzP0hpL713N9VGcg+ym0ujRz+pZ/jqv41z
 5Y3hJa1LLkjyrwnMdd0whNJTf4nnCRQEYHap+OBKlXEO72WdwuYjb6OjOYAKmbF56wchXHCwjas
 QxEGSvtQ1u72+FHU4tV/wX4yttbe/Hbja/7DBX1ivIZePu+fzDeHjgfy4s5L4vJt2xQcMZHroiO
 M3puwXWmL/bTUCvcpQSFM3S4Zi71/5b9ZpmeGEJqO0yYM8pKCj0Y5P2uJQEqSNVcZxMGyD51Z4G
 CAenUigG+LZKHCxlyhMm0hslGClM3z/YYEWV+cZ/UXFOL0+X2o2UhspnifQByeibWCYevQseO/D
 PJe7ehE0J/8nwTOPK7wf4s8INsMTa3NGGwvNOiWFrK3l4zC64=
X-Received: by 2002:a17:90b:578c:b0:36b:aed6:235a with SMTP id
 98e67ed59e1d1-36c67facb44mr6949630a91.22.1780241648939; 
 Sun, 31 May 2026 08:34:08 -0700 (PDT)
Received: from fedora.. ([2405:201:3005:d874:1572:5c02:3b40:ecec])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bc0c391cbsm8348464a91.16.2026.05.31.08.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 08:34:08 -0700 (PDT)
From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>, luc@lmichel.fr,
 peter.maydell@linaro.org, hemanshu_dev@proton.me
Subject: [PATCH v2] hw/core/qdev-clock: Fix potential null pointer dereference
Date: Sun, 31 May 2026 21:03:55 +0530
Message-ID: <20260531153354.88909-2-hemanshu.khilari.foss@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=hemanshu.khilari.foss@gmail.com; helo=mail-pj1-x1043.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

qdev_get_clocklist() function returns a pointer to the NamedClockList
struct. This function is called in qdev_alias_clock() and the returned
pointer is immediately dereferenced without a null check.

Passing clock name that doesn't exist to qdev_get_clocklist() is a
programming error, and so this change is not fixing a bug, only making
the reporting of that programming error a bit more helpful and bringing
it in to line with qdev_get_clock_in() and qdev_get_clock_out().

Cc: luc@lmichel.fr
Cc: peter.maydell@linaro.org
Cc: hemanshu_dev@proton.me
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2342
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
---
 hw/core/qdev-clock.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 6e2967e433..861f78f94c 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -157,7 +157,14 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
                         DeviceState *alias_dev, const char *alias_name)
 {
     NamedClockList *ncl = qdev_get_clocklist(dev, name);
-    Clock *clk = ncl->clock;
+    Clock *clk;
+
+    if (!ncl) {
+        error_report("Can not find clock '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
+    clk = ncl->clock;
 
     ncl = qdev_init_clocklist(alias_dev, alias_name, true, ncl->output, clk);
 
-- 
2.42.0


