Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7D0E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 22:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPqk9-0002CR-8o; Mon, 23 Dec 2024 17:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqje-00020K-2b
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:10 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqja-0006we-HI
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:07 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso3999952f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 14:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734992225; x=1735597025;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3URIE4zHtByvEfYraCOVtbfUd26NZUSZnP/6fBk9gDI=;
 b=D1Y9KJWMpkJNgw6QecBC1CT41bDl15aloVrJrrvDHx9upjiMk2W2ud399u48RcQ7bW
 eJlIZxCCb3qRKNi96WgCCCUmmEoJP9V/xuOt/rvx9h0GCBTcS+t4M3Pd4ppVWlP7m7h6
 v9AfoKSKIUUtZ7U+yJS56k4iGUqQY1RuzpK3JYvwKRkZEjFJXWdiuuAdUSckrUjePDVl
 5jouJKABHxO5ZJ31g+bZ9TJ+5BLlMcYPoQxYK6i/dbUyUPWc4ydIGkBE3J389Is682+z
 GOKuku989XXghiUMRWbOzjnZAOsf+auuDh6DI1ySIEBJi9oVbEISp7O24m/SQJgL5dHY
 wqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734992225; x=1735597025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3URIE4zHtByvEfYraCOVtbfUd26NZUSZnP/6fBk9gDI=;
 b=G1Hn+FeLOFVOB1yL2gv4TSkLvjlm8PeWvgPyw1U/rf3GKqRhhsr6HCbxFfTNwdpDYI
 8bd9tH0cU+VHJwcRKK3bdSTfVxbPa/MNMeLw1Q6OEhcc3syTOaEE7Q7SiuqOUGpo/98m
 Q2i6hK9Z828ceh6X+pgn03MiHvLZFKIhrBCgiQsRQBc+UV8Nnzwh1LpgFeot2UifXfdb
 z5z056SLCUmWU2jNGnU8C5+jBblC0DWburK7Azec2UQQGMhMb9NjlbLDwsN3v/jvdHf2
 o5Z8rDS4gQiRQvjuCf1HXdUu7qnWQlpp0zrTzx7k+lUhYXBRryhuIedInySzCQG6Eh1g
 dd/w==
X-Gm-Message-State: AOJu0Yx5s3CZiY9Zx9+qTVxhid0di76jLwgQf1hWHERaL+owu6FUWjcR
 qFebZpllL3ljihYNRmGOEWmHjGi2uyAED860XcGAG6PUWL93XY4VNIE8XoaPXAH4xcuL756PtPe
 yfA==
X-Gm-Gg: ASbGnctkuZI48YzeLK5wbflHjQcZsngXw0zOf2NNnAho6v8ukJfIQ79ZC4CAe8N2KEZ
 CJLGSKytKp1FDCLuM3FpKwlFkpjeDxNvQW4SAcecLrBqhW2J7vNNTnRVObRO0HkEojo4iXdaR4k
 n0ASYSj3oKmHR4Rd9AjEXqFnaEz/8zJaWREJgmjf/lPk6ybC6OWvBj7m1Y+Etyz/F3i+8PH0qaM
 0F7i6o0hrz0XVTz7Z385fo4vAVZPytXPA4M5Ajgojv1RMf78xcEkERXzscwDbpwkGjGvZjDPA6v
 O7FuoTZ5BNvQHjo/A06W/+GM1obevGDp
X-Google-Smtp-Source: AGHT+IHtJfUBYzPSkFb9ar1Brv79jSK9DDHg0ztyCGaixYuTB+kWpcZSYb1gBC26gUFEbY1muy5eKA==
X-Received: by 2002:a05:6000:4a0d:b0:385:dedb:a156 with SMTP id
 ffacd0b85a97d-38a221ed2e7mr11037812f8f.6.1734992225180; 
 Mon, 23 Dec 2024 14:17:05 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc161sm147561075e9.10.2024.12.23.14.17.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Dec 2024 14:17:04 -0800 (PST)
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
Subject: [PATCH v16 05/14] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Mon, 23 Dec 2024 23:16:36 +0100
Message-Id: <20241223221645.29911-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241223221645.29911-1-phil@philjordan.eu>
References: <20241223221645.29911-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::42b;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a290e9c2..2101b51217 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -509,6 +509,7 @@ F: target/arm/hvf/
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
@@ -516,6 +517,7 @@ F: target/i386/hvf/
 HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -2631,6 +2633,11 @@ F: hw/display/edid*
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


