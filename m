Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746D5C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHj0-0006Ji-Jf; Thu, 03 Jul 2025 07:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhR-0001fZ-0h
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhP-00049s-DF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so3113521f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540509; x=1752145309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y41c1z5FO9paKQb2OenF8sh2dtfozLKUoL5o/ucwscI=;
 b=vaCq87MThJ0dNCjb0je+QwwIVvxTcJmrr++G6cYtH0zwpXhjivCY8AxOFNQbYyCi0y
 /Bq5ScpIAbByQggeMgmho2/0n9TNyH7lfbreIqKBUjerzGiyjqco80cn44YgcH0T00Dq
 Vi1/pxazAqLnrXB8fKIE0ydMgZP4Q3Q4i3Hcv5RZjtmZMMFEiZJlBsYS/HIiWJObTCYA
 ovF6FcyvxjJm5h5wvR8JWPrgpmZvftCn+6xLh5l8vCdebqFU87smSAiu4XkT8hipGFdq
 1W/UMDuy3VLWckg5Skt6FtQw7WOAdfwW7DmJvA42veUHbgYLz5mwBdqG2YsAaEB+19tm
 k7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540509; x=1752145309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y41c1z5FO9paKQb2OenF8sh2dtfozLKUoL5o/ucwscI=;
 b=fazoDycXkrgWzpsuTcv0aiIs4ZdHc7ED0hZHbaEUBUQOHgE+mFx4kixprcFyKtsDii
 Zufe1DDMXpfSjuCzH8vOmyw7FoMc/dOnY2vLHOE2SrR4Oybak3/+HbwwGEOlweNHt7wp
 QGwGkOk0VKSRdV0yCV8VIyx+L0TEOrBACFm+oHlGtq5oLIi6rbql0kzH7glquk6zJcFz
 gk79P//aBTjgmsbdnaeG9BZ1EtmgGKNmkkBY4NN3M97P80j9eIjk8yVr51JzSc4+rKGq
 1ke1sqhOJVl3Wcmjm4awlS4F4gEgaxnfPtaO/VcG38Cpn5omSZY2NVDjqkYXV1XWQ2D9
 b2hg==
X-Gm-Message-State: AOJu0YwUq+lVEDYFm1+eJlqANeApzopuOLJ8iixqb9xTlpTxRTG4zF1q
 VGHsLQ2X8P3i7bnkXuaTPPeUpzYZGaTChcpGr+4SyHRfP08fFP297SGILkrMHiMqnSkaH70/hD/
 jse8RI0Y=
X-Gm-Gg: ASbGncvgjU/uzFdBDgdRq1km0HPtWfGqaImZVOBgNulT1/8dsCKwKzGsFqiyvhdVL7f
 41h+cyGU8q6DfSxSSeXD/daFkSM3Fy5FDNQjEVw5kL/tqgiUWK0AZgw7zPHnxNj1pzcNX4awVNm
 ZqjG76LdXEtNcVXsg3uOmuMuGrEN56pzLgNtU6xnE8yW+KtP2WKQ0vdbW0LXyeDKLvCO3rzklHH
 ccsH4qxPrZDqQEcpn3F5ZlYxAqram2Mb5dW1nosQNqJ2JGfWMwJwm5RN9lg3r3p41yeO2h46OEb
 TJzpHnGjE1xjPiWCLulrCgVN3nOrPF8UTrUkjUBmSQq2XUnhVJtw5FDLxVEXSIgPPQ+aeZipD29
 4aJQ28AxtsJcSKDJLQQSOEA==
X-Google-Smtp-Source: AGHT+IGUzOWh1p66nPTXhGYrVXpNdG8Ig9SVmQbFWLOQ0lStUKfhlKtaElol00FmkiaFACVdWBtOjQ==
X-Received: by 2002:a05:6000:2dc3:b0:3a4:f900:21c4 with SMTP id
 ffacd0b85a97d-3b1ff714c02mr5425125f8f.26.1751540508802; 
 Thu, 03 Jul 2025 04:01:48 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a999c632sm23683345e9.23.2025.07.03.04.01.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 69/69] accel/tcg: Unregister the RCU before exiting RR
 thread
Date: Thu,  3 Jul 2025 12:55:35 +0200
Message-ID: <20250703105540.67664-70-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
---
 accel/tcg/tcg-accel-ops-rr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index d976daa7319..0aa4ba393a4 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -313,6 +313,8 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
+    rcu_unregister_thread();
+
     g_assert_not_reached();
 }
 
-- 
2.49.0


