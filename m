Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C08EE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDn8-00060j-Cj; Thu, 05 Dec 2024 10:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJDn6-00060b-UJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJDn5-0005Mw-DS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733412558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ic7UfRblpCXYeCXi37hXd4Y8DeSTJhCz2btIMOLhVgs=;
 b=W8ajKrWhHmi8Ys5yu7QpXa4lP4NqfseyOiIVZ3p1Kw/JrrL5Sy6C6WomMQCcUXzexIe/xZ
 LKh0bA7LSI0DuqgrJHihpmQGI7WHyRPp/Li/PwQlvmiZvaPy9TWbZBYSGcmPFPpyGssgTe
 b34RgiBL9Tr6jRIcOirSXW7uY1T6Wvo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-X2k38UsjPq-X8EJkiztQ9g-1; Thu, 05 Dec 2024 10:29:16 -0500
X-MC-Unique: X2k38UsjPq-X8EJkiztQ9g-1
X-Mimecast-MFC-AGG-ID: X2k38UsjPq-X8EJkiztQ9g
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4671e52ce77so12004551cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733412556; x=1734017356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ic7UfRblpCXYeCXi37hXd4Y8DeSTJhCz2btIMOLhVgs=;
 b=ZWAnWTTPHo/4XeCY1ByGG7lzjIjJebPRMcvjjAwGCr6kowObPWwX2ZaCpnePDSyrIH
 0qdH6NIzB3ULRH76zrxwLeZUQxLMMopFcTecLvs5jdjNVkPf5n487vcUNC7Llo9FIH9q
 dznQiF9B94l4HMh1faOgQCfvT0fo4fIQZ2juelJlGQ0qf9T8W9BMjVq4k7pQtsh/ca3n
 GNF1YsYGbEGnqebccIbComAd9pJaB8AaKV9Ik2854j9wXh0uZ3604opjBT0eSUZa4a7T
 +u7Pj5GgA5qPqpudyUcSuckX9vuQdz38aGlaM92UaHMbgV2ZbszY34/Vo5WIFouQILA9
 OXxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6dirXku64lbF7HSM+4Yzq/qM0Gd78Toj2WhYQpNP5XaPsuXFc4qv24lgwMtOl+11lTOgtk+JbDY0U@nongnu.org
X-Gm-Message-State: AOJu0YxgEMNyH77Br0woXilM6MY3GsLqwsVHfrIanPaXZGzEZEZkjiH6
 aFn4fTSW2ZUJpKpDcXkwA9GiK/3awEapUiDZp79kmwQmpOmTEHuJRYi48EZV2nxBVdXjm/czuWi
 l8dCjtsIxfKHxbgw5bQ7J+c0pZG14SaAlKV8Wdhzj7k4YQoLHJnYa
X-Gm-Gg: ASbGnctRoU6wFDUY/aTt+yP7tqIFH1S6C4maL2ydsCIntBFacLDB5+PGI0jG06evXMV
 EFjFP6wxfHSp5r6XXUL041hG+2WJvJjRIgTusyhASPzeQVG7Cthdhhg+5jvttA3xy1yIht0/9qx
 kRDP2YcrImSUmSi2YfVv0KfZT7gCePGpOBOqd2y+svr52cfGEbI7qG31JyYYhLxzMkmh9zgSMn6
 vbrtlj2gMeFRxDlQoqJ3kyLaA4igbCelvxl1+GPi1DkKPLuNeVFu04hDeDUni9Zpf5gngJxGqsl
 PgMypWFwvww=
X-Received: by 2002:a05:622a:d:b0:463:4bb6:bfe2 with SMTP id
 d75a77b69052e-4670c75e541mr172748791cf.50.1733412556270; 
 Thu, 05 Dec 2024 07:29:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyllNe6Ns+OItN58J4aPCnqbnJLROveqlaXE2NORzdD3Yr1pYZopEZGCRZhvoK7jCD/R4cmg==
X-Received: by 2002:a05:622a:d:b0:463:4bb6:bfe2 with SMTP id
 d75a77b69052e-4670c75e541mr172748381cf.50.1733412555949; 
 Thu, 05 Dec 2024 07:29:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4672978f761sm8838051cf.56.2024.12.05.07.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 07:29:14 -0800 (PST)
Date: Thu, 5 Dec 2024 10:29:12 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 09/24] migration/multifd: Split packet into header and
 RAM data
Message-ID: <Z1HGyHx3nEXVbnCQ@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <8cb65952e475c0236d66047270fd3ed907f7404e.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cb65952e475c0236d66047270fd3ed907f7404e.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Sun, Nov 17, 2024 at 08:20:04PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Read packet header first so in the future we will be able to
> differentiate between a RAM multifd packet and a device state multifd
> packet.
> 
> Since these two are of different size we can't read the packet body until
> we know which packet type it is.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


