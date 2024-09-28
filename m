Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6EFCF6496
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 08:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTHj-0000YY-OH; Sat, 28 Sep 2024 04:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHh-0000WD-Ai
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHf-0002K8-Gh
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37ce18b042fso216868f8f.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513913; x=1728118713;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfeuSle8WU9lgCf9lWNy2Qa389vC+1vrwCadU13cu6o=;
 b=jfBK+BRtJtF+gp8/N0evWYVshHEtFatc4vAU4REkpfEMwyNia872Xoha5jSnAopaeU
 DfgzpwHUF2pq/rRy0W8zWKTQVbfQXhkrKLvSCT3Wj+hPNCq15zgCji/E8iuN8dPDpEEC
 NjTijvUIQjt9fiAmyZd2AmGMrhm1iDa+cQ1gMEYscSAOgWKz3omVZzF3dEZ3EMTOmLES
 wjAC5/tlnWJPdugl019d664yNF/TKwlJzsthnXWc9x4xhyUFh+unUm8RumFJEJvPdvmU
 wcfDLOjiEEJQLFhdMKejW+mrLWY/vDJ2XXjfJ8J2zQSI17CxMIWmjdBcwmoGtJnzH8Gr
 uDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513913; x=1728118713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FfeuSle8WU9lgCf9lWNy2Qa389vC+1vrwCadU13cu6o=;
 b=fF+dr/fWB+TJE81U7rWzED+BUqaSH70XsNLRQ8lNtEGRvgkwfBTC/F3cJ5BWF2Q6Uu
 ifyAgBIQ3vdjsk9yEGRnLum3k6nCzpvvROjDoNkCjy/YSeOxn0HXUdJy5pRUyXY7ZKvH
 0vjda0KbK+V+jMRSxZnbjPg32WtCWQO/megDIFHmQEnrAwYBZUutVHlJMEbdMEZRwAjO
 uF4Ddyt5W6o3hkzmbFyzCc5WkbXj0GHBi10kjL/MAPp2rJ2XSb4znjIPXET8YN05Fidc
 plbgwaGTKIwIE32jo4BqS8B2XDkxr4TxmUBfo0hOEDzDyOXGcKplcJhVQ2XjXhS9XqSw
 rLPQ==
X-Gm-Message-State: AOJu0YwdY9INzal3+lnRY+iW5TgLfmLQ0bKvFgzDEZ3N9X7yhV7Ln74J
 meRQkiivIcNgVei5xDFjMfctbwuGV+XyHCjqQcMcqvCA8uSwTLAzqjaXjRbQ+15i7bQfKDssbP7
 j8g==
X-Google-Smtp-Source: AGHT+IGADEFUjJjdNj/ScMmbJthalbIvRiUmnE9lhPF6mFJEgYEg6JrbjYyhU/VLvr5+ABiN29vhig==
X-Received: by 2002:a5d:404a:0:b0:371:a8a3:f9a1 with SMTP id
 ffacd0b85a97d-37cd5a831fcmr3731857f8f.11.1727513913081; 
 Sat, 28 Sep 2024 01:58:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.58.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:58:32 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 05/14] MAINTAINERS: Add myself as maintainer for apple-gfx,
 reviewer for HVF
Date: Sat, 28 Sep 2024 10:57:18 +0200
Message-Id: <20240928085727.56883-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::436;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x436.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
index ffacd60f407..0133b874847 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -510,6 +510,7 @@ F: target/arm/hvf/
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
@@ -517,6 +518,7 @@ F: target/i386/hvf/
 HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -2624,6 +2626,11 @@ F: hw/display/edid*
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


