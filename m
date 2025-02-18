Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE61CC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 14:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkOJR-0004t1-3I; Tue, 18 Feb 2025 09:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1tkOJI-0004sF-MX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:10:54 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1tkOJG-0003X1-49
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:10:52 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso61185035e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1739887847; x=1740492647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gnHaycBuKeySQOmT0PTWO7o/+j7+Xf7EAs3n92pGywQ=;
 b=b8KZnNvdHAfI/t0XjxIrgk/k0rE/NH4CUTaWSlGbueeaukem2hmuRZKZc1ASx7SL9c
 ReT0sAupA11eBp19FjpBYIJ7nUCgipQ6KZBMb0pkGvOMhSjSurOKI2E9oRAKDF5agkHw
 gIsEw6lxpGNffbToQZQZpcVCfFW7LdJlG/vjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739887847; x=1740492647;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnHaycBuKeySQOmT0PTWO7o/+j7+Xf7EAs3n92pGywQ=;
 b=a6/g3JGSUB0cX5PvQblUnCpNeWVEyAKQ61HPfYIxp34fGtnYT7NMd/mBI4BWRciweq
 1ha5TzLvaActLoi89ez+J77L8Z8LeGVRec9JUrvdz7nMk+IIJ3GQmXSANctLAm/TOcAo
 ypd8TgtN1kaqelFwyFnBkuvdgS08v2bO84zNjnNZvF2k9I2u75WjOQFTDNc4JdJH0QKX
 XuMOZ0dmtm6ywNRxrItr3TwKBnNfE6UVt+r6TIhs6bqzFVmJ6y/ZBrtYyrgGQ+VqPmu6
 B9B4J11zI+sTFXFAEdGz3uR16JKz5J2KZyHdpuC3KDdS+HBJlzwuUNtb7R8S/X8LxO8D
 PkhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX90ZppSHcl3VRktKzTeVz6h4z+JbXAWKBTt5sCKaqI7mJSqvAbhnlwnDfyhbSfWq7W8BHZ5VL1k5z2@nongnu.org
X-Gm-Message-State: AOJu0Yz2G7KmMxu5Gvee+A/Dd7Xp9iqYl39qKycC5DZXLxrhbc1BeNX5
 atXVU3c4wqhDbDJj4TjmupW1t2IaURF4I5Q97quatdcdsJaaE38iGyIyHhf+ZR8=
X-Gm-Gg: ASbGncvcXab4IOvjZk5UanAjNEMB933G2BlWM3CHI9km9cgkaxBaPqI4Kq08PdMdHiH
 7UuD4fXBFrvGgHbHnaVeZ28kZy0GcKp78VcL2DqFhLaGCoBIIRN8pFV2uptIgkwdO+18S5USXDJ
 Foq+QZsf59V2m2c/YpvcM6FR27DGr3PQp0gUQLWQwSQV2fRYzVVsOlgm4zvSl0Uzc8zwRnqdQCB
 UldiE4NkFPvn4I66iiKH0dwSyum3qyiqp/xrybZrDqnU8O90QMQ/3Siv6ctvIHkVIkrrSzCSHj1
 /vgxwoQIFBF0UIYB7EGQTZb/E//pNrlQZGoDyP1gKmjI7UiZ+lKkcBQ=
X-Google-Smtp-Source: AGHT+IFAYPvX+3iueQGDgOxkfZX7j2AMQ4u7ZI4Ge/r85uKBHCQVQNtFmAxjfXXUQ4j9XaFQfPec3w==
X-Received: by 2002:a05:600c:1c86:b0:439:98ca:e39b with SMTP id
 5b1f17b1804b1-43998cae5a5mr8300805e9.29.1739887847372; 
 Tue, 18 Feb 2025 06:10:47 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43993d297e9sm21046705e9.33.2025.02.18.06.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 06:10:47 -0800 (PST)
Message-ID: <9b22d0ff-5902-4ec7-ae54-e974482ebd87@citrix.com>
Date: Tue, 18 Feb 2025 14:10:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-4-richard.henderson@linaro.org>
 <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=andrew.cooper@cloud.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 18/02/2025 11:20 am, Philippe Mathieu-Daudé wrote:
> Hi,
>
> Adding Xen community.
>
> On 8/2/25 21:57, Richard Henderson wrote:
>> Require a 64-bit host binary to spawn a 64-bit guest.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   meson.build | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 1af8aeb194..911955cfa8 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -304,9 +304,14 @@ else
>>   endif
>>   accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>>   -if cpu in ['x86', 'x86_64']
>> +if cpu == 'x86'
>> +  xen_targets = ['i386-softmmu']
>> +elif cpu == 'x86_64'
>>     xen_targets = ['i386-softmmu', 'x86_64-softmmu']
>> -elif cpu in ['arm', 'aarch64']
>> +elif cpu == 'arm'
>> +  # i386 emulator provides xenpv machine type for multiple
>> architectures
>> +  xen_targets = ['i386-softmmu']
>
> Is actually someone *testing* this config? I'm having hard time building
> it, so am very suspicious about how it runs, and start to wonder if I'm
> not just wasting my time (as could be our CI).

It was intentional.  I believe it was Stefano (CC'd) who introduced it.

Xen uses qemu-system-i386 everywhere because qemu-system-x86_64 doesn't
make compatible VMs.  I'm not sure why; I suspect it's bugs in the Xen
machine types, but I don't know QEMU well enough to be sure.

Another thing that (at least, was) tied to qemu-system-i386 was using
Qemu as a XenBlk <-> QCOW adapter, at which point it wasn't even really
a system emulator, just a paravirtual disk implementation.

This is, AIUI, what ARM wants with the xenpv machine.  If there's a
better way to do this, please do say.


Looking through Xen's CI, I can't see any of the ARM builds building
QEMU at all.  I think it's quite possible it's not tested any more.

~Andrew

