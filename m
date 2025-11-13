Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D2FCD5BA7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 09:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJTpV-0001Wy-KD; Thu, 13 Nov 2025 04:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vJTpC-0001J4-Vt
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vJTp7-0001kb-Mx
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763026856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9GvMDSY7jNsSjzu2161UzLQSFqFcHJOTFbGhBcJlpio=;
 b=PICNzQbdJiuPT6oUEMCXZ3Yx1mS+urpSbquRecW3pHhsq7bH8VacTmcTBqIhRVXNnLJqq9
 OcncWGS8+hLM0xZSBc14aeV2Y2EJQNG9PSDUHGJrh+o5iu1XWRnz/uxvnxpWhqBBXbsz4s
 6FzYVKaEZ5eIB6Eu4pyNHD6HykHY/U8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-hgmjgIQ0NfSpexcz-O01og-1; Thu, 13 Nov 2025 04:40:54 -0500
X-MC-Unique: hgmjgIQ0NfSpexcz-O01og-1
X-Mimecast-MFC-AGG-ID: hgmjgIQ0NfSpexcz-O01og_1763026853
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429c5c8ae3bso429082f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 01:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763026853; x=1763631653; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9GvMDSY7jNsSjzu2161UzLQSFqFcHJOTFbGhBcJlpio=;
 b=LU040wQg/gYj/SWsRG8DCtAUr/7U3ctBkHTqduwqyMhhiOTC5EOw21cuqTYnhQENG9
 tsSI6sR9c6bxsKGqwZJ2yvJ8bmHyW4NA4atxtuOZWnt3jDUvJm1ApiaQjZhFfJreGOXO
 jdb1JZmb4LUwRoFxeIZwblZ0tdRXCTmOCZKIrttmd1KDxMl51Q6gn7lZ6TVRKoRhlewV
 AfTmTnPswN2xrNKIipjaHg6S7+TOUGei9QHQlyf7LtRtsl787EF3KQF3tgU+0sJ0URpD
 AlO67taS2VQ+iZgzoXFa1W5iP5VZkU+kcJ5WvMVRIddLIZoaa+OmhM8sbwEYtgCb+Qx/
 N7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763026853; x=1763631653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GvMDSY7jNsSjzu2161UzLQSFqFcHJOTFbGhBcJlpio=;
 b=seRhC0t4fmxbIl2nA7eev2/yL7DnS7bY+Ugr25vFKkj6PGB1DlsZn+qz4MaHKUQoVl
 FOBnKU4mV9VjLLVGGIQCNpmSgQQzINY+GhPPhdb6VNeRLtEK0IuICusvYGlFmSJhQjOX
 FY7iSRmWsOH/EWQneoXg/574+TfYl+x5KjO6v5/orGtglQ+VfgX6BO49EFnwbH55BSAJ
 oz8s5nqWRGq0pby62sqzRKXZQwaGMl56MiYFvHJj0nHS5Qa8l2g/4J/nbIUHZTtKqHd5
 07JJb91asIvYrioLM7rlDLSxQewvJNT44G09rc0l0DswaPT4klZtPq+ah6/EslbwTmef
 EcdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx1on1SFnkgxRQslt3ekHqeXK/fDKs2HkhA2HfLhaNcWzDkSw7wN4F83LlB6mwQBDDokDxcc/Yf9ze@nongnu.org
X-Gm-Message-State: AOJu0YwTkFGaoDyRbUIdXACgCu2vcMxaxpFtNAmAjioFZ10MJb8O9kVi
 YBVE5Mzq2QWjdNo1vhI+o2GxWlsCu/iCQmdWLrWuhyVmx6PgAY9wmUA06HAUd6gdcRIHO+4JEc+
 10RRUiIaBIjXJauhOfJV9Tmi9t2MS27jhsRHuCMFxnI04h6HeJ9hYWBJ5
X-Gm-Gg: ASbGnct/ULpvJhDcctshD4YIVxwKouGWAEKU8nuJTskHkzgsT1xQkH9FecKHRjbLyCL
 1Ogic68M4P7RWIMN9KSKzpKUELzYDxloLWWw9Yv+Io++yJ+1+Xj3kDiptgdqQhhx4/3hI0hTMM1
 snZRJHT+Nmn3XuyU1IurYtDUsNV+AJSMyE4AB1Fi1Gh7UZuq0M1L/7wuvWjdO85e+zr74yOMTUE
 onqhNCSRidsPbr5QSh0cIi++GWxMLyPMiMzaW1pE0JcJ9uCvUihZzO1cDoTQpUwJVTBFZjvncFI
 3upO8bSw+XakMi6TZc07FeXQHE0z0J0Q2vHtp0twtYOUM3eRtq1G5D19kQk/ZLGmLyio7fv83oa
 w6qBfpq1LTUFWp/WB2l1NkKgTE/ibk37kwbI5MVZ22h79SSZIxTU=
X-Received: by 2002:a05:6000:2c0b:b0:429:d66b:50ae with SMTP id
 ffacd0b85a97d-42b4bdd57eamr6106755f8f.57.1763026853418; 
 Thu, 13 Nov 2025 01:40:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRr/gKkewueXISDnL1vNOogkWeyfa21d2qHynuScK/D/nbVtG/zBBBIDM3WWogxFs6K19zhQ==
X-Received: by 2002:a05:6000:2c0b:b0:429:d66b:50ae with SMTP id
 ffacd0b85a97d-42b4bdd57eamr6106721f8f.57.1763026852942; 
 Thu, 13 Nov 2025 01:40:52 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae88sm2825790f8f.6.2025.11.13.01.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 01:40:52 -0800 (PST)
Date: Thu, 13 Nov 2025 10:40:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 david@redhat.com
Subject: Re: [PATCH] virtio/vhost: don't consider non-MAP_SHARED regions public
Message-ID: <yhrdm2lo5gvbpdn6emn3iwjxu4oa42aol26hoo3j5vnvycvnbx@uwgeim6b257q>
References: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

CCing David

On Thu, Nov 13, 2025 at 11:58:42AM +0300, Daniil Tatianin wrote:
>Just having a file descriptor is not enough to consider a memory region
>public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
>writes to this region won't be visible to the vhost-user backend, thus
>causing it to read all zeroes or garbage. Make sure we don't pass such
>regions and include that to our definition of what a private region is.
>

Should we add a Fixes tag? Not really as bug fix, but more to make it
clear that this is a followup.

Fixes: 552b25229c ("vhost: Rework memslot filtering and fix "used_memslot" tracking")

>Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>---
> hw/virtio/vhost.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 266a11514a..eb098a25c5 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -591,11 +591,13 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
>         /*
>          * Some backends (like vhost-user) can only handle memory regions
>          * that have an fd (can be mapped into a different process). Filter
>-         * the ones without an fd out, if requested.
>-         *
>-         * TODO: we might have to limit to MAP_SHARED as well.
>+         * the ones without an fd out, if requested. Also make sure that
>+         * this region is mapped as shared so that the vhost backend can
>+         * observe modifications to this region, otherwise we consider it
>+         * private.
>          */
>-        if (memory_region_get_fd(section->mr) < 0 &&
>+        if ((memory_region_get_fd(section->mr) < 0 ||
>+            !qemu_ram_is_shared(section->mr->ram_block)) &&

Maybe not for this patch, but should we introduce a
`memory_region_is_shared()` where to do these checks?

BTW this patch LGTM:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>             dev->vhost_ops->vhost_backend_no_private_memslots &&
>             dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
>             trace_vhost_reject_section(mr->name, 2);
>-- 
>2.34.1
>


