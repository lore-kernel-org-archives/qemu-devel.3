Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EC7D1D485
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBLD-0001gd-Tm; Fri, 09 Jan 2026 07:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veBL6-0001Yk-C4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:11:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veBL4-0001jA-JZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767960694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D3uJsoyXz7vh50vIZtr0UHIwczu3RKQIX6l67/FjIxQ=;
 b=hcSjTJmihvjDIES3VLZK3mYv9JV6pdXiFlkGYoK/Yl8r5RmHciGJsAZtO7FhvqIA94+tAg
 F28O9pC2S7Vu0RpuMV49B42hsU4P/dAUwxcVHCFRWdSe7nQBA8CSNZCWrqYNeOSo5Q7on0
 WoTBvLzkrv5GrWKe+C0S5tJCI+c+2xc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-r0R71cvoMRG1dzqVB5WTew-1; Fri, 09 Jan 2026 07:11:31 -0500
X-MC-Unique: r0R71cvoMRG1dzqVB5WTew-1
X-Mimecast-MFC-AGG-ID: r0R71cvoMRG1dzqVB5WTew_1767960690
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so38354555e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 04:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767960690; x=1768565490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=D3uJsoyXz7vh50vIZtr0UHIwczu3RKQIX6l67/FjIxQ=;
 b=kMP1Fiu+q7DYZU6hG62JH67ki9LcLpv1Dk3eUM8evfB/A7Ej3juoWwmBcFUxX+DqRs
 gG8Gy+r1dy5P1+AiTNb+z4OvSfSaGbOkAXDfeEGry5HQ7+5ApNJXvKEgnlok7FgnplnQ
 Baj+XNNBe9R2IH3zO0JXDnN5pWXDocHWPbCyQBtx2fsn3Nq813WsjJIEnZm7L5hN9t1d
 aCT6nwkC0z40z4bFs6FcQWh64CtVTdAGJ5VcKuYG3uDeP5I4g9+dOWJ86Q1RKQeAiHNH
 C3Y/MfrM5VPZVjT1zZ5WFZEBWq51yR01ctusLUsjrHqojvGRpnM8qiMvQmQCrttT40HF
 GhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767960690; x=1768565490;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3uJsoyXz7vh50vIZtr0UHIwczu3RKQIX6l67/FjIxQ=;
 b=vYjlcK399fw18dkiPxuo9q4htl8oqdY85Jbls0NQ0NR1j9hB9WYbetBBSuCNNQu0m6
 nRFUKb+qOkfd62MnFxVFsyz3IZOqkr71Q9OdUtDW/rhptpRynI67JG82i5GIxYenl+E1
 U/8YDXn+IKtMq2d/XvdRS5wgf/Tbc/ZQ8LfEGlP0xX8Huuz7yRHPnZV4fZpW7AC5SQmF
 0QhhWPRdjOekQINKNbaiTg5j7ORSYlqwIt6B8T62M1Xikkn84podH+sodoPipQlAAaV/
 TqIHooWi9gJOE7sd9PirdJOor///G4y0nlccOQsoPE8GSk4EsqvaDx2Y8YhRrUUkTrZq
 B1rA==
X-Gm-Message-State: AOJu0Yz0ye8xzlnMtsiXVclbjRXI1IsrUc3Y7+wSbFzSK3P88xLdykus
 nLWgSz/MPBxuopwXFOIJHwA7TAzz+NmtXrGsq43N9qbfuVwaTWygNvhXrH2oaVTdrfeHLut/bZ6
 g3LfO++Tly3J+XHwD+Qvk0G6W/GdsaeJj4IysKdzkiWX69i/1URfKN7eM
X-Gm-Gg: AY/fxX5uNmcSpoMfHcNnVpPjlapzoMJCssZqgZEHydkV6J58GAtlEdlvt+gagO9D4qv
 E7fyfnlyvKhfYYicj5uRwjEN4l5wsFEXsvwdpxatmEouNKALJxZnH6f9EJTER7wd4oZVw/TKHAB
 DZWZxrlndxdQlum+7swATseRKpL8RinqxWcb6/TwRoBax69FOSCTyasQVMHQ560U/oLQCm+XHpi
 nH11o1OB4EvWKfeVlELemar2BfTvSjpaVYhVH9jD43JE/RC/U+dQ7s7lUJEM8RNLBfzS+u0ssbQ
 fI9Nl+5ekhOM4lZ0/+5LG+/cafD44iDmayzRAWKt3v3hcu5aSuxzJkemxqHWtS0i3OJAeYsDdhC
 3JIVV7X+Da47aGvrJL336JAFvgFED1cnwdkwAU4KNHWpKzMCblEM7iPXjEMBsyTHTMYiKajAsi5
 +bOs/yKdAMj3vi5w==
X-Received: by 2002:a05:600c:444f:b0:477:df3:1453 with SMTP id
 5b1f17b1804b1-47d8a177307mr66116905e9.28.1767960690444; 
 Fri, 09 Jan 2026 04:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMClP8jxfN9WVpN2beJFxEBuzdL9zxo7p9nfwBx4eTRRkfIOQApj0+oCYW2LeHHyRWItftXw==
X-Received: by 2002:a05:600c:444f:b0:477:df3:1453 with SMTP id
 5b1f17b1804b1-47d8a177307mr66116615e9.28.1767960690009; 
 Fri, 09 Jan 2026 04:11:30 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa84sm21967932f8f.2.2026.01.09.04.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 04:11:29 -0800 (PST)
Message-ID: <69602270-54d0-4bc7-b69f-27ab16cdb6e1@redhat.com>
Date: Fri, 9 Jan 2026 13:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/24] util: add API to fetch the current thread name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-9-berrange@redhat.com>
 <8867bff0-227f-46b9-b0c6-938fc0d6f625@redhat.com>
 <aWDs0OMLdap9q70B@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aWDs0OMLdap9q70B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/26 12:56, Daniel P. Berrangé wrote:
> On Fri, Jan 09, 2026 at 12:49:20PM +0100, Paolo Bonzini wrote:
>> On 1/8/26 18:03, Daniel P. Berrangé wrote:
>>> +static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP];
>>
>> ... you can instead of the previous patch, add a constructor here that just
>> sets namebuf to "main" with strcpy.
> 
> How about just a static initializer
> 
>    static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP] = { 'm', 'a', 'i', 'n', '\0' };
> 
> or is there some interaction with __thread that makes that undesirable ?

This would break here:

     if (namebuf[0] != '\0') {
         return namebuf;
     }

and every thread would have "main" as the name, because static 
initializers for __thread apply to all threads.

Thanks,

Paolo


