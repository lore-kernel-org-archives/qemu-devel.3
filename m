Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA7EEC1101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 16:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuYXe-00020M-HG; Mon, 23 Feb 2026 11:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuYXb-0001z8-AK
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:12:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuYXY-0005Xm-Vh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771863127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ze/An/SOFIjsOjs+x6ZwwPrH9WzszpFw6b9TfdTWBjw=;
 b=fkQ0oZ5yyyhz746FhOfogCFcM384L3U3U7QEQ7r0iYAz2EGAOXtBZ+NMbj43P/VrvfXpKg
 GXZv5ulekSxa0jAxeQRfxDxjjqNzNeurKfVhfZhi+97bRiJ95W1nN0xQmNvVpDc4Aek2hw
 lIFvkUKrJWrBHSr6BBaX+z7GcgZ3aDk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-U-bQpoqIPFSmUZARbzplqQ-1; Mon, 23 Feb 2026 11:12:04 -0500
X-MC-Unique: U-bQpoqIPFSmUZARbzplqQ-1
X-Mimecast-MFC-AGG-ID: U-bQpoqIPFSmUZARbzplqQ_1771863123
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8861544696so661669566b.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 08:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771863123; x=1772467923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ze/An/SOFIjsOjs+x6ZwwPrH9WzszpFw6b9TfdTWBjw=;
 b=OZc2iZzm8Pw1Crlm+SW6MHjFKt08I9dFEdjW81C0F0Tw30jCUencRunI8ZhRXvnevZ
 BMmMp5CPy2W/pQCqOmqm6EcMIFbBmEDqFnG9Eyl/sNPNXULP3IKF84nmLt9wen/2yoXb
 LRQ78rUIzuTOJrbk0yxBEUT0KtvjDGPYUrtRzejCL4sWdQk04EEEs1+iiXsAX3PXUXJJ
 q7gRZg/hy8QU9o4iIUnDekUSAz8tw/ZzrK8nfX+pmKeLEWWujsxDBoOGdp6/+ctlmNI7
 BZhOS40Bf0wJFJ7oZWB4V115z0yHi3KnXf+/R+YXau9qbGFs/ChyWAQEEUVMMkd75oQ4
 Zq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771863123; x=1772467923;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ze/An/SOFIjsOjs+x6ZwwPrH9WzszpFw6b9TfdTWBjw=;
 b=Ya7nQUWfGZkqdECwSDwcVpQghNMrX9xpa3fiUyyOwSrZe/ea5XckF/jsj1SUymryw1
 dez/WQr7ZZtfimazFDsm+/yzxn5yfcsW77KPVggz70I12/QKfK8j77OyQ9813lKKKwsd
 lRlsS6JD5bjTJ53EKIesHFeeZ/8xPIc0NRBtVfCrgH2DlX3GTNmUuuL2rn64CVVWAoA4
 RGHOELDI6J9w+6m7v+clBy7BChDZKBYhzX/XgUIfPyM7E//HWP+SD3xVoejawtHoTmk3
 lhvZWpcOtOXLaWIrQ4o0kcD1jovFKZfmzMDlZZ/VrpDaFRKH1pfMXchI3hj4+Nu/sVbc
 Pwjg==
X-Gm-Message-State: AOJu0YwWFV+Zp5urrFBt0DlBsPyI/PP83ZrWFCr+n2tuy+vOljpNf4Qn
 mA7YRHyXbhKOuBn2yTeyDvChlSe4Z+gZfY5FOCuMzZOLQX3aYmthz6ifTvA9a82f+FHUD2y3k/Q
 whNRl2W7B+8WpIjuny4pKf5wSBv1cZGlFh8sEmo6O99qBTAR5ooR+qiOv
X-Gm-Gg: AZuq6aJUFUc7MLyb7c3u2MCXIR667aMRVGSK/pRH75E19KIeW7PkJuqaYOo7e+TPpXR
 JGElTAFEtDGLGnXe1cuTxUh81lrCYNyIMpknDrWcvaFVCvZYjvE9w22o3wnsRd36DVOOgtKs5W3
 MYJUQl7IU8I8ReCuNbV1kx/1FjfQZBvR8pzGUDZXHF2TaVNkbAthq0rk/6mGpv/BaSwijbR+paD
 fYCpLbXA9uF+mf3k81QkfYGB6KgBuRbRmyWUl0dzrK29UlvLo7BUDsx8AOZGAoHGUs+JIHiaRfz
 VkzHI4EZTsZ2QMIltI2dKuAr9gmfGPKBPtnCBJKmHFLtTx+P3v78Ga40CEXhDPOqOsPrDm4BV2q
 L5wuAjRhOQLHknCrJg3WZVKN7jqddygmzRo2meLnF5KcICcHfWomA1Svet1X2iD+l+ldquUdIYD
 8aBNn/+uFTTEVQp9i0YEfx8onkRi4=
X-Received: by 2002:a17:906:fe4d:b0:b43:b7ec:b8a1 with SMTP id
 a640c23a62f3a-b9081a4b105mr542935666b.24.1771863122842; 
 Mon, 23 Feb 2026 08:12:02 -0800 (PST)
X-Received: by 2002:a17:906:fe4d:b0:b43:b7ec:b8a1 with SMTP id
 a640c23a62f3a-b9081a4b105mr542933566b.24.1771863122350; 
 Mon, 23 Feb 2026 08:12:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9084eb912dsm345905066b.55.2026.02.23.08.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 08:12:01 -0800 (PST)
Message-ID: <80366391-ad17-4ed8-82d4-79a6168e374e@redhat.com>
Date: Mon, 23 Feb 2026 17:11:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com> <87ms0z7i33.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87ms0z7i33.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

On 2/23/26 13:36, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Generate high-level native Rust declarations for the QAPI types.
>>
>> - char* is mapped to String, scalars to there corresponding Rust types
>>
>> - enums use #[repr(u32)] and can be transmuted to their C counterparts
>>
>> - has_foo/foo members are mapped to Option<T>
>>
>> - lists are represented as Vec<T>
>>
>> - structures map fields 1:1 to Rust
>>
>> - alternate are represented as Rust enum, each variant being a 1-element
>>    tuple
>>
>> - unions are represented in a similar way as in C: a struct S with a "u"
>>    member (since S may have extra 'base' fields). The discriminant
>>    isn't a member of S, since Rust enum already include it, but it can be
>>    recovered with "mystruct.u.into()"
>>
>> Anything that includes a recursive struct puts it in a Box.  Lists are
>> not considered recursive, because Vec breaks the recursion (it's possible
>> to construct an object containing an empty Vec of its own type).
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lureau@redhat.com
>> [Paolo: rewrite conversion of schema types to Rust types]
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Please mention how to actually generate Rust, because it's anything but
> obvious: pass -B qapi.backend.QAPIRsBackend to qapi-gen.py.  Recommend
> to mention it again in the cover letter.
> 
> Additionally, state that this is a hack we'll want to replace both in
> the commit message and a TODO comment.  See review of v1's cover letter
> for why.

Yes, the TODO comment is in patch 14 where the thing actually gets used. 
  I can make it more prominent.

Paolo


