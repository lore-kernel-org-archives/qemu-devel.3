Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C081EE020A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 15:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vabFE-0006Ai-BS; Tue, 30 Dec 2025 10:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vabFD-0006AB-2S
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 10:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vabFA-0004OU-G4
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 10:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767106958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sq89PB/aRcuCOVIBt7Sn9cCBLLbnaVHO63YRPBgGCH0=;
 b=g7gp41g0kqlrneEhOiJPRdHPWwYveFicRLDX2QaQGG+A8ZpMHr3cjn14wQCT9cK4Nvy6oV
 IvsGoE+nnsCrxGYkM5Apv004gqP5ABSG++gKiiStBPp/QuaKTsz+6anFwwx4dC2eFAXBqb
 qcqJLXqx1hzwgDrWou1vXDCxuBerH2w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-QGii4i58OuSygmRHypeajg-1; Tue, 30 Dec 2025 10:02:35 -0500
X-MC-Unique: QGii4i58OuSygmRHypeajg-1
X-Mimecast-MFC-AGG-ID: QGii4i58OuSygmRHypeajg_1767106954
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8088be744afso2775743b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 07:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767106954; x=1767711754; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sq89PB/aRcuCOVIBt7Sn9cCBLLbnaVHO63YRPBgGCH0=;
 b=N9eCeQfiEX2F00wxjvzwC9nIjwQT6JwRYiCCwstlvtRxRfrOaKU8YbNqkTOVad4Chy
 eXUyC3RAKZqJeWiNOnJxSv1z/o8nhdswL/Dm/A0xExJ/peZDIBF/LDSKkJ1y2pJsBbm4
 9+GUZX3YTKp5gWQGAr69ZaqFIGl5ZO2wnaa3W+kCRFklHRmJUtQ6o2b/3XA1m8ZinvUT
 BG62olkmjleFyJamh2pMngpgpE8EoRJSEvoIVLfSJLIJFlSQsqCRuegSJjV/KzT3reNo
 k5FKV9SLRZEbka+C22oRkelbxs7j8wsIo65u37/vc+79J5hmtrK9v/G5py5fbF4e3RcW
 OOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767106954; x=1767711754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sq89PB/aRcuCOVIBt7Sn9cCBLLbnaVHO63YRPBgGCH0=;
 b=OcegbV54JUGqYIa81/uVUZhw2IOHQCNv/pzvedqvba6kcLbyNJpdnvwWZMiEzRbdeD
 ZKaaHKW9qLCK080z7uG3GK+n/YjIB2AJjjhYVZ81gHhl4rO9zBiaZbGL1dcOObBl6Mta
 hmwwfL1CF8k/CJJxFCz6cG3zyP8bclqWap1JlBgcDnGG3+QZDaj0DEIBrG5JglAtyPva
 16OJTJ/edpoh+vEAJscUu+o7jxssYIq16iLn6M8ZFwtDCmePL2o+KZ8/F2vXKkwkvdEh
 EogSv6eVrQoSRC5d85qbDdZyNpmYqIM6W9F7q9UD8FhPfeSgsuz0kjLrlsKemjjqQktQ
 biZw==
X-Gm-Message-State: AOJu0YyUAVOIBO1aL+93VPxXGf1yBuExZkMNXBrsN+qvI9yt1IK7ID0S
 RjrZoKwQPU8iPbYXDHkXHv3/4HF0ftceyyqHYljcP3z8A1qhMJ1dxZyjeQYEslIFW41sIhrO+mk
 G2Hr4e+Rt3Uuw1kbRCxqJRsx5fCwU6m6FV4LsDB81m4Wl8Y79EDOTFS+p
X-Gm-Gg: AY/fxX7ZEZkEDOBRfEHTtjfztp3zngYOIZJz54dhz1PGVZJY2ZISnxJqIF2xV0iSuyi
 vzR9M3Z7Er6RgkTmgVc/+sxDkI6+0QulW52VM7y1nP6OUQG5OhM/OP/CN0h6x8l9iYdHUzLw0tl
 MkK+tfUigwL81gbGLxkhJZzpkfESvaOaIj/6e+UI4FTXK3pJBvuny0v+nMcdP0CWR1hQVLsG7iA
 TIi9wD8tGwnW3Gf+n4QvBg86TTC7nZsgLLdXPKb3DH78iatwxD0naylyS/XK+al8SZIRZ1oO2sA
 j1dGVP23D5pvKD+WYB5HPOf+b17NZ7Bwm9OSbmJcbVNZ3gq2F46ISLBAThwljza0PwUasHEuIV7
 2Ntg=
X-Received: by 2002:a05:6a00:1d9f:b0:7e8:3fcb:bc3c with SMTP id
 d2e1a72fcca58-7ff545e4018mr33172108b3a.17.1767106953931; 
 Tue, 30 Dec 2025 07:02:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENrvyz3LlEtlrpwuTRk2iAyii/rdukKduYB32U9F9ZpBNbQddw9OrWgpDNrngw+88wL0OIEg==
X-Received: by 2002:a05:6a00:1d9f:b0:7e8:3fcb:bc3c with SMTP id
 d2e1a72fcca58-7ff545e4018mr33172057b3a.17.1767106953365; 
 Tue, 30 Dec 2025 07:02:33 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm32968532b3a.51.2025.12.30.07.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 07:02:33 -0800 (PST)
Date: Tue, 30 Dec 2025 10:02:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH 0/3] migration: Add COLO multifd support and COLO
 migration unit test
Message-ID: <aVPpg_LwlGFIPfen@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Dec 30, 2025 at 03:05:43PM +0100, Lukas Straub wrote:
> Hello everyone,
> This adds COLO multifd support and migration unit tests for COLO migration
> and failover.

Hi, Lukas,

I'll review the series after the new year.

Could you still introduce some background on how you're deploying COLO?  Do
you use it in production, or for fun?

COLO is still a nice and interesting feature, said that, COLO has quite a
lot of code plugged into migration core.  I wished it's like a multifd
compressor which was much more self-contained, but it's not.  I wished we
can simplify the code in QEMU migration.

We've talked it through before with current COLO maintainers, it looks to
me there aren't really much users using it in production, meanwhile COLO
doesn't look like a feature to benefit individual QEMU users either.

I want to study the use case of COLO in status quo, and evaluate how much
effort we should put on it in the future.  Note that if it's for fun we can
always use a stable branch which will be there forever.  We'll need to
think about QEMU evolving in the future, and what's best for QEMU.

Thanks,

> 
> Regards,
> Lukas
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
> Lukas Straub (3):
>       multifd: Add colo support
>       migration-test: Add -snapshot option for COLO
>       migration-test: Add COLO migration unit test
> 
>  migration/meson.build              |   2 +-
>  migration/multifd-colo.c           |  57 ++++++++++++++++++
>  migration/multifd-colo.h           |  26 +++++++++
>  migration/multifd.c                |  14 ++++-
>  tests/qtest/meson.build            |   7 ++-
>  tests/qtest/migration-test.c       |   1 +
>  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.c  |  69 +++++++++++++++++++++-
>  tests/qtest/migration/framework.h  |  10 ++++
>  9 files changed, 294 insertions(+), 7 deletions(-)
> ---
> base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
> 
> Best regards,
> -- 
> Lukas Straub <lukasstraub2@web.de>
> 

-- 
Peter Xu


