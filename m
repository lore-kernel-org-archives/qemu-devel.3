Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12718CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utM7P-000348-5u; Tue, 02 Sep 2025 04:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utM7L-00030D-Gs
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:11:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utM7J-00050Y-MO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:11:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d75aso858418f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756800708; x=1757405508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=96NyaQ7c1yEf9RnVJ0Lpaiev7GymLJQLQiEW2+lDAYg=;
 b=H9NyP8VQB+wuWsayqes4MucLMze+96xsxAjcBpPcb1vG7J00+6Oe3mWYwdxdGVBoHp
 gaVCFNGBk36ZEVRjlaW9VBvR4ivLa6GI/U8ecHKlLfq81y6GlFIa5EJadYvw5ulk731M
 KVQKzmjK2uZzDHvVIuiWz1Zrtcv8dDaaZUxXlp6vKnU0U1jTi6kaXSImEAyRZ5biGz/z
 otYN0uLgdQYtaBh/t7DNyARRxuwLRI4nC8K1kEvZbScgIW8RFyPZhTzj0Lsg60THTLlF
 2v4IhE/IRzRgKv6dcivR0cRyloGjiWyJapWaK9QKywSqjiQx6DrFDyzmImriFxcUQAWh
 fa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756800708; x=1757405508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=96NyaQ7c1yEf9RnVJ0Lpaiev7GymLJQLQiEW2+lDAYg=;
 b=ndV9pVXGwX1hTHKuDnXqdl9dl1+OfefOBNHwSPjP5XlHTHraP/OcAZPH320TS4NIuf
 xCDzmYNMiJExhL9NKQpwPO9V0FbTCiTRI2b4Ig2qR2/xR1UagSHtn9OksiR1iiTmcR0H
 MjRwH23fXuBbpfaZucJ70MMKdghm4o/RLTRf/mkQ/hAfiMNQlvel2ZImnPaQR/jzxVS+
 e/jC0/15dGsrMSlammMRyHi32uVI3hb0KXneydu+/8LC2bob97sjK0nxfsMaxluX84qc
 pspNAnlNnsdM34/BpLwr7liZkgIf1OQuy8e2wHlcmKI4pkVFsyf5bhtKqm1mhgtDCFHp
 bHSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXVSMI9aGDe1h0bTrrdhuXoX+k9ciWAHa/r83vayutyGF3D/UY83ssfAtFYnXACLQS9oGqTBNFgAJE@nongnu.org
X-Gm-Message-State: AOJu0YxdtIttb0Gemz7rwF3EVirsE8wviCYh2xv+fVoUtJAbpfStGAf+
 WqVA+AriSftbKWla6D6zlXp/Pyt946X/ck+1hQwh2oyhFpuR8GZCHZ2cIEuacgbW6dA=
X-Gm-Gg: ASbGnct+tNUxOHCnBD/69cLBIUaQga8yNOwRsVvPG4cpo53976ccc+Oc2V1DghGwOTC
 zxye0Sa8Z7+3Xa12lX6flTUKvn/JST49ViiEGJsq8I3/kMDThgqKEsPylNkXt+8iv47+oXz04Gi
 +aMUebSzRyMetTgrMtJFraXX7fCpr/X9oLLAm9HL/ZOZRPEUDwpEkq+7HM1rU7fzXQtQK/t9P67
 zhictaC/teZPu5a7Pymkr6u+3Z76WTMdha/zWW/OmMUKJ9PCkxrE4YwrC3Of9bbrqNs5Kd0PTfx
 lvheVx+q05vn6tad7/55p1wl+VkAmrkfWeR/8l9eIGpu3o960mdzvpwi7fUo2gRso3gBIoX/8uE
 /PduEuDOzmIXDdJTK8BIfmbsNqDbRkWi9Te468SBhScmFYW2IqIrRnC1BfBHZ4BVO4g==
X-Google-Smtp-Source: AGHT+IFtYuo501rOWzHAG3WBcBx28TbEipJ8VkSorn3M/OSsK1Etdy1/fw0vuR27Z8cLIZMl9qPwMg==
X-Received: by 2002:a05:6000:24c1:b0:3cb:bd66:da42 with SMTP id
 ffacd0b85a97d-3d1b0440a00mr9027272f8f.13.1756800707587; 
 Tue, 02 Sep 2025 01:11:47 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3db72983560sm50484f8f.1.2025.09.02.01.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 01:11:46 -0700 (PDT)
Message-ID: <67597ab9-7cff-461f-99ef-e291d9d7149e@linaro.org>
Date: Tue, 2 Sep 2025 10:11:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] hexagon system emulation v2, part 3/3
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ale@rev.ng, anjo@rev.ng, marco.liebel@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi,

On 2/9/25 05:49, Brian Cain wrote:
> As with parts 1, 2 - some of the changes requested have been made, but not
> all.
> 
> New features for part 3:
> - global registers device model
> - boot-serial-test qtest case
> 
> Issues not addressed with v2:
> * "Add l2vic interrupt controller" - DECLARE_SIMPLE_TYPE, bitops
>      - I might also push this and/or QTimer out of this series to simplify
>        things a bit.
> 
> Brian Cain (8):
>    hw/hexagon: Add globalreg model
>    hw/hexagon: Add global register tracing
>    hw/hexagon: Add machine configs for sysemu
>    hw/hexagon: Add v68, sa8775-cdsp0 defs
>    hw/hexagon: Modify "Standalone" symbols
>    target/hexagon: add build config for softmmu
>    hw/hexagon: Define hexagon "virt" machine
>    tests/qtest: Add hexagon boot-serial-test
> 
> Sid Manning (3):
>    hw/hexagon: Add support for cfgbase
>    hw/timer: Add QTimer device
>    hw/intc: Add l2vic interrupt controller

FYI I have tagged this series to review, but I might not have time the
following 3 weeks.
In doubt, please ping during last week of September to remind me ;)

