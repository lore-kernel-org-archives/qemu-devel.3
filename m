Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0609FB5EAB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mKj-0000rF-QK; Wed, 18 Mar 2026 04:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKf-0000qJ-Q4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKd-0001mt-WA
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCeY4n3aG6uvgN+2wCtWjV8E8nVdROMN1q+s0mdYmKs=;
 b=ZZ5JVPxsdbj9CqU3oaPkibAZkEutB2wKEIVINbqm8+GYDW12mpGPANXK91QFR12p2ZI6Gb
 7wi8GPrfHTKL8EqFKW/uG7KeBD18qdtIkg+65qL39a8WMg6OuQgPWe8qbajOwuzmcGbI1I
 Q/oVLyLi6ewYZERNLaptoFLbp0qXVy4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-4eTIZ2ahOxOe5juTKISuCQ-1; Wed, 18 Mar 2026 04:32:45 -0400
X-MC-Unique: 4eTIZ2ahOxOe5juTKISuCQ-1
X-Mimecast-MFC-AGG-ID: 4eTIZ2ahOxOe5juTKISuCQ_1773822764
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853b00f9f5so69516655e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822763; x=1774427563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCeY4n3aG6uvgN+2wCtWjV8E8nVdROMN1q+s0mdYmKs=;
 b=pF7+S0zJidcpyAhBpeYky3aDicXauBoCkxwRM3xCd9GQilPRtIHwnXyGPCSxE+dvLf
 SRMfblFZSLoVdLG5ivRZp2iBoiMhTszN9mvUJL2H/cqqjjer0/5/y/2Z6kK6fJsEcQ99
 Jc5k9qGD20Sg1rNIA1d/pgQVqHasZhGNdIq1w7iUBmjQCVbLc3RTbj5K06FX/duFlOyp
 knSCHh2LiNNs7TfJ/FGV9fF4Az8WTPEJK2IP/BObTFF+ZbyZpVB+jQEZcVCQ/mOaqPdA
 7YXmcJtnvHveO6cpNRioZddbzmg+GYmmI2pf63VransHNshaZWrdsjv4T1YWMX3Lcg4i
 S2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822763; x=1774427563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCeY4n3aG6uvgN+2wCtWjV8E8nVdROMN1q+s0mdYmKs=;
 b=TrxDrqZbhx2DIh8n5HwB23Hlz7jOT/zNAEg78wMuyMAvTXVSzH6Kskw45Zk9cNAvaO
 avav3m4MZX+BVsmgSS//oaj/QiZmuxmCCkJMq0P5LWr/KjGGsoe1s//LCHo/R6vshRxz
 CpyF4rCgrGXo8J+ATCHXNaycxz50l6fsMtXWYJZsrz1VKdhO1t442+TMeglMQJhojwtl
 dQqTBJ4CrsFwDbSS/362Qevd3d5+luNF8TX2SGa7xElYw5GSTxOrxvyK/O4KYzgbC4J6
 h1bN9cBMErxlVRD8GFU93obSQDFQdb++JUpr4A+3I9FQjPP/37mpzyPsnDWaYDqnvzZU
 EPKw==
X-Gm-Message-State: AOJu0YyPulUSJ80ES/p+UNYHAMkXPypDS5XCazqJnY6ytaR7t9QGxAOd
 a0IthT94WI4EjEmo9TKlui2KKY5zrxY4NEmFVXcWi2jO0zxu78ZUiHls0X+siLPFiIdZZx3p6JB
 bRBxJQbyW15ZMXi6BMoiGEkbivoMru5aJOSwyTGQaxjVgqkhivhvs5ujsPZU765IqRBKuIRGENg
 LaAor9RIhwFyR6NXuZ0kJrALPbi3dsxBrjF9/LP82n
X-Gm-Gg: ATEYQzw2kTHSA0iQZMeSU9Kd6dY5WDThVyw7OAfSV8E31ik+845it+6aEeoCPQkU+lY
 DNfcK0dk6g8/qr7B9PBK6Q/IFWovfOkYJqPMC/CCGq5Z30e88YitNyAAbmeswVlzZ9fwuCvIoiG
 1ovJkJ2OGyIJjYa1q18O7BNuDWG8wwk2fXojNZKyxuyxiLMytCKRmZNQCuNrmzWShDb84TsRDJL
 /uIu8lWKpojryDHB0LQnD8v8NJKVJdoEU4OgUmKRTQX7dvqcGV3ve5Y+rFW23gn1BCoLLYShMlT
 GcMyXRPdhv2ejw5zNh70q+tSBCwlWJwsPF6aTcD5VkGxKiYwBLc5UEgNHGkQK84l2j0WZHmBA/m
 pjKunFKApbdQ5CTLSlInNBZJZ/6G1KjGD17bw7hEVsqOBmjeRFUSYB6KUQYQovuMQ+i//keZ1VF
 aiFG4SLF5V7hJJkpgYwjxQiNUFhMQ=
X-Received: by 2002:a05:600c:1e88:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-486f441bc30mr43281335e9.6.1773822763023; 
 Wed, 18 Mar 2026 01:32:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1e88:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-486f441bc30mr43280935e9.6.1773822762425; 
 Wed, 18 Mar 2026 01:32:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f5e162e2sm10093005e9.34.2026.03.18.01.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 01:32:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 2/4] build-sys: use the "run" variable
Date: Wed, 18 Mar 2026 09:32:36 +0100
Message-ID: <20260318083238.1132609-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318083238.1132609-1-pbonzini@redhat.com>
References: <20260318083238.1132609-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Avoid unused variables and hand-written path, this should also help meson
to figure out the relation between the commands.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260211103305.3112657-1-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 11139f540b0..de00fddb2db 100644
--- a/meson.build
+++ b/meson.build
@@ -3504,7 +3504,7 @@ run_config = configuration_data({'build_dir': meson.current_build_dir()})
 run = configure_file(input: 'run.in',
                      output: 'run',
                      configuration: run_config)
-run_command('chmod', 'a+x', meson.current_build_dir() / 'run', check: true)
+run_command('chmod', 'a+x', run, check: true)
 
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
-- 
2.53.0


