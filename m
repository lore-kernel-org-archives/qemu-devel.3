Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE86C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 11:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSa1B-0000ak-S0; Fri, 20 Jun 2025 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uSa0z-0000SD-Ug
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uSa0y-0000rO-GL
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750419273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZ2QZnPk97NrKa3O9VQVTXVUjDfhhyxB5h7+m7eLIhw=;
 b=VGkMaHCYwS6NpxccIoZvonegWVh5+MZRagW4t16TWfxlZ77Gd1Mg8n889BSnmddfliIItj
 b+h1DqiQMTU5zOcttl5fnI/CrvOYRWnMsoY46INmosOek0fYVJ3rwh/++dnIeM+TuGxSHt
 1GZAXT1+C+87nbljMmaMU3txv5lfIIc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Z6Vfn7HUP8OV9a5USO0ZwQ-1; Fri, 20 Jun 2025 07:31:48 -0400
X-MC-Unique: Z6Vfn7HUP8OV9a5USO0ZwQ-1
X-Mimecast-MFC-AGG-ID: Z6Vfn7HUP8OV9a5USO0ZwQ_1750419106
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235089528a0so14731955ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750419106; x=1751023906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZ2QZnPk97NrKa3O9VQVTXVUjDfhhyxB5h7+m7eLIhw=;
 b=BEgmzT+hSRHcAuRMNfpx3UliwQnCohNWujn4pdXZsE/mQdgwTKv0zwee1c1cC9edFD
 1dw76PuuxeK6R3oXth6dVEN5u3C5TPTTQWcz5SML+KwTFLmJxffRCWiGT30EX3rPTc9f
 kl2BZW8cVlcnzHoPes5/KaLYmvNddoouiKe6XyPKRuavedn7cFN5PD09R8YQ1eS4AFkS
 oZRWo8Sd2BhZxuTERwGJ5M8k1Mkedyi30jqOwf98Y/JQDpIqHqqRKFGXFV5iJDD8BsdO
 cMJMDnkDfhrY9uxy6AtEJJezHJdvwgXUUu1vR25OfJOJVqcwva0Wo88nNPFyZO+U9Znl
 8KXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0W1QuFIONvVRq4csgKrt9ERcN2r66Ebq9cRcC/WnROIB9Sloe3Us+gx8/NFR9eHEbo6RT14SYh5/P@nongnu.org
X-Gm-Message-State: AOJu0YzdgtBJcjgVmp4SbVaa30pZ5yh/q9KXyuYutRv7nanbyGrE4UQN
 9UNH50E4cMIW6gdbG98RubSax6RCZqmfW5xGBTn/kGNavEK93vkx3HzbeIsshmBgE8qCzhlJGO2
 RZSb7fZPFNIRKgNl/O+7uj61lbnHtAM+MfQWFuiGGWFeyDt7lNRmtSjitn55kTzMWXplI2OGsad
 CaHx7PMipx56StRIDMCeRgEAu/9WSCArY=
X-Gm-Gg: ASbGncvyO8wTY3z/SD5VRzGNJoWdwMycUKMagUIelkZ5rB1dvhd1cnnZe1yIinuPTxX
 pYb4XfR0srmBJVaywh/7KPXkdUNuETN4Q6YmalcuUITQCNigKGzxlRuRmkbIK4CbGkofQjRno/q
 TlwVw=
X-Received: by 2002:a17:90b:2e04:b0:30c:4bac:1da1 with SMTP id
 98e67ed59e1d1-3159f52d0fbmr3431272a91.17.1750419104503; 
 Fri, 20 Jun 2025 04:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGEeWQj0rE0XivnoPdOWx7MXgR4Jq+cZRYW4g1dVm+9AOfgXb2tdvlnwgZqqoZKDwbyqsWnl6rPGqwaR0Xiys=
X-Received: by 2002:a17:90b:2e04:b0:30c:4bac:1da1 with SMTP id
 98e67ed59e1d1-3159f52d0fbmr3431231a91.17.1750419104054; Fri, 20 Jun 2025
 04:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACzuRyy7p6FPeu6qugzihecOE8ET-wA87+NTBGscdO4B=HLsrg@mail.gmail.com>
In-Reply-To: <CACzuRyy7p6FPeu6qugzihecOE8ET-wA87+NTBGscdO4B=HLsrg@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 20 Jun 2025 13:31:32 +0200
X-Gm-Features: Ac12FXzCyOveHFuXEEtQ64bJ_LO634eAd3sUVWneKPZ-b4MaOEjPDJmIXrMhJ6E
Message-ID: <CADSE00Jr=bjO5YUBGnbVm6gOuhuaKJLu8u3AV8y7YfznftZUiA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] vhost-user-devive: Add shmem BAR
To: Dorinda Bassey <dbassey@redhat.com>
Cc: alex.bennee@linaro.org, David Hildenbrand <david@redhat.com>, hi@alyssa.is,
 Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

On Fri, Jun 20, 2025 at 11:08=E2=80=AFAM Dorinda Bassey <dbassey@redhat.com=
> wrote:
>
> Hi Albert,
>
> Thank you for these patches, just a small issue you could add to your
> next series.
>
> >
> > +
> > +            memory_region_init(virtio_new_shmem_region(vdev, i)->mr,
> > +                               OBJECT(vdev), "vub-shm-" + i,
> > +                               memory_sizes[i]);
>
> Here, `"vub-shm-" + i` looks like string concatenation but uses
> pointer arithmetic,
> which could cause a crash at runtime for e.g., when `i` is > 0. I
> believe you can use
> g_strdup_printf("vub-shm-%d", i) to fix this, it constructs a new
> null-terminated
> string like "vub-shm-0", "vub-shm-1", "vub-shm-2", etc. If that was
> your intention.

Nice catch! Looks like I just didn't completely switch to the right
syntax when working on this patch.

Luckily, on patch 1 of this series I used the correct string
manipulation. I had to double check.

>
> BR,
> Dorinda.
>


