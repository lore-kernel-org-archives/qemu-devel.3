Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5C8E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPf-0002KZ-PG; Sat, 27 Dec 2025 04:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPa-0002Jd-Uj
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPZ-0002IA-JE
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766826992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWbbnYTTjYaE7oaeT2bvkDD7Zb8/wuty6WaSfbSwib0=;
 b=Ep99BFbAbL+/0WeBxHDtz2Kpso2hNhBuArsL6tqJiMwXjYcod796BC8qWRT3fKc+z1TlLs
 EH0ZpHZcmw71Ux5HnWtZdbvEvS6iM4iY4AvQBcRGk3w2AdBLBmuvElmGvkwQ5ruOxQXOZc
 BlVS4Ja2lERU5CMBhFHbEHnYMQzN+E8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-uxWenCpoMeWxFFbkpBxk8w-1; Sat, 27 Dec 2025 04:16:30 -0500
X-MC-Unique: uxWenCpoMeWxFFbkpBxk8w-1
X-Mimecast-MFC-AGG-ID: uxWenCpoMeWxFFbkpBxk8w_1766826989
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-431054c09e3so4767722f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766826988; x=1767431788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWbbnYTTjYaE7oaeT2bvkDD7Zb8/wuty6WaSfbSwib0=;
 b=k8CqdKWpvxf8bzj/ysI5cHAV7/5VpLXBbDGEJziH5WyCkep8Vppzi7uWSHNNGRNYtb
 C1ELiSYLoBRh0t7sliTZy6mRA2X4zLEJElIzG1wgFO9/pWtR7NXjneB7PYKi2I7k+ANd
 fM1dgwZsbIi+/DalPTQg9lci7pafwaB1cXAp8bnZx+jWFhl+zW2OqZ94gZ5a8qYC0qtC
 eVgKYpCs9KPSMqtlj9jUlQGKb89QCwgSEjqKFHiTJqGADPHhd0otzEYYZ6E3DFQdWHfl
 fIn/wXrzzpFrKRAB0P4QwgCLQH32hZZYCEY7DQ209di+4jvtkI6Y4KjdF3EhDMNjOd5R
 P8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766826988; x=1767431788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rWbbnYTTjYaE7oaeT2bvkDD7Zb8/wuty6WaSfbSwib0=;
 b=af4MxllOl8XxeUWg1SSRGP3oCmHdKpQXpeTL+IX2TvaaFBAcfixeSSNzCKbNELv82z
 XxTMuDMJFxVz6xivufbEOxuCznOWwyWErezA7p2J8sS4ZHZDO3Pm+d2mLrE7ORNg95jh
 rs8znAnonbwSwV3pEk57+bEtg3SS/vGBGkxvBo3vtx2A+r9PGnpp3jUa9jYn8Vl32RSx
 hsHfpd2N/6Hi2zbyCpPaJT8f++ENr1tvqHjAjMca+8DxvKnMO/ayxnpKxYaxocU6OSgq
 LTZcoVTrKM0Gen7FQc8GEJRUQVwUTSmclXLJ7hfIvcYc1ndB1wyN775mi7F+GcXzVF/8
 OOcA==
X-Gm-Message-State: AOJu0YxqdDgKnjjCbVLMBsClU8f+Ue4JDpFr8RG707ry6w3jQA1NOwZH
 9rYlNDGM/HIRMKzEXT04YtYQiq6s3RwTW1QQioOW8FEwW5Z0XBF1/Bmqv3oboKwJZ/2dbPQAV8N
 +SkeOZ/U7waLSSJNNg4dPymHpugYyaQgkVD42yOJr38j9dzFRlGYJ8WP88HnaHK9qxFKKkCAExc
 ygJOVbKUi1MPwPo/VJ3V9y4s52QbhfyZOU/1rPx6hh
X-Gm-Gg: AY/fxX6KIbYtPRxA3NtcY8YhhL1XW8WJmB5RV1ND/wkZTeqxqFEOJu+jUqvgTRg2R9w
 Xul15BKSx1aYcKTHsTXWAHmBs3qp26LW7s01EyUTfI08BKA3zl/1WSckajv8QoaRBx4oZjXqoD3
 pTZ7aWgowfZ7HKyHz4O3P9fNDCAf7wFo2FUJ5N1h+vCX0ssmEjIdhKI/8b8SFvNnKn7KVDq0rE4
 vNiP6RbYDbINsu3QmIpZS4Je/QERXdBYehtWa+aJUFONJCXlyR64oCuKT4TdVW8M7iijrE4eI8/
 maZAxizUFt2gUhi77O+ZlS96hm6HAZLCBJTybtC2tQYWxZWOUNnIsAbASr7Nz3FbblHvPOWXraz
 HjuYt1+YyBGfdTYr/Rx09B0EI1+VHpYYWRrCmjirce4NXj3R4pztGZbp49+0P0PyMM+U2JQCkxM
 fOzMbdkZ/gMw7KqZo=
X-Received: by 2002:a05:6000:2383:b0:432:86a3:ef2e with SMTP id
 ffacd0b85a97d-43286a3ef72mr2956043f8f.21.1766826988660; 
 Sat, 27 Dec 2025 01:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDZmIcSN/JGI5cZ0gtKrkVt3KOMnF80Cv+fvXZRAJlBiL8DBXoldiZzDsIbsKqSD6KWBn1Sg==
X-Received: by 2002:a05:6000:2383:b0:432:86a3:ef2e with SMTP id
 ffacd0b85a97d-43286a3ef72mr2956022f8f.21.1766826988248; 
 Sat, 27 Dec 2025 01:16:28 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2721sm49377062f8f.39.2025.12.27.01.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Mosier <nmosier@stanford.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 002/153] i386/tcg/svm: fix comma operator typo
Date: Sat, 27 Dec 2025 10:13:49 +0100
Message-ID: <20251227091622.20725-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Mosier <nmosier@stanford.edu>

A comma operator inappropriately terminates an expression
in svm_helper.c. Replace it with a semicolon.

Signed-off-by: Nicholas Mosier <nmosier@stanford.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20251111-i386-svm-vmexit-typo-fix-v1-1-49f0414472cd@stanford.edu
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/system/svm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 4b86796518f..524b3620d56 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -742,7 +742,7 @@ void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_info_1,
              exit_code);
 
     x86_stq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
-                                             control.exit_info_1), exit_info_1),
+                                             control.exit_info_1), exit_info_1);
 
     /* remove any pending exception */
     env->old_exception = -1;
-- 
2.52.0


