Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF3FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lp0-0005H3-8c; Wed, 24 Sep 2025 05:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loy-0005FF-4s
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Los-0004pX-2t
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cGRXr7IOuXBD087dAOWEFFsD7KAtBeiyHVV7B7Xyq60=;
 b=OwXzWETmDs1xmyc5QZnWBqpiB2JDhm3XJJgimoprp0/Q8keHkN+m45H2S4jVdY5JAy7XDc
 K5yaI+CwKylKMa47qBeWHyG1r1obZ2Rm+O09pCiMOx9JnOrgLBG09gTq67MAHjXl8yXe+H
 xeaO9wNUqx+w9JV8jDj6k5BVe/E7TNE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-ME0kMPCAMB6hPOZEXzEo_Q-1; Wed, 24 Sep 2025 05:29:43 -0400
X-MC-Unique: ME0kMPCAMB6hPOZEXzEo_Q-1
X-Mimecast-MFC-AGG-ID: ME0kMPCAMB6hPOZEXzEo_Q_1758706182
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afe7b40b15fso236869866b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706182; x=1759310982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGRXr7IOuXBD087dAOWEFFsD7KAtBeiyHVV7B7Xyq60=;
 b=aSjgmqcE3QE9gVrHJET56m9ig3sc6JREw0LNdS/RVU52mkXD/7IMpbhuaLqODavZIn
 TQkrPcgJZBT97mfOYJ4IqUyXbaiFuC6Kvi8KkNe9+YNgrJRzoG1t5GFBnXwOXq56wIu0
 T9cjF8eOTtKUJEsXx/61KnDXidytI/W5gvdOQkFjq3Jo0yEyNFBsowW0GUHweI90EzJ5
 fuRo0cprbuLSFzDcIoGPpRYmpHpYmkFkIdmhvYkHtre3TS0eKn1m4qKd9IuhgToBA41D
 e6beTE5zZ944HUdQFO/VrYPkLF02bwO2r1KeSLtXxlihj0NySYb/iELuENMQrx8due7g
 TQJw==
X-Gm-Message-State: AOJu0Yz3GEFLr97w6WZ5eYYwFsJA8SDw35kF/jCnDPwpXdE9+jC9vk23
 B76N/sKiFblckIYJh9Y5EG6TnifEHwLe+Rp43JLHua+/2u82IJCSUcJs359u2P49rX34ht3DHBJ
 JCW65m1m3ZpUt6kONtTi+nyHn3azPbynMwjPYLUyAT41s389hi2mE+jlRPwLiqcuCv19AzKxCuS
 8/4D8bn0oFFM/Pe+FOFTKAoPxrZeIdnk4PHZiUU9rY
X-Gm-Gg: ASbGncuf8KD2VoQKszoVh3DC4rJVjtEAcKxZjQ2Q9yKuzsOX1T8xRYoyHQnhWKidUf7
 S/kZS9Ok8ngaO03eBA6tVVxmbIGcyIVvHJg5LSw2RUlbYugQyf4nKbdR+HKULlYZWpVha0lsJQR
 UTX5cixzjJ1+mJJLkIxjd/vWiamtFz4Kae3ABVxtHj/5JWGKS8F9h29ahATptwH5xpM3gBdWOyu
 Ms92E/SELx6wrozQVmG4EH78K82pF3JITuPw+5ATKIEuIEw1tBnjsNwFCo+cuyfvsN6X/Y47KWj
 /2Zaqq2aEQjEOnsgSjnfvFjTsfwOTEeujunhn8UEsp24oqVcL+Eec9INdab3yDatpTJ2zHVsmY9
 2Fl2Gg7ZNVLdxUMF+1gtUFBFNw3bNeR/JEY/8V6FiFEoBJw==
X-Received: by 2002:a17:906:f590:b0:b2e:51cc:9b9 with SMTP id
 a640c23a62f3a-b3027d3e5a8mr550345266b.24.1758706181686; 
 Wed, 24 Sep 2025 02:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaStrNEzvYEI+nuTAoiuUJXSw+KmgVILcCMs/tlOlHpHDm7XCGBgLOKCZHhibWfuojAtb4cQ==
X-Received: by 2002:a17:906:f590:b0:b2e:51cc:9b9 with SMTP id
 a640c23a62f3a-b3027d3e5a8mr550342966b.24.1758706181206; 
 Wed, 24 Sep 2025 02:29:41 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b29abf51da3sm907646666b.75.2025.09.24.02.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/29] rust/hpet: Clean up type mismatch for num_timers property
Date: Wed, 24 Sep 2025 11:28:36 +0200
Message-ID: <20250924092850.42047-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Now `num_timers` is `usize` other than `u8`. Although the type field in
`declare_properties` macro hasn't been used, it's better to explicitly
point this out and clean up this before doing other property work.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-11-zhao1.liu@intel.com
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3cfbe9c32bb..fce75415579 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -909,7 +909,7 @@ impl ObjectImpl for HPETState {
         HPETState,
         num_timers,
         unsafe { &qdev_prop_usize },
-        u8,
+        usize,
         default = HPET_MIN_TIMERS
     ),
     define_property!(
-- 
2.51.0


