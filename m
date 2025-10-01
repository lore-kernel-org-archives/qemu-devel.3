Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE5ECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zor-0006Z9-Gp; Wed, 01 Oct 2025 12:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3zoq-0006Y2-16
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3zod-0007LH-Me
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759336580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1zUbIP6vviuRW4VFH71V9ujzRHESPUdqWcFFykoVNc=;
 b=jSm4EzLvkWQ+Pnt8xlZ5domeyfCcJaze2i92WInr+y5JWFNxvbrDMVtKjxtDO14d8laHu4
 gnF5f8u3OKcbAs9peMWr36do0ITnmG2kpeuiC1ZUOVP7fRSyncWJNG+JROpeobIYJGAMXI
 x6d+vbE2cN7OdF2mUf+W47Nopa9CgUs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-vfSkJxreMJGNoveH6k4D6g-1; Wed, 01 Oct 2025 12:36:12 -0400
X-MC-Unique: vfSkJxreMJGNoveH6k4D6g-1
X-Mimecast-MFC-AGG-ID: vfSkJxreMJGNoveH6k4D6g_1759336572
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-792f273fd58so2482806d6.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759336572; x=1759941372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1zUbIP6vviuRW4VFH71V9ujzRHESPUdqWcFFykoVNc=;
 b=a4lyAdbmrpQFJ2r0KpqTKiLimf+rv0S0mtBrFWIef+OdIMZEgJI+jVjXjTzbVWYq6L
 JdnrXlo4stCFP2+TptlZ8LqEJ65wYpS390ayVsT+g8cWwzEMf7zEWrgbLR1WfUVXVaBs
 ywz30cTdCK2jUk4ldzAmM+ZO/VWXGAsvntXFR7mirBTfm0ZR5Iekc/gtCT5By3hS9Soj
 QMUdp50dn8QG1YXSLwmiy0klEt6Rzdtmyk15k2NNy230HU0W8RZbasCKOG9yk7/w+TGp
 kdqdVqJfRT0bcqDwouW+n8PJUrkpK4gz47iC6NjHcpUahpuHhpptTyTlePD5d1/KccgB
 VkxQ==
X-Gm-Message-State: AOJu0YwZLvoL8EmFvTM6gmpigv46VXxS4CvicUrZ1ayM6ws3aM5DJQnU
 YFuL3TcKVqi4IM2nwG9ZoQKAkOtrhbLKQeGbv0tojOP5qeuDn1MhEpShShjMvYhZFElxdVcfxwa
 +BhtFA/geFAXqPZ/RpVvOEJh8mWyYX7TRzoe5EOqrRCnPrbI/izmy6xsk
X-Gm-Gg: ASbGncu4lp2kBgkHuVMGd4I9cU6YfbXEUNIsPElKQ/HZCDoDAPV0LDhO2I2AxiCZ2DR
 gM4GZShpktYo2r/WwiZj6G1YADkJDZo7MdvxuK22GXDc8qjGIFPT46Bu4f4zQFyO2pmtWVYip90
 8LwN8WOpzVeLaKMEgvDESWOFwZstk2rRCLxsxEDayLdDiWS5duxjj2ldHZoHU0k3DoBWNXZCvRV
 M34w6W8XvL3Zwmlvd59UPSDuHsbjzMe6qTfILY79GBdnu/5cJ+R6UBiiIN55KPtM2usWnKf5iz/
 yh0rTk0dkgIAJ81K5MibxUSaiXUf9UFHKr1BaA==
X-Received: by 2002:a05:6214:2469:b0:823:f922:8f10 with SMTP id
 6a1803df08f44-8739f3c472cmr59597696d6.30.1759336572148; 
 Wed, 01 Oct 2025 09:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiPUJbWtdHsU/sTuqNkS09A7DVu+TUqgMb1NcAWtw0+NDP0YRcbOoc8VqMeFxKiIlkdRRXTA==
X-Received: by 2002:a05:6214:2469:b0:823:f922:8f10 with SMTP id
 6a1803df08f44-8739f3c472cmr59597216d6.30.1759336571547; 
 Wed, 01 Oct 2025 09:36:11 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bdf53343sm812326d6.54.2025.10.01.09.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 09:36:11 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:36:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V5 05/19] migration: cpr-exec save and load
Message-ID: <aN1YekYL7qmtI6o4@x1.local>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <1759332851-370353-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1759332851-370353-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 01, 2025 at 08:33:57AM -0700, Steve Sistare wrote:
> diff --git a/migration/meson.build b/migration/meson.build
> index 0f71544..16909d5 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -16,6 +16,7 @@ system_ss.add(files(
>    'channel-block.c',
>    'cpr.c',
>    'cpr-transfer.c',
> +  'cpr-exec.c',
>    'cpu-throttle.c',
>    'dirtyrate.c',
>    'exec.c',

I'll give it a shot on cross builds soon, but I wonder if the whole cpr*
should be only compiled when "host_os == 'linux'".

I'm not even sure above qemu_memfd_create() is always defined.  But even if
it'll work right now, we still compile these codes that will not be used
outside linux..

-- 
Peter Xu


