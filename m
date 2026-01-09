Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82D2D26D69
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veEIw-0005vq-Mb; Fri, 09 Jan 2026 10:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veEIu-0005vC-RA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1veEIt-0007eA-Ev
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767972090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WeXADwCKomx6ThMO/P01x+k8ewdNDqGQKQbTKENu2gg=;
 b=Zt/G3RzzAJtsr8YPylx66MmlIQtOJdGfvngeqeO9IijfQMy28rKnReBYWA8hAX/m6HlUh1
 suYwjZhXfD3mQOSBRSHgiwlnjpEXmdArgNACcA+i3qz2U0IlgGMYETPjlooJxMgGndIaBc
 eev9EcO1aRXt95ajZ8+S68QDh+FVcK0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-EIjCqLGsMsmYe0efPtKhiA-1; Fri, 09 Jan 2026 10:21:28 -0500
X-MC-Unique: EIjCqLGsMsmYe0efPtKhiA-1
X-Mimecast-MFC-AGG-ID: EIjCqLGsMsmYe0efPtKhiA_1767972087
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso31641405e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767972087; x=1768576887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WeXADwCKomx6ThMO/P01x+k8ewdNDqGQKQbTKENu2gg=;
 b=CvPuQH8oDm6SlxV9MO/YaF6mcF+eKoMqswcIjYjRTvPFccH/izsg6XMrwywvUlTuPf
 2lJzj/IdOb8Q9k1EPTKWfO8Lded4oWaByUuj5Ier4YdOxW8fOSZwTVWOHwWW7J/Rqx0g
 8OG1kT11PNgIxr3IqOTkvKbrlgeLy9G3hxXZsD+ArVX8TAAG94LumpJX043tt8wkVHiP
 ziHUHwwlpoI4TONqyceDokdKpFWbmCf+RqdepC4RTlGo4KeBFFTLYzAightooYtWk+U6
 LhB3KTSTAla+vG7YjApjzlpuEDRbXWlBPer8bxbGMIAdjTGjMAGI8F3B25Ouv+jQdxqG
 Uhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767972087; x=1768576887;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeXADwCKomx6ThMO/P01x+k8ewdNDqGQKQbTKENu2gg=;
 b=P/W9ltfuZsiSU4Oz77wQlc9dLmp/3jNR94PgLfv9Oj+/OjBxu9mHjrc7lhbuneFm9H
 slHVn/lb6rAVuP0gx6A4yiLV+s0oB4c/kYGOlHEoYtRdT+fddv5NTiKZ5/IV8joC29zZ
 5Kk06k319apg2NtnqR9mFhMkEjdhJ84MMx2KbMEKEuj7fXJnWxNVKDU2aE0JPJDP9Eo5
 LXEGYGblJbii0BsIgqGgTN4q6KeiPGulYMPhlkymXroIkikT/J570or/G/wfkeD6VSQK
 j61JOcpFW2UdqJuE2Vch5ItCcUbLyFdOfgM+vH52bkQ4sRT4wYylGUoQxgSQucmaWhO3
 njZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjgE0evGTgstUXoK2PFgG4WEWlzJXDdaLoCpYJfdUWPtwtdITEEbhb/54xXOl2y2Pbdnpo656cwN8V@nongnu.org
X-Gm-Message-State: AOJu0YwldsSdsN1iSExnMwQmUpXyU9jqe2TPLsjxaKwgMwgFSlUdUApR
 PQi0qLBVEo8u7RksWrqPtvnpegf56bonZcT4fJLiYilo+oTZbJb4uLOEsN9perREsSiAxHGQ6yw
 3GlET6lMwRCIzFb8Je+HJZ+QA3dXZOkIchvzgIh7iKAxUrIHsvTnjlaE5AkboRWtc
X-Gm-Gg: AY/fxX7YZyryOSIsmy+Yh/PjU6hFvMPPQcQ50mApwMhNlM5s3Tbg5TbvAKSygC+b6kX
 zjl59rW9H8nbLaI/94GHIYwF3CfzFQzwTnW9rPMWSk9llXwoo6U7HJj7J8/GUZJSjV1oaLz2RDR
 9+lG+fz8AZi4ALGJ2FCEDXq2Cy/b3Sx0iaV3cUu5Jd5srkbcDO+1H64zDyMRmoEgw6KS6eVNier
 VUhyMmBa516VAD3kSJ1ckNZ6GHPu8oDKJk3CpRlN3DzN/lwJ7MfA0hPwtNn8IFj0lCyNseQ29z9
 1lFTDyZGNp1vsr0oRdl/+7HmgQ2Mtti5hSkPoLL5jn+HDGbbNOqemB4Cog+uYmFrJRuGcZLKExt
 q0xdocN1Hss5EqE/vUikNMzZV9iOWEy6WXm9+Ijn3+hqgYKLT
X-Received: by 2002:a05:600c:1991:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d84b4119amr110449925e9.32.1767972086630; 
 Fri, 09 Jan 2026 07:21:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo1DY1Ayr7ErV7H6vhpNJQeztupotoRN/ABLu1fH6CFgdO0HsCpkf4J0lOvlhKiq4uYGzq9g==
X-Received: by 2002:a05:600c:1991:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d84b4119amr110449705e9.32.1767972086269; 
 Fri, 09 Jan 2026 07:21:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8719e695sm63549365e9.17.2026.01.09.07.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 07:21:25 -0800 (PST)
Message-ID: <3d0684e6-4a74-412a-b146-ff8241ac46b9@redhat.com>
Date: Fri, 9 Jan 2026 16:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/vfio/migration: Check base architecture at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Anton Johansson <anjo@rev.ng>,
 Alex Williamson <alex.williamson@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251021161707.8324-1-philmd@linaro.org>
 <c5381a4d-74b2-4352-b3f3-c0d39a438dd6@redhat.com>
 <8afeac41-72ed-4654-827a-771b3119a2e2@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8afeac41-72ed-4654-827a-771b3119a2e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/9/26 16:08, Philippe Mathieu-Daudé wrote:
> On 21/10/25 18:31, Cédric Le Goater wrote:
>> On 10/21/25 18:17, Philippe Mathieu-Daudé wrote:
>>> Inline vfio_arch_wants_loading_config_after_iter() and
>>> replace the compile time check of the TARGET_ARM definition
>>> by a runtime call to target_base_arm().
>>
>> What's the value of a runtime check of target ARM ? Please explain.
> 
> target_base_arm() returns %true when the ARM and AArch64 targets
> are used.
> 
> Runtime check allow compiling this file once for all targets,
> allowing to eventually have a single binary targetting them once.

Do you want to update the commit log ?

> Still I expect this function to be problematic on heterogenous
> emulation, but we are not quite there yet.

ok. So we can still take the patch I guess.

Thanks,


C.


