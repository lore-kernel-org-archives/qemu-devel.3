Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEB0C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvN-0008Dr-5Q; Fri, 30 May 2025 03:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvM-0008DP-3K
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvK-0006nl-6H
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZDhYgEn25ajyWYlR9Nt+PSW6BB/943ujLlEl7VIT5Y=;
 b=PiTDdrhjp5DTu79nVsVTCpPupt8ndWlmgKMSQthJYwYfyPPv5sZZMbNNjgOe/6cow1Jyxi
 cJ3RfVrULxt5D/+a2x1LTof2k9LTE4UrHEaxevGuif+V2H64/pHaGT3htNxrq/4p7GaBTG
 QbY42MNakqQZYmpi0eqCcmO+Fk0SdPI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Q7UuKHNVMZa3K6VjbDl0aw-1; Fri, 30 May 2025 03:12:59 -0400
X-MC-Unique: Q7UuKHNVMZa3K6VjbDl0aw-1
X-Mimecast-MFC-AGG-ID: Q7UuKHNVMZa3K6VjbDl0aw_1748589178
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-604639a2715so1509621a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589177; x=1749193977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZDhYgEn25ajyWYlR9Nt+PSW6BB/943ujLlEl7VIT5Y=;
 b=YUvUCAzRO7fUat5/aehMJrU5wefiINcRPKSte0BrQeQK7R9KJe1iUTt9ZrzDwaRjgh
 E4tKMP/wT+gcIFL/Tvv25OXKq1H3V0LMMhhoAbUK9xbRaLTBxt/fh9oLScqTbTEd6Y8K
 5nB0Hlu+hGWAjAfiWLr/m4aZIeL+bT+qSpfvFGaqlQdqifhfvr1VfkK4TLl1U/rNSbr/
 JazsELyDXTjlcUtwyRrF3qYRoar9z96iGcgxD9VrwseGsfkNLLzAuMYkZIhQQsLfSaYw
 yaMXngkhcdtXXSbyaHekFNjPx7BoMDAlh7DILOcI7IjihdeDV1z+jYYxCfTFJDcLn3ZD
 uv2g==
X-Gm-Message-State: AOJu0YzsRVvtb3JMZkiR4pPGdZHSAVmj3K9bc9RQ7udXxrpAM0+Gcx+B
 U45fw81Ve+h3YAbA+nF84rTMVj/ufIWxah8CG9OjTNxB6BfdiwLl5Z7HAnuPh9bkMrVatPEs6cI
 Iuo12CHX5/aJOdhshdBDs1vpN8I0synPwX/uybsjxvMLPpYAnduD0q4wImLQE5lUzfQHT/6TjeF
 9Nl9rHy4QizErOMtfhirn6jzhRfFflM1mqUACI8LXW
X-Gm-Gg: ASbGncsAfu0mYPS4qIokp7zNOYYlEuzcIIvBqUITwJFYEjrvILJVoPmxk95gqd0t8YP
 kE9xfmqC1r8iU9rrV24cWGq4RhHfGvYgENJRl/49Ps3IL6ArXuFCPGs/zaUftUvazyqWO9CLoMr
 RfHRtM40lLj9IjQO6Fai1PlieU2V6urvRGbmczIZVsFwOq3L309lxcEJGH4HVVH+FSn104M2iOb
 b4GAbdcOJjgrzsYCkjdX3+u42E34jYCUFmJcAiIq7BoRRa3yyoSzQEtdm6lHxgcU0HgdekB/L+o
 WntvQ0+6UwNBLw==
X-Received: by 2002:a17:907:7203:b0:ad5:8594:652e with SMTP id
 a640c23a62f3a-adb36ba4b75mr91270166b.35.1748589177056; 
 Fri, 30 May 2025 00:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmp0/E7mTcJ8Rdeo8G0qZiB4ZNkkduhNo/tix72GAlWnABl6zPWhbTi7jd/nomwjMFpiRibA==
X-Received: by 2002:a17:907:7203:b0:ad5:8594:652e with SMTP id
 a640c23a62f3a-adb36ba4b75mr91268066b.35.1748589176692; 
 Fri, 30 May 2025 00:12:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd04551sm275580066b.93.2025.05.30.00.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:12:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/77] hw/arm: remove explicit dependencies listed
Date: Fri, 30 May 2025 09:11:32 +0200
Message-ID: <20250530071250.2050910-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250521223414.248276-3-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 5098795f61d..d90be8f4c94 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
 arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
-arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
+arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [files('musicpal.c')])
 arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
@@ -79,7 +79,7 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
-arm_common_ss.add(fdt, files('boot.c'))
+arm_common_ss.add(files('boot.c'))
 
 hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.49.0


