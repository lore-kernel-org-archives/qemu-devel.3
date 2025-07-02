Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2FDC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2c-0000AP-Sl; Wed, 02 Jul 2025 06:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2Y-00005S-QC
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2R-0002pa-Jp
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so46926735e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453401; x=1752058201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LuknGbyHpYfn5Myg53J+fZFSmGacyw10WuAzgbETa8=;
 b=TWyTxuMd+pU7NDqN/CTIVl8wbnKKKilkIV2ofSGDGsIlkepgParw3t4walqVj5Fb+c
 TKLvXjsbdchtSUjYK1P6uuWvJB0wA8jxNVx599vHJtN11hfaJneHw8bKgh5v7mst2XEF
 A+WW8DK2+DigtKH+iaFo4phcUMppsAVXQaLwkKvmzidyp/fKRIyIdpry4e7H0aXaHeWK
 QavUZ0G7EibswXBOCL2k2QAi4VFlCpvl1+kxMxReOQAahkIHHt8+1WbmKudQmAg9U1L9
 Oe/MEWgRYfng3KPZdKIPICDM5ceqwH9NapHLDbgtVZxSQqq+ul1mA/sOyVPe5eOe8kVi
 3uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453401; x=1752058201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LuknGbyHpYfn5Myg53J+fZFSmGacyw10WuAzgbETa8=;
 b=q7eRcnJ05L7df+O0chZ9NC47aMJlE11YuAnHl7f8ky4LYU495xwRRhTDUtvpWUkYSb
 i/ZHXKr3FPRHPev9CS1xJIqBQ1vE4mxpHaA9NXCxe1kcwkm62u9K+1G9bp/NgUCnm9qt
 Ku9QEq7UM4UQmOsATQ/xFbDungSssS2o7xuZn3tW6uXLYCctd/nHAPCJ4cw8OfQePgAC
 VTm8EPtpxiRt9/O3vMpkPN1abL//HVeRIUWF7mh8DO2A+IVF1z6bDTxQ6u/AD7y217hJ
 lPvNR85YGxHfVnD9M3tfr/emG+sMccHEjkoVRJISOVcReMqR/gKKYYLsPEvLbe/n7+7O
 +NNw==
X-Gm-Message-State: AOJu0YxHVpgkPQLZ/SLzW9bfthSxxzbmaZCU1uwtcAI47em7xGZYEN8p
 EKh+aWw6ygWaxwOtaB5NT8+bqt3pcisr/OVQD7u25oyb/8Jkxq79FRobkpg3ugeyjtc=
X-Gm-Gg: ASbGncu+/FA80Lt0mfMIInkLJ3s4jaSmoqGKZS2tHv0pNEwSYzIAa9nnps1dditigRH
 P7ODv8v7orbOARZBrjB34CL71Qbnu79onNenqh08iUgVhqKrV+6PSzH6HtwI/Z7a5BEa1KUmM+h
 kGMoBzlzRq1eA7rHU2AW+PAeotBrpkQp0Ov4u6SnpdbJK7YuJUain2rS8vm/Fkn5G0nMuiKpQgE
 vAyemV9OMDGLS3V1XkjbHdB4wt+Z5XG2E6iE1UuRdX+Se/2wIp1thnorSH/1DTbg6f4Du8ZGW9n
 N9yZz3ErrIpCpk98PZ7hqAd+SmCa+eyi+yjNL0YcZFczBMvZU9aIxRcLzCiKmu8=
X-Google-Smtp-Source: AGHT+IEsjrWtmcCnvAD5zctHpHTklmnGzvRgDlBJdn66TZJxZrpgpJ4wgn0i2dC/SobHEHoMGkvjeQ==
X-Received: by 2002:a05:600c:8b10:b0:453:7713:476c with SMTP id
 5b1f17b1804b1-454a3c17edfmr20859765e9.2.1751453401606; 
 Wed, 02 Jul 2025 03:50:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fe587sm198289805e9.19.2025.07.02.03.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:49:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2729D5F8D8;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 04/15] semihosting/uaccess: Compile once
Date: Wed,  2 Jul 2025 11:49:44 +0100
Message-ID: <20250702104955.3778269-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, TVD_SPACE_RATIO=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250526095213.14113-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-5-alex.bennee@linaro.org>

diff --git a/semihosting/meson.build b/semihosting/meson.build
index f3d38dda91..b1ab2506c6 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -3,15 +3,12 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'syscalls.c',
 ))
 
-specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'uaccess.c',
-))
-
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
 system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
+  'uaccess.c',
 ), if_false: files(
   'stubs-system.c',
 ))
-- 
2.47.2


