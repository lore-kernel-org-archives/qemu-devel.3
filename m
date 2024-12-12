Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FC5E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjB4-0005Fc-Cb; Thu, 12 Dec 2024 08:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLjAx-0005DY-Vi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:24:20 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLjAw-0004Qr-5q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:24:19 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f29db2614eso290976eaf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 05:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734009855; x=1734614655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=29mmsRSm8TeD9q2T3ImAftq+MizEVunVXW/xSDuuHrg=;
 b=qf5AuWavMfWLC124uEe+CJi8FWGhaOykf8AmmgkYXhmLv4SF+ZeusgsBVFMIGwm2lp
 P4fMpu6tGrNlxGxocYKZvxEIvB/Yto7o0+0zHnY1uWHczl9VDLfFHFz09azQu9g7LtzW
 ql9fTKi+adY2bkX25Ufq9VLDNcuTtqowKf0wvUPAzxsklNbZaOxCm+ODoqoDXsLHxojP
 pJ6wO/T4Z0JQtMP69v1ASLGhNdoophbzcjCNSCwaOWTGNg2OFvXE+phS97nl2PKRs8BT
 +fM89LjPzjLG5dHSgS5IFxDzZW/WRKs0S+4+NTuFoLvTE4p5tlvBx2UGZX5Potn+z7yR
 Oyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734009855; x=1734614655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29mmsRSm8TeD9q2T3ImAftq+MizEVunVXW/xSDuuHrg=;
 b=qdRRvetDBEruCZPOULjKfqmU/Ft2pS1eI1t1pe4ahNieKItLlcl6OTL79lTV235ESL
 CfOFkulESo+78zd3sV0QzUyR6tIE4gWMSSNrFMKqWlAyLaQZUNJBnHxB9f2shDboCutl
 loTzNcl0PbjYPX1DoqbzFhqsLTys5iZB+O7nz533g/+caKOR7aQbQZ15pZhk9S61kK29
 XhzoxfLTGhY/6bYQA1tYBneZHL0C2JPsT/ry9mzqGzNGbJ3cf0PGT6kPP4Ld7Vv8CQAe
 zAm01iAO8HAUE+fvesVwdRPsvTvwZX8AF4hiwowfRoXxe0+PWR5pypAWJ1fePZ2Mka3C
 OkcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+d94M9aZE0SI7CdaoAw9RrprP3aNd+NW7C1cZdC0BNh8a9e2BelLN+VbaaKIthTa4j0MGgjG29j43@nongnu.org
X-Gm-Message-State: AOJu0YwBKoA0MEB7o+uvYccRKiuWW1iz54Gn7Keho4xTTv4nzLZ3e/hF
 2O7PBM6Kg1toFoP2+WCL+s6vpsqZV7gKQtXeXBm981W/eF76xCUYbbGVmcOff4I=
X-Gm-Gg: ASbGncs0tGgYvx8RRQkyYQZmNKJmIHlVjjvdno3nTBgdExg5FFXdZJPXuG8/taNfi/f
 MqoMRCjYDg9ddqnZCdkDeIHp2q5i25w8mmsGvax4vHrSujUt9jgtr+sw/+CxxE4tXRRE4gn1nCJ
 5LqixhskYOGfHacvKw9W5rFmysIIPGFVJzQv+kj2kD9FRfbLODdUumlhsX5IAiii8klWjD8o94y
 h9ERwj1/aJeu2boIikhW4u7mQ+dxrNnYP+UM8wwU77/l9Bca+MIjex5m5bk4NI9DGh6P/E4OB2l
 VFVQ9huA3D+wOoYj+ri06delimqsz4WzJ54=
X-Google-Smtp-Source: AGHT+IFPqVbnQ3R4KX6tyMVVD3EPDfSKtODUJVHMQ0gnb+in4nwuxXJZiVARzaoeN2PpGNQx03NRTQ==
X-Received: by 2002:a05:6820:618:b0:5f2:bb17:f070 with SMTP id
 006d021491bc7-5f3245efa60mr80429eaf.3.1734009855471; 
 Thu, 12 Dec 2024 05:24:15 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e1adcf1a1sm751466a34.58.2024.12.12.05.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 05:24:15 -0800 (PST)
Message-ID: <46c6aee4-7e55-4cbb-9b0f-3776f7aed85b@linaro.org>
Date: Thu, 12 Dec 2024 07:24:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] semihosting/uaccess: Briefly document returned values
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241212115413.42109-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212115413.42109-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 12/12/24 05:54, Philippe Mathieu-Daudé wrote:
> Since it is not obvious the get/put_user*() methods
> can return an error, add brief docstrings about it.
> Also remind to use *unlock_user() when appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/semihosting/uaccess.h | 55 +++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

