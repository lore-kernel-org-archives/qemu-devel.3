Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D75D13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXo-0000gZ-80; Tue, 27 Jan 2026 04:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXe-0000da-Nn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXZ-0008TK-7c
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dW/5Ry7VsalF+kGUVbKtXXaiT0xUof2cogeafgTzgI=;
 b=EfRpem0mhp14LDXuOJq3Ryvr47EJAFwC3OQewHf2XFhF/72eiVR7P7gARRZQdDPdB/Bx5b
 vbDbWfZOarp4Cvd25e6ShFaM2JJXPhFyOypNl+7FQzrqoAiPOxR+6jPMKnBPyyIWDBuChp
 75t4PzoUkBptqKyIKUMFa0Gk2ec9UlA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-BofAUUZANP-ozhUmoRJYCg-1; Tue, 27 Jan 2026 04:39:14 -0500
X-MC-Unique: BofAUUZANP-ozhUmoRJYCg-1
X-Mimecast-MFC-AGG-ID: BofAUUZANP-ozhUmoRJYCg_1769506753
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435a6c0c794so4207378f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506752; x=1770111552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2dW/5Ry7VsalF+kGUVbKtXXaiT0xUof2cogeafgTzgI=;
 b=eD25XXbg6ktGIUKZsYfjvvSv2RAiK60dPR9HotytetkTHkhMDFfxFzR2u6skBLrWTv
 +CLLBKGzzCkniDPwe4KH5Wdm8KlgbC11CDg+tYj/JaM0rjOdtnqhBdzQ44aAaRu8+6tn
 2jFCxMcmVMXud8guKShVYwefxcZDVY21wfmScqhMdNCqB6mjKcPyeXXtNWcGHtQbRiw1
 QzsX4SXTJSwByMHncBI8xpI+Q7XD4RkPnHYZRsqjJFsvNtc5En0uddLCmqymUZsv5Emr
 8qZFHZT+A3w0Rqozzln1WBpwDZIiawOmHWQwDd5DkgXGfRgj5fWogELbimkEcFA2BL+N
 Nv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506752; x=1770111552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2dW/5Ry7VsalF+kGUVbKtXXaiT0xUof2cogeafgTzgI=;
 b=orXL2thWnZunZLIGlZlytiStsTMGcYO/3pF1gJA2a6PTOeXJLz6v1oDjeLtB8Q7uzQ
 AujPdZ+1uQO5cqfe/DDL4twqgI42cMqWc1qeMA7rsP/howB1tLzUBHaZRIwFnyV2myjV
 He+xLZDGua6H7BFQPV4pRM/n0TcUIDqlVNo/x6Nvw89ahD+53hZm+rLrtmxdGlEw0Mp6
 RVwPTlOTCBWWjd0JHzxbXbQoCT5CTejvsl+6wO9wmWlNzN6j2r39aS2qaklSuYW/wQMK
 gL6e7TfBH9nLAMdvAU6K4Jpk47WCdDIzh4vNl1lga6bK3Fa4I0nkzS+bxW2VJ9a5vBzS
 IabQ==
X-Gm-Message-State: AOJu0YzRLUjoNb5No6zL0LcarEBUVoZ4cefM630gFmiSHBp/TDJM3Xsx
 vgCVqSPPYnODTmHWeggsS2XgWr39TYajZQ022fTbknWrgJNpvXAspu8sY88HZ06xFbI9ae5KG1o
 JmaorE3UyGkrhEQzn3xGggENXq4vo7cAAlcfk5PgnRakD6dCww02MH380mrJztbI6BMGqMizvIy
 zfo/BFEKR2WhpEwz9C3aI7a6PZFmuKwWo+bkIScbDV
X-Gm-Gg: AZuq6aKkVG3C0MrwdkQ76gu+X+2mfaJzpeUUqtQQ5AiGST9Ryj5sJbw/l/bcrL2iXOe
 XRVbeKBB5n7W2jAFaQoXGVCceR3WJmtLUvcgcFlAXJIHDLqYbw0F655Hna0rVxZVwkuFL4TdpVn
 9pJk6M4F8Fmb4LxyUm8KHbZSQQX1QgyAHzlNjzpHh7J03J3bO2SrWOIQyrtL1ogS3pOTNifNfH9
 0LFgi9aXmQ4Arpl8DC15cmtTaz7dTCPHyUeGY6bBryD4KNNkViDamPBjavGr2k7e4SbMYp+Jko4
 KNzrJAwNwp30TIH+/kIbcYlntLHOASvvAf5WUc3tQ5P8U2nj0Gaghi90wn2QnUFKdhtqadyGzy3
 +xEWYRBYqN3+qxP/fwEUA3fU2cmiD8syOToi+jaXhwO0S5NCGnFb4kiTtPf5Q8gBB/3RaoIQlij
 9cYA40Sr+pQwuQUg==
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-48069c16459mr12488015e9.5.1769506752550; 
 Tue, 27 Jan 2026 01:39:12 -0800 (PST)
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-48069c16459mr12487795e9.5.1769506752079; 
 Tue, 27 Jan 2026 01:39:12 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745c5sm37882735f8f.32.2026.01.27.01.39.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/13] rust: hwcore: add chardev symbols to integration tests
Date: Tue, 27 Jan 2026 10:38:55 +0100
Message-ID: <20260127093906.353741-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
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


