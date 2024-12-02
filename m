Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C342CD4979E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 05:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHz1U-0001b5-Ik; Mon, 02 Dec 2024 00:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHz1S-0001al-5F
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tHz1P-0007px-IL
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 00:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733117457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFWcw2asdUZzDNr3e2THaQxQbbyJt+uJ8ARTGBWXDTc=;
 b=P20IPfK+m7BAVJ0Dfxjv7qp15TQWYKlv2xlxiJvqXL6udvTg4M8PHh8vUstC///NnPwUBG
 WsCdBkb2xJT4HkeyCYrMqwx8g4h6QK4IHUbeowDZ7NUukmVix5AYSwLXDoZmfS0KqM0FlP
 MF2yWtmL4XidobuAcH5gwkdRl0UtWUU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-PBt01eO3M76oym7uAf904g-1; Mon, 02 Dec 2024 00:30:53 -0500
X-MC-Unique: PBt01eO3M76oym7uAf904g-1
X-Mimecast-MFC-AGG-ID: PBt01eO3M76oym7uAf904g
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71d893a4082so69100a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 21:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733117452; x=1733722252;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PFWcw2asdUZzDNr3e2THaQxQbbyJt+uJ8ARTGBWXDTc=;
 b=X6fQsrBMW1snDAhZicflGS+KvEyrdfKv3YIE7JSdfcAeX0hib8FiQHDEceC4lUCtig
 5d1HyRdXN9FD8SNbodmHNJmXk9AanowYk70CcDSjxlu4ng1QqjbLDbjQ3rxXgKWvA/dF
 8hcQxZIO83iyHLgYj+O+M9hSmBXZ0HeONwSxLOmrKf8MiwD4s35gHQYCXzJN+LLdkpJL
 K27/rEhzwpz2FSdvCtuYNYuWrg/qshlgGLs8kfuoLxdljJ3vtnZF4giiCQuitBtKL1E8
 34Fw4rnP+E0yWMJMVBLNbj93vhMwTiYca8RNM4YQ/0N3IUvyaG0uL8sxE9Yu/0Lmo9rF
 3D4g==
X-Gm-Message-State: AOJu0YwkfK98Zbg94Qm5/4io+a5jfZPxNBRVLHMwW6Hn9NiRLmwUDsQX
 A32TGlWkOpjjNfE6hqEyuQwGrjd5XWoB56DT2McP8d9XXsZDC3XCGttSzz1fpmVZFF87DXSrSlI
 8rKAknU6R1O5hE2y3leUJ2A9licakBKrcYxIdB/B2vf/iu5BKz2E1
X-Gm-Gg: ASbGnct/ALO7QzDj/2DO+yG03mc/5+YakH5n0gx4rE41Ee3X7UMb4q3LQedyiMOm9Uw
 8GKTjayjHrPnkCv72U6/43hrrThPhtWmZq3WxPL+MJJugDMyk1qy4dwgSIQzlm1P9DqdSWwypsM
 VU2v8jxC3CTWczGfFPm/kZGGE0FiXrYMtwt9fQQeWbv4SGHoQn+u9tB0xh9cXFoin0Ll8bZIi+m
 WbdtVdWjG+T6y6ctiT5mEkk+rJRlRzwhM0ytAlFNZbyiSBRxhL3JQ==
X-Received: by 2002:a05:6808:228e:b0:3e6:147d:ffc with SMTP id
 5614622812f47-3ea6de62cbemr4729705b6e.10.1733117452515; 
 Sun, 01 Dec 2024 21:30:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhn9jd+bNK63aCQURXsaK02BONMI8laEiZP5ZyEGJAdAeImwYnAb2xbVh6WFGI6YDOO3TCBw==
X-Received: by 2002:a05:6808:228e:b0:3e6:147d:ffc with SMTP id
 5614622812f47-3ea6de62cbemr4729697b6e.10.1733117452276; 
 Sun, 01 Dec 2024 21:30:52 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea8621131bsm2160424b6e.36.2024.12.01.21.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 21:30:51 -0800 (PST)
Date: Sun, 1 Dec 2024 22:30:50 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <c.koehne@beckhoff.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 3/8] vfio/igd: remove unsupported device ids
Message-ID: <20241201223050.12ead1a4.alex.williamson@redhat.com>
In-Reply-To: <20241201160938.44355-4-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-4-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon,  2 Dec 2024 00:09:33 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Since e433f208973f ("vfio/igd: return an invalid generation for unknown
> devices"), the default return of igd_gen() was changed to unsupported.
> There is no need to filter out those unsupported devices.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index b449316ec0..8f300498e4 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -64,16 +64,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
>      }
>  
>      switch (vdev->device_id & 0xff00) {
> -    /* Old, untested, unavailable, unknown */
> -    case 0x0000:
> -    case 0x2500:
> -    case 0x2700:
> -    case 0x2900:
> -    case 0x2a00:
> -    case 0x2e00:
> -    case 0x3500:
> -    case 0xa000:
> -        return -1;
>      /* SandyBridge, IvyBridge, ValleyView, Haswell */
>      case 0x0100:
>      case 0x0400:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


