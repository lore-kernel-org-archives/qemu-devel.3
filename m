Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79AFCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJV-0005IG-CN; Tue, 21 Oct 2025 16:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJN-00050L-1e
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJK-0001YB-To
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so1608455e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079823; x=1761684623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7pVRvMSa1tuaaAjaeaWzWN+zOC+X4LPSLmio2TfrgMc=;
 b=ipqBQ3kmZQowuKpufkNmaLR1GyOb5l9g8tAIRPbFbFadqqHasfLpLFKGMWwTRJIE2N
 4jO6wbfehnW2O6Z+6sdFQVfi2TDx6g/9mhsAJvQbWJja2C39NeowvS3UBVCepzfL5Vte
 JcKwUbhaWo7kuLsh2rGubr2GnI80mOch3XtBPWnq15e8mRhmJh6BK8ZLiKWqgoDAGQQn
 9zsasFAaFOwpD4zura618Gs7d+qM8jqMaeelSwxG+56JrlUPmGCQYzB5Cw6bkYRUAzR/
 MM31kCfjPJbjgiAH0ptG8M722cUWNefC5IHtJJrtUhqYXVib8L2vyla/727TTdTG2UAs
 FuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079823; x=1761684623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pVRvMSa1tuaaAjaeaWzWN+zOC+X4LPSLmio2TfrgMc=;
 b=MlUOpBTP8xdwwfK9n8j1fNQ8vjaI/MWulC3eEuE2QdbmGYwZjMH0O1rN5TJGk3cIKH
 Mu2saFaZIxRtNwxp4fLWw3AzOzH5dN8KgOpwjmflHUbUX4ZhKbc45RDKfKyCRP3PhdjI
 6aW+O+2xLHRm1TI6LB91Lo6l3QvYfcOY9NeaPCPVbS86kzy/U9O9ojdmfTLzaI4IGBwD
 GagblDRfOYSogu2vAE2Xd2RvoiRI/EmHOE+zE6QngBFK4DC5TpRMVWMA8SrjjnELSiwr
 mm67PtASveQ1oCikgvqJXesXP7dyZtP9aj+nAMMqU6xSvkmnC0qhAdWD9ntKMrHUNI/l
 XwZA==
X-Gm-Message-State: AOJu0YyRwxRz+YW9wOIECYFKAz2pnm6u3/MaNsT2nwOfieO2/+Y7QoC/
 G7hDNZ7GmANTKNp8MDkNLC4bVHq2U8jev3G7BqQd0K0YVSvN0gy0pg73iSTad9mK8TLWPSgLfaK
 hNm15cbg=
X-Gm-Gg: ASbGncvvap4AXtWaALK88AXEyO887s6hEILwXXU0eUzL25VZ2FUx/DG5kV92XOA3oE2
 vcoGHlqJlnLCgQYvcLZIS7Eot3Zw7sULFo+gxVXdtAlg7VDJFhFCYkMWmBRPoV7J3gEnfLewU3R
 FDGtF+PaufwHy8KLy75+4iOemBl6QGU+6iFV+srMsK2Rvu4iMlOzoS6DXJgOS5zx41QLqDM/JfS
 f+tbWeQlX8kS162bhc1IQ+uUf4mBTIvHyAEQ/WAjIxMYDwTI9YPoMUBoIVwi9arOcw0Kg+Ta8Xd
 HeKvl2HSqiKd38t05mm1txLw9WwJQlANBz5wy+pcaSldguH+B7m+hIC6MDMsNK5DrGM7B2au/eP
 rAQClC7Gx3GZ9JPZT85xkbl/dq3XmjdHw1+IVu7ZQbhpZtUxXqI0mXilXlfqKQ+pSH9FddgslQU
 /7d+J/hay3yROwYndsLwq9Dxdk2CBS+ZONLuaMo+KejULqr68bB91nDcgGdFtd9kGxLpkVlOc=
X-Google-Smtp-Source: AGHT+IFd0IRuX6vS1KrZzAvST7/oqk+CE27Cqtt+XJEK1kuXJXXvseHWKqKzwkkqV2mZ01cWzYS3aQ==
X-Received: by 2002:a05:600c:3505:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-475c3fcb2fbmr7419785e9.11.1761079823360; 
 Tue, 21 Oct 2025 13:50:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494b02475sm24819605e9.4.2025.10.21.13.50.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:50:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/45] MAINTAINERS: Add missing machine name in the Alpha
 section
Date: Tue, 21 Oct 2025 22:46:57 +0200
Message-ID: <20251021204700.56072-44-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Thomas Huth <thuth@redhat.com>

Without a machine name here, get_maintainers.pl uses the "-----..."
separator for describing what the maintainer is taking care of:

 $ scripts/get_maintainer.pl -f hw/alpha/dp264.c
 Richard Henderson <richard.henderson@linaro.org> (maintainer:--------------)
 qemu-devel@nongnu.org (open list:All patches CC here)

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251020140425.45003-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 667acd933c7..d4e7fd965b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -671,6 +671,7 @@ F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
 
 Alpha Machines
 --------------
+Clipper
 M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
 F: hw/alpha/
-- 
2.51.0


