Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37179C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRuV-0006LP-JY; Thu, 16 Jan 2025 10:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tYRuT-0006Kd-8A
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:35:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tYRuR-0003WV-MX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737041747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjIpcD7YWjfIwGyoS2xumZ713mFtxVG+uRPiveCy82g=;
 b=KnhGQTLDTXTm5vaNam0UBzWvObAgT97H5wwxu3FLtXKsrcZ/LfSesdVVABEpDkzLNRNo4i
 r7BeMcyCuyloUnyyNMHEFKvgVSBQSybcy1c7MWdUh1XRJBQxyGmVCJMoyUS8xhgsVcpOpH
 eZw3ErAa8unig54JMtSfb5wEbIYLu3k=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-6831t00xP0Wp4wOvtZspJw-1; Thu, 16 Jan 2025 10:35:46 -0500
X-MC-Unique: 6831t00xP0Wp4wOvtZspJw-1
X-Mimecast-MFC-AGG-ID: 6831t00xP0Wp4wOvtZspJw
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-844ebc11477so10756839f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737041745; x=1737646545;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KjIpcD7YWjfIwGyoS2xumZ713mFtxVG+uRPiveCy82g=;
 b=M71/ImNLY2bvuGCT3ZDOShjVkonYAWmqFXnhZ4uoa792v+sv6PRtBtzwLgoZmWPYCU
 8yoq0rJjvAPOkLgYypGDKCABJOEJlMhA60vlCdVYMd/llqU6jMZ1YCHeLAO7g+Bt/dRa
 mi++lH0rnanjmCmTWuOenapmjb8QNSTZfMm80WIDatqYuco2csbDrERKXECWXrmiJKjg
 F2UlIHAjV+D+xjqBvPi3NVP7v6bwgj8z4LTORwzjyQ03uJuNWyxwBeigL/oeZcI3IMJ/
 oR/xnGW5ZVd5Np95yF7qVahI+hEw5fU3803j0OtGqIQl+WWuchpjrej7i0k/NyDt0qLO
 purw==
X-Gm-Message-State: AOJu0Yx/qaMNeaCcxBzr8tGEjrgJdQ5qh+EuaBfxG5CtZDQ2zAL4yFbV
 zOLqNqR6CopNf4SN7ehQGSRI6WL2A5rmizWq/nXAW0Y5vCob0wpuav3RwxrfTsoZDEWiPzat2A/
 JZMud/eFuUkc7aNm8qt34arbUOaOTAlh+zrAzPPe1FkmSyyeAUxj/
X-Gm-Gg: ASbGncvSBifAOkG8ycekfP9joHCz/8yhQXDfnlF245nLuJDIw6edlXUyXcJZED+bYPu
 IQPSxXHwxFraMSXWDUr7oD4T4ZYP8PnI9u5it0OxchTlAWlGKabMRHVixvYvPye3ijHkUv4F37J
 mocYx+TuGNv7YwmYnZfiEzrwMSAF58hEWEDvqUGEXgTqq2quiV/QDCNbvmfqApyaicqPDTNUVDt
 XFsGFxlP79wakAPrej4C3KQwotuZqoRwJwp9TgOd+JdWPJMLtpaRgrrBQ82
X-Received: by 2002:a05:6602:6d1a:b0:83a:9350:68b with SMTP id
 ca18e2360f4ac-84cdfddfb66mr811917939f.0.1737041745698; 
 Thu, 16 Jan 2025 07:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7QFqbYKh3e3NGUt2NwBhYNKuCm/9f819uqsIQokVRh2lY9gixa9mUR5R3g1P6ULulldpTKA==
X-Received: by 2002:a05:6602:6d1a:b0:83a:9350:68b with SMTP id
 ca18e2360f4ac-84cdfddfb66mr811917439f.0.1737041745363; 
 Thu, 16 Jan 2025 07:35:45 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75649c1esm70662173.78.2025.01.16.07.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 07:35:44 -0800 (PST)
Date: Thu, 16 Jan 2025 10:35:30 -0500
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/igd: Fix potential overflow in igd_gtt_memory_size()
Message-ID: <20250116103530.2cb45731.alex.williamson@redhat.com>
In-Reply-To: <20250107130604.669697-1-clg@redhat.com>
References: <20250107130604.669697-1-clg@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  7 Jan 2025 14:06:04 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> The risk is mainly theoretical since the applied bit mask will keep
> the 'ggms' shift value below 3. Nevertheless, let's use a 64 bit
> integer type and resolve the coverity issue.
>=20
> Resolves: Coverity CID 1585908
> Fixes: 1e1eac5f3dcd ("vfio/igd: canonicalize memory size calculations")
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/igd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 0740a5dd8cc9346a92c4613194faa8dea42e1d98..b5303ea565d6a344d0a43273f=
288bbb4a7f48327 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -133,7 +133,7 @@ static uint64_t igd_gtt_memory_size(int gen, uint16_t=
 gmch)
>      } else {
>          ggms =3D (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS=
_MASK;
>          if (ggms !=3D 0) {
> -            ggms =3D 1 << ggms;
> +            ggms =3D 1ULL << ggms;
>          }
>      }
> =20

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


