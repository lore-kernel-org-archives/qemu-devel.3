Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14020C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BAF-0005wR-JW; Wed, 15 May 2024 05:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7BAD-0005tL-9E
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:43:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7BAB-00026m-Is
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:43:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-420180b5838so20511835e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766185; x=1716370985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eYfCiVrp48YDjgh5bVg6h9xc6LBwA01N6tvBCTmiDF0=;
 b=zRmSQPH+cKW6VbmWku1TekVl+GvAIY3YKqpYIR8Bz/RaoV5qIehnWWjwauevQIkAPt
 i4awcke3WlGqITgIN+bEmEoAPxNAWmiXYSrTo39YGZa4RQKnDzei8lJ5Uztv83ZjnWnC
 Le0m1pDtRT5Y1GLqwDhRYNTPKSIqP4c72uw/uGwiNXQ+Wb5TPWZKabDjFVkZ4bw1Qxq8
 rxlS6DmlpQkGPmsPSGISN68hg6a2tYWDBTJRTruugs6nIdlstoICE+5ITE8arAJn1r9r
 ZXsGAEjjVpaSqePmopIO+p1ccssz8NvLt2jcoo5KhHHXlmAz1CMlQ2RPXnJFte99EuYp
 NfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766185; x=1716370985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eYfCiVrp48YDjgh5bVg6h9xc6LBwA01N6tvBCTmiDF0=;
 b=Z8Lacttb0CzqbvH83DJ0aioIZjyLEdDl2tv2pt3TtZZskZCZKG0CfHHqtoaE3NmWug
 i0Oxp6r+yaDL6+Ixwpro1kMR5jirz6q/q5KFeLE4kyMJDgRIuV8EeTUDr1CUp5Rha21R
 x2+jpYMcPlYJbHo0L1kwpR8cX55/3NSUz6Yn5ZhJspstYlMdoxxEzKiXGqJO7KDGZXcj
 gLX70QIKskVy88DDunjh6bBO+suTWwwI+A3xhe0ydgytrXEmQrjNusHSb1DePK6McCw5
 rX9CSlFnLuMrkzWcI3g9kpIofgFTy31volI5PnW+cUT0d1G5vnFD4AIyv5ngQv6JO0wl
 KMOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXusaiMX1yttA7bycUXx4F0buVWXYuIlCbNwEj2NNmd3o8T1ETZLOmcQvpd6q1tGqnt4B08axRlUyqje+4C4/+T3FC+6es=
X-Gm-Message-State: AOJu0YxbHAyzp1wr+JoVqeK14aErm2LdgztZIR+5+W0QT3rDRWx9OAHf
 ls7s7FLh4cQ4jbbltxAaRXfoQQIHiCrSSFMtwmGKix1GwZ8HtoDYdbaHvQUckv8=
X-Google-Smtp-Source: AGHT+IHkHHT6zVGscfFwesuBFVorANB7I4pbneSPJ5HRN5dM5iQa2eZCzTHHpnHdmxdqya6Z7aBjcA==
X-Received: by 2002:a05:600c:4690:b0:41a:c82c:1999 with SMTP id
 5b1f17b1804b1-41feaa30816mr172125065e9.9.1715766185044; 
 Wed, 15 May 2024 02:43:05 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce24efsm225207445e9.19.2024.05.15.02.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:43:04 -0700 (PDT)
Message-ID: <121a3f09-8f3d-4222-912a-661f90bf07c5@linaro.org>
Date: Wed, 15 May 2024 11:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] plugins: extract generate ptr for qemu_plugin_u64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
 <20240514174253.694591-5-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240514174253.694591-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 14/5/24 19:42, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Plugin operations can access a scoreboard. This function factorizes code
> generation for accessing entry associated to a given vcpu.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240502211522.346467-3-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


