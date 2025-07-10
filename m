Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AC7C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuat-0007IN-ON; Thu, 10 Jul 2025 12:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uZuKN-0002Ls-Jx
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uZuKK-00012s-5d
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752165649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QJiFa3InfTk6WTOrJuQKKPNrT30F7JG6dTyP1o1ErIA=;
 b=O0zYGNRzwHXatiZbBHY9KzAYT+844SGRKXvxzDx+NWw7LKrZlnKMeEcxNjsDJt2HFIRAIo
 DghDabMaifKOwqbssx9GCAwzI4U+RHr2j8h+EgIxd2vx3gj2Y/g2mNK2ZxHEhKNC3Li6x5
 ph4uaQPqMoSva50IAh2cSa4e+9PAqEQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-zcp5QlMhNs6kzS75z_fhPg-1; Thu, 10 Jul 2025 12:40:48 -0400
X-MC-Unique: zcp5QlMhNs6kzS75z_fhPg-1
X-Mimecast-MFC-AGG-ID: zcp5QlMhNs6kzS75z_fhPg_1752165647
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5281ba3a4so459771f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165647; x=1752770447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJiFa3InfTk6WTOrJuQKKPNrT30F7JG6dTyP1o1ErIA=;
 b=SvjAZY3lj7jpk00iDmQ9bOeLXlBxZam01svcxYd7xTc9m30a8OX4lGKOv7XM+S7vTT
 LM9AJDuyvFqGf8f0vhrqi9Ds1Atxt8e34qSMQzLtlaKMWYai1QiKA2e3tlu9uW0lEllQ
 6OlwBVkzoB4o+OYKLv9npHQQUKSH7iPVPmP8VYadqJsCs4Ba0sUrxc2iN7RNJFJpXScN
 kZi34MGxJ37D6ADjrxdKXgcGTeDOFwjXCCROsypZYgWcHIicm/ju1ALBe/OCqNvShPoI
 LR7cEf77FblD7fGn7x9yQmOqEMGSY1WfEkTuYCyXXCTYB0lOWyyt6k662Uef7cpe2ilR
 NlTQ==
X-Gm-Message-State: AOJu0YwInB4INJkMbo0rZN4l/ZI2eZc8GEKT4LoYjhlsbOmH8rXrCdNb
 s6+iPY5QbmMNWWpnMKr9cYwb+JLSJhoQIvWNYeVaAubbhB6+z/nzaq77DBM7860NUU64NHKJZ0k
 NZrbaaxxjAl4k4JVoqQyYGsMgtYLC1xeUTS4Kgdb4J/ZzK0r7O1GgUXKD
X-Gm-Gg: ASbGnctgeDjlVM1n6D8V0B6AGAobWgI6fRgcTb7FkUPEmhGVVQUvSmaEotxTU/vAn+i
 k9XLp8zBZWRHBPBvryEiYLWQQNLK6V52h2B5jSgwuvxk71NQ0xUUugFeVpsT+GzeooAeTUK4fCU
 ieB9liV/KSOU0IXA6qDxqx0wFxOcacYntu/1DFtpeDDXQzUcWMjCB3pHnmUVptAD7zKyCjYgUXZ
 xkPK6zX0rkPrx8kkz0N/5X8M+f4OQvB7fgk3iNWFlYog5T1negDFvY690CI9Rmh8/+Wfk6UnZf6
 yozD49bT0okes4Y=
X-Received: by 2002:adf:cc0c:0:b0:3b5:f168:5e60 with SMTP id
 ffacd0b85a97d-3b5f1880e73mr184597f8f.19.1752165646828; 
 Thu, 10 Jul 2025 09:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCUCpSI0ot8fToiunr+30H7c27I21MG8IndFdyGi/s0KZJTdpJU69DGxw82KsDDgMenuzfCA==
X-Received: by 2002:adf:cc0c:0:b0:3b5:f168:5e60 with SMTP id
 ffacd0b85a97d-3b5f1880e73mr184580f8f.19.1752165646336; 
 Thu, 10 Jul 2025 09:40:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d5f5sm2306376f8f.56.2025.07.10.09.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:40:45 -0700 (PDT)
Date: Thu, 10 Jul 2025 12:40:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: vhost-vdpa potential fd leak (coverity issue)
Message-ID: <20250710123945-mutt-send-email-mst@kernel.org>
References: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Jul 10, 2025 at 04:46:34PM +0100, Peter Maydell wrote:
> Hi; Coverity complains about a potential filedescriptor leak in
> net/vhost-vdpa.c:net_init_vhost_vdpa(). This is CID 1490785.
> 
> Specifically, in this function we do:
>     queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
>                                                  &has_cvq, errp);
>     if (queue_pairs < 0) {
>         [exit with failure]
>     }
>     ...
>     ncs = g_malloc0(sizeof(*ncs) * queue_pairs);
>     for (i = 0; i < queue_pairs; i++) {
>        ...
>        ncs[i] = net_vhost_vdpa_init(..., vdpa_device_fd, ...)
>        ...
>     }
>     if (has_cvq) {
>        ...
>        nc = net_host_vdpa_init(..., vdpa_device_fd, ...)
>        ...
>     }
> 
> So if queue_pairs is zero we will malloc(0) which seems dubious;
> and if queue_pairs is zero and has_cvq is false then the init
> function will exit success without ever calling net_vhost_vdpa_init()
> and it will leak the vdpa_device_fd.
> 
> My guess is that queue_pairs == 0 should be an error, or possibly
> that (queue_pairs == 0 && !has_cvq) should be an error.
> 
> Could somebody who knows more about this code tell me which, and
> perhaps produce a patch to make it handle that case?

Historically queue_pairs == 0 was always same as 1, IIRC.

> Q: should this file be listed in the "vhost" subcategory of MAINTAINERS?
> At the moment it only gets caught by "Network device backends".
> 
> thanks
> -- PMM


This so.


