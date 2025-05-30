Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BD7C5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvR-0008FF-OY; Fri, 30 May 2025 03:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvP-0008Ea-Dc
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvN-0006o1-Ng
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8iytk596qFvoq4XGuuczZdwRmvPFNDnfKNqPGLwBtZI=;
 b=Wwhmhjmiwpaq4U9AQmp7J8n3kA3qc9RO3KnMtoIhp3yKZYvUhuwmRzq7hczVlwwUykdrlm
 6mcIDeImDqcPj3Rr/8hZ/l0wt6ADWf/0hiczlqbLKoVLJt/j8XtWMGTsSPkYoobCc5Tpo6
 v8+KXu6FUdE0gWLxCbj0st3J47q1NJI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-zy5x7KYzM9i-iKb5t8xO_g-1; Fri, 30 May 2025 03:13:01 -0400
X-MC-Unique: zy5x7KYzM9i-iKb5t8xO_g-1
X-Mimecast-MFC-AGG-ID: zy5x7KYzM9i-iKb5t8xO_g_1748589181
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so87509266b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589180; x=1749193980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8iytk596qFvoq4XGuuczZdwRmvPFNDnfKNqPGLwBtZI=;
 b=S2WEwWoyWy6mk7ZYITEkKKy390o78OIOwla/6AcWxnMZxDPE4MwJgsEkpHQJUGRhsO
 XJJYfZ0mJVkNTV85erppNjC2uUQJ2J3v6IBt13S3bOwqpOk9R7SR3ZqZvFOL2XeVIU67
 ZBMBqbfQBuyYjzEx+Rarv5RALeWIkO3FbQ6OTy+gj8hlYMEqJwVqIkuwlvCiqkMRQ+H2
 lzvIAD1Idz6eDq7MXDhnSOaxAUL2nOuPNBGdOcQeC9c+lUF9RqwG8QnZjQhlQ4ITdF20
 wEan/pLBQBETOvpbn9C3QsNjqP9mtYvQ3MBThJ6bCbURV9k8Z8mcBmPGfOb9xSPnsymo
 uj3Q==
X-Gm-Message-State: AOJu0Yyhybd/DUbb5xA2FdT3rYxcBN9REvfTaA+QMXNF2Zc5D44IXTLx
 pjwXoGXArKj1l0sCisYJGwMmSryDZZU4WSQBu61owRNBfTMXrzJo6LMew1UqCuZVf7wQ3r0BJ1i
 ACNUpnX0xlYiR+ZrkxWyWBLmAoQOHazJiMrjCFtoSeK3BF39WQ3VB4nPFofAZ/+u706RTwacpAP
 B/4LMf3KZjkw5Ihrh6wjM/K7yN2MpE5JL7FSoVXDmB
X-Gm-Gg: ASbGncvMQrs/OBNC9HolDcjdjSOHsbWQ9a0X3O+V3utenxT7rU0+N6hsPi86ov2NBd1
 VzFkfUUY09xlIgFwsS564sJHNMr/NoJS7363pyOIJ9oXCbsMrN0Ijuc/B2JLhoOmG3wpQuE4UOL
 YSpL5cwqNBrnahTSoNBYwF28Inxv4EWtmDUIi178mtfsE3OBcqj4XRyER1S4VaFMkzU0O2oYPjC
 prnZkhB2EtHJm2/QRqdmJJpfGKYzvpwBx+mTPegFRcy54m1RQiV9SapEIwnNfx+I7Vd9Tj0YRMA
 87BhhuBqf3SQjw==
X-Received: by 2002:a17:907:6d06:b0:adb:300a:bcc0 with SMTP id
 a640c23a62f3a-adb36bfb72bmr112628366b.46.1748589179884; 
 Fri, 30 May 2025 00:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDqrsZ5cjAr6xNppyuMijtbLs3qlP7Mrr8aUC6OHcPevVYRxalwtazGbU26xJWMuQPDTTW+Q==
X-Received: by 2002:a17:907:6d06:b0:adb:300a:bcc0 with SMTP id
 a640c23a62f3a-adb36bfb72bmr112624366b.46.1748589179395; 
 Fri, 30 May 2025 00:12:59 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fed96sm275835866b.32.2025.05.30.00.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:12:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/77] target/arm: remove explicit dependencies listed
Date: Fri, 30 May 2025 09:11:33 +0200
Message-ID: <20250530071250.2050910-4-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/20250521223414.248276-4-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index b404fa54863..2ff7ed6e98f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -28,7 +28,7 @@ arm_user_ss.add(files(
   'vfp_fpscr.c',
 ))
 
-arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-- 
2.49.0


