Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF62D3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 16:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSeA6-0000tx-Nj; Mon, 08 Dec 2025 11:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vSeA5-0000tg-42
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vSeA3-0001nQ-Il
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765211549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpx1+KoXA9BwiBto7wdCzHwMF2i88yhoCHWsvoYgCnU=;
 b=DqjjWYUUpRAy1lLIOoNMyqbizKA64Ca4C80Pzj48qdFPoj+nO2x/0dX4+vTAngId+PaGz3
 C18Gmwx7jFq+3+BdfFoywtfTScsxtl+b33tIrAYA1m+VFrqmqgkxRI5IbITWVKTUJlUSJp
 GQFb8OdGjE5h2km3gVExLLXfX2H8dtE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-FLc7SHBYMoWH0eJ5wO9vlQ-1; Mon, 08 Dec 2025 11:32:12 -0500
X-MC-Unique: FLc7SHBYMoWH0eJ5wO9vlQ-1
X-Mimecast-MFC-AGG-ID: FLc7SHBYMoWH0eJ5wO9vlQ_1765211531
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ed74e6c468so66316611cf.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 08:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765211531; x=1765816331; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mpx1+KoXA9BwiBto7wdCzHwMF2i88yhoCHWsvoYgCnU=;
 b=a91teJRdSizNEd5LGyfrhLvgUghGIb20NgMHyyyE7HtLylfYB+OBlw5tQvkinYGDik
 lYXZLxCep3orbSG5OCcvDNPfNBqyYZhpU8MlcMxwHrouQ/JtLz8XBq383cZMF842HC49
 OfIDid8ejEHCDhS5iN+Cm92qZflZ8h/4V+YdjfUtvx+zsDa0qc9twBWHPz5Svc882SkH
 ZtvZ5FOEZAGJW82k90e1eyQIY+VAxPZdDEizRU+iiL+UYM6yunSE7WWmvreM5lVY+pcv
 M3S/YGzWcps8hPHebqzLX8DMFuvC+NIUX+a2l+MrVegAhSxZ/OfMPJhXUD8xB3kORItJ
 H3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765211531; x=1765816331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpx1+KoXA9BwiBto7wdCzHwMF2i88yhoCHWsvoYgCnU=;
 b=oMzI6lIKNIPj2SsrAHdw+FUzg9IF6hFTW8poBypsi0hl9bGCt3JirygC66mYhc2RWD
 a7c1Mmw5lqyIhuFpFKWDERYyjVmrc9CtexXmAyuKbmSehHBs9WDyps2ETwhenrWkpG9w
 j5Qxdiw21z4zaP1cDkQSn3Zd8Y0Sag3uh6DqnYouvJr2DMzZ5TtoHXrhDBnYIEi61t1p
 yTER+WHKx35ejopj5yK0doviaW/hf/ejEx1dzuf9Or/6hYHjSLyBXXMY1yP/BHoyys/x
 bHTESqc5tDui7CzwnNtxhP2sH+XJ5KEgE+71GNcVZz3paCSv4igP2wyP7yCxh4hmRPDq
 IxNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf9AJoMSl5HS5GNYI+0y6hvdQpKeG6k3ULoSgVMY1VKIOXUOW1nj8LFFSxwe9il8Yg/4t9tuF5vDDH@nongnu.org
X-Gm-Message-State: AOJu0YysqIgDK4RDRVSq/CI3v3Wr0OJAvCnF9FkQDiscvvP9/DYQyiO2
 L6TxHBINb4kPBip89XdqORlCN6segZJ1xdvVDliYlLJ7VUnqAAF+EY2suflGQy7UM/KzMzYlNUe
 JjfHefjXWiQ9Lgz0175f+VH6+ePcg0cLtDoL2u/aMYz+me4BxjXhCFZAs
X-Gm-Gg: ASbGnctGU0p66fc52cRFNvtKHIH8nggKBU3X31e1UuDIjhmu3a8ma2HZRfLRtI0sn7T
 Z7/lXlWeWloAlPvNBYiDBDW6fwV2Xa6T5RFnNfJ7maqBU1LpjviNZ7iVDWqmUBkp+nQ9+MMx04g
 RSdX3xDhl/NvAsel9HoRKAH/jUrkk94cTmF2l9xYv8c2cWbJ9z8+wDoyBwjLWRUArkrgtnj+kQQ
 CCS8/n7LNRIaoK/O496U/o05OFyWTFtUMW6yX37TIGKnXqsHv62R1ehrodarW4KWY4gcPJKIMpC
 dyUvZGQ7jfKnxEavAxBt4h9Xdj/arBJtc86SCy736q62gc9B5GQLbkf7yuNWKeXI7x88tpRBUMc
 6N0U=
X-Received: by 2002:a05:622a:10b:b0:4ee:49b8:fb4b with SMTP id
 d75a77b69052e-4f03fedbbf8mr128331941cf.66.1765211531377; 
 Mon, 08 Dec 2025 08:32:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI+vumQD0r67kXkI2+XgWRC9XxkHXfiA3CDOFnBh/gbm7f7j6tLBH+AyJQO/ivLMbUixb3vw==
X-Received: by 2002:a05:622a:10b:b0:4ee:49b8:fb4b with SMTP id
 d75a77b69052e-4f03fedbbf8mr128331351cf.66.1765211530851; 
 Mon, 08 Dec 2025 08:32:10 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f0276b0351sm78965401cf.8.2025.12.08.08.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 08:32:10 -0800 (PST)
Date: Mon, 8 Dec 2025 11:32:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration/options: Add x-ignore-shared
Message-ID: <aTb9ie5OYg4zlDQP@x1.local>
References: <20251205172054.288909-1-peterx@redhat.com>
 <87h5u1kmku.fsf@suse.de>
 <6d36351f-5faf-449d-9de1-0db1fedf394d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d36351f-5faf-449d-9de1-0db1fedf394d@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 08, 2025 at 04:44:25PM +0100, Claudio Fontana wrote:
> On 12/8/25 16:41, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> >> This aids scriptings only.
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  migration/options.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/migration/options.c b/migration/options.c
> >> index e78324b80c..30bf9afaf0 100644
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -203,6 +203,7 @@ const Property migration_properties[] = {
> >>                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
> >>      DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
> >>      DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
> >> +    DEFINE_PROP_MIG_CAP("x-ignore-share", MIGRATION_CAPABILITY_X_IGNORE_SHARED),
> >>  };
> >>  const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
> > 
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > 
> 
> Nit: x-ignore-shared or x-ignore-share ? Commit msg and code seem to disagree.

Ah true.. I'll fix it while queuing it, thanks.

-- 
Peter Xu


