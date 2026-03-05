Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B24AEEF303
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy21Y-0007zA-VN; Thu, 05 Mar 2026 01:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vy21S-0007vi-5c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:17:23 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vy21Q-0002SR-QI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:17:21 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5675d609621so6854971e0c.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 22:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772691440; x=1773296240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04wSoPvEJvkTAiAgHbyNSYUJJM0mX/HXbO0rUhp706U=;
 b=DBTNqtunWhACZKzgxQzyhaAJPwCJIvBtrAvqjMvHXS7AUuZQ2/YrN0yL3pOYiX7kP4
 Lntrwfsifi0Ot7+XjPt24UyfKgGfkJ906a504I/l+Hwu+qtrv+U2N9Fff2HUOgr3MBcx
 vR7cPfV61keRHWAVZlzn/g45CvNYeiFiGbF7cw2hng8X98xX0HIwdrDbf0n5ahZiisim
 Wv7Oo3msPFgTDiX6Z8Z7xNF6gpmdxSDdn7RUZLV3lRZSRgTmaQu+IyDzLX+4e5dtMcht
 06Grj2Ga5tFLBcAidRaI2ABvRTpz+FbSrdATRCCVU5dy4q393V/Rbo0iewYy3Fri7yj9
 CEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772691440; x=1773296240;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=04wSoPvEJvkTAiAgHbyNSYUJJM0mX/HXbO0rUhp706U=;
 b=Amsc6T7Bhp4TH14zMqTOgeEH6WR7xbJjIOOz06rh5mUxQ/FW+CWVfZVlIx1xirTrWa
 H0UEx8G5L/9GiS62tEwcNoEZTloc/NEix57RKkOzKkAY3GAMtIscqaPLOGv2VvIrOovt
 hIXJOppcwmlcfariYXvG9MQHbXBDj5OMSWC0G9rlb9TkyrTz6oGGzwTU5lDzA5z3AO7r
 vH/1btY0VmAdzkBIKKH4iCB7NGhzX93AHgfvh8KYVlBAdkQy2X3Vvr6pidrQMosexwpt
 nH5ki1cJKx/1EpGr/3YGDwGn9BSGk+xpq5B9emWF3Nefcqzobjn7to+5UExnNTiON/19
 bvkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMm6rFpY0vK1WLmG5m2KiUp1BNzP/vcqsYwE665YHIXu+F9UvXVpyr62lDv5K0btucKlGgsskGsSut@nongnu.org
X-Gm-Message-State: AOJu0YzEl7ukv9DyNv89c49hC2Ke2pJUOizs2Y28ygpNZ33RXttTMVUk
 sbLpIqgcKNKVLZcbADshqiA5619034a4dcyxHXRnPBW9J6gqQq+CrCEWYIVKmzwUMoc=
X-Gm-Gg: ATEYQzzC4zUSct5vEjw3MvEWenA9Ksx7BdyHZUA8MZM2nlaqgBuoH1v+v/gVxYnN+fS
 J6tZk1Epi2wmST3a4nXTam8aSzWwx98t+b3rSUHPf2BemZtD8mouKxsf5eCiMRhT0F7EFynkHbB
 LyfOnxAYTCs3PbURSEZx8xrxqu8slrJkmwS0c5Y4nDQCt9ay9HI40XsrbmfyobCUgQ7L8Ycmkr2
 9Vr0Ni+Gdn0dyjb76p9JMOF750OH3RHWumHJrTbzTDU2vQZRFDVTaihodsCAmDlm6tM0I3O8swj
 iYM+q6owQunC6jI0afLMnezRTV8t/PqC8EXtqlNIYPqgJRBZMWl4moI9xanVvzqDPharYFe1Y6D
 zTJ5RHNcOIizHLAA69e2xXdtjsSj9HoPkEnEOADQWTHMwd/KoRmJqCwJOSyxRiCHdvpEnXLpy+x
 qg8YWuuXpjkRkv2M7zXn+jop+287ABfRy3
X-Received: by 2002:a05:6122:3c47:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56ae7765e96mr2463007e0c.10.1772691439618; 
 Wed, 04 Mar 2026 22:17:19 -0800 (PST)
Received: from [192.168.0.103] ([191.8.216.93])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94df645b877sm20240098241.8.2026.03.04.22.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 22:17:19 -0800 (PST)
Message-ID: <7575565a-89e1-4ff6-8e05-9c84c8682214@linaro.org>
Date: Thu, 5 Mar 2026 03:17:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 4/8] bios-tables-test: prepare to change ARM ACPI virt
 PPTT
To: Alireza Sanaee <alireza.sanaee@huawei.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com
References: <20260220141128.789-1-alireza.sanaee@huawei.com>
 <20260220141128.789-5-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260220141128.789-5-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa30.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alireza,

On 2/20/26 11:11, Alireza Sanaee wrote:
> Prepare to update `build_pptt` function to add cache description
> functionalities, thus add binaries in this patch.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..e84d6c6955 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,4 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/PPTT",
> +"tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/PPTT.topology",

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

