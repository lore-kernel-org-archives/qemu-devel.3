Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23C6E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxq-0004Vz-TP; Thu, 19 Dec 2024 03:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxh-0004Sl-8t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxf-00055P-OG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7BcPA5dTlWF5fYX3mQy4xElZYCb69b4ktHM7D7aGrk=;
 b=EaXOKkgAIYNjQZSUJYwyOj1ZvBhd2D0is4ye9LpwtsmY0RcWPZ55ga42yHyCvpwgqcAZmN
 WLphmmfPZ31MS+Yp8D/gO6gIZlcjWJffkCBZXsWwQ8luc80HK7oKoAZ6AKT6rr1f+08V2B
 qFyHtVaFAALL4hM0vxrm7KN8Fhamdfs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-7LWEOcr3OBKg_qwgiFCvxA-1; Thu, 19 Dec 2024 03:32:45 -0500
X-MC-Unique: 7LWEOcr3OBKg_qwgiFCvxA-1
X-Mimecast-MFC-AGG-ID: 7LWEOcr3OBKg_qwgiFCvxA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso293619f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597163; x=1735201963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7BcPA5dTlWF5fYX3mQy4xElZYCb69b4ktHM7D7aGrk=;
 b=jpzM9LGOhA6AfD5j3lyh88NDUtgSNtEPjUX/+HDn6EJhJfNzNjkHMiWD/XTdDhmPZr
 X7NwfhcmQWqcL2cTzx8wnyAakL37Icgll+FCT5VIC6JatJUc4wdJmddR/VkKD1z8qNp6
 MU9PyYuoQnJZt+oRqknGhbGa9+ue77EhjrdFM3zP8jL5KSW7bsPL8gU7sxZ+Ot75lhTc
 KhXbpyyvyt9Ro0g8kgBfNaDaD4hKlOwY10luFqBJANOjOTE/yi0z0f42nz8JxP+cSJiO
 UqZN7rA3AJomSQ7YYLf7q4VzENrrb317ERPesOJLKA0TTSl/coovlNYNZ7g1UDIj1/ms
 Mg7A==
X-Gm-Message-State: AOJu0Ywj/g+d08vaJiDWacBvI6puF9kNyOQi2MuIQQU6Zy5UWdbGVH4a
 DKf8jwUg3/8GDIboL9O01NTAB7KYxhP0X6hnr6+3ydFGd+GWS0tLYjhd4nchGOupZH5CB85sLxr
 A1EBZapOKJm2lbeo2MK92jXxGI2Ra7bxmm4G0/7yoSUUjLNAv5JXKVSpzzFl9SHlXhnmK6tlEdR
 Env0/0MaqkKGklbihHe1i+b5SbouNxcRyMlX8O
X-Gm-Gg: ASbGncuu4Vekh1cvl8DsrIQ54dC1gSzb6BYxZ5qFite16WQDTEzT/7y25m5JksrSbjk
 6gq+fdokwTOSYKXJASY8nd5ILo/kaOEJEmGLxf+fidjLrJtH02ikoJqTPjl0gkxLF66cAc2L8Cw
 za9MSZZbUkdPVmSn5Q6/CUFfIV8YUUYV1OzsdDO2rU4ZjOu9x4UKTX09KgMNuwUW4paJAUxmmnc
 sIb1WSbR6qaq0lfq2+iw40nZOBxGVBxvZu0jT43sMDFINAasJTpjh8ek6rD
X-Received: by 2002:a5d:5f4e:0:b0:385:e9ba:acda with SMTP id
 ffacd0b85a97d-388e4d31165mr6080767f8f.2.1734597163212; 
 Thu, 19 Dec 2024 00:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfMwN/JVcwHhwoi0mP33jwr18oFvQ6fM6kQPgWVzIRHyz/tklNrZzw2X6083HlLugdjInDFQ==
X-Received: by 2002:a5d:5f4e:0:b0:385:e9ba:acda with SMTP id
 ffacd0b85a97d-388e4d31165mr6080741f8f.2.1734597162866; 
 Thu, 19 Dec 2024 00:32:42 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e150sm968670f8f.66.2024.12.19.00.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/41] hw/tricore: Remove empty Property lists
Date: Thu, 19 Dec 2024 09:31:54 +0100
Message-ID: <20241219083228.363430-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-8-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/tricore/tc27x_soc.c          | 5 -----
 hw/tricore/tricore_testdevice.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index ecd92717b50..81bb16d89b6 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -201,16 +201,11 @@ static void tc27x_soc_init(Object *obj)
     object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
 }
 
-static Property tc27x_soc_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void tc27x_soc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = tc27x_soc_realize;
-    device_class_set_props(dc, tc27x_soc_properties);
 }
 
 static void tc277d_soc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index ae95c495654..e60866d76fa 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -58,15 +58,10 @@ static void tricore_testdevice_init(Object *obj)
                           "tricore_testdevice", 0x4);
 }
 
-static Property tricore_testdevice_properties[] = {
-    DEFINE_PROP_END_OF_LIST()
-};
-
 static void tricore_testdevice_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, tricore_testdevice_properties);
     device_class_set_legacy_reset(dc, tricore_testdevice_reset);
 }
 
-- 
2.47.1


