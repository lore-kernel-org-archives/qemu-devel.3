Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D51C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwysn-0001U3-4A; Mon, 02 Mar 2026 03:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysb-0001PP-Hl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysa-0001Uc-1f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFdOiQyPFU/kDzvSVAYPu91w9k4cEkStFxsLh/0Nhto=;
 b=HRD5YBoL8bE1Goh6GDu7KEcFs3zEGwS3Ur0yMe0QUAy3f+lWA2QVGCNFBgmFxPQqJ32KhR
 egVEAc/Wycx2lvH9frkkcUY4Y27WBCg9ZQVyPWDxbfRWXpIJhMEx49VvJLFP1kJDoijvOT
 6SDKrP/LcEurxmZtX3FYygH4W/3UgPA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-_ZF9f2faMTqqBWDpmQZAbA-1; Mon, 02 Mar 2026 03:43:49 -0500
X-MC-Unique: _ZF9f2faMTqqBWDpmQZAbA-1
X-Mimecast-MFC-AGG-ID: _ZF9f2faMTqqBWDpmQZAbA_1772441029
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso46174725e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441027; x=1773045827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFdOiQyPFU/kDzvSVAYPu91w9k4cEkStFxsLh/0Nhto=;
 b=KzJKL6WZYSc8mjfYPp5lmCjMGZpDhaqljCa7gYOhbfyY4bKG8vmrwU71dnM41vbYaz
 ZIW1NmYnfrym+CpSjn1XI5+ChtNV9xkhByWuBf8amAq6noyDz3Mc/XhXl613Jai4w6yb
 USUZWyTkClIRdob+8yz+R+eMhm5OzWRhJOB/hzpM2tJucp98dEyYJdOWURMo5ueVr5xP
 Gkkzchq7o94+UkIzrPEE0X8xIt9P7sno0KW5InWCTv16tnUyiPZDjlpLVZGzNRhlZjNm
 LsRvSr3wgP6fZIdQl4NGXYidqlMVbxdYx9/cVtJBDYFhRDYL4UXqbwE0+0dfw80s8X7g
 0clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441027; x=1773045827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NFdOiQyPFU/kDzvSVAYPu91w9k4cEkStFxsLh/0Nhto=;
 b=vbFVI5nPyDTdUIwyO6ASh6LCUk0OBKrpVWWLMGC/v0XwaJp6XTyv/AM5CJoeTfR+aC
 yMkU7eA6cQ5cJczxJpD+RwEbrBZ+555basKLregZA4gZI7jlAPwAb8u8u7OXE1DTw4bw
 7BEbg41ifEPbJbLGO3aIDedrxS4wuIPIDTUMm8xz7I/H7q5nVrWY1PK5zU6FBuMo+L7f
 HiEZiNMfRI0Q/3KZFHMdQFi456ZstJeLbkmSpt9E3t/1flR8e/SzXWYynl6De2mJPBGE
 skOzQHJfgcBMVi4sZOnpjljE3/H4Max2Jv85sk2DQlTZI7YTfdiMotQnJrRq0zge5MfM
 ezYg==
X-Gm-Message-State: AOJu0YwjJhRoCJ7J4Sxu6ip8Y7JkijYI87n5gw1BrO9Cz3RBEh1Oidp4
 C6FSorWQS1Du38ar745D3xAR1FPb0KJf7ZcBpf76qRTet9KBfDvalTJkpECBQQPdUcwIQ7OrTMu
 UONSIDmAwGbZTUNScaV37DhT/XnlbzECPi574a5dOunaBahd8/Z9ul84Xl+CWUd39wOQO0WEYjc
 hKSEjz4BTpMLfWrt+En295dBFXKS3ILB9iKtMDczN3
X-Gm-Gg: ATEYQzwQjV4EsuMfEeGNE4O9owxiDZ+D7HQKPwLUvyG1z4xUa1cdci1IKofMFhW73yg
 0/9Axe8bccZE9y3N5sw3Py/MU2Ag4BRyVpHH+m6bA9cmTDEFI3ZJTT4RCgwlqpXEhyHixAyQM7i
 cOJprXXU8VJwgYvrapzrS7+lHXEv0HFWgGMgmHclkCexy827dRHkZSBPL4TppI9prY1iaN3FLZ0
 /kgB34icZ5ul3XeD0ZivqEVi/Cn7/+M23C6IxddMFM27wtYjUj5l1ZQS+ayV/RIsgYkRrDWCyh0
 y7yJ8VaAwxbF1Bp6HzJImdIw0aIvmaFRf8/7NhO4PkPAZfAmdn7TyEkESOYJuKlZZN8RXtYnMUH
 6973znOQZi54kVjo/oGiYSB7rAc2vOS9sXdiTz7CTWJ4zobSTlHhWWBL15I3hQROZQir9iE2Ykm
 nQ48PkQikTDBZg4xgJAb2fpPYsmgs=
X-Received: by 2002:a05:600c:c059:20b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-483c9beacf1mr137761465e9.22.1772441026993; 
 Mon, 02 Mar 2026 00:43:46 -0800 (PST)
X-Received: by 2002:a05:600c:c059:20b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-483c9beacf1mr137761215e9.22.1772441026512; 
 Mon, 02 Mar 2026 00:43:46 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b84023sm273157845e9.12.2026.03.02.00.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:43:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Wei Liu (Microsoft)" <wei.liu@kernel.org>
Subject: [PULL 002/102] target/i386/emulate/x86_decode: Fix compiler warning
Date: Mon,  2 Mar 2026 09:41:57 +0100
Message-ID: <20260302084338.473368-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Bernhard Beschow <shentey@gmail.com>

When compiling for i386-softmmu under MSYS2, GCC emits the following warning:

  In function 'get_reg_val',
      inlined from 'calc_modrm_operand64' at ../src/target/i386/emulate/x86_decode.c:1796:15:
  ../src/target/i386/emulate/x86_decode.c:1703:5: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'val' with type 'target_ulong' {aka 'unsigned int'} [-Werror=array-bounds=]
   1703 |     memcpy(&val,
        |     ^~~~~~~~~~~~
   1704 |            get_reg_ref(env, reg, rex_present, is_extended, size),
        |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1705 |            size);
        |            ~~~~~
  ../src/target/i386/emulate/x86_decode.c: In function 'calc_modrm_operand64':
  ../src/target/i386/emulate/x86_decode.c:1702:18: note: 'val' declared here
   1702 |     target_ulong val = 0;
        |                  ^~~

In the calc_modrm_operand64() case the compiler sees size == 8 to be mem-copied
to a target_ulong variable which is only 4 bytes wide in case of i386-softmmu.
Note that when size != 1, get_reg_ref() always returns a pointer to an 8 byte
register, regardless of the target_ulong size. Fix the compiler warning by
always providing 8 bytes of storage by means of uint64_t.

Fixes: 77a2dba45cc9 ("target/i386/emulate: stop overloading decode->op[N].ptr")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/20260223233950.96076-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index d037ed11420..6ad03b71b07 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1699,7 +1699,7 @@ void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
 target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size)
 {
-    target_ulong val = 0;
+    uint64_t val = 0;
     memcpy(&val,
            get_reg_ref(env, reg, rex_present, is_extended, size),
            size);
-- 
2.53.0


