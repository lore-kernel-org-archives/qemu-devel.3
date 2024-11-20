Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB591D44171
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 09:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDgjo-0003ls-9k; Wed, 20 Nov 2024 04:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDgjm-0003lM-LR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDgjk-0001xx-PB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732093857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hfkd3PwiEmGUCeNvhgI0d1aKQauRs4OhvkYx77lLgq4=;
 b=YtBoPNdpmVXCBLL9RRTOdJvtwjWVkkZ3xARuc2+QzUEQEPfoh9NgIlORnylgkTD+yq2r+z
 zafCklNOlXQPmJEXo58joIQGDRVRW7mnlcRjOrb6QzgsrLvVMusjzufwHFdGXB7oCcSkaY
 OTFfV7+ig3NcAYn803JlAp3MoOXXvVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Sv2SPiG5P7i9eyes4KZXjQ-1; Wed, 20 Nov 2024 04:10:55 -0500
X-MC-Unique: Sv2SPiG5P7i9eyes4KZXjQ-1
X-Mimecast-MFC-AGG-ID: Sv2SPiG5P7i9eyes4KZXjQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so34794345e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 01:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732093853; x=1732698653;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hfkd3PwiEmGUCeNvhgI0d1aKQauRs4OhvkYx77lLgq4=;
 b=S8F/CidT0AE+ZOMqyS36X1jbLTBzmylsR4OqBJI4nIsSwJjmyIduUHWn4K88P6NP25
 VN5LVF0gY+giE4VgWv6Xc8BZRV85mrREBz5XN5bfJnU5lHL3P+jL/axZZv1VhVCI/PHW
 LpCVj2CYETbmPnTSJf0E2IGUP7MJCCo6m7zqmPI5y4JabOr1xJejJbe2lDEAzvjmyAW5
 04JacqemkWte0QEM0kdSLRg+us32MMkMDi9Pvv0MeoiPbx3GxdWPSxu2XQNv8X9gefv0
 hAWe5zu5pf2cU+o8+piJUhcTHXT4N+cXdGbMq947jwLmHDC+oG3hsm4XhxMhoMYCRiH6
 ibEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj21iVXOqwSvuXZppPZaOc0Asxj+VP/XnnBclnVaKCeR+m9xEZwNZ0evjnVDwFpJ8Ki56F9faesE+Y@nongnu.org
X-Gm-Message-State: AOJu0YzViLafSDL6U/Lk38f/Mxqhqi5Mj8jcfeTa6hsf+V4QNB5CYvIy
 NQXtY6pmMbBR8Xi5tt1aFOfJPQ0QDkyszBaWYK4ut7lEh2z+7qkfFgrAc5ovfNVllQ4p6OCZ/yf
 D/qU86QxjKo65wORPuLT/fgmSjlRyBbVBPiOH4ptwfYREU2gyyHs4z9ripjOI
X-Received: by 2002:a05:600c:34c3:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-43348986248mr14846705e9.1.1732093853449; 
 Wed, 20 Nov 2024 01:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVQmYpQ1dMtS6gky7bV6KZ/eRPxH/nDVx4uYod69u6cV7AXIW/a0giHzrmULMFI9sh/vMtqg==
X-Received: by 2002:a05:600c:34c3:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-43348986248mr14846545e9.1.1732093853150; 
 Wed, 20 Nov 2024 01:10:53 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3825493ee48sm1457277f8f.98.2024.11.20.01.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 01:10:52 -0800 (PST)
Message-ID: <64087716-e9f8-4016-859d-974173d21dbd@redhat.com>
Date: Wed, 20 Nov 2024 10:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/scsi/scsi-disk: Avoid buffer overrun parsing
 'loadparam'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
References: <20241120085300.49866-1-philmd@linaro.org>
 <20241120085300.49866-3-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241120085300.49866-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/20/24 09:53, Philippe Mathieu-Daudé wrote:
> @@ -112,7 +113,7 @@ struct SCSIDiskState {
>       char *vendor;
>       char *product;
>       char *device_id;
> -    char *loadparm;     /* only for s390x */
> +    char loadparm[LOADPARM_LEN]; /* only for s390x */

You would need a +1 here because of

static char *scsi_property_get_loadparm(Object *obj, Error **errp)
{
     return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
}

expecting NUL-termination as well.

> -    lp_str = g_malloc0(strlen(value));

I have sent a pull request that simply adds the +1 here, also because...

> -    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
> -        g_free(lp_str);
> -        return;
> -    }
> -    SCSI_DISK_BASE(obj)->loadparm = lp_str;
> +    qdev_prop_sanitize_s390x_loadparm(SCSI_DISK_BASE(obj)->loadparm, value, errp);

... this would overwrite SCSI_DISK_BASE(obj)->loadparm in case of error. 
  Note how the code is setting loadparm only after a successful 
qdev_prop_sanitize_s390x_loadparm.  That's not a problem in practice, 
because failing to set a property is usually fatal, but not good style 
either.

Thanks,

Paolo


