Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE58D31A2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwoo-0003MJ-L4; Wed, 14 Jan 2026 04:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfwom-0003Jc-Tb
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfwol-0001ps-5t
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768381529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/K6S1A+ISlG2P6HVYW3Zy18bB5bP8aMGEnAL86/rDno=;
 b=ReAx9XaWdRRRCoCRBP/rNDT1SVdGwANua3FT+3aB+BRcyFmGTAuKdVxpVg3kOJrXk3ObNt
 e7ie0ERZ987FDtjtlJY9+Io7KRVm44Z4oT1nqxoRvL4vi2IWu6Eliaa0pSjTMKqHND080G
 quVUA5/XXF43IArSnBy9fLfChNkSi2o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-TqUZjI6UPDOf50tE-C8Eyw-1; Wed, 14 Jan 2026 04:05:28 -0500
X-MC-Unique: TqUZjI6UPDOf50tE-C8Eyw-1
X-Mimecast-MFC-AGG-ID: TqUZjI6UPDOf50tE-C8Eyw_1768381527
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d5c7a2f54so3363325e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 01:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768381526; x=1768986326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/K6S1A+ISlG2P6HVYW3Zy18bB5bP8aMGEnAL86/rDno=;
 b=gWEa+fGXG23/a6eJlDyb3jxTdpLO/ud5poorlea2bCaAYM//XmlDm+CWCJg9FBfopt
 pnxVIXMpHkrjDQiK4VGpu0jrLHVyhBf2pIQ66TZMwHjUYmGMNv0k/dAl61rLm3HcYx3q
 v9SIjYtpr073oIeWmWXjfYbH3IovJvZrToKYAZFbYh34s0VqmumAKYaiOE8Tyd3/RkVh
 2HbptFPTgWr/C2+9dG3gBouZjWmUNxlmgfe7kTh/mxCQ+wW8tfeU/lWtbgqf+C/u0onk
 lqq3veaI/3S1jhL2rKmhtT8ysD6Ee2XNo33UB9kbc2nz2YRWMGo310a3jnZccEOPMRsK
 7w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768381526; x=1768986326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/K6S1A+ISlG2P6HVYW3Zy18bB5bP8aMGEnAL86/rDno=;
 b=Bx3hlySHe+mZz6fNAin1KSjbUbTqWO4qF8o/nk0oBPDjQBvRiGf8E6/Osv6cfttDo/
 8LfycKw1oWhGUfIO7q31ukFupyK+Oa3laViNCQ408uCh032iGutwXI6oUB+19Sv5F50r
 gmsVMl8X4pmqXJsqrEK0q3wmhBsx/OrLoTyraqNakIRdPknknC9tix225jI1ckP6vvej
 ryRCM1Kk5b6vemm4TH2sJIqCrdS/f+phw1V8At0H3AHiZ7UL1VfUrxfugT7Da27blt4i
 X0R8k6Wz/PW+/aX7OcAM/fpcEAC+IHp7+SyxQMDa4eWvJVP36v9mLC8hY+pmug55xxIs
 xIsw==
X-Gm-Message-State: AOJu0YyDldtHeR7f8zOaXtqk7CfgGA2usQ2UZTw/TL58YhIMDIhOyuhY
 tgx8M1omfSK8NqbFXF0oSEVUjFlLPVPqQybbvtvjgMyrv8yZVTqnXR6LqniLGdHyVgvV2JKACTe
 6nZforr8bcqpAViDQNZbtD1nKxZN4+gVLJGZSQ+3bCWmwZYGnpnRod0VwThivhs2W101fJjkgtv
 OlT7Y7oGFD7TfVRcKcelC2OnNIc07RHSkRVC2xAglU
X-Gm-Gg: AY/fxX4IAMXdZrV+yiULJEjA74dI1bdYE6hDGV/8NngarA1Q+UJ0tYkv4mAFcKftgjb
 9QcuC1d6SnTrDmL/6a/l753ASn/gkLOX6Xg0jIlLyBv01nyscq80zPSE6yHmNvc8aSrIqArPppn
 PKyvykQ+PhrEOC0u8MBk6P643LBQ4SFrFTP8bQbQV4z9QI6mYVSqcaDhZ1Ops1yAXJctnbfRKKL
 gUKLNZQTacSegxfTaP21TzvIeGSWXScff3RIJJy0fcQj6i9NAu0ZWZRGJEoPB6hMfGkXNUDAhDf
 3X4nTWl4uxFqCNVG7fvibBLJ30ulVIVTCl6Jv6bbyW9ZAqUFgoGK8F7EefD3KaVdvvZgfL9PadN
 JU3IwvSvj5aVooKcAveb9HVvA/FfG6ti1+hmA54uv7h242GINWfFIVxSv/XYFdWJveefIIVUxBc
 7nhfrCvzT5Idm/OQ==
X-Received: by 2002:a05:600c:3ba7:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47ee377babcmr21026355e9.5.1768381525937; 
 Wed, 14 Jan 2026 01:05:25 -0800 (PST)
X-Received: by 2002:a05:600c:3ba7:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-47ee377babcmr21025915e9.5.1768381525428; 
 Wed, 14 Jan 2026 01:05:25 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee57fe917sm17526335e9.10.2026.01.14.01.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 01:05:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] rust: hwcore: add chardev symbols to integration tests
Date: Wed, 14 Jan 2026 10:04:17 +0100
Message-ID: <20260114090523.1315939-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Even though they are not used, rustc does not elide its symbols on msys2.
This causes a linker error.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Yet another tiny bit.  For the remaining issue, which is another
	linker error in the same test due to missing system/memory.c, I'm
	posting (after retesting) a patch series from Marc-André that is a
	bit bigger but was going to be submitted anyway.

 rust/hw/core/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index fa1765a2302..942ee9cdacf 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -73,7 +73,7 @@ test('rust-hwcore-rs-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, util_rs]),
+        dependencies: [chardev_rs, common_rs, hwcore_rs, bql_rs, migration_rs, util_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
-- 
2.52.0


