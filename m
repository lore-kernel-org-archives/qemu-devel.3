Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD3ECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDY-0004w3-Fw; Tue, 14 Oct 2025 09:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDU-0004qy-6S
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDS-0000y4-4U
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqzK4xMOj6Z3D/xSJ9Ykj+zTwkBuUmwR3JfwFDRx8Yw=;
 b=Z3SLEOWON4QFtTixQ6ZPo/NXRlXeSHhrum4PF9XtxyADitWJZwRnodoEaoeCT2rNhDLvHh
 fVahObKur8x/kKZ80y9PauYEB37Om8FZSr6np9EuQd8j9LAThDxkLWwY1aOYMEOPhE8LUY
 m06t8xJvsrA7JorWQdLwwFoiArVUYUM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-6p1dHaMxOsWt7fZaGW_4JA-1; Tue, 14 Oct 2025 09:37:22 -0400
X-MC-Unique: 6p1dHaMxOsWt7fZaGW_4JA-1
X-Mimecast-MFC-AGG-ID: 6p1dHaMxOsWt7fZaGW_4JA_1760449041
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-401dbafbcfaso4319905f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449040; x=1761053840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqzK4xMOj6Z3D/xSJ9Ykj+zTwkBuUmwR3JfwFDRx8Yw=;
 b=YQt4LLhOy6mZXOdh264zenTPIlv/F4vJgxd/DygPVtcI7HEMzX/t/YIkqkb5VrEXf/
 7optiKcLIXlweZNAEFQpUmstoKMwOFRusdRtWhN0uuYteikeGTYRg+sti7csDqag0kUs
 Z1VnAfnMSXf09522wGRFnVRXRWFRAiDQrqBxbw31XbIvBthed2l21L7TOHp7+Ym8WvDH
 FWGJrCeylN9fjnIHrzY5jgtLRDkF6Y6+PlEKxdsOZQ8ShUp/o60asf4Z5pYUf8kfcL8+
 dsWmVySRlZdFL4gVyUdpqDmkbXArNKgtr4cII0AcoPskGbJ26gn4SeN3sVZPD/vkrsRU
 Osow==
X-Gm-Message-State: AOJu0YzQBZvCTnS9Vkvj9F4g65rIWbro50tI+mLdQcPbbQCYVsb9W56y
 a53f8ES80NGRKSSWKXfAPwN/3i7ceA/CqZn/mgIlCN83pVQ5CMQ3bSbzVT7f57E+y6UnTUPBIXH
 6NmdVCQ8xezWxicqx8KIMK0yLV8xBuobQnNi+FLjhwNgB68FYaYhEOgxz3ZCraN0t/hXYMaiFB0
 D0XAtaG6yxHYhqnspcCLR6lDTiJH+JzCKOYvzQK3uE
X-Gm-Gg: ASbGncujtgr74joUpiubni2ajeVkq4zcXbg/bD/urhTusOGORHF1KOG9Pm35hS5yjIN
 THKwT9D7LrNWOk4RkNfsvbSIsnJBMCCZkUyl8urDkVX67Hc8LVK33rVoWIMx0bxlbDTv6rzUSBb
 XMx7KSnDBSq5CCznydTpmMI6uVR7N46FRVwoqtLINtCYXZr7+LizgPD4GEMue2Gp8+w/KvXX50R
 g6OfjgV63nJZnFLR0F1Ylo1VkWTAqrGHI7o5gIa1SgBGr7QPCvq2Qb07rQ/U4E4CVROdoQzOutB
 HNJDzUS737/aeLdSGWFgOpMjBGNVeSeAT30oH/O/1F7AophIcHVkW6+IBfS0vP94lJLr0fbG8JJ
 Fm326K4Std7aLjEEIgZMALNAq+dUvsiFLb9tqru3krGA=
X-Received: by 2002:a05:6000:2305:b0:425:7e45:aaa8 with SMTP id
 ffacd0b85a97d-42667178050mr16077084f8f.19.1760449040306; 
 Tue, 14 Oct 2025 06:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzU29JgVkFZ4W8Q1tBLT/IamVpxQegmGCOEfrVnNf9pJSjt0bkMB0AlhOpJxeaQq7KBSafIg==
X-Received: by 2002:a05:6000:2305:b0:425:7e45:aaa8 with SMTP id
 ffacd0b85a97d-42667178050mr16077057f8f.19.1760449039837; 
 Tue, 14 Oct 2025 06:37:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf6b4sm23838242f8f.25.2025.10.14.06.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/28] rust: migration: hide more warnings from
 call_func_with_field!
Date: Tue, 14 Oct 2025 15:36:48 +0200
Message-ID: <20251014133713.1103695-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The call_func_with_field! macro uses dead code willingly to infer
the appropriate type.  This has started adding a new warning:

error: unused variable: `value__`
 79 |             break phantom__(&{ let value__: $typ; value__.$($field).+ })

So shut it up together with the existing unreachable_code warning.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index e04b19b3c9f..5f5708ad39e 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -72,6 +72,7 @@ macro_rules! call_func_with_field {
     ($func:expr, $typ:ty, $($field:tt).+) => {
         $func(loop {
             #![allow(unreachable_code)]
+            #![allow(unused_variables)]
             const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker::PhantomData }
             // Unreachable code is exempt from checks on uninitialized values.
             // Use that trick to infer the type of this PhantomData.
-- 
2.51.0


