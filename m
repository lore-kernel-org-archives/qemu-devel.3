Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E4DD46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtG-00007h-Gz; Wed, 28 Jan 2026 20:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt4-0008S6-WE
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:00 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt2-00038p-MY
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:58 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34ccbf37205so171385a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650314; x=1770255114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEmhWV50Bdw75mIkmSTg87b5KWsClkrsHwxNSDCjPXY=;
 b=x6kWX55Tk5S5yd+GoY4i9fPB1r0ooi8yWiLF2ojSYHKOk7nwLbjyrIVncqvp7j8td6
 4v+ag5/Zzh1LH+XM5BvXj9T1bdCM+ociyDIE2ouFw2mGg+kkG+3VX3EELlAGlN2dtdON
 gwZFDFCfOgvJMtkSLlcLQAEQSnjHENsxfTUVvRWk6ZadigeAevCxdzAAV8wizZtzhmQn
 1a2g4SNSTNheTZevUlOJR908fs/IgIQUj8UoemUFAUHs5bHPx4Ewhl6m8Q3XsPEtS3yD
 Q/gXQrGOUdTVY3fK0TcNddW1iRZYjXyC/Rrj4fbdo4hws3Nu+M7Z4YERdc2SpS4ol7+r
 PX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650314; x=1770255114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEmhWV50Bdw75mIkmSTg87b5KWsClkrsHwxNSDCjPXY=;
 b=UFA6rpPEPB1FYBBXq0P8nrPmSuUMzmdg43N7r5fI0fX9I326iHh9gDtD9fOgeEsNHC
 nEvBTPrWAniObPWsWkB+biOSzdjcq3A3GWICkvB0PYzenZkAplDp6dWDYNa1SczuFa4q
 CGxee9a4TPcmi5/741droD6j/Ab8gbwCOPpABvmZRX2cdsvEDjzu0BFus0OExZFsi9jE
 sSymJ64howxEwCG2mHyP94C2Bs4H2ng0iBLUKEXZVo4atGRfFl/iENvRNZ4AmviGnSbe
 sS0FxaHJHqYDQghUexeS/kiPYejW3HdesMQsrVgLswwbTvIrVLlObhUCIv1hpGmpotAQ
 NEdg==
X-Gm-Message-State: AOJu0YwBTPNudYLfCGtropTXWrGX8iHCd5rgXkCldSJjwlERIW6CB0vB
 nzw5/UPHV/rREkbISgJToqSBulM1BpZDso0Px/gsf4A6JwnXrtWRdTNiYbGywX/3PUQIV4+T++U
 atMbF
X-Gm-Gg: AZuq6aKyfyW5VSRlgwmyyA726wlyyWLMZ3ZLxpu7Gh1FfYAytyB9BBVl2JUQXxgpi5U
 HUidYSg1SzHuy2dEFWNqo9X9j8UfBmvOMyq1sn56gFj+1DBlsjaU4C+BNJ5Z4wD1Jp3V5lgBTcZ
 EaT1eiaKOrxjBBrXHmqFIkbtSM46NNkrOwEPiVwHG5X0gc2FSpuAqcg2GmVa4Z68fZEZcmxdN2Q
 r+dqG467irGFg3HT+oNSFkCGxliszxUnWhDiOFHi4VZFUpTzkPu4bLZm99vs+GTLdebCocipbBx
 yhbkuv6/shsayvevGsJ+acuOw1wbRWvvJtEhcaI1I7CVJ14hu2wQxb4g7SGR8UDWIV8T1a4x/HO
 lb5ytYE6E2jeSxD14OkQf8iNoOU4GUf3v/nb26ruZ8yypP0zsGNKN4ngq1Ex4VoBwxyNNnuDSek
 wdypLSdOViAnEakSXu6WRgH+fCsyMv4D5XKg/yQLryEl2XSxDdVKfi++g861lUsyen
X-Received: by 2002:a17:90b:3b8a:b0:34f:454f:69a9 with SMTP id
 98e67ed59e1d1-353fed87a9dmr5518654a91.28.1769650314407; 
 Wed, 28 Jan 2026 17:31:54 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:53 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 11/20] plugins: use complete filename for defining plugins
 sources
Date: Wed, 28 Jan 2026 17:31:25 -0800
Message-ID: <20260129013134.3956938-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/meson.build   | 10 +++++-----
 tests/tcg/plugins/meson.build |  7 +++++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6915ffa5fbc..3d2d7862e0c 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,15 +1,15 @@
-contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
-                   'traps', 'uftrace']
+contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
+                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
+                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
 if host_os != 'windows'
   # lockstep uses socket.h
-  contrib_plugins += 'lockstep'
+  contrib_plugins += 'lockstep.c'
 endif
 
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    t += shared_module(i, files(i + '.c'),
+    t += shared_module(fs.stem(i), files(i),
                        dependencies: plugins_deps)
   endforeach
 endif
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7823704616..303f97f9679 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,7 +1,10 @@
+test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
+                'reset.c', 'syscall.c', 'patch.c']
+
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    t += shared_module(i, files(i + '.c'),
+  foreach i : test_plugins
+    t += shared_module(fs.stem(i), files(i),
                        dependencies: plugins_deps)
   endforeach
 endif
-- 
2.47.3


