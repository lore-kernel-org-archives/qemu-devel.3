Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDB6F99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquj-0008JW-Cw; Thu, 23 Apr 2026 06:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu6-0006Yy-6r
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu4-0002KW-2v
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d70c30767so4347530f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938600; x=1777543400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5jtxzNslKZuQU5rJrwMQ7igVsUYizcXwn/USYZz0v9g=;
 b=LQUDC/nA+0ohENhGlzep5mMi5rIBnWYs0FfR8V4aQbep8hJ0ymLh338EhNS1ZDM8hx
 LyYNVI9ciiO7sn2ZHUUWFP188Ko6EEK0xdWQ7ktnH6vWDr9LfRhrnipKW/uG2Q65n7Fi
 oy3w7Q2iSTQr9UpFpLtTWTd/A9YNvi6Be/D8t1JZiT5BQ0VoLBNcDd/nhG6peWXizcib
 k7Z6d7ifvIWoAG9WJdTdMscoL93PThd5XyhW7HFAApyS6krZp2lhzvWMghcSM8TQS70q
 ZcsrALBhe5qukWa5+jAYnYBTBXSvlrFZwixoXNwUeVVmx/GuOFiCgOh1r745G8+Fpe2o
 qp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938600; x=1777543400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5jtxzNslKZuQU5rJrwMQ7igVsUYizcXwn/USYZz0v9g=;
 b=f8xPu08FwtPFCk5e5BHbyjcZzhWw89j2VHJOdy8WjdW3vXsfTWlk/VjcHs6tV1vi3k
 Tk0woQ924Bj8G3ba+U7fJDlKvWm24uROnPNv0hCuNV1Jd9Ape6WzStcwOOH3UnMUeaUW
 /ODJC/3OkGGqIC3FU9H9dwIzxCZd+y9Xu2xky/8WNFZ2M+jI05m9oP+4Q6ITT0z7HSNb
 91C32T5ePracc+uNDfcYZTce0tenqpAzK/UYDV9RYx0wsfk106A2buvlflHUMen3fiW3
 VitavVuygvT9+lcAj8AQsrUJJEjKelEwLu2Npi5VJS4M9J/z0EW+AxLPxyGYsApATztC
 iiNA==
X-Gm-Message-State: AOJu0Yxk0a5LC7zZYCoNJxWi1o+5SN1sp5viFboSjmRoxsDdJyxzES+u
 Cfmwa/Svpkoe8/zKFkbcB4SCXjfMEJfbL2+JQRYTqjQuXHx3ds01yLy1qrY8l1tntGfraHs2qCJ
 /E4WG
X-Gm-Gg: AeBDiesmhz1ZgNseXFFEOKajzBXUQ9frYi/vVefgDVBhCGOylIu37p1blesDZMH+GLd
 l0FVkU0EgrtKXrUy9uwYgq304BnkDIoa7YU6Xe3yF2/dLuMpCqLFjdOEOt/RuYlK17TP611UdOb
 V35Ket8vNKI5DS4vIJ5DSecKxBp+x5dasHja1FbTUtfOfxQv2FHuv+v9svaRQcWdvztBWZawhQP
 zh+D2U2F3aqMZDWN7A3ULykgmQ+fvq1tQhQo+F3i4zpBCQuUImZbtMSrP546GOcYln98iMms85m
 hPmgCLZYuPZUf286xx741AyL5S0Q2LMf44TOZTDTYmlK3mc57nuo2ztMHpuforxPdOlEtOhWFFo
 rarq/1nulfHn1TZGVt+68vXtQKDMkxLAk7Tfz+uW9AmnsMdNJmKneDfU48Z8/++x2KebAEtnKTz
 EJiuDHsdIVQ+XushNeIZFdXe/T7BAVbWV6tb339wWSPGhz0EoMhzllOKQNlBuycZ1m6AqVhxj3n
 sb9eZxj0N63eIOi30Sd4+jg0VBv37SPMv5xgIUBHA==
X-Received: by 2002:a05:6000:2dc6:b0:43d:7512:6f7b with SMTP id
 ffacd0b85a97d-43fe3f35785mr41745799f8f.5.1776938599915; 
 Thu, 23 Apr 2026 03:03:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/59] MAINTAINERS: Remove Marcel Apfelbaum
Date: Thu, 23 Apr 2026 11:02:15 +0100
Message-ID: <20260423100229.2941820-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Marcel Apfelbaum has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-15-peter.maydell@linaro.org
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 065a18986c..48bfa032e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1928,7 +1928,6 @@ X86 Machines
 ------------
 PC
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
@@ -2011,7 +2010,6 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
 R: Zhao Liu <zhao1.liu@intel.com>
@@ -2147,7 +2145,6 @@ F: hw/ipack/
 
 PCI
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/pci/*
 F: hw/misc/pci-testdev.c
-- 
2.43.0


