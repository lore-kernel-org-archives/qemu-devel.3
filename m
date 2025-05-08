Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD639C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzC9-0007it-LY; Thu, 08 May 2025 07:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzC7-0007ig-V9
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:13:40 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzC6-0002ww-BV
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:13:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7411f65811cso246788b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746702816; x=1747307616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZB/MUtPH+AoPuM5nhP8yeEw7cacwlRjZhkgYmkPIU88=;
 b=O3joKfT2YYW7nlgUfzlmZ3NhPkIF1QXmgUEWIt4Nzs2o8ttZOfsuCIScsq5Ua8FS9n
 uERu/zXiOfO+vtA2388VTZi1ICKFr8zb/TPCW1w+Rx+X+V54Vo9grF7QxVLxBPImHcDP
 Rnb1fGhyk9r2x0N4DPCghmvjjZO1TToGs18YQRml0GoPZSbyEW/N+8344GpvJDAKCfDF
 sH15+z8/WB8IEdy8XOTLn18TnKQNTEJKtPS8TK9gkmIIVO70JiiRcGUMjkBHUiPNfEX6
 zGpF5QcfkhYOj1yw4f7wihkn9MhlyCNa9iC/PUFv/DngYnugA5RRbuNACuoQadyGDlwj
 qU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746702816; x=1747307616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZB/MUtPH+AoPuM5nhP8yeEw7cacwlRjZhkgYmkPIU88=;
 b=THALp223mwRRzhjC/eHaftH4/iKMwDfPzlejFcXYXSPdJ3jI2yAcUx7ZcxQDeB+1Fp
 f/WjbNh4ABp05+KC2Esk46VN/cT6OmxLZuJDCyE9bB1Onsbk8uhGIAvjlJYkhhAldG81
 H7P/nplHyW4Ross/TWGb7Es07ft9w43KEV1eU4SLEB3HnDoRQFx5zg9AslOAkHpHpnqs
 LP9CIufFNqusmKoBkFRVHKJ27SnmjkjY8HSXoG8f/S00jQFUZ7n/wlLGvc0T60Yu+ql9
 yZ6v+8FrQ0pJNiwJzAz4vEp8LpcamwQKOPuauHheG2mblhThS6rSuAUP97pcol5GrT7F
 5TAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuNfAlb+/vhOdl0quseOPXj+Plk+0RFDwZ4dImbITA4niOyQjTIGBed9zYxQ3CZ3rkyhW7OX+VZO2O@nongnu.org
X-Gm-Message-State: AOJu0YxQB2gLLiDA9aIUTlBUrvxBUr8ralM8k0otBow//KnbBcnDgQLp
 uyMQiWkKaIVuEbvQ21/EbTXEt2tsrixQFdUshVx/RecWiqRskfDQ4/orFdIcXWU=
X-Gm-Gg: ASbGncvupcGD/lYTxVEgM3lbvQF/KzyPyZuE0gtfEIhfv+E7LaA0+V2fvXqlkqVps14
 yOmKfrjfOv2Jnyh3prGWQZn/Rt1R6KzevEL26H7O+u5W318Pc3+FXFKFFw1aUCvul00oy8Dx0vJ
 TA4ID1ovP8WjaAPhyE52Kt7IsZNK7txshZ/KqVccM/L/5ES4EH8zTqKAv8H2hAx52Jw/eJv4+cE
 EQ54M9ZRtCdSmhbYvItr4YxgwbLnkX67mC5VzKnMnZvtkUiqI5ilbmJP0gjIguoGXzsva7UpV+Y
 tQlSfTqvqM4rOOc+dRBXjUpAMvjpVg1NUSFLJDBvVlSp21A+TYkZAtZ5x25MK7a4irom4P4X4iV
 4UKuSsIYt
X-Google-Smtp-Source: AGHT+IHMbAlbFWxxenEateg2MMxzs6OoTsIxKV21hr6jnmdc21N8z8nJ7AW8raCNWe1pKQ8E/3x8Ug==
X-Received: by 2002:a05:6a00:279e:b0:736:4fe0:2661 with SMTP id
 d2e1a72fcca58-7409cf82c68mr9381791b3a.11.1746702816407; 
 Thu, 08 May 2025 04:13:36 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405c2e7596sm13119348b3a.147.2025.05.08.04.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:13:36 -0700 (PDT)
Message-ID: <81e5c29f-b373-437d-bddd-c82d786bc4a6@linaro.org>
Date: Thu, 8 May 2025 13:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: do not check supported TCG architecture if no
 emulators built
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250508095044.468069-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508095044.468069-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/5/25 11:50, Paolo Bonzini wrote:
> Errors about TCI are pointless if only tools are being built; suppress
> them even if the user did not specify --disable-tcg.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


