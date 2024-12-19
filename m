Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F6DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFU-0001nL-CQ; Thu, 19 Dec 2024 11:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHim-0003Ar-O4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHik-0002Ow-SJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jzX2pyO/iqHI0cjENwYLEKZ3ZU6j0kw5XT1+VOMzPg=;
 b=YXYNCvXI4YLcTBJGvRZBBlTqyFUqKX5/Cqmb4oEk4SS0I2TRDhet1vs9xvMN/SjnRDPdJr
 UpSwCWTphJZAcujj+nFdn8//RJd1XFBUFMQA+rrTawDd8Wk/XEoyntYVIBjxftB/HkivkA
 iDC4CwBVNPOCgdQE5vWQNW29vL4CjME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-VYzOtU9oPBiUodDkYeoUOg-1; Thu, 19 Dec 2024 09:41:45 -0500
X-MC-Unique: VYzOtU9oPBiUodDkYeoUOg-1
X-Mimecast-MFC-AGG-ID: VYzOtU9oPBiUodDkYeoUOg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so5285265e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619304; x=1735224104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jzX2pyO/iqHI0cjENwYLEKZ3ZU6j0kw5XT1+VOMzPg=;
 b=tq3jSL+vqG7RNzXWpwBjd1I+2VbGMhTgPckPmVOmldbGWqrgQyaF8ROyIQlySXkrt5
 ZQ1lZSi/wA7ElVLf7Afp5KdLjQ5Ok01CEzm0l9zaz0XflQ9XlZLXPdgJV8U1q/jfmfqz
 22Xb0PDWb4HAQpLWQ6UsmuInTLsrexnOrY0hNWy/oRpXzMUTpt0EamgoEMyhhr79gao9
 EDk6Y3qgWhrE4Jrq6TAeg2+JJivi6y6hyaB0hQAQ2peiuTEeN2OhkVpCtBjoWe/BrZbL
 t7pVCOsevHu+WI3rIAno6asZsOykgG9nhnC12veJn8mxyaZWDJIJIeTQrozoDpGFZqsx
 I1Ig==
X-Gm-Message-State: AOJu0YzKKBmRm1wgN/golsjWRkCNztTpC6P19gdDvn7ALnJ4mPfdBkqn
 OjzwK+KT98A7w9endLDBjuHZP/OY290wX7f1yVm2uN5O+Ooq36+v0pTz53IzSxRH67MYD7374y2
 mfqG32u6Xn6Timj4tkoabByZzzUBKqkhtEpKnpYa3mIveDuwZSkgXuaLqLwMUc7/bYvRmDPG/zN
 gdcD0tt2v8Y8w2jibVgtyT/9wVlDQ/k73MeKE=
X-Gm-Gg: ASbGncsXbne8P3dSohasSKdre1Vp80FT3AJ5gZ91X2HJ7tDlN5jmY7mVhtL9z1yAl2Y
 h0HKzCOLhP66AXrsyCvpk5csxQ+oQwJq42HZx4Zyu/zsaY7OHr0jntrFZCoWBssVegBJ2n9lObr
 nB+zSKIHpGEPADv/bGIxRXknp4XeUpFTJDhks9FsGzaTwmWyeKwlvEkGk0hwYMN1vaQC30Y02t6
 tAhMpZxew/H8fX9j7ai8akjqIbMihVSmoDXPNK5ANP2z9V+NloM8YRmG3COEiJPTAy5hQ0fFELE
 PFmCPnpT0Iqb4U9N06aNCHVZ2cfV7pgdoGW1IPKD
X-Received: by 2002:a05:6000:4609:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-388e4d6430dmr6378027f8f.35.1734619303839; 
 Thu, 19 Dec 2024 06:41:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdK5LxQEuU02Z9U+hkMcgnnmY4R64sLf1X0U+pBmoZ2k2Zw/0TsBk3kR2RqwGWkpI7pxlsNg==
X-Received: by 2002:a05:6000:4609:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-388e4d6430dmr6377993f8f.35.1734619303439; 
 Thu, 19 Dec 2024 06:41:43 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c8471dcsm1708604f8f.48.2024.12.19.06.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:43 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/14] s390x/pv: prepare for memory devices
Date: Thu, 19 Dec 2024 15:41:12 +0100
Message-ID: <20241219144115.2820241-12-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
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

Let's avoid checking for the maxram_size, and instead rely on the memory
limit determined in s390_memory_init(), that might be larger than
maxram_size, for example due to alignment purposes.

This check now correctly mimics what the kernel will check in
kvm_s390_pv_set_aside(), whereby a VM <= 2 GiB VM would end up using
a segment type ASCE.

Message-ID: <20241008105455.2302628-12-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm/pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 424cce75ca..fa66607e7b 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
      * If the feature is not present or if the VM is not larger than 2 GiB,
      * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
      */
-    if ((MACHINE(ms)->ram_size <= 2 * GiB) ||
+    if (s390_get_memory_limit(ms) <= 2 * GiB ||
         !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
         return false;
     }
-- 
2.47.1


