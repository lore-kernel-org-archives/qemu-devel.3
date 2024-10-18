Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A95D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p8h-0005e8-J9; Fri, 18 Oct 2024 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1p8f-0005dt-HH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1p8d-00015u-9y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729266217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WZHPztKe1daD2Kh+phZWpfLgDsenz88dq9Esk/z1amo=;
 b=bMGl/CGA2c9Kk/aPHV8iHRmvmGK0aYYgbeN1s7oubTwZT6Vtshz8OllYNqdXZMbtDO/DFG
 GYyFZzLo5AlhW08fkCzWLOi503/hDU+NctcChwvEMkOzKlL7+tVbm9BOiHtsAhZGXDCYjE
 adHPUele7dGz1bLYrsBYfbxZyypt6xI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-3dywI9JDPwiD-rjpZJoGbw-1; Fri, 18 Oct 2024 11:43:36 -0400
X-MC-Unique: 3dywI9JDPwiD-rjpZJoGbw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d95264eb4so1100003f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729266215; x=1729871015;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WZHPztKe1daD2Kh+phZWpfLgDsenz88dq9Esk/z1amo=;
 b=pemcoXE6+GYf4pkqqhrj1y4gS2FTc8WtopG9LeDplBEdqlAwcYUZ9ULL+XmIo5XOai
 rZHjWoRZsh8WyNZCS4XEQchSWkn15AwiJJExkpu1exBTAix3lALad5h5zuyEZYyCOv7t
 uUtgo4JBtyCnP2zXEw8Oytuw6ESdJoG3Q4d/nHI5XtbBDb7xTXk4RqmuuRPBDvoOnIMt
 s1F5hovYvJJ2Xd0UpLrfj2dRs2oxpvw4iUggRyfBdiOyzMT9OwcS13Y8BNyMZ6fRoLiH
 JiuV90WDK6q0aPeeuo6DAiLRmo1eP3FWKTJkcSGNaWfIWyOfw6DyTXKSNB6PCNNP5tEo
 ue+Q==
X-Gm-Message-State: AOJu0YyDiXpEY99I+lksz0jINzWZKHBWcDglzYQp8UV0Bt/hafPN7xzl
 kjOHFXtdMBPFOHRBmxloUl2TcpLG07A9VWXim0WBV1Shk7pISkgxi1xqsHb6Mcqe/PS7J5W4g9T
 UuHI28jDNT5dYsaGOXk+U+pvUCqn0rHTyM+KDUk3nXK1On55Mmr3D
X-Received: by 2002:a5d:49c7:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-37e8b6c7183mr2198986f8f.0.1729266215010; 
 Fri, 18 Oct 2024 08:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIGj4wfAqPGWrL/TqAfy1IgMLAnV3MdHf3/no8YLHUyMaZly9kp4oVidRxp6yu3q3ZtV/KGA==
X-Received: by 2002:a5d:49c7:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-37e8b6c7183mr2198964f8f.0.1729266214396; 
 Fri, 18 Oct 2024 08:43:34 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ecf140298sm2213958f8f.110.2024.10.18.08.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 08:43:33 -0700 (PDT)
Message-ID: <2f34640b-77ad-4267-975e-7898b6f8e38d@redhat.com>
Date: Fri, 18 Oct 2024 17:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] rust: allow older versions of rustc and bindgen
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <ZxJjLpDe0-A_6PEL@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZxJjLpDe0-A_6PEL@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/18/24 15:31, Daniel P. Berrangé wrote:
> On Tue, Oct 15, 2024 at 03:17:18PM +0200, Paolo Bonzini wrote:
>> On top of this, the required version of bindgen is still too new
>> for Debian 12 and Ubuntu 22.04.  This is fixed by the last four patches.
>>
>> This is an RFC for two reasons.  First, because it would be a valid
>> decision to delay enabling of Rust until at least some of these
>> features are available in all supported distros.
> 
> Lets say we maximise our back compatibility today, and have to
> carry some sub-optimal code patterns.
> 
> 1, 2, 3, 4 years down the lines, we can gradually eliminate
> those undesired code patterns / workarounds, as older distros
> naturally age-out of our matrix.  After 4 years our entire
> matrix will have cycled, so we're not needing to carry this
> debt for very long (4 years is not long in the context of a
> project like QEMU which has been going several decades)

I agree, for what it's worth.

> Personally I tend towards quicker adoption of Rust, despite
> the need for short term workarounds, as they'll disappear
> again reasonably quickly.

Yes, especially since (as Kevin pointed out) most of the workarounds are 
okay in terms of maintainability.  If the worst is "if let", and it only 
occurs in a dependency, we're in a good place overall.

>>                                                   Another possibility
>> could be to accept Rust 1.64.0 but require installing a newer bindgen
>> (0.66.x for example) on those two distros with an older release.
> 
> How difficult is it to get newer 'bindgen' installed on these
> platforms ? The audience here is not so much distros trying to
> package new QEMU, as that's ony relevant for new distro, but
> rather it is end usrs/contributors building QEMU for themslves.

Very simple - "cargo install bindgen-cli", as already seen in the 
fedora-rust-nightly container's Dockerfile (note: building QEMU does 
_not_ need cargo).  In fact we could in fact do it via libvirt-ci, and 
it's quite possible that MacOS or some BSDs will need it.

Personally I'd be okay with allowing Debian 12 but not Ubuntu 22.04, for 
various reasons:

- Ubuntu 22.04 has a new rustc and an old bindgen---so it's really just 
laziness.

- any workarounds for Debian 12 would last shorter, and anyway

- Debian 12 has the really important feature (--allowlist-file), whereas 
the lack of --generate-cstr is only annoying.

> Can it be done automagically in the same way we "do the right thing"
> with the 3rd party crates we depend on, or is bindgen special in
> some way that makes it more inconvenient for users ?

bindgen is special in that it has a metric ton of indirect dependencies, 
which we'd all have to write a meson.build for (by hand). :/

> On the last point, see
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg02688.html
> 
> with that series, it should be just a matter of adding '--enable-rust'
> in a few key jobs.

Indeed, thanks.

Paolo


