Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDDEE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLl3h-000394-H0; Thu, 12 Dec 2024 10:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLl3d-00038F-NX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLl3W-0006yS-Qv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734017084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nFlZ8BPgfoQockJuyNVqOGjYmTIzqU0ALiB07FSCzyQ=;
 b=NdiVVrAHMbo50OkKI43Zayg7n5nPtxW0/3Mcog1+g/+GOxsIrhkrvgDY5ytR/TzT74xH8N
 hsBcrRJWXp6cptfY3pNKubeEw8GGeMYHaM6ibsdY7NyabfjFiHI9qBwj3a6zgm+odtAB/+
 IgfPH8H5+ZMINlrIajJIiELyT4eR9PY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ps6hdz3kMjiDGT7ulSWRpQ-1; Thu, 12 Dec 2024 10:24:42 -0500
X-MC-Unique: ps6hdz3kMjiDGT7ulSWRpQ-1
X-Mimecast-MFC-AGG-ID: ps6hdz3kMjiDGT7ulSWRpQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso1066345f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017081; x=1734621881;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFlZ8BPgfoQockJuyNVqOGjYmTIzqU0ALiB07FSCzyQ=;
 b=BImo056ywe8zZlKedRj2/8SkTIbVg9FtSz80eLxSth5uSgEqbz72Lw/C6Xs2DusftS
 YQXzbYhXzaJCzPSu4DzgaDQ9q8/Wl4da9cAJdi9ONsu5fJeEbUVSAxfXrj2F6hK+4ubk
 MVveC30CDHhx9OLBCrG9cMdDz4QVlkL5yLDXu7i/KXBE0dZQU4ys8UGCnn/YkdHG1HT3
 iwjQA5dvOFuux6n65X/8o4zHHnAR+EI/ThPRFdRAwB6DbKUjDto892AWpu1aIoNlvVNf
 r95f8JzrS9ahaNxByTP55ymqY0PmqwSn7z8d6RoEi0pb/ONOkDuevjlIN42wBON/E7sy
 51jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMT2HLhdecJx5nPGqYeXdB9yMK4Kt8stvT2h/oUAoH53ZuCVoagKcHYedyocKGPZ8PShwnATFQIR2X@nongnu.org
X-Gm-Message-State: AOJu0Yze0fKhvUbMPAb679JovC57oaxXDv3l2vKKaBYCjJZu1oPw0XhH
 0K+YNT0IE39g19Nb6T8eXlLmMcSpMgcfRRVPWulWGIS2r8HaphADsZztKmnS0cKtXYD38N4vJyT
 UVG/4sLk3mR4pFOJrZpxjipFFqUSX+YPq45NeNIDWWdFMviHW0BZ/
X-Gm-Gg: ASbGncsHS2ilUA2gHKD/eVahqyNxREp4TNxl8E1mfFv1hw650sPtTpfcfOALs/r7mg2
 FAeT/koSnlcFxH8PW8btyIGl6NdGU4N3ErmxzbQq5xNCUeE66exYSvUPMny/Oc2f9pEAy7suIhY
 QURVaoSm8F8vPalY6DIgu8kJg5/PH7LT6MZgNeBD9shv8dtJqXEwD2lmgAY8kH3KUKzZNBv0yVb
 4KLJqvT7JJLzREH3WjMIWddpWTsabzOpyxXB/AxMBYuTQ3DxuREItTksP5K
X-Received: by 2002:a05:6000:481a:b0:385:f7e5:de88 with SMTP id
 ffacd0b85a97d-387887ac0dcmr2911246f8f.3.1734017081524; 
 Thu, 12 Dec 2024 07:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKHs0kfyoX2AvuBCh/uU0GB2IVmgdgEmmPPcUjTe6dmbeimNBlFFNPxLPHn6nqw6SLhe5C1Q==
X-Received: by 2002:a05:6000:481a:b0:385:f7e5:de88 with SMTP id
 ffacd0b85a97d-387887ac0dcmr2911217f8f.3.1734017081137; 
 Thu, 12 Dec 2024 07:24:41 -0800 (PST)
Received: from [192.168.10.27] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38782514e86sm4367236f8f.72.2024.12.12.07.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:24:40 -0800 (PST)
Message-ID: <d1a0de70-718a-452b-b20a-1934358d53de@redhat.com>
Date: Thu, 12 Dec 2024 16:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system: Restrict libSDL CPPFLAGS to vl.c
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Haozhong Zhang <haozhong.zhang@intel.com>
References: <20241212092632.18538-1-philmd@linaro.org>
 <20241212092632.18538-2-philmd@linaro.org>
 <88d424da-a876-43b1-b0fe-4c0ff084d2a1@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <88d424da-a876-43b1-b0fe-4c0ff084d2a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/12/24 14:18, Richard Henderson wrote:
> On 12/12/24 03:26, Philippe Mathieu-Daudé wrote:
>> Only vl.c includes libSDL headers.
>> No need to pass them to all system_ss[] files.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/meson.build | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/system/meson.build b/system/meson.build
>> index 4952f4b2c7d..f7e2c8b826f 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -23,8 +23,11 @@ system_ss.add(files(
>>     'runstate-hmp-cmds.c',
>>     'runstate.c',
>>     'tpm-hmp-cmds.c',
>> +), libpmem, libdaxctl)
>> +
>> +system_ss.add(files(
>>     'vl.c',
>> -), sdl, libpmem, libdaxctl)
>> +), sdl)
>>   if have_tpm
>>     system_ss.add(files('tpm.c'))
> 
> I'm sure Paolo will correct me, but I don't think this does what you 
> think it does.  I believe this has no change at all.

No need to correct anything! :)

> The presence of sdl within a *particular* source_set.add() call is 
> immaterial.  If the condition is true (and here, because the condition 
> is missing it is true), all of the files and dependencies get lumped 
> together.  In the end, everything gets copied into common_ss.

Yep.  You can have different flags, including library CFLAGS/CPPFLAGS, 
for specific vs system (the former ends up in the libqemu-*.a.p 
directory, vs libcommon.a.p for system), or for those sourcesets that 
are used also by user-mode emulation (IIRC libhwcore.a.p) or by tests 
(the various directories libio.a.p, libmigration.a.p).  However, here 
there is no effect at all.

If you want to do this as a cleanup to keep the libraries close to their 
users, I have no objection, but please adjust the commit message and 
squash the two patches together.

Paolo

> Both of these patches only alters the order of the items in the link 
> ordering.
> 
> 
> r~
> 
> 
> 


