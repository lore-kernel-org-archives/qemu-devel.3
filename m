Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE363C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmTg-0001rf-83; Tue, 11 Feb 2025 04:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thmTd-0001r8-W9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:22:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thmTZ-0002s2-8I
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:22:43 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dd0dc21b2so1978259f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739265759; x=1739870559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sDQKIoAvPAsyL+4G8ZB827EKcWgYbqdiMzHDX46eOA0=;
 b=rvmoePpHoPUaFAGkTbBQ7Ex39CazeBdqD0UAJoS2BY2ZXWMkESXzXgM/OEOszcXqX2
 7FPgoApOTRoWN26Slvln0K4+W0mYIW5pzbCvfZU/juviV2n8juuC5VsIwFB7anfge2YV
 ZP4BWPM3tao7+UC/bqm3h+HV9S6YEpty2etzswAwb7m3tLqeWfNJSjNEOKVFLRKCQK/W
 ha6PpjkV7bDAxhLXNqHAeT6YOU7x3DqYsUzZCuxBRpynpXtgImWTdmOege6Nlgfvi5ne
 R3hR+Kgm+L3t7bgX7NcCUSpE2I/4qCNFn2ftJFo/5BMwYsSfqggBFYiRxBpH4IIYSit8
 eTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739265759; x=1739870559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sDQKIoAvPAsyL+4G8ZB827EKcWgYbqdiMzHDX46eOA0=;
 b=f15T/aZ8CNNmF45E2bwbCjGit2X0H5djFw+ii82unqNAyJtqNqEqEUAmiZ4GHge2No
 Lv95FCNWAdsGXt17lECgWwCbtWQtnGzZWFHcs6JYnKLmgUyqz/dhOO/I3cFWQ+6mSxcM
 gj7XxL+fZufOqGeFgO+fOGdA5PQGdcPyCSs4dkrbMN/KET59nZpGhL5VbfjRqRmIkddx
 W5fbZmPgtU4IdhLolbLvMYHOduhWjCfpxWCTThpo8EIH9EcvgL502p/g4cXAbeorEKYn
 zXn5UE3AsOoRXbjoZ/XaDAjMGJcImZc6iKvgTz55CtryVPTMyglMdBF9sdlaqIp3dcKV
 0nRg==
X-Gm-Message-State: AOJu0YysqeKL1xda/9YSjrUK4N/46BN+3pkrCy72cJIt0WurP0tHm07r
 kM4x3kB/XLzoSf715mF8VVOWrdS3LWKtpKrM8hxTjcPwvoBN2ZueyC0ks4e7xGE=
X-Gm-Gg: ASbGncuiVsAz+KrHJSoRN7Xj6Sg3MB3buxNGK1neRuF3vR16JsMgzHU1XShpYh2mrFl
 GX/kadoLeFehQdcw1bV15ZrLazCO4ITm7bHK9P02McR37ZJsERtmCfTe+hgZyoR3Qiypf+H9WHy
 1VEadNtlHP3mV4PFFEC63pM3tmXcUFYreBmpbKUm16shVDrOmGyQZGcsfXyirT9vlXNounrBeS0
 Qm27ETEMPq9kYb8ixA4U2tqB1rbllrAkurL2mDPQdiKqjgbjSBBR1xd9r2RtcKd7KxrQ0uRvYn2
 BJPMHoVrMWZPEMzu4ivmT8CuIt8K2kKrVCL1EWWtfDL9oyDEJ+0EzmzGrCqYPx5K
X-Google-Smtp-Source: AGHT+IFm9sHqMY2wsq9CX/mOFo8eSAc5Jknmon+kFX0ZskhO8XkO6AVqu+AbxX4gmVvCANa0saoiZQ==
X-Received: by 2002:a05:6000:154e:b0:38d:e3da:63cd with SMTP id
 ffacd0b85a97d-38de3da6560mr3140306f8f.23.1739265758981; 
 Tue, 11 Feb 2025 01:22:38 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcfd7d153sm10204079f8f.84.2025.02.11.01.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 01:22:38 -0800 (PST)
Message-ID: <85539c0c-51e8-43ba-9c99-23e1b684f30e@linaro.org>
Date: Tue, 11 Feb 2025 10:22:37 +0100
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
 Markus Armbruster <armbru@redhat.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6S3Mgt1G7fIjeBB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 6/2/25 14:20, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
>> Introduce an abstract machine parent class which defines
>> the 'little_endian' property. Duplicate the current machine,
>> which endian is tied to the binary endianness, to one big
>> endian and a little endian machine; updating the machine
>> description. Keep the current default machine for each binary.
>>
>> 'petalogix-s3adsp1800' machine is aliased as:
>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>> - 'petalogix-s3adsp1800-le' on little-endian one.
> 
> Does it makes sense to expose these as different machine types ?
> 
> If all the HW is identical in both cases, it feels like the
> endianness could just be a bool property of the machine type,
> rather than a new machine type.

To clarify what we are trying to achieve here:

1/ Current situation:

$ qemu-system-microblaze -M help
Supported machines are:
none                 empty machine
petalogix-ml605      PetaLogix linux refdesign for xilinx ml605 (big 
endian) (deprecated)
petalogix-s3adsp1800 PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (default)
xlnx-zynqmp-pmu      Xilinx ZynqMP PMU machine (big endian) (deprecated)
$ qemu-system-microblazeel -M help
Supported machines are:
none                 empty machine
petalogix-ml605      PetaLogix linux refdesign for xilinx ml605 (little 
endian)
petalogix-s3adsp1800 PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (default)
xlnx-zynqmp-pmu      Xilinx ZynqMP PMU machine (little endian)

1 architecture declined in 2 binaries, total of 6 machines

2/ With this series:

qemu-system-microblaze -M help
Supported machines are:
none                 empty machine
petalogix-ml605      PetaLogix linux refdesign for xilinx ml605 (big 
endian) (deprecated)
petalogix-s3adsp1800 PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (big endian) (alias of petalogix-s3adsp1800-be)
petalogix-s3adsp1800-be PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (big endian) (default)
petalogix-s3adsp1800-le PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (little endian)
xlnx-zynqmp-pmu      Xilinx ZynqMP PMU machine (big endian) (deprecated)
qemu-system-microblazeel -M help
Supported machines are:
none                 empty machine
petalogix-ml605      PetaLogix linux refdesign for xilinx ml605 (little 
endian)
petalogix-s3adsp1800-be PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (big endian)
petalogix-s3adsp1800 PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (little endian) (alias of petalogix-s3adsp1800-le)
petalogix-s3adsp1800-le PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (little endian) (default)
xlnx-zynqmp-pmu      Xilinx ZynqMP PMU machine (little endian)

1 architecture declined in 2 binaries, total of 10 machines

3/ Once the deprecation period passed and we can merge the 2 binaries:

$ qemu-system-microblaze -M help
Supported machines are:
none                 empty machine
petalogix-ml605      PetaLogix linux refdesign for xilinx ml605 (little 
endian)
petalogix-s3adsp1800-be PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (big endian)
petalogix-s3adsp1800-le PetaLogix linux refdesign for xilinx Spartan 
3ADSP1800 (little endian)
xlnx-zynqmp-pmu      Xilinx ZynqMP PMU machine (little endian)

1 architecture, 1 binary, 4 machines (which could be reduced to 3 if
we want a default endianness for the s3adsp1800).

Due to the deprecation policy, step 2/ is necessary to reach 3/.


