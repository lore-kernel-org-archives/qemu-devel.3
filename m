Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE262CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 12:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1lFo-0000ZE-8J; Thu, 25 Sep 2025 08:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1lFk-0000XR-Hu
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1lFb-00022r-5t
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758803931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P10hSSwGdrqBZlOCqazyUw324TBYd6VRWzKHMam0uK4=;
 b=FnreCtHYPO5ZeRGPOEi10uoRUf1ue8TIHI5iq7KhSl+71ThzWPq1qQPZDBslEZ/r0W5ahT
 dgWnnYBoRh3Of6PhSgAtcLkkSUA5qeTSvallOiV6ay6TYiZmJ651EWPoiPG1qiRlIBdXcm
 4zgNWGYT/0FOhEe3F20mgQXcqm0vSWU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-B7tU5lOwMj6CKCjtNrU7_A-1; Thu, 25 Sep 2025 08:38:47 -0400
X-MC-Unique: B7tU5lOwMj6CKCjtNrU7_A-1
X-Mimecast-MFC-AGG-ID: B7tU5lOwMj6CKCjtNrU7_A_1758803926
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b04a8ae1409so99628266b.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 05:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758803926; x=1759408726;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P10hSSwGdrqBZlOCqazyUw324TBYd6VRWzKHMam0uK4=;
 b=P8m5twozhraeVmcxh8nqpQXCCq1e25M5iRsxnBYRg1Rc4IBYci5L7UkmNqeJuFXJYd
 fNErowoU8CsgYp00JDwD0EfaJUxOhPuHaBBBJdMhOBL1hHMdEO9fAwQ4Ws3pb0X3roz1
 C1bDih0x9RNDEQpxbjktk6Kx8/odi0uqqYJ1Eqo78jo+gsEdOkx3lBM9yE2nxWcC4NGf
 AZrHGfhNhkhuupvrpBU7zrF18DQym8FFw7LqrYHOWepYUJBlPdxnloZLaDZ56EYxrA/K
 lOcGU6K5XgXlGLmOKYTqlD1LexbsiaMe63T5iPQQ3DbW2gzrzEtQQkvipp90UQRb58e4
 z3VQ==
X-Gm-Message-State: AOJu0YxE0CnmLtK0Bq4VWqiUtsWSYRKD/VnamB22qbUAUvpA2aS+e5Dy
 x/kSFv6lxO5tOaeR3/Y6KCjcqzv18z7UeAp++r3U6Gtk2QzBE5qpZ5ykbA6++6EalQxivYAQeYs
 iQH5Tzp9Vq+VxCHbNqRFSyBC5my2/v/nsdNgPkSDA8DtpkE8HRSVuhUEY
X-Gm-Gg: ASbGncsmwaV/FDdhrPag/TEEeg46Wb2kF0wXAF4KHL94rDKwNf5G6lbdM+f7Paui9Tn
 oPPXspLNef4xnV12BZWuBwDO7aZDyplqAqb/qwHap6yXnWIXygKYLt8rSJxDv7aC6DsH2HWZOO4
 61rXZe+MDC8c+x5shV0e8Z35QrxYPPsAzFJk2l3SmrQ+vUQKKDj/WVW18j6Tq5IUOLpUuHr0XxQ
 YvrVsL6Tp9cFZlMtBciSONmA47kOXFoixy42oBEi/O3SJ4K0cyFhGW2Eb1KCKHPPjiOaVJV0m90
 VBvO78F+MzQzf602/sLnwQgJw9q0I7B2ILIm7RKfEV1OBJPof5e+inNHNQBTwGPmhQjp6H0Vq7g
 /6ZqrBCvJsD6y0Xfjw2cfGwu0XICTkF/BSOaWNh+AAdx8Aw==
X-Received: by 2002:a17:907:86aa:b0:b04:967:307c with SMTP id
 a640c23a62f3a-b34bde1308dmr361088666b.34.1758803926126; 
 Thu, 25 Sep 2025 05:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj9DrWzXCYG+5hbFShj5Lnt5Yosv0GmPKHezN9EMkxyJwlHxttKrf4Bg+LS64Xv+YyC65+4w==
X-Received: by 2002:a17:907:86aa:b0:b04:967:307c with SMTP id
 a640c23a62f3a-b34bde1308dmr361085866b.34.1758803925694; 
 Thu, 25 Sep 2025 05:38:45 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b353e5d1343sm161578866b.16.2025.09.25.05.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 05:38:44 -0700 (PDT)
Message-ID: <4d7d946f-db87-43b6-a5f4-4f6cc583df20@redhat.com>
Date: Thu, 25 Sep 2025 14:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Tanish Desai
 <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
 <20250924181024.GB6015@fedora>
 <CABgObfbDphuWOx9r8JEpQCtvGtZM2XYkEd+mBxO4LeqoVPvW6A@mail.gmail.com>
 <20250925115047.GA22729@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250925115047.GA22729@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/25/25 13:50, Stefan Hajnoczi wrote:
> On Wed, Sep 24, 2025 at 09:58:04PM +0200, Paolo Bonzini wrote:
>> On Wed, Sep 24, 2025, 20:10 Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>>>> fn trace_event_state_is_enabled(dstate: u16) -> bool {
>>>>       unsafe { trace_events_enabled_count } != 0 && dstate != 0
>>>> }
>>>
>>> The generated code is missing DTrace's SDT semaphore (see
>>> generate_h_backend_dstate() in scripts/tracetool/backend/dtrace.py). The
>>> conditional must be taken when a tool like SystemTap or GDB sets the SDT
>>> semaphore. Right now it will not be taken because the conditional only
>>> looks at _ ## id ## _DSTATE and not the SDT semaphore.
>>>
>>
>> This is private code to trace-*.rs, for use within the tracepoint functions
>> only; it's not a public "is the tracepoint active" API. The public side in
>> C does look at the semaphore.
> 
> You're right, the code is fine just with the function renamed.

No problem---in fact I have now realized that, for systemtap, I have to 
ensure that the semaphore is shared between C and Rust!

Paolo


