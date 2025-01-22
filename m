Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE30C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacI5-0001yc-MI; Wed, 22 Jan 2025 10:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tacHx-0001rS-IN
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tacHv-0001ZF-Qo
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737558302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hBSer5RHte3DiPfBuHNWLnhAhecs5oss4gYGurWr2Rc=;
 b=PdHu0JdhBVbf8wEHoChR3MwLcaFUZeX4N1GXhSlI3/C5C8pmTgLHeGf4uIO1AfBVjSsXYR
 MAUIoGV43P76Il3sG5kNcUfdE0Ilq0juW6JGsZ0AciO0+LCJhdPQyIwKXosn+IjxFc0RRu
 lNfb//gTB7nqT56XeUEDLxW22yjk8p4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-U7eDthrONpmZP0Epp8I6tw-1; Wed, 22 Jan 2025 10:05:00 -0500
X-MC-Unique: U7eDthrONpmZP0Epp8I6tw-1
X-Mimecast-MFC-AGG-ID: U7eDthrONpmZP0Epp8I6tw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab2e529dc35so688389366b.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 07:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737558299; x=1738163099;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBSer5RHte3DiPfBuHNWLnhAhecs5oss4gYGurWr2Rc=;
 b=oMlNuH7snCMNtyobrfKlUKNF3LEAKpMGntYNfZ8t7EcJFxQdGl2Ov+tFx+7MwTBAvl
 7+eG7XxyserBxfFxSrghRuEDMY5ivAjd3x/C+3/Hld4au70+7VBN8GgK/E4ComFQQRZw
 hJWX88ZsS8FRExIMtJ66NqHW7thGBze1laYy48qlUDrl+qv85zdZVT7T75BhKp2gzod3
 mPZaSaQD8UCNYQPSsrVFxoqZNlAbd8dDKSp7RPszzxSkJbcttQ+D9qmJhs6HWbadWwUf
 4LyHfRHfHDPt7CKosLOfQ/HAL+C5hPskdsPIQca/2lW7KLs60NWtFb1S0bJNXHTBNgH0
 CNvg==
X-Gm-Message-State: AOJu0YxPooG7J9DyFPD1BX6xh9XyEvbPvduNwdOJUWDFvYvigx+42rjJ
 fNz/GMm/q+axagDdad+VR8hS6sKCHU1CeYtCcIHbc7QVTe+KB+dW1kbqAUJpPjyKcJGST7u4IZm
 kc0PPZZFX+E+sJUtwtn4e/+oDnY268817uo8MAPBWEkbMSrEttk6N
X-Gm-Gg: ASbGncuemX32MjcQLR5fAdy5CjBG6M+DyWWZ9zkMpbkyGEZbCzd646kTQXlAZbaL2Yd
 ft8Ae5lKvpZvHrws9IzQ/fE9aETlDkwnLKwsMCDcZQmJ+W4h5O+zSmoaPqkfbefnNC0bReKCycW
 fZdsWbu/XZsN5+ME3tfuePneKeFpoK65Hfw7rGqQLdOs0RooGJkqxRiEaMQ3nzeosNbdXwDV8Ay
 37BsX7o+ESNXbjpgEE3SK7qmuPEAXCgx4A/Z062VWkqREHDTgJamwjb/R5ENTyrHvNaGv4T0n4=
X-Received: by 2002:a17:907:930b:b0:aa6:a9fe:46e5 with SMTP id
 a640c23a62f3a-ab38b3dae38mr2251359766b.53.1737558299615; 
 Wed, 22 Jan 2025 07:04:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFfMJeYJxCZardkse5PMD2GWir/3u16u3koAtpOEvxHnjU7PSyLVQ/mrUWEw52kIdaHVuuRA==
X-Received: by 2002:a17:907:930b:b0:aa6:a9fe:46e5 with SMTP id
 a640c23a62f3a-ab38b3dae38mr2251351866b.53.1737558298951; 
 Wed, 22 Jan 2025 07:04:58 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab384d2d3dcsm912532166b.81.2025.01.22.07.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 07:04:57 -0800 (PST)
Message-ID: <5ace2ad3-3633-4c79-81c1-aac9d10a16ca@redhat.com>
Date: Wed, 22 Jan 2025 16:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] rust: pl011: extract CharBackend receive logic into
 a separate function
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-5-pbonzini@redhat.com> <Z5EHu/7nEbS51IlH@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z5EHu/7nEbS51IlH@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/22/25 15:59, Zhao Liu wrote:
>>           if size > 0 {
>>               debug_assert!(!buf.is_null());
>> -            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
> 
> An extra question...here I'm not sure, do we really need read_volatile?

No, the buffer is not guest visible.  It will certainly go away together 
with chardev bindings.

Paolo


