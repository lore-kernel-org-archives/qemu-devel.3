Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72EDC021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfT-00019Q-Gg; Thu, 13 Feb 2025 11:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfN-00017t-MQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfK-0005fX-4n
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flZ23sKzW+B6elEVxHhJ87AEPqM0mRFuz9sf5vBkc00=;
 b=c25duyDSk8oNRD2Dz3MYvsdtm50wu/n75CTHh6jt7Q0ELNSpjqB80E2qyu3BjbtOBHxORx
 X2IkeO9OX5gDbbmi3T758rvU0CiE2Z4kx1OirJYDU8W9rq9SQLr1gMlI8nvwEZHyPffxoe
 cJujd7yKoPT5ieYZyLhErPwVAImnLz0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-fIGJaf7OM12NsTmOWRJKbQ-1; Thu, 13 Feb 2025 11:02:12 -0500
X-MC-Unique: fIGJaf7OM12NsTmOWRJKbQ-1
X-Mimecast-MFC-AGG-ID: fIGJaf7OM12NsTmOWRJKbQ_1739462531
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dcc9653a7so554637f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462530; x=1740067330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flZ23sKzW+B6elEVxHhJ87AEPqM0mRFuz9sf5vBkc00=;
 b=WXOJQtQSLeVtLH/hOtoFvhI6TOG5cLhOGb5SYd3Ds9se3EkmQFO7tEk7M1RjzOUyhX
 RaXXj+cKJghPMxQO0bFZC6AnpeBCcPyYH9cy2nO6zMbQgFaKOMfQ0VkSeUoSbRptR7F/
 RDyAvQiZzohsRbSO/FdjNdFIEo9rFWkig7TuR2jTcn3fPcdvoIOqWw8lDPgsCDOZtzo6
 /DIgS1qJM60uObzZAYQSkbkoP4+Lfe49JXVAwPYJ1V+W9Ewc6CsUJbQPyNO4Wxd5CZ3h
 T+/9L1swxAt6LGhEFA2AWyPodILF0kguww+MZhac1L4d5p+p4lh2NnRu1hykVJ5Zru6z
 IaNg==
X-Gm-Message-State: AOJu0YyZXevMNnWvCX8fJ3+rcHyO1TIRHDPPQka7UJGvWIzymkOIww11
 7bROm0kdtAlgZdovcN2iJTDjoMxTagYGjOTyD94jxh8NXfXxvEkPjjKjAY+jRYKnhLLHHQ+jS/l
 C8DVD5GdLsxxNRciiraULzXBtKWwTvXpib9tkyv/V9ERSwBNBXvHkNvW7KZC8tAF5NiLWZo/ZZs
 XFE5fnGifoDGpEp4JVXetyvZxpE3IHefL4JSsPb04=
X-Gm-Gg: ASbGncuBPi+EVagL/fudAkh33VXlvywIJSyt1L+cUCrYgUqRoacpXxXFgoO5nRWTF12
 1LFalcMjprOlFHU7KX6kJml+TJLixpY8qsj9vVThinUdQV3d3YLMJ14sKyLCC+IcCTFrBw+SuHM
 SAKM2KyYmivSPJPsGTb7drAYPxSTAn+E7o34hWzkd2h8aar6zXGRX2cqT+uXKU5Jt/t/yU2RWAl
 PfzSm2tXB6DmrRV2KbtvekQZfXSz/ieJiu3Z5U0JzyYxLCb+SbLUuyES8DQCVtyVPzIma/36a45
 wKe1tGIfE4TrxA3+KE3WnplWqQFiKnEuoXhVF+2ZukM3ig==
X-Received: by 2002:a05:6000:2cf:b0:38c:5dcb:312e with SMTP id
 ffacd0b85a97d-38f2445d018mr5287761f8f.0.1739462529051; 
 Thu, 13 Feb 2025 08:02:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAuh4oKbmDkTcacFQwkdnf2a719fxZYLO2PbsTtJhqfR7ILUc3zxJIq318R89MRMTWGOcGkw==
X-Received: by 2002:a05:6000:2cf:b0:38c:5dcb:312e with SMTP id
 ffacd0b85a97d-38f2445d018mr5287708f8f.0.1739462528561; 
 Thu, 13 Feb 2025 08:02:08 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d8f1csm2269535f8f.69.2025.02.13.08.02.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:02:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/27] rust: vmstate: remove redundant link targets
Date: Thu, 13 Feb 2025 17:00:52 +0100
Message-ID: <20250213160054.3937012-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 164effc6553..c6dfb609356 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -191,10 +191,9 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * scalar types (integer and `bool`)
 /// * the C struct `QEMUTimer`
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
-///   [`BqlCell`](crate::cell::BqlCell), [`BqlRefCell`](crate::cell::BqlRefCell)
+///   [`BqlCell`], [`BqlRefCell`]
 /// * a raw pointer to any of the above
-/// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
-///   the above
+/// * a `NonNull` pointer, a `Box` or an [`Owned`] for any of the above
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
-- 
2.48.1


