Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06BDC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZeP-0003F4-FJ; Fri, 18 Sep 2026 10:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZeM-0003Eg-9U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:33:14 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZeK-00010n-SP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:33:14 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso7169155e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741991; x=1790346791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XiDM53/ykS6QcI60fFUTaIdtnIPywKAHlvgyNFnLQMw=;
 b=zV9+1AfneEETGUz/EfZTvDutnWpGnY2Y9QjQ/ZNd+4VO2hF/E8rNcIXkWVOWBc00+K
 ujIGSAiWeyeb0tGlwY3U/jjLVv6pCAi2kJ5Br9TQksiyVT5r+JyGo2r4nyPnNiHMMnna
 J5clN59Vpmb2SoKKyfrtymHl4oXYv1p+N4UbposCkeN8KZVZrb/3CGKP+YGY47CzJc2b
 rvNeeTUJChEk/pJ8nvEz3phLREZYvHSJQXYibScgQZkhDmDYPc1i+xrTN8wj/o/0jPw7
 Dhvu4LTw6FV7gkTWvgAFrGgKKFhUhqYpGpPg56J/eY07z1NTcj/g8lqf1N/vQDQmZYLr
 Xtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741991; x=1790346791;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XiDM53/ykS6QcI60fFUTaIdtnIPywKAHlvgyNFnLQMw=;
 b=Pv8S3UAQPVVDcqSl6ZZS3s86u/v8WDbNiLOqO2Kci72kLuvD+zDbV2vGzp9vUq97Xw
 lp6XyU2fkCn0Csc/CfW72CRtMcri2Lvqy0NK+qMI0BIua9J/PLZRdvoPFpk2thgATJvW
 dLFDVtB8fL296IzjYTcDMV3sVhBjj3nEREmPlMIx5JNYwnVRXt+EZNIhXk5EtZLpSlec
 AHqgQC+vF254E8pmfcF4O3qRYpdVyheEuZ46gYySHkYHjB8xXAJmq6cD7AIfI11QWcZH
 9rfzJLrd/3MNBxVZhmJMhoie2P3NTGyBJSTsGl4VHaz9FDecdY2rZyr4LLvHq2k3GJWM
 SnLw==
X-Gm-Message-State: AFuF++mVRaJThDZzo2M8y3ryoa52p/h7AI9AMtymOnaz867o6kSZBCcd
 gCMUFfkK7SMwPvj0/CwMTsZEC4r4UzL1VNdXLYei4/GPlMdLPX0mnP1FJcnSnvPPxu9LUXdk5eV
 +TfbE
X-Gm-Gg: AYBFou1EkRs9nmMKbLk2aNl574JXcIqIXv8LLlfk8RZjOBfwB5pVN4kvfpFUw6oUaK1
 /AnoJEoAdsS/kZSyNCaNJWeBNd2dw+4CfO7MG6VuJBf0/w1CNoFMhWzorww0A1FAkiSoOiCvVjr
 5xSMGQXByR6/0sOtqTrIiepSuZ+ei5xQLsJ3W/P1TXKm3v9tNGwAS6Tv9MTnWwxD7tujQn3f/Sw
 /orQN66hp1leFQwUIyVnYF7Z8mgPhgS8KmdoO41KR8J9DeukKsWcIhFbhE469rgvc+q9lWHzOHj
 b/Tahz2sht5q0xpSpvnoSaP5lq9pF8RO/u7Z9tWIGA9oSNUpZkJqHMsSB5+Y26MPbcSwJbFeZ1b
 NiO4Z5vk2kcAFd0rro5tZG2LPrUPPNaMqbxV3U6vPVBRfWq5+xR3JRxHloeMpz97Dip7YWczXZI
 j3px+2focGEJwESJeADhE5N1Ra+bGL/cJjhe/NvKHS1ESW9LMBP36TEtPbyRIyfm1QNQjLBVY=
X-Received: by 2002:a05:600c:358a:b0:49c:fa20:cc08 with SMTP id
 5b1f17b1804b1-49fc5741844mr43849115e9.31.1789741991530; 
 Fri, 18 Sep 2026 07:33:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc56aab7csm44241325e9.1.2026.09.18.07.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:33:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B0805FCB8;
 Fri, 18 Sep 2026 15:24:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 15/17] tests/tcg: add console property to docker image custom
 target
Date: Fri, 18 Sep 2026 15:24:26 +0100
Message-ID: <20260918142429.336497-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

According to the meson docs this serialises the target in a special
"console" pool which also disables the buffering of stdout. This helps
avoid the appearance of a massive stall when a docker image is built.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260917165602.3405537-16-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 053ef147df0..95f533b0ab5 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -265,6 +265,7 @@ foreach target, plan: tcg_tests
       endif
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
+                        console: true,
                         output: 'no_output_' + image_name)
       image_targets += {cc_dockerfile: t}
     endif
-- 
2.47.3


