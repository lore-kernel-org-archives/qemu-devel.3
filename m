Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEFED3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0Zv-00065Q-O1; Tue, 09 Dec 2025 11:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zt-00064Q-6O
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:41 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zm-0001qx-G7
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so50342085e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765297713; x=1765902513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7ZPSr670CbdoKMpCrNfLy9AGJjMvVPEo1SwtHgb68k=;
 b=mwnkcPY2kAZi1zj1p+2EiTVmH/2qriurGzPiFmPAAsD1vyICqmqU1p7oAx+eQBaYal
 LgHrULoxiLfPZRAPPIbjqvuhLgpcYjzIsDlavXKTSoQZrGmtUCkWhvlDa+DtI218kd79
 V0H6OM76mbD0R7GrJVbEpPQing66i37nEOvyBmWZ8PyPrI7tpyhoBrn0A5WwG+E+TnI1
 xvrL9vYH5av/kYf2sFF+HjlqjNptqngwipNCQcFMFjgP4FEJiagKGS4hMHzsFlXocdgO
 07YAtoPBTrw/gE5VvRoXqZnRxvyotmyyDvoEX9/gQtfE9z9M15N1MGw3HebE0Babprw0
 GxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297713; x=1765902513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F7ZPSr670CbdoKMpCrNfLy9AGJjMvVPEo1SwtHgb68k=;
 b=ouw2n8il2kHbo3EryhfBQy7XK8JEjMSmsVFCB25aCHNQ5ivmHAyVQ1RyRu4GNbaq1e
 m89TUEBMD8ssQ7jaGUQgPEgVLAZEWHgJ8T2SCogf9byI8tAD/fPO1/tjm8nmIJjoutrl
 DMQZlBhyO9yfYy9/uwZv9NjEnLOpJWBoI7qBdC+xEkvK9QgXA6H36uxNzSpUdYAX1urM
 GOewvzPpFAfdQKkDIagd0qookaGRP7GejfHFpUu75KG41qEz8DnI4CFRqqX1QoS6b/n6
 5pFPoewbIlw9Ep72j+gF6XLYryqEFV9SUGB4z1J8PuT+HZ7RqhCtgNOesFjnh5Zs/83R
 ua+Q==
X-Gm-Message-State: AOJu0YwPZ0TCNz1q1A4aTSjEcfHoSsO2rSHAfqOws22PX2snuExUhCfm
 rTjKevXgpqj1yIi7iw0MYF9D+8WvXptzFLn/7+SenyO+if3VmYXOXhXBSxfTm1ZMzqs=
X-Gm-Gg: ASbGncutE5xklJ27B2NsSF1BME/0GYjBNj3KRp+cHRw6D+JP4jv0CEYBqjMHW0WpwPN
 LD91weTf2JLoEAbkerxVr2xp2sTvpSRdhmAAsFYQpTOevE9TUdUk15SbRrbo6ZgXdryip9HEG3g
 zqLELiwdg1L+ewlk8IAt87ZAJQwo7fyFDCxfLHcNGb8wgsQrd7bq5iNP/rTiEuMLfmBvMq/xjvN
 z4pmSegc2HGJg9LVrkzFD3dPOOAB7JOMHlUra0tywesSSQMHLsy66K6j/KfiGB2VeFuFY9QaA2c
 DP00+zsQ1JXnb6d6IQAlWbDFwFvzWtQYr2zfG9VZmSF35I1PNPRdFiiD5ijxUpHk7PFMItgGffa
 CjDxt51wputquokJ8IjnkGXyz3CFYWdmhiLYA4smnPdj4NV5ykhI54oNe6lQsk5vD2sWOOhCmei
 uAlS4/1l/Cgk8=
X-Google-Smtp-Source: AGHT+IEwwHplRG4nMNYV1uuk4oBiM8T4QL1h2O8qaFfkORO4IAWJlmo+UStYjGgxfhN3p9Gz8mCiDA==
X-Received: by 2002:a05:600c:350b:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-47939e4039dmr107500245e9.33.1765297712889; 
 Tue, 09 Dec 2025 08:28:32 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331092sm32819187f8f.30.2025.12.09.08.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:28:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 134C85F892;
 Tue, 09 Dec 2025 16:28:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 3/4] target/arm: make HV_EXIT_REASON_CANCELED leave
 hvf_arch_vcpu_exec
Date: Tue,  9 Dec 2025 16:28:28 +0000
Message-ID: <20251209162829.1328559-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209162829.1328559-1-alex.bennee@linaro.org>
References: <20251209162829.1328559-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Without this we can spin tightly in the main HVF dispatch loop and
never release the lock long enough. As a result the HMP never gets to
run and shutting down the system deadlocks.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3228
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251209092459.1058313-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8e2940217a6..8288b605299 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2020,6 +2020,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         break;
     case HV_EXIT_REASON_CANCELED:
         /* we got kicked, no exit to process */
+        ret = -1;
         break;
     default:
         g_assert_not_reached();
-- 
2.47.3


