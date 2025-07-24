Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22A6C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 14:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uexPH-0000Wc-FM; Thu, 24 Jul 2025 10:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uexP8-0000Qh-Mk
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uexP6-0005ZL-7v
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753369118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEqy0tAc3L+CYRIUpCnvDxZj0h/6TvXwXjuHcM6Lcrc=;
 b=fQS/p+ADw5De9EXozQQHcgKVJiqBA0lqNnMwpkZVOlQ5Dy2vIBikjqiUuYBOkByvO6+eM9
 LbVL4JHn6K+H9dXt6/lWVzUK/K8XKEuIQYRMGq6vKep2PZnx44O4bfCSSG2LQabw1UGYAP
 9h5c0Auuz6KJIz+AjWpZ6Xl5y2bGXtA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-OzmhLDcwNMqWmjdpU4FVUw-1; Thu, 24 Jul 2025 10:58:37 -0400
X-MC-Unique: OzmhLDcwNMqWmjdpU4FVUw-1
X-Mimecast-MFC-AGG-ID: OzmhLDcwNMqWmjdpU4FVUw_1753369116
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so563115f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 07:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753369116; x=1753973916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pEqy0tAc3L+CYRIUpCnvDxZj0h/6TvXwXjuHcM6Lcrc=;
 b=XstQwKGp2oRf1pyv1oAVAb3wSugBPZxyWqTz3wlzlKA/HrE3w5P9HqyqDIdRiHsvas
 RoH/72+Iq2M2Bnbuk7ySbwn7IDUiyzW8JaKBCu1FJ0NFUSxAYKzxHvXdnPCBTy5SRVN5
 2TYpkDPFooKBdKSpmIoCYsdHDQnAWyY2XniVTAQuMXXaPyQNVvSKyf/yIHEADNmdNEe4
 r5uvSKozbPgtxytgYvrodN3qLhg8EbuZ+qUWO26qkOT17DjX7YfuWwDTZ0ShRW/ceCbk
 46ZlzXh8wqG00RPkkDjjjOivdrhBzFe/TeXNCqMwaOMk9u3L0yk7KVWHCPtYzVmDZXeM
 +90A==
X-Gm-Message-State: AOJu0YwtpokrsWcPItaO0QDiaJDGvxeLXEA85gaYI+fpnkNU3QTMaatj
 JDR7Uaq7arH1hdrlCdmoHWw7vw0SfrOAH52Rb1VyhTaDuE60Mv57q2tUV0u07wj9Tn5/0s544PU
 LpsCRf0ZL1XmqHmDkXXipHB+baQf8IrYsta0Ylvrh0979BWye0hurftwM
X-Gm-Gg: ASbGnctN5Zl3NPV9z4s7wnaqOZhcx8KPt8bVHjBc9dmkC1Stwe0+1R/R3sDcwReIgmm
 oJR4NKaFjvJagNgNz5yYhSisCmDaPZLAOAiTIWK8YYaVn8soFFIkFO54YjRQsUq0zZ8jay7hZlN
 1yXulQXoI6OsuYdvFDD2iYKD3XIS3JufpYzMss/38Ai7qYxwnfuMxAfTmKpv4jSOHYDhjY5QPDy
 7c6EK4MXDY9fRiVRXxRiJkcM1utW5AD+jVtvsdq6tbYqAkGYnTfCZkbhdCxA/G0xiY6wk9HihIo
 wb3Qio7vC9IvGQd1XC2D0iPeNI9chC1HwDr9ioD4iMx0bS5dU3TDqs7vwX+wVn+gw74Q4IoJmtj
 9QmSo/7sqY5hsZfOUqv3S6+JyXf7ZP5n6m3DOCPXdgdRYpYs9ABv3KkZddb75dB8DXEQJ
X-Received: by 2002:a05:6000:2887:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3b768edb95amr5688773f8f.23.1753369115621; 
 Thu, 24 Jul 2025 07:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP2/bM78+AEfjMSPv8fPajTVBgfyz3sll40t8GAP/naK8pYi7f4Ob24k8f+NU/KQG7pgLQaA==
X-Received: by 2002:a05:6000:2887:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3b768edb95amr5688752f8f.23.1753369115152; 
 Thu, 24 Jul 2025 07:58:35 -0700 (PDT)
Received: from ?IPV6:2003:cf:d706:376d:ff28:b03a:a15f:3cdf?
 (p200300cfd706376dff28b03aa15f3cdf.dip0.t-ipconnect.de.
 [2003:cf:d706:376d:ff28:b03a:a15f:3cdf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc60501sm2464999f8f.2.2025.07.24.07.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 07:58:34 -0700 (PDT)
Message-ID: <e62d351c-0fe7-4987-bbbf-d99704cc3e9b@redhat.com>
Date: Thu, 24 Jul 2025 16:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vhost: Do not abort on log-start error
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
References: <20250724125928.61045-1-hreitz@redhat.com>
 <20250724125928.61045-2-hreitz@redhat.com>
 <tjqbvfrpzqgp65ibiasyct7k2ibzkhdrlev4ov45i3xsaxox2g@wwojtijmv6hs>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <tjqbvfrpzqgp65ibiasyct7k2ibzkhdrlev4ov45i3xsaxox2g@wwojtijmv6hs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 24.07.25 16:24, Stefano Garzarella wrote:
> On Thu, Jul 24, 2025 at 02:59:27PM +0200, Hanna Czenczek wrote:
>> Commit 3688fec8923 ("memory: Add Error** argument to .log_global_start()
>> handler") enabled vhost_log_global_start() to return a proper error, but
>> did not change it to do so; instead, it still aborts the whole process
>> on error.
>>
>> This crash can be reproduced by e.g. killing a virtiofsd daemon before
>> initiating migration.  In such a case, qemu should not crash, but just
>> make the attempted migration fail.
>>
>> Buglink: https://issues.redhat.com/browse/RHEL-94534
>> Reported-by: Tingting Mao <timao@redhat.com>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>> hw/virtio/vhost.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> IIUC we always had the problem, so it's not a regression, but should 
> we queue the patch in stable as well?

That’s my impression as well.  I think it fits and makes sense for 
stable, but it isn’t absolutely necessary; it’s not a regression, and 
abort()-ing is not a critical problem.

> Anyway, it LGTM!
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!

Hanna

>
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index c30ea1156e..05ad5de629 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1110,7 +1110,8 @@ static bool 
>> vhost_log_global_start(MemoryListener *listener, Error **errp)
>>
>>     r = vhost_migration_log(listener, true);
>>     if (r < 0) {
>> -        abort();
>> +        error_setg_errno(errp, -r, "vhost: Failed to start logging");
>> +        return false;
>>     }
>>     return true;
>> }
>> -- 
>> 2.50.1
>>
>


