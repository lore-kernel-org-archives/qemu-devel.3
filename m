Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156E0C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgAaa-0000eu-OQ; Thu, 06 Feb 2025 17:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAaY-0000dI-OV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:43:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAaX-000300-7j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738881792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OSMTQsWh/iIHSAjFjNlDzic3kYo3f2A40CU3G3VDEjw=;
 b=AaAhib3hCD/iYbuLKJYRNIz+u95FOQ+NHjQmAW9b4JJBjWUz2+2vL3YGeHGO5Jq2j5TjWE
 rwQzbGotuAYT/t/5UmOWtjh/mSUMmP4hRDpDd73Ui5XXze7Ty8FIURJagZPgSPVO51hIKQ
 RgON25uRszUB2ldkppLtJ0s3oRjfC6U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-YiVKOBMBNIK_DsVJNISR3w-1; Thu, 06 Feb 2025 17:43:11 -0500
X-MC-Unique: YiVKOBMBNIK_DsVJNISR3w-1
X-Mimecast-MFC-AGG-ID: YiVKOBMBNIK_DsVJNISR3w
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e43113ba01so32630836d6.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738881790; x=1739486590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSMTQsWh/iIHSAjFjNlDzic3kYo3f2A40CU3G3VDEjw=;
 b=gOwQXHVsxEQ22lgmxU2kCYruNZn6xKkhdwJp3qWuX6ZEw+JkwopZp3I3PP4w9d9A39
 WftqOSCtPct08tmN5l+EObf+QkjLZY4FmWvVoTt4oQhlib7j/cEXMfAG0gvSRoF0RGJy
 FJANTegRvdLs7BnmNjRCe00lpD1I8lTg6BmPgGpxK/6ZLdsSGP3DpXSwnxQVl3X1qZ6v
 xKSWw00ccn354qWCFsKP7ObQssocfQcrzWfs0eU7G3KPqvqeoAlGfKgpKveKDe9v1iG8
 xcw7J1E2PfM+tDIQyq5Ku6cJct9qyuBYidtrI4Fx2gj6BfJhXTdc1mxrAg1q1c5wJ3IN
 GKBQ==
X-Gm-Message-State: AOJu0Yz2pNJhuNWxnHVCpxzaODteKwxHztw04PukHqahCnny9mr185+Q
 4VZUGoKq+NpBUQnnUlB46AqXHHon/lfvRWL4LCo0EiNT7VL2K0kiyT5SUEdrtXEFwU2HYJUyh3G
 JpayvSOEa5C2Nq2IS5fjBq59PjHvodQY6LDz0brvAe4vI5OZsrMQU2w4ngNAN
X-Gm-Gg: ASbGnctYCaapNNwSLn+H5rEfCBfbbYOhKn3Gjny87ZQhf+JDFpMdBQ2vQWluZysz7ra
 sjf3bpghNPBir8Jw8qEjEKcbOimYCuYr8mWzPV6Ci5I2DWEEnjiVKXnwzSnOHcRbtd8zlvVCY8J
 xxylzqu5MmB5w5N7i7dGMsiBFdwcupgKiNFEG5h4xyrr6MK4Fk6NO3qVA2XjFtJ9nzh0T9+F3dz
 YKv3yttV9uVnPxGMsr0aLl3Qh9MNh4tDaTgGFCHh9cdMkbna4xO8QCbvXBCHuOjehzBfB+DWBPa
 sXYHy7ZEnOinhUb8HZu0qjbTaLKPgy6an3PU5UY3DDD+FF1T
X-Received: by 2002:a05:6214:2486:b0:6e2:3721:f2c6 with SMTP id
 6a1803df08f44-6e4456c513cmr12369286d6.33.1738881790342; 
 Thu, 06 Feb 2025 14:43:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZO09Ana2t3Fiamt+y88pLn+wxsorZ1Hpqq9jHhyzNS3l8a1aLg1UwAU8rnCIpB+WQQTMQxg==
X-Received: by 2002:a05:6214:2486:b0:6e2:3721:f2c6 with SMTP id
 6a1803df08f44-6e4456c513cmr12369176d6.33.1738881790115; 
 Thu, 06 Feb 2025 14:43:10 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e43e6b3c32sm7716406d6.124.2025.02.06.14.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 14:43:09 -0800 (PST)
Date: Thu, 6 Feb 2025 17:43:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 2/5] migration: refactor ram_save_target_page functions
Message-ID: <Z6U6-_oKIwqXz9kl@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205122712.229151-3-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 05, 2025 at 05:57:09PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Refactor ram_save_target_page legacy and multifd
> functions into one. Other than simplifying it,
> it frees 'migration_ops' object from usage, so it
> is expunged.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick below:

[...]

> -static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
> +static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
>  {
>      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>  
> +    if (!migrate_multifd()
> +        || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> +        if (save_zero_page(rs, pss, offset)) {
> +            return 1;
> +        }
> +    }
> +
> +    if (migrate_multifd()) {
> +        RAMBlock *block = pss->block;
> +        return ram_save_multifd_page(block, offset);

Can drop the var here :

           return ram_save_multifd_page(pss->block, offset);

-- 
Peter Xu


