Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7E6EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snyv9-0001Rd-Oq; Tue, 10 Sep 2024 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1snyv2-0001Ps-2L
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:20:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1snyuz-0002Sn-Rz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:20:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so1085555e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1725967218; x=1726572018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7HnOYeOff+Aq60BA5DPeIDEoK0HCYbCwZM5kL+YVUeI=;
 b=MUHrZ6fvM/AYQ/8UjNiaEGBGB+Pm6vaGOkSb70k+TqS39RlM6nqpQa32Np+I5hySTa
 ISiQIYWJ4NcORLjoXVGGfgHhbHDFuri8uU97xuHyVvmHqqr6lVK2NhSFCCVjRUgA9hdc
 w4R6rvbnwYhQ+ki1zV0KLdG0/HPNEjG0L9IOWKhDhrguZNQzW44U5lJVhvW4xQ0XVU7l
 FcyloPeqBGh/vkILv73XtAMua4pFE3H4MForM0HRyOanmyGWs6M3aEmUxMWOHFExbG6e
 9iPdjzKVujC8O1vOCIvL9Pj+HEdIzR8azDB4rDMZMgcF79aB501Tbb/ZdKmLdd0T8wd5
 hPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725967218; x=1726572018;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HnOYeOff+Aq60BA5DPeIDEoK0HCYbCwZM5kL+YVUeI=;
 b=sLWGikD++FUX7A//pT2TwMgFMRkok7ZWVKU/wz/IM68+l5MLszX0NWSYGePrvyz6kG
 HUA6Q8BcqrrlT2qZhn4i1KkrG0Up9Mz1MVZFYcHVztuT1mH51U3ADY/p2WN9SwoUw+f5
 0trfUCBCsGzC6h9jjz2ZMXVRkNnVcRZ1KBGvcIYaKhIjvHYar2nY0zpTOiLCPfhRtyZq
 hFa/Jrop9p3MGsiYp/VeFLHqy+IyhGXP92F3jsi3wPW24l5/ZgVeRgc0hjC7aJQjlN/5
 haLaJw1hzmLhAw9fzRVfRIjOeZn5SSo9WzcQhk3Y0XfRtIqzHcwXoBQCiKhDLUGKr1FI
 MLTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU8+wlwvgC87S1tXQYqw9p1fCJktfLM5JqjmRLi5/Z7HjxTTPGpRW1J/4/bXW0WXjkTGHwd0uZxrmE@nongnu.org
X-Gm-Message-State: AOJu0Yy6nVYlIXLC9kxdutPC+l7PQnGQUOK3BiZK5uFnA00M5DYVO7HG
 jDCOysZFiPtEV+QogT7aS1dQkQPwhwS8pjpyTJrMyNPaBFkUzmYGi+TvfEeohWo=
X-Google-Smtp-Source: AGHT+IGBelYE2+SHajKoi3p1dvbpbcaw3RsHMMz9vg1KHsX8HRd25zEl6ezCwM9Txl3OWz2fzkModg==
X-Received: by 2002:a05:600c:4e11:b0:42c:b9c7:f54b with SMTP id
 5b1f17b1804b1-42cb9c7f6e0mr39345815e9.16.1725967217580; 
 Tue, 10 Sep 2024 04:20:17 -0700 (PDT)
Received: from ?IPV6:2a0e:cb01:d3:f100:969c:7831:eedd:9022?
 ([2a0e:cb01:d3:f100:969c:7831:eedd:9022])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb8180csm108389825e9.35.2024.09.10.04.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 04:20:17 -0700 (PDT)
Message-ID: <1753bd69-6f7a-4b34-a7ae-8a0b225b72c9@embecosm.com>
Date: Tue, 10 Sep 2024 12:20:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] target/riscv: rvv: improve performance of RISC-V vector
 loads and stores on large amounts of data.
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
 <20240717153040.11073-3-paolo.savini@embecosm.com>
 <8e0c2afd-4c31-47f8-ade9-60a83ca20859@linaro.org>
Content-Language: en-US
From: Paolo Savini <paolo.savini@embecosm.com>
Autocrypt: addr=paolo.savini@embecosm.com; keydata=
 xsFNBFkmx4gBEACxFDFs8WHCLfdXcMgET+MNAyR9E4ry7u9tApQVns7cCM0p0/S1hp6NZHmU
 TAkiI7o0AC85/UbENNSm7AUy1CuYKKXhq1cK0+tWpxBZXfC6wnwG/uZ85wkshW/E+1ad+wKQ
 glc3ulbbnPgkntrgnsUANJkT3G8iGKKZV2gryGzYZZLDWxJa3RncsoLELsIBPM3St1cRveZi
 UBGOtQJ/BkKcnFsn3YbLS4/BwzBCez99+maGTEjo5tKexvHkvTWDOuOnEnN7/8KZYTI2/3QT
 aqJt3Mn8bGoxnHDRskxcQlU0Ikbu5sTAdY4AjoSywtK55flAyFaiI0JmAskQzYppw9YnanTd
 6cXweYkMPlpUO2Rrsa0Rlnx7RJvnp+0iNeBvPZIFO5cC8pkMr6c/p6iQRQtDGXPr/bLt9VRh
 6+aU/hiPKlR2IDOU0p9SzzJLQZX1N9Ux3Vi+9YqoXqFjpb2xKhVSz9+4jyMolt2s2wbS7Yic
 CqOnItrmpz7uG3v19/KXSM2tAvVq5/NLRShWeZnUICJGVIqkjpy66yxEA1VdMv8fv6nPY0Zc
 XdEjM7OheRtyJ3wARIZ6tit38zd+Ec6v5ZiwoeStCSq/qBHcsU0ntJh2XVIY2j8Crl5Lqnzp
 10cntRxP+fXllXOvUZKyfAyfG3MZXQk1+3jmJsa/0U2HkX9CJQARAQABzShQYW9sbyBTYXZp
 bmkgPHBhb2xvLnNhdmluaUBlbWJlY29zbS5jb20+wsGUBBMBCAA+FiEEK3shuOASG5NvClHt
 M4WOPu66Z+EFAmK+9DcCGyMFCQ8oAK4FCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQM4WO
 Pu66Z+GGQg//afbMPUI3aDSKhV6Y6ghL6xf/yNL627i3Fawf+3P78Gyzxg83xzeoJ8NfDT+F
 kS1MDYaTD0qj+toI/obIuRzshhwF5ffyaLNMLRzfQYcEFVbk8qfz4FXDwNNaFL9K/1zC4wXz
 SlH6IitHdtgqIOtvYPXicmiPDMl9kxfOkgWrFOu7C7m6RYCzbu1IuSMYZ1DgoFr9KriLDqby
 UuFCDTN25cU2qfX6o37KJ7VEuhuMSlCf7jthNNLSEGb38ScEvUHHH8KZe5wN/O2UyLLyaCtI
 GlZj5vraQu/DWMadH7yOBAbP9VsKDrn+zMD24U6w/xSUi4gxintjugQHBrbtL8eeqi4nx6tW
 p9UujtulIucfSyQ/R/WD9oBT39NTwXbDsrAWTQJXT0IxsWHgF0sXI5gkUk6JpM8wlEh1nq2e
 PUuoLopx3sTDS+Cg7ZjlTJiPnXLfegChbNUBx4FRdPn06FlL1mZwut9diegP9m9LkKi1Jrp/
 6zmRMw7YNxXY6oU7lFZRek1TARCSwW9vZJFqsnVUZhASwp0+nkY9kBMX74jrbUTQM3MNSofI
 qh6EGJnRX9UFJOOkOsbeNQHIa2D/bJTya2vE1LBanDdMz7pchT78ISN6ZlZz73QrJstKfY/c
 j385P7USxjOvjwtSYkIoh0/eKrzsJ3N4jn0aaFQDhvw07+DOwU0EWSbHiAEQALWuuba2/zHn
 POInGBZ+sVwyqKQ/J/nEx1TgseX0wUAG1fN5ImW+pHqQvuJwCloJoguvsKIdx7hSZ4oz1VU8
 USsbsl9vHCVRLGmTOE1MLr3F0PoPzdpNSF0jvss8EDxYW3CZwpE5TpkgQBxfaoXirX7K45WG
 bwEzMMntywjyLBQ1h0LjdcAtdps/oWfJgWEmJIYQU3HX2Pm5oqgsmZal8Qczxa+cBBqLiLys
 KLPBhOrd82zdgme5UKqZwA58NYObNGPRL4tz05qLO9VQ4JJMP5AYsXkLwOnA+jzy08GTUZ5/
 i7vThZmZn3FomFR6jUV6PFjrLk2sUbZE5gN46i82HGGwCqTSds2d8Acy6NZJcLGlzDfFsviD
 X8IpOLPlgBtDv51R1LVwnjBdPDubLOwXWCVnPjKPV+n9hlCTL6cH+rvAWAFGIA+7y5b1PFBW
 rQiZ2ZO0c+Bw8O2dKLdj0e7cXoNUlnH9OMB48GLbuuy8lxOHE7qcfak+F7wzp4qPAoj0dPj0
 05cEcI15/07qyEhf1hkA2JbJZQtYxllgKhbxdVnUjN61+/qLDV4fE3GCmvF41YfzUNOT58+s
 TLfMlIOrUkJaZhA/N9n+CGW67XD9TG+9W+UJIwzzc+GQDKKzgsBgCep+3uwkhtmiSHg6sav7
 T6H5YqOdcrJKr+ehuraWGu3ZABEBAAHCwWUEGAEIAA8FAmK+9DcCGwwFCQ8oAK4ACgkQM4WO
 Pu66Z+Gr4w/9FKKAJrTHbJGDTiP7XXMIJEsv/xk6In0pcn6vmnbgFeGqi7Y04hJ1SGxc3uY0
 kWiAifMfDnk499nGz3rcjT5YHw3i2++azzEIJWp7e/qPWHklZ5Ou+NsziWXmEVPIBg98ofN2
 hH+KW9SqKiEuCd7BGDU2L//xthQCfwh7ZpIjpm55oKAsX4cQcqOIzusThooHD7qcRl6bUvdL
 3X03beKp/yPTnGXlyB1vLoAvVNWxBVOmRrv++HMj2Fr7OjSm/v2qt3JPufxg4O+CHwA8uOYG
 AQsI13nanh43cb32n1QKKooXszMM5jb53lZeB4cqLdqa7MNXub+N8eDQbD6RN8NARloRik7j
 c90QUHeq3iG1jQAy3sJkLzKjFrCeHe0sHUosHAExKEAvYUFEpRI9fw4THMsUCZl94865aVrK
 oTKPQC3NLymyHZrE4XsKM87RfdAirMTWYl7CRJiJTGyBl5cqUtYBandCB+w69KErQvXkTDsC
 gLdbxTE0V52Uzlo8XH/sWoBqjGYeBPP7N7R87to28MaRXQqQO5dJMYYQ48h/SlXYNhgErNBv
 v5/HdNMG7HoMaOeJJksTweugySnZ8/opXTTYrn5beaRuSznU8ErbCAKn1y1DaDGRnMeTK/qG
 jKBBlQ4aqf6fUhpYwHcO7YC1oXz2w8WisW2R3f25FdaaDzw=
In-Reply-To: <8e0c2afd-4c31-47f8-ade9-60a83ca20859@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thanks for the feedback Richard, I'm working on the endianness. Could 
you please give me more details about the atomicity issues you are 
referring to?

Best wishes

Paolo

On 7/27/24 08:15, Richard Henderson wrote:
> On 7/18/24 01:30, Paolo Savini wrote:
>> This patch optimizes the emulation of unit-stride load/store RVV 
>> instructions
>> when the data being loaded/stored per iteration amounts to 64 bytes 
>> or more.
>> The optimization consists of calling __builtin_memcpy on chunks of 
>> data of 128
>> and 256 bytes between the memory address of the simulated vector 
>> register and
>> the destination memory address and vice versa.
>> This is done only if we have direct access to the RAM of the host 
>> machine.
>>
>> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
>> ---
>>   target/riscv/vector_helper.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index 4b444c6bc5..7674972784 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -486,7 +486,22 @@ vext_group_ldst_host(CPURISCVState *env, void 
>> *vd, uint32_t byte_end,
>>       }
>>         fn = fns[is_load][group_size];
>> -    fn(vd, byte_offset, host + byte_offset);
>> +
>> +    if (byte_offset + 32 < byte_end) {
>> +      group_size = MO_256;
>> +      if (is_load)
>> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t 
>> *)(host + byte_offset), 32);
>> +      else
>> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t 
>> *)(vd + byte_offset), 32);
>> +    } else if (byte_offset + 16 < byte_end) {
>> +      group_size = MO_128;
>> +      if (is_load)
>> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t 
>> *)(host + byte_offset), 16);
>> +      else
>> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t 
>> *)(vd + byte_offset), 16);
>> +    } else {
>> +      fn(vd, byte_offset, host + byte_offset);
>> +    }
>
> This will not work for big-endian hosts.
>
> This may have atomicity issues, depending on the spec, the compiler 
> options, and the host capabilities.
>
>
> r~
>

