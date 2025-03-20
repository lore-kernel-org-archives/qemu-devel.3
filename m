Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0543FC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEfs-0007Rq-Dj; Thu, 20 Mar 2025 08:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvEfO-0007Kc-EL
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvEfK-0002Pd-06
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742472383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uThQc2E8ragqKw6JjO9nyh1Qqr/jhvaLXLndjVDzmtU=;
 b=a/KEs3XlBvwgFdVPZ37J29khqvcgYxyGUaVdVkid/uxKqIgFUJ+isSAJ2U160zMqo3UP5R
 GJm+ZdB21EsW7/mnPCnxby78PoMwX/Ma+DZsiH8h8vKxpyVFsa2ZsQMti5+YHVI8jNVa/b
 6CyCH8MqMqeFrrYnOdnGTK4sQybArn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-dkgkRUDNOLa-iKVGhphRLg-1; Thu, 20 Mar 2025 08:06:21 -0400
X-MC-Unique: dkgkRUDNOLa-iKVGhphRLg-1
X-Mimecast-MFC-AGG-ID: dkgkRUDNOLa-iKVGhphRLg_1742472380
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394c747c72so4032515e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742472380; x=1743077180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uThQc2E8ragqKw6JjO9nyh1Qqr/jhvaLXLndjVDzmtU=;
 b=fwnAIimmdexV2JOv4KgAFnGifT6D4t4OD8wyxQSOHjR1fDAXJXVKm6K89qiz2nN/HT
 XXxhpaK0rSnbrtSqNa2EL+9qID5t5lPxfY3QWeowE+vOMpDbG9N8PlXYgDjXaEjNsQ1p
 6i3Ene+u0fjMc+OqQbfGzzONMPBKU7lB3x04Zfl52JDbFvHn8I7OiYNEyzzAP6iuDp2M
 G45loKtC+1qj4UGiHh16fEDHjo5rCeVmC4Xt+Pb2/IJmun7aOn0lhj0EBhjcU0gJNJYB
 4TG9UB4uV9eJYzBHE8hpKQSoZYLE9u1P4rXxK25dJ6ZLh0TFj0xOZ7oIX9al9/JNfFlj
 ynzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOpoCFmOYL9dKx3mcKSawCoT3E5LXF8Z5004A0qHHc2ukgc5CcI73lLJpYALuFRpVm8GoYbZ5KsrPB@nongnu.org
X-Gm-Message-State: AOJu0YzMD5lqFHM+HSqh2L4rh67FizMfoCauCw23fJTB0vQAmOTGWjLQ
 28VM669skVj7nlzNOeR6gffIPdAAqreTDn1DJkby06GMB/3IJU+g8steBbHxbmFnrsUhea62J1j
 glLQJ2DHOyc/5dd/DlWL7HQS1HgJRhdVBPCqislARKqU987yH0UruRCReqWPlqhBQFVKskzQVj5
 qP7t1JcLTY/82V4TGN9UUFA+/RRU+QwsQEFR4=
X-Gm-Gg: ASbGncv9vabIXZc4yaUXv9Z7gQwu0xH+xk7EoU9BEFmF1pcM9s4bTaC9ectZsCUV6Zn
 nuCUdqABU03p/FxJ04EGGg/sq3jbg9N2CtFxQjRsp1Pyy5i0llmO7+zbRTx2J26+/s/0TD5wcIv
 o=
X-Received: by 2002:a05:600c:cc7:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43d4381697cmr70538395e9.29.1742472379754; 
 Thu, 20 Mar 2025 05:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Wv0RCxiziDtrHYCYRBWqDqbk+OD3++qJY3RinUuCK0Ee+vmfMysXVGnG47/p+o0hYbBxn5ac8QXESWmvu3s=
X-Received: by 2002:a05:600c:cc7:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43d4381697cmr70537845e9.29.1742472379326; Thu, 20 Mar 2025
 05:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <Z8ssc0NETt9KJjTG@x1.local> <87tt84u0d2.fsf@suse.de>
 <Z8tv53G5s9MLYv6f@x1.local>
 <87o6y9t14g.fsf@suse.de> <Z88DmvrNrW5Q1n7y@x1.local> <87ecz4adoi.fsf@suse.de>
In-Reply-To: <87ecz4adoi.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 20 Mar 2025 17:36:02 +0530
X-Gm-Features: AQ5f1JrpZa0UbbiwaPFQ4n7oSLVj5lG97kzG7vr3R7ZlPo9GPKT5opMnj3okYPE
Message-ID: <CAE8KmOwkLoPB=wLuE5WC0HERzmUqAqjP9ZECTvxBELaN31yBVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Tue, 11 Mar 2025 at 00:59, Fabiano Rosas <farosas@suse.de> wrote:
> Peter Xu <peterx@redhat.com> writes:
> > To me, this is a fairly important question to ask.  Fundamentally, the very
> > initial question is why do we need periodic flush and sync at all.  It's
> > because we want to make sure new version of pages to land later than old
> > versions.
...
> > Then v1 and v2 of the page P are ordered.
> > If without the message on the main channel:
> > Then I don't see what protects reorder of arrival of messages like:
...
> That's all fine. As long as the recv part doesn't see them out of
> order. I'll try to write some code to confirm so I don't waste too much
> of your time.

* Relying on this receive order seems like a passive solution. On one
side we are saying there is no defined 'requirement' on the network or
compute capacity/quality for migration. ie. compute and network can be
as bad as possible, yet migration shall always work reliably.

* When receiving different versions of pages, couldn't multifd_recv
check the latest version present in guest RAM and accept the incoming
version only if it is fresher than the already present one? ie. if v1
arrives later than v2 on the receive side, the receive side
could/should discard v1 because v2 is already received.

Thank you.
---
  - Prasad


