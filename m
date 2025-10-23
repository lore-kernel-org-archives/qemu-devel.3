Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAABCCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBp76-00087s-KC; Thu, 23 Oct 2025 02:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBp74-00087G-7R
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:47:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBp72-0002eu-Ey
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:47:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so3384855e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761202069; x=1761806869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62Q2uk5f0k47hMfVnvACmPYV4/Cahi2vI5y31H1o+T0=;
 b=lqRG+lnSPwkvLJbj4mmB5mHIMcIuqgiwV3pxwbmNw2JIg5/9i14WnKbmHMkmstUl6H
 h7X1bLVBMiJdEvIWs8B9OduICcfAjRoT1AE+xQoYVZzQE3GlNNQATh1T2zaTlWeTcxlv
 1uB27g4Ujp0xBT1IQAv1qpgIfjNEqkf4PI/H1BJYDVNw1GIDC+AVmwTf8M5v513lVxbP
 dgKDoKHl7TTDf0Frtff+Isrzw4+Z4XLXNCu3pYj6CdF5RJq8zosO9CJ6AxpyZS9j2rha
 wITASjlsCd5/RtsR0QD+IG9A/DBtjG6C02Hdb81gK20Z133Vt9eLlq21bJ+3YKMbz1T8
 GlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761202069; x=1761806869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=62Q2uk5f0k47hMfVnvACmPYV4/Cahi2vI5y31H1o+T0=;
 b=d+RwTJPZo0BVcAXR4oEbSDEL0qM4z16rwDR7WccAiInTRJR69FwmwEnZdjNb+I6KGP
 bKweXKICcF6MhXXG9+IfIMb4alebS/+TX3Tf1tjhjdNkNaKN2wzZcWrDpwpnqyXkPta/
 q+F/h67ITw3myF0qMrcbrQ11Jt0FZPQBS84RkgPfRUcZmpyfps5Nag6YagWnU6rZlBj8
 On9iIcsPGb5WZxSmwAZaO2Z442EVKx08J+fzM/hMzc/1u3451AUtQM5SKNLm0aRSZJ1W
 2prsm4MIqvaz2zdUU+CDFAbyS9XFYsg1Y/WbSpD9D1XVKOJD88NkttwZK63PW0B26mvT
 lg5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx2QuQmuXR1HNznXQu52t9CWCzxQtAwfS0jjkTJE+GuAI13pfBZzlG8oBRASDVV1mApOJWNpSlDGzA@nongnu.org
X-Gm-Message-State: AOJu0YxqBosxc6KQTaqHwByYpN8LO+/h0/YFspCb8PafKoe9PJ71d+hM
 8gDxEuzO9/njllZN+IFo4wqHQew5R3DukLPpS9BNE+7NiaMkc74tFWxwSVy6DcPrugBSaufK/XG
 7GgB9KI4=
X-Gm-Gg: ASbGncv/6cnUIOtqTScgIc0cWNcMlOrpkh46MF3JROtn/Ghke1uZJ9DcpArh6OCMevx
 vdJ4nvje/nZzq34wvwz5KbzjJj1P9QQ7SokEr3h8/C7db4fjrXPFxnRCaOMA63xUjf1iPeKhxyW
 PtuAzYB/zb2mYwOMGhsvD6ihBokWXdFw+6X1GVfodPMSWUn2xG6fjhvTn2kMOmsoGLUX55/zlJd
 086X1TiN47S2t3cFrSr5syoPmeI54gaz7eaDjBtZKaJ+CLJyczXOTXGntHEbcee4536jRiUVtKt
 WooRL5i8YN7eqZaD5bk///wR0JKRbY+GUkq2uOoW9zd0L/QSok4NxIMaSeorWu38Xtdjxx1d4E2
 0mDrKiXElpjIf0YePSvBLdxP/RMmBEgJsVflQLOvd6yd3zTvhKz/08TQS4jPzWqyl/YPIYHlb34
 bsozSZljyuKwnAw/lsA5K4yWj3gVnf4WsQqrFMcVSyK7eruOEPArB8sQ==
X-Google-Smtp-Source: AGHT+IF5d8j1spEU/bW0QJb1k1CWhFdUWVEQCRLnGensKXfrH7NCAped6ekIM5x0djZ/7vyL/m8Law==
X-Received: by 2002:a05:600c:3494:b0:471:76f:80ed with SMTP id
 5b1f17b1804b1-47117934827mr167490655e9.41.1761202069263; 
 Wed, 22 Oct 2025 23:47:49 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342946sm78825685e9.10.2025.10.22.23.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:47:48 -0700 (PDT)
Message-ID: <5429d889-a47e-43f9-be48-403164d2882a@linaro.org>
Date: Thu, 23 Oct 2025 08:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] hw/ppc/pegasos2: Move PCI IRQ routing setup to a
 function
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <f5ff16a6933ab6e1f9e194d16ef85364ac3cf6df.1761176219.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f5ff16a6933ab6e1f9e194d16ef85364ac3cf6df.1761176219.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 23/10/25 02:06, BALATON Zoltan wrote:
> Collect steps of setting up PCI IRQ routing in one function.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 66 +++++++++++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


