Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3AAE77180
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 20:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKNny-0002GC-2u; Sun, 08 Dec 2024 15:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKNnt-0002CH-Kl
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 15:22:57 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKNnq-00083W-UQ
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 15:22:57 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa68d0b9e7bso17777866b.3
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733689373; x=1734294173;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTij3bXu5nZDt0Vwg+IprqKvFSAcOqEgivoe2gV/mPY=;
 b=lY+n3Xcs+nMAJ3OAlZjGRZypP0LMzfAL3XxC816KXfdjxfx73NGXNIvFzOn0elU9vy
 c7dFj+7enrFjBnqqreiSvVykCdJE3bWTTlmJwhefAAnGZTaITAjgcckgfRaOE/B5n2+v
 WWjQ4JGR6MaN6Zku/DRyL8sVaaB6ziQwqGK7mhA29Lamx3/fg6AhVRZTvVGt7IPtq4Di
 3fApHW03Wk7KUvf9ZFIsoEqGjkSRhvr3PNrZUM2B7q5WkdlkOr82R4hue6iMP0gR6xIC
 rszEiLx3EdahhXSH34qpNOe4FiPOWDdAecoSz8AMXoHMyXcRxt1DQAuT/cdir9IdXbcb
 uI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733689373; x=1734294173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTij3bXu5nZDt0Vwg+IprqKvFSAcOqEgivoe2gV/mPY=;
 b=BSWeRd9/PKYvyayUkyNuEz1n08T7OYfUOrspTOf+OXjxbcp6OJ68rDysvZv0uQLc/F
 T5O8CmrPnAn8nO3282RTBse2mzUelGEbdfWtggTJT/JrlrM0twmIfLHdOvJWMqABp2iy
 r5QXSU7KOMiN05gPVcZ+CWUNEECnOTxChBQH6PqtnaoOrpOVls7NRK32sdlJ2mZanKyH
 3WI4SC15a2VCxlcc9kK+o6LGzu3WunflkYcKe26j+Z9s7kA+v3+g6dD+FoBw7ZkvYDZ4
 1TCvZAVXvAQ5hl/BpnSIeSfiyvl927ZXntpSGw3PZP7nT2goNsiZ2GXLiQgcKU0UYKUh
 /Ddg==
X-Gm-Message-State: AOJu0Yykr3FBS3PI/Kg+PECWM90rPApGGPuJ1C1K0TmbxfazVK8VDIxo
 gsCO4ZUFrbhJbcTLIxFAETnTOscD3eE2hR7BVkLwbE2OIB7LEU6B04DxCjsq7IzpVZiRUlqMquj
 jE8s8
X-Gm-Gg: ASbGncvDI+y6fwMeknYD2i8m6WTjbn/SMUQug00bRM5ME+t2kCTOPxF3vr838ukqpOf
 JWiCSGdADccjxzlCbE2Di5cph0VN2THStkJuzAxvUdKhZQGMdoVXysXRhTpACU5JMJvS1fntob1
 2z4Lkfw8ga4xNBC6FCCAEICHIPcgPePOKlhaoVl6ODKNwZjZKmdsEawlSzpx8vBpCaTUR8yh8u+
 4X5mFzyFTvmH0X6WBv5Zy+UAcOe9EGDNwRs5g8McTGZ26L/Jnu6MqlGjPGhxptNPW0aGBTmAqVq
 3fSv50HoHezI2Q6By2gnNEnEdg==
X-Google-Smtp-Source: AGHT+IHTNe9idJqzd5HPM7VUB/kQeBJ5NKo2nGLhxf8vM+deXNb3VTppZHJOuK9REciS9XJJK53R3Q==
X-Received: by 2002:a17:906:328e:b0:aa6:5eae:7ed6 with SMTP id
 a640c23a62f3a-aa65eae884amr542745266b.13.1733689373609; 
 Sun, 08 Dec 2024 12:22:53 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e4eee4sm585759266b.26.2024.12.08.12.22.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 12:22:53 -0800 (PST)
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
 qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v13 05/15] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Sun,  8 Dec 2024 21:22:28 +0100
Message-Id: <20241208202238.68873-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241208202238.68873-1-phil@philjordan.eu>
References: <20241208202238.68873-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::636;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x636.google.com
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
index aaf0505a214..09899f7407e 100644
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
@@ -2612,6 +2614,11 @@ F: hw/display/edid*
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
2.39.5 (Apple Git-154)


