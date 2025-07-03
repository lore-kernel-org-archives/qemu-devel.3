Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8440BC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiu-0005o2-O8; Thu, 03 Jul 2025 07:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhO-0001cg-5R
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhJ-00048B-4A
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso6180695e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540503; x=1752145303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYnKEElTC5IwOmZPbnF1VDHeVLYo+K3YiqWHHRzMLu0=;
 b=hxca4lK1eAnUW+RxMmZk3D82uIEp8GGaqbnJnjrbDVhNGsa0/72slMoWCzYimJ2FqF
 InwcELgN4EJ3AE1buMx+0POONPc8kGG9oek7enSo2rjpXsXx5rHaPxaxJH2j1zjdFcn1
 RS+MG58EYvuGMyeYwomtue8vEht7RU8QLUTEKn395Qf4oPb+Hms3yDGrAMU4nW81tIuW
 UAOel05WAxF/8pluJuaKMntYSq9KjWg+dt2vem+tHdJY7VRSyM/XuYwH+h9/6okp7nIC
 jpYymiVA+9M1RBfQ0sleKtqGjsl2M2nbGBxDKC/aV595BeBYajCdDH0euNC0NiTLhLgv
 lopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540503; x=1752145303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYnKEElTC5IwOmZPbnF1VDHeVLYo+K3YiqWHHRzMLu0=;
 b=S8lPdvka5HCIQKP3n/0DCYA780s7ZEXvHRwpFOlDINp7DYHjyV2aG9jha+gKH5neTs
 UfbsUaZeU7ZeXlv1ACBtEhCrWp2G9YfOVjSW4uPE/fPsH3foJmeBQK37VOGPs31NnStx
 nicKh+0K3kow9Iw6vzy3kUPOGUmob12nwad1VrkT7g4ZncxNDkfvDmGHf0Hi2uhdgaY+
 nt+xuIVRoPN74x3IK1AWNVTtt4MSjm9/srDrjngpyB5VgHDqVUjmxS6GB77Y5N0+d3ql
 aPdkGT2Mk4gj5OoFmRDrrQzl/tMpZ+swIp80CluOmoEmKvjKEsNSSOLhqXr7wGq/y3Pk
 OjsQ==
X-Gm-Message-State: AOJu0YzLIGIcVt3A2Uf09uhV4DXRdZDxk9zM9ssOUDEg7EHXPtxpV8XR
 xNL8BYxaeRieXQAlESBPON5X3XzkmEK/91SKIfBvkLY+FVwHVsGLB7VJD2E/UCnYMPkIhzBkAqk
 5q19YFZg=
X-Gm-Gg: ASbGnctvpBcuXqn96q8IjZVzIi+n8uw6CP/bLQk5RDYC+7FpGjuhpvMTjFkLrwApROa
 bhphFjpjCXDvbK940ZmxgEFRvCicdnQBKrOELjwyNzaS8JoIEa2HodPlGlhxlDR9RN/rxT6i4fz
 /5YbpmvrXHKx7EtL7fhj/W6l0/Ok6F66iJ1ANzixlmWyDPxFN3f1RyEhzp9EXi6tUYxHZnmcWof
 CsTZ9KOBE9I6vaw8ow2Qt4babt3Lsq+G6MwplLccxlnj10WNrZd0s79jmVwloWfm2pdeM/ZxOdM
 57YJX02F1k0qgFnfPXSy4Wj+5Av9PWAiU7LBIRZ1FdevWsD0OQ5sjocIrIMU6hCyuRsRmlWjzTe
 hQITK1ZzN+18=
X-Google-Smtp-Source: AGHT+IFdCajdFy7GoXw0aUuDzxPHqkPrhDSt0yuUGVOtUqyp9f38GDPXrJ+aNvB1mENvYSYuw0+u+Q==
X-Received: by 2002:a05:600c:3f10:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-454ab34622dmr22700395e9.10.1751540502931; 
 Thu, 03 Jul 2025 04:01:42 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde3b9sm23907695e9.28.2025.07.03.04.01.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 68/69] accel/tcg: Clear exit_request once in tcg_cpu_exec()
Date: Thu,  3 Jul 2025 12:55:34 +0200
Message-ID: <20250703105540.67664-69-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 1 -
 accel/tcg/tcg-accel-ops.c       | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 6f2a992efad..543c4effa0e 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -112,7 +112,6 @@ void *mttcg_cpu_thread_routine(void *arg)
             }
         }
 
-        qatomic_set_mb(&cpu->exit_request, 0);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6823f31d8ad..c5784f420f0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -96,6 +96,9 @@ int tcg_cpu_exec(CPUState *cpu)
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
+
+    qatomic_set_mb(&cpu->exit_request, 0);
+
     return ret;
 }
 
-- 
2.49.0


