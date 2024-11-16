Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D9CD68BF7
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 20:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCPLd-0000G2-3j; Sat, 16 Nov 2024 15:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tCPLb-0000Fc-3w
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 15:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tCPLZ-0006vR-09
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 15:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731788682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vobj0J68tgiXeoIbnC4J5t+3FC7RRd0R9SA6PR/izsA=;
 b=RKG58bOyiBHaJJdMk7PB+1I3C49iLqr1gPfo0GvQdowakE0nHKU9C1XmOn6qhYuvP7C/vQ
 wP6h1qdGVeiAdvvvnAt0+0aeJ0n1eXE2V7vF4UbcfUfMQIWDzaJRcpYH87RFTX1SlFiGqp
 xDuVkOUueJndeKeFtUqOTPkVpIOsWEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Q7VwlRUTMry8cytRka1jIw-1; Sat, 16 Nov 2024 15:24:39 -0500
X-MC-Unique: Q7VwlRUTMry8cytRka1jIw-1
X-Mimecast-MFC-AGG-ID: Q7VwlRUTMry8cytRka1jIw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so21002205e9.2
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 12:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731788678; x=1732393478;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vobj0J68tgiXeoIbnC4J5t+3FC7RRd0R9SA6PR/izsA=;
 b=qSE6AFWxtfqYkhDXQcX9HH9Ktqx04aK+Y4tTxrbFfa53UzHwXFkLyg2lposNhFxYDI
 QAF3OBHHlo0+UX8Z9jXzHVse02c2CMvnxqIsV+63nix1c26Y4QcepdFuno0a+hvZt466
 f1C7kYtcs9bYc+0X9zrpfhJPY7WxK4yDGRgcV58VMGGIMzM4VXPaYc94HeA+dB4KDYew
 bm6rOMl2+RUqH39kQSJ2hGgNUu3JuqlxjyahCmciX8SvJHMKlKzphayHrjdBxLpCmOgy
 QZj/Q0lFGATuMygUGNo1u/nAzHiYisPkffibhSDMsDPrvYb7K/2vSZsnIVBVwAOeNjWi
 EAkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4YoGoSvtnxrvmbgWgf7lSbzvEyhIuQAjl9Ixyv85hqJoNHFwUuoovHE9mJ8A9Xx8s4YB+COJTK8dL@nongnu.org
X-Gm-Message-State: AOJu0YzmngGekn4FjdbEJw66GYkIsPw4kGalayOsELetyd6iecRopx+n
 MgaXMnQjXGaGD4ko008z09N3idBPqnynOqdcGo3Dr5ak8wHsWsex85zr2Twvqpvi0M+roNzrYO9
 Y2L8v8+FbovGzcrUAjvsBI4dtIhB409PJFyQIsRc/rILNPswm1VXm
X-Received: by 2002:a05:600c:4e8b:b0:431:4f29:4a98 with SMTP id
 5b1f17b1804b1-432df77c605mr57609765e9.20.1731788678338; 
 Sat, 16 Nov 2024 12:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMXGoncVt1+QW8R3jNYenhauSQXLpJVfuCixj/M0T9NCsDHs4NUmV8J7Nip5tCX9eDcnPs8w==
X-Received: by 2002:a05:600c:4e8b:b0:431:4f29:4a98 with SMTP id
 5b1f17b1804b1-432df77c605mr57609605e9.20.1731788677992; 
 Sat, 16 Nov 2024 12:24:37 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432da265ca8sm101716385e9.14.2024.11.16.12.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Nov 2024 12:24:37 -0800 (PST)
Message-ID: <7d835e14-c3d4-4aba-b4a9-eeb06f56fdde@redhat.com>
Date: Sat, 16 Nov 2024 21:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rust/pl011: Fix DeviceID reads
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241116181549.3430225-1-manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241116181549.3430225-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.121,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.696,
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

On 11/16/24 19:15, Manos Pitsidianakis wrote:
>   impl DeviceId {
> -    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
> -    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
> +    /// Value of `UARTPeriphID0` register, which contains the `PartNumber0` value.
> +    const fn uart_periph_id0(self) -> u64 {
> +        0x11
> +    }
> +
> +    /// Value of `UARTPeriphID1` register, which contains the `Designer0` and `PartNumber1` values.
> +    const fn uart_periph_id1(self) -> u64 {
> +        (match self {
> +            Self::Arm => 0x10,
> +            Self::Luminary => 0x00,
> +        }) as u64
> +    }
> 
> +
> +    /// Value of `UARTPeriphID2` register, which contains the `Revision` and `Designer1` values.
> +    const fn uart_periph_id2(self) -> u64 {
> +        (match self {
> +            Self::Arm => 0x14,
> +            Self::Luminary => 0x18,
> +        }) as u64
> +    }
> +
> +    /// Value of `UARTPeriphID3` register, which contains the `Configuration` value.
> +    const fn uart_periph_id3(self) -> u64 {
> +        (match self {
> +            Self::Arm => 0x0,
> +            Self::Luminary => 0x1,
> +        }) as u64
> +    }

If I understand correctly, these are two reasons why you did not go with 
the simple adjustment to the Err(v) pattern:

* the separate registers match the datasheet more

* given the bug that you are fixing in the write function, you want to 
avoid duplicating "Err(v) if (0xfe0..=0xffc).contains(&v)" between read 
and write; instead, you rely on exhaustive enums for error checking.

I wonder if we can keep these improvements while making the 
implementation a bit more concise...  The eight const getter functions 
are quite verbose, and having the device type match inside each function 
is repetitive and hard to verify.  Maybe something like

     const UART_PCELL_ID: [u8; 4] = [0x0d, 0xf0, 0x05, 0xb1];
     const ARM_UART_PERIPH_ID: [u8; 4] = [0x11, 0x10, 0x14, 0x00];
     const LUMINARY_UART_PERIPH_ID: [u8; 4] = [0x11, 0x00, 0x18, 0x01];

     /// Value of `UARTPeriphID0` through `UARTPeriphID3` registers
     const fn uart_periph_id(&self, idx: usize) -> u8 {
         match self {
             Self::Arm => ARM_UART_PERIPH_ID,
             Self::Luminary => LUMINARY_UART_PERIPH_ID,
         }[idx]
     }

     /// Value of `UARTPCellID0` through `UARTPCellID3` registers
     const fn uart_pcell_id(idx: usize) -> u8 {
         Self::UART_PCELL_ID[idx]
     }

could be the best of both worlds?

>           match RegisterOffset::try_from(offset) {
> +            Ok(PeriphID0) | Ok(PeriphID1) | Ok(PeriphID2) | Ok(PeriphID3) | Ok(PCellID0)
> +            | Ok(PCellID1) | Ok(PCellID2) | Ok(PCellID3) => {
> +                // Ignore writes to read-only registers.
> +            }

This is indeed an improvement over the patches that Junjie and I had 
sent, because the writes would have gone down the eprintln! path.

Thanks,

Paolo

>               Err(_bad_offset) => {
>                   eprintln!("write bad offset {offset} value {value}");
>               }
> diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
> index cd0a49acb9..1f305aa13f 100644
> --- a/rust/hw/char/pl011/src/lib.rs
> +++ b/rust/hw/char/pl011/src/lib.rs
> @@ -111,6 +111,22 @@ pub enum RegisterOffset {
>       /// DMA control Register
>       #[doc(alias = "UARTDMACR")]
>       DMACR = 0x048,
> +    #[doc(alias = "UARTPeriphID0")]
> +    PeriphID0 = 0xFE0,
> +    #[doc(alias = "UARTPeriphID1")]
> +    PeriphID1 = 0xFE4,
> +    #[doc(alias = "UARTPeriphID2")]
> +    PeriphID2 = 0xFE8,
> +    #[doc(alias = "UARTPeriphID3")]
> +    PeriphID3 = 0xFEC,
> +    #[doc(alias = "UARTPCellID0")]
> +    PCellID0 = 0xFF0,
> +    #[doc(alias = "UARTPCellID1")]
> +    PCellID1 = 0xFF4,
> +    #[doc(alias = "UARTPCellID2")]
> +    PCellID2 = 0xFF8,
> +    #[doc(alias = "UARTPCellID3")]
> +    PCellID3 = 0xFFC,
>       ///// Reserved, offsets `0x04C` to `0x07C`.
>       //Reserved = 0x04C,
>   }
> @@ -137,7 +153,11 @@ const fn _assert_exhaustive(val: RegisterOffset) {
>                   }
>               }
>           }
> -        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR }
> +        case! {
> +            DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR,
> +            PeriphID0, PeriphID1, PeriphID2, PeriphID3,
> +            PCellID0, PCellID1, PCellID2, PCellID3,
> +        }
>       }
>   }
>   
> 
> base-commit: 43f2def68476697deb0d119cbae51b20019c6c86


