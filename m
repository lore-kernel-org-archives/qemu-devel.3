Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A15C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8c9-00062M-4R; Thu, 22 Feb 2024 07:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8br-0005zA-KF
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8bp-0004kf-7n
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:31 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41272d42207so17108825e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606526; x=1709211326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTbUaEgNgo7IbUetOjGywYbHIYWFMzt0Rp2Y/fJHQw4=;
 b=fFek2Rt8y+7XcwctElbLG9CYv1Rz+85hP4Ev8syfC6g9XZjNm4wu8/9sRizbWHuF56
 b4qd3UD6J2jK/Afi6p5SFpaqhNtCMSiCp8LN9OP4pJRHG4OBUuo4+zrecnY6EKIcv8Dt
 zcIpoySsCpfh1D6pH8W2NuQ+zobvKbvlQQpaH+9E7kYMwUyhs9oSl0pW8Oaey5bhjRJG
 jHmjaZuN5FsmYkCXrhvg9T4vNQXjm8hELlvBEJZe9YnsdInyjjG9tLE5UopdP2S85Ung
 747ldvVdQYZVsS1i9iaXx4iAoYUd4BjKAPUaO3FahjmndFygfCqGTIc2nlLCXcu45nUA
 x/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606526; x=1709211326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTbUaEgNgo7IbUetOjGywYbHIYWFMzt0Rp2Y/fJHQw4=;
 b=UJ0naUXyLwIDo9CZk+7IaJ8Go1ZKJ1TqxwHf9AQhMkanef2OgKDc3YEB3Fynn+xITA
 /ptv2lE8nHouQ2Uwc35GO0KFKrCEgho85j3LrJg096cT3fnRkNLjE1QAU5m0EEVWYhyj
 0agtBndRbGh5aKj/Cfnf2SkAJZTR0Q5xhhX31Qo4ifGl53tznzzDeQKUgJkFfq60wh1W
 bL6xX2H4FEPoyagnWN9X8FtBGdkZtYsaFkmuVCla9IKANzxxSCMdp1BZ9IdbRdvdT+0X
 EpXgQDSNzv8F426ihHzD/McU1iYD2qOQ+l9X+qGutvn4hqI6sU9J5ZCHH36aHX9x9YeY
 tvWw==
X-Gm-Message-State: AOJu0YwV7z7eIow4MgAxTwciSyrptdJDuhZQNnvX8GmHDMPoYmSnZ0DS
 zgEEiXZpUaSd6WpGgbUtvTZJcWPe702osRXQkTEpQMtCeAn0AdI3iz/ATz9qz8nEFFbaC/HFlja
 TRxA=
X-Google-Smtp-Source: AGHT+IFtGpBQrARRZrh3r1XK8iu0kE0NzdHHhD5g06uuJXMG6OjH6dlHz3bOi77bGh2kRiHkzzog2w==
X-Received: by 2002:a05:600c:21d8:b0:411:e398:ca7a with SMTP id
 x24-20020a05600c21d800b00411e398ca7amr16491946wmj.39.1708606526348; 
 Thu, 22 Feb 2024 04:55:26 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a5d59c1000000b0033d9c5c5557sm944138wry.15.2024.02.22.04.55.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:55:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 07/32] hw/ppc/spapr_cpu: Use qdev_is_realized() instead of QOM
 API
Date: Thu, 22 Feb 2024 13:55:09 +0100
Message-ID: <20240222125517.67131-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240216110313.17039-4-philmd@linaro.org>
---
 hw/ppc/spapr_cpu_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 0c0fb3f1b0..40b7c52f7f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -245,8 +245,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
              * spapr_cpu_core_realize(), make sure we only unrealize
              * vCPUs that have already been realized.
              */
-            if (object_property_get_bool(OBJECT(sc->threads[i]), "realized",
-                                         &error_abort)) {
+            if (qdev_is_realized(DEVICE(sc->threads[i]))) {
                 spapr_unrealize_vcpu(sc->threads[i], sc);
             }
             spapr_delete_vcpu(sc->threads[i]);
-- 
2.41.0


