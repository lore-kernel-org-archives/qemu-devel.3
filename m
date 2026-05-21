Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EE6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Hj-000452-P4; Thu, 21 May 2026 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hh-00041v-2R
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hc-0008VW-As
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso6616945e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369469; x=1779974269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ii74m1gv5tKs9ZgZ3mpQX8nD5rvzAOIu4S9FRD6AHTA=;
 b=tu/6uN4pvOD7uc5JPCAaer0pRAkT09uVMBXYvXjjxXQpC9Mss3wGe0bfZeg30fX3CK
 KUSv25fwxDBKCXr++efmiJeHI1bbuRJcV2ixV2aaFZmGrXG48eiaLvyOTbBDh+kS+1oT
 IMK+rXXdLcV2sxDe959a0KoMKMj5N2VTemibS3aXbCvxxW/mi93hKOb2I1oHCewa8+yu
 o7X/st9Doa0SvBDXwiIaYLuZhgL5ijJ674e85RMrXeg/3avDo4EhwZantFsCmVs4hQv0
 z/2Bg5tM96kbiujyXyc/D0fV6ecRWd+8urvWZfER2/ngyTZ60Gek22EkumoZxGqbPkfS
 aLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369469; x=1779974269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ii74m1gv5tKs9ZgZ3mpQX8nD5rvzAOIu4S9FRD6AHTA=;
 b=Ygm2mbndlGI+fRtC9uOd94sl2057EeIP5zvawMnA5sfGcgeH6udu6B1LCaeXwTfJxF
 Ey6cuY2AQ7hkQc10/YcKe3MaH0jdqVMSetbZt0tPoBU2Z1K2XnfoO3tcSHxiQyxVRMdF
 IucqQAuONVfNyFzdwgCq4UpncS9esMhE1RCPIXLtXAYl6mlgcdfwsAyanwbei0hQmfB2
 GrRVx+wfgAUE9AJ7WJyKku2nyQKJ+mxE1a6oeEGiSU3Y1XSt/vkJZHEu8/oUDUH+6kgH
 FMqGhkfCpmxFqzTT7Kwrn8n0mRfCEMB38zzoTCGtRQI2Pwz3IB9/bffNR21mS/PKPQ6q
 Uygw==
X-Gm-Message-State: AOJu0Yzuop4l+cDdIntrgv5U51wu3CsAyvnoDymUhdeyxGgonLZIUBQU
 Wukhdg1BedLAAxkPrRJFKgO/jxsGW7lv74wD/9HB9t3S4kxVYiBIQEHookweRhm61ik=
X-Gm-Gg: Acq92OFIRBMqnDAmwup2PoPOVpJCAUxyKpbrxQuPIxla/3XGTSWjsbEHBowvd070Vo0
 ExbWYLYrdxk/Ti+ICY0pTpy1OdG7Rw6+/Z9qc0iUp4ocollr96FuXA0uTyVLZmm1WtxJ7tQn54N
 vFSfV13oMfqFTP6RS8oucg7H0pl/kZrVJEiywcQYuMJ4pSZWubyb3XTDJ+9t0zig6xbA2l2UXxN
 JmSPtsAd1OADWfKYJ93wjeebVXbs7K8BnwQYgQzrXA7TDDspm9IA38AOBTe09Bxdf3o1E/vQQCD
 phN9EED54UTV6wI/5rG8BT9JZ6yxPWFyHr4PI40rxAvr80Ju6ff5Vif+QpW4/z0wgas8EWTGWAN
 rJ14d0fVbv5nCCW3V4gRJNzLNpurY9NzHpMCihD8QJ4w5YsMIv4WQMGSvryzCEjpOozR0rctoCS
 HTeT1HjkwHVo0VmJzgcnf7ApGdEyx2ThSArg==
X-Received: by 2002:a05:600c:470d:b0:490:3df8:65cb with SMTP id
 5b1f17b1804b1-4903df866bfmr9684975e9.18.1779369469436; 
 Thu, 21 May 2026 06:17:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d44d7dsm73273925e9.5.2026.05.21.06.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D8C560B36;
 Thu, 21 May 2026 14:17:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 11/16] MAINTAINERS: Cover debian-loongarch-cross.docker
 with LoongArch section
Date: Thu, 21 May 2026 14:17:33 +0100
Message-ID: <20260521131739.540157-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fadf2cfcc7..03ec57efe75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -280,6 +280,7 @@ LoongArch TCG CPUs
 M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
+F: tests/docker/dockerfiles/debian-loongarch-cross.docker
 F: tests/tcg/loongarch64/
 F: tests/functional/loongarch64/meson.build
 F: tests/functional/loongarch64/test_virt.py
-- 
2.47.3


