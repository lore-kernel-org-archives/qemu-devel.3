Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70468C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhEK-00025s-OV; Fri, 21 Mar 2025 14:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEE-0001c7-My
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhED-000726-4y
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmzz+Z10cF8s6oKBzeZDluVa8sEBlKEmjUCkAgJ5/6I=;
 b=H8B92rHV6umBp2kGbM9xxYqLLXz+0Gk7CKfnPJqOefFUaZbOIPXTPHb5SjKGLZd80pbOwF
 85SDOJOO5bJwZK2jGSu4X8DVPdWMXJ8++42LYvD5iWPuId6H5ch6j8u5oL+1jprXjQ0/1W
 F8dHeBZtYLjx20HBNkzTNC0CFQZz15g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-o1X-onHtN9O72CbQe23b0g-1; Fri, 21 Mar 2025 14:36:19 -0400
X-MC-Unique: o1X-onHtN9O72CbQe23b0g-1
X-Mimecast-MFC-AGG-ID: o1X-onHtN9O72CbQe23b0g_1742582178
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac25852291cso195405666b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582176; x=1743186976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmzz+Z10cF8s6oKBzeZDluVa8sEBlKEmjUCkAgJ5/6I=;
 b=mPw1hpo9OqD5OFH8J2X4X72WNwHreGMGprx8VZHaAwM5f9S0OxELUnLPeubiBMysOd
 csKxSr9GURtM4y9/smosz7gn4megV3VDCYTyqUmXyT9FB0xIlskn6X725vc1D3FsG4fr
 0ko4xUQ0NPqDfCRT1F+WAT9wZq9PS9Age3Zu11S2A14hrOEVzxSmjjH6T9rrpicRBHv5
 uKGbb7qKpUxm++/gvlC7fDwKfh3/M2gGKNGGlRK7x/qYtbfNMM1fHxoHT5w4Wq2H48AJ
 DICq23XTcRoZSJ1s60vjf8RiGjZzinJJf9elWLxDPmnytj+VEUMsA29+vzvL9WTRfVAh
 X0Cw==
X-Gm-Message-State: AOJu0YzabG//H28ZR5nvYCWoebjcX8eivHo3GHsfGJbuI1vHFDAE85+m
 mZjLoOMtjkzNYUITfBO850CWMNNIhD056sqTo55gjMBxDxrqjQdTyDvNVMkU8M6gh4wLGvu5mCy
 Cb61XQEdL5klrEswzOfEnD2UkHZZlk1TiDdez4LUnREqTZiUTbct08qfjX0kV3Pgb//NXSmydJE
 bF6DWD/oRqal0TkjA2YMEgZufPyDlSTdAth9zm
X-Gm-Gg: ASbGncv4IucfjgCcYdv0COjQqxuPKIyQl3h9OHZhUywxqpzJ9StqXmon/MZmvUTA+5T
 qbuAtSFHy/MGG9oaYSQxdmTCeMhVteudHFgvLI00KBpkl3RZhTkpmiEv1iF5LklUpW+1ge6/Sw1
 lsjpneE9stA0/Q3gysp2i16slnwPE+3k9o/EFYBTY4bb2R3fgz6hogEGeHcTaxD4q+EKBHv1oOD
 4PGWIGABoeyzkkP7A1nbzJh8jW2keWy9C6/E9gKkZAZzvq6Y3Rn8BJIdH1djpUbzag0XUuQBSqe
 aLtZwWDSF7J+3Ez68RhV
X-Received: by 2002:a17:907:3ea2:b0:ac2:baab:681c with SMTP id
 a640c23a62f3a-ac3f22b2bddmr421988166b.28.1742582176360; 
 Fri, 21 Mar 2025 11:36:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG4RC6lChpnRUoT8qFxk85rSdD8ABIvBfoz+pBRkloQQbSxWUuit/uDEF9itMSxxXgFkVOZw==
X-Received: by 2002:a17:907:3ea2:b0:ac2:baab:681c with SMTP id
 a640c23a62f3a-ac3f22b2bddmr421983866b.28.1742582175873; 
 Fri, 21 Mar 2025 11:36:15 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efb51cebsm194768966b.107.2025.03.21.11.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/24] hw/char/pl011: Pad PL011State struct to same size as
 Rust impl
Date: Fri, 21 Mar 2025 19:35:37 +0100
Message-ID: <20250321183556.155097-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

We have some users of the PL011 struct which embed it directly into
their own state structs. This means that the Rust version of the
device must have a state struct that is the same size or smaller
than the C struct.

In commit 9b642097d6b7 ("rust: pl011: switch to safe chardev operation")
the Rust PL011 state struct changed from having a bindings::CharBackend
to a chardev::CharBackend, which made it grow larger than the C
version. This results in an assertion at startup when QEMU was
built with Rust enabled:

 $ qemu-system-arm -M raspi2b -display none
 ERROR:../../qom/object.c:562:object_initialize_with_type: assertion
 failed: (size >= type->instance_size)

The long-term better approach to this problem would be to move
our C device code patterns away from "embed a struct" and (back)
to "have a pointer to the device", so we can make the C PL011State
struct a private implementation detail rather than exposed to
its users.

For the short term, add a padding field at the end of the C struct
so it's big enough that the Rust state struct can fit.

Fixes: 9b642097d6b7 ("rust: pl011: switch to safe chardev operation")
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20250321112523.1774131-3-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/char/pl011.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 4fcaf3d7d30..299ca9b18bb 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -52,6 +52,11 @@ struct PL011State {
     Clock *clk;
     bool migrate_clk;
     const unsigned char *id;
+    /*
+     * Since some users embed this struct directly, we must
+     * ensure that the C struct is at least as big as the Rust one.
+     */
+    uint8_t padding_for_rust[16];
 };
 
 DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
-- 
2.49.0


