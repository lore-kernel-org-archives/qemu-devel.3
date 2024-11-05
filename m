Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B87D2C139
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LWD-0005ZP-VM; Tue, 05 Nov 2024 10:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LWA-0005XA-Vz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:30:55 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LW8-00041q-Lo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:30:54 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1e63so6713236a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730820651; x=1731425451;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/+Dw+aYt6NbuWkFBOKFczpVcmoeYxuOifXoZQ9eKwo=;
 b=ekj3rA5x7MOLG0krhrECqLm00lL8+uKGFgOrnS/nKdcSgcpfKBSeqJVlw7oMoauf4x
 tEw/HP/yp5UwQfKZmT00xqMQ7TQbSOl5gzpA+Je/e9FiXRKRdTFMXwlKyCo+9SYMjxdi
 ON55kgCcHqBCge2Q4L9NFzkWqUWkcqAsjMPcesnK4BQbkvtIDF0+sqq2ko2qBFAb4fe/
 MxEETxxCEcQgdUPu2/Pqspmd23UkfDYyT2BL6RkkuQTFjTWRySoQX1Nm8bd8+0tPbJi7
 8/ngzFoBleqBjR9CyIlTX8i4wK1USBAVNvtMSuI7XkFX67IEDlBueGttQ1ry9ICkHxII
 Swbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730820651; x=1731425451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/+Dw+aYt6NbuWkFBOKFczpVcmoeYxuOifXoZQ9eKwo=;
 b=JdKezZTLo5U6zuR0QWUl732gQg4tAMBxjSpOzB48RKZlfvHe2ABsx3fVt6rD2HF9hB
 xbHhy2GkNNpTms37fTb6mYdiTBAI8TbJ75VjwygNl1p5k6dNxEHERa0YhuOAzWDxwJIU
 A3zG0Ii2R95qd1EY/PE2S9wMstTfDfXsIo3aKC9ZXyZglU5w90m9lAEyalE1jJ4EwIVV
 R1nM97T8Rk9R106ePJOHOdwDdu8AhYFjRx6YraoIc68Y0hRzitpBHN9MW5gfdikgJn89
 pqR4M5Zq0v3ZuSRV3TIVNZw9mLjlsPCm4Io4087REt0CpMuoXOoneeITMAVlglBxVdMY
 8fZA==
X-Gm-Message-State: AOJu0YwKvywWVnDqoq1XbhV0ky/o0Dj181W/mLrqX1/sivomnCC/rMwa
 8PmpTPCuDQAXR9H6maJbo2eYbqlxehUycVtcMSXZ6IDmuBuUn5eueaETxr3gdQUy+tXiEb3Zpej
 HCQ==
X-Google-Smtp-Source: AGHT+IHzyV84ALVakfza508qgByGVmVkQyv9egnNz+DuJg/dAXDiwRZrfOPETSSkMFSBE2JbiFzLKg==
X-Received: by 2002:a05:6402:2687:b0:5c9:7f41:eb19 with SMTP id
 4fb4d7f45d1cf-5cea966bceemr14580439a12.4.1730820651081; 
 Tue, 05 Nov 2024 07:30:51 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6aae3fcsm1419415a12.21.2024.11.05.07.30.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 07:30:49 -0800 (PST)
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
 qemu-riscv@nongnu.org
Subject: [PATCH v7 05/15] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Tue,  5 Nov 2024 16:30:12 +0100
Message-Id: <20241105153022.91101-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241105153022.91101-1-phil@philjordan.eu>
References: <20241105153022.91101-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52a;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52a.google.com
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
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0844f5da196..c7964ab784b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -506,6 +506,7 @@ F: target/arm/hvf/
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
@@ -513,6 +514,7 @@ F: target/i386/hvf/
 HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -2608,6 +2610,11 @@ F: hw/display/edid*
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


