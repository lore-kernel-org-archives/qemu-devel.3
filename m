Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D4DE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK3G-0002Bi-0D; Fri, 10 Jan 2025 13:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2h-0000QW-Hu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2f-0001Cm-OJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/SgEHIcRdBYgVQTtKD0/BCAD1nVvQXOmSgaoZuaiys=;
 b=AKx8CcEB0N0MbMszofn4Qi0UdspMlhLcklgZCyIz7qL5yokTX0gRwTrZSA6iK1F1DUq4xg
 HqMaRILnB8eeVzxRnB4SuzaGSs5Bi+qCM2h+SqOOjMookHFmIdyP5ZgGOd22QAlK9RQHm5
 XFMo42OL8boALXGrhbBH4LgcreKKXR8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-BaeizroDMzWZMDR9xpe9DQ-1; Fri, 10 Jan 2025 13:47:29 -0500
X-MC-Unique: BaeizroDMzWZMDR9xpe9DQ-1
X-Mimecast-MFC-AGG-ID: BaeizroDMzWZMDR9xpe9DQ
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d88d37abd0so2353299a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534848; x=1737139648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/SgEHIcRdBYgVQTtKD0/BCAD1nVvQXOmSgaoZuaiys=;
 b=hPRRRP0gpRYT2L1JHpOyZ0DEgFinlqQ1cmhP4IgL/z3qxOcVDzpRFgqbtS7f8Z6sS3
 ZuCRhrrMYRoYS65+ssORk4pnwAeMvXgSwLr3cimg/oKwBpEsdwoCiQkUoZBZcMd+/dxK
 PsQ0spJCQ8bRIztBd0p5l3XUXtZ0SyVwVivPEb0u2wfWeGU0vsUcefIN1aia+6oIcPXz
 HkGZyFpx5+J11lfsfNvcJ4ENut0Z08SoVPypNzYikGwIB9PAL1JnTtE2KmrnGIJy1xBO
 J5N12Vn0FJnBNPkUlcFHetscIKXTAysL6vZv6Z2hRnWRtIAFSJU8RQTp9qrGRo2YCFR7
 65KQ==
X-Gm-Message-State: AOJu0YwMeDDLf8gK+kamCYyN/D0X8soBE7AoKscJONdNxPhGFWhZGOtz
 JMAh7B9qaMilita/0lXQSI9v1bx16imBATFGg4CMnhP5SsT+9HZ7oMGfxLmYfLFx7gMViL3tWo8
 qRyHxnSUaEnyL1pyFYHqsvIAtdMDAyexCzESpoad2IIOdoEcOCOKTSwlma13uiZyRtN/AiFma+f
 GRvXI8m+DmfzPjJTL/g/EpRSdQVybb/7Ky+7BJo9Y=
X-Gm-Gg: ASbGncs+Jv5jBQb6aGT5HaL9MbbkTuEb51+Y/Nhy4JSsIzeqhQddF0ltTak40Ob2y75
 J0YvAa/IlQDSTwx6Nuix7fuZZp3YCBQhn1twH4z8RfFe5mhs0R/8LeXBfMf1zx9msIh63QBB2j8
 y+hbDpAlWgjQASX0P/JSBzuRtwUgEWGac6GM4rNUEtfOlIIZ5GETP1Vjd3CgtV0EW7x95pI1CCh
 +BTVvAb0Ei/SS9Cw3b9uu8f63zYO9QVCh+OFvF7l8f/ZZHEaYeWkEHLyCo=
X-Received: by 2002:a05:6402:270d:b0:5d3:d4cf:fea0 with SMTP id
 4fb4d7f45d1cf-5d972e4c62emr9671029a12.21.1736534847684; 
 Fri, 10 Jan 2025 10:47:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIwj9LGgzLXpOlyrrP/5XeuHgE/B/qaqZwaKSFqT8+BbtGDlrD+yBRMx0lARlI0LjGgsEsWA==
X-Received: by 2002:a05:6402:270d:b0:5d3:d4cf:fea0 with SMTP id
 4fb4d7f45d1cf-5d972e4c62emr9671019a12.21.1736534847210; 
 Fri, 10 Jan 2025 10:47:27 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9904a55f9sm1845875a12.81.2025.01.10.10.47.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/38] target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with
 KVM_MSR_FILTER_MAX_RANGES
Date: Fri, 10 Jan 2025 19:46:09 +0100
Message-ID: <20250110184620.408302-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

kvm_install_msr_filters() uses KVM_MSR_FILTER_MAX_RANGES as the bound
when traversing msr_handlers[], while other places still compute the
size by ARRAY_SIZE(msr_handlers).

In fact, msr_handlers[] is an array with the fixed size
KVM_MSR_FILTER_MAX_RANGES, and this has to be true because
kvm_install_msr_filters copies from one array to the other.
For code consistency, assert that they match and use
ARRAY_SIZE(msr_handlers) everywehere.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6f424774b33..1d7214b6a65 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5854,7 +5854,8 @@ static int kvm_install_msr_filters(KVMState *s)
     };
     int i, j = 0;
 
-    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(msr_handlers) != ARRAY_SIZE(filter.ranges));
+    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
         if (handler->msr) {
             struct kvm_msr_filter_range *range = &filter.ranges[j++];
-- 
2.47.1


