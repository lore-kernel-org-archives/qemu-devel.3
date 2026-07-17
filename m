Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C359C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkbfc-0004aI-Kl; Fri, 17 Jul 2026 02:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkbfa-0004Yi-I3
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkbfY-0007ue-FP
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784268209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OQ8rVbN6rQPjC+56fOwPxHKrS1kO9Dbv05Z4ttG6YDI=;
 b=UFLfnpno1u5YEDWCnykLODgOIuVU5NAwSej2jVmxwjccBI1bZNa7ISvTZ76S7rjKfIL1Xb
 y1XQePvuBAob/HdKHVZE8ScBAeils3SVowsR5eXGL6zzCh1dii0zcJvJk3FP6ufCclPgHR
 SPgFvPxbF3ZjdoyOyj8sG6Pn5jDGBKs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-fQwDYfdaOfGanUVUiqo1yw-1; Fri, 17 Jul 2026 02:03:27 -0400
X-MC-Unique: fQwDYfdaOfGanUVUiqo1yw-1
X-Mimecast-MFC-AGG-ID: fQwDYfdaOfGanUVUiqo1yw_1784268206
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493ce4b7777so56344875e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 23:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784268206; x=1784873006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:to:from:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OQ8rVbN6rQPjC+56fOwPxHKrS1kO9Dbv05Z4ttG6YDI=;
 b=jGZI5nBSUGq6oEuS2DEBc7SyQzsiX9EtzOUi/uvfHPImTOUbCYm2LBHwTDyMJOqxt7
 oeKAnmSeQgDSy6U18tC7ZhODJ4pMF2Gl26FfUhLi7zyA/rSpqkqNKJ7M/vpF6j23dOTn
 fNVCZHsx6qRPbCWHTQ7xTkPbvMyK3Z4qSruMRStWQo4f+qYuGtqzMT2PB879mCO/2n+f
 RlTvPUsYTtWOdbb7fhFWQMeivShiLHoCjwXmQy3KlIt4wBbA2yvJMn1JqJGPDjXq2Bo2
 fkW+P+PI1CxO+cDP0Nd+11FoC1fiTyx8KbdV9uVVvpCEnF5qVSpe6r1tkYlnPqucNuLj
 jZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784268206; x=1784873006;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:to:from:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OQ8rVbN6rQPjC+56fOwPxHKrS1kO9Dbv05Z4ttG6YDI=;
 b=YJidHmlncL/R6mE77kdpP9uBE/dkbzQQkJKZHvGQJtzIaMc0tgYLXsP4JPhdwIbEe0
 G11KNSMJYGJS1CPLoWWoLMnRSEps55ITohWkgp2ZdTbb1a84+pn3I6L+7xdkIpRr8joq
 CsLcqXKlBsmr8lWN3gjfQCwEYUhLBuMqYXpXbmfiT1hhp4gIzBXcNm9miK7PNoZmDxRu
 v/OqSr96AimWs73se1nNohla/Zc0hQEkXCQMM/zcl5TJmibj3wsPdSmI62n76YAh4UJk
 sY8QAy307tr614erKN9IKS+H94acJittUoJF1t64crThY0Ld5gSi6eXLWhQmUXC4BD3s
 KxLw==
X-Gm-Message-State: AOJu0YwObqtnHB5FT4+1p4eDRLihj2gjN71Ey0aW0kME/pxMhOzLXrWq
 gChBfKkCBrcPpGPJ8YNHPq9pqk0Oe5UQ6DNwh8G0Wyw6W2zsjDEpehPJJBwDI6OCS+Z0dt+7O2t
 s/UMrW5gEI1FAuOQZ0sAePI0uwN4WXG4y0OT5PFAHsMHRSpEglKZ0i+4VB0F1eHRZCNsLOdrPrM
 OybFeLO05Lwz2TQDaKHohkvDDb1BZtPuFZ829U
X-Gm-Gg: AfdE7cm4M1IODP7MFOg6y1AQmxhSty9tIEpjK+r1ly9zaTh3igP7m1igNMQI3c1TjJX
 bLZEF6aGBKxic8LVKGx92ZRoCClZxCiJFjU/P1z+lsd89BBXBkyTIcXmueKqYXTHunKsAh6lHYR
 WlCazUIL+5F+WKQqQQIp0kmDmxlsi7j/3gp3i3NG73Jr2eOfX+zP3lOYoTv+hmoDMsqpZ4jqO8C
 rKW47IdbnEPDrOO1ShcEIrU1pdTL6Q3Wp3iEzQy3XjgSt84Z3QgdfYmUzo8qX3NtlBJY2YnEpkN
 0YG8OhDlbwic12XwMW3Ndj3cMEqhR+8Gne4HlWnDa8RelfN5GZQZt69ltYM=
X-Received: by 2002:a05:600c:1d1e:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-4954a3d0cc7mr11565955e9.2.1784268206278; 
 Thu, 16 Jul 2026 23:03:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1e:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-4954a3d0cc7mr11565235e9.2.1784268205627; 
 Thu, 16 Jul 2026 23:03:25 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49469sm934837f8f.7.2026.07.16.23.03.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 23:03:24 -0700 (PDT)
Message-ID: <ea3a1d28-7e31-4075-bef1-812eea6bfec2@redhat.com>
Date: Fri, 17 Jul 2026 08:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-uas: Fix guest-triggerable heap OOB access
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
References: <20260716193321.256391-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260716193321.256391-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/07/2026 21.33, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The stream ID is under control of the guest, so we must not use
> it for indexing into the status3[] array without checking it for
> being in range.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3612
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3986

As requested by the reporter in the bug ticket:
Reported-by: Tristan Madani <tristan@talencesecurity.com>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/usb/dev-uas.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
> index 8576dfec96f..7df58cdeee7 100644
> --- a/hw/usb/dev-uas.c
> +++ b/hw/usb/dev-uas.c
> @@ -383,8 +383,15 @@ static void usb_uas_send_status_bh(void *opaque)
>   
>   static void usb_uas_queue_status(UASDevice *uas, UASStatus *st, int length)
>   {
> -    USBPacket *p = uas_using_streams(uas) ?
> -        uas->status3[st->stream] : uas->status2;
> +    USBPacket *p = NULL;
> +
> +    if (!uas_using_streams(uas)) {
> +        p = uas->status2;
> +    } else if (st->stream <= UAS_MAX_STREAMS) {
> +        p = uas->status3[st->stream];
> +    } else {
> +        warn_report_once(TYPE_USB_UAS ": bad stream ID 0x%x", st->stream);
> +    }
>   
>       st->length += length;
>       QTAILQ_INSERT_TAIL(&uas->results, st, next);


