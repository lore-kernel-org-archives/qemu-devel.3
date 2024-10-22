Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE23D2CDFA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HTF-0002Gd-PI; Tue, 22 Oct 2024 12:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HTC-0002FJ-1g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HTA-0001q0-EF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729613450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvVmwc5NWQ/VQB3j1+hTYbj7MQ65yDmOHB2iGGSPtz8=;
 b=g5/CVmHKs0hbsKEexcOKd0lpNWRb3forz9hmlUUFeAYUepf/lGywFGbaSRJisOQQdQJtGp
 H0PmgqEjoPdXB6K876jWDiGijgNfbb+L67WRi1buEPlUjChhYdLI8Ye8F2gVXyrBbtwS6J
 HrtuGrrFzA6kV2qqpd4oeHiZC7JoBRc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-1xYH17a2Nq-r_-SK4Aac2g-1; Tue, 22 Oct 2024 12:10:47 -0400
X-MC-Unique: 1xYH17a2Nq-r_-SK4Aac2g-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b15c2e3ca1so734870585a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 09:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729613446; x=1730218246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wvVmwc5NWQ/VQB3j1+hTYbj7MQ65yDmOHB2iGGSPtz8=;
 b=ZvbSyYQDcWev5NxDiifGaZe6jfyIiZFLomxuBE22TZwVN/TITkQMRdTspncQvBgD8W
 bna7sa6Hds43bcAularIA8V/cEcieLshRXYsXoRBoYUA0d3dGYhxfMhdMFBB2UyxVA0q
 8l/p4x7wfM4WSjcyyzlchIumoI8ILqiaTKoD5QaIHj3v9rW+AHxRIMHJMwrBAHrFgSxh
 y75LSTKxTsdfs+QF7brk/hIqcQ/THLXznHZSfbsDBFTLaHugoK0hjASBcrElSqXa7NfU
 s7ED33D5HtLwXY3tEY4wzANpywyVZDPaNS98H/1WiEKIAYpWNOjPJvX1k97DiZQG2tfH
 UzwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTJSJf2AUQkWuHT8nrEfZgmGgh5iGFYJnYvC+KS35r/xdAL3YSv/AJ02OvQ1hpwt2pMWTjhAOFDbLi@nongnu.org
X-Gm-Message-State: AOJu0Yzwp43EvRpkfWHmPm0jlYhnN2FLJ0VP/1FAVKgzDFD0eqVkF2ah
 Z767DNEEqjw3sY6cfch/fQAGcFK/iPmCyt3n+o+XC5jZQWDrbQj9dABeLvV90/3deiLBUV+WWJs
 aPmtafqAZJaEGZh2BCkoB7ZEhjgB/WjyXIUW8Vd+x/pZVrX6LgJI2
X-Received: by 2002:a05:6214:4489:b0:6cb:4b70:8ead with SMTP id
 6a1803df08f44-6cde15ebe09mr242888546d6.37.1729613446440; 
 Tue, 22 Oct 2024 09:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwm1e7cIzdJST1t6xIeE35iqjtPudZzNBK8V76TTHvTb+PwNGJUB6jyT2Qh1mjQKmrmL5y1Q==
X-Received: by 2002:a05:6214:4489:b0:6cb:4b70:8ead with SMTP id
 6a1803df08f44-6cde15ebe09mr242888206d6.37.1729613446135; 
 Tue, 22 Oct 2024 09:10:46 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008aca1asm30078606d6.7.2024.10.22.09.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:10:45 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:10:43 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
Message-ID: <ZxfOg4qy0b9jQ4W9@x1n>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com>
 <ZxZ4Y5KSNPcuN8-X@x1n>
 <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com>
 <ZxaHPo7GRPuby5ky@x1n>
 <3e0d59e7-699e-47b2-a6dc-204d64e07895@nvidia.com>
 <d172a1b8-9e6f-42ef-a78c-decb5c9a2944@redhat.com>
 <Zxe2sZLyIa3XbVeZ@x1n>
 <c6aa909e-aad8-472b-a2b4-5c8d0af5df7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6aa909e-aad8-472b-a2b4-5c8d0af5df7b@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 22, 2024 at 04:42:14PM +0200, Cédric Le Goater wrote:
> > So let me send a small patch later to hopefully make all these exported
> > functions (including migration_file_set_error() in this case, logically
> > anything in migration/misc.h) safe to be called without migration.
> 
> OK.

Posted here:

https://lore.kernel.org/qemu-devel/20241022160720.1013543-1-peterx@redhat.com/

Thanks,

-- 
Peter Xu


