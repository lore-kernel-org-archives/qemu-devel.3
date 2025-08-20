Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 13:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoite-0007Yd-GA; Wed, 20 Aug 2025 09:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uoitc-0007WD-FC
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uoitZ-0004vv-DL
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755696627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+jnpaJWaa05lLjx/GprTcC4HHfELwj7ENiYWQAagekk=;
 b=TII2FKH58cv1P3lNhihl2V7mMB696M6320MuEBg1llRSCZ+n4EgGZs/MYPRqrheENKvDNP
 om4o+84aKBSLHHdKVUoWcesPHYOIGnKnXxXa7AzacUWIxs7jTnttKA3prgpXy9fV489SIY
 WahxlOyHCZyEe/FAB32Z/hTOzSpurZs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-PpsdAQY3Mc68fR55e8CcBA-1; Wed, 20 Aug 2025 09:30:25 -0400
X-MC-Unique: PpsdAQY3Mc68fR55e8CcBA-1
X-Mimecast-MFC-AGG-ID: PpsdAQY3Mc68fR55e8CcBA_1755696625
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e8704e0264so1805490985a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 06:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755696625; x=1756301425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jnpaJWaa05lLjx/GprTcC4HHfELwj7ENiYWQAagekk=;
 b=FzTkxfdVsOfQupd3KeRrEBIsVQC2mpWFXwWgl1belh0gBmadPJ0nhWaN5WWsiHFDcy
 M1RyL8ClLZZL6P97evBuPf+BwGqEU7Koq035aUF3Z+g6H/RSx57FrwDFvM2s7go9KwyL
 ym1oK2renP/1/1IzLOKLhzwaZP/R/zxIsxzKcENWO6n9ykM/waM3DpLxGE4y8mm8wRW8
 iFFTPCOY2cLpZ0WF/AT0YvDCVLPG/p3d659CrPY0Oql59OKnPPmJUyU6OFRn3hEzzhqC
 0FZqkXf7e9i5g3M8sQpuI/xxbvWMc94VG/hRRIXp2W9I+Vc/llpGQ+G5GNF50fYuDU1M
 6uMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ7fC4QyOOUjdOGlbJg633e+0jdbsChGqQ7YijdTvZDTRDsYorjGKJCzUuWF1xz1NrI5ZCgoNTC82i@nongnu.org
X-Gm-Message-State: AOJu0YyJdyrIjKNN2sa5V0S0Ejbhn/mSaIqyt9o3OK9AnvduxQQBSB0Y
 O4lAOPOMy8+kx1D5dKda577pJ4Aaxb2ZYv2Y69UHb7xWeIy+825EpJBEsky+z17s/xq5Pe7w4Br
 Q8vKWpAchGU5M7UyxGS8lA0ENIPERlgUTYUOtuFhfgFOGDTq86UGc5X85
X-Gm-Gg: ASbGnctFlSKzLGXozJpI8BEkHPD/GK4tWsdcvvEgmhb+HC3KsnW3xDfdFMgg4BFRKXE
 1DdCX+vKJKLElAq/khP8syEf0lCqBmci5J/Yli21NeYZGGWOeE/lDgfkdlh18txbEx3qzlM2niT
 ChViJRHOktYFCoOwObuoQQCSTVRrmpqSPAbS1B7Ug2MllQb2lEocXsZbPk4gobK/bg4pnDC7Rc9
 /OBmwZxH5SoLxhxOKjBdLSLw63PllC9yZoR5VVOZteUXujbrUnfxp7os6HDQDp1S1BxIgmViwsc
 KC6/w5KPP++OIVdzvYjLd4wTVvz3wK+G
X-Received: by 2002:a05:620a:4410:b0:7e1:5efc:6f6 with SMTP id
 af79cd13be357-7e9fcb78b2cmr304958085a.47.1755696625016; 
 Wed, 20 Aug 2025 06:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6gtish0a/RzCHEJINWFpiq7cN1Z9YEuOC5DDyTSSEGrvAgh59UNzGypZCSBczD9L/12/vUA==
X-Received: by 2002:a05:620a:4410:b0:7e1:5efc:6f6 with SMTP id
 af79cd13be357-7e9fcb78b2cmr304954185a.47.1755696624563; 
 Wed, 20 Aug 2025 06:30:24 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e070b0csm931081185a.35.2025.08.20.06.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 06:30:23 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:30:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Subject: Re: [PATCH 27/33] migration/socket: keep fds non-block
Message-ID: <aKXN4bykrOFE6_cX@x1.local>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-28-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813164856.950363-28-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 13, 2025 at 07:48:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> For migration channel keep fds non-blocking property as is.
> It's needed for future local migration of fds.

It is pretty risky.  This changes the attribute for all the iochannels that
migration incoming side uses, including multifd / postcopy / ...

I left comment in previous patch as a pure question trying to understand
whether the feature is needed.  If it is, here it might still be good to:

  - Above the line add a comment explaning why
  - Only apply it to whatever channel that matters.  In this case, IIUC
    only the main channel matters

Thanks,

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/socket.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/socket.c b/migration/socket.c
> index 5ec65b8c03..9f7b6919cf 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -129,6 +129,7 @@ static void socket_accept_incoming_migration(QIONetListener *listener,
>      }
>  
>      qio_channel_set_name(QIO_CHANNEL(cioc), "migration-socket-incoming");
> +    qio_channel_socket_keep_nonblock(QIO_CHANNEL(cioc));
>      migration_channel_process_incoming(QIO_CHANNEL(cioc));
>  }
>  
> -- 
> 2.48.1
> 

-- 
Peter Xu


