Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950B4D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 17:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZuQo-0001XY-7M; Sun, 28 Dec 2025 12:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuQl-0001WE-Es
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:19:48 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vZuQk-0003FZ-0W
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 12:19:47 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6446fcddf2fso7274331d50.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766942385; x=1767547185; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmXsVYK+je8jNWKDTeh6JiPTjq94wqZ6E82ryIqeyqY=;
 b=kEoQomys8Vlr2I38cfN1pOfCpmifb+HPQhaQnh9LxEj5zP/1OCUUMeGsp6xbTXttiE
 C4sdxfTFQ4wgVFE8D3nLRNAiV25ixFIls1DOkJ/mV4uETdsm0Av4X63Nx8+dBNOrn1yY
 a7sGzez12mfkAW4Z9ZwW/9TNIqcXPpO7XZMIqua7Y4OdsTo9f91kItx7Fxu5eoZkPQcc
 BCUOCV734LM2Uqsx+AgDFgwQRlwdXNZyP7TTCjEli/d/liW+9zHLORLm3Qa0z6pz0RG+
 NTNMupDSoNZejm8V9/GbJC4FKiGJ3zi/fgDnRSsMJeszQalsYS5KHAIAqT7qQADODaX1
 epLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766942385; x=1767547185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qmXsVYK+je8jNWKDTeh6JiPTjq94wqZ6E82ryIqeyqY=;
 b=QCnwp88j/YKoN6zU99dTGUdVJEi5hjjtD28NNtjKpyvtFDd27qq5RgPxOQ5MCpNBgt
 gFNDLgtE7r+Lth75jp9U3XDgaQscPfHZNWF/pU7xPSNcwYX+5o04Yof3IJiXrGu0jn5k
 Ul6/ABeqF/zgtMyPVSNbf8dJFiwxqnxNMEuhMpnThqIoqnwIjVnwpkikiVtwfvtTRyw4
 Z7tPECs30aX63F+r0PXv0mqNb0pSLf+owrrUoLMVJNnPldHcwqR/v/NE0UnpgVi5ELyE
 oJhtw1eQfH9Y9vBPPB4X1Qu5YjrcEt5clbfNQD4ZnojLkQjTB6OGzaiBESW6fzVYmwaW
 uqiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNk8DxexepIEkR26U6GfuuqKPx6GZCdbxtoTvvDIecGLrNgrtZVPtLbzMOIXB/8GVwDXZHORs3A+KL@nongnu.org
X-Gm-Message-State: AOJu0Yx+caGi4PVCfhuZmauOpu+KHzEHI7CGS4pi6QeCt6+LLgD/KC9r
 ebjpUGH7U91/CCaYXTUDBVC04wsiqTCc1pK8HYHlaqjsosah05ngETfPo9/+7cjwTrvAdhdpt5d
 /bEf5VLw+QpFz1cVkK0KjF/R3Y86ezbv5JKaRAMD15Q==
X-Gm-Gg: AY/fxX5kJR3KQbpIziSprCfEElnwYcIDHB5ww0OuOgxZB++5ZV0HjGuykQagZ0zGqmn
 Zh9szmZeX4pk0IyGU7W5ajmIXPKdzBLRdHoKlh5AbERyqbe36csDJBLau+BqbqmYvnE4tiEV5/Q
 3dTBF+P/3TTFJ9UjZU+x67a/6L8ygUuk4fKamd5AFDfouFYcENVN35EKVzClpd4X3XlURFY9gYd
 t7NAhM/b271fxuIGQgMiJXg4ZSIT8Dhly9FqJvnMnP1Wrlzt5eYNwt59gF5fHdda0mZctEYAT3o
 JYqCvbcUT+MjoD+IixUv5UE=
X-Google-Smtp-Source: AGHT+IHG+AtznED6UJaQ3gLlpDDCrhHVjFd0Wko4TIWFe0oCoMqzVpINrKiH+vBd7kVdUHVFRAMrD686nyC7DchlMoM=
X-Received: by 2002:a05:690e:4185:b0:641:f5bc:6984 with SMTP id
 956f58d0204a3-6466a8c9029mr20294549d50.80.1766942384698; Sun, 28 Dec 2025
 09:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
 <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
 <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
 <CABgObfYXW7RqZjqHVQd8T-RfZvy8oxb7-uWK0Au1W5VXzHVSNA@mail.gmail.com>
 <1b73aeb0-fa3f-4ced-9c07-5f0accebc324@linaro.org>
 <CABgObfbquY+4KqQn+o5nKhWPuFJnOB_LYTJzVCjF-GgH8VcQNg@mail.gmail.com>
In-Reply-To: <CABgObfbquY+4KqQn+o5nKhWPuFJnOB_LYTJzVCjF-GgH8VcQNg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Dec 2025 17:19:32 +0000
X-Gm-Features: AQt7F2p5k8M4JOac8Lm4kK9Jz39eI3dGvfn31wnw1GAmaYof2Q6afVOZDT43ay4
Message-ID: <CAFEAcA-s=w6+_mEM7pq1Z49OOkQVpOGGS-xqqjEjT5VNqX+FSQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Sun, 28 Dec 2025 at 16:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Il dom 28 dic 2025, 17:00 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=
 ha scritto:
>>
>> On 28/12/25 16:38, Paolo Bonzini wrote:
>> >
>> >
>> > Il dom 28 dic 2025, 16:14 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg
>> > <mailto:philmd@linaro.org>> ha scritto:
>> >
>> >      > Perhaps the source of the confusion is that they are in bswap.h
>> >     but they
>> >      > (quite obviously since it's host endianness) never swap?
>> >
>> >     Hmm, maybe not well named API then.
>> >
>> >
>> > The name is fine, the placement maybe a bit less; they could be moved
>> > out of bswap.h but it's not really necessary to do it now.
>>
>> Indeed not needed now, but already done to figure this API ;) This
>> helped me to understand what we don't need is "DO_STN_LDN_P(he)"
>> because this is a convoluted expansion to a plain memcpy().
>
>
> Without having seen your code, I will note that the simple conversion to =
memcpy() only works for little endian hosts. On big endian, you also need t=
o adjust the first byte, like
>
>    memcpy(p, ((uint8_t*)&val) + sizeof(val) - n, n);
>
> And likewise for ldn_he_p. (Apologize if you had noticed it, just trying =
to avoid a possible round trip over the holidays!)

But an inline memcpy() is hard to read and easy to get wrong:
we have a pointer-cast and some pointer arithmetic going on here.
What we want is to express our intent: "I am doing a load/store
of N bytes which are in the host byte order and which might not
be aligned". That's what the _he_p() functions are all for.

thanks
-- PMM

