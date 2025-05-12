Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7429CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMcu-0000ot-9T; Mon, 12 May 2025 02:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uEMcq-0000oP-PL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uEMcn-0001j4-ET
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747031211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xz1JhFHycslGjJ/EAn273Q8MY4qag1MA5qB6CFSNj1s=;
 b=i+C5ddUYZAMmCOvB/Og4+s9yAhDwothJW86+l6dNFnKZbrz8uBKLyFj7JpGkZg6rhCNVF/
 rOVnulUbZ566rHIpGGxGxRQPHWOHlAH6yDZxRoTdupZ+ex3g2KtbBpivhV1y+FmD+NxW4u
 VvldhHB6s9xSMeteQJyob6iNxtM3Hb4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-VOgQ4iLFNWCtAibq4VU71g-1; Mon, 12 May 2025 02:26:49 -0400
X-MC-Unique: VOgQ4iLFNWCtAibq4VU71g-1
X-Mimecast-MFC-AGG-ID: VOgQ4iLFNWCtAibq4VU71g_1747031208
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so29875205e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 23:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747031208; x=1747636008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xz1JhFHycslGjJ/EAn273Q8MY4qag1MA5qB6CFSNj1s=;
 b=xPs7P00YkTGLW6qswDBG0cXypdHuKzzN3KL33kE63zuOuGFtCHJl1DxnMSZ6sYTwBJ
 qCjSMKKySGNcGZ2OdZ6vLQVwx+UwvpRrEqO5EUsnJ9dtutvf3sJG9vt2vISBeFCXfdKa
 KVM6ibsAJ6Ok6Ofa7Wb7UJKcrWl9w3Ojcyg5udG1evEpbnk3gVi5xAdZMyrdjOW7WUnV
 fiKTIPR378GMapPVqd3Lg3I1fUmLrw3RcFtfF/saivrq8I15+K4KjFGYrCZwl5OhUUqh
 vxHEkO5sUOjClG8+rl+xPyGiQybnxjNmDdyMlJY6qEkAj/K/yz6ZEIBD/mI8LJz3nYp5
 GTYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSTRidoEM2tKa+kl4UQxYPvOUgx2Y4wtIsF85loEG0pvfEb8ueo1CMmjnn+PRztBwAVnV9pgwdAmaz@nongnu.org
X-Gm-Message-State: AOJu0Yzs694fi9Xo7M2GbMXWnQSaU4/VUegm1Z5F/skeNVKHAwW2GYj7
 qtj8xSGzX7M5uptGt/9CbV5hYw2hyDY86RurOgcGkW60lCmb5jwuqsJGMk/av4LDKSJEACPNcKZ
 FfFIHQZ6FFkiTo+lbgo5sZwRMwvYZ3h+aTlJm0yVqw7g37xABAMO5OUejDsNVtTV/vV/d5btDcz
 NV1ptY5q3CHMWxaG/zBFdn6Qk7hgE=
X-Gm-Gg: ASbGnctztxIIFtHEr6tvbbrScB6SBIcM7T57gkA64zz0fZIBsW2wMS7Q5TsDgd4RFRb
 Y2ORE0/4Js1fu1TZ0SQHZP1iHrdoxhSlzOodmeFUp10mx/eDfRzEVjU3Rj/dz/JzN+2WgKw==
X-Received: by 2002:a05:600c:3b97:b0:441:d2d8:bd8b with SMTP id
 5b1f17b1804b1-442d6d3e20cmr88649955e9.8.1747031208474; 
 Sun, 11 May 2025 23:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE+Pa7A7mr+Jd0YBvPxDJJyDT35l0DUlMlPum/zuyW87u6xw0FbBRLKR3Zs/aRFBzzMum4QxGXojjq5Gswzmw=
X-Received: by 2002:a05:600c:3b97:b0:441:d2d8:bd8b with SMTP id
 5b1f17b1804b1-442d6d3e20cmr88649835e9.8.1747031208209; Sun, 11 May 2025
 23:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-4-ppandit@redhat.com>
 <87ecwzfbnk.fsf@suse.de> <aBzQYslYtUZgXjgO@x1.local>
 <CAE8KmOzi8Zzy5hE2SMdTbMZJQD5_XH34rfEP_B85jstUF9E08g@mail.gmail.com>
 <aB4bGYf-EuGES73h@x1.local>
In-Reply-To: <aB4bGYf-EuGES73h@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 12 May 2025 11:56:31 +0530
X-Gm-Features: AX0GCFuqDmY1M5MO2HC551jzOLl71AZz44JuQktBnCcmjaGp9bFVfw8nMjDJi_w
Message-ID: <CAE8KmOwFDJhFE6wJpTfDBAG4mJ-Xjsfh8VJwqVYLzT3gGZLZUA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] migration: write zero pages when postcopy enabled
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi,

On Fri, 9 May 2025 at 20:41, Peter Xu <peterx@redhat.com> wrote:
> Isn't that what multifd is doing already?
> typedef struct {
>     ...
>     /*
>      * This array contains the pointers to:
>      *  - normal pages (initial normal_pages entries)
>      *  - zero pages (following zero_pages entries)
>      */
>     uint64_t offset[];
> } __attribute__((packed)) MultiFDPacket_t;
> Or maybe I missed what you meant.

* Why are we memsetting zero pages on the receive side? What I'm
trying to get at is, if destination memory is zero-initialised at the
beginning of migration, we might be able to do away with this
memset(3) call and this optimisation altogether. All zero page entries
could point to the same zero page as well, if we don't want to
preallocate all zero pages at start.

Thank you.
---
  - Prasad


