Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2855C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVDq-0003ES-WA; Mon, 26 Feb 2024 02:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reVDo-0003Cv-I0
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:16:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reVDm-000763-9b
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:16:20 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so1842116f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708931776; x=1709536576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ldSdLgR0z/gFEvYgw7WIwGkgqZGirLeKihbYn6YrZMo=;
 b=Lh/SMwc+KviB1yVQJyGp5MYvO7nw3xk0ADKb831sLFOu6ybxmon0MXEyPaneRAqfI6
 H4USaJTlyguLYsjf91kKkbJD6TJ8itD25OJQ2VF3KGGxj8j50E5rppbqxXCOfqol2z0t
 wDWRM+Cdvz7syVuFkG+mwGhDACTJAAttQIkcuxC0rdSlAfDzeQT3ScRMMgLLNED6RIOF
 YnwjOeI5+18+UlLCo8d6oFiF/6qdadrpUv0MtoJbHHuEsHmCEMcFrrex9TpwmPGIkjRO
 EYNvBIr8JuGj+eZ+WmnILE2Rj0SC7sc/lHnICtbemqL6pwlpHmr0MgE5IMSSkRo3bDho
 d01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708931776; x=1709536576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldSdLgR0z/gFEvYgw7WIwGkgqZGirLeKihbYn6YrZMo=;
 b=iMvprK3oRxqw53JkG7LIe9FMNurptcSVh4UaUKHuDJb6zqxKkN6Jm4uCgicuPu7MO7
 ADfOPYYVzDMbB+V8gR0PKyDUgusc1cxtVN927WFMRHwdmG3gCA2pxMqUhFD+BwJcCqem
 g9byubVeHeKwYWm8mrzLEIRPGwdsiam4pP4RhHWVPbKRBSAWWB8DbhXUDKhoktLGw70y
 /xTByu5nWDLF18e4xTWpbmqSHVWyiitNEpS8UV4Bf0wX5XOqv+ZMvX2lO9rxerxojJvt
 S221mhEKKEJOckMssIzN1z3ia4Njkllbcmh6/cBq620pTSGu5n88fdyXMN2ilt/s2h/M
 ISTQ==
X-Gm-Message-State: AOJu0YztTx83Fx17s6U96VdjlwTjlEhn5oHxvZ7YBrcVA/hq6eTnx+nK
 jcO5tLzjjT7hYwb2WCF+KXwcij7XTwkqqDMwmU8IAYBTbz1fMlLYyIHHfF8DCpCSwHD0VwhqdTb
 h
X-Google-Smtp-Source: AGHT+IHTQoPg6J9YyOP0F9/k5cVQv7nMcqVF3hpjSXsBgsqOd7aE6kjZtN1wzX+9ck6XjHk0sDGCIw==
X-Received: by 2002:a5d:5b85:0:b0:33d:87e9:5900 with SMTP id
 df5-20020a5d5b85000000b0033d87e95900mr4059192wrb.62.1708931776195; 
 Sun, 25 Feb 2024 23:16:16 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a5d6786000000b0033dd4783058sm3203766wru.9.2024.02.25.23.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 23:16:15 -0800 (PST)
Message-ID: <3dd4aab1-4a12-44dd-a925-b5578b387492@linaro.org>
Date: Mon, 26 Feb 2024 08:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: support on risc-v 128bits
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Jean-Christophe_=C3=89n=C3=A9e?=
 <jean-christophe@blues-softwares.net>
Cc: qemu-devel@nongnu.org
References: <03553894ee4f79b3f63979a9e9ac87e635c75933.camel@blues-softwares.net>
 <CAKmqyKN3zWD7Pb5_u8MiJreRZnZ8J-e1E9m-L6vuZvhq_W9u3w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKN3zWD7Pb5_u8MiJreRZnZ8J-e1E9m-L6vuZvhq_W9u3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/2/24 00:57, Alistair Francis wrote:
> On Mon, Feb 26, 2024 at 9:30 AM Jean-Christophe Énée
> <jean-christophe@blues-softwares.net> wrote:
>>
>> hi,
>> i would like developpe my OS on risc-v 128 bits.
>> after search the support isn´t fully operational
> 
> We have some basic 128-bit support, but it isn't complete. The RISC-V
> spec states:
> 
> ```
> The design of the RV128I base ISA is not yet complete, and while much
> of the remainder of this specification is expected to apply to RV128,
> this version of the document focuses only on RV32 and RV64
> ```
> 
> so the spec isn't finished either. AFAIK there is also no guest
> software we can use for testing.
> 
>>
>> how can i help, and in the same learn risc-v 128 bits
> 
> At this point there isn't really too much to do. There is some basic
> support, so maybe you could try and port your OS to that? I'm not sure
> how you would compile it for 128-bit support though, as I don't think
> any compilers support 128-bits.

You can also have a look at TinyEMU from Fabrice Bellard:

https://bellard.org/tinyemu/readme.txt

- RISC-V system emulator supporting the RV128IMAFDQC base ISA (user
   level ISA version 2.2, priviledged architecture version 1.10)
   including:

   - 32/64/128 bit integer registers
   - 32/64/128 bit floating point instructions
   - Compressed instructions
   - dynamic XLEN change

...

4) Technical notes
------------------

4.1) 128 bit support

The RISC-V specification does not define all the instruction encodings
for the 128 bit integer and floating point operations. The missing
ones were interpolated from the 32 and 64 ones.

Unfortunately there is no RISC-V 128 bit toolchain nor OS now
(volunteers for the Linux port ?), so rv128test.bin may be the first
128 bit code for RISC-V !


