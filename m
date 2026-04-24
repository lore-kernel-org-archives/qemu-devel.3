Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36A7FED3F1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGKIS-0004yf-Vw; Fri, 24 Apr 2026 13:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGKIN-0004xv-0Q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 13:26:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGKIK-00022t-ST
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 13:26:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso61422915e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777051582; x=1777656382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ngp/pbv0tw1CybRWld/cPRbAx+/edxPPRAltYCT7RR0=;
 b=fzqyJTn9fqxnR7mQdPVK+wvR2DW9FQ2EInHty3+eBvYwurINm2TAOeKM13MR5/UkL3
 xu01MI/Hjn9TGl8jq0MZDXm0aaUD1I6JBrCbwtUQPqz2AphLrsB6PWDq3eKfNAB/b1GQ
 CnCk/OVDoD4o33tiTIb5F4p/W2in9tK/F2ifn+eSL2NaWl39MFVuDy3HroMR3ayCARGe
 fSOBC5zo4eEb/g1cbg4iop9F7dLN+E2w/Qs5ktMVTYd6AITr/MMkpstGNIQHPzlzNMzg
 /PpEC9oavE+MUM9JImzRoGnh2dWouI1MmbKKnnu/SrAGBl56uWJ/QGr8i7LZ89xzNr2G
 gxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777051582; x=1777656382;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ngp/pbv0tw1CybRWld/cPRbAx+/edxPPRAltYCT7RR0=;
 b=asa3vCaZNjHQlJEovqfr5JFYjkQsCEjQdHo2wQBvIUfrxG5e7Bg3zEsDtNzfZfEeiV
 KmCBT+ZAl+jaUn/P/r6nAraUVpPFKvw84GpjoZAlpo1THOyWOsr7K/DO9y0cnCPoo+C2
 hncG/HxodfFQi/h0tHEYxQMdqFAEEdxz1OjX2A65rEYwyFtToYcvSS9bebIKPNw3EFHJ
 7k2YVYhtEFc2KOzdHL23h2P8u2QSAR264x+DWZemw0RbDFTH7mv1SWq9/soYf2celPQE
 UgaKSS3PMmKag+V4HaitKT5qKFksKxmx6kIMBvhDivt6HFIi52OvlUBVv32iGusctB/+
 Z8jA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SEeFa+vC/PNMqhyITu2mHxaDvf8iEX6oxH/e9J3wI+p9R6nqI5bAURJgxNz0v1R5W2sQeNVJ5C7i4@nongnu.org
X-Gm-Message-State: AOJu0YwSYwiKHGQk8kECG1zNhAUW9w++OY8OEGlezvf3fY+xyuaKJsxK
 Yt2VE81Z0Aum8PEuTtwdqOFTsO8YpSvSaDJFy96Z7SfXYzzZHMc574VV2XUQOjlC9N0=
X-Gm-Gg: AeBDietLxF9iP9eLZEzlyimlaf0pAzdCFI+dG3+zwYfob0g6rwPucSU7isCjkgN2u7Q
 7f+ozCe48TuthCAOLo8I/HumwI6+NzqpDZ3X8OrVkX+LUgQV7U97eCNR4A91pUwv7/AFTfnweAl
 T8vjU/XCodC/dfytlBW2t33RFj7p39ERjBV54ooNffVYGcKYlYo+U7T0I4Wbkh3KpDba7mogUEB
 Yn5+9+Ej694YP56eVzGo1FWcvTktoQG7ozFx3UqInOxEZ1puKQiHcO0UFmmbFRVvnBYurqNKFgD
 nsqPjdtiTHD6lU/ok4vOsc1GZ5jBrQOBVOdDVT3dfOpGqyuaWUNTUjAqm4oKDxcvxtiCacs4k4B
 VOFXyK9UNAjHD+tMKSyOCU4Yq8JdngUHc6e+uakz63VA0ZDJCl5iW84a0W/vE3VagzVKUJ3igyj
 KzNnUApSEiM+Yaxdzg5cYJ+5UTE70sD7YD2ipyJTu5YbrP0CibzAD8YSMcpCF8/PUso9J6yvPEK
 8oe
X-Received: by 2002:a05:600c:8908:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48a58e16eb2mr161840295e9.19.1777051582224; 
 Fri, 24 Apr 2026 10:26:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a6124d7e7sm173970705e9.5.2026.04.24.10.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 10:26:21 -0700 (PDT)
Message-ID: <9febe685-6cb0-4c24-b601-b777ac7ef0ec@linaro.org>
Date: Fri, 24 Apr 2026 19:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/register: add register_array_get_owner
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org
References: <20260424155646.533334-1-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260424155646.533334-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 24/4/26 17:56, Luc Michel wrote:
> Add the register_array_get_owner function to the register API. This
> function can be used to retrieve the device owning the given
> RegisterInfoArray.
> 
> This was previously done inline by some devices.
> 5c6367bc1c8850f74812eeaaf87cff9911be58de modified the way register
> blocks are created and parented to the device. Since this is an
> implementation detail of the register API, it makes sense to have a
> function for this.
> 
> Use it in the Versal OSPI and Versal/ZynqMP eFuse models instead of
> tinkering with the API internals.
Fixes: 5c6367bc1c8 ("hw/core/register: add the REGISTER_ARRAY type")

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3421
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3422
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3423
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   include/hw/core/register.h        | 11 +++++++++++
>   hw/core/register.c                |  5 +++++
>   hw/nvram/xlnx-versal-efuse-ctrl.c |  4 ++--
>   hw/nvram/xlnx-zynqmp-efuse.c      |  4 ++--
>   hw/ssi/xlnx-versal-ospi.c         | 10 +++-------
>   5 files changed, 23 insertions(+), 11 deletions(-)


> diff --git a/hw/core/register.c b/hw/core/register.c
> index c3f3c936e70..99ca5e17758 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -320,10 +320,15 @@ static void register_array_finalize(Object *obj)
>       RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
>   
>       g_free(r_array->r);
>   }
>   
> +DeviceState *register_array_get_owner(const RegisterInfoArray *reg_array)
> +{
> +    return DEVICE(OBJECT(reg_array)->parent);

Odd, we have object_class_get_parent() but no object_get_parent().

> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


