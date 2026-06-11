Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A72CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXfr9-0004Wy-Of; Thu, 11 Jun 2026 09:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXfr6-0004WU-MO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXfr5-0003X5-2d
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781186038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VgrPa3naNK/9zGDRnujqRYVwg/TdAvfTE5hbEKZmls=;
 b=VCi80OANMAmpnbnkSwEdStP0d7AIEzcMhBMLBtvsD/C6yr5AHSCdSll8XR9szTVH1koko1
 X3BrKL+Huqi0AzxKg6fM4m0GL6JnuJgY25RRdhdCIUHaC9Os/zeO9kvGQ1kwA8IJoRYJcB
 YU9ZbIIsu/99thqYbTDlUi7OIuzXelU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-JSv6UufzNm-SxmeFdl7_4A-1; Thu, 11 Jun 2026 09:53:48 -0400
X-MC-Unique: JSv6UufzNm-SxmeFdl7_4A-1
X-Mimecast-MFC-AGG-ID: JSv6UufzNm-SxmeFdl7_4A_1781186028
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7f582244e9eso27307537b3.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781186028; x=1781790828; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/VgrPa3naNK/9zGDRnujqRYVwg/TdAvfTE5hbEKZmls=;
 b=Lqr4MZwXkRrW4PClCQWE+ffn82pZNSVwURx4nbXOLbBTT8UQ3lypWIs6zSv5E9sLgz
 G6fu4Fr/6IWUgngMNWARcaL6A5OiTC/F13VPO5v2aMJNb8x4eX2kaRyMgg7zSwRJESrI
 qiYn2olr/DLQRPYIiYskLdu1kVs6jyDh/YC8f+54NgNf8HjhSx6nNDxb6eztNt+245lM
 NHeEfdCmx2fudLnf6nugFbSZ17Gcd4I7jEC+GUFq1yp9C1zmML3V99vA6MEHKknGfG2l
 1np9B3vY4VpcOCaPYBQpwM9zyigzMPuNbGoZuL3tVmDh7cEiVOS88v/o7vDh8Dr0PPkh
 dY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781186028; x=1781790828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VgrPa3naNK/9zGDRnujqRYVwg/TdAvfTE5hbEKZmls=;
 b=Z12fcYufRnq+NAu7nmH+5fyOPRcnCDDAyXnSU6Onj4Cdpo3yZVPNvKjFfsadNTPcRU
 V74ikZnHBNIJYzrv1qbwJ2SPx0KvqYgHPgEDFyLtrwG9ARmyQdnj5hiCJn3l4Drcu7qz
 LuKR+28o7JoKmREhA+oO1atj4zo64z3TsptFX3WJax8hcug4tiy7H80Jg/y2mxvpfvFY
 IOPoNXmdp0dh4q4zXjDEmJ67J5Ib+XxTIAG7FXZ9KMnWdiNsYI+zHwDek7L0h91GtnTo
 iUohJMbeI8X0L6XkjIZVrhEhPUJ7XvcG4jK/uSVwRbftcPEpgfbryPyVWTYV5O5NqB56
 VsgA==
X-Gm-Message-State: AOJu0YzCa1ErHL4e+Y0eCeZf5l1kNwgwpDuMncY7sE1HoY7XOSKiHnFv
 OV1Wa9AyapNymCOv8bnT5RgkBtH9RkGHIdSXkIXVuPQ8I4DO1EggPJP0tx4mKGe6CLcL/79IoTU
 AjV997y/Vbq1XBz7YSDSLfSsDO+u9pJdn3ertc3glkBxEjuAI8AadvKus
X-Gm-Gg: Acq92OGfcJGKY5EMxWUTFTInYw4gzc6aQMpW5teKxNDj83xZ/FK7kq1/PQKC5JSjyAW
 HSKhr89VnKqpL/ZQHj5cHgQWsip+aiZwZjS7dDfuOOkDTpZqc1LL0cnWyb9kiFUqWqDVprt6F4U
 Cz1/R65/uOY9BxggCr0mK/E4GBgGpUX1y0ioKWFsDEp99fzOqivJQqZ7mXE9pNSL9tHP0SNB+5D
 daK4D8cej3X+nNc20slZTFxK119/QIxjutB0DTS2rud0LlPlK+eOvWGlaCifenBgR6iIKfC1QNM
 PGCsSEX41asPG283X39rFhzwaD/dgQqcgcYWyqYVo6f6unioFn/UhIJBJwnDhBMjumFyHgt3wvZ
 gP8Nk9e127T1vKtlcsFjwRpHV4w==
X-Received: by 2002:a05:690c:885:b0:7dd:489:b56a with SMTP id
 00721157ae682-7f65719007bmr30079987b3.25.1781186028042; 
 Thu, 11 Jun 2026 06:53:48 -0700 (PDT)
X-Received: by 2002:a05:690c:885:b0:7dd:489:b56a with SMTP id
 00721157ae682-7f65719007bmr30079707b3.25.1781186027470; 
 Thu, 11 Jun 2026 06:53:47 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7f6958cabfesm5548377b3.27.2026.06.11.06.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:53:47 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:53:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
Message-ID: <aiq96eu4C-8AQwKu@x1.local>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com>
 <73fe919b-d8eb-4b01-8401-f7ecb418eb11@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73fe919b-d8eb-4b01-8401-f7ecb418eb11@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 01:54:54PM +0100, Mark Cave-Ayland wrote:
> > @@ -2141,4 +2048,10 @@ char *object_property_help(const char *name, const char *type,
> >   G_DEFINE_AUTOPTR_CLEANUP_FUNC(Object, object_unref)
> > +/*
> > + * Object property ptr helpers cannot be included at the beginning of the
> > + * file, because it depends on QOM definitions in current header.
> > + */
> > +#include "qom/object-property-ptr.h"
> 
> I wonder if possibly we might want to let the caller include the extra
> header? But I don't feel too strongly either way.

Yes, I didn't try to when drafting, but I also agree it's cleaner.  It will
need to update existing files (20 .c files) that used the api set.  I'll do
it if we can reach a consensus on the concept.

[...]

> Otherwise looks okay to me:
> 
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Thanks,

-- 
Peter Xu


