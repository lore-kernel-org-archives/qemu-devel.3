Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3DAC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJYV-0007Wb-PE; Tue, 06 May 2025 10:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVH-0001ic-EQ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVF-00028i-Js
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso25466545e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542556; x=1747147356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tQhWRsmeRZhJEPaGeSywzZPRJRyw52wiAKMOIfW054U=;
 b=SheFN0zYy97rk3X6MGdBhz5hoHj/uhx6wvV/9votxJMwdmEcMnKPaI+L6yF5FmNKjp
 y3f3f9o5WpciAn2GD5GvRmhSVCOQD/3LW9hC0Xt2qUdV1r6KTjfbwM9+2MstwCpBpiDt
 IDLYtdabysGBfDnpdwi+f8/MPX88Lh78/zMY/U+i+FbxJVRmSskS16hN8M8olknN/vGn
 APu+gaQwEpxc9W0UQVplXs3I7g0dpjqqdUVbKe2FzR/CNL7RyAyXZXFUHf/12dSXmSdM
 ibXIGLxgLaZfaDJ0GRK6KxWtnFa7/mTNgYDkRHWkKqYGVoktnKtbShIr+Ep20/3kj4+4
 6tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542556; x=1747147356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQhWRsmeRZhJEPaGeSywzZPRJRyw52wiAKMOIfW054U=;
 b=rK+SE+rJ4uSzd+mlLQfiwAysGtMfDWx7W0WNT1ha0RrAqJwY7X3XtHLud7lT80Sgs3
 G3EijdVD9+BbSXa59IfgOUuBdf5+SErwVPkHSQn61CcFvkVy3Eup4peetra2mI4+lQZz
 DtHaURFvLZZmiOt2DOXfUYnDyfcx2vo2wH/Qq+oYSsenh0bv+tzh4HQ2ZpXJSz+B1wOH
 k416KTZAGEep8C0W3wjJqJL9SZNlbKewJlnt9DQEaPELq8URqCwbMmOc3DQ1K7dGjhDB
 BpCmLEsKO9BXof/NtQXaXUfbu6giM4eRS4MX12Nkvs3vpzB0G7Ak40uEvuozdPRlOI5v
 akIA==
X-Gm-Message-State: AOJu0YwKsYPQezUU01JYs8Lqy5UtW6Ic4FmCGvZpYaLEMrpAWEnnygtn
 rEgZ3mAiqNftmuxJoPhUBaoi0iz2kYEqI2dYWiFOohQDuCZlu3KVOl9q5FFUhFoS6bd60LvrXjt
 g
X-Gm-Gg: ASbGncu0+08J+BpR94wPoDN6MjPGVruQ4mGWfMF9ZGHyCR5Thje0j3ZoRhXtn1SsHUN
 nNK56KA/6CYM1JJo4rLY4oEaPxiFqMxiRn0pbUQ1wQoohD9eBzWlTNfpWQl9yyd/xKI2yEOS4hN
 38RycofnD6nv2TPAp0BfkgFEBUV2HaGMf/wTYMRK3JjG9/UhlK66FeA+Z8ldZ/gqMVGW/7pfpI2
 rG/KFtMs9N6f3ReyCPeLO1d6idETUvGjqgSCgrcz3cMnsWWZYy5vueMujvaWm34yuz0nLwGvzFs
 qo9JRtHvPDR2dhG1e1AoKF6DbkhT1vr8xJ94FcGFBeDCV20=
X-Google-Smtp-Source: AGHT+IFavq25gzeD1IzK6if0lL9JUOXD9y8pm9Y2nZINZifJ4JaKC5b9v9i0xkuOxEeQkZ+GiYaGAw==
X-Received: by 2002:a05:600c:3e05:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-441c49486cbmr84203585e9.32.1746542555916; 
 Tue, 06 May 2025 07:42:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/32] hw/arm/virt: Remove deprecated virt-2.11 machine
Date: Tue,  6 May 2025 15:41:59 +0100
Message-ID: <20250506144214.1221450-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6e10b2b0857..4b21f3226f9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3601,13 +3601,3 @@ static void virt_machine_2_12_options(MachineClass *mc)
     mc->max_cpus = 255;
 }
 DEFINE_VIRT_MACHINE(2, 12)
-
-static void virt_machine_2_11_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_12_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    vmc->smbios_old_sys_ver = true;
-}
-DEFINE_VIRT_MACHINE(2, 11)
-- 
2.43.0


