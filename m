Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45416C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXSL-0007z6-Kl; Mon, 26 May 2025 09:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXSF-0007wQ-CT
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:01:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXS9-0005bh-Jc
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:01:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so13487155e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748264475; x=1748869275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Scqv3eZhXytD1uRMr9jXIMm2TkAk/vZVk6169RD0CD4=;
 b=fbtsSfddZItuyAV/oQPd1qnZBeItgBtgoTRcKfnCaqtJaNW5i7RqoMrzrbtuZm/LCN
 QRrR0VcHOIRXT0G5VaAlQUDGLrHfhNUcirRO+8GfCa4vtNgpFoQJBBpagb32YUOzjPTX
 NO5y9ify6zD5lB3+Jq9TrlGPM121pIPqfQqMPiwkoBbtBMini5wtBKt7LkmGQoAmDaz0
 dPztAXEQD/52YTUaZzBUSADJg966vjKkHB2+wJCRKGpOyhzxOblFCnnreiGXzbSAqFAr
 ThF980SdI5lpvi+ITmIKmxyLkoZf4os9G9bDG2BLoGqbRK5pngD8MnhaicfTEEzb7jGX
 eXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748264475; x=1748869275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Scqv3eZhXytD1uRMr9jXIMm2TkAk/vZVk6169RD0CD4=;
 b=SQpwDvybnAVWhPl4uPmPZGsLpWli5CSBb3OUgcSGv4iOZEN9rL2d/08s6EXEJipO5G
 gt+FYFA/+o6TwCPe1eieE1i26foVHKuDJBO/Exj5TY+AnpkWg4brE7Kejz2feXHTgHDO
 +/Ex8W/2W5g92vaQncx5inZaln5EI0E0QHGJczkjEAqDQ2ctLY2n17CjLDbPKJIkpL8X
 MnPFlK/QSPuCvNfwleouhzMda+yIwCi02Ig740cyag1DpDgDvl+pMnwhWhSV6ZgvPX6y
 K6ZW4hb9HjuDTOS2IeYbe3MR6Raq4qja+6qcNdqz5XQbP2ec5u1GJG/Dgpg5A7B8KOrI
 OLcA==
X-Gm-Message-State: AOJu0YxALPNqxFv6/pIHOFe24rS9N3rlTdslg0jv5sMAO59zumPhXSl+
 bgXuE47K4KMaK9+KgFlNB6tOtfrOFFdMUqwYdeaO5TSYVKt5NuGJVxVq9O0bC2raHVwiEOnbSTP
 bmy9enl74+w==
X-Gm-Gg: ASbGncthRfE3qji/UGQzbe1sb86F1UkUP4DnKaMlh5+/MCBlwym6mdf6GWGnnENy5Qm
 4rqBHqQd0rlsM5SdbmOE3FtbxxguoJKiBn43K8oBqH/jz89ChW2GWYbnOowrozJzvJO5mYXjcRp
 Sz1fCd2Tfi0YxZsSDH9NiwbOMV0Ri8bxJkjXpDZSba17uobqr2rS4hAVqhruetZTo4AIrl4mo9F
 DGHRolzUpwim+3Q/mIwqIQVbBIzjYkzaxn4Y4syC++knssNTLvXfzvFINIzRI2XADY9t6F2bHPU
 glf6Int4L4ld5jSrsyWtNT4ivXE8t/4wVHlSvLqLPusQ+NsCLg2JxS2NpfPfsUzku+XhXHce1Dq
 81jrl9rzbjjdB
X-Google-Smtp-Source: AGHT+IEuOCEs29xny8F3WLVNGdBgV0vvomsy4dbR6Uq272RCOu9MHi/2XPbJDIwxwZdxhKw087jmCQ==
X-Received: by 2002:a05:600c:470b:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-44c92d363f2mr75211395e9.23.1748264475290; 
 Mon, 26 May 2025 06:01:15 -0700 (PDT)
Received: from [10.132.0.213] (44.87.95.79.rev.sfr.net. [79.95.87.44])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78aef8asm245122125e9.29.2025.05.26.06.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 06:01:14 -0700 (PDT)
Message-ID: <78ab8e33-77bc-46dd-8db6-dd43ec9703f0@linaro.org>
Date: Mon, 26 May 2025 15:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/boards: Remove MachineState::usb_disabled field
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
References: <20250526130006.49817-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526130006.49817-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

(forgot to Cc Thomas)

On 26/5/25 15:00, Philippe Mathieu-Daudé wrote:
> Only add default devices checking defaults_enabled().
> Remove the unused usb_disabled field in MachineState.
> 
> Based-on: <20250526112346.48744-1-philmd@linaro.org>
>            "hw/ppc: Fix --without-default-devices build"
> 
> Philippe Mathieu-Daudé (3):
>    hw/ppc/spapr: Only create default devices when requested
>    hw/ppc/mac_newworld: Only create default devices when requested
>    hw/boards: Remove MachineState::usb_disabled field
> 
>   include/hw/boards.h   | 1 -
>   hw/core/machine.c     | 1 -
>   hw/ppc/mac_newworld.c | 3 +--
>   hw/ppc/spapr.c        | 3 +--
>   4 files changed, 2 insertions(+), 6 deletions(-)
> 


