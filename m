Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91494C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 16:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkSL-0001qh-NN; Thu, 12 Jun 2025 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPkSK-0001qL-2h
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPkSH-0004Rf-WC
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749744421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pKjej/MABeu4JRitk+0NSroN6AmyQ/SycGLAUuPuzXo=;
 b=GUO65wx0liSImGb3dzjhEP2gvfdTMt/D6vcP2BUKFpYlhuU0za1Cu0VY8enBT8oG2AvKr6
 KDh5OURwRGbBtqBq8HO++YTiYkC9mtGwvswmX1ttLLEF+9UKNq7hU1f28NKJHLGKwmxkXu
 nRrWMqpGAMIuBgC4OSy4K3imGzGC918=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-npmG7EWhND20buovDcCfpw-1; Thu, 12 Jun 2025 12:07:00 -0400
X-MC-Unique: npmG7EWhND20buovDcCfpw-1
X-Mimecast-MFC-AGG-ID: npmG7EWhND20buovDcCfpw_1749744419
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a43988c314so20909601cf.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 09:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749744419; x=1750349219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKjej/MABeu4JRitk+0NSroN6AmyQ/SycGLAUuPuzXo=;
 b=L+LQsF/A7HA4sD1meZ3uqMf4GEe+HL+r3Q39v8HmyLkbitu6GqENYMgTb6D6DGfHp3
 Up+CnNyJLkOtLrQIlRX6Z5kjlaE5I6MgeyuegPsG539FsxeuVKh1dH5+gBXTzIqxdtM8
 hsdNaABgl/oGWc1dfBICRQp1uGK6FP74AZzcnWSOvUQMaTFzYiAeWLes8sSew0Wmxr3A
 KhHTEDDbc+hdI5j98BKfho0TtleojPD74a507qNEtfDXjRkMebNKzwP+svSKXoufMONi
 GDf7ifryfo13nmzg5hA2EfZb5iXOHuzFCLlEjevEGPoNONE0oNrt5BkuKEkInW5xKXOg
 hVDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBdT1GcDEBD5v2dWWmYkaobyYXaqxsc/1zWkElQYJWaQC7sCVHK/kXeUJwhDlgC5wS8WSjwZZFLYX/@nongnu.org
X-Gm-Message-State: AOJu0YyOI6FoMpH2x66Uz4dmMjwLVPYXQJXfFta83gsBBgj4ceJv6jvL
 8G/ekCnMEa4qtu7nDs8KlplrrHxu5hZc5qV2ryBOu+hwg1LOXqKIHuPZxhYWkgt4F0N4jjx9TbN
 ccXcbHXJDpsOYt6q0oxAAAV7J6jhout3B94ioYSivxnrz6Lm+DzMeaeQ0
X-Gm-Gg: ASbGnct9/Tp1hMTh/5YW1wY1hnaEfVdwQOhTVjWN1QRzTVhQdq08XPXQUtLXGNI+lwa
 yeJu1ux4Sl4f1AGIxJSQxEATs0OUk8pc3EVaZ6K7Kqt2gFewQ0epilrYDzPMFYlCDHj+BMHvItM
 nqTbhoIoz+jrP4AjkQQdGYVlOoUBrPI1HQoJiZG1Seg7eceDxy2eVO4xYZz8eHt94q3oKDjmGVM
 A38GHqtb8T02tw1RHVgwvP/odv/s1O/n3Rkoc6UHou++Buo9JvkzLV1ScWxuGwKViA0wgk+29Mx
 28VYb+kolKRmSw==
X-Received: by 2002:a05:622a:1dc7:b0:4a4:3963:1e10 with SMTP id
 d75a77b69052e-4a72293f4a7mr75656321cf.13.1749744418519; 
 Thu, 12 Jun 2025 09:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYP0bbswxMGpijqCJF0DJEMDMYebP+S+3Wl5OEwQHx6OV3lV73xXp5jh7fgUc5GBuxTBnkNA==
X-Received: by 2002:a05:622a:1dc7:b0:4a4:3963:1e10 with SMTP id
 d75a77b69052e-4a72293f4a7mr75655931cf.13.1749744418054; 
 Thu, 12 Jun 2025 09:06:58 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8e1cf5esm56574885a.49.2025.06.12.09.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 09:06:57 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:06:53 -0400
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>
Subject: Re: live-migration performance regression when using pmem
Message-ID: <aEr7Hfk1P0LNV8LE@x1.local>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
 <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
 <20250513161036-mutt-send-email-mst@kernel.org>
 <cac9c790-c195-4d06-b3ac-894320ccbb97@redhat.com>
 <D700A742-535E-43FB-A602-9FFA4F1DAA99@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D700A742-535E-43FB-A602-9FFA4F1DAA99@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 12, 2025 at 03:34:35PM +0000, Chaney, Ben wrote:
> On 5/14/25, 9:59 AM, "David Hildenbrand" <david@redhat.com <mailto:david@redhat.com>> wrote:
> 
> 
> 
> >Because we need to make sure the pmem kind memory data is synced
> >after migration, we choose to call pmem_persist() when the migration
> >finish. This will make sure the data of pmem is safe and will not
> >lose if power is off.
> 
> Thank you for clarifying. I think I initially misunderstood the purpose of
> this code path.
> 
> In that case, how about something like this to restrict the sync to only
> run when it would be effective? If the memory region is volatile then
> there is no benefit to syncing.
> 
> Thanks,
>         Ben
> 
> ---
> migration/ram.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f25ebd9620..24fb29f0a5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3930,7 +3930,9 @@ static int ram_load_cleanup(void *opaque)
>      RAMBlock *rb;
> 
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> -        qemu_ram_block_writeback(rb);
> +        if (rb->mr->nonvolatile) {
> +            qemu_ram_block_writeback(rb);
> +        }
>      }
> 
>      xbzrle_load_cleanup();
> --
> 2.40.1

Looks good here, I think that's what I mentioned:

https://lore.kernel.org/all/aCTHwhrXROReEPEh@x1.local/

But I guess I got the use case wrong; looks like it worked for you.

In that case please switch to memory_region_is_nonvolatile(), and add
proper Fixes, and copy stable.

Thanks,

-- 
Peter Xu


