Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA12D59D60
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 19:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFelT-0004lG-Dq; Mon, 25 Nov 2024 14:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFelR-0004ki-RS
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFelM-0008UR-MC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732562926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VllPW7dGiy+WACAniERnkQZrC9FYLYAd+AATyo8h5nE=;
 b=h9X0Nr/vzt6dLrx1ArPQhxuL/x3upaKCvoGKTp47R74DAs20d8b7E7P6NPSudqh0lcv3o9
 7cnu8G16Wn9Ku3q3X+u25R8jEBzlJYXAMw8vGw+m+cJdEN13tzw99Bx0xXtgFxvJXCKMfo
 IIIfml5++I0wCWl0V0x9zE7F5NgYaGw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-c3uvMRmxMYGcJ5J5lKPS4A-1; Mon, 25 Nov 2024 14:28:44 -0500
X-MC-Unique: c3uvMRmxMYGcJ5J5lKPS4A-1
X-Mimecast-MFC-AGG-ID: c3uvMRmxMYGcJ5J5lKPS4A
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7b3c63c3aso17441355ab.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732562924; x=1733167724;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VllPW7dGiy+WACAniERnkQZrC9FYLYAd+AATyo8h5nE=;
 b=ZCGUnj2HW1sg2POK5FhdsTBu3pmbAhCgo+wdZzXGeUoQsM3AaryomoyzvW2bVNDjvY
 F9cqihIhmdllsSB9yQ9X16D5W8Q/HhLwcT7HLQnAkR8dpa+IKMEDvw2TLIw4+wFP/MgH
 OPvjv7N0ZTOnRa4E7QbY0zfWlX2CTKHY8k3s8bD88lmK+9ksHOCO7FkVXquFS/enAjch
 grBSDqJU6DgNJ/htdmpjEsbb5nrgNA2Ac3tNNdhL51G5wJEopdklNdeHwXdyGScrDUNu
 T6SADb8EPeJ9umSe4ksiR1oNEFafU/R0izEPIBlDcjrz35/rExZaD4I8OFP/ARri6KmF
 yCVA==
X-Gm-Message-State: AOJu0YzBp8y4h5RmSTv+t8vrHH1wpKPuPBprAY3IYdY4i2kKZQHs+dwe
 gmo0QgHKufIGusl6g3C/rMxV21GW7UNxfZMUmFTUc5YwOSwEPuE1aRryzWSLumTAkdmQqlN7h1d
 8zZVxEXFQI2KZvrCg6Cj2IT3QGpQObaFk96HXKQkhEE4tdY7R1mQ6
X-Gm-Gg: ASbGncvfCHcU0vcoAh08QGFkGghydlinrKCIyVdq7tEns/bMnoSbwWzAopIck87aaGr
 kMJ2HMmzvHZ5WX5945hPVdL8+ZIlMTtGC3bbUmokCEECpOvYoxSuVabxEAwSV6UouVtkT9Agujr
 Vk3EkrEQHznxBhPA+ocHG/bfmsdQmJXnCfSDl1yLDB7hsln9X+2ffdvm1vrezJt1t6jZy44+MdR
 NUGfXLIH8gbn4LqlFQNdNIcHXjugKbW0zRgdWg57wKyJ3TUMkLH9NZoUfiUuUPwmEnr0lsvPGsg
 THOt4AHlin8=
X-Received: by 2002:a05:6e02:152d:b0:3a7:8d8e:e730 with SMTP id
 e9e14a558f8ab-3a79af23627mr121497025ab.22.1732562924075; 
 Mon, 25 Nov 2024 11:28:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIgSsQwK4736D3z2EJmKBN/PDQQK4Ikh+Bf/ILq4smQ00cTtVbKTkvROe1nT52IJxzwTn28Q==
X-Received: by 2002:a05:6e02:152d:b0:3a7:8d8e:e730 with SMTP id
 e9e14a558f8ab-3a79af23627mr121496915ab.22.1732562923774; 
 Mon, 25 Nov 2024 11:28:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a79acbdf6asm18797565ab.77.2024.11.25.11.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:28:43 -0800 (PST)
Date: Mon, 25 Nov 2024 14:28:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix extra cleanup at postcopy listen
Message-ID: <Z0TP6Wmv6DnDPLES@x1n>
References: <20241125191128.9120-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241125191128.9120-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Nov 25, 2024 at 04:11:28PM -0300, Fabiano Rosas wrote:
> After fixing the loadvm cleanup race the qemu_loadvm_state_cleanup()
> is now being called twice in the postcopy listen thread.
> 
> Fixes: 4ce5622908 ("migration/multifd: Fix rb->receivedmap cleanup race")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

This is so far harmless, right?  I think we can still queue this for 9.2,
but I'd just like to double check..

> ---
>  migration/savevm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f4e4876f72..98821c8120 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2057,7 +2057,6 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * got a bad migration state).
>       */
>      migration_incoming_state_destroy();
> -    qemu_loadvm_state_cleanup();
>  
>      rcu_unregister_thread();
>      mis->have_listen_thread = false;
> -- 
> 2.35.3
> 

-- 
Peter Xu


