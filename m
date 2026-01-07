Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6C8D0D14B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 17:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXOd-00039e-4Q; Wed, 07 Jan 2026 12:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdXOU-00038x-42
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdXOR-0001T6-KK
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 12:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767807137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sQVVJFp1vpQNZl2j/cXHR2qZEFjPn5lDwyDSiJRHotI=;
 b=PTGTrxcJziTR9Zp4YLlYJwsx4XhwEeWk2nO4qjn8ZpxvDlYBQDMHsDmDvCW1sywtR1FmtD
 5Q56BlIG+6qVvfY1WqMzmrc9bHIrqhQUEFiiCPL6OSkbcQ/X+9GcgY9KSZKGCYriDBAznk
 k7utBpvJ3DwbeFy+70wL+Bc7Mtm6asE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-35GRetd3OkypVoo78F7-2Q-1; Wed, 07 Jan 2026 12:32:15 -0500
X-MC-Unique: 35GRetd3OkypVoo78F7-2Q-1
X-Mimecast-MFC-AGG-ID: 35GRetd3OkypVoo78F7-2Q_1767807134
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso528996f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767807134; x=1768411934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sQVVJFp1vpQNZl2j/cXHR2qZEFjPn5lDwyDSiJRHotI=;
 b=pcy4XmFP4pBz57Plxo2B0VSpTl3kKnNKl3YUx3rUongHEIxifPC5iHYFigaYv7PJjq
 8AFDXeHJX4Ia19vkWfczpsIk7111RRbzC7LlcJfOZGc/VIznJp6w94ei8ZCv35ibFqdw
 Vi/inbSFWdM3p6ofwUMlHbZNFzNVQNqIveVxLumARwYHOhlqq3fHDvQdQK51tKR1qqzS
 AaUogAPQecNUHJTynyjdcXqQizwCTRrzz/IiV1chPWXqa7udywxDFoo0i76XOPBcTsNq
 yET3LrmJdBPKp5hloisoeBTItdGe3s+sujhxOA/u9Hy2HvMeykLoFR+vsQzS+zkYv8QW
 +FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767807134; x=1768411934;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQVVJFp1vpQNZl2j/cXHR2qZEFjPn5lDwyDSiJRHotI=;
 b=w0UVKvv5r1lY9NfgYXQOOVzkCVyv6FHyq22Hrii+T+8UeyqNJZga4Ey+ZJX/qsqgF9
 GdVzpzaIzcy6cDCrXekTi0nLycObiXaQN7lYk3V255cznMUfhs+2f8DTj0nTt3n9Pu+G
 aLDYbaUQMed0q+kJxno19U6dV9pnkn5C2yjxZ7BaFjjbcGHPns6HvubTH+y3F+9cHkgh
 9kBCBWwSGnaaLzghAh3pcOWAUNT9YRIpOAc5vHba1ykwFaAJLUJ9dNzLpjSGMOi3g3Vj
 RbeNt55P4yStv0XjKJzSyglUP3yzo2kjyn7gLgEHxSD+kTw2KgJeVQHnIdzKs7OX0GwH
 FT9w==
X-Gm-Message-State: AOJu0Yy2nSZoRHtMzAgZYVAOnkfa9PrGdI5kgNIhmS2icRuXSHABhjaE
 QEijzsu6aLdlOxcXAnY/NVh+Q7hWFlFH1k77JJdyYOuC7/+D0AeunxTUhEY6iTnQ5VZUXzU62/0
 3P8T6MtBVmhKtwASd8bePtIiD77KDPtihwtOB2Qujm06GT43CNYFswz2w
X-Gm-Gg: AY/fxX6HTocKtKn1QGm/XSw/R/uYEb4dcRfb9jaRTyQUwk5WKTg0nx0+6L3SWWryIo3
 eiK/7QXqAfrwDVasgx7niiJdkDeewi+/edrH8c5xCjCIzdTrWTkX8FuCStb3VihZBAuYsj3Fatb
 XdTlY4uDQwTEbEeMTqMUGpJQKqwP80eb5jYQGr0R5nJZf7k4QKoFb6awxg0PGUofbI8qKdYGuF+
 1Jn4rKwHXZ4QSx+WVP948dRoqPGVc86wfpocKcCL9M99ecCwDVQniQPccjlpA/wqJnOtEkHkpqo
 icrGHszA2AmX2r4ZEK1Xp94l2dXtx9sQrT2Pr2sgiqv7XrxVOJM9WYVGijqQU+K5hgX+KlIyP9/
 iQlKefWWdQF6TMVwZAADblXvTkKGuaBmDWQvV55wZ1YMT7tTZ+czYkJrwvxKRXrPnAQyv6hM54E
 qx+yfz/UWpeZNzTg==
X-Received: by 2002:a05:6000:a88:b0:432:c0b8:ee42 with SMTP id
 ffacd0b85a97d-432c0b8ef25mr5517179f8f.11.1767807134251; 
 Wed, 07 Jan 2026 09:32:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjonGqfotVWBJ2r0RODBYNRmuqTf2DbaenHluOWf3o9KorIvc/HVQtUAjlwZHjcNBnTIfHuA==
X-Received: by 2002:a05:6000:a88:b0:432:c0b8:ee42 with SMTP id
 ffacd0b85a97d-432c0b8ef25mr5517152f8f.11.1767807133861; 
 Wed, 07 Jan 2026 09:32:13 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa78sm11454528f8f.6.2026.01.07.09.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 09:32:13 -0800 (PST)
Message-ID: <e1cfdb4c-1e33-47dc-b8f3-3d5b40cb6c98@redhat.com>
Date: Wed, 7 Jan 2026 18:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/i386/tcg: allow VEX in 16-bit protected mode
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260107151400.273916-1-pbonzini@redhat.com>
 <20260107151400.273916-5-pbonzini@redhat.com>
 <d3747279-4dcc-b58f-18f0-c8a87c4abcf0@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <d3747279-4dcc-b58f-18f0-c8a87c4abcf0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 1/7/26 16:57, BALATON Zoltan wrote:
> On Wed, 7 Jan 2026, Paolo Bonzini wrote:
>> VEX is only forbidden in real and vm86 mode; 16-bit protected mode 
>> supports
>> it for some unfathomable reason.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> target/i386/tcg/decode-new.c.inc | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/ 
>> decode-new.c.inc
>> index f662364c600..243df7e3735 100644
>> --- a/target/i386/tcg/decode-new.c.inc
>> +++ b/target/i386/tcg/decode-new.c.inc
>> @@ -2875,7 +2875,7 @@ static void disas_insn(DisasContext *s, CPUState 
>> *cpu)
>>          * VEX prefixes cannot be used except in 32-bit mode.
> 
> Does this comment need updating too?

Good catch, it should be "Bits 6-7 of the first byte must be set except 
in 64-bit mode".

Paolo

> 
> Regards,
> BALATON Zoltan
> 
>>          * Otherwise the instruction is LES or LDS.
>>          */
>> -        if (CODE32(s) && !VM86(s)) {
>> +        if (PE(s) && !VM86(s)) {
>>             static const int pp_prefix[4] = {
>>                 0, PREFIX_DATA, PREFIX_REPZ, PREFIX_REPNZ
>>             };
>>
> 
> 


