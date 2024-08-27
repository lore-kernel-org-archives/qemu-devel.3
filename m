Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8240AC54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sivRL-0006uQ-6F; Tue, 27 Aug 2024 08:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sivRG-0006tA-CL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sivRE-0008RD-SD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 08:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724762203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1liak7c9/MC9GNTGPN1Av/PXD+9/Sju2Zq9LeR864fI=;
 b=GnTcIIRC5N3N7GzBzg4YOeHVDdUAsVGpnu87rOTQo8agT3i3n4DDRudFP+pJDMu1d8diyo
 PkXoc5N9kgiknTD53/VIVZ6YgQZxVUpRDhC+yFVNizBzoupILrljMeFnbRWzdLKfCQfXH3
 7+MZZbnYeW+wM4Hka6NoE4polOmbJCk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-rsRZLSycNZalODXLLF4yIQ-1; Tue, 27 Aug 2024 08:36:42 -0400
X-MC-Unique: rsRZLSycNZalODXLLF4yIQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42b8a5b7fd9so32585775e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 05:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724762201; x=1725367001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1liak7c9/MC9GNTGPN1Av/PXD+9/Sju2Zq9LeR864fI=;
 b=S2TYXQQIVH+5y0I2rDrkB+hqL+JqMGr8JIGx+jb4vluHc0KCXRXpyNQ6HfLHFyIsE1
 a/oxt86CwULtZ2Sxr7im+W0FrM5nBUVFKjIS8f82T1UVN5i7nnsS9SXXgsheMMEac/8o
 /A4qZZvQkmioAsW0TRwXxndsUJHpNqpYTc/wVijckN+b9F3hwV6cUlmoJ9CCCS2dNegY
 kLfKSryWRP61SyWZn5fZCZyJcWBdgfuY98rrbLTaxnCPotuudV/Kj7fvYmSk6ZbySbLx
 oOhwdJTzg7AfIHnUfYmbSUi9kEsCHPymKOYmNErsS9keLyAmi/3+VoliPp57W24o/trO
 T6iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh94f+3DY2METsRwErB5KjBaA0J2k8PTNqdgs5JEt6KnwqAVoErfj/Z8l8r+1q2LaXfk2TRz5u7a+2@nongnu.org
X-Gm-Message-State: AOJu0Yxk5SGzXqr9CgTyskZEemNqc9DPJsyWB+iWgaoYHb1WIkZdRh6y
 oakvUr9cqQVX6koClIRN4xC9uVNRGwLH+VfVwe1YeJx97/DwxyrX0p8ubUUNlNiFMRrcnEmwFpR
 BwScAAlxbsGIuXl9Ai79nd5X4rRuiN4qzCYNBBqjXLPqrU3+HXnxcmOZUuWqN0zYroRCYl3vIEa
 iNCnoJEXV2XW4CV6aqqTJ+edYwZ5g=
X-Received: by 2002:a5d:59a6:0:b0:368:4e2e:7596 with SMTP id
 ffacd0b85a97d-3748c7fb277mr2181300f8f.37.1724762200933; 
 Tue, 27 Aug 2024 05:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYy07g8hIqjmA7nwkb9d9JSdqH5vJu2GhUrtGKpMqzKmOA14fHVqkyG4rVfQ7iY81KP+GmUzHgg/eg1PrPO0U=
X-Received: by 2002:a5d:59a6:0:b0:368:4e2e:7596 with SMTP id
 ffacd0b85a97d-3748c7fb277mr2181273f8f.37.1724762200454; Tue, 27 Aug 2024
 05:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
 <20240801101210-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d4485eba.82f2.4fda.af98.6cd4ae867655@feishu.cn>
 <CAE8KmOxPS2QsWOesKg7h_euSV7r-z4NPZ9vMvTLY6tOudqJjuA@mail.gmail.com>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.aef11064.252c.4e66.b54f.0729a2c3aa1c@feishu.cn>
In-Reply-To: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.aef11064.252c.4e66.b54f.0729a2c3aa1c@feishu.cn>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 27 Aug 2024 18:06:23 +0530
Message-ID: <CAE8KmOz1QH_gT=nOvovqTj+th=uMxEvacGxN4ndTYwz=dPxrHg@mail.gmail.com>
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Aug 2024 at 16:50, BillXiang <xiangwencheng@dayudpu.com> wrote:
> it's better to be consistent to use vhost_user_per_device_request for those per-device messages, right?

* ...consistent to use? Could you please elaborate a little?

Thank you.
---
  - Prasad


