Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E94CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJPA-000832-QT; Tue, 06 May 2025 10:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJP4-0007q4-FR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJP2-00016T-Ry
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so5945268f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542171; x=1747146971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suVX6cmdj8m7H2HB7KjODyjJfCC/SsEdU5xs/t8XcI8=;
 b=hRb8l2Bn+42F+VEA/Kt50czONurGmGLwfgqHKNeY1ATDx8nG/UcwYT8lPSloMms4Xn
 8LTZObMjifJJBTz0lZ2nCjQHNL8GGFzeWuIk9U/u954kaSZC+RMZks7yWCkMlKC9j2Wt
 8KyyZ65fCylPa727gqzDa25oxzsDaBmMq/fbsqIEXY2chhfGCIKCrY0b5CylBO45Nyps
 iHg4Ke0F/eObbGC1GNoZXzcn1AMHgcvumt40u2PyZwxAoIoVIn8goHZ5FXjDTzNOFBAv
 4k8GZ9Nzv2I1Nsc+pJO4ekm+q19xkXkHyF+fbvfVw0zFYvErK3Q4W2uvj+qRKpT1l++j
 5OGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542171; x=1747146971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suVX6cmdj8m7H2HB7KjODyjJfCC/SsEdU5xs/t8XcI8=;
 b=WglgE5CpwzZXrsEcFfS0KrchjcDJXbt0KqySqRJYRwsFJ/kJ2ZTg5X4GJI2xNnkvTk
 Dn/u6S3vqKShtCnQZ4F+nnn2aZOpJRs708Aem7sMs+l+UW0eexQMqEbpIsx1/ThJ9Sdt
 NxmSHh8NTNTXFh0Yar7rrltMdGqfRIDGdAp1n27EG1RnwOLqbqtSTHA1T8t6ic6bzlP3
 pLtxS8vZ+gxuMDbNLehF4OA8Vs9+h53FuXdPYj8Otq9lyNLBcPODC2ugQ/nNkl5vjQEu
 XdmED0lzRzs5e2WrYiXDO6XducrSBoXDywjuDa+4kE6v1XpWu1ALeyI852sxyE0Gyuxu
 vlOA==
X-Gm-Message-State: AOJu0YwAXRkAsIGZe/Cd0gG1UiKoomvcNbFJlhZEYL1+V+7BMhgmoZ8h
 iizYJPI2LkmK7u4QBwSPPAe0MfxO77eGLes0JcGrDMUufRC4ePr++W0MrBARBN5WVOkLo18uduL
 N
X-Gm-Gg: ASbGncukNRYqQRr9c4dmv+gR/RCS60EI09TH8vkvVM8NpbnNzJnP3DNJQ8ugpwsjvo0
 f6kkcF8GtbI2W8nTlCHWGzskjl6iBNTr6bAnlyNh+OdM6RkENcrvvF+Znebt97q8dzPd2fjcuBe
 dxTNzO/Xx3/M/xqR9Lg+3niNvOh6fm/dY16bY6ZSOvpRimMZpDCc689y5G0f0d3iYNXvWb5+w2o
 Q6lRc7lUTqxWqgFB8J2BZf2DCAW84YNKkSOJqkD9BGKkWLqySULEG13Qm/lrWYzFP2HkFqbaJFA
 rPW1hN9QeiiK7WfPthKyiTuXNivkN0rndv9loYn7VW9RjnkFR7kwaHi63CrHTANodTfKfEPtKtG
 9MwkhVk/6p/2oxdqg43ZL
X-Google-Smtp-Source: AGHT+IHgV6wlRXHabzlYHxYg6Hed9DuVCr4yh2rGoelufPFTL3OLdbPjAF6f6+s7ndTD2+2Ol9u0kw==
X-Received: by 2002:a05:6000:4006:b0:39c:268b:8b66 with SMTP id
 ffacd0b85a97d-3a0ac1ff66fmr2665764f8f.43.1746542171075; 
 Tue, 06 May 2025 07:36:11 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b3d0a77asm101892f8f.56.2025.05.06.07.36.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/22] hw/hyperv/balloon: common balloon compilation units
Date: Tue,  6 May 2025 16:35:01 +0200
Message-ID: <20250506143512.4315-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250424232829.141163-6-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index a9f2045a9af..5acd709bdd5 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,5 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.47.1


