Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D064C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRLt-0005Gp-Q8; Wed, 26 Jun 2024 08:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRLs-0005GT-H1
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:02:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRLq-0000xD-Sj
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 08:02:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-424adaa6ceeso5028115e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719403333; x=1720008133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ltow7ytQdvOPrZqOjowQbu5j0rIIyg2tUaYK4AdJlxo=;
 b=p/VW3THmmRti62nsHT+/olW3Phtxh5f3WhLJMCgMzHxcnDZpnbH0xEaFA7/rtgh5aH
 r80ZeyhgY0EaVaz5wnKKLk5hysRPcfL50erBR9VJ2HDyuRoa7pJ30ybev/rlQDhe+hTn
 lbgtBiYdFml1d54bHD8jOF0DXvtrzZXPDSEsbWYzv05V2802f4sMKTYprBIJCspl78Qm
 Upw3kLfL6+YTTmZ7tEvHwjreSd/7WWoviVUs72yv+c0IH1ZnNmu0wXX9QyBUqDiGKQWT
 6py/UxrgzcUolEw6EGUgZDxwmDOdm+mzZrO0j4iO2SR6AqOP94eZ1yz16knOwkSrzvn7
 DWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719403333; x=1720008133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ltow7ytQdvOPrZqOjowQbu5j0rIIyg2tUaYK4AdJlxo=;
 b=Esbr/oenHWzzhjjnsg2jzazLCE/lSqhDMDQQUomvvfp7pjayNtyPKUrH1+ql+Hoi/q
 HUdbtvyTOtX7C8zrTaRYRRMV0VhUS56D4pXw6yyWpyDtGz7Dr5KwioQ9e6eanBHRZLsO
 CN0tb3hm0hFbeBBgidIGSzIxiKQwaQN/qy2BYUnRTt4Buy5j42tPar+UUFGfZCOS4OQq
 bZPCX0wjb1JPkdYci/7aZtgSUnRyCLhnI11kDcz6Vp2+1mpnxTCn+2b4As8Zo2O1amVf
 4GmAYahF1NbM69wnRxiNayBAX0hX3gWcsyBtR/vEGQVGo0+N6Hq/aiej+AT36O3r4QNC
 q27Q==
X-Gm-Message-State: AOJu0Yz6W9/X0xzKbVjlqFWLO2FL9YIHp6gHOSZE/S/M7Y0Gu719oI0T
 MvxkJMUAsXtsMABF4GnHaL0kQ7rsNYOTcPvmPYM6TbJ/32iSUcCCYxllRwED8oo=
X-Google-Smtp-Source: AGHT+IGfOsHlBDCv90QPKZ0gnXF7c2MpiksUy0G3OXcIhw9a+8cWMyqI1wcf/8hX+LGD6tYJpXDYNg==
X-Received: by 2002:a5d:5591:0:b0:362:2111:4816 with SMTP id
 ffacd0b85a97d-366e95e7178mr7046195f8f.55.1719403332936; 
 Wed, 26 Jun 2024 05:02:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638f858fbsm15560449f8f.65.2024.06.26.05.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 05:02:12 -0700 (PDT)
Message-ID: <10d140df-1c80-457e-be6d-9b6bc299b056@linaro.org>
Date: Wed, 26 Jun 2024 14:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] spapr: Free stdout path
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-4-f3cc42302189@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240626-san-v1-4-f3cc42302189@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 26/6/24 13:06, Akihiko Odaki wrote:
> This suppresses LeakSanitizer warnings.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/ppc/spapr_vof.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


