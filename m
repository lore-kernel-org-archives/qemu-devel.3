Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93C3CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fTD-000577-7V; Tue, 14 Oct 2025 09:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fT5-0004sP-GW
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fT1-0003Tq-Fd
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760450008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiqRnSP/X9SSZA8yDUllsWfXGNlAGteT5DU0FW0Muq8=;
 b=Ln02heWGPOCfOEcoovzc3mP4bT08eLtXUJZV1JcS/89bS8M7JKCrlkSFu2ta/OH/y7rGeN
 6I06xnl8xNKZHC7gNLafBbYQ3iEAQOziaBU4/F9yxO7dyC6k1muzmBsUNQuhuJECtsKSsr
 HmKBi15sjf9FS9Ip6iArupV66jhMQL4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-eONBhfFZNy2FUf1t7QcP_w-1; Tue, 14 Oct 2025 09:53:27 -0400
X-MC-Unique: eONBhfFZNy2FUf1t7QcP_w-1
X-Mimecast-MFC-AGG-ID: eONBhfFZNy2FUf1t7QcP_w_1760450006
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so4639440f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760450006; x=1761054806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiqRnSP/X9SSZA8yDUllsWfXGNlAGteT5DU0FW0Muq8=;
 b=MoYYfvnl3n/4zaUqys4e+pReWSc9oNiZgiV5eziq0fSaXxiU5PB9uMyKG0lhb6G4wl
 ZPV1TAJb8MhYwEHqlOf6uUkvcrTGN3cc1nCmkrppwrOKwvxhZKJpt6y98jlFHwBm03vI
 pYQgwpfuMdO0cNJEtHOLuV1LraEuoUY1S4kcnu32ufahbHINzesX55CqnQeK6eG79VU8
 nEgT3sW6SX6QbdHz1qpaoCcRXMhqDVWAQ5mWppykboM0K9uhihjKG6YjqUL0mYofsCgI
 OclyTYq/LBnPDcZKdxEdzYWboqbk3Ice40HzEpbZM/xHlS5Yxe0CwXepj3N8jlSuZq5C
 QrhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjPibOpOnUYupKGqTAyDN369c/g9tuqpq3xOxAlZws+Z/WMsNLGXH8Bw0hpIi69qPguhsxPDOGaE4b@nongnu.org
X-Gm-Message-State: AOJu0YwFBXs3PRSyCIuUn72VZD+9pTwfVyfpVcf9p3aj4ryDfoHRjIBO
 sKwgYPbz21VhtyRhQMQ5bYIMnssTzrojinTP233Lpjtevspt5tsDjqL3gZPi+DC4h9znWbwkg/V
 3HHzriYHIi38Ot9vAoZFzttFEkbrUCAyLeisF4F3/IjBCgup476byfTLRQf8pkdqLwOzp/ZQFrv
 qDyQBVuwDXofk/7UroVp1fihIc6c3OYFw=
X-Gm-Gg: ASbGncvEN9b2SFYe9QNliJF6a5Ycqv1m4TYX11QGIIRv0ozuspb5FiPrrH//syLzSEn
 czuy/NSuc/nIFOGZJM8xLqyOm2qWZ7jbtmIp/0wZNZOWadCKcUnayfLIo29pyeuFl3V8+2V1d+U
 J87wQL4JEWcCCmbYfaYGmy3J8trgXbaCrDpyK9DfnJzh0zwBY63aiTL9HsC+DkswT4bLLD4IvTN
 Q93seVMgn2/RjnozH+6YvnK
X-Received: by 2002:a05:6000:2910:b0:405:3028:1bf2 with SMTP id
 ffacd0b85a97d-4266e8db2abmr14301005f8f.62.1760450006147; 
 Tue, 14 Oct 2025 06:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsRicPE1x1uskBlTA5XpPje4S8wC+d1zd1A3r8QzAyas5dQGZHhztnVz1sQuPWFWV8FcOMMzMv/t6Gn5c1h6o=
X-Received: by 2002:a05:6000:2910:b0:405:3028:1bf2 with SMTP id
 ffacd0b85a97d-4266e8db2abmr14300983f8f.62.1760450005739; Tue, 14 Oct 2025
 06:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250923104136.133875-1-pbonzini@redhat.com>
 <aNVrAkx+ahn7ZRns@intel.com>
 <8a754d6c-1d8c-43d7-b3f8-a4b3e194d30e@tls.msk.ru> <aOyouIh//WY+EkKb@intel.com>
 <d2cf0acc-7ba2-43fd-9d1b-3fcfbb8f7dc7@tls.msk.ru>
 <CABjvBV60PX6OLzkFTfkPDXYUtR_WMVNbm9DQZwjaa_YuBAcfkg@mail.gmail.com>
In-Reply-To: <CABjvBV60PX6OLzkFTfkPDXYUtR_WMVNbm9DQZwjaa_YuBAcfkg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Oct 2025 15:53:13 +0200
X-Gm-Features: AS18NWBGFfEKlUkAzxqAa0jOMAtdmIkWmGzqlH9G0GBsVx-OZwdonW6lkjkGySk
Message-ID: <CABgObfbb-xpaBGZ7PhfQuFQorKwCVWpA057mctX0XqNxMnFhxA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 0/2] Fix cross migration issue with missing
 features: pdcm, arch-capabilities
To: Hector Cao <hector.cao@canonical.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org, 
 lk@c--e.de, berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Oct 14, 2025 at 12:49=E2=80=AFPM Hector Cao <hector.cao@canonical.c=
om> wrote:
>
>
>
> On Mon, Oct 13, 2025 at 7:22=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> =
wrote:
>>
>> On 10/13/25 10:22, Zhao Liu wrote:
>> > On Fri, Oct 10, 2025 at 08:40:56PM +0300, Michael Tokarev wrote:
>> ..>>> I found the previous 2 fixes were merged into stable 10.0:
>> >>>
>> >>> 24778b1c7ee7aca9721ed4757b0e0df0c16390f7
>> >>> 3d26cb65c27190e57637644ecf6c96b8c3d246a3
>> >>>
>> >>> Should stable 10.0 revert these 2 fixes, to ensure migration
>> >>> compatibility?
>> >
>> > Sorry for late...just return from vacation.
>>
>> I returned from vacation today too :)
>>
>> >> Now when I think about it.
>> >>
>> >> There were at least 2 point releases of 10.0.x (10.0.4 & 10.0.5)
>> >> with these 2 patches already.
>> >
>> > EMM, it seems 10.0.x (x < 4) can't migrate to 10.0.y (4 <=3D y <=3D 5)=
,
>> > right? If so, could we treat this behavior as a regression?
>>
>> It is a regression in 10.0.4 indeed.  But it already lasted for
>> 2 stable releases (10.0.4 & 10.0.5).  So by reverting the above
>> mentioned two changes in 10.0.6, we'll make yet another regression,
>> now when migrating from 10.0.[45] to 10.0.6. This is why I thought
>> it might be an idea to keep just one regression in 10.0.x, so to
>> say.  Especially since these changes already fixes issues with
>> existing guests, so by reverting them, we'll bring them back to
>> 10.0.x.
>>
>> It is an either-or combination.  It is not bad either way, I'm just
>> thinking what is best currently.
>>
>> And with my limited understanding of the migration issue in the context
>> (for which I asked for clarification some 5 or 6 times already), it
>> feels to me like "pretending" these above 2 mentioned above patches has
>> always been part of 10.0.x, - declare that migration wont work from
>> 10.0.[1-3] (or [1-5]?) to subsequent versions, and be done with it.
>>
>> And modify the 2 properties introduced by:
>>
>> 6529f31e0d target/i386: add compatibility property for pdcm feature
>> e9efa4a771 target/i386: add compatibility property for arch_capabilities
>>
>> to be part of pc_compat_9_2 machine, not 10.0..
>>
>> Hopefully it's understandable what I mean.
>
> IIUC, there is no perfect solution that makes migration work for all comb=
inations
> of versions as you already pointed out.
> Reverting the two faulty commits in 10.0.x will reduce the scope of migra=
tion failures (10.0.x -> 10.0.y / 10.1.z)

Yes, I agree. In my opinion reverting is the best option, because it
makes the machine types as constant as possible. Any change in the
machine types is a bug and the fix is to revert to the previous
situation.

Paolo


