Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADE8C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLta-00074o-PS; Thu, 30 Jul 2026 04:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtY-00073j-7f
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:36 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtW-00017e-DJ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:35 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so233682066b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399209; x=1786004009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wXiU7ti5qahm2uu10xmoUW4yWwkxyZQGn0PKpqZCris=;
 b=suBYjEzTXNT3xp0FjUL0or6LynSQZCNFzpAWMZt3o9suFrKAokzfgfWnthcFTj8Teo
 bj8xwMRT31v3nsGVxWk0Tg3bVG5lYxLqaULjbIAANNq4GNsOILEsTT5WPkTVi02tMulY
 El2+HMG11cp8jkS2jF196WyfCainCGq/dNNH3gcPxDmrnT6kHp17rbc+ztNCne2TUyfA
 gh/OFIaNeBZIeiH/i7CE1FyEgyvtu8Qi7Wp2G2LGJLTaZOxUVdTZG6ywIKHt/qtkKVbX
 TDwICCbmGVI/vbCIXkFCkmOYHnwGGKZWi2GeqBhqSlqNiaNxGfEkc8DGHyzWVSdga8+J
 +Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399209; x=1786004009;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wXiU7ti5qahm2uu10xmoUW4yWwkxyZQGn0PKpqZCris=;
 b=OpH2ms2jj2L7KKdOlcAnLBap4nZoKD6nH4HA2aEq8jLiCopd2vnQn+ut4WXf82bVfk
 kb4PcXzdnnFY0vmmGS2Gwu9kaeuKfu0HryBAoBoe1rlqaR5W0JKJu0/NDGV+BzrLiH+0
 ce0E8mPcdGySynC8A8vWCEYydQMAFu9/id61XxCE3kI8iPOh/anFrVtS5VVykHB8ZfnQ
 KNgm57HjIY08sr9pO+VcveegI2y1aKguijeWXnUVbKqdZ5tFRXQz/QqrQy/ArfcdtzQJ
 lOSAtEkS6OJThI82Po/Qn9Wrzu9Olf02K9bir207l/By8kJYADXZ/kG8nMorl2/LMz1Q
 jhKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RobCPzB+tmCZRqaPxG1NHTMtGy8T/grOYlQnpxUDF/5gpIt0rep93cVh+3LxRErvixcRnJoN9c2XfR3@nongnu.org
X-Gm-Message-State: AOJu0YxFPSgtZG35OBxVXrWFWencO736ZzdW0KIH1fkPjHmQI7ZAVS81
 Fye3ZEUirPd3ayMQM25ibPehbz7POCP1++VmfxKg0Q/K018D5YqV2KKYqmJ3L0zo7C4=
X-Gm-Gg: AR+sD11nPXjnUEZWL7gYwSIfbM9sg3Nsmx9CEAjaOaM7RdqdxI6cyFbcYBUIhqDu03+
 OixN+fmnTf85VR/urw8o+r2i0KzxEsLbIpNLGPAyYmzc9OVh0w9RotU2yy95GMrQBE9xepEukYr
 7OSXPHqu6V1g+N3FH6G5QqN54nt+SP5tvghIjwATUaUXpeivec9zlcjznHO00lsabqLHK+Amfsd
 yInh7IywIX7tX9QGO765s8S3IyU0rIqwev0Y9XFnVmjaCRa3poKRm5LIX6iwfXUyELolkNvm5uG
 jWkcMyQUNB07LvWboJqR9qN9S/eGFTuXnjqLpvGm6EuyP/dgk9jh0DWgiT3j5ZurfwQVUImmD2B
 8vBk3JRN4GV5tmyCzBHUNTqrf3CkKNmu1TEVcEkKaSuDtjt/T1SEXAfPw/YHmdyjYI+RkzSqV2Y
 FnL79IiVUjj5RkFh8JSVNB9V60Pu6LCjFCtVhGyND+14NFeRdB7w==
X-Received: by 2002:a17:907:97d4:b0:c15:edb7:a74d with SMTP id
 a640c23a62f3a-c1fa53ed69cmr83867366b.12.1785399209062; 
 Thu, 30 Jul 2026 01:13:29 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
Date: Thu, 30 Jul 2026 10:13:17 +0200
Message-ID: <20260730081325.1816193-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730081325.1816193-1-den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=den@openvz.org; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..4628793dde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
 
 IDE
 M: John Snow <jsnow@redhat.com>
+M: Denis V. Lunev <den@openvz.org>
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/ide/
-- 
2.53.0


