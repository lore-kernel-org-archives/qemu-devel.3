Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD97BE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYz9-0003TR-PT; Fri, 06 Dec 2024 09:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJYz7-0003T5-NK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:07:09 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJYz6-0005XZ-BF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:07:09 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ea52520327so1228909b6e.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733494027; x=1734098827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GY/cAPhW3/oqi/C1YCvCLavQZ4L9C4haY7O1gunfYt0=;
 b=JymKmm0O4gK4qS4QwBrCvvHUoxWPqvCAHpSLeTrsN9T5aBSyyoU1YQdX5CRcQGbHpE
 5XAika0q+/7vBYcEn0DVh79QTg3omjFvV2nypZoR4SWGH1b88En00UAgB6MDpGutAqtb
 zQRycP1lmlREM1TVWyRaZPr/OwsI4Er730LJbpB3qYp9SwLhImzGApnXMVm0yNaxatnw
 5wSp4u5mmGAksTxImd0ocz2+UEA3PH62S7uc5ctPcChtUkkDAk/s7QMIuPs0Meml5LdK
 B1axv2vyZjOff4DM55qJXvxEIOYHt4+tojscehxcITgHVqZthv0wUSduIW8NGeX89nt9
 wxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733494027; x=1734098827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GY/cAPhW3/oqi/C1YCvCLavQZ4L9C4haY7O1gunfYt0=;
 b=MbaP8muCC9kXK+Q+P3VRAmf+gKwghYPip87mKjd+dSMz5Zh+w8p9Lu0bfOnzTU6VJU
 l84kdUmAUzBB5Wrjzhy0j2Sqf7gPZro4j6kt027qYvN8AyqTt/N5FqCq8bjL6ltp2XRa
 nuo/xKgrY+K3OafjIO5er0zCUxe9UZgaeikZ+rgWZPxVajarfBdaBCwhLwmClL8K7o9X
 KKyAA/hWNklCePvhbQ4Z1v4TZ5HxtrjX2wuGRi9ujU9kXZWEGo/+1GbOntqGs8e6y0Ql
 QAMU4pr+V663twTDeK7V5FMoTCp2X86wzmVc4CAe3TmOoWLo/yrQUBahf9WxrHFVkPKX
 /PkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV4Rq3BBr9KwDY+eqN9hbjmo061sQEuBWpKob3h+d89Wdm1L60BzUpcPvZ7yiVLd4eOefMN5wyab8X@nongnu.org
X-Gm-Message-State: AOJu0YzaB+vaggkR2z3YvQCmCgXoCC6IwYe4h5yg4btdAoLqROSYUsYQ
 aepMXkA42K7xETyUFR1VfNPC8EQm8A4BWIFKkxjQhjnntleCnah7LF7/cFeyBWw=
X-Gm-Gg: ASbGncu8+ibAYaPkOgk3FSI/uVJS4Di6yjHZOXAhDn4W/iyfozjjRkqRcMCAK/zAXJ/
 Tg38CCbabrFwOtJIks9ax0RrT8YbZMV8766xK8q04R2fWIrHZ8F1dVXd6Kx8FbpMbH9fiw/VKzh
 j9a/F4tpJVQDTGQws+2x+RZD4Dpyna78gzWWmFF0cMCqULjUqdhWu2tNugzm0muOygrMOoLUeXu
 FAqek+gY2AfOKoKfImKwDaXNKTZMYHz0XcSv8KFv/DCOJAyHd6PCllE2T2JSmUTCDmRn61nv++i
 ELc+tYi6cj1ihtJJm5nqltAUz0PU
X-Google-Smtp-Source: AGHT+IGIBgVv2ZeXUAhczbXb9OvXaoDFvRRPfwwI2WHV+fzEur55jsIhXtYZVUdA58d4QGtpmXQKDg==
X-Received: by 2002:a05:6808:2f1a:b0:3e6:580b:d7d0 with SMTP id
 5614622812f47-3eb19ce346bmr3702232b6e.19.1733494026909; 
 Fri, 06 Dec 2024 06:07:06 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb07674c71sm749383b6e.5.2024.12.06.06.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 06:07:06 -0800 (PST)
Message-ID: <aa9dc46c-d99a-41c7-849a-aa9077d8ccda@linaro.org>
Date: Fri, 6 Dec 2024 08:07:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <edfa85a7-2963-46d8-8b02-4d22ec1aeee6@linaro.org>
 <Z1K4uc+XJIypkNaw@intel.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z1K4uc+XJIypkNaw@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 12/6/24 02:41, Zhao Liu wrote:
> BTW, may I ask why you favor bool over uint8_t, and is it because they
> are indeed just 0/1 as well? :)

Yes, exactly.  :-)


r~

