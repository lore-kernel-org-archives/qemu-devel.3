Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6751E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFg-0001re-Af; Thu, 19 Dec 2024 11:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcz-0004qW-Uq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:53 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcy-0004Yr-Kl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso6828635e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622791; x=1735227591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upFpBaO8cptavFRp1HZ7mKtcy+0BbSMhQQtCEJtj5Yg=;
 b=W4S47rPQjwyXvMsCuO1l1H7SSANpv3E3UMfbtLNCKIp5XtnmbeENAQuFLbh+wTZjw3
 /Biuh/CzGZ/BtRdmodlsVsI4rE5qliBsj3/lbo+BapZn6U8bMQ8yt+gZK3TABYVCfIVu
 BQHDJwAwc1rb5kS0xzl+4wFdZj6pC1YN95eHDJE2Ax8xHHU9z3BDEKvUTwMIQNO3Jsnw
 aQ+fLRw2LcAxCqPl9RP2nzQnv+tpASOp1E7q/cvxWqskGIER7avMZW/QDtNCO1SFQz56
 G1rpPrQc0uTvd/l0EnmdPFniCYu/UZa5nFXRGE7ZYyB0rWCBHKE6ZiXksVOFdbhhWF/d
 qhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622791; x=1735227591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upFpBaO8cptavFRp1HZ7mKtcy+0BbSMhQQtCEJtj5Yg=;
 b=BvlVp4ydOaT4xsToEpbV7Hhk2H/YysuZ3Glc+0wvUWzy8UzGws8BF4/yawUdo0/dj/
 1PPk0KnooShoFEMXVm4t4Vob1XbUEB6l+OktAKzLs+3T8FdegiVAIFqFrqUHo1bBR2pr
 X/ZDBflwER7CmKCArP56oJ4YRy5iqQOZQ8pF6WwQfzE1EI3gkaZYDvlnol837BVnJeGj
 +WU4AuVCFma8XgGH2FFWt1l8xL2dddPqrsNOfuqG4v6MGXCZgtXdjmPvEvgeuflaC2mV
 6rh7fBfSQogC/gSUw3woJV+8t6ooqKVJx0Ft7e6LW/Qx4DEtQjF/hznPzVABv7p9tmQ1
 BSyQ==
X-Gm-Message-State: AOJu0YzA5adQRrwuafJQiAXPhaQw8SbkVSiSkomJpdlPZc9q08eJKECQ
 bFBlDGX4J7lc91x24QiUMi0TIuJ/pg8cFyPXRP5CWcnpPIcBP+AI1xfEZQXty11Cbv2LqkkWz6q
 Z
X-Gm-Gg: ASbGnct5ev6AEBf0Sq+G2bAhzEP9vUtSugOGPs33iyQ/kK8sW0QsTniVJ3BrWAXFZ+F
 tfww1L8TtygB7puTjyxOFbyBU+pWtkge26d0axl51+MrXJTq11PsmXvnFESll2Wh2rdZkZnhnue
 mWRbnZU8q3cIXbAzRRz9KYIixdkscwAMItCXrIvQ84Na8k0umLq2Wt5pSPIjpULZkP0j2yv6eRY
 aj3GeqFiMF/BMg2Z/LGkXnvBb3rGXKjp3lY+bX0E8JxnD0YX439yReA5E5viOCM/2ooZixjMQ79
 HnHi
X-Google-Smtp-Source: AGHT+IErehxBq4obOaVRcaYCREXohUvSxM4e0g+hUo+WwFbrfvi4FJvxnGJYLGiEEC/HTEknmJKr/Q==
X-Received: by 2002:a05:600c:4fd3:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-4365c7c83d7mr28882795e9.26.1734622790613; 
 Thu, 19 Dec 2024 07:39:50 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c515sm21268325e9.30.2024.12.19.07.39.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 09/10] hw/misc/vmcoreinfo: Deprecate '-device vmcoreinfo'
Date: Thu, 19 Dec 2024 16:38:56 +0100
Message-ID: <20241219153857.57450-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
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

'-device vmcoreinfo' is replaced by '-object vmcore-info'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d6809f94ea1..57a3d734081 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -79,6 +79,11 @@ described with -smp are supported by the target machine.
 
 Use ``-run-with user=..`` instead.
 
+``-device vmcoreinfo`` (since 10.0)
+'''''''''''''''''''''''''''''''''''
+
+Use ``-object vmcore-info`` instead.
+
 
 User-mode emulator command line arguments
 -----------------------------------------
-- 
2.47.1


