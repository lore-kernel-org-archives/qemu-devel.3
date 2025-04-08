Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B308C369A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E7U-0004fh-O0; Tue, 08 Apr 2025 14:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7S-0004f1-FI
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7Q-0004Gs-JI
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so3678633f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138578; x=1744743378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bd4HZgu2rQoNG5y96HldgtWC5Ca0xdeHz+9r0bAk4j8=;
 b=FdutjfaxUBE/xbCXwenWfTZ4KYczFbINTS2QP6gsN+XZm+puM5DsRMZS8+eNhYTVuC
 X8gK9waFOZ1jyeXe4gxuKXaPrBVrWhUUiAPDlIF/RZK3tjNDW73V5WdomNvnN5z4X3IZ
 +rMwZmGBl6O5JfEjnvR/4v+Zz0SYr5MU3MaQTS8Ak+tOeJYw3yNP0LKj4zwcyzN2ylhc
 plzm9cdvMPle6zw3YnDNdvlte8Pap2L+f8gxvPk+00RBP63+xWq1Mq0KCI6dnOrNLUj4
 tY+iBiDlA9cLUNR3h5Hw2Yaw9oYrjPTMcoJsDwQDiRTu0qMXzkmwAyE7Dbbqjma90LMk
 Cftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138578; x=1744743378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bd4HZgu2rQoNG5y96HldgtWC5Ca0xdeHz+9r0bAk4j8=;
 b=emonxfZ/ag+w1KyFk/eR6relg/wyb6yAlaISkQ7LAKPGzLOrfTvb+I8m/CMbIp5pCY
 2tc27KFclZjsTjDT2Fl+5Pbr7sBs0nhD53YwyIt/tDTzcaZoj2uIubdvDeV3YNg0gx2N
 ijg7eqz9ASYYAiJTc1TzpMnJbjPAuT9vb5eHY6BprwfYZCCv6VQb4t3dgc16IQ8xWMML
 kR8UTeoydRfOvyu0PmHWslSIzoKqx28xL7HzqerxqziOgx8El12yJ6B1qQ/xspm1wzpE
 4HSrlQuSooWIWbn6rfJ06Pe0MzRvhyaa4flTddY4BFztkYN3NFqVmzuYLCU0ewWrlk3P
 tD0g==
X-Gm-Message-State: AOJu0YyoajA46EydOa1lYC8kRUvEUFqWV4N4k/SCoApeGgbZoRFX5wcn
 kENlDDa/lCGF3LQa66rXscZCka3Rxmh4RXwPAZWo5KXsuvf2EZdoR5TP7RNB6LuMLpgjmC5ZhOL
 867Q=
X-Gm-Gg: ASbGncsD0Zf4tb9FPRah+vkly87PeW4e796106qPjux2/9zVJti3yFTZkjm7yYa5m4I
 EmwLnkvAgKj0ZqVuK8WCalRXqODR+llxYTHLWgoUyiezz3rd/v1IrAn5G2jx0Eje0PLugVpBevj
 Q73LsBs9QGAIoW6j8nHDJzFe2XUe2JLRrkbIxihEl1VMeOaU9pKiDw5OXWObNzNhl1KQqH7ufFq
 CDUf0PA0JVfuSI/vD4FLEiIg8DCHBzxmJxE4J51wiWjK3hWagM1PAl0mns+Ydv8nO2/JQ7CrS5k
 XMvjA1lRDxkJ7B8WBIt5hy33YG8GeNRj5hXDmZS16JeulV0GyzDNOYOArq9jrWboNB8uSPkiTK4
 6MxeVSyms4laNt9hUxYg=
X-Google-Smtp-Source: AGHT+IEoz0LHiBxJqgGDH1yn2ICFHc87F8fysBbRnTUkg7bSPDsBT+ZxPEOConiTYxc1qdVl+tPWkQ==
X-Received: by 2002:a5d:584c:0:b0:391:2f15:c1f4 with SMTP id
 ffacd0b85a97d-39d87cddd2amr209773f8f.55.1744138578187; 
 Tue, 08 Apr 2025 11:56:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7064sm16109823f8f.34.2025.04.08.11.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/8] scripts/checkpatch: Fix typo in SPDX-License-Identifier
 keyword
Date: Tue,  8 Apr 2025 20:55:38 +0200
Message-ID: <20250408185538.85538-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

Fix the typo in the error message to help `grep` the example:

ERROR: New file '***' requires 'SPDX-License-Identifer'

Fixes: fa4d79c64dae ("scripts: mandate that new files have SPDX-License-Identifier")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250408162702.2350565-1-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6ae9d7febee..365892de042 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1688,11 +1688,11 @@ sub process {
 			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
 			    # source code files MUST have SPDX license declared
 			    ERROR("New file '$expect_spdx_file' requires " .
-				  "'SPDX-License-Identifer'");
+				  "'SPDX-License-Identifier'");
 			} else {
 			    # Other files MAY have SPDX license if appropriate
 			    WARN("Does new file '$expect_spdx_file' need " .
-				 "'SPDX-License-Identifer'?");
+				 "'SPDX-License-Identifier'?");
 			}
 		    }
 		    $expect_spdx = 1;
-- 
2.47.1


