Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AACAC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgPY-0007nB-EJ; Fri, 04 Jul 2025 09:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPN-0007mE-Qg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:24:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPM-0004hc-9Q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:24:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso516117f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635490; x=1752240290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jxrXXZwhgXBbYFwDd3hq6wqnkB16rmWLS1ZEx3ztqps=;
 b=ufov5xSTCN6ZMd0rzI3ajeO5NC+qWxq0QWzYRS7rmDGwYWnW7XdQ7VMzuhuStB6yGy
 yfWImZaj8OX8Vod1AvgB0yi1SllhfvLzcq2WZmrN27GxIA7VaGUwRZMWgZfM6TLhkgCZ
 E0QfTxvJ4TY1FypKNqJi34T6MgaRffk+GKkcQIpx1PHn/VV123o2gOefnxYgrAg8KD6U
 nvhwCY0cgtDBId2rtlJ0YQI8heoF0VU9DTII+72HLoEyVzLkSF1rOxmnl4MQOO6knxqi
 TArm1ZTSWhi+aKtgtcCMyhu2w5egEUDyOINFP0JQEeaN6xOgzZHs0dMO8J2kq83dFzP/
 GRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635490; x=1752240290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxrXXZwhgXBbYFwDd3hq6wqnkB16rmWLS1ZEx3ztqps=;
 b=pZYxL/q5TvHICPe2UI/WXyk/w2lsyAy8OBhm0TfHUyWCTkEgBq1CE/co5FQNaywerS
 M3gKz3385buMHj8SXFwssZQp7yOC94M4eNZnPRI0y6bp0JeVtCm10Vc7C814cCEawKGG
 0CL04J6sqfz2GLfoRSABxWfRA/e1fvvauYgAuqbnRjjnDSNJ+9S/e2NUAhmdixt190ND
 LC648nl07JwhdyezTwUwqQu13H27ij8q+ZH9uoxKQn/g1u0PvTOzJgOvIMotqbKCDwJO
 BkBROmHEdOFkfmDzWR+slANbVsGzqunrLoDi4G3W6FwfipKPCR4PwCSDKWEDN69Sw+SF
 /oXA==
X-Gm-Message-State: AOJu0YyJKNpyoAiJGl0VT7KrxTO49RWXOsf5puwsTIJQWkbdvw4f49PO
 tzjyqiq0TGE+aMFTpm5p4xE6WyoK2kDjkZt0GZz/OJfESj8x7VaHRX/0hV/6dxPHl6QbE1eMDGq
 uS3kL
X-Gm-Gg: ASbGncvoPgMtCH+bbK3BZet4e4LVJ2LXNgJx0w1SKfUM0VUnzHuu1k2yGRPzqqvpaS6
 7qX7tY9/dgK8SpmFmcatm2ZIeAQTWnhddp5P8gb98ywg4O+b8lG1vrvhDCr5T/H8YrWBSx83LHr
 3eYMxpitCmBgSAmcFP4cLEbDLnpfOQ4GP/T/uHp49hiLcfv/27tRAoowWIl+zan3iPB16wbn56m
 A3IORSs5ZDz4i60DhhjDu2d2fyYEica8bobSguPBTPWYW9ab9eA6DfKywfAJm9nKJCJLbmSSpn3
 5BUyuGPRZkR8N9g/oKYK0GeluYCrwSwWLbqXFTAPlnSAJeb+LWBrX8aPXG7pcZMN7wCAYVn/K1k
 pdtbFqJPXM36EzrFaDIup4uKy1P4DEP1+z9boO8XwKg==
X-Google-Smtp-Source: AGHT+IEsZToCxVBhetd95mMsQ+BO0olb5y9JOzBwV+GQyi1sK3FKshjHYohcLOx/2Iz2HDrMtc0rEQ==
X-Received: by 2002:a5d:5f47:0:b0:3a5:232c:6976 with SMTP id
 ffacd0b85a97d-3b4965ff9a0mr2485421f8f.44.1751635490236; 
 Fri, 04 Jul 2025 06:24:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0941sm2473309f8f.26.2025.07.04.06.24.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 06:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/36] accel/tcg: Unregister the RCU before exiting RR thread
Date: Fri,  4 Jul 2025 15:24:35 +0200
Message-ID: <20250704132439.25743-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704132439.25743-1-philmd@linaro.org>
References: <20250704132439.25743-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Although unreachable, still unregister the RCU before exiting
the thread, as documented in "qemu/rcu.h":

 /*
  * Important !
  *
  * Each thread containing read-side critical sections must be registered
  * with rcu_register_thread() before calling rcu_read_lock().
  * rcu_unregister_thread() should be called before the thread exits.
  */

Unregister the RCU to be on par with what is done for other
accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250702185332.43650-66-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee9..a578698d071 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -302,6 +302,8 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
+    rcu_unregister_thread();
+
     g_assert_not_reached();
 }
 
-- 
2.49.0


