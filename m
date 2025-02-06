Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3DEC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3QZ-0003BW-Bv; Thu, 06 Feb 2025 10:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg3QY-0003AZ-2n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:04:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg3QW-0005w5-2t
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:04:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283dedso10033105e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854262; x=1739459062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=km8wfH1YKDGjHtyfe844rEvoeDz+boWvButHiUcY8IM=;
 b=L87+B9Bfb7iONQHNAcoP6e0iGgNtDfmdawY2i4TX2t6JP4VWYStSmc1I8uoU88lF2w
 pHm8bDu3FkokHAv4UV4L9rEUWUCs++F5ITCQuOKmVsP8D19sQBpidbasdnQf7CYUWjsu
 bZDFKFEwqZISteQ+zR0GJ6b4bkwHwyHePjrIShEOv+000va99QeXelKYv1NdPjEjg/QR
 CfthbOJSpEOM3R1VtUFpX39wBqvPjd+2bx5Y7f+ubDpNEofVx1C+chbRthLNpBenKd1F
 kt4HhGPxiohbX42WdsxmuMfMzm2uC1C9HZgiJR5rzWpcJ571F+DZB1IuW1qUNBfRwXxG
 Q2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854262; x=1739459062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=km8wfH1YKDGjHtyfe844rEvoeDz+boWvButHiUcY8IM=;
 b=qNaXU8i3jOw7jqEpUjQ0z1O0Bddri9niyUnM17apDMJeso3plqCYzTwqT0lE7M9RPA
 bblX7yKgeek57iBBfktVDwy3S3iPXHmHjIlLH8GKRVVax8igT0GUmI5CfA1CkF0ex17v
 YesFCoF4K9uJNqgoSYJaZbtUcJiyeAcbnmvcjUzxaDXuGs6mLYJgfC8+H/yG/eY15e6F
 VFJsTePPl0GOw1GfRw3a1L7lIvoyL2GvZ47Mwvnf0cDgCXj9zB2Ejs2P5F0XYa5z2jM/
 rGiUtDf3c8fYkzaNZuKmmXQ3QMgOs6JnFsDyhsKlG2NN5TyRwFgEHBduX+tMIaVUb7xK
 79Xg==
X-Gm-Message-State: AOJu0Yz7TSDT9DtxLiF22BW0P8c1nDdOAhd2PuadSYMGmJNod9HbBkC2
 SgxQ4LOn2EVwGAQc/33c1/3JR5NRVh1uj+wam0sqqQfdsHezcw6urj/sldqT3wA=
X-Gm-Gg: ASbGncvrTHzXNGabNuPRVNQlqKyetFbrw+LipQ8LCm/j4KbCRU8/nJT185IZyhf7nWA
 vjiG3H7Vg5UV0zRrR8yeCBM89ufnwrgbeGagID8SI1igSpzol0QGNAXssbPDmktCUbec7eAkiva
 VMH65oFPI5jhX1TDe9+i0ybb5l4a9vgOFnfkde2SPlH2LBV/7jrmqux6Ae38Pkv8osAqqvmsv3d
 KbKDfY2zSlRslQGOucpC9rBQwpNK06ppjx2CsDyR1iiazrpV414CXudohy1xDkxh2kBxPyzSwTI
 my8LIBGLJIT6JXDchUUHTdA7IXkRVFgdZjgt2p9nk5r4ED4sW6v5roOeJ4M=
X-Google-Smtp-Source: AGHT+IHUetmvOAjyxDOEknvKxGKDD1pjI4/z+TXs5R19Q+StoQ/DaECimwilp7pdm9UPWZDsweO8ig==
X-Received: by 2002:a5d:6d8e:0:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38db48b42c0mr4890013f8f.1.1738854262183; 
 Thu, 06 Feb 2025 07:04:22 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd368bdsm2000130f8f.33.2025.02.06.07.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 07:04:21 -0800 (PST)
Message-ID: <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
Date: Thu, 6 Feb 2025 16:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6THtfjL6UVhBiW7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/2/25 15:31, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 02:53:58PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Daniel,
>>
>> On 6/2/25 14:20, Daniel P. Berrangé wrote:
>>> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Introduce an abstract machine parent class which defines
>>>> the 'little_endian' property. Duplicate the current machine,
>>>> which endian is tied to the binary endianness, to one big
>>>> endian and a little endian machine; updating the machine
>>>> description. Keep the current default machine for each binary.
>>>>
>>>> 'petalogix-s3adsp1800' machine is aliased as:
>>>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>>>> - 'petalogix-s3adsp1800-le' on little-endian one.
>>>
>>> Does it makes sense to expose these as different machine types ?
>>>
>>> If all the HW is identical in both cases, it feels like the
>>> endianness could just be a bool property of the machine type,
>>> rather than a new machine type.
>>
>> Our test suites expect "qemu-system-foo -M bar" to work out of
>> the box, we can not have non-default properties.
>>
>> (This is related to the raspberry pi discussion in
>> https://lore.kernel.org/qemu-devel/20250204002240.97830-1-philmd@linaro.org/).
>>
>> My plan is to deprecate 'petalogix-s3adsp1800', so once we
>> remove it we can merge both qemu-system-microblaze and
>> qemu-system-microblazeel into a single binary.
>>
>> If you don't want to add more machines, what should be the
>> endianness of the 'petalogix-s3adsp1800' machine in a binary
>> with no particular endianness? Either we add for explicit
>> endianness (fixing test suites) or we add one machine for
>> each endianness; I fail to see other options not too
>> confusing for our users.
> 
> We would pick an arbitrary endianness of our choosing
> I guess. How does this work in physical machines ? Is
> the choice of endianess a firmware setting, or a choice
> by the vendor when manufacturing in some way ?

Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
(wired to a CPU pin which is sampled once at cold reset).

> Picking an arbitrary endianess is compatible with our
> test suite, it just has the implication that we would
> only end up testing the machine in a single endianness
> configuration.
> 
> If we wanted to test both endianness options, the test
> would need amending to know to try both values of the
> endian property on the machine.
> 
>> This approach is the same I took to merge MIPS*, SH4* and
>> Xtensa* machines in endianness-agnostic binaries.
> 
> If we have prior art like this, then remaining consistentv is
> desirable and thus my comments are too late.

My worry is about how to not break what distros currently ship.

> 
>> Also the same I'm using to merge 32/64-bit targets into the
>> same binaries.
>> Assuming we have a qemu-system-x86 binary able to run i386 and
>> x86_64 machines, what do you expect when starting '-M pc'? How
>> to not confuse users wanting to run FreeDOS in 32-bit mode?
>>
>> Again, IMO having '-M pc,mode=32' is simpler, but that breaks
>> the test suites assumptions than machines can start with no
>> default values (see QOM introspection tests for example).
> 
> With x86 there's no need for mode=32. Whether the machine
> supports 64-bit or not is a property of the CPU model
> chosen. eg  "qemu -M pc -cpu Nehalem" would be 64-bit and
> "qemu -M pc -cpu pentium" would be 32-bit.
> 
> The qemu-system-i386 binary is pretty much pointless as a
> separate thing. Libvirt will happily use qemu-system-x86_64
> to run 32-bit guests, by just specifying a 32-bit CPU
> model

IIRC Thomas tried to convert TARGET_X86_64 to a runtime check
but it wasn't that easy:

https://lore.kernel.org/qemu-devel/20230425133851.489283-1-thuth@redhat.com/

