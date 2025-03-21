Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0EAC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEX-0002qg-RR; Fri, 21 Mar 2025 14:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEP-0002P9-1l
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEN-00073J-4a
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLiRCVPflMZBiuoT6PpWJ4Rvv6yoCgprry9CsORptr0=;
 b=FrmH6KqbTN7iBTKtmterIJWgrkbdL+jhGlgNvAptIj+IbKBvFZjGamwH1vACczCvZBsetY
 WIoWEomkj+qK7KVVhmwNyUi75tnjrHQsRMQ0cnAduzNx05UUdn2sS83yKM5e/6uuntuaCA
 rKvPywX2fWc4rl0y9Px75nuU1L5HycY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-uKjOlCnCOkeJX08uJHN4ng-1; Fri, 21 Mar 2025 14:36:28 -0400
X-MC-Unique: uKjOlCnCOkeJX08uJHN4ng-1
X-Mimecast-MFC-AGG-ID: uKjOlCnCOkeJX08uJHN4ng_1742582188
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ceed237efso18710755e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582187; x=1743186987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLiRCVPflMZBiuoT6PpWJ4Rvv6yoCgprry9CsORptr0=;
 b=HSB6aZ8VIj5thRVZR9rIOmLXRtR5K5R1f2bFyDO/teZh7Dn+cwGMNw8LyhXxtn0pyh
 BdfVxYxL+43zyBgHH0prMvwjgt0wmzvTmcrLZP4+TisKS8axFP1gFCvM3fI24MqTHNIp
 mUZEcSo2X7otVQ3q0dpdRhS2eI3xMlEI7bBG/4GzhqCYA73kUOx+Mmai+kd94N8EQd8t
 mGT041pA+vTXZd/wDXLtvyrAnwIRfOodPqMsAAbG1omPaqJMtHy2rZWKHPKFcrzYMaGc
 g+S9B6sXd87cufvkOpTzcjYGXq+CTIDCKPr4O0gXGi0YnbBtNv1CklklrRKefbftf+3O
 jxTQ==
X-Gm-Message-State: AOJu0Yy8y9hphUvPueWP6Jykhxw1A1fMnAZEi1oQgp87pGgJTP7EZAlj
 CoJ6Kkwp5ly8OIA2nmTUFibP5J8sMm1kXQtgqeL16t3z9gFvhTW05PLt7Z5N2b924+hDHfg5lF9
 oXjL6Xq8vfjVTTb458rQCw1+j8FHd5uClFpo6BiNKxHwFlcXzgexu7HM1DHlETqwT4HoxL3Zhin
 LWZaJ3E0kdk2XGRVmcqclS1c+ionCRTCMT6DDZ
X-Gm-Gg: ASbGncvzLiOGvlqZUFAubHlB6tnoN2V99ck/p5wDaEUDDxtwsmJF3j66+OgUYkPyRD/
 TQrPSA6rPMQlKJw2EVwVk1rXLbH6fGSqeLR9553f+OoKl6chPJMA/TPAGtrD7vU6U+BDIGf0vDr
 OpLgfiA3zjzRWFAubeq26FuaayRxuFtQShMSRlOBUapARiRdHg1YNoxVipHbHZAh74wbyX8wcvT
 pIT07INEISbPpsMnLYg1ZsTQZsD2UznQB2SBZY7oE72lXTIUwdTFr9SZqoS9SaBIB4Lze868DlU
 hhelaNynketpbn88/ETx
X-Received: by 2002:a05:600c:1547:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43d509ec734mr40116905e9.8.1742582187204; 
 Fri, 21 Mar 2025 11:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO0IOMLGDvkLwIhTUuBjv8p9yLjAZN86Kfvg1GNpVKlVwx0Fbi1MVhA1cBNLXaulRPzF8Kug==
X-Received: by 2002:a05:600c:1547:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43d509ec734mr40116695e9.8.1742582186661; 
 Fri, 21 Mar 2025 11:36:26 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43e2asm87107535e9.11.2025.03.21.11.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/24] rust/vmstate: Remove unnecessary unsafe
Date: Fri, 21 Mar 2025 19:35:41 +0100
Message-ID: <20250321183556.155097-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Remove the `unsafe` block of vmsd, because vmsd (passed to
vmstate_struct) is defined in Rust side now, and it doesn't need
`unsafe`.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index f0510ae769d..6698dfe7aeb 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -447,7 +447,7 @@ macro_rules! vmstate_struct {
             },
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-            vmsd: unsafe { $vmsd },
+            vmsd: $vmsd,
             ..$crate::zeroable::Zeroable::ZERO $(
                 .with_varray_flag($crate::call_func_with_field!(
                     $crate::vmstate::vmstate_varray_flag,
-- 
2.49.0


