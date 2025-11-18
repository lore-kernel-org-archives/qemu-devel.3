Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F6FCED260
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIyG-0006VY-Fs; Tue, 18 Nov 2025 05:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIyE-0006UW-6R
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIyC-00032h-P5
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763461796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=do+UbaBiOOwddVkAoLI/+bC2dQuwohtwYVd2EuLCMA4=;
 b=Z0nSG5lE9NhtcWZ49wmqOnh2aMv7ohfgjAzxp1pJizbsqFv51FcQ+aetkjgVxcV9N9R1Cl
 oV6UHomshfKhSfIxgZnFZOdcNm6KkL1i1AokwgtngMNLh32VyXchJMXij9/CZiUsO44c44
 QbTIIXhh3Y5Pg8nZycRef1u3/0KPZCo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-h73dvMsEOPexueXTj6VddA-1; Tue, 18 Nov 2025 05:29:54 -0500
X-MC-Unique: h73dvMsEOPexueXTj6VddA-1
X-Mimecast-MFC-AGG-ID: h73dvMsEOPexueXTj6VddA_1763461793
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so23717865e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763461792; x=1764066592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=do+UbaBiOOwddVkAoLI/+bC2dQuwohtwYVd2EuLCMA4=;
 b=LI0C8v3cvh+rOJ9foQezRcaEdCyGUjtAj0Hk4xDrKgKtw0OuiBaA2YHuNU/3R63/s/
 vqnEZ8is5MQ4oaKYd9JWz/EL6hXjj3I+WIvHTp4uecL+2OSg4VK/VYCQV5wAGTFM71lQ
 SVDzUpRSR2ilJwafanNdhCbRsuqTjpeH+6nApEzRCj/A9GtwVoiFd7ijpIL5PxwLi422
 6yDGAEBkfbUenVOKt6nh4CjH51Z6rLpeRY/JMA5yY6eDssVmKhpJfbr23dcYHIgcnLQ0
 0FsLWOuvEVTWyUdmMpjtRJfsOreoMoEwbqUO/KO2B5ScgTVlOajJ/zIQnGkhtJpWnfH5
 RXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763461792; x=1764066592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=do+UbaBiOOwddVkAoLI/+bC2dQuwohtwYVd2EuLCMA4=;
 b=ioP4Vyx0meozGwVGyKdL62XOfDJnE0iohwD5JtgdfXHtodgJoic4uPra1Ma4S1eCXm
 7QkIM8FIkxiCEsCGQb3Q26Fk9+D98i8vnU5LiJxiCECoDo6422DjYrPPhNKtydhlgTNu
 rzWm9xCXEBLM4Y9hOIbiKJdFMjlr3Qja2k8nvdtBJqgV7IPsungHphzuxiqIQBpxclFE
 wJRGDCRMSmnrnT5hEwaLFxmrLQy6plBveTSze3Jt9lGIgQtdszN3Jv3EiUO15My6ZrHb
 e61NJ4FJ8fYE6X7aCIcj820IfEh9IOitE87qMIg4tdS2L8kTLQTI4lcTQZHctR7kCnA0
 38lg==
X-Gm-Message-State: AOJu0YzvFB6Kwcchk1bNd0VGcGVgp3e6fSI4PKidopi/rswuaFKtZ5qR
 cfLgNLFusIjc487phzKr8RdqRVejdrg/LY9V4Fvfl12khZ65sh/xdQHTzRS2JfTppgb9ERArsw5
 1h39wNjRmKf8qLTRg1rMA2HBYFQgDW0tKzeUX2t0q0lRdham/4f8o5semmjIYXWaxMwqaY+Y+z8
 BG0Tg9eeipg4naoDQeFG73nsPRaL/hBA2EUjoCJJMl
X-Gm-Gg: ASbGncs0rxD9D0VH5txSSLBR2vNH3ArYqUQfTgFeKw+CtKRzELAaJFgFg9taqrVRZkX
 m7qOYdaQJOHLa5kgUcEGjyqx3nDuWFCc9ZBD4ONF/9/fIVkqHDaaimeJax18rh0PESRQsvtl2WG
 JaKV+KYttfLq7Ke96jW8ubroe9YUxdPC0oYi7mee9d6pOdkmGMvpZY9GIH/ULB3OiAHDME0TUVO
 gSsyOEXC9nmhe16Ox2OFOJzsMELg8W02l6mKd7WrmbCjxfTjvljyuX2F3Qhnvyl/nqYxz59FrFg
 99jhbComDFLf5oRdcSHlw/gh88dLhHAJiyhK02egthhGkmnR3xs2Gpo27sxivEQqReBHmv/EnSp
 VZ9h7TAnHLb9l/eEsKr6SRp+iIvUKgP4SYvYXt4vYqHZsLaOcWabMDGHYktdHQveT9+st+88KbW
 muEdXIF1/MdxveCZA=
X-Received: by 2002:a05:600c:a0b:b0:477:bf1:8c82 with SMTP id
 5b1f17b1804b1-477a94fd02amr24196655e9.15.1763461792274; 
 Tue, 18 Nov 2025 02:29:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy6/5UJNYCpNSIxBQZA7Mx7WNuk7k6GYNY3910D0VMtBf+TDiyacXTpCeZGx+swsAuTizSyQ==
X-Received: by 2002:a05:600c:a0b:b0:477:bf1:8c82 with SMTP id
 5b1f17b1804b1-477a94fd02amr24196345e9.15.1763461791842; 
 Tue, 18 Nov 2025 02:29:51 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96a58c5sm15553695e9.0.2025.11.18.02.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:29:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH v2 3/3] mtest2make: do not repeat the same speed over and over
Date: Tue, 18 Nov 2025 11:29:42 +0100
Message-ID: <20251118102942.551194-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118102942.551194-1-pbonzini@redhat.com>
References: <20251118102942.551194-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

There are just two of them (slow and thorough; quick is simply the
default).  Avoid repeating them for as many times as there are tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 692e4867ec7..19c11ed9352 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -14,7 +14,7 @@
 class Suite(object):
     def __init__(self):
         self.deps = set()
-        self.speeds = []
+        self.speeds = set()
 
     def names(self, base):
         return [f'{base}-{speed}' for speed in self.speeds]
@@ -62,10 +62,10 @@ def process_tests(test, targets, suites):
         suites[s].deps.update(deps)
         if s.endswith('-slow'):
             s = s[:-5]
-            suites[s].speeds.append('slow')
+            suites[s].speeds.add('slow')
         if s.endswith('-thorough'):
             s = s[:-9]
-            suites[s].speeds.append('thorough')
+            suites[s].speeds.add('thorough')
 
 def emit_prolog(suites, prefix):
     all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-- 
2.51.1


