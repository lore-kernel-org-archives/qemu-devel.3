Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F5EF99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxU-00053a-2v; Thu, 23 Apr 2026 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxK-0004TA-M9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxI-00041g-Pk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso53881195e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938803; x=1777543603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=423taZb2slU2rqQZ3HO41Tr2eRROaCQqgxy5ElE6ZDw=;
 b=PZX7b5WaXkUe+v9qPgcWknqT2wzgs3/9DXgSS+rMgQbVyLL8uhXD7HqgR7tkTGIzfK
 rHcwsC4H90tG6YieAkrjuQRnS19ddOKR0uq2XrJAxkcsdZRJp0qF8sVg1PqcLExCw88T
 fCe7wADFY64cNxBoXzpe+YBCVyrQK22vcsAE+ASWGMlQiOzxycRTW8l7zD6oRoYGujvO
 ag62DnGlmdrH0Fx5tm5XC0BvFPBHNmTvMlqnL6i3g8tYtd5D7zSoQ1sSXpFS8wkaHhh6
 sV+gSQzfdatmANw9HkH498qzqEZUpOkgxzAOA471BxsjJK6bWjgVLl7+foc0tUqYJZGb
 61PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938803; x=1777543603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=423taZb2slU2rqQZ3HO41Tr2eRROaCQqgxy5ElE6ZDw=;
 b=S/vydJl1BackaTn/MnUAsCV+1WubmegGlmqKEwiyo8Bhn3oML/USS4cg2+GbDgiqlc
 KsKGcyZpY1AEQBWKbVFDxphkigQjOS2qApMNwtPlfZDh9bo3XQd9hiVy/FTnELRy9CcU
 vmkRDpHsa5FIR6nMBK5UHLi9TS3FgYdvNu8tvfbP7D5R1tHneJ1TAhptbn7QoZJsTf9w
 Z6aA64PoiH7juKnIhk1N2WsyZkYPyLWKW3T9MDwc9Q05Xu0l0ypY/4fR2J258bCw4PSr
 7Wgv/FLiEntTdZ3cpUOJCMf5aDsGxkB3MyRNlj35NxQL8JQ4weJGo+9j2tLt5PMcPmRb
 v3LQ==
X-Gm-Message-State: AOJu0YwNGOp3udcYRSujIx7obiOiLieQb+scwmbP14Vh1lJU/Tp4fQXp
 W5cjHkdRkS+VBqcm1zy/YEC9F8JzYJk1Ut9OR0d7JmtceVTMUZ3l3oBCDgu3+7hqz6s/4YFCI6w
 7kV/eCZg=
X-Gm-Gg: AeBDiev03nt/q+gKbbQFM1dn+AdsFERQVcqF2pTwisKFZq1ePApYuZEQn0CSW21SoFr
 D7YQcK5gFb2VwJhusK+C6JcpHc9/lmavEo1YnQ2FY9vrMo60aIylNJltDWE32GJuFV4Z/OVwFOv
 J2A7Qv3j5BIrEjut1UDneyiqihSiWSXyGkUdBzMH6uRCR9yiq/gmoewpkrKxZPv/GOhmoQXbRn2
 RclIFwp9pieS4kx8Oe7o234BVnKv61D5TnVJkf3JvssbYaMBhVG9pt1XDyzD4TQkRPxNtp4EyUp
 mb1QuEkS3MFivySqs4h72+rrMDxgvYnXocvH1liGE0O3z8V8RnaA7qpE9v0KmscMYDvj3I2xplc
 xCHwL5YBxdmaFgShgih3iNsGY41PI0k2PYoaNljrrS+jPuRLmQfYlVfkzkkheHxW/8DWGp3Lr0X
 GPFcsRiJuL6KqqOL1RyiK2KZdLTnsnlzRdljy8qihAI2xjwyso0T7QtYIhqbCoJG1oTaky2WG1s
 KAcZZSQUxc=
X-Received: by 2002:a05:600c:3006:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-488fb739f86mr206092375e9.2.1776938802657; 
 Thu, 23 Apr 2026 03:06:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489201cde98sm268827045e9.7.2026.04.23.03.06.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:06:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] target/microblaze: Introduce common system/user meson
 source set
Date: Thu, 23 Apr 2026 12:06:07 +0200
Message-ID: <20260423100612.27278-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Introduce a source set common to system / user.
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index b86b37d9238..7f7d27d4efa 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -1,5 +1,10 @@
 gen = decodetree.process('insns.decode')
 
+microblaze_common_ss = ss.source_set()
+microblaze_common_ss.add(files(
+  'gdbstub.c',
+))
+
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
@@ -10,10 +15,10 @@ microblaze_ss.add(files(
 ))
 
 microblaze_user_ss = ss.source_set()
-microblaze_user_ss.add(files('gdbstub.c'))
+microblaze_user_ss.add_all(microblaze_common_ss)
 
 microblaze_common_system_ss = ss.source_set()
-microblaze_common_system_ss.add(files('gdbstub.c'))
+microblaze_common_system_ss.add_all(microblaze_common_ss)
 
 microblaze_system_ss = ss.source_set()
 microblaze_system_ss.add(files(
-- 
2.53.0


