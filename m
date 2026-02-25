Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF10EFD205
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9ti-0005lO-FL; Wed, 25 Feb 2026 03:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vv9tg-0005iW-NP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:05:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vv9tf-0000sy-02
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772006725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ikyzkts721L5JCueYlPHhLJIrBzi/Gft4KsIokRrZY=;
 b=jGTSMDs61A37vXsX+DvAuG9xq2X6gZ7izzEumHuaOhmWOl6pZxYkLO9xt2UO/vgMkbbUAp
 zm/nCL3TMNQYrothV5Chzc1iAKQTVqbbUGjLPIwDDDK9qJ+FVOIdGFA11IpX3W3KseTmdv
 x5Udv0QxwxiM8Eos0L3dJPlhSWtIw9c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-1WsfPybyOd2wNrI95nMcew-1; Wed, 25 Feb 2026 03:05:23 -0500
X-MC-Unique: 1WsfPybyOd2wNrI95nMcew-1
X-Mimecast-MFC-AGG-ID: 1WsfPybyOd2wNrI95nMcew_1772006723
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48378c4a79fso47550575e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772006723; x=1772611523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Ikyzkts721L5JCueYlPHhLJIrBzi/Gft4KsIokRrZY=;
 b=Ui831Axd1ZnIWX3P3ALl8zcU0l6WX0YYQXH/6v/c00BhR+yHUt4y/ZWKtzVGW3xm8Q
 7QYQpSowtNsUWOJXfWDHo+sztlGL10dMluaYDVCGy6Y/qNnYf9PQZXzEYXdTmJ5XSO7j
 gqr0mVgopub0XOcCVT5WQjVXu62zPUpV7aD1wZyOqsdKPdjIfTM1Y76Cx/EvQCPSI8FC
 d8HczVmd9gWL8nQFCJl6sDEVkJWyRbjRk7tZW9/XAPBzSoJTJFDPiGGtbjc3eOewKLEZ
 Fom/dchii0Z7Pitqh8GjhHG/OpZ2VSJ56P3nvPBGSZr1hGbWWq1LQB4QjThmFiKI306x
 QBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772006723; x=1772611523;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Ikyzkts721L5JCueYlPHhLJIrBzi/Gft4KsIokRrZY=;
 b=JHogY1I8DWOdtCKjiqs6q01mN5BTyR4TY/DbSMXko8mpfjG68wfQE65eKTBFnPjlWB
 afEI3mna0QxXz27pqJ5YOAJOm6KlIrXonJfvQK32ol3HD8nswUPJXoR4ZWgb+06HDOXz
 0I8fAOAg415lRiABFT7vDSFui4Wmd1lmA5Kx05OWP+ovFCjEdjB1RYsdhwt+FcH7OeVu
 I5dIH75HCH+sQXbTQxRE8xRThfvAkfdIlXBEOe4VsU2vIaU2JDONiklnMFnGwilE0PG5
 0UStbU5uTpfB8BFDcfTCMmypoqLxpHnnGPhgd6r8XIGwLTQ/lZKVP+6v53vCcxouE8Hh
 iW7w==
X-Gm-Message-State: AOJu0YwrZWQ2QDrXSHvJQ3CryJx+GFxm8kXXr89kktNs3IzSICj35Udd
 V9FOqmmvpZJwytRGsgwacGQgWVKZJz1oUm36syzCW24WnNzf/hKTAOnDViLtahPqCqk41hXOa2Z
 ZQlCunglDNJ2c5MY9N2ScaLmU8awJnE+vSUrnY8ilF9+Hhlfl1QKO35h5
X-Gm-Gg: ATEYQzx46zkDpGSYMP/KwM1USFVzjtpHMRdYGZJ0bgr0r/eBlCKz2lS1Dluvl7eJpQ7
 R6FX0S9ml0Y3yRIqI0uESv5YuVpLCeOa/dkLh5KqOj44Ft0qrCn1nbr8uajJgCGEIYp+3+WnTCV
 uFwnHinbunHZK2YOoSkXu3OPXS2az3yt6sHVPGdT0Sh5WsZnECLVizqjlIJUMnbBYmIxQuxqy4x
 wauD33xl1Dvsb8ACTTrV9+2Yx1XedUddfmJPx8h1UPYJg4qxL1nzJCvdcNA2/sk/x7ZnNuQ5/84
 JUBji7Sa8wFzA0EDnokKTrK9HKOyqnUK9FWxRkNiisBNyITbl0k2OQh8JA8EFNnEANhFbuinYEJ
 GRKm5+1VsN6Tyrkrf5ueqtf0ohR5WnO1us5MOoKn/7xBv60YNC+11Liu9HGWE51RUU65ZvN24zk
 jIH8+mJNRlXuzKVwRT5FccgIamxII=
X-Received: by 2002:a05:600c:5289:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-483bef5c44fmr23389845e9.28.1772006722610; 
 Wed, 25 Feb 2026 00:05:22 -0800 (PST)
X-Received: by 2002:a05:600c:5289:b0:480:1b65:b744 with SMTP id
 5b1f17b1804b1-483bef5c44fmr23389235e9.28.1772006722035; 
 Wed, 25 Feb 2026 00:05:22 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bfb296bfsm8894595e9.0.2026.02.25.00.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 00:05:21 -0800 (PST)
Message-ID: <e88e3a0f-6b15-4967-8e9c-613ecf537b5e@redhat.com>
Date: Wed, 25 Feb 2026 09:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] rust/qobject: add basic bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-2-pbonzini@redhat.com> <87jyw24fw5.fsf@pond.sub.org>
 <58720d10-5613-4235-b47f-939e9a8d3096@redhat.com>
 <87y0ki1d21.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87y0ki1d21.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 14:33, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 2/24/26 11:03, Markus Armbruster wrote:
>>>> diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
>>>> index b9ed68a01d8..0907dd59142 100644
>>>> --- a/rust/util/wrapper.h
>>>> +++ b/rust/util/wrapper.h
>>>> @@ -30,3 +30,10 @@ typedef enum memory_order {
>>>>   #include "qemu/log.h"
>>>>   #include "qemu/module.h"
>>>>   #include "qemu/timer.h"
>>>> +#include "qobject/qnull.h"
>>>> +#include "qobject/qbool.h"
>>>> +#include "qobject/qnum.h"
>>>> +#include "qobject/qstring.h"
>>>> +#include "qobject/qobject.h"
>>>> +#include "qobject/qlist.h"
>>>> +#include "qobject/qdict.h"
>>>
>>> Is this file just for bindgen, and never actually fed to the C compiler?
>>
>> Yes.
> 
> Thanks!
> 
>>>> +impl From<()> for QObject {
>>>> +    fn from(_null: ()) -> Self {
>>>> +        // Conversion of the C inline `qnull` function
>>>> +        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.base)) }
>>>> +    }
>>>> +}
>>>
>>> Could we call C qnull() instead of using qnull_.base?
>>
>> See v1 review - no, because qnull() is inline.  I can make it not
>> inline, of course.
> 
> I feel making it inline was a bit silly.  Perhaps I had a non-silly
> reason back then, but I can't see it anymore.

Maybe it was, but qnull_ is also used by tests/unit/check-qnull.c; and 
it would also be silly to make qnull() extern while keeping the global 
qnull_.  In doubt, I'd leave it as is.

Paolo


