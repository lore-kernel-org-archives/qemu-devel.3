Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909A6C369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CiN-00044B-AX; Wed, 16 Apr 2025 20:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiL-00043K-Nq
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:45 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiJ-0006QI-6t
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:45 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2cc57330163so98540fac.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744848161; x=1745452961;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDzK1+65Mv6a49WJNhPRq8x3vpC29HQLfTAjbcCCOoI=;
 b=Ami1ZQkHM6zJEPVcwQ6PxQfJzc8urtuJdBtmju82d7pXcaKod0QltkNCF4EAmlvyGy
 QHPYWni6LmPiL8SbC29FU+aHTbUK7VhAgtgH/HQsC01cx3lM1p3AKjCTNQVoN/ZVmqn6
 KLKjoREGSPc6zw6TMYJ4EDIA9crZUtrLoA4Pbh4za0C6M7+eyKwzUyNDvr6sH1IRSsXJ
 71g64a3teKeRPxXEJ/kz6YkiP+ZR7mx9WZ7genjXmZPz+HwcqbICNdF9kBpPKhshym7P
 19AxonZY6LO45Bs9zuaFFGavcfR0aTfPAiT61Ryg9a6TQzfEhZ6pXixqinalYa5LO2dJ
 tTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744848161; x=1745452961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDzK1+65Mv6a49WJNhPRq8x3vpC29HQLfTAjbcCCOoI=;
 b=RgZj7zEIe4aG4Kfein0y+kEpZWZVklBzLIRhsY3PIBXXyaXSCmAm8AHsE8H1hPa5qZ
 dHvv7qrzRtmEsCXe5D1AMfJVgUQq0RQkla/BGou4Q1o3HZoJbmfjWB670IblEbxnnWrR
 qgwEorzFP0/DKN+csZplTALQcFQnbn32NRsWXWf68lbsAUu6nVMBguP1xRqCl/7NuSkl
 NgyC03A8lkzV0eOQitiLN+xPwHXdSTnwr1OBSRfpNLcqWKZhDt5Y5JirOcYT4C0fD6kB
 uthy4CQHumS3OGooj6Zalu1B90Izk8Juo2W5aZgCgMOhr1Wu3mvvuFCdVpa4kM81xLpx
 8axw==
X-Gm-Message-State: AOJu0YyBnmZAKD9eD1ThPjF5OM7cfR3y4c64AxzrHPBwerc323GghXvS
 2jvPhmlAd2EUo8H/8zvbAq8PuaNcwBLgDYn8HH8Jf03ZGv36Sa7KKa1wL/959CGr9/me1qLxKU6
 T
X-Gm-Gg: ASbGncuPUcdy7SZGRIgaxxcjdfLWSdSS4kERJ9RQv9bS+CzqtZ95NsR9nnFGFARq3L0
 Re6XQZN5WIB2lwLTwLDTm/1vaOaSC2klHdjd+m94xixsPFrYVims7oi9gTEddpn1ajTKddpPpPg
 yvF6vnfKYvp2fkSXB+mrsalP+hhLT68F3eEMjSTI0kCzTm4dQ95y1pykkWa64CW469SCDN+A7/f
 ME1hD5FcoalaUVxgWOAgY5D0s7xFt10tUyUYNHfoVSSPu4cWo/VL3gmERaxSVknAQKMtCz6ecou
 nFBnO1RzJxZcia7tLF6zdZNoELa6XgMkeDU=
X-Google-Smtp-Source: AGHT+IGDvOs48TtVL8rxkSAq1cWBZ/eQGDJhcjmoWha8/6tKmiKjorxULfe0WqrOfBEXwf7RMYtyTw==
X-Received: by 2002:a05:6870:4945:b0:2b7:f58d:6dcf with SMTP id
 586e51a60fabf-2d4d2b65c98mr2396233fac.18.1744848160830; 
 Wed, 16 Apr 2025 17:02:40 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8795:e9fb:beca:ef25])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-2d096cd1a48sm3527040fac.40.2025.04.16.17.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:02:40 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PULL 6/6] ipmi/bmc-sim: add error handling for 'Set BMC Global
 Enables' command
Date: Wed, 16 Apr 2025 18:59:10 -0500
Message-ID: <20250417000224.3830705-7-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417000224.3830705-1-corey@minyard.net>
References: <20250417000224.3830705-1-corey@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2b.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Mask out unsupported bits and return failure if attempting to set
any. This is not required by the IPMI spec, but it does require that
system software not change bits it isn't aware of.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250401140153.685523-6-npiggin@gmail.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/ipmi_bmc_sim.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 4ed66e1ee0..1c60a71831 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -235,6 +235,7 @@ struct IPMIBmcSim {
 #define IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(s) \
     (IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE & (s)->msg_flags)
 
+#define IPMI_BMC_GLOBAL_ENABLES_SUPPORTED 0x0f
 #define IPMI_BMC_RCV_MSG_QUEUE_INT_BIT    0
 #define IPMI_BMC_EVBUF_FULL_INT_BIT       1
 #define IPMI_BMC_EVENT_MSG_BUF_BIT        2
@@ -934,7 +935,14 @@ static void set_bmc_global_enables(IPMIBmcSim *ibs,
                                    uint8_t *cmd, unsigned int cmd_len,
                                    RspBuffer *rsp)
 {
-    set_global_enables(ibs, cmd[2]);
+    uint8_t val = cmd[2];
+
+    if (val & ~IPMI_BMC_GLOBAL_ENABLES_SUPPORTED) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    set_global_enables(ibs, val);
 }
 
 static void get_bmc_global_enables(IPMIBmcSim *ibs,
-- 
2.43.0


