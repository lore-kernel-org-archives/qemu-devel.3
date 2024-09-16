Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A230FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7Is-0001pP-Qp; Mon, 16 Sep 2024 04:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Ij-0001ml-Bs
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:41:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Ig-0003bL-9c
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:41:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so23804335e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476096; x=1727080896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zwcKW8cKBFR7rQucA22Lvh615WezakPNuIDv/yEP9U=;
 b=T9Q4B8/qrbZ84V8uCSf3P/Q3euo9jy8BL7XaGUbkrXyCJ5uD4MSjVJFL6UeervO/G9
 I4T1gmkjdIlUrEpn1IdEc83aysTc1k1LKftND7Bm7BmI+DFzuw56acJRcDOrkTuLH4dx
 3g9t3Ab/rLVakCjUNw/8ACE3jHQ7KsBL7hGDYtMjIiI5IndA8Hgte50tos/P9AYhMNUW
 jbeTk28FpW/ZNeVrziVuv2V0e3Eh6L0fGas04sSdMhWHftkfYOUTnsIPnX0Jkx57AQWR
 xXDSCXti44margsjgf9ZVI7FzmLLSsUQrFiGi2e9N3u82ipqE4E15erm+fY4zYJVVzOz
 HhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476096; x=1727080896;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6zwcKW8cKBFR7rQucA22Lvh615WezakPNuIDv/yEP9U=;
 b=cnEEzbRehdhK+fxOZkgOW09TEaMOn86tvh36qd1z6JMryc2WaBDDtjFpFaYChV+R2b
 SE2NgPjNtunmj536wQd70SvYJyvqo6E3dlMWPJ5+x1DXF3i+pZ3pdMT7/75sGInJJack
 3l67D6dFs8gGk3Rl5VRnD+v2EHxAZYgkrk9gNZGomaGSWc6XyxFzoSsWCMAZ176lielh
 hc/TlFm8kgaE3cdTX6qcRaIIiAgcvzRkOv8ret8h/Bnd3H7NfWxgojn0t6eQKfWq7E2/
 9hYaTktsrp/+59rpBIVbr3IyYtkA8Zdy0AhCJGIEHFWEj/OPB1bmmW6Rs3R/FXus8Vj/
 EIFA==
X-Gm-Message-State: AOJu0YziWV5It+VrWHry1wpeK3oJP+V2tw6/n7rGDJgImC8k4OJ4/g81
 1H+rulFWJoL3lTnzfmJ/C8myvovWctY1bzS5Xi7QcFEwiXLJLIK3Fzo+FuDAvTA=
X-Google-Smtp-Source: AGHT+IFahcVuBpaJbgK44I1ljDyjsGuvMv9Cj55WUyvMej+YnOG0gByoqKtGIqQRXFkjkO2EaxQtSw==
X-Received: by 2002:a05:600c:4e51:b0:426:5dc8:6a63 with SMTP id
 5b1f17b1804b1-42d964e0f37mr72512925e9.30.1726476096193; 
 Mon, 16 Sep 2024 01:41:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b189a83sm104275345e9.34.2024.09.16.01.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:41:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B58365F87D;
 Mon, 16 Sep 2024 09:41:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  devel@lists.libvirt.org,  Thomas Huth
 <thuth@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  qemu-ppc@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>,  Yanan Wang <wangyanan55@huawei.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  qemu-s390x@nongnu.org,  Alexandre Iooss
 <erdnaxe@crans.org>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 11/17] tests/tcg: only read/write 64 bit words on 64 bit
 systems
In-Reply-To: <c56f2b0b-3028-4b89-8289-e20519cdcdb7@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 13 Sep 2024 22:15:40
 +0200")
References: <20240913172655.173873-1-alex.bennee@linaro.org>
 <20240913172655.173873-12-alex.bennee@linaro.org>
 <c56f2b0b-3028-4b89-8289-e20519cdcdb7@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 16 Sep 2024 09:41:34 +0100
Message-ID: <875xqwgfcx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 13/9/24 19:26, Alex Benn=C3=A9e wrote:
>> While the compilers will generally happily synthesise a 64 bit value
>> for you on 32 bit systems it doesn't exercise anything on QEMU. It
>> also makes it hard to accurately compare the accesses to test_data
>> when instrumenting.
>> Message-Id: <20240910140733.4007719-21-alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/tcg/multiarch/system/memory.c | 26 +++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
>> diff --git a/tests/tcg/multiarch/system/memory.c
>> b/tests/tcg/multiarch/system/memory.c
>> index 8f2371975d..680dd4800b 100644
>> --- a/tests/tcg/multiarch/system/memory.c
>> +++ b/tests/tcg/multiarch/system/memory.c
>> @@ -163,6 +163,7 @@ static void init_test_data_u32(int offset)
>>       ml_printf("done %d @ %p\n", i, ptr);
>>   }
>>   +#if __SIZEOF_POINTER__ =3D=3D 8
>
>>=3D ? :)

Ahh I was confused by the email quoting. Do we actually have any systems
with bigger pointers or is this just for future proofing?

>
>>   static void init_test_data_u64(int offset)
>>   {
>>       uint8_t count =3D 0;
>> @@ -187,6 +188,7 @@ static void init_test_data_u64(int offset)
>>       }
>>       ml_printf("done %d @ %p\n", i, ptr);
>>   }
>> +#endif
>>     static bool read_test_data_u16(int offset)
>>   {
>> @@ -254,6 +256,7 @@ static bool read_test_data_u32(int offset)
>>       return true;
>>   }
>>   +#if __SIZEOF_POINTER__ =3D=3D 8
>>   static bool read_test_data_u64(int offset)
>>   {
>>       uint64_t word, *ptr =3D (uint64_t *)&test_data[offset];
>> @@ -307,11 +310,16 @@ static bool read_test_data_u64(int offset)
>>       ml_printf("done %d @ %p\n", i, ptr);
>>       return true;
>>   }
>> +#endif
>>     /* Read the test data and verify at various offsets */
>> -read_ufn read_ufns[] =3D { read_test_data_u16,
>> -                         read_test_data_u32,
>> -                         read_test_data_u64 };
>> +read_ufn read_ufns[] =3D {
>> +    read_test_data_u16,
>> +    read_test_data_u32,
>> +#if __SIZEOF_POINTER__ =3D=3D 8
>> +    read_test_data_u64
>> +#endif
>> +};
>>     bool do_unsigned_reads(int start_off)
>>   {
>> @@ -476,10 +484,14 @@ bool do_signed_reads(bool neg_first)
>>       return ok;
>>   }
>>   -init_ufn init_ufns[] =3D { init_test_data_u8,
>> -                         init_test_data_u16,
>> -                         init_test_data_u32,
>> -                         init_test_data_u64 };
>> +init_ufn init_ufns[] =3D {
>> +    init_test_data_u8,
>> +    init_test_data_u16,
>> +    init_test_data_u32,
>> +#if __SIZEOF_POINTER__ =3D=3D 8
>> +    init_test_data_u64
>> +#endif
>> +};
>>     int main(void)
>>   {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

