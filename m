Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88091C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCx1P-0005HO-V5; Fri, 31 May 2024 03:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCx1O-0005HE-HY
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:49:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCx1N-0007D3-3B
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:49:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35dc0472b7eso1663457f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717141791; x=1717746591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IxWT98FX33Ci8AsbuFBN+P2ik3CLtyNIhuKVGHEvI74=;
 b=ANC5IbWiHMnjaodiwCFjFri601WXkvsg0TRpPIh/y/hbxHcc6yHb2S7AcQbYOJYJAo
 U5YEJuh5oKpsRl6CztskwIYdHa0IQzISBoEFXTmaOoKMHJEcKc7n5ZinvkFwAibDwpZx
 BYvsm0WmH+2Mt52NT56D7l/52ST/xhWTAF+9c7srnzKXAR26UdEsb+C7KQXQiR8Y/+NB
 fyrWxyAZL3EN1MfjoTeZxwhRql8GSULHFTGlfTEbWx+iXMkxIBZlbcoXkk52X9uhqxjk
 ft8ZjWskWCDZ6opI6CAS5r3HREDjkGqTNPTXq93roh360Tb+jWggKu6OG67+vU9tTaot
 xWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717141791; x=1717746591;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IxWT98FX33Ci8AsbuFBN+P2ik3CLtyNIhuKVGHEvI74=;
 b=N4POetb5o/QRdyDm2zy3kxIf/+ybOXb+rkdHOLWKOEES4ipG0LK7rYsLtyDAIS5crm
 ZpszjwiHuL+hVw96BJAWoYiit48DjE3XIzUF+Nu3HLmCazADmNo7eZI7RuoQ+WYS6JOs
 oVM9n8GqsLSxA404gNEouugpt/atf/rQzz+K7t0oRjgHhJUy2/TG1zhV7XP8eMkxp+2S
 3M82CsYhR6IJ0uv6CnKjQHLZLL2ClIgc1WTh3KnoqQvjcubw4HC03KzwSHlOJpf9THDI
 t44Ve0fOPM7F9ew3wJGda+bzT0W40nfiyGh3Jgd3auITT4dZ76lKIcD9wPreKrs6O7/z
 SDQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs3Hz4hOIRoljsCzc+IjSNI6mfTsQVzMMI6FVpAKfdsYroWDZxLvLz+5CYaC/JYiJZ5TKFyC4AAhntm/92ngzygHQmMLE=
X-Gm-Message-State: AOJu0Yxma1rMU61zTufAF7EDzAdMPhKjFoQxxYE2JNajc4BCciyMsrm0
 t0bgf5KQ1S5ATsHzuZJj3xbJLsA4swY7dsLWzYG6LT+etmmEPk1aVpn2jvk41eA=
X-Google-Smtp-Source: AGHT+IE+Q17njyCiRWg4+vNi8bRwOep6/C6YslF6gdDYjtor7Jze//SkWin5u68SHFUr1QOThQk8Eg==
X-Received: by 2002:a5d:6d05:0:b0:356:c47a:87de with SMTP id
 ffacd0b85a97d-35e0f25e206mr616987f8f.8.1717141791094; 
 Fri, 31 May 2024 00:49:51 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062edbcsm1223055f8f.84.2024.05.31.00.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:49:50 -0700 (PDT)
Message-ID: <89aee12f-35b1-4517-ab0b-6677bf5512ff@linaro.org>
Date: Fri, 31 May 2024 09:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] backends/hostmem: Report error on qemu_madvise()
 failures
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, imammedo@redhat.com
References: <cover.1717140354.git.mprivozn@redhat.com>
 <3341689328d280183062a8fcde006468346ecf1d.1717140354.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3341689328d280183062a8fcde006468346ecf1d.1717140354.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/5/24 09:28, Michal Privoznik wrote:
> If user sets .merge or .dump attributes qemu_madvise() is called
> with corresponding advice. But it is never checked for failure
> which may mislead users into thinking the attribute is set
> correctly. Report an appropriate error.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   backends/hostmem.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


