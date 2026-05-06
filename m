Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AA0FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcsD-0003W0-1O; Wed, 06 May 2026 10:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrQ-0001K7-0Q
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrO-0001FL-Ho
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso71329195e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076260; x=1778681060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iaJFzIJUDSNhlu1CwM+oWQIx5FuRz0v1PPPiqNFhe2o=;
 b=e/9RZV0omwD2jQy/0ItRK5G9LsfmtRICjp/MWI3Bx7TGX2S5c9XSO7iL7978/plVLl
 UoVHA//b5SyoV4K/FfdMmE8O+UTwVvUuFOwZuATAXYFWFYY3B8jhF/SrWDj1qNv+utNy
 GBENYg1TTV5vLa9fm4tYqBOhe+HK85kpuZQjDIuU7f0IvlZGjN3BNFlMhO6L8C5yzeju
 tWOWZY2knBud1yBXiNMjwJS6p2d+BiWR4WU1L58uk82/Vd0g+rItMvpLPPsZ3VC6B2IM
 YIf6erflkHZOcXPFS9h8b9sTQFgqk7eIXGKFa1YO+rF3gtLQYDMkOzQTzDOonssDmo6X
 gJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076260; x=1778681060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iaJFzIJUDSNhlu1CwM+oWQIx5FuRz0v1PPPiqNFhe2o=;
 b=Ll68Mrf5yC4cFb3y5DDdWI7eRTPZrXTvLLbsnNcNkMET3RHcJ8RJS/u9nVz0e5OnEh
 fLTMzlINxKheNZLfPYzYOebxmO+p8as8+k1GKI3Ri9kh6b2IZdUst32PrTnF4K62dSp5
 EAGrtjxUj6851Kh6YjEWwJnBm7LtlfSzjs0CfWa/LtW6kki+y7NsRjhQvwjIEW+yhff/
 OIw3fvhJp6+qolWtbWBCq/SGQFIaFnU8zt6eYMSpdBCq1lrggpN+RBqmV1WFZLbKfU0M
 SMx0kTG3fCSogloDk3DS79lRrJIKmHPHE0axajh5fS1TSqcu/dQUEPZjgaXQUiSNbmOX
 C62g==
X-Gm-Message-State: AOJu0YzLTl+I9D6QZl9/YDd/DHWFAq2gdNGdXXRt0PE0qPoyDKcr4GTQ
 tinuEctKoRl1oaqvZkrSskaG116WUACO7ybsFdz8rf6OHfzzvUTJ8dEiJb5jqYE813n95ufwJiG
 2UD4RlY8=
X-Gm-Gg: AeBDievVb8BtrRH6THrjXhpRHF5EfkoQGGHkKB5AO7FSTK+0H2crq6I/BQGDB1RKdvj
 RqvXt7gBONZPp0noF8uv5KF5zmRek9x9ZhfKwmBeJOq9Xv4Dli8rW/ts91qr6Op5tS72JZShU7W
 AUnKYj0/c8E6fyFXcnzYwRO3b+3Nkm/45IE/uulVsfRPC/ZdN68qrPDyzomLVF8wu7n4lQdmr36
 knFBcmEcS9ZjqM7qGMhwp6OH3GSLEfGWpvlNlFSLWmIZB7sre8NTlstg6Aqh6sG6DI1/qlSGC/P
 IApGlFHLfWYBr9fxB/posh0oj5Ndfrs3arRTGAZch0ovbq3XM32IFRIGKEXR8K72IZSG0ty/EBY
 HH3+wtza/Nqs33HO2wqnm1nHt1ZTva5QjUHQRTg5v/3JgrotT48LTiMsuwjy/0C9zQVmdAn7vym
 fpUBvXej2DI5uM82PhjdBKuQcnuRArQAmi7dP6sY4XRkjj3aeHSwru22tyLXqAn70JHClevpnr8
 CKTha+4yqY=
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-48e51e0bb62mr38985735e9.3.1778076259944; 
 Wed, 06 May 2026 07:04:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53142ce6sm17647295e9.28.2026.05.06.07.04.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:04:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 068/110] monitor: Remove hmp_info_pic() left-over declaration
Date: Wed,  6 May 2026 15:54:40 +0200
Message-ID: <20260506135524.20617-69-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

When converting 'info pic' to QMP in commit 795eaa62fa6 ("hw/intc:
Introduce x-query-interrupt-controllers QMP command"), we forgot
to remove the hmp_info_pic() declaration. Do it now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-33-philmd@linaro.org>
---
 include/monitor/hmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9bf46795bd4..9258a049bff 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -52,7 +52,6 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vnc(Monitor *mon, const QDict *qdict);
 void hmp_info_spice(Monitor *mon, const QDict *qdict);
 void hmp_info_balloon(Monitor *mon, const QDict *qdict);
-void hmp_info_pic(Monitor *mon, const QDict *qdict);
 void hmp_info_pci(Monitor *mon, const QDict *qdict);
 void hmp_info_tpm(Monitor *mon, const QDict *qdict);
 void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
-- 
2.53.0


