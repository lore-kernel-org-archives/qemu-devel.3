Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75109E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZD-0002ZO-2I; Wed, 11 Dec 2024 11:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZA-0002L3-8r
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZ8-0000L6-PY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MXfVs/g+bvC1GKRwZEGvjJF+Epo24jQg+cJnZuvvCU=;
 b=Eb6zal7OtHkDPLrcaWPi3kZS7J9VfuD8LzCDrU/kBgADoIlqXpqRi0WiXACdyqMe7OEFRf
 ayyrM47bSy+v6hGvpFRSq4v4X8KjVg5WzAQVpVOYoYS3AhDrg58hRLX/AUCqlAXe+4jQ/J
 pSE7iTcjMM+s1Cq+TfWrWTdyM3HS9WM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-EVFyI356O76RMSHo03Th-Q-1; Wed, 11 Dec 2024 11:27:56 -0500
X-MC-Unique: EVFyI356O76RMSHo03Th-Q-1
X-Mimecast-MFC-AGG-ID: EVFyI356O76RMSHo03Th-Q
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46790c5b1a5so14449681cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934475; x=1734539275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MXfVs/g+bvC1GKRwZEGvjJF+Epo24jQg+cJnZuvvCU=;
 b=Rq1e2aKJjFkpTwNWLcBuQ+ksubafhLaRyOd+ALr3h2EXsEMZods+FiRr/u1QEfnbDz
 dSTwRoumwSziuk4tSx0hJDhL2l6xJ6gEdOENI2q6AErGPolwjmdZ/z292tA8q1eR5LAZ
 193CZ4VmOSIsseEF+ppYKqI2AAufpr4K7eItbeu2W5B5QdYwICOS1eMlNyuGeyTBmFJL
 0Xftq4LpxCJ8OhuSta+g8AygHJVz0CRV11NMlcD4kq0SKRcOGTXvFRWZdYIoplolm4ec
 cDHpTaQYDoRumhLs0Q1qBS4X4u/ZONN41JIhKnNOPVs00PDuVJNWq83J8c019l9Nsfq8
 Pn3Q==
X-Gm-Message-State: AOJu0YyuSjXH7LVs0DLyPX+kyo0wHvad3HZe2B/GJEHQuPcUjxw22Ouz
 t7Ue1fzsKC9vgXskCLWpEkxQVq7lR3xOjyXzKZZ4YaaDE0CfRiEpIgU47COLhnbvRrmTiSlQX2I
 luJh2/+y8RWw4QEM1uc+Rt0fCeCRXrbBg1g9rD0oLbsIWU+A/twwau6RxsfZF6KGmYfGRNIxQmn
 Ia4j1BiICInUzMhcCAXaw1MNEeAfP6jmlz2ims
X-Gm-Gg: ASbGncsVbLBxg2z7zSVLSj0cwSYflpoo3P1k54x5oPTWyiD0FVXGa9F5rasBaAWpG0c
 aoVjhzpxVkMRbMky8CLEeGt3M68FB9QdE36R7OUotyZpOvU9vlMEBNVYRNZTOEfYnIzCgXrbzHg
 mpjLQVT/z5NxLizecwBPf7GN4m5kp5wxMURsHtqnOBEP8L2/rYDn5iUFwW8BtUqZaDF/X5R8zcv
 OkKNLNjaJGGJqcinCLKOVmPqu3u19r9zW2XSU8PZiOoSTEEVs1plhgn
X-Received: by 2002:a05:6214:c8b:b0:6d8:a148:9ac1 with SMTP id
 6a1803df08f44-6d934bbe3f9mr58259836d6.47.1733934475666; 
 Wed, 11 Dec 2024 08:27:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZFaVyeVL6o0TvT8PnO1wf7MO78cONiIk7NqVF8a3cWsi1jHTw/VOks2DAYUXtcGeE0ONDkA==
X-Received: by 2002:a05:6214:c8b:b0:6d8:a148:9ac1 with SMTP id
 6a1803df08f44-6d934bbe3f9mr58259406d6.47.1733934475170; 
 Wed, 11 Dec 2024 08:27:55 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da698c4csm71249116d6.51.2024.12.11.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>
Subject: [PULL 13/49] rust: fix doc test syntax
Date: Wed, 11 Dec 2024 17:26:43 +0100
Message-ID: <20241211162720.320070-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

Allow "cargo test --doc" to pass.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/zeroable.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 13cdb2ccba5..6125aeed8b4 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -7,9 +7,9 @@
 /// behavior.  This trait in principle could be implemented as just:
 ///
 /// ```
-///     const ZERO: Self = unsafe {
-///         ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init()
-///     },
+/// pub unsafe trait Zeroable: Default {
+///     const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
+/// }
 /// ```
 ///
 /// The need for a manual implementation is only because `zeroed()` cannot
-- 
2.47.1


