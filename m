Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F768E69E8C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICRr-0000rz-S3; Mon, 02 Dec 2024 14:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tICRn-0000rE-4u
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tICRl-0008Vb-Mo
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733169064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eL9lfOvelCE5QO2irQsO6R9QFNQE45MQ6+sK95HwXJ8=;
 b=PuMwNtDI2yyyQ1WO+LWANKG6zNan7zd7JQlcMFRkB8mE1e/KmPPT23KGLWqNyHX1gLoG5V
 V2t7HuxfTvkHEFnE4BjWKyuuV0XMnk8eMaWPtPP42Wo6iXdcLEtd83Rf5XQ+5UiDQSJP3F
 zPFhBuoQRenywCnvCTMGoMBitg8pLmU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-6AWc9xIuNCiyQ7TWvgMPLA-1; Mon, 02 Dec 2024 14:51:02 -0500
X-MC-Unique: 6AWc9xIuNCiyQ7TWvgMPLA-1
X-Mimecast-MFC-AGG-ID: 6AWc9xIuNCiyQ7TWvgMPLA
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-8419aa81d6aso402744239f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 11:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733169061; x=1733773861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eL9lfOvelCE5QO2irQsO6R9QFNQE45MQ6+sK95HwXJ8=;
 b=RQPQpi/Cc65FtHgGwPTyObEvZWFFKiJAdn9UVzJb45+9jE1tEOkd41ypwumnURmmeY
 QpKYdU+ZEcMPh8PameTT56KZW5rbZz3RdybuPe06FS1hkRKNnE+oRxB84IbAgsEymnJl
 Atm4e9/g2JoEH2NCaoMm8rrmDT0bjUJAudsI/yqnJwpOmb7m7xzHCRhLclarvD/p9IFn
 AlS9bLP61kZQAyLSdDATxdNsfUK8P8lz1YhsK8sWHvLqTKpIqrjdAZ2wR32TuUpnuIrV
 D30DwQZpUZRHfFpkXV6JZbl3pIUjSbfybkmOYcI64SHwXDKT1smQ+/Ws943RIta7zt+z
 CeYQ==
X-Gm-Message-State: AOJu0YwRIVTEvqwoWdKN1s/H0UVFSUQjeUiI/9a9t+AFeYsKjxLfxgPc
 LAGGZvqcw+v1HRdqdUHgSHu+O2EvQjXJjl3JFc+CMuzRa5A4/mUnUaRGKlmAxipPyGuH8ph+1EO
 8/jpovx+NR1YCR5rxY+VdKeryk5CgRelvbWY67FF2fNJyq+Hc0E04z4AI05fc
X-Gm-Gg: ASbGncs/c70EIf9Txz+IbH1GYicYqXSqTeT/PQ1gT4lJT/USJef5wQG2DWkNWfjEkxD
 E7cwxFzmQygq7on6I6Nr9AMEJjN9HUiR3O+249prGAk8ZCHVAwd+Y6RblrXsHDh1LUPco964Ebb
 /kWkrPW6uLXVCtjtn7AFc3tCDmembgokLxKi5tdBttIToQkVIST8Sk7BrqjE/5q+YmCoyAoPm65
 LEAzD1Cy67nDJ38Ssm8uw9IXI1JgLk0yyV30BiezMY6FxzUdgocj6h0mK+Kk/4LA6yI3ibTd/Rn
 uIeOKHcJZF8=
X-Received: by 2002:a05:6602:3d2:b0:83a:d039:a721 with SMTP id
 ca18e2360f4ac-843ed0458a9mr2649403139f.8.1733169061290; 
 Mon, 02 Dec 2024 11:51:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX94J/FqTvuUHH7zvH/ZfgsjTL6FvFSi3I1Kifw5aUYak2Cw6uPY2D6DwvsRg0rCOQ/uCO4w==
X-Received: by 2002:a05:6602:3d2:b0:83a:d039:a721 with SMTP id
 ca18e2360f4ac-843ed0458a9mr2649401439f.8.1733169061024; 
 Mon, 02 Dec 2024 11:51:01 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230e74932sm2219857173.116.2024.12.02.11.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 11:51:00 -0800 (PST)
Date: Mon, 2 Dec 2024 14:50:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 03/17] tests/migration: Disambiguate guestperf vs. a-b
Message-ID: <Z04Potq9HK13KBPp@x1n>
References: <20241127182901.529-1-farosas@suse.de>
 <20241127182901.529-4-farosas@suse.de> <87serajhxz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87serajhxz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Nov 29, 2024 at 10:19:36AM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > The current build structure for migration tests is confusing. There is
> > the tests/migration directory, which contains two different guest code
> > implementations, one for the qtests (a-b-{bootblock|kernel}.S) and
> > another for the guestperf script (stress.c). One uses a Makefile,
> > while the other uses meson.
> >
> > The next patches will add a new qtests/migration/ directory to hold
> > qtest code which will make the situation even more confusing.
> >
> > Move the guest code used by qtests into a new qtests/migration/
> > directory and rename the old one to tests/migration-stress.
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> Please squash this in:
> 
> -->8--
> From 9f8a693e31be198e1e052d86be99ffaaa0a3e8a8 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Fri, 29 Nov 2024 10:05:21 -0300
> Subject: [PATCH] fixup! tests/migration: Disambiguate guestperf vs. a-b
> 
> ---
>  tests/migration-stress/guestperf/shell.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/migration-stress/guestperf/shell.py b/tests/migration-stress/guestperf/shell.py
> index c85d89efec..046afeb84e 100644
> --- a/tests/migration-stress/guestperf/shell.py
> +++ b/tests/migration-stress/guestperf/shell.py
> @@ -46,7 +46,8 @@ def __init__(self):
>          parser.add_argument("--binary", dest="binary", default="/usr/bin/qemu-system-x86_64")
>          parser.add_argument("--dst-host", dest="dst_host", default="localhost")
>          parser.add_argument("--kernel", dest="kernel", default="/boot/vmlinuz-%s" % platform.release())
> -        parser.add_argument("--initrd", dest="initrd", default="tests/migration/initrd-stress.img")
> +        parser.add_argument("--initrd", dest="initrd",
> +                            default="tests/migration-stress/initrd-stress.img")
>          parser.add_argument("--transport", dest="transport", default="unix")

Queued for 10.0 and squashed this in.

-- 
Peter Xu


