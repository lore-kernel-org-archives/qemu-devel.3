Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F25D77892
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 17:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjKx9-0000Dd-Aq; Fri, 23 Jan 2026 12:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vjKx7-0000Cd-Ce
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 12:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vjKx5-0007qZ-LJ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 12:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769189286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDN/eGC9r+QfWyzU3wF2348KbKILb8kCKmxzDjl4iDI=;
 b=IRQGc4+h4UX42TYAMdYkoxXSMvTbUwoI1L/OYMxhhrwDYuw1CBoMYpnO8QUdbZEWnpEu6F
 3Rr79S9u0ihv+mS6wmPS5R5Vfk5noFoV3ux0SOn0qq093HmOqMqxZdN1FLsUUtyxor19Xl
 PHUlbStarUE47Nevwq2PNySVxKm3c3w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-Pmf1zg-PP3GziIg1_gDnuQ-1; Fri, 23 Jan 2026 12:28:03 -0500
X-MC-Unique: Pmf1zg-PP3GziIg1_gDnuQ-1
X-Mimecast-MFC-AGG-ID: Pmf1zg-PP3GziIg1_gDnuQ_1769189283
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435ab9ed85dso348369f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769189283; x=1769794083; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lDN/eGC9r+QfWyzU3wF2348KbKILb8kCKmxzDjl4iDI=;
 b=G+dGguimOEmmzfJ4EOTC/7v7Oa15uUw/owSTNEXHfDsOj2RZ5SKOn3asCD0NU/7GAc
 SD0wHOVxDeViRnhI1cWUsFgxuaxJ4JwGY9ikXbTiPDDGoF+UV8Pe2OHvBHnxzvrbg21c
 mxo0zrEjnGe6ZybTvQcW8EcxbJ5VIgXfrrBOSFkJy4iirqq9cVHwbkQtvdrt54xwvJx1
 FSfBIZCOF6ngSw7YT3jbHdN2+DZ6/9kRy/PnO+Jw7UG4qLJbt60g1H7vHZ18nqGESpjK
 KttZxqDVsqnnN2LHA9sZwFbZJz/qVU966zUvvymFEyRan0LIDeGcQAiCYCncHI3OgBUh
 ywJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769189283; x=1769794083;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lDN/eGC9r+QfWyzU3wF2348KbKILb8kCKmxzDjl4iDI=;
 b=rtQSolHRYh6o8TWpf99lS4SIMH4h0OCpelwgZ2i4d0n+YuvL/Xs6JLah6C2QPjEWop
 cLgfxElAg4PABM9QSDcSAeohkjCNQrmsAOUwVah4ajBkFjzPR9ynfbayIlr4KKlYA9u3
 XmxXfArghoh0pe6wd4ckuC+HMx0DYsTC+IvaSTO5/wCJ9VGh4U59Mz7QYXEbPDpOB512
 aogeJMo6bPywuYJpJh5DbpIwjnmmKnxizpLPXnvk8n54OC7nrCW/8/LMepSBqFD91t51
 1GYBgIl5igeDb3oSIU6rZSiqEQMnAHyMewkjJDwPxAew/m08UFLdZCE7lSb2nPEIGRIE
 n4Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKKe1R2K6RHGwy1V5dL4LZOJ3XZs8RnAbU9vayQyHExOR8Vb/4/GrsWFsex+ijs4XZT+JubBIpivN/@nongnu.org
X-Gm-Message-State: AOJu0YyFkSTCnFeXJMHdB3JTYJ36FXAdNjhZJfbDbI/Ipo1tsNY7GSYu
 HhhLSUdP0yzOedoRXUZxmhs08r/179CUphquZ5eax2x9c/Vg8w+t3TZQr/tusz91WpyTHkW4rgZ
 avI+Z8ZF6iypA9M3463CCVryJoXoA8B2HUCX9OYi4Lw2wQsS3GLQsHgxT
X-Gm-Gg: AZuq6aLyRYf52fVkuDhLWKSgTb4PXZwvwShpJSm3sL4vJJS6FbSVJxgNtezyUVYKacP
 VfoH5Ci/oy5NDOlleXYkFdDE6VKI0+Ckdn+8RtvkXxv1xe8O45+RbtgXHnyseReH0bJnb92E/7Q
 54ekbF1THlv4CvgTQjl5AfYfKcZlvnJCRmL30lXnBH35s22OxIbyt+fbdLR2aZdUYa4XtvmJiry
 hREtHhCEuoe/WlSWPxIghNzLk72op5AwYTDGC8X2P8VkHQXM3aBnh9rEPSkbeYsCbU7S0HTn+Ki
 WwtFGaspU6sR/yQg814ab9hWsqcDD1aPGN2tlowZL0G2imMAgQgG6+Sycrb5MnlHeIfhx0Yw/rC
 ArV4wAx26qRW4l9xMe0RRk4k+axVT519p30xqSQiLbMYdZ1hVnFcyQI7ZbKc=
X-Received: by 2002:a05:6000:178a:b0:432:c0e6:cfc0 with SMTP id
 ffacd0b85a97d-435b16270a9mr6428168f8f.57.1769189282677; 
 Fri, 23 Jan 2026 09:28:02 -0800 (PST)
X-Received: by 2002:a05:6000:178a:b0:432:c0e6:cfc0 with SMTP id
 ffacd0b85a97d-435b16270a9mr6428132f8f.57.1769189282247; 
 Fri, 23 Jan 2026 09:28:02 -0800 (PST)
Received: from rh (p200300f6af31d00062ddfb9151537832.dip0.t-ipconnect.de.
 [2003:f6:af31:d000:62dd:fb91:5153:7832])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm8208594f8f.9.2026.01.23.09.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 09:28:01 -0800 (PST)
Date: Fri, 23 Jan 2026 18:28:00 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org, 
 oliver.upton@linux.dev, gshan@redhat.com, ddutile@redhat.com, 
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v5 10/11] hw/arm/virt: Introduce framework to aggregate
 hidden-regs and safe-missing-regs
In-Reply-To: <20260121074834.1900677-11-eric.auger@redhat.com>
Message-ID: <1d622049-4b20-a12e-61d2-847c3a83869f@redhat.com>
References: <20260121074834.1900677-1-eric.auger@redhat.com>
 <20260121074834.1900677-11-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 21 Jan 2026, Eric Auger wrote:
> Currently if a virt_machine_<n>_options() sets a TYPE_ARM_CPU
> x-mig-hidden-regs or x-mig-safe-missing-regs array property, another
> one cannot overwrite it or extend it. We end up with a core dump:
>
> qemu-system-aarch64: can't apply global arm-cpu.x-mig-safe-missing-regs=0x603000000013c103, 0x603000000013c512, 0x603000000013c513: array size property x-mig-safe-missing-regs may not be set more than once
> Aborted (core dumped)
>
> In practice we would like an easy way to register regs that belong
> to either of those categories and allow aggregation of those.
>
> We introduce arm_virt_compat_register_safe_missing_reg() and
> arm_virt_compat_register_hidden_reg() which populate GLists of
> int64_t. After all virt_machine_<n>_options have been called and
> have registered their regs, the GList are converted into the
> associated array property value and the GlobalProperties are set.
>
[...]
> +static char *get_prop_value_from_reg_qlist(QList *l)
> +{
> +    size_t size = qlist_size(l);
> +    GString *s = g_string_new("");
> +    QListEntry *item;
> +    int i = 0;
> +    QNum *qi;
> +
> +    if (!size) {
> +        return NULL;

Do we need to free s here (or allocate later) or is there some RAII magic
involed?

> +    }
> +    QLIST_FOREACH_ENTRY(l, item) {
> +        qi = qobject_to(QNum, qlist_entry_obj(item));
> +        int64_t regidx;
> +
> +        qnum_get_try_int(qi, &regidx);
> +        if (i++ > 0) {
> +            g_string_append(s, ", ");
> +        }
> +        g_string_append_printf(s, "%" G_GINT64_FORMAT, regidx);
> +    }
> +    return g_string_free(s, false);
> +}

Reviewed-by: Sebastian Ott <sebott@redhat.com>


