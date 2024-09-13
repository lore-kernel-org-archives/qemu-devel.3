Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEF7FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp81F-0006Ic-E9; Fri, 13 Sep 2024 11:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80E-0002Qn-IF
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80C-0007pW-Oa
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso21785405e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240467; x=1726845267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qYwSezei3GHgmowM3iNNbQqlhKZV+rcT9uJVVE4D7io=;
 b=hKHVaT3BhLde92e4i4LYTvEvH3PcKlX0u8t7wJEUqYAAYwGo24xZIrMp/hxoNbJRnr
 REjUN9yD4g60iOa95/pTfYs0E9RAMD1k6KfR7hc4UUjoD5CSrS8/04iABqTfbs+TGWSC
 QCLuZKVoE5cBIi8DkOg+T1tzoOcUg+8JiLoXZmYgor55avCS/Fy2DN0rvAJOpDwokz3/
 4AnHQwFYTzLA5qNAkq0++1SdTvfQ7R+eO+k4I2Gny1xqJA/FFSmOe42IxZzym4ccTfw4
 jd9+4+9n0GEByb2C8SIPORmcsmJ/0YtZM5enNIrqEQE+AXW4nh5zgMC35CHZb1qOYVhd
 n89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240467; x=1726845267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYwSezei3GHgmowM3iNNbQqlhKZV+rcT9uJVVE4D7io=;
 b=FK7TC5EZZjfcLUCigc0HmOr0qa6zoeKbcqC195LkZnEAt9N3oAaOSzAuHhd2s8I5+k
 DAWFGMUJs+dabVjLKVMq+OZ1MGU/7dStX1IqgH69WvfNEsx8u3wmvksasckEyuJuMkMw
 MogTpJWkDO5t0fBGhhtQaNTzQxc7wAI7C2j8BLV9+yOM/2P+z7EntBdiep2MDb9PBvQd
 KFGfg+bHkwyyjpHEMq2p8nWqrIxI/4AtLubrjhYMpDZIsEsbGm4fNYC2jk6pcqWslZE3
 oMPurTbh5x3nLe+8dn77jZIufrN4EcYretswu0/UP0ogWQBjDlwnJbKNTr7U2P8ke65d
 x/lg==
X-Gm-Message-State: AOJu0YwOJ/XN6GHA1kpbpGmhK07/27+tttxP8WBTK59pUnONrAaTpvUN
 LV0KvVETsLr2R1UUFgRdb7EqqYVx/akHBm4cG0JXC+j0pXqj0jeGEkWAnT/wCFTLPWuRun8GjYs
 N
X-Google-Smtp-Source: AGHT+IGsDwzWmd7DBFqfEckPgVFGSN1K8tlaf18PdwFC79GkjGmr0AMorlPbvjteW09sVCSNoLNILQ==
X-Received: by 2002:a05:600c:3514:b0:42c:df67:1d35 with SMTP id
 5b1f17b1804b1-42cdf671f9emr53039085e9.1.1726240467134; 
 Fri, 13 Sep 2024 08:14:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/27] MAINTAINERS: Add my-self as CAN maintainer
Date: Fri, 13 Sep 2024 16:14:10 +0100
Message-Id: <20240913151411.2167922-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Francisco Iglesias <francisco.iglesias@amd.com>

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240906181645.40359-4-francisco.iglesias@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9812d46525..b05505436a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2707,6 +2707,7 @@ F: include/hw/rx/
 
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
+M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.34.1


