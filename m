Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F3DE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxXs-0000hj-ED; Wed, 18 Dec 2024 12:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxXg-0000PA-Nt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxXf-0003on-Cj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734541738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cURjf1wKJXJy49cj12PWLMpzRcP6bzYap0XS7DZk/YE=;
 b=WUBu0hcPCM6PSn9zBt8IAOExn1jdUloEwzOF2jO0Hfr93ZiH8CXfMzbm74C3GNJYbzvvwM
 5r7rGkmdT6awH3YDOv/e+oXme4ap5ntrEu89KAuGY3vTeqnoOMqiogbB6bqOh9eLD4Z7z5
 SCxCfXGxOiT4EcAf/a2vsqBmR49MJ+8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-VWJEiy4xPFi2GQQnwzUuEQ-1; Wed, 18 Dec 2024 12:08:57 -0500
X-MC-Unique: VWJEiy4xPFi2GQQnwzUuEQ-1
X-Mimecast-MFC-AGG-ID: VWJEiy4xPFi2GQQnwzUuEQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-468f7e0aef7so55378721cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541736; x=1735146536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cURjf1wKJXJy49cj12PWLMpzRcP6bzYap0XS7DZk/YE=;
 b=sRRWILXf8aL6996mIgV9IHmgTA1WRsmCQPUj0Bo9e8p/tqRkvjdFswKM24LXKVzcdl
 iIcMqYiuk7b2rcQv+hRafl8qStiRNKpE/7JxVpr9oM3GWaP8dTx5BLP/GhbbEjwlQviX
 0SKvs5sHQ3wSLJljDQZlao6w4oqe6QQDMUa4ydLx2t/Q8PGLCcGQdCxjRhcdtjgH9qte
 mdA91gV5SO4eFgZWR8MxCE6lP5JNwXSEaRLCAD3ykc0GEm0CFcTdP+sakkWqQc8pVTzh
 C7mPIIIWFVCEYEa/y2bKqgfSpHxy0rc/0SWKIelzto0LUm3XQed+ttPco0cdFnNGya2U
 IA5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF+WYKuv7dEJEkY0buEk/Z6BBriY1OXckoSykNpDdYvCXln6MXXcBdlMMY40ltE07+FmwRaXfd5YYu@nongnu.org
X-Gm-Message-State: AOJu0YyzWJ+VEq4sMIdOWvQj7zljVhZ4k41NhdWhSGA9xDcBL0wrj3OL
 7Esjjsl2vrH23xQjWfZCtmP5XoXbxsr/AT4xWwBpOlZzDwK/JHrACuCGC1eHryMIy/M5NTGRI2p
 +pR2yV9QNHJNt+hS+6z8DmSFeW3PqfBzQBWS5Ix02UpdBZ21RqvL0
X-Gm-Gg: ASbGncuotTMx3gMDDOGv3qw8zNz53QssqXxXFdOFgSDh2ztYOD/WIPKC5N6JykX3Sht
 agA3puyKOsHtx7fc4pIwmTjeNScF5kEu6l/FjfelHBliH7qt2PxPK45d9AfikvWMJ7OwE57iMiR
 JScKo0ULMYTXhqjHN6LMq7CmQFkb68R16NHOzXitvMEZPd98n911poMoUer4p/h5I9O/sPyIJV0
 z5qYJ/uMo+DazthBGMw9JlVpduGYbnpq0NUNG06JLhZEAQbLzwhntoQqg8EAwfhpFZZNZc85ddX
 Kj/navSTc4x89SsI9g==
X-Received: by 2002:ac8:588a:0:b0:461:646c:b8fc with SMTP id
 d75a77b69052e-46908e1eefdmr59137391cf.23.1734541736509; 
 Wed, 18 Dec 2024 09:08:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmK1MKhE0zInqpSThP6HiI3TSHZOhpB2+slU5FSbc2Z8Z1gRBHrLiDr/mgtjziz3u/SJFpzw==
X-Received: by 2002:ac8:588a:0:b0:461:646c:b8fc with SMTP id
 d75a77b69052e-46908e1eefdmr59136881cf.23.1734541736149; 
 Wed, 18 Dec 2024 09:08:56 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2e93bb7sm52860501cf.70.2024.12.18.09.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:08:55 -0800 (PST)
Date: Wed, 18 Dec 2024 12:08:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, jason.zeng@intel.com,
 yichen.wang@bytedance.com
Subject: Re: [PATCH 3/3] multifd: bugfix for incorrect migration data with
 qatzip compression
Message-ID: <Z2MBpsa8lWC4U5x-@x1n>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
 <20241218091413.140396-4-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218091413.140396-4-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 05:14:13PM +0800, Yuan Liu wrote:
> When QPL compression is enabled on the migration channel and the same
> dirty page changes from a normal page to a zero page in the iterative
> memory copy, the dirty page will not be updated to a zero page again
> on the target side, resulting in incorrect memory data on the source
> and target sides.
> 
> The root cause is that the target side does not record the normal pages
> to the receivedmap.
> 
> The solution is to add ramblock_recv_bitmap_set_offset in target side
> to record the normal pages.
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Jason Zeng <jason.zeng@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


