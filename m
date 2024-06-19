Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6975C27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 16:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJy8x-0003Su-FN; Wed, 19 Jun 2024 12:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJy8v-0003RK-6N
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:26:41 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJy8t-0000EB-IY
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:26:40 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bc035a7ccso6984320e87.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718814397; x=1719419197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fKX2vAyP46bR8QE5GKAdhf2dbCPDWv+ngUAsl3G0gbU=;
 b=hj2ncaKQebziiT69abkXPuitB6uDN0Uv5kWB7YygCTH18CSHFCrWExyL/ZA4mavLAa
 cId5N6MoqVersnK4G/bF6kJAJNjsdWM8n5XqQzJo2qyd09M8oVaYnkuXwVAyR6VB9C0t
 nx8S8+Uzethv7F2MLgsMWwOqSLSnax66932nodEq8JK1LEYrqUYHZ6UnpTBlGxdp5rTt
 fahrH/JC4OO8W7QY7KQMRMz3oEWa0bjyW0ECt7m7bhTHgV5WMriaRxGM88nfl7Wtq58q
 jR+HIhh41Cnl9G7FKhcSIPTNGaJGNZ1/k+4f483mOsRoXS1Y6d20PmiL2kGSFCBFeCH9
 CvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718814397; x=1719419197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKX2vAyP46bR8QE5GKAdhf2dbCPDWv+ngUAsl3G0gbU=;
 b=g5pn7YZxRIeSs1HXAqel7g7a1GNLrhGSYkV46yxWoWpwwDRUmRLkrNgDQyFsU6Ikqi
 8wZJwDnZHy3vFAkOHVNvutCyLWPuZjm4TrEW2sx/de3sPBwnAtmVtepRz4q3tEHXW9u/
 JkVUAtyA8FsguD2ySpKFSofoZz3ZOAF3xJff6fL9nZkN+Ww9IkkaupH1/HhSlFIkdF1j
 R4/rjMWb9/EAYNpNcIHdj4OPQaFhhU8Xht3NuBu+ILhcBODRbUZw5tA3zCG3/u0wv8kY
 GdFOu79CHCxKDA9gJ+tU8UtRfAX0v7j24ajq+jao1kGkEvCNLPSQuLodzZt9fa8JTTWl
 ZRlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX2jlf5uyWI0ph3MhbEJU2AOzuuJdMmjQz2HxZIWgE9R7tSRwg62LJlmhJKBsvG0muSoYydRi9VYwkan0LVvjoCp/SK8M=
X-Gm-Message-State: AOJu0YxMnM9oirgvs/Tr0HrlloYh3UG39OarWMA7VesMjuCq18XUoapH
 zZKt9dbYMQjjKz7u/r+cg/KGzhqb+6CZyrS/atwZEPM40lvZpvCjL+WpBCv2niA=
X-Google-Smtp-Source: AGHT+IEJuZXUSuNiWYZehGa8Wo5z490ltR0vb5ZX3OeubXQO9bUIDl0QQebWRUpBBygXruyc1sK4Eg==
X-Received: by 2002:a05:6512:688:b0:52c:bd70:ac73 with SMTP id
 2adb3069b0e04-52ccaa58728mr1967877e87.5.1718814397380; 
 Wed, 19 Jun 2024 09:26:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2295sm17641657f8f.82.2024.06.19.09.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 09:26:36 -0700 (PDT)
Message-ID: <4ac16024-fcc4-46d6-9676-9269b9256a3b@linaro.org>
Date: Wed, 19 Jun 2024 18:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: detect --cpu=mipsisa64r6
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240619114616.251610-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240619114616.251610-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 19/6/24 13:46, Paolo Bonzini wrote:
> Treat it as a MIPS64 machine.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



