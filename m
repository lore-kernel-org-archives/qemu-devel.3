Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C82BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3v2V-0002oe-D9; Wed, 01 Oct 2025 07:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3v2S-0002no-4O
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3v2I-00011y-6v
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759318208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iKdrNn9L/0ppkJHfiCXKADiN6IhMtjuqTguCHsATBis=;
 b=hpWUoAIyUkd2YhWuS17QV9uQYka3KChTOWCg31mU1k3pq4buCpBK+mU7nTFRYjRK1X2o9Z
 0HYZgd7/z4hmhc/eQ9GVg+mF0BIofxqbmLGan5xRIJDZxVC3ouE0iKds7SA7wuf5sMKOEU
 d2UzY01duYw1GbxvzEAVmhIfa+THC00=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-Y7-2UZr_Pvio1c07zCOxyA-1; Wed, 01 Oct 2025 07:30:07 -0400
X-MC-Unique: Y7-2UZr_Pvio1c07zCOxyA-1
X-Mimecast-MFC-AGG-ID: Y7-2UZr_Pvio1c07zCOxyA_1759318206
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b2ef8e0133fso536917766b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 04:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759318206; x=1759923006;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iKdrNn9L/0ppkJHfiCXKADiN6IhMtjuqTguCHsATBis=;
 b=KCTcWZxBSnhqiKYZIagn49gKK0cIRQYfPgZxiZg6swB0hcsgt5lx0RaOUhOXBYhWeu
 Ptg2qO/sWU5helObM+PtcWcNr6zhldBFDlpyPuAwGf/UfIiFGQ9UqZgU2SnyX8z83mMr
 jWewnUmgs6rC/tTy/khtq2xaNdHnpv8VHtZhEvwW6WumAO26NkGEAkXekaJHdlWbHuCR
 gUasdk+RWJeGTgFvouQzNDxvZgMo/P+i6QI004f7s7gkI5u+3Y5yk/mhpe1S1PcI0Uj1
 1TH43dpIxpLTN1rTtm+r7zC+XUrpIXa3w1Zt5tDKiuxe4NderFQQRVoCuE2Hwi7hNbC6
 Z2kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL/jpkhl+XblEii7SXnFpiyoGTOfgnOOCNOHxG998sHynDEc53rneSOibt4Xp2xoVre89QqjJAz1cv@nongnu.org
X-Gm-Message-State: AOJu0Yw/Os0RbPcr5fDRPbQ4ZdGdF3hkEShsTBabGmqYFPolMuO0vhWi
 6z2kM8x4Zh2VehLy29EWNWGa+IH8GTiODceu4HHqP+966TwBPtU4gpvl1jNQRlNBW27TsYNnTVj
 dHfLdCrG2z6tKPMZzp/w4hUkhJdF1y6EETh4sekFQpPY1NBx8kwaJdP++
X-Gm-Gg: ASbGnct70dSKV6Lu+JdLyVLkfl1xh5VIloQDapINxqu6K22Q6Ock/vkM+d/w7brHNem
 k9G1qDGIXHTBaZTlcJSB9oi7FlTVIFN6DC70InSgOntPrOIUCIKDg2m/SLqZrjKlZCX9WR49Ccr
 8OUss5CxcN62SzZDVm2oKZ1/gwWGJX3T7mt+4XN2NKW4ctKxG+c3j4f/NEV8aGvggm1MzVitp5V
 TPFH1C4yLiWQbe70zspE6Ym6zfWVMDwg98E97mHkX5CRQ2JHqQzAIXxs9p2zJOcipIELMyP6NCE
 JqjFoZeepBVNUj0VWxbiRxjXqK5oZKb1RFI+kXlqpoPyWNn/xAauO2q7tELrJhMjmr+mwlNPJnp
 Y0sJnHBED6ddISPB6x2PAcxJO8Ru1WWm3um410554g/gdm+qMtPg=
X-Received: by 2002:a17:907:608b:b0:b45:1063:fb52 with SMTP id
 a640c23a62f3a-b46e479ffb8mr428813166b.39.1759318206052; 
 Wed, 01 Oct 2025 04:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwB11Xyj1pN5XKXTT5NJmdHjtMY45/bAeN4hnsRvVwD2XkJliRLYzfjGIzI73Cjz/wVDpxkA==
X-Received: by 2002:a17:907:608b:b0:b45:1063:fb52 with SMTP id
 a640c23a62f3a-b46e479ffb8mr428808966b.39.1759318205663; 
 Wed, 01 Oct 2025 04:30:05 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b3b2d7db72asm880401166b.67.2025.10.01.04.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 04:30:05 -0700 (PDT)
Message-ID: <cbb6c926-b5a6-49c2-8b35-0988e1fcc7ce@redhat.com>
Date: Wed, 1 Oct 2025 13:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/27] WIP: enable rust for wasm/emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-28-marcandre.lureau@redhat.com>
 <CAEDrbUbOWp24F_wO88Tb9ZCM8Q+jXEK_1BzwGMwC3MG=3TzgAA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAEDrbUbOWp24F_wO88Tb9ZCM8Q+jXEK_1BzwGMwC3MG=3TzgAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
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

On 9/29/25 10:52, Kohei Tokunaga wrote:
> Hi Marc-André,
> 
> Thank you for working on this patch.
> 
>  > wasm-ld: error: unable to find library -llibqemuutil.a
> 
> This issue looks similar to the one in "[PATCH v2 24/27] WIP: cirrus/macos:
> enable Rust" so I tried the upcoming meson change[1] mentioned in that
> patch for the wasm build. By also applying a patch for disabling the
> "verbatim" modifier for the Emscripten build[2], I was able to avoid the
> error.

Hi Kohei,

can you please open a PR for this patch?

Thanks,

Paolo


