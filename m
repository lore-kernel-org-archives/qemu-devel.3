Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8969D0E3F3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t442Q-0006Dh-Ke; Thu, 24 Oct 2024 16:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t442O-00060A-UC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:02:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t442M-0002MY-28
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:02:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e983487a1so967958b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729800144; x=1730404944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lM192urMKvFZLAw9PHjSiOx9wCOdV7JWBRsyrwZY1VE=;
 b=QDV/DxIQp8MZ6uGP5gOyy0h3tZSwkgNCgFYk/9Er9TvbabM01jUkUKm1vljVvIGtxa
 jqh+g8Q6ByoQTwiOchED9Qv748Pc59LEJS98cRIl3QNLCuUvIJ2Zv2TEFM2diGZv+zvM
 hevsFPLHQxMx8eXsr9N1Wd1x9q2yGz2FH/ZTNeNr0qWiKB/Yi5fFFF2Q0o0w4Fpa9YMT
 qsgDxTIi1yF3xYOWHPUpqKl6nii9Zz8192VOtAex2/RiKhMF5xms+zFWqJ6GNFLHvEWF
 nGLCnamvI2Ca5XkeMZFzdbFTmUf9FfsIjwQOJ+ppl4OEGUNt+IzXk+v5MGND2FGlK0Cp
 GTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729800144; x=1730404944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lM192urMKvFZLAw9PHjSiOx9wCOdV7JWBRsyrwZY1VE=;
 b=NL7YQequJl6Bj5OX3OxNBlGmjwUQoWfMaAkAczz3NyKJU6csjIOcnBYnm78U8mz8dr
 t9SLJT84bPzrcmT8AOeeSIogvPyXFMqw/9pJ+zaqmd/DIBo9A01sIHHd+w0lmHweSRln
 ZWNp2paek19pU+j3/BPLiwMsuSD8iJdXhtv/GS1mvCm7pVxRB2ZGHLiwkIbq+eqZNySD
 54fhwurde2YYYB4hXOqOY+CBJUzS2OhcGoQOkTJeuVi25A4KaR+xvKLeufiZKIhWa3xD
 8K4ShRjfgDEq3LNJPzuvSt/+YiSi4Syzk5FMjSlDBDNgJl3a1rEu2U9Ypn4XVWU93gY6
 VLrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqloLTEkKFgKksWKy9llGFDwQm1TvQM1j0Z8po1Phtjz0vlyIODgYevfdNsd2F3VwhsAuiL6S4nzCh@nongnu.org
X-Gm-Message-State: AOJu0Yz2XuKvW5BfPyXtK7+XNuJR8ogMmvWXlG8qTaJUGCH7N/kxT2Hl
 +luNjlHwYV80hiPi0kl24Z4LPS1HsyVQ65PicGqTsHqJhBnyeDPzEHQxsk42DnI=
X-Google-Smtp-Source: AGHT+IEshyE2WmBSiOGFokGIrgHmcIz1UhcR9teScQTlkjcIDK/u9JFoQsgCdbJiughfxWGVrNofFg==
X-Received: by 2002:a05:6a00:1495:b0:71e:5b92:b036 with SMTP id
 d2e1a72fcca58-72030b61a33mr10171202b3a.22.1729800144451; 
 Thu, 24 Oct 2024 13:02:24 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13ea28fsm8613358b3a.141.2024.10.24.13.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 13:02:24 -0700 (PDT)
Message-ID: <20dec12b-69e0-4996-9962-6aac9d40fc07@linaro.org>
Date: Thu, 24 Oct 2024 17:02:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241024165627.1372621-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Peter,

(Cc'ing Mark)

On 24/10/24 13:56, Peter Xu wrote:
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
>   qom/object.c                    |  3 +++
>   qom/object_interfaces.c         | 24 +++++++++++++++++
>   qom/qom-qmp-cmds.c              | 22 ++++++++++++---
>   system/qdev-monitor.c           |  7 +++++
>   5 files changed, 100 insertions(+), 3 deletions(-)


> +/**
> + * SingletonClass:
> + *
> + * @parent_class: the base class
> + * @get_instance: fetch the singleton instance if it is created,
> + *                NULL otherwise.
> + *
> + * Singleton class describes the type of object classes that can only
> + * provide one instance for the whole lifecycle of QEMU.  It will fail the
> + * operation if one attemps to create more than one instance.
> + *
> + * One can fetch the single object using class's get_instance() callback if
> + * it was created before.  This can be useful for operations like QMP
> + * qom-list-properties, where dynamically creating an object might not be
> + * feasible.
> + */
> +struct SingletonClass {
> +    /* <private> */
> +    InterfaceClass parent_class;
> +    /* <public> */
> +    Object *(*get_instance)(Error **errp);

IMHO asking get_instance() is overkill ...

> +};
> +
> +/**
> + * object_class_is_singleton:
> + *
> + * @class: the class to detect singleton
> + *
> + * Returns: true if it's a singleton class, false otherwise.
> + */
> +bool object_class_is_singleton(ObjectClass *class);
> +
> +/**
> + * singleton_get_instance:
> + *
> + * @class: the class to fetch singleton instance
> + *
> + * Returns: the object* if the class is a singleton class and the singleton
> + *          object is created, NULL otherwise.
> + */
> +Object *singleton_get_instance(ObjectClass *class);
> +
>   #endif

> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index e0833c8bfe..6766060d0a 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -354,6 +354,23 @@ void user_creatable_cleanup(void)
>       object_unparent(object_get_objects_root());
>   }
>   
> +bool object_class_is_singleton(ObjectClass *class)
> +{
> +    return !!object_class_dynamic_cast(class, TYPE_SINGLETON);
> +}
> +
> +Object *singleton_get_instance(ObjectClass *class)
> +{

... when we can use object_resolve_type_unambiguous:

       return 
object_resolve_type_unambiguous(object_class_get_name(class, NULL));

BTW should we pass Error** argument to singleton_get_instance()?

> +    SingletonClass *singleton =
> +        (SingletonClass *)object_class_dynamic_cast(class, TYPE_SINGLETON);
> +
> +    if (!singleton) {
> +        return NULL;
> +    }
> +
> +    return singleton->get_instance(&error_abort);
> +}

Alternatively call object_resolve_type_unambiguous() in instance_init()?

Regards,

Phil.

