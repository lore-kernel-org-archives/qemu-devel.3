Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201EEC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYhG-00011r-Cn; Mon, 26 May 2025 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJYh3-0000z9-07
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:20:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJYgz-0007Kn-FD
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:20:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4c6c0a9c7so1526174f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748269239; x=1748874039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nMwp4QRNJ8OAGlpjifsAwGcs42ixDJ8dmMqqy9rPA/0=;
 b=ebCj8Uz44Zr+9Yv+vCrQveUMKrcmk8TERBLqo80x7DpGM4kuiY78wBh+4NVQHIcgtT
 PqgaXB0F2VGzRgGFyac8nlsNMxFZZyoTJ52BRksDxwyjuG8unqhaX1JG06dek/EDhXwv
 F9g/xyx1ETdTyiLkEEhO55Xcc4kqXgSrrP+T+oiWxClQalWhLyPxX5gTUOVvVMPaJTkz
 CBdZgFcjUhp8hVgm7YCcFEWpD831St7ujFNzT2mrov13H0GmXJEQ2BkGRiSOMzda6qff
 iQ5eZe4mWJLONRNKHasPyOQaCi1+sVsrX6IM+NxFdB81y+YQrgDlMTwtqo2wCPkVyWYS
 oYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269239; x=1748874039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nMwp4QRNJ8OAGlpjifsAwGcs42ixDJ8dmMqqy9rPA/0=;
 b=t5g9yJukQXzBUtFVpfVgGYEhcmfSxBp5bMd0TFuLxnTeNmyluqgg2CRDKgKLZz3aRV
 E8Q7zb4WX2DM1Z6f5EeQG8TsRF/7JtLADFp872uiYcVFjr207yBvJrgCMFSWIXK77VJz
 z7kiC8Gmwy5PPGbTRoiPOMtn4SnG5R/24utPx/oDrbLst5+WfJK980LN7Jkxw5kBBRz0
 5gM7/oPWngSYq8T+vWW5mlUuwckZL9O8kOlpD1y60bLMhonMhSe+GFHm2N4ExWT/GUQf
 XIRA6BtBi+TqceImKbCadn/qulXPo5oc9InYf/BT5BhBioqOV4oTb9R5utTapf7X/dqS
 /8HQ==
X-Gm-Message-State: AOJu0YyLi2mmxRudaizdf5wC5pNnP5YlREO/zyOjz16Oi36wvM8rdVh1
 0tX5PByOfHSUSf6eKG3czm4sDT2/yda57TrL/zk0mqhHpG3V7JcatEYtU91JLNoydk8=
X-Gm-Gg: ASbGnct/5QSwizNdIMmvwH3+UotHOl5JZR87mbprNPxml34Wg93frnOrpNf4gHMOg8z
 TFJq5NwAmOnj3/ALulQl8R7BGKLUbHMOtJTPMD/NXVhXiy3h5cqdqLv2PiVNbNyBRNrRrKkHu2b
 07ZqwmWYFtsNAvodLEuDRy3V+YbgBLQT1W017UIhznf4NEWc9ioqonYYX9Aon9bmGRBeRj2uoik
 BLE/XSE1j69OxaAp5s6M6q6f83NkixeiAjqsAKnvizW0TH0QjVgCLszVAsmxBZH6C7DrEn4puiF
 a4nDOiXSHDaGjjzFlsCfH6+ftxf2AVDQY1qa5AleLUDhxOGN3JlcOwyukMHyv0kuNF+9f/LpFPf
 SrAhd7nktneKPD9PyuWo=
X-Google-Smtp-Source: AGHT+IGmh0bgBhAjThk2cOUJAhEClFU4oZK0IE+frlpGoj5GEhUCHMaIxgwoNTOpnsASDwPf0iNlyQ==
X-Received: by 2002:a5d:64cb:0:b0:3a1:f564:cd9d with SMTP id
 ffacd0b85a97d-3a4cb4b8c18mr7422719f8f.36.1748269239265; 
 Mon, 26 May 2025 07:20:39 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4de9c9853sm961921f8f.27.2025.05.26.07.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 07:20:38 -0700 (PDT)
Message-ID: <649e4c91-fb4c-4cb2-9810-b1ee885ffea3@linaro.org>
Date: Mon, 26 May 2025 16:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/boards: Remove MachineState::usb_disabled field
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Alexander Graf <agraf@csgraf.de>,
 Markus Armbruster <armbru@redhat.com>
References: <20250526130006.49817-1-philmd@linaro.org>
 <1c9f8e9d-1ee6-b2d9-98d6-5640f59f0e4a@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1c9f8e9d-1ee6-b2d9-98d6-5640f59f0e4a@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 26/5/25 15:18, BALATON Zoltan wrote:
> On Mon, 26 May 2025, Philippe Mathieu-Daudé wrote:
>> Only add default devices checking defaults_enabled().
>> Remove the unused usb_disabled field in MachineState.
> 
> At least for Mac machines this may be more complex. I think there is a - 
> usb switch to enable/disable USB independently of defaults and due to 
> some bugs some MacOS versions may need this to boot so maybe it's used.

If the user asks -usb off, we shouldn't re-enable it in the shadow.

If a configuration isn't usable, we have to report a configuration
error, possibly providing hints about what should be fixed.

> 
> Regards,
> BALATON Zoltan
> 
>> Based-on: <20250526112346.48744-1-philmd@linaro.org>
>>          "hw/ppc: Fix --without-default-devices build"
>>
>> Philippe Mathieu-Daudé (3):
>>  hw/ppc/spapr: Only create default devices when requested
>>  hw/ppc/mac_newworld: Only create default devices when requested
>>  hw/boards: Remove MachineState::usb_disabled field
>>
>> include/hw/boards.h   | 1 -
>> hw/core/machine.c     | 1 -
>> hw/ppc/mac_newworld.c | 3 +--
>> hw/ppc/spapr.c        | 3 +--
>> 4 files changed, 2 insertions(+), 6 deletions(-)
>>
>>


