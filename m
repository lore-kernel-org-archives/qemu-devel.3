Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC23C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKIN-0008IT-DO; Mon, 27 Jul 2026 08:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1woKIL-0008Hw-DH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1woKIJ-0008AM-Qq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785154734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5dKeWNXTVrL85tSrPucpBv2NSFt9uxptmhhn9V0Ke0=;
 b=XEm8+oO7AVncKeEfSBHC0NSp/l6PAWJqgNFKTRe5xNe1shKvB5B2ksdSJL5vgKpGrT/TJG
 kokTwU7IfgDn5zHrdhChtsNW2nWOirTRi24eVyXTZkSIGfCsd6OAmOKThvvnjefktS5HMo
 ad5LotK2J7uKl8DRvj8ov4SAAcWZmsg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-6QOB9SRoO4uxBVddkINSsg-1; Mon, 27 Jul 2026 08:18:53 -0400
X-MC-Unique: 6QOB9SRoO4uxBVddkINSsg-1
X-Mimecast-MFC-AGG-ID: 6QOB9SRoO4uxBVddkINSsg_1785154732
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954fd771baso24071235e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785154732; x=1785759532; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L5dKeWNXTVrL85tSrPucpBv2NSFt9uxptmhhn9V0Ke0=;
 b=N6fI3ukX73QkBNbDiGazg2HSvT8cB5Mxw/8qq9JuO1wf7wSW8OlfOM4iRexvzSCGdZ
 HYUJbeOelfxuQI0m2P71azyYVRADy9ev3cMxBxBPfRG4oOaKgHVVlNgfkkZfjReOeZ/d
 tsX+oVBCpBod1oY9lQnLpzpT+oU2yqBHIRdzZRRoXCx30IwLDL5Dx40BMbHp6LVJZT7r
 hCdz79AJ0qqh6AaE6eeO+qnXTVP+/S0DTzsoiIMAUJZfslFMXDXc6Gbh+wAIgRBr5Lu3
 9iEvFQkvytoW/Dv38o+dzYXT/i8fN8bJIAaucfTapRH202kYO3f3sHJwmDg1ZuiiEaKR
 ubog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154732; x=1785759532;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L5dKeWNXTVrL85tSrPucpBv2NSFt9uxptmhhn9V0Ke0=;
 b=gimQk5cFLmLMH5rghGSD7nSKi77cy/H0RI6f1nXrtuZRpWLw6dq7+ymfHBvqTSG3Xa
 Q9+9PsIfReol+9nkKoZTquibtQ4lReOWsIJxC+A8sezCZoCDQOTlMqqJ/aRImboQ6Xfw
 XeNbC7ISNAqpYKc9PCYhpjYHcO02JoJuCXCAX+94/bqVv7Zc3yItoxceGJ5u0935jZ3k
 gsNZPsLlGODfneiSopLUHiEclrisch8egp1ShMBNw+2xW8vVO7irwWTXkpb3KQ3IPExX
 IUz3sw/Wfa5CTH0rsNClsHJS9D//mnnUdAg86sbDz7HKlXQwx3Uzf65xCvixSvN3G3dR
 iNOg==
X-Gm-Message-State: AOJu0Yx9TOHEmL2JQrc33sUqhAzLPlbf8cwCJMtm1aTmjx2WBSAhcZQS
 tJFu0ONMFp3T5anRpNAx19wHpMDl7NbrRDO/QrQlinZA0J7gbN4lR4DxXp8gbzIfi1M8WwsMreT
 uleEQsLEJFLqDVBPutyBy7aM/17rg7UYHU77sdUdp8aAYvzKMiKbd+UGm
X-Gm-Gg: AR+sD11WytUwSS3L1ffTkB62CTF5N2njXOrjscMOwzD4X/2JANjhpzkpkaqhj/YZZLl
 wULZZHI6JI6kEl/Nk9V+OPmXp1pHJ5MP1tQVtVPnIb7CHNr0pP7mh4JhrHiXfgXi3jaNcYtc7DV
 rKyYzoVgpvNP/X3f1TXDvV5cmFVTy8l+LeR+KMDZJXMGccTEv8A2d3857q3QRlTgZFaWsoaB1+/
 bVKeCsiupizsHtDuDax4yZg0MKu2QLYqPqtdkVSku0cVU6kfA6rFiKvfFyuWNPM8jpxF0XydzeP
 e5CGNSEiRVfMlUzmXbw/9qfv8VFnnPBPV7PBfK8i3ysKDApwZIyPXSun1xfp
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id
 5b1f17b1804b1-496b5c7182amr99174475e9.10.1785154731992; 
 Mon, 27 Jul 2026 05:18:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4444:b0:495:6b4c:fccc with SMTP id
 5b1f17b1804b1-496b5c7182amr99174075e9.10.1785154731608; 
 Mon, 27 Jul 2026 05:18:51 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b388d5b4sm162922435e9.3.2026.07.27.05.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:18:50 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:18:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Lukas Straub <lukasstraub2@web.de>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Zhao Liu
 <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>, Markus
 Armbruster <armbru@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Alex
 Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>, Hanna
 Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, Stefan
 Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Michael
 S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, linux-edac@vger.kernel.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, qemu-trivial@nongnu.org, Jonathan Cameron
 <jic23@kernel.org>
Subject: Re: [PATCH v2 16/44] qapi: convert trivial intro sections for
 acpi.json
Message-ID: <20260727141848.5cc56eb2@imammedo>
In-Reply-To: <20260723044805.527643-17-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
 <20260723044805.527643-17-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 23 Jul 2026 00:47:37 -0400
John Snow <jsnow@redhat.com> wrote:

> (Trivial)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi/acpi.json | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/acpi.json b/qapi/acpi.json
> index 906b3687a55..291a04a7ea4 100644
> --- a/qapi/acpi.json
> +++ b/qapi/acpi.json
> @@ -81,10 +81,9 @@
>  
>  ##
>  # @ACPIOSTInfo:
> -#
> -# OSPM Status Indication for a device.  For description of possible
> -# values of @source and @status fields see "_OST (OSPM Status
> -# Indication)" chapter of ACPI5.0 spec.
> +#     OSPM Status Indication for a device.  For description
> +#     of possible values of @source and @status fields see "_OST (OSPM
> +#     Status Indication)" chapter of ACPI5.0 spec.
>  #
>  # @device: device ID associated with slot
>  #
> @@ -107,9 +106,8 @@
>  
>  ##
>  # @query-acpi-ospm-status:
> -#
> -# Return a list of `ACPIOSTInfo` for devices that support status
> -# reporting via ACPI _OST method.
> +#     Return a list of `ACPIOSTInfo` for devices
> +#     that support status reporting via ACPI _OST method.
>  #
>  # Since: 2.1
>  #
> @@ -126,8 +124,7 @@
>  
>  ##
>  # @ACPI_DEVICE_OST:
> -#
> -# Emitted when guest executes ACPI _OST method.
> +#     Emitted when guest executes ACPI _OST method.
>  #
>  # @info: OSPM Status Indication
>  #


