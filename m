Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A31CA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFRXb-0006OL-Bq; Sat, 10 Oct 2026 03:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRXP-0006MJ-KV
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:30:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xFRXN-00035Q-Bw
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 03:30:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48b02a2359aso383483f8f.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791617430; x=1792222230; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aK63pA/LNxSEeNG3ry2eSOzxpvVrxY874ImE72FDeHo=;
 b=zOFHpik/C5C7tmhmsjeq+/VX9BYUKOVUMMaZqqfzImxnZZ2DCH/Fh2iD5OSYKenBH4
 oSSFzyncPxTKFSrJXpido3E1nEVKyyTNaNHEW/mocdlg8AHkYXGSMCF0PVoGho77FPhn
 3VShYNK6C1fstgV6fZsfVyOSqZi4N7DjwfPZrwAW549S1JlCv62ooldyp2H2GSTkmr81
 qOaXpCXTBsVrFNcWb6So6jetzeLj7iMifZmwDkzqv/V4ZxvVevbXbljFVVbRvvcSTrib
 zupow9//Lhv72wo2ltKdvd1UZbjpISn2C9tW+bqTA4dEroZAOTildcdgt7CU8nUSL7PD
 ytVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791617430; x=1792222230;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aK63pA/LNxSEeNG3ry2eSOzxpvVrxY874ImE72FDeHo=;
 b=ARCWA7kO9PIHC4sWHqIzhNacdfpS6GSvtH9D1KvGlysZMF6YcCjeDkwqSsWcQF6mmz
 bLzrHJNfdTma9tIWf8Ip17nzhQFW68j4VpO7vCVxJooGiNV8zIVLT9Lh+YTh4pHnUKv6
 2m5janVyYaa9BZYZ7gCn94z1UzDKaATY5JEYQRD5b07Vq3xdM82PK4G5lm5PXfzL995o
 +fFUQYYMt9UGiDHwxjgVLwyCuiAP8+LEs3r5xFJmuwvJf+IFhLUJRDvILHQgD7hLhIvJ
 KR+Eean9HjC4fsEL8iWVL5ppgiOFk/RbQw8oeZHJKmIvIoLTcFlTN+6pZQ1QuCwkEr/L
 awgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMEWaLeyWAL1bZ04jexewncaFSlwReMTlox5TS5MqpcTFXcGl4EWN5jvXLq2G8ip5L8ANqoJwcnkh1@nongnu.org
X-Gm-Message-State: AFq9FYKiF/SoThkjuYo75nlH3x/tPsSUPueSzqAyrDRGLnTOJkAkVRlS
 oioRpBHMc+cknb9kqhMraK+TNC4daNJPBJddoYyyoaPKYBD+x7h1XbWS4FWvebB5jJw=
X-Gm-Gg: AYBFou2uNf1O7oBhjM6qtO9UwKxriFgKI8tafgHAZM1p8GgvI0fkLCVaXLV7pOByYfA
 lmxOdEuTtD5iqKWl6dZVFbZDw/86vxBoNfVTFE2TXow0DaJx6iYRqy0lnU3CqJFFcG/EYOcKStI
 PxiAFREHh6YVu1hOStqIqJbBVdMVqiWki4UJl/eX2mNqTKjnmOzUK69c8gJnF6HmzRZqKjAKcf8
 FUE7hCUPexlWINtMrbuf3nEZaoDa8Fbmv0fuyxK5kiE8x7asdyr99hRc+mQSj06WhVGiukuJp64
 jOGJDt5xoB/mGVvwUxv9GbpEmJqNdzLScyJXG+YYSgJ7RAnvTrLVc92C66iFzm9/YIXchA83EO0
 SAOqFnrSsy5Rb/QFNQd3oCjm+4ZdQNXMUFdwG8lkv8sMpcRGiOF1jkTcIsaznrn6Uyn3zp2w5Rc
 bojOCxKaCYxjUOhcpb88RW9wFt5UrdbVQo2T5hs87D5ZCfn1hgyrOBiXoCpw81/0Yf9gHZkg9Ah
 FkryKLK2Gb2kBsTYyy/3Sy/pWHDnDwV9FTa5oQcWusF2hmSg839ZS0=
X-Received: by 2002:a05:6000:61c:b0:48c:58b9:f17c with SMTP id
 ffacd0b85a97d-48db947461fmr8735195f8f.12.1791617430054; 
 Sat, 10 Oct 2026 00:30:30 -0700 (PDT)
Received: from ?IPV6:2a00:1e:e082:2901:a2d3:66fa:95e6:7d81?
 ([2a00:1e:e082:2901:a2d3:66fa:95e6:7d81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db97ce3aasm7739256f8f.21.2026.10.10.00.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 00:30:29 -0700 (PDT)
Message-ID: <764a9ecd-6856-4309-9ae3-8f878a9b1d8a@linaro.org>
Date: Sat, 10 Oct 2026 09:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] target/sparc: crypto instructions for Linux kernel testing
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Biggers <ebiggers@kernel.org>
References: <63d84da88caec4176900e535116d64b1c4cffffb.camel@itx.no>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <63d84da88caec4176900e535116d64b1c4cffffb.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/30/26 20:32, Stian Halseth wrote:
> Hi all,
> 
> QEMU doesn't implement the SPARC crypto instructions, so the kernel's
> crypto tests cannot execute optimized SPARC code.
> 
> See this issue[1] raised by Eric Biggers.
> 
> I became involved in this after submitting a patch[2] for native SPARC
> XTS support. Since the kernel devs currently have no way of testing
> this, outside of real hardware, the motivation is to make this possible
> with the help of QEMU.
> 
> I've done some reading into the QEMU code, and might be able to
> contribute an implementation.
> 
> Before investing time in it, I would appreciate some feedback from the
> maintainers.
> 
> I'm thinking about adding a "crypto" CPU feature to sun4u which enables
> the missing instructions.
> 
> Why sun4u and not sun4v? Because it would allow a direct -kernel image
> boot without the OpenSPARC firmware, which QEMU doesn't ship.
> 
> This would mean adding SPARC T4(+) instructions on sun4u CPU models.
> This combo does not really exist, so I want to know if that is
> acceptable, or if you would rather have this done differently.
> 
> Since the kernel currently learns about the instructions from the sun4v
> machine description's hwcap-list, a small kernel patch would be
> required to read a hwcap-list property from the OF CPU node instead.
> OpenBIOS could set that property for a CPU that has the feature.
> 
> If this is not desirable, it can also be implemented for sun4v with
> OpenSPARC firmware. Kernel developers would need that firmware and a
> boot disk image, since niagara cannot boot with -kernel.
> 
> I have a T4-1 and a T7-1 (M7) to check the instructions against.
> 
> [1] https://github.com/sparclinux/issues/issues/77
> [2] https://lore.kernel.org/all/20260929211218.4194135-1-stian@itx.no/
> 
> Looking forward to hearing your thoughts,
When I implemented the VIS{3,4} stuff a couple of years ago, I tried to 
add a newer cpu (though I forget which model).  I couldn't get a kernel 
to boot with that and sun4u, so in the end I left the cpu out and left 
the extensions as plain cpu features.

The biggest problem with sun4v is that it's incomplete.  It has the most 
promise as an emulation platform because it is explicitly a hypervisor 
platform.  In the ideal case, QEMU would not faithfully model the 
hardware, but would instead model the hypervisor interface.  Which would 
make lots of stuff far easier and quicker to emulate -- most notably the 
TLB.

But it's a big packet of work and no one has done it.


r~

