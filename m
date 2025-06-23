Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4481C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg8k-0001CH-6W; Mon, 23 Jun 2025 08:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8e-0001B0-Lq
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:04 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8c-0000Qp-Qi
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so1700116f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681138; x=1751285938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33tTruwtHJUDsLE1NQEO6k6TPJwHdavbHWnexaTt8VY=;
 b=Ev26ZtJKAnfkdhhRupkf9cmjH5yX27jKjx5+6zAcw06BZG8aqAPUcuapGZTCydGd7/
 J+BkDBFDqq/3fzA9ZZsZfAnCtpil/CGgZgHNCSmEUL0czXq+XBW4tKf4YCGwvWlX7pLe
 tHDnP/BQ6iqyqx9RzuAO/xTd9a3m4CKNw5oWsFc3Zq6bQifnmMnXGZSwjEfsLZVk1gOW
 ZB/kGx5u5x/Rih0p+mkGm0ycZ5xSWAMqPRUlcGgcNk9xuS0QGfseQSAHlNycaS8ex8f9
 3QJcdVWq/2b8zxQjBTNAcVZ2HrpnmtCZg1vMUaPObepmKtTsUAMJwHDMuWg5AiNprfH0
 HTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681138; x=1751285938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33tTruwtHJUDsLE1NQEO6k6TPJwHdavbHWnexaTt8VY=;
 b=eOPjyQPGjkEf++MeY+abJqcCAIhDWHK2ol4VMlKJei9AKI7PEP4D+cqr9aNRXUBlrO
 pgQAt2CYZQS/6bQtjYbexuNGZmx2q0v2scEloY88MCt0/cuI2k/QmWV2vS1dGaPsEalY
 zLuFe3yWvZ3VBGq8pxiV0a9dnDkSGR2eLMNW4IoXvm/ectkRWyyrZ0giR9c+AFc9cUvQ
 NEDH/rgSt/dDuaLWkszbb9mv9RA0BGvrqZ8qVY41T7TmDBEC3qcvYRINLnu7XQSN7qbm
 KXsEBV2iUSMMOsCV8YGs0xWA+ERvxkxybiDp9mmrxHnj6PS/LzSQBHaNy62a2j9TbdMX
 m2jw==
X-Gm-Message-State: AOJu0YzoW9RgT7IyRSsrSyQGC0muJUqwjFXy516aCQJQAElsu5QqfMOJ
 Umjbu6DtjiESKLzj1i2nKRud+6Dx8DZbHI/H8uR6vgMDzLzTSOQsVtwy+xMQ1jTyYGXJ90C0ppM
 rgHGC
X-Gm-Gg: ASbGncsFagQ7Ovfk5x+TDpSD+5Fc+jZW7o87jfBXxeyEZjoRPgHYAo5NtsML2E0LwLH
 LM5s/ULFR2IrWdnmvDrkhaqcYEho5+IGkvpvNge46zRgKUqdJwKi+Mb+umQQpVExxPEGA9VCoyR
 rh/7q4S8KQ1i/HU8Dt8+DCFhHHmu+PLjLt2/ZdSWklvEnWPnUH/PpCjm07TQJEhqGu2tOmUZZkc
 q2NpUD/fhwhql9AenWNJnoILqpUIIo14mIkX3vqQXBf+ydOuiYJ7OclJSb2WLKDEi3e0j53944r
 zDUbGjxiVmaOGYyZQQ3qbg6FU9NLBW0QLxivzD7gKdXC0y7L+OpnCHb1mHeNttQijZrfaZ9TtBX
 fNkJoJCav4pmg8y/zwXUJm2JH0Jo5oOb8UBoit58nfdEIaeQ=
X-Google-Smtp-Source: AGHT+IEjVwbsAMNAS5by9E9W3i2mS1agngW0TG97TbFd4Y+XoqUdKx/v5toxL2DXWSaOw2EUWfZl2A==
X-Received: by 2002:a05:6000:471e:b0:3a4:dfc2:bb60 with SMTP id
 ffacd0b85a97d-3a6d12a9a5amr7627210f8f.26.1750681138080; 
 Mon, 23 Jun 2025 05:18:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d118a1f2sm9166243f8f.83.2025.06.23.05.18.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:18:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 02/26] target/arm: Reduce arm_cpu_post_init() declaration
 scope
Date: Mon, 23 Jun 2025 14:18:21 +0200
Message-ID: <20250623121845.7214-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

arm_cpu_post_init() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 2 --
 target/arm/cpu.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 302c24e2324..c31f69912b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1150,8 +1150,6 @@ void arm_gt_sel2vtimer_cb(void *opaque);
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
-void arm_cpu_post_init(Object *obj);
-
 #define ARM_AFF0_SHIFT 0
 #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
 #define ARM_AFF1_SHIFT 8
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e025e241eda..eb0639de719 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1713,7 +1713,7 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
     }
 }
 
-void arm_cpu_post_init(Object *obj)
+static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-- 
2.49.0


