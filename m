Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B675E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxXm-0000Qa-8t; Wed, 18 Dec 2024 12:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxXa-0000NJ-ON
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:08:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxXY-0003nk-T9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734541730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DiYDW3/4hTeAzOzKzCZM18SSCie/twi/yI1bPqLhxpw=;
 b=bDx3SGWV6xJX6DmaQI5U6zPXAVdlXMh4vdOR+zXeW/4BsjRsszTGyakJ3c5NwIWik0rE8y
 YNXdw62woEEsZ5UsEmGWaWulYdj7RMfyGTZlxXgPJlJ7zCm4AO4W13cvG9pLx1ZZKnkZAw
 Qg5IVcq9fnuHJDjlMN8+OvIFVL6QvLU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-XcSls4u5NZ2p6YvZWL59kw-1; Wed, 18 Dec 2024 12:08:49 -0500
X-MC-Unique: XcSls4u5NZ2p6YvZWL59kw-1
X-Mimecast-MFC-AGG-ID: XcSls4u5NZ2p6YvZWL59kw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6dcd1e4a051so124048996d6.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541729; x=1735146529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiYDW3/4hTeAzOzKzCZM18SSCie/twi/yI1bPqLhxpw=;
 b=dynCIV7IwGC/r5yFj2Wvz3WZjdFztydZFCg1rX2ymIu70SQ2ADBkrqOcUX0H8G5kJM
 CpBcd5SJoFWB1Iw8cJCtP8um6wAfQKyJVKb3J+gj9sv/cnmVjbdE0orbg++rO8pLapYb
 KA6AWduiGYOtMS5n/MsZKqu36/n0ZomgH0vv1MZeA6uIOIm1qcM1RZzpsOJWXk0hNeKg
 oBbC0XmDfwPmXVdaHhK719tjVmz8BoR3Gxe/oHZHvwG4H2o8VyPdRDiPTW7vNz9imWLv
 FU0PiP61gmDHHLFOGQf7UD3Em3pOTCZg0Vo0Utzf4IjjT9f/VMT1x2m+VsmOOmVzW7RF
 EAHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPiL0qGV2YnDI09P4N81a//4qeOyf5UpHFMUgEP1/qeMvvsijc06/I+eMrIWMFZ7pG9CAPA8hfFoU9@nongnu.org
X-Gm-Message-State: AOJu0YzwDAumMoE8Sul3Dkr6bYeX+8lCEYqTvkupldquJJljXSWJRb6v
 hXxgtcRzj/2+d1V3tHiM3VmXU13V+5E88JBZ+8QXeMsROU7gH/e6rHsw6GcRJHT5Z/YromXsOI6
 bLzpL0eEemGAMMRexHHKJW0emDP4PU12DCmZNfjJK2E9tb5SEAhln
X-Gm-Gg: ASbGnctthk3cZNdvmfBCEuMdW2IXFFDFgvda9pGiEIcTHlrYWgXaMiL6VulZdmQ2uLy
 snCOCGVXzk7S0WcMl7KdSg7jz9VMqEqlmcNDjBNI2BlNOtMEE/exLThirt/PRB81pNPoZgUQA1J
 JnGAP0BckjSvzuDVk8Vpf3A4Vi8aRu1BZJMsayUslL2Kmwr82geaiKuEYUTVVc2m6uuzwIoYakG
 gI3Vc+h5gH9gNAhA/ynjz4N4ptS8Da/2c5yNsOcJLVbDu0A0YuGhfkm9t2eMsfx4DqSHxvCbTzp
 mozOwZAO5tRjq9cSeA==
X-Received: by 2002:ad4:5dc8:0:b0:6d4:1425:6d2d with SMTP id
 6a1803df08f44-6dd09259bf5mr52768796d6.43.1734541729063; 
 Wed, 18 Dec 2024 09:08:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvau6hKf2uFJbPcAvlNEVMQ7bCghdMASB68OLdeFKG4gTwDWgYUm3f25KwVlLR7Yk167Yesg==
X-Received: by 2002:ad4:5dc8:0:b0:6d4:1425:6d2d with SMTP id
 6a1803df08f44-6dd09259bf5mr52768576d6.43.1734541728823; 
 Wed, 18 Dec 2024 09:08:48 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd3a9c21sm52175536d6.128.2024.12.18.09.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:08:48 -0800 (PST)
Date: Wed, 18 Dec 2024 12:08:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, jason.zeng@intel.com,
 yichen.wang@bytedance.com
Subject: Re: [PATCH 2/3] multifd: bugfix for incorrect migration data with
 QPL compression
Message-ID: <Z2MBnuUwjh7tT1Hx@x1n>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
 <20241218091413.140396-3-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218091413.140396-3-yuan1.liu@intel.com>
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

On Wed, Dec 18, 2024 at 05:14:12PM +0800, Yuan Liu wrote:
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


