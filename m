Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC13BFD88C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05Gc-0002le-4N; Tue, 10 Mar 2026 18:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05Ga-0002l9-Il
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:09:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05GY-00025L-Sn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:09:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so5202924f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180564; x=1773785364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=US85J4JR3GJNPZ3oJTe2cSnkCs6VXwsD3WsU8xuipE8=;
 b=yVpj+Tm7RZcQW3qFgeVJxT++0upMn/rV/KR0FBrcGgGj9pHtu34E3/DZC+AJhYnLk5
 4n92vh1dyJgenGtTr4x68btYeDrapJSM6KzEdVX7bWDh9aPtgQ5DhHK/j5ed/yRhoIGc
 8i54MbNhm9tZduqTw1Ahf3UanYfpJofaJabdPDfLeYPCncyKOnM6jevT9xTtuGdsbF47
 EDBZS9vL7YieJtORsJKl2lVRpZkkl5QDQHctMOSToXEnLf8r86AAtnZe+KZbX7jn+nRm
 qOIKP8IHvdOskfteWk3Jpj/0ZmqpIUXrZj/kJBAnP3+nSy40dmmGO0PPt5EluiPhVKDV
 KIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180564; x=1773785364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=US85J4JR3GJNPZ3oJTe2cSnkCs6VXwsD3WsU8xuipE8=;
 b=pMQsqQJ+lDNciVOgB/gjqqTPdgjfiCHvaVgBBS/E8Cg76jl2lGi+mBIWRAmoFaJe3d
 UyozeWq9+1kHHDAA1+K04Oj7YfdbfmHxZJYEI+E7SDTdegrg8W/SnvzscbMlQbpHbIKc
 ba0XfDkAjZJLfHLu7poBw6zHwa4m9rijwGEbN6L/PtcU8H8NF+wtXlPFJiPIqOfcTtrx
 7G2aZMUVxb7alfGfxt3UNB8UpwbG3i4Xjz52pG40nSiJh2nL2BUBtVXQ7U7+encpFCSb
 d3ytkSg/ez894ir+xGTYOs/PzTPBGaDXHC0tA5vxhT/XWNmHjcWjlawFE7LojwrsKY/5
 2Yvw==
X-Gm-Message-State: AOJu0Yz11z0kQVmSj81W13v2U2AYQtSrzhqmX7noBxmuV59+GzzYYDTP
 DBXdUHFr6m5mjdLi61PNoodoYsD6iawzhT+s/Yr3DDxW8swcTSz7advSNiCjUE/SlZ0TRPD5pMt
 /KTQgiGs=
X-Gm-Gg: ATEYQzzNb0MLc4fTOGB7zMmPC5e8vAZ1fFMXDCojCKigL0svW/EA8A+xj3U067Expwg
 GNQsrXS75Mw9Z3kzMl/yCAZhUXsetW2StapBvsnNLjbdE3C6XzK18JXBqUQ+OMSjERnb7AmbXaJ
 9VMl53aund7X+2EO2c/RdXW6OI1pqr08pqn8cjB5mALLUuebCH2JGtSShjo/gWdOjNKBwguqm63
 Udbt3u20AOZmyuCVOzqaA7JCTvhmNGaFglUqAGgs7UEBT5W1eweD/f6O8/NBvYFm3kQn1vI3Qs+
 1CNzeD2luNpISsN69mUKHqNPFWNfYUMQ7bKabmjBNVG4PcCCegZAKR1nRmswDvCAcSSza0QtInm
 33qJGFBKI/FWiRtl4jgUtZ9Z59UBp+tQa4AekfJg8NC1n2VIqSlgsCOpoyHRzEjuYKGSf3yzYL0
 fGqtuqMBITwN7hq/bm84pa54YFmxHwWdN8i4Ne2c4+29emJ8uf2td3nywWIw7b4s6QucPqiKzs
X-Received: by 2002:a05:6000:3112:b0:439:bce5:6508 with SMTP id
 ffacd0b85a97d-439f81fc613mr885186f8f.14.1773180564480; 
 Tue, 10 Mar 2026 15:09:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81f1318sm1233248f8f.21.2026.03.10.15.09.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:09:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 05/12] gdbstub: Have scripts/feature_to_c.py generate more
 verbose output
Date: Tue, 10 Mar 2026 22:59:08 +0100
Message-ID: <20260310215916.55815-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Make the structure field names explicit, so it is easier
to figure what is what when reviewing multiple entries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/feature_to_c.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 3aa62fb895f..1329695ad04 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -85,13 +85,16 @@ def writeliteral(indent, bytes):
     num_regs = max(regnums) - base_reg + 1 if len(regnums) else 0
 
     sys.stdout.write('    {\n')
-    writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
+    sys.stdout.write('        .xmlname = ')
+    writeliteral(0, bytes(os.path.basename(input), 'utf-8'))
     sys.stdout.write(',\n')
-    writeliteral(8, read)
+    sys.stdout.write('        .xml = \n')
+    writeliteral(12, read)
     sys.stdout.write(',\n')
-    writeliteral(8, bytes(feature_name, 'utf-8'))
+    sys.stdout.write('        .name = ')
+    writeliteral(0, bytes(feature_name, 'utf-8'))
     sys.stdout.write(',\n')
-    sys.stdout.write(f'        (const char * const [{num_regs}]) {{\n')
+    sys.stdout.write(f'        .regs = (const char * const [{num_regs}]) {{\n')
 
     for index, regname in enumerate(regnames):
         sys.stdout.write(f'            [{regnums[index] - base_reg}] =\n')
@@ -99,7 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
-    sys.stdout.write(f'        {num_regs},\n')
+    sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
 sys.stdout.write('    { NULL }\n};\n')
-- 
2.53.0


