Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7445EC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TBQ-0000BX-SV; Thu, 17 Apr 2025 13:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TBL-0008Uy-5I
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:37:48 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TBF-0002L3-C1
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:37:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso1063773b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911459; x=1745516259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Ay+9aka7XPzdlU2sPlv175zu/wtHNtMvUoE879WNLQ=;
 b=UYrIColxE4z1mW6533H7wYFWC2d4C8GoyxMFDCFexbEdisXQ4Uo9FgXuM32Sl4QKJa
 9jL+gI8HHBr6S6sZuWnH4bn9+z7FZOho40CjiPdhDuljDKrv5wNHszPjlax544Fy+a1e
 rEowsMZg8aW2ey+lgUdUcXcDZqI3NXuZoK4gWZ3mqr4crgo3X8zx9HhWQT/cch/VPPRj
 Hz1G6s/2k1A9+nhBVc1JkuAzYYR85EP+yvYwjNJLR6GKzcimqeUfN0U4n3Eo8PJx5IjU
 +HFg/YvPt5rsGPQQOxhfIOeBKSFXCHTHPo6/rJEYb0PecCFT3s+5xyC35ddQW7l3c6Yw
 U7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911459; x=1745516259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Ay+9aka7XPzdlU2sPlv175zu/wtHNtMvUoE879WNLQ=;
 b=iY1nOokAswHxKu8K+zCwq9JsVl7zaaLW5NY/Y6rtboMEfgxDdXqvALaalpQsy4wI0h
 yUpJhK/D3c1Qkmb++ikmocRwRjz0Lqo62nFS3XBJi3HGwoHLEP0Uzaj2n5GLcGfk98JB
 7JVB7v4PdnYkX24NdyynFlQhvG5Itn5N14TYJkMTIjjUmC4ms1F/1eEmG/cexikauTKl
 TDrzZY3sgKiTzgG1z6/d3klcsIGBo8ancynvMIfDzK8721lVd5mdiMvRFm2XlNMH/qyR
 j2lQz/tTu4aRRtgknL5DkXqUaXpZ9tcwkNIzpE4ZG8fyT4p6Mmm04dP/dDV1DLrg8gXM
 aUNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfPyrrTPpZR4MW8c/xgZkylAP7LB3TwQYmHKYhtUc0C1l2cDJkw5laa52Vc+dY3RjnAfEzR+HXP+w2@nongnu.org
X-Gm-Message-State: AOJu0YzU3MEr4tV7jeh39bXoyd+azH6jw5OK2gOw6OsglSPitL7i4lte
 ByWYZT/W7zXv5USRLEGf+YWjovRVtWTjlE5qSC2+P8zKeJYpAFnijSFYKWoCtFg=
X-Gm-Gg: ASbGncuNdV+Zft/LFMyXryul8jOEYTgvOcZuWXmAKKaOvUIWG5K/wYjTfIM4JF/zpj8
 EkV8CEPBG+8TCiBond9cRZiI0PFG9tMAqZqjLzhB4Dy2ev3LDacFpyrwjxxVdee6yWEZSygvhfV
 GBWIMm5mHuLBQwO7k0szKxQccfjTEqobNhuiasHWZRnYV4RFPFus0B2YH54TwXT8m3wRUQkFl9T
 ldbJi4nvBaUyKV2w0PvtKR1GYQkuO2uPIWB0SgBLl6NramLd5/pI4Njfhp1d4lLzIvjMX0rIKS1
 j1BRzRigx/aZ52r56yp+M/M3Lu3R/wntxXtK2kUA4K9Mh1mi5EX2
X-Google-Smtp-Source: AGHT+IFdrBe1lnfd9q0YgF4q7x7tKJwbj2EjEgneU12I1+wYlrOZt1yNJDQjnSpLu8qwIcG0KerkMA==
X-Received: by 2002:a05:6a20:c892:b0:1f5:83da:2f9f with SMTP id
 adf61e73a8af0-203b3e9d98cmr9712531637.12.1744911458868; 
 Thu, 17 Apr 2025 10:37:38 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db12713c3sm129065a12.9.2025.04.17.10.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:37:38 -0700 (PDT)
Message-ID: <59d171d6-ea4e-4046-819b-b107be3bad7d@linaro.org>
Date: Thu, 17 Apr 2025 14:37:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 12/13] microvm: enable suspend
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204446.3032-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204446.3032-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
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

Hi Annie,

On 4/11/25 17:44, Annie Li wrote:
> The function qemu_wakeup_suspend_enabled combines the suspend
> and wakeup together. However, the microvm doesn't support
> wakeup yet. Suspend is enabled here, but wakeup doesn't
> actually work for microvm now.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/i386/microvm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index eba33c4365..da5d4126e5 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -489,6 +489,7 @@ static void microvm_machine_state_init(MachineState *machine)
>       qemu_add_machine_init_done_notifier(&mms->machine_done);
>       mms->powerdown_req.notify = microvm_powerdown_req;
>       qemu_register_powerdown_notifier(&mms->powerdown_req);
> +    qemu_register_wakeup_support();
>   
>       microvm_memory_init(mms);
>   

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

