Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CB9CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBrl-0003Ao-CE; Fri, 24 Oct 2025 03:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vCBri-0003AQ-Fd
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vCBrg-0007ll-AS
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761289531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3cvuvPkep1ENgUdqtxg1V0HTKbRErhg80SzhNUXi8Cc=;
 b=FbsZjQGvSiWCAc4nz2ELhJzIt6AQQa94tGsL4b3/4iO3i2gm2WwhfwmV7VYfhYFlFFk1EE
 RDIFc3dFeJK3DU0ih2PA24sP20dMLnGbq1uh7ntdImSy1ygEjXJVUBiMaYtq85r/P4oSUj
 d8Ugsld7u9Zg+CYa6GXLrVeNvixMwiE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-_B1kF6XwM5S0o-0yFZxFcw-1; Fri, 24 Oct 2025 03:05:29 -0400
X-MC-Unique: _B1kF6XwM5S0o-0yFZxFcw-1
X-Mimecast-MFC-AGG-ID: _B1kF6XwM5S0o-0yFZxFcw_1761289528
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-470fd5ba449so10667845e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761289528; x=1761894328;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cvuvPkep1ENgUdqtxg1V0HTKbRErhg80SzhNUXi8Cc=;
 b=cngSBad5T9mndtqbaNHqdkDhMQUaqElbR+dOTobXgxdULgH4Pd+oKpesxHXwh/1fNu
 /Z3soKK8HEcNO/3HcFXyRnE7tkNBVDvtHtDy53AqqZ86poBsvXlolj3xMaT71+bbcfQY
 b6d8PtKsCL6VYrXHaE0i2CA66H7KIfIn1RQ5QmidUBzcIeYGNkXMHlyBSVt/SqzttnYe
 9rhkR67Adu4YkYPq7+5+QcQn6RfK1qcRJcLJ2zY5qNHDvNjY1xnV24Ie5Igk6KRCKxzS
 menOHOswB0iqux/OmyB8+lt5rHyxHQGZCtyvrwcqAANEMAMMRqLsKm+lf2SzDonHFTG6
 UqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMkdaPj3kvq5IXCuAO8qccq8ljkRVswT5MYlpZouXgG9Qdq6hGo7nxAHkRgaJiXeDELaPAbFplQSOY@nongnu.org
X-Gm-Message-State: AOJu0YxJaz9ZhC/1L5tzJNQdOPzYww3pUOzIinL/T/SsSF7jBLEkhmUY
 ST9oFWNcnV4JmSbZkaT7GjWfsKVFm3tqjV/wTpE/LQyor11MH7c/kSDFwCD2ffQufMdrdD6Wj3f
 ozDE8GelQZ8TrRhee+D7kAThzhIHMk3DjCa39i8G9gkmheoUuNGASKiaA
X-Gm-Gg: ASbGncuI/+BABuGA/pgnMc9Kb4zeF/+DiRCaxDllfEWpY5p7SOdlFEQqU0CHIl+JYdG
 WbR+rRakZjU8365goDTEAZaiKa9LnRURys9CXt8kdfzh0Db7FmSIA8+C3lvq+nKZA3HBnhHR5Dk
 zaVqjnhA9SVKHgZA+Eu/8yn6p91f7+/tw/p3d8ca//MazYQbVLkJmU15r5XddY9RWowQVlhX9eF
 aOC43ODAawRjZmjfuMxCXlhTVv38/sI5XQm5LhPAlrd373QlUrlxpw050DgL2rVeCwc8G95QBMQ
 4oqLfQl4zMFwTGbf0QBj8Niw0Wn+7Tov3UJ2pOB5IrNNSpaPq65LhAf+joknncP6ImqNxbwoJlZ
 5MYFe1D9OvsGsBC9IpRObq+SuphpbU/Du+XJ2ramlsHpp+yFoh7a4KPVaBJd+b6X7974B/v5Oe7
 OB0A==
X-Received: by 2002:a05:600d:42e2:b0:45d:e775:d8b8 with SMTP id
 5b1f17b1804b1-475d24088a3mr7430305e9.1.1761289527975; 
 Fri, 24 Oct 2025 00:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEukfkK9yUlQ2VyE7cp/cMMUvd+Ou5AHX7LyXCHmDgmjQPBo6iIg/G5BLT6fgghls5KGsnozg==
X-Received: by 2002:a05:600d:42e2:b0:45d:e775:d8b8 with SMTP id
 5b1f17b1804b1-475d24088a3mr7430065e9.1.1761289527565; 
 Fri, 24 Oct 2025 00:05:27 -0700 (PDT)
Received: from [192.168.10.81] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4298d4a49ffsm3794670f8f.13.2025.10.24.00.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 00:05:26 -0700 (PDT)
Message-ID: <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
Date: Fri, 24 Oct 2025 09:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 philmd@linaro.org
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251022101420.36059-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/22/25 12:14, Markus Armbruster wrote:
> qdev_print_props() retrieves a property's value from its legacy
> property if it exists.  A legacy property is created by
> qdev_class_add_legacy_property() when the property has a print()
> method or does not have a get() method.
> 
> If it has a print() method, the legacy property's value is obtained
> from the property's print() method.  This is used to format PCI
> addresses nicely, i.e. like 01.3 instead of 11.
> 
> Else, if doesn't have a get() method, the legacy property is
> unreadable.  "info qtree" silently skips unreadable properties.
> 
> Link properties don't have a get() method, and are therefore skipped.
> This is wrong, because the underlying QOM property *is* readable.
> 
> Change qdev_print_props() to simply use a print() method directly if
> it exists, else get the value via QOM.
> 
> "info qtree" now shows links fine.  For instance, machine "pc" onboard
> device "PIIX4_PM" property "bus" is now visible.

It's been many years, but I think the original idea was that dc->props_ 
would be replaced with walking QOM properties.

I'm not opposed to the patch, but it would put the plan in the coffin so 
I thought I'd point that out.

In the meanwhile I queued patch 1, which is an obviously good idea.

Paolo

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   system/qdev-monitor.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 2ac92d0a07..850f0c6606 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -745,19 +745,18 @@ static void qdev_print_props(Monitor *mon, DeviceState *dev, DeviceClass *dc,
>       for (int i = 0, n = dc->props_count_; i < n; ++i) {
>           const Property *prop = &dc->props_[i];
>           char *value;
> -        char *legacy_name = g_strdup_printf("legacy-%s", prop->name);
>   
> -        if (object_property_get_type(OBJECT(dev), legacy_name, NULL)) {
> -            value = object_property_get_str(OBJECT(dev), legacy_name, NULL);
> +        if (prop->info->print) {
> +            value = prop->info->print(OBJECT(dev), prop);
>           } else {
>               value = object_property_print(OBJECT(dev), prop->name, true,
>                                             NULL);
>           }
> -        g_free(legacy_name);
>   
>           if (!value) {
>               continue;
>           }
> +
>           qdev_printf("%s = %s\n", prop->name,
>                       *value ? value : "<null>");
>           g_free(value);


