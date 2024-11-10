Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A399CD12D55
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 22:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAFuO-0003pS-HG; Sun, 10 Nov 2024 16:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAFuH-0003hA-8Q
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 16:55:42 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tAFuD-0003xC-SZ
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 16:55:40 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso740111366b.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 13:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1731275736; x=1731880536;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIhXQnoj/9ouYAI2nP3PoRv/lz28A9hOVY2Snhhf/9M=;
 b=SeHQ5o/do/7angSREGqS65fkKuSyhDB9B3AIvEPyTCuOuw1KZOgz79nc5XeTGvLikV
 0bUGv+QPTcSRnWNCS4g83ik+b7CSifp/ccdyhZIHbtDWZSFmtk9mt85YwwI2z+2Puo9k
 YrCWIK3AL6gwAf1M4SlZARKuf74aSUSYB0gE/yu8/4dov2Vzn0pJV1xlz3Y52ZGljP7A
 yG6V5SA9XwOlBw2JQG7c2qMLLlFnopXdqFMA9TQ1hunBz9dBYWuHWFmkM00c9h9cHr+n
 pIgpvRO5Mhxv7YWIGbkkvWfnPodTRb1Gk1J7dby1J/tP6wQO89u5ecee7d2WYiamn5Pv
 64oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731275736; x=1731880536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIhXQnoj/9ouYAI2nP3PoRv/lz28A9hOVY2Snhhf/9M=;
 b=O2QOJcNoRkSGwQIduHBvD78whNT11CptwMieooU7VT4LUYrYKdpCkKD61QTBIVsSrN
 6XprmCP2tmaiXm5nTDpIluPhhvGo0tfkC+DpMvaPvsPrlC/UBWaXmYvWRJD2flXdYrLY
 oL7shJ1uhh+dy1ProlXOLtaXXGAccZbW8/DdpoFBV/zk7UHOcW+GcYKx5rpsPJyVOhei
 T2Tnt4BigoHCmtLzVCLTqRtj30x3jRCTJxfllpB07D9JOcqSaBnpUIIpZ0BxeRLZ2rjr
 Tz8G6sAw6hzsJA7kjFZ5oPR/YGKIs1ZgImO/WZdLXiIbkoucwSVrelYJLlDoNxpC42l9
 2+UQ==
X-Gm-Message-State: AOJu0Yy71LMCAs4FNbMG/0W6WMbmVO72TDAvw2SC0FRRgI4UA7RVn/eK
 7ycdXyF9zr6ZwYgohPTx2w8hlAca1G0SrA8kW9ev/bFZ75Xbb1kHkiBVD3pib3pbKouQEEHQJ2t
 NBw==
X-Google-Smtp-Source: AGHT+IF9f02dQgCnAPmnuJzS8tQ5X3Ck+eKkPPWQRbz1SeOhRefX2YpNfwAtB+hKn7PsFTqZb4LSoQ==
X-Received: by 2002:a17:907:c09:b0:a9e:45e6:42cb with SMTP id
 a640c23a62f3a-a9eefee4bddmr1033790966b.18.1731275735589; 
 Sun, 10 Nov 2024 13:55:35 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0e2f731sm523715566b.189.2024.11.10.13.55.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 10 Nov 2024 13:55:35 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v9 05/16] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Sun, 10 Nov 2024 22:55:08 +0100
Message-Id: <20241110215519.49150-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241110215519.49150-1-phil@philjordan.eu>
References: <20241110215519.49150-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::635;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x635.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

I'm happy to take responsibility for the macOS PV graphics code. As
HVF patches don't seem to get much attention at the moment, I'm also
adding myself as designated reviewer for HVF and x86 HVF to try and
improve that.

I anticipate that the resulting workload should be covered by the
funding I'm receiving for improving Qemu in combination with macOS. As
of right now this runs out at the end of 2024; I expect the workload on
apple-gfx should be relatively minor and manageable in my spare time
beyond that. I may have to remove myself from more general HVF duties
once the contract runs out if it's more than I can manage.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0e..b28267b6286 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -507,6 +507,7 @@ F: target/arm/hvf/
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
@@ -514,6 +515,7 @@ F: target/i386/hvf/
 HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -2609,6 +2611,11 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
 
+macOS PV Graphics (apple-gfx)
+M: Phil Dennis-Jordan <phil@philjordan.eu>
+S: Maintained
+F: hw/display/apple-gfx*
+
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.39.3 (Apple Git-145)


