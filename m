Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CACCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDf-0004Ub-1F; Fri, 17 Oct 2025 09:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDW-0003xL-5j
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDO-0004fD-Ke
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-426ed6f4db5so1758376f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706587; x=1761311387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9jwimuswCJOfHVj53S93paKIotqSGwUVxc74CBqNFg=;
 b=sg8AYn9m8ovp7nJJzSI/d2X9DuAWJ3Q78qGpjLKT+lto26fmNRHJXCy8SaqymNvDD9
 +ifpYEbHaAjmhnDt6ACyxUT/lww1aFuED6014bSjOlilAZM/V0tbgvRE5Pqr4Qt1LE2t
 kr1uP/ckO89sk+dllZ2CaIF+E2Bxso4gRVwvaPg47HOqXYyvB5fsaq90q/1H0XtUtoMp
 9GKEseSoAByFO6WmyTIjMFP7y8F7z3L5AkshSAVzanDOY1BWm3BY6qTuOiocRA40ghcv
 a4zxLOyUkgH4m2JzMSIACke+TW7I8I71i16XJmbPLNlzfVoZNeumuEm79s/pbrUjHmUT
 Cfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706587; x=1761311387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9jwimuswCJOfHVj53S93paKIotqSGwUVxc74CBqNFg=;
 b=RbOL4C+b7WF2/fRpt2RSAYlnMpgtRA8OfdgpbMoYwem4qxmSQGzBnCih4PDgDuY9sh
 8OiUHOqfKpVzqCQqoJfEQ2wZK8MSML1DL3zR2gnDo+meYMn3vjVIyTZXK99J+yNpszgq
 UdmAyotRYIpgRtotrYY2h4525vUtSNOPmINz8iyUATfdOiMJcL14vt5OL9OeOR2BWgnZ
 x4s3BCS300hk8Rcih+cYlyZvIKP9A025rgBDPLFJMDCUGmh1m9vC7nBk9frK/A2MIqAj
 cy6dbQM8FFNZAsBcRnyfeC6P5fw8EQ2UaE5+Hy9BUG2ZZAa60hXj1y/RX4qu+wuIvAzP
 lFdw==
X-Gm-Message-State: AOJu0YzJYt7jGwdxWKkmtR4fgm6+/yP2oU5MRyP//9A6oW8zRysDvoNo
 a0sS7Jnb+BtjkveQqhD/Y98kSX7JFbihEHzKXso5iFUQxujU1FM2TCu4XGVg0sjTU9c6n+WgUbH
 4l++SzoE=
X-Gm-Gg: ASbGncvFDKISTXyLz1u9EJZLxwF0oLYtFh4/c1XWsC0TOny8m2BaM6Z57qKXnLFZgyJ
 yOP1UfPabXjLH73U5s2GSBc2T2qOWPODTi9U6BTycZ/x5t+NvaACxoAJrXf9wKIrfeVtWenqiei
 uwAlVtyCI4IMXIZ9nfN+jwVZG4POK7gsYkzsxeKTVF4fTCs4zffPtHTEC8OKTrIa/oN6E2JSr7q
 oMkZO2tsOieMoz8yj1pgaaJQQefp1Wbz9kMIEz3o7333Y4vFA7SMenfcKF7oU+ENYk17WwoMKbM
 7CXpiA4OajOuDNe97Tm55yFCY3YHWrZDa9cnOKtn75hRnXVr1nKPXNXkLayMewnITGiyWm3MiLP
 OBVgF69jmEta9Zm//ip/24qCX8SKwjQa/q4oBPVGJC0WWzx9ByBNXNbmUAHc/xB+BmpngL530d8
 NuGbOmyZSIHkHI2YafoINjullkXjpYb/LYWfVDgrybYPihOWHR+Q==
X-Google-Smtp-Source: AGHT+IHKf+HcKG+LKZBmy/HAKb+DDrZfqCNI6AIIv59fVkhu5r51SbYonKP6tk82eDYmrVXEyUAWfA==
X-Received: by 2002:a05:6000:40dc:b0:414:fb6c:e369 with SMTP id
 ffacd0b85a97d-42704b3db2dmr2572248f8f.5.1760706586721; 
 Fri, 17 Oct 2025 06:09:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4270a62427csm650576f8f.30.2025.10.17.06.09.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/20] hw/arm/virt: Remove deprecated virt-7.0 machine
Date: Fri, 17 Oct 2025 15:08:16 +0200
Message-ID: <20251017130821.58388-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eb0e0e1bee3..7218badc8c7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3597,10 +3597,3 @@ static void virt_machine_7_1_options(MachineClass *mc)
     vmc->no_highmem_compact = true;
 }
 DEFINE_VIRT_MACHINE(7, 1)
-
-static void virt_machine_7_0_options(MachineClass *mc)
-{
-    virt_machine_7_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
-}
-DEFINE_VIRT_MACHINE(7, 0)
-- 
2.51.0


