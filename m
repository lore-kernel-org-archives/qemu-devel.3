Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2B2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6xA4-00074L-60; Thu, 09 Oct 2025 16:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x9x-0006zV-Cw
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:22:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x9u-0007nh-D9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:22:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so123648f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760041360; x=1760646160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQrCik6YlkH2KQmaQufDJvH5ooAj07D854A632oiWpo=;
 b=fI06GbkfJEhFrBbVuw96k8Q2qM67hX3plNS0xp+eTDrKgHgrihN7u5dCUcu1fGmaJa
 JQ7LZTu7cYPZktXsDKwTTKr+XOfWquRR1iU9WvRLLAr8pJ3KVbx3wRC30AHAkQIvVDkV
 G1HzSUB3RkpxgyqV7ln0YxEmOjcWojkabTCsjIxvygYh0ZXKyQ0O1snL2Lmu8vdVj9j6
 VMZ3iYBK2Lxid/SZ1YiuJnbe8kkgT0ZIAZYHWElW+LHPyvCJ6FI56keOln8uZwhbqfSV
 q1DbLXhHZFRo74u+VBTPccFwDfEmKwKB7A4+WbLQHfyO8bYXlnCKkb/ne4613atgmsYn
 alvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760041360; x=1760646160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQrCik6YlkH2KQmaQufDJvH5ooAj07D854A632oiWpo=;
 b=QlCcTPjO9DXfGaaBQun/sd+pVWXK2CD+bNL3yjQt/OSiWPuI+Oj9ngD0nvQh9Zesq6
 GZ2oVflzKUfgrgsOj5Xq69DncbAb3PS5FLpzfN7snBc5a4Z0i4gwOO1HCZZfJc18Qbk9
 Ch0dRHW3ObCt+AjQnSrh7FnJjfGOF+08EZ1ETfsLZTraMhPkT1GiSbOTgfrlpw5ajbek
 77xgsVHw+h0rwoWmMRHQGFS6Z9N4vDQ6aM745BMxamqxsoxJeamqoqiPZ+XdWEQLDPNg
 2Qr5q+GM3Jizu5eavv56pUt66XGe1wvQNrJnG0wq7ZX6ESX1oc8NwtBVjKfsFHE+JeGg
 76nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlAkSWgBjURSyviH3u4isG+GzxSAHZwMDRUjb28Z1FWhDfNJr82V2ojHzKh0bjasDHe5p5velP6wAz@nongnu.org
X-Gm-Message-State: AOJu0YzGiPPAxqwUiBnBYviroylpcXkOzoAMscraaHFemAo+UxIDcYAG
 XDnEleMSssIE0ZTM+VIXKnnFM6E/23Ejk1KYIlUc2vmi0Lca9s673vu3F+69bD67ZYU=
X-Gm-Gg: ASbGncuqRqnQ4A4MnPLcKxJ8NxE+y0DwKgMRQJ74kNkJjqfOz1ZNsS9FDAUAgEf3IqK
 XrdFPDiCPrbXv7vBnF/AX87ae+EtDSA9ZX8nXh/uuFcVbvmsKf5pgdN4RAi/GoJPWBvb4Kl3u6q
 kqsGBrpjemGrOsOBLe/gWmENorpr1TZ2V49oMMvZZB4hVCaiemvLO4ObwFAwfettWeCSff59dDm
 hCtotUojuu0JUklN/njV5MJTBnUagRuxKEbe+RHiFMrjDi3HXsyeWaiB/vaAisf/wXn0YF6DF8T
 Fn5ahXege/ph+W3d3PgFtLSDhrNC26gLD740qEaJIWnqvWLK1VnQgRCdna7L7s9on/1rxUffQbw
 tfxXWI4ptFtG9PgbQBemZVak61P/dk1lKz32TI4eOltRe3LX9e/+XWPB6bFcT9OlZN1vqX7LYk7
 GQ7WF+o+RCKLzyhbFK5V/6DCJS2EPD
X-Google-Smtp-Source: AGHT+IFJM22AW3bm8qfUk3TpElk3yNVDwV07+/LqFCc/fqnzT7BGf2Rw/CQTYBRGOoGLhv2Uf8q/Qw==
X-Received: by 2002:a5d:588a:0:b0:3ec:4e41:fd86 with SMTP id
 ffacd0b85a97d-4267260e213mr5444219f8f.50.1760041360568; 
 Thu, 09 Oct 2025 13:22:40 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe74sm598894f8f.35.2025.10.09.13.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 13:22:39 -0700 (PDT)
Message-ID: <9173ed6e-c952-457a-9f6c-ab0e827199f7@linaro.org>
Date: Thu, 9 Oct 2025 22:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] linux-user/hexagon: Use an array for GPRs
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ale@rev.ng, anjo@rev.ng, marco.liebel@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
 <20251009195943.438454-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251009195943.438454-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

On 9/10/25 21:59, Brian Cain wrote:
> Link: https://lore.kernel.org/qemu-devel/023e01dc389c$faf84320$f0e8c960$@gmail.com/
> Suggested-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   linux-user/hexagon/signal.c | 79 ++++---------------------------------
>   1 file changed, 7 insertions(+), 72 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


