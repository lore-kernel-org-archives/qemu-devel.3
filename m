Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD31C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 05:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm2oS-0007Tr-9d; Tue, 21 Jul 2026 01:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm2oQ-0007Sk-Fv
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 01:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm2oO-0000t1-Fs
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 01:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784610874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XTaAz2NfG11f78JGCG8dvPj6L9Q4kB1/oovgxv4XAIQ=;
 b=TyYX8mX25RBYbQu6h0wh6KHcc08AxEBqskzsxAWkLAMkUkL/BMmtlH/A6AUgNQK3Z37YW9
 7bXQe4r0EFL9Eacux4yvTrOLU5FiwGUlUKfZ8KgRod2UcDXXtEruG4fzW+PsCGKDaGDriZ
 UmehNWQs71VRB8UuhPm1GFZrV0B5BPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-hBAz6lAfPsGXy4B6BRUjSw-1; Tue, 21 Jul 2026 01:14:32 -0400
X-MC-Unique: hBAz6lAfPsGXy4B6BRUjSw-1
X-Mimecast-MFC-AGG-ID: hBAz6lAfPsGXy4B6BRUjSw_1784610872
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955e865174so11363025e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784610872; x=1785215672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XTaAz2NfG11f78JGCG8dvPj6L9Q4kB1/oovgxv4XAIQ=;
 b=lD3uRHowEiVDPVEkb5JDWiAiMHTot4YD6kLuwZkD2sbg8sxAgP7084cN2EKRMXmvJ/
 8bPRxJEjnY3o5NSTxevzIctx0uKO9F1mer6ML7YjNYUaYsb6E/nZfn0fqJdwp6jJ93Xq
 EZQuFISSeKfuBYV3vnR47RhbdxQDS9sMHbxF4bQZYDGiPlq31x3KrbgY5gmSymgoUX34
 FAx1nQufZirBkClIbcR4OmK79m81pxGLrVwbFS7wQuWPLqGSUbVO+TcmjgPRR6n7rqnN
 w/t4pQ2zZ7LnbrXwT3blM1TRw58oRF4U4lAmc0J8A0PyA70UzQUpAW+NqNUKlbFYWLbm
 U3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784610872; x=1785215672;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTaAz2NfG11f78JGCG8dvPj6L9Q4kB1/oovgxv4XAIQ=;
 b=pAwaAp6E66d+sNkW/iUhIba6rgVSPa0Zbb2xws8ZwjqBNuFT1BRXf2g8RHwjicvE1o
 iiSLIMQMFEOAN6qKiWKF5tQXJr8738svnV5khxm3Vi90UUvyiZkPX692RcWt8AsmAXl3
 lMim1+MRakbPHqsvYsN3xxijlPwoBZfWIis4QT6OVqxpyh+duYw+iBjhqQz0UCrIEYG0
 CU+SDSur77H1r72dRPaXQZR7vq2f6SZKX0B5JWgzhpBFr6dHidAFI/0rP4G0228J/uRh
 eY14nzt4E29nwglIzq5TT9eEVmLN7sLYhpX1O+BE59TuyEx0NSX0t0MC+CY3zX7dUdxv
 C68w==
X-Gm-Message-State: AOJu0Yw+Ek5rAYtj1g/aGNKnR1FMyt2VC6qz1PWh8IU4bjLMR3/2qI4H
 yDXkrZqrb69NffSs+qbU5vr/g/Nn3vdhCb/c86lR9YpPGCW3t9TG7lJu/Y9asW48cE5dKpGt5OH
 FrsfbsBWi3B8pGJyLlDqXlwxzb2TPW+rq+iIIK2TNxhQq5DJeNrJdHY82
X-Gm-Gg: AfdE7clv3VaANj9p0+ucntT7ECfItGJeEhHWvL7ELOn4vJI+ResERwyrVaNmh4gwzio
 JIA9FQcn36jG0t49fmhmYSF2EJ3rIPYXRG2TLC2lxn6xsAbJBGOG2axRwcWWPue/nsIwTTcG/Jl
 xBiME9LMLeR/kT53ZM9IBLesQtsdbEQvhztZ1il787mHi77ALWkofkWRLV/CY5iIFEonnW7Fy2V
 CX0okyHI06LD3Bc2s0M5MPp7VhsRPAtsy/a0gP8EgqoPrp1QcTNa3aAy7zotk+EbIoeRs6coXnD
 bylRnD3h6w3ZaJYuzYGQ+lgTbIkxZaYBvD2POZ+EUMnT8Ir6bHaWe662qD3csqn9XH+XmJ6Nj2G
 7MSGWe3HBRSLDir6R/DU33Zur700WPAGti6Izw2Q=
X-Received: by 2002:a05:600c:4fce:b0:493:fa66:4861 with SMTP id
 5b1f17b1804b1-4954a404bc2mr208468885e9.25.1784610871683; 
 Mon, 20 Jul 2026 22:14:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4fce:b0:493:fa66:4861 with SMTP id
 5b1f17b1804b1-4954a404bc2mr208468555e9.25.1784610871306; 
 Mon, 20 Jul 2026 22:14:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547319dsm37369735e9.5.2026.07.20.22.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 22:14:30 -0700 (PDT)
Message-ID: <de6169d2-15ac-4f46-a249-ddb753946be5@redhat.com>
Date: Tue, 21 Jul 2026 07:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] build: fix sparc64 host
To: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
 <20260720171031.259f590e@shazbot.org>
 <089649f0-b677-4c1a-a42b-eb9853f4fc7a@oss.qualcomm.com>
 <a2273203-403c-4da1-b3dd-0933dd70faf0@app.fastmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a2273203-403c-4da1-b3dd-0933dd70faf0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On 7/21/26 05:33, Alex Williamson wrote:
> On Mon, Jul 20, 2026, at 8:48 PM, Pierrick Bouvier wrote:
>> On 7/20/2026 4:10 PM, Alex Williamson wrote:
>>> On Mon, 20 Jul 2026 22:17:13 +0000
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>
>>>> It was reported that build on sparc64 host is currently broken, due to inclusion
>>>> of asm/kvm.h, which is not present on this platform:
>>>> https://lore.kernel.org/qemu-devel/c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru/
>>>
>>> Isn't is sufficient just to remove the stale <linux/kvm.h> include?
>>>
>>> I don't know of a case that fails, platforms that support vfio might
>>> actually be a sub-set of those that support KVM, but being dependent on
>>> a KVM supported host has no technical basis.  KVM and VFIO are
>>> independent features where neither should have a hard dependency on the
>>> other.  Thanks,
>>>
>>
>> It's related to a recent change that was made to get rid of CONFIG_KVM
>> in the file to deduplicate hw/vfio/listener.c between targets. So it's
>> now unconditionally included, thus the regression.
> 
> I understand.  I'm suggesting the fix is simply:
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c19600e980a8..008f488a3e7d 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
> -#include <linux/kvm.h>
>   #include <linux/vfio.h>
>   
>   #include "exec/target_page.h"
> 
> This builds in both a native amd64 environment and a cross-compiled sparc64 environment.

This leaves linux/kvm.h included only in the following VFIO files:

   hw/vfio/kvm-spapr.c
   hw/vfio/kvm-helpers.c

Looks clean to me.

Thanks,

C.


