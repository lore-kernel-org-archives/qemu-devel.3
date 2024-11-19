Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA5DD4417D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQtv-0004bD-Cc; Tue, 19 Nov 2024 11:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDQtq-0004am-V5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDQtn-0007XE-SN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732032978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jr8A5OhLeUImsufY13ebeYtDiLA7KiH4JfzHe8BSGjw=;
 b=bLLDyyLVrDeqgP+ZgKQZldEY02Imkc6H6A1B6lSTJapyx+OsjjmlmWd2yRd8cWm+EVVBdc
 IL/qO5lBtGt33SEpWHuANLueOnhJ6Z8SnbuLfdGUQ1zEWGs6G6Mjlly8dwHXWlxFj2h5iX
 9beicVmRuOPWs+m/DEe7I94+mu1LoUs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-oR0f72NLM-2VGrGre5KmLA-1; Tue, 19 Nov 2024 11:16:16 -0500
X-MC-Unique: oR0f72NLM-2VGrGre5KmLA-1
X-Mimecast-MFC-AGG-ID: oR0f72NLM-2VGrGre5KmLA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso24821135e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732032975; x=1732637775;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jr8A5OhLeUImsufY13ebeYtDiLA7KiH4JfzHe8BSGjw=;
 b=pN09gRmoEfLiTuuUftzahpo/UheTMFvaWapwy1hl1P3ESBnsI6D3ry69e88wzvCH23
 QRfuYAAOXOoYrfFKd7qG3fppCEkPaPs48baZNu6JlZthS10fCS+G9ItW42Fktypa7qV8
 LbVu/NtciTieRdChEXitASvuPwajTE4qh2Gy7bBzGpJ+43BL4EmWfhkrX1eezj/c/gDm
 f+tx+B8J9Uf8lyBOcCWldZDMBx+P06CpX+84dAdIKb57Cj7bbAuj4h0dHL/nvrY9DIpI
 qRjpKJpm3AW0TIQg7DiG5QMfnUoRclbGgu1nQEetqc6tQRhgLYU5otnzit+H+fm8Id4x
 Nnew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU66c7EAgZxjr298i53SSRhnk+Xqor45aDMj4SFEX62LAbtW/nSOVYOsshMNDKBbpW/bAHro/8KvFKF@nongnu.org
X-Gm-Message-State: AOJu0YzpKX4j2UvEgrpiW+ec0Zjtq0zJyxI5Et5OatIk556c6oozWI95
 bIMSSk7nKot5uUt/YF5imNA1bYLS7gIPlNyrdS1DWRiE2pz+7xkOMt4mRXNLt26H0gOUWEnUrjt
 pAsDSsOzqnQqRSH0PB3RSoW4aALQfA2p0nS+GQgRyr5+rdPNI+ayP
X-Received: by 2002:a05:600c:474e:b0:431:518a:683b with SMTP id
 5b1f17b1804b1-432df74f2c1mr137211475e9.18.1732032974902; 
 Tue, 19 Nov 2024 08:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ggTtlr9rSuVSREhCODZFnFp/ko3XIFitLfzO9fASBuvXY2DZ5LpOF0YwV21so3Nu0c4LVQ==
X-Received: by 2002:a05:600c:474e:b0:431:518a:683b with SMTP id
 5b1f17b1804b1-432df74f2c1mr137211155e9.18.1732032974382; 
 Tue, 19 Nov 2024 08:16:14 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432dab80ad9sm194840765e9.25.2024.11.19.08.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 08:16:13 -0800 (PST)
Message-ID: <c471b22c-1b50-47c6-9b67-a9853545b041@redhat.com>
Date: Tue, 19 Nov 2024 17:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qdev: Fix set_pci_devfn() to visit option only once
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, armbru@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, qemu-stable@nongnu.org
References: <20241119120353.57812-1-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241119120353.57812-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/19/24 13:03, Kevin Wolf wrote:
> pci_devfn properties accept either a string or an integer as input. To
> implement this, set_pci_devfn() first tries to visit the option as a
> string, and if that fails, it visits it as an integer instead. While the
> QemuOpts visitor happens to accept this, it is invalid according to the
> visitor interface. QObject input visitors run into an assertion failure
> when this is done.
> 
> QObject input visitors are used with the JSON syntax version of -device
> on the command line:
> 
> $ ./qemu-system-x86_64 -enable-kvm -M q35 -device pcie-pci-bridge,id=pci.1,bus=pcie.0 -blockdev null-co,node-name=disk -device '{ "driver": "virtio-blk-pci", "drive": "disk", "id": "virtio-disk0", "bus": "pci.1", "addr": 1 }'
> qemu-system-x86_64: ../qapi/qobject-input-visitor.c:143: QObject *qobject_input_try_get_object(QObjectInputVisitor *, const char *, _Bool): Assertion `removed' failed.
> 
> The proper way to accept both strings and integers is using the
> alternate mechanism, which tells us the type of the input before it's
> visited. With this information, we can directly visit it as the right
> type.
> 
> This fixes set_pci_devfn() by using the alternate mechanism.

Indeed, set_pci_devfn() predates alternates.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Cc: qemu-stable@nongnu.org
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/core/qdev-properties-system.c | 54 +++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 35deef05f3..91d3ff4719 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -790,39 +790,57 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
>                             void *opaque, Error **errp)
>   {
>       Property *prop = opaque;
> +    GenericAlternate *alt;
>       int32_t value, *ptr = object_field_prop_ptr(obj, prop);
>       unsigned int slot, fn, n;
> -    char *str;
> +    g_autofree char *str = NULL;
> +
> +    if (!visit_start_alternate(v, name, &alt, sizeof(*alt), errp)) {
> +        return;
> +    }
> +
> +    switch (alt->type) {
> +    case QTYPE_QSTRING:
> +        if (!visit_type_str(v, name, &str, errp)) {
> +            goto out;
> +        }
>   
> -    if (!visit_type_str(v, name, &str, NULL)) {
> +        if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
> +            fn = 0;
> +            if (sscanf(str, "%x%n", &slot, &n) != 1) {
> +                goto invalid;
> +            }
> +        }
> +        if (str[n] != '\0' || fn > 7 || slot > 31) {
> +            goto invalid;
> +        }
> +        *ptr = slot << 3 | fn;
> +        break;
> +
> +    case QTYPE_QNUM:
>           if (!visit_type_int32(v, name, &value, errp)) {
> -            return;
> +            goto out;
>           }
>           if (value < -1 || value > 255) {
>               error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                          name ? name : "null", "a value between -1 and 255");
> -            return;
> +            goto out;
>           }
>           *ptr = value;
> -        return;
> -    }
> +        break;
>   
> -    if (sscanf(str, "%x.%x%n", &slot, &fn, &n) != 2) {
> -        fn = 0;
> -        if (sscanf(str, "%x%n", &slot, &n) != 1) {
> -            goto invalid;
> -        }
> -    }
> -    if (str[n] != '\0' || fn > 7 || slot > 31) {
> -        goto invalid;
> +    default:
> +        error_setg(errp, "Invalid parameter type for '%s', expected int or str",
> +                   name ? name : "null");
> +        goto out;
>       }
> -    *ptr = slot << 3 | fn;
> -    g_free(str);
> -    return;
> +
> +    goto out;
>   
>   invalid:
>       error_set_from_qdev_prop_error(errp, EINVAL, obj, name, str);
> -    g_free(str);
> +out:
> +    visit_end_alternate(v, (void **) &alt);
>   }
>   
>   static int print_pci_devfn(Object *obj, Property *prop, char *dest,


