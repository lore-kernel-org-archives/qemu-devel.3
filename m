Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23324C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHB-0002EM-N4; Fri, 26 Jan 2024 09:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH9-0002CF-Jc
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:47 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH7-0007rY-ET
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-337d99f9cdfso590952f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279624; x=1706884424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M6SHCWbrZ+mqpOFqOLQgsC9xtK67Vc6rtoI9yN+xnY0=;
 b=HRR83KHaiqPLmY9SCDjp0Jzs/DRAuoWS9eD/c286vUxHyB8ggw09K4diaQHzrml1sv
 ljdiiVk7jdt4EwsC4spiUNAl4kLmUJ+BE6j0WN/zMA31fPsgfzwKVkgVepai6rXdU56c
 mMQUoIIq89Mxu+jzelGiQSduzEEZ9M4o1ImoP0ozXUT8gVTkwA/bjZWJkOcO+nwl5ne1
 6V739ZmC0zPhKo6Aq17BXFZww+CfpM3FBGuXZkANy1bxqMBMqGr2Wwar4zSRKZeCEOmv
 IfiBQtTCHPdxbEDcQ/W13luyOyUjI14A2IQR/HUkg9u6EDaFXJzjrkJL7VEXniZ17HmO
 zKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279624; x=1706884424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6SHCWbrZ+mqpOFqOLQgsC9xtK67Vc6rtoI9yN+xnY0=;
 b=TOg2+5NvHOSXcnAc4vQNtChRBFQ3Uu9rylsg89kKiI56xj4Ch3E01NW6g/43gZHD/D
 SBWo3D3jj4SOAP8ufH4muxAu8rJXmt+3kwvVLnBK1LaFMOAZPWVVRVWUi//Ab4Dh5XPi
 qdGl6pxFPFRh2EHo8a+9JYaYrYMe4YJP56spNYDBr5FX258bRUKfJJ0nBrnWKRHsea1p
 gI95RD6T2g+/w6ZAVwjmqg89m5V3YlhI1yJsG2AX/+xg5kRgsjOVepbIdPPLpeyHutJI
 u1//1MJQjxbmY19GocRpOC0bxmJDQ3XyghslpzwlY9PQb9j0eIyER7H0++0JmwfJShLJ
 t3Hw==
X-Gm-Message-State: AOJu0Yz6rcpPZZIg6qdOEX7kAl0m8xTOGyg2Jm1PI02x2u9Kig4yKQBc
 igRrKJ2mqTYn9AmKko9FwMGFlE61ubXZ0O00GzO/Pr6Bu7CtwWIj2N6d5+bAoaY2D0v/hVJvEQE
 N
X-Google-Smtp-Source: AGHT+IHBbDEW1chsp+D0uUU+vvS8XHmUcBJs51Npr1d3TYFCbGgXRI+yf2ngYth1vBO8y7Q/++7VUA==
X-Received: by 2002:a5d:518e:0:b0:336:6ed3:2ead with SMTP id
 k14-20020a5d518e000000b003366ed32eadmr505348wrv.17.1706279623777; 
 Fri, 26 Jan 2024 06:33:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/36] hw/arm/virt.c: Remove newline from error_report() string
Date: Fri, 26 Jan 2024 14:33:08 +0000
Message-Id: <20240126143341.2101237-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

error_report() strings should not include trailing newlines; remove
the newline from the error we print when devices won't fit into the
address space of the CPU.

This commit also fixes the accidental hardcoded tabs that were in
this line, since we have to touch the line anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240118131649.2726375-1-peter.maydell@linaro.org
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5cbc69dff83..ed4ed9f4142 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1771,8 +1771,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     /* Base address of the high IO region */
     memtop = base = device_memory_base + ROUND_UP(device_memory_size, GiB);
     if (memtop > BIT_ULL(pa_bits)) {
-	    error_report("Addressing limited to %d bits, but memory exceeds it by %llu bytes\n",
-			 pa_bits, memtop - BIT_ULL(pa_bits));
+        error_report("Addressing limited to %d bits, but memory exceeds it by %llu bytes",
+                     pa_bits, memtop - BIT_ULL(pa_bits));
         exit(EXIT_FAILURE);
     }
     if (base < device_memory_base) {
-- 
2.34.1


