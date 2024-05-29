Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ED0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJjO-0007Vx-DY; Wed, 29 May 2024 09:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJjL-0007Uj-TR
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCJjJ-0003GE-41
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716990756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hn/LWj1JSK6CC2Hv+m3XDN7fkwLw+vCRab4TeNvPmU=;
 b=UUlJQ+YcN/Dg7g6Opw8ZqmjBbvkqA/HB6Tr62MqXpcM9aMVv57EZRcWEySkUByOciBSLaz
 u8sHTXhXlS+ZUKtAyeZ2uu9tKzuA5l6CzZmKEL+Rd4nvCQrqsAZWtOajdKBgeMfDsWZmtX
 ogJxz5EX69dMWvGlPM79OFrBvFkvi/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-PqhZwX99Mhqgc-TvVxLglQ-1; Wed, 29 May 2024 09:52:35 -0400
X-MC-Unique: PqhZwX99Mhqgc-TvVxLglQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-354ddb92ad8so1272974f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990754; x=1717595554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hn/LWj1JSK6CC2Hv+m3XDN7fkwLw+vCRab4TeNvPmU=;
 b=ivvf9b9pc+eZTovCqkeybp5HTMRIfe4T3QunQ1+fajA7zys49ds7+DrL72E9MfhUOL
 cZfbSzAkt8b2dgZGoQBCx5MJdSmGaP+vwhSBAJ6/gKOXxczuIwGf/hFT5BaumSBbhSaz
 TR+HrrSIvHUvYX4icLKPianueZAozhMzxvndqKQLTQnWmHhZDI3syMmZ5PayLXMo4KEQ
 Km6eEfL7VEc34CdehEzUHROnj4ajEQI1j2+Qum3QGsIBQLqZ632bEepqHVLVLgWVZiur
 gXW0/giOSlxGK4Wwxa9Wgu1uPbNcWTr0icfnht7VN11kvtmsBVN4XW6WlpI1CZlQSguW
 QBlQ==
X-Gm-Message-State: AOJu0Yw4ct3axAiUGlPxJsmcbE31Z0+mrrSnbDsPuAxgS1i9K6fflVy2
 XOFH1JM+IklCyBN3WKFZFQ5loIbuTAvPPm1nh36zeTiFSas1zx46bgp1SVEAbtgL/Yy4fMBlxts
 sdS87rx4Sj4kro1vEOXyW0hizrb6lLjJIWY6iL12M66o0nTzHyeKf
X-Received: by 2002:a5d:688d:0:b0:354:fbb4:dcb with SMTP id
 ffacd0b85a97d-3552fdc0b39mr8966713f8f.40.1716990753849; 
 Wed, 29 May 2024 06:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ZHvM1t5m3faVpTWnlYUHG13woX5Nt95PYLPsSIKDwqEy4ggxMxXyy8uPk5wXUTYpOr4ifA==
X-Received: by 2002:a5d:688d:0:b0:354:fbb4:dcb with SMTP id
 ffacd0b85a97d-3552fdc0b39mr8966692f8f.40.1716990753406; 
 Wed, 29 May 2024 06:52:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-359bc20cbdbsm7733763f8f.22.2024.05.29.06.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 06:52:32 -0700 (PDT)
Date: Wed, 29 May 2024 15:52:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 06/23] hw/acpi/ich9: Remove 'memory-hotplug-support'
 property
Message-ID: <20240529155231.65d316b5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-7-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-7-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 29 May 2024 07:15:22 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> No external code sets the 'memory-hotplug-support'
> property, remove it.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ich9.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 573d032e8e..9b605af21a 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -351,21 +351,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visito=
r *v, const char *name,
>      visit_type_uint32(v, name, &value, errp);
>  }
> =20
> -static bool ich9_pm_get_memory_hotplug_support(Object *obj, Error **errp)
> -{
> -    ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
> -
> -    return s->pm.acpi_memory_hotplug.is_enabled;
> -}
> -
> -static void ich9_pm_set_memory_hotplug_support(Object *obj, bool value,
> -                                               Error **errp)
> -{
> -    ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
> -
> -    s->pm.acpi_memory_hotplug.is_enabled =3D value;
> -}
> -
>  static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
>  {
>      ICH9LPCState *s =3D ICH9_LPC_DEVICE(obj);
> @@ -445,9 +430,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMReg=
s *pm)
>                          NULL, NULL, pm);
>      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
>                                     &gpe0_len, OBJ_PROP_FLAG_READ);
> -    object_property_add_bool(obj, "memory-hotplug-support",
> -                             ich9_pm_get_memory_hotplug_support,
> -                             ich9_pm_set_memory_hotplug_support);
>      object_property_add_bool(obj, "cpu-hotplug-legacy",
>                               ich9_pm_get_cpu_hotplug_legacy,
>                               ich9_pm_set_cpu_hotplug_legacy);


