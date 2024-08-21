Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABF7C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgsgr-0005ne-Lw; Wed, 21 Aug 2024 17:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgsgj-0005mr-TX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgsgh-0003eG-PN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724274973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCkvWfFxO6wV58nanmssoIuDF7+LHt028Lnj333n0U0=;
 b=PVtCiTaRPydPGGT5TxxaoNEkqfBWI/pUgIWorLDsZa7avC1MSKf2Cnu69QqP/MtkQ8mL/l
 ReSjqUEh1c4LO5ylGLBXBIsrmw1O2VKBAyBItt9Ywp9WdpTq+sP4YRCjmlk829ImHMXTVH
 EkEvlh3RPjPXsOLOuva3T6aJQvMziKk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-9EhcusN1MumUuKFYOClElw-1; Wed, 21 Aug 2024 17:16:12 -0400
X-MC-Unique: 9EhcusN1MumUuKFYOClElw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bb84f0652eso852606d6.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724274972; x=1724879772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCkvWfFxO6wV58nanmssoIuDF7+LHt028Lnj333n0U0=;
 b=lnmZ5Zf+APtHUzj+5EYTv4Xx1+SUJhHA2C2x3yTZDNizVw2oF7Z3r6X1qEbiZFPSKO
 5T6LwdU0lbAA5EOAGQkP5aXll67P7cLRYjGLroWiYIrXwi301FZxYu6y+WDAjJ5j1osf
 TAACW7BwGjT5ociU+htEHgnFbJx19+MnaS9NAPMZ+X6ItbEFpeqtkbOJBuGb26ycxX9y
 DdaWdOi88J4aM8bFTY1PjCPa+kkr2a5da0i9E2wXYx1Jeo/VXwPFz6y8TC0tS4oYf/qj
 xmZQ4zAADm7BOsurbSAnellYl1F8Cr5HbqAJDlQ9xLbmCh7lRAyTWfu6JEoa72m8XbzP
 4mug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDlATrZhU+sCLULzTqTNB7mIPYqoZlKgv+QUExXOcyvPVzuATXkFE9vNATLz+pB+cOPsmLUjyJ8J23@nongnu.org
X-Gm-Message-State: AOJu0Yw1aEvGdvxOZF3jPDLGUbkZZnDFU+GU8Gc/4JjYSBp9DiC2/dnO
 jJupubRVP27o6lB+nUNHAlLVtOSJ7QH9PQF6EAXzSjRfg3TtIU3+xdHzHW9rbvFDRr44BxuaEW3
 MUbSABPJia5x10xRKruzlaIDLwXkGA4djTlR15Wb8qcMvjkRjYonM
X-Received: by 2002:a05:6214:459d:b0:6b5:238:2e42 with SMTP id
 6a1803df08f44-6c156843295mr48322116d6.40.1724274971769; 
 Wed, 21 Aug 2024 14:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyWVyyXE1Bm46+kXBbpKHsqlyejOMwx89qqHtYdsjJyVhMS5DclXlex1mcLKq0iimD3Il0yQ==
X-Received: by 2002:a05:6214:459d:b0:6b5:238:2e42 with SMTP id
 6a1803df08f44-6c156843295mr48321866d6.40.1724274971354; 
 Wed, 21 Aug 2024 14:16:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162de7b4bsm835956d6.136.2024.08.21.14.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:16:10 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:16:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Yichen Wang <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 11/13] migration/multifd: Add migration option set
 packet size.
Message-ID: <ZsZZFwws5tlOMmZk@x1n>
References: <20240711220451.19780-1-yichen.wang@bytedance.com>
 <20240711220451.19780-2-yichen.wang@bytedance.com>
 <87msmg2heh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msmg2heh.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 17, 2024 at 11:59:50AM -0300, Fabiano Rosas wrote:
> Yichen Wang <yichen.wang@bytedance.com> writes:
> 
> > From: Hao Xiang <hao.xiang@linux.dev>
> >
> > During live migration, if the latency between sender and receiver is
> > high and bandwidth is also high (a long and fat pipe), using a bigger
> > packet size can help reduce migration total time. The current multifd
> > packet size is 128 * 4kb. In addition, Intel DSA offloading performs
> > better with a large batch task.
> 
> Last time we measured, mapped-ram also performed slightly better with a
> larger packet size:
> 
>         2 MiB   1 MiB   512 KiB  256 KiB  128 KiB
> AVG(10) 50814   50396     48732    46423    34574
> DEV       736     552       619      473     1430

I wonder whether we could make the new parameter to be pages-per-packet,
rather than in the form of packet-size, just to make our lifes easier for a
possibly static offset[] buffer in the future for the MultiFDPages_t.

With that, we throttle it with MAX_N_PAGES, we can have MultiFDPages_t
statically allocated always with the max buffer. After all, it won't
consume a lot of memory anyway; for MAX_N_PAGES=1K pages it's 8KB per
channel.

-- 
Peter Xu


