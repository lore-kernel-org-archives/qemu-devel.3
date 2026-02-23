Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D461BEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZMG-0004l3-7f; Mon, 23 Feb 2026 12:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLB-0002pq-Lw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL4-0000QU-Q0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:24 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso3365436f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866195; x=1772470995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cwI7KECXfXNz5KI7P3D4TAbbo3v+8W/zQ7gFbJfb+Z4=;
 b=oEh9X+SZMbhnsOSo/S09eriZbqI2Tv+F6wJIRtRRpdZ0znaIRGa5ulZ8KSYnKlGpbk
 xkCJAIPSdmOyELBvheKN9N1KjiT00YaVG4BwRBzPiKQWUInArZ/4S+KuDqMtL7ROr9aC
 Ys3NoLuzRdFtSamSozVzwkWzkGgVFKl522x5UcVBTBFZeVSsSYrZYPwzyQTB0apu/o8e
 GRC8tkpTJI5/nhBRal0iqJxeXcQ0XVLa4LaWsQEGvQWIc8vbeb99piVmay6rBx8zIZbL
 DjKus3b7eIqiG0dhJLcbbXX57xy0cOnNWVaBGPm+08C83C1FHpjNXphrXTGvYZhoPISJ
 yYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866195; x=1772470995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cwI7KECXfXNz5KI7P3D4TAbbo3v+8W/zQ7gFbJfb+Z4=;
 b=HmvMttV8dE9e26nD1NuESqz7P0YBBJlRbs0+ytyxyd/O9ThXP+yrtvjbFwWFqMkIMc
 my7BhAgFk/YfyhuSacAYWRvnDa0xquwmO/yNus2OaVMYTyuk8hGKi68ZdjWHtN2WI52h
 tpCHavSSEAxZyt1oH8VipsabphOjPB5T4lh3JsYXiec4lhZWmbm16Wx4od9FI96ySeEp
 16sHs44CdsErJ47iD8i+sbXRj5wtoI26tQkIGh5W9Z8kmBP/Xv1mBOp/AavkgjH1DiRM
 jKlmQZ8JFDkOWBQoMRlPwvk7iCJmAfKfpEjdMeWj/vTMfOB3w862Yy1OO7Xzf6k+UTtb
 seeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2azodbkwCA9GR8rzG1FEL/MVhkqmZyKLxPamL2a8ZJva4CJ50Hl/EasYWph8Qtnhj2OgiPeSeekjc@nongnu.org
X-Gm-Message-State: AOJu0YzcB582Ilh21pLPOe64p20BLmvWc6QOwnZncUi2D73Trjl2dOVq
 lVdA9k8CCW0Q4JfrteeoVnPCGerMPzzY68wD1Tn42KiVXpO7SnnR+je4kdbFdrvRc10=
X-Gm-Gg: AZuq6aINQUpC11tyyqYSX356ou9nRvGwTBiozxiExKLAG+0ipRwkRpVepz8B0ScYh2D
 2zDxhfdJl465lqoR/GFeeLYYejUzFiAhWcKn2MpjcA6NsH8qJ5RFnsE0QqgiIOweKjFw8NHFWM9
 D+TCnUe8GYneIX+6UaPVRETpb70ZGvKrz1C7go6WgvKzuWrFjI28w4McPYlUoFiC4l99202OYDO
 8ua0ddL/TJ7kJNTyP3FGw/aO6m1UTOAV9hpm1nHnl+e5q+RFVz/yAKy+QAB5RjcHQlKBKEV/x0g
 PRcEwE0Vgr4xUJ87W9c4idFi6qsTuanh6HoxKIMFJOLxm44g5crtF+ADdUOTWhwRg1BrJS3Sy23
 JFLLsrgHQUiLcASixB26k0CFfIKwtor7ASqzT7DAYtoj32l49S8ISImmpITE6fGn1e7bomiJINn
 COH4aO3LehEI2UKfyJ/u1AC6Fh8/V2yv8myT+2np3YfP0rUGqr660MVgMIhkPMgfFMIdBcCNPgx
 kgZdwJUho1hXPmursQXn8egNwzNy9s=
X-Received: by 2002:a05:600c:1989:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-483a94c99admr175517055e9.9.1771866195261; 
 Mon, 23 Feb 2026 09:03:15 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 55/65] hw/arm/virt: Update error message for bad gic-version
 option
Date: Mon, 23 Feb 2026 17:02:02 +0000
Message-ID: <20260223170212.441276-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

As we added different valid gic-version option settings,
we forgot to update the hint in the error message produced
when the user specifies an invalid value:

$ qemu-system-aarch64 -M virt,help | grep gic-version
  gic-version=<string>   - Set GIC version. Valid values are 2, 3, 4, host and max
$ qemu-system-aarch64 -M virt,gic-version=bang
qemu-system-aarch64: Invalid gic-version value
Valid values are 3, 2, host, max.

Update the error string to match the one we use in the help text
for the option.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 50865e8115..8dc999712c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2971,7 +2971,7 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
         vms->gic_version = VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
+        error_append_hint(errp, "Valid values are 2, 3, 4, host, and max.\n");
     }
 }
 
-- 
2.43.0


