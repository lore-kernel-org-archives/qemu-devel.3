Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6315AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 14:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uewuH-0005j5-9m; Thu, 24 Jul 2025 10:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uewuA-0005he-Tg
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uewu8-00042l-Sq
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753367199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXkkAuahPYZTP9iFeY+KNGa5tzzEebmUZS5U3ecJOhQ=;
 b=iZ4cv571W8Lrrg0NxS7F+xTxwbqsndUT2tiH9GrONajOyaSSrd9/Pu++NzrO9e5kDnwoml
 a0Y0C7XSoFsIdkcmmU9oNVJBJSjjp530pROVh39KNmOPBApDp7VXPVz9lEMgpahRUX0Aoo
 7Hxy92QSAyAw9hvdTxbIXAEBRiOBk1s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-SI0F3n38Od-yc62BpNY2LQ-1; Thu, 24 Jul 2025 10:26:31 -0400
X-MC-Unique: SI0F3n38Od-yc62BpNY2LQ-1
X-Mimecast-MFC-AGG-ID: SI0F3n38Od-yc62BpNY2LQ_1753367191
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fb3466271fso18717416d6.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 07:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753367191; x=1753971991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXkkAuahPYZTP9iFeY+KNGa5tzzEebmUZS5U3ecJOhQ=;
 b=PhQQ2ecpYpd+nvSGojhRQbU4maaThv9AhiulrxwYusZAAIGZ+JifBsCEB/GPSpH1Q4
 Jyrq+0L+RtbDigK2+PpGqN7RWYO+pFyyjlIN882hPiggOa0ZNpmdH8Cu/TJ5pLMpey25
 y9rppUzwhB/TsEaBZoeWlBNy6BzIkwNqvOsnwqO0l1arTdEDISFDw4bFK2ozbn54kX6Y
 DHTiiidYK2wn8At0K/P7TGxfF/x+/KvMA8xRg5H2dLdj3oVo1tFAaWjEIKkdwoeF15Se
 88md7riF6T63ymTDaKl8axA9jYEG4Wa4Crc4eruEfHca7SlvCciUkN5FooUe6eqnl3lQ
 kPvw==
X-Gm-Message-State: AOJu0Yx6OhwLeW1FqQyT4e4zqYUVxOIF28fu5vLzEN65Uq4amN99DbpZ
 Coyranf+FWLSHpiUj002M1drarGyFESQ1B1EoThCQzNAiVBYeC5IEbmo2E/z9z3THM/c154cVRB
 qB8sO9U1MWLI6xv6rsahRWNFOP9coztAU/uO5wDQ8v7CHserk4qlsPXFy
X-Gm-Gg: ASbGncsvrIKl+dV347FxtTJ1GOq2CQQSn6jGSHOZ+f/ea8FmKQFbqSkqcOqQlWHwjQw
 y/qvm20JHpJvNLT62O6jMCB6TyRfkcdM/KqjJctn4F/tGoF56O/LmmTUQUhZYDSOb7KwtonWGTt
 0wJxU4vOH9vtjH286JxQgeGMX7wfzlQ/APZwn3pxb8ODaQRhRxxWbAYHEvbF4OceWLrG5v5zUCL
 Yyk0Ext3jGJ5Wmclyg0o6E5vcCVEVhjTnMjyEAzMDrbxmze7+DG3kyrCzW2fW4memvVpVGZQkfL
 7iNACrpEHMH9gqRN0QvOaSW8CdiR2Ah+U+XjjIcu+u66Ctb2n8C9LJGG3Pw0f7gvR6ROGm9TWtG
 g1SsE/CRO8yw+bwQ=
X-Received: by 2002:a05:6214:2264:b0:704:f7d8:7034 with SMTP id
 6a1803df08f44-70713d9c2b1mr24873646d6.25.1753367190953; 
 Thu, 24 Jul 2025 07:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPvCr7fMygHQkMHpyEe6PGibEKLVdno11to2HJHpaoGCeSYHU/iDsp9YdhxzW15UKV87+FsA==
X-Received: by 2002:a05:6214:2264:b0:704:f7d8:7034 with SMTP id
 6a1803df08f44-70713d9c2b1mr24873026d6.25.1753367190225; 
 Thu, 24 Jul 2025 07:26:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70713491e9dsm10268406d6.92.2025.07.24.07.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 07:26:29 -0700 (PDT)
Date: Thu, 24 Jul 2025 16:26:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] vhost: Do not abort on log-stop error
Message-ID: <vndz6ld7yp7cbzxfda2o7wp4neayoaem25bseprhfa47hai5g4@jbkaiuxhzazv>
References: <20250724125928.61045-1-hreitz@redhat.com>
 <20250724125928.61045-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250724125928.61045-3-hreitz@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 24, 2025 at 02:59:28PM +0200, Hanna Czenczek wrote:
>Failing to stop logging in a vhost device is not exactly fatal.  We can
>log such an error, but there is no need to abort the whole qemu process
>because of it.
>
>Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>---
> hw/virtio/vhost.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Ditto about stable here as well.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 05ad5de629..6557c58d12 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1122,7 +1122,8 @@ static void vhost_log_global_stop(MemoryListener *listener)
>
>     r = vhost_migration_log(listener, false);
>     if (r < 0) {
>-        abort();
>+        /* Not fatal, so report it, but take no further action */
>+        warn_report("vhost: Failed to stop logging");
>     }
> }
>
>-- 
>2.50.1
>


