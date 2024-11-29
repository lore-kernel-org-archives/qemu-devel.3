Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C596D729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH2s4-0008S9-Jg; Fri, 29 Nov 2024 10:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH2s1-0008P1-Q3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:25:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH2rz-00025J-Cy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:25:25 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4349e1467fbso17957625e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732893922; x=1733498722;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwfJKS/UmNk6H202tZ95ZsNatmfeqYn1XDsf0iNj28I=;
 b=EOg3sW/kn7RvDQhTFNxCuO7g8tE4OQ7/EHW+t+rscoqm+m1ToUEJSTqop+I4RwKMiA
 JJ/Yo9RXP6L87J7weZK8+70EdKfn6y9lD5QC1F4CMyzKqbJZHNYNop8BouzzkPRSEs5f
 6C0X4vWvt/qk/TyvKKIuw3tRNoncaUUXSye6WiiKgbKDNRjVlV1Qh15dDcoY2v4HYrDV
 CiMq27Pv/NmNdAmOo31MOX1T1RfeT8e/Y6j+p/i3X5/OLfGN/fmCH6uG3W6ICxrL3yln
 OHmMozYGaIptr66pod5Stv3S726zpDmbyLN1RK84K0fecT1BXeBCdqh58BYLyEVuuZrN
 9llQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732893922; x=1733498722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwfJKS/UmNk6H202tZ95ZsNatmfeqYn1XDsf0iNj28I=;
 b=wFGy6oV5Gu+4fXYH9nPFs46AfIISBX9P5t9ZwGSHoTQrCKxRPH1acQuqx2uqI7hh7n
 cYT8Z4K2lensq7Rv6lRorV/BdhdSpyPPdUVLyzf9ICYWPGsYHi1ov4azs7pRhjFAQQOC
 n8MPqlJD1/ZXLbnEhjHAeqlSygs8gkROsC8oDak+xe+//sWi5UlpdDHMUnbtE1A5P5iv
 2UcpvPaNRCexKepZp6HEukNlOSWBGphpkzlkzChi6ZMMUW1eqCUMvzo7V2NQ+GkR1no6
 VfmY9qmShJPuux/sEqkUD/2S44K296ra8cICV3pjJwEWAEa/Sebia6VWE+0KWfHDyXnC
 dbTQ==
X-Gm-Message-State: AOJu0YyZLfi2RWpKquidw+XAGvh0rdAvdrl+lje941dltj9SYWjLQykz
 oTYAZ97RGCtrGa2vo/DMbCOp79U3byV4ulwFpAQiemzKj7etU71VApvk6rFtMTEQMLnQ4Cpa9vz
 esw==
X-Gm-Gg: ASbGncuhQlE00gEWtc0M7Tuc7X9Uz5xOZVQbtFBvVMgf720unn0LqcWkAcm948DMan0
 QZsTsRTkGOKr6wfZbZzxn5DwA4Q4/qfs+G55M3L/eKAlFxfXFG283F21yQw49my5JRSSVCLylJI
 2gCHhBWX9G+L0svKbX7zrnCiOtLd2CwKHSpYjdgQI/sOaYKhGKFFmLUdrizjLRnTX1Cao7aj0lL
 KotmzoX/wdb5vgnbbbQVrUKypxQi52G3R0leUzJFZLcS/tXxoNzA2UcgVE0ISEeY7ijHz81ivx7
 egmaDP703t6/mhJDHn64Er/weg==
X-Google-Smtp-Source: AGHT+IGNdAroA/eJSoS9VrtmHqCDyoIirPczpctgA/JMMSB6UMf9rpmkZIBMG3aSKSZqnjfWTdGaNQ==
X-Received: by 2002:a05:600c:1c8d:b0:431:4f29:9542 with SMTP id
 5b1f17b1804b1-434a9db845bmr106297585e9.6.1732893920275; 
 Fri, 29 Nov 2024 07:25:20 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd2db2dsm4685119f8f.14.2024.11.29.07.25.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 07:25:19 -0800 (PST)
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
Subject: [PATCH v12 05/15] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Fri, 29 Nov 2024 16:24:56 +0100
Message-Id: <20241129152506.59390-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241129152506.59390-1-phil@philjordan.eu>
References: <20241129152506.59390-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32b;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32b.google.com
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
index 2b1c4abed65..08780eca5d1 100644
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
@@ -2610,6 +2612,11 @@ F: hw/display/edid*
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


