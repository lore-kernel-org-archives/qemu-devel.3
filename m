Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69941C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83Eo-0000fR-VY; Thu, 24 Apr 2025 16:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83Ee-0000et-IW
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:31:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83Ec-0005wv-Ge
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:31:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so11062025e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526706; x=1746131506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UXThcD0mbAJuejklinjebsYJPuXIYTdEvO6fgMioKJU=;
 b=iEi5aO+Vkh4+JQ20FxsMYwbzNJMU3F2tcCwLpEwdMHQp8OlyOOQhPIpmbhOAb7o0rp
 KERfLIZonP/25xg2azmgBq/m1bYES3kXHjDlW5Adm0sjGfFPOCPm5JxeAl9IR1wl/2WA
 TJo3t0msTSdDYkBIh09bk7GVEzU6RAAj0oZNwZu2itxIHaGfO9AOArBVrU1ekrTNvxpF
 J8rEF5H4wtlbgkGJbU4FHFiwCxVTTZdNqaKmLlxf84XUVKvp3R6t+ZhlDDIKe6VzljpE
 OXiwZ2ILRMSWHJrNIiJD/JD01fBDv+/sI1ec5vCRmUu75x3c0QeNu3A4pCSSK/w1kcZW
 k2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526706; x=1746131506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UXThcD0mbAJuejklinjebsYJPuXIYTdEvO6fgMioKJU=;
 b=lahdsa+yRnENZaFVIwWH2lbq0V7itVOnJQLY7K3KKbyLupdexUEUhk8K1fjnVmBv3+
 d/lBpeSzSJPKoIhkiJy1ekCgVbMDgmaFdkcLhDhSI9eDSeCorUIWUvkVcCwqZaSir10D
 YA5znd6NobURrHs+y2Bb1ZcuW8SbMYACtaGzs+fpSi0nNfT+ZWEVqM+LwBVPuTiS9noz
 18xr4sMeL9hvHnWdBIYUG+i3wkNL2c6NTV3thdxEK4yr56pzQiGOSCdikhYgo2UkHXEA
 eUd8AAzLE95t5huGWOpcaOrB++QEYSGGf8IMI0s+vWf98nEdHw/5t0Vn6V5+eyEe3v8E
 p4Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9IiX2fwWMK7StcLoqqeRID7vFLg8HgoFlOAm+yTMruBbRtWWOpPpv/6OGdI/QZ8fo5NeJA/I14P4E@nongnu.org
X-Gm-Message-State: AOJu0YwkE/WkOYrD7meaoz2O6IG7wv0VTuozY8cqJpo5dYk9JWm2O2PA
 VnrGoKXyMn9zK93RQukBQvPeYlfyNk0lBux/9G/v7RDznzaJ7vItBmBGi8E0Gss=
X-Gm-Gg: ASbGncsMFCjaOfyOOB+WMwheWMDj4ULJlrzwtxeEo55c1n7nSrp6R1oXmTxGmyuEfsD
 qZ2ybPcl+q+UW3mK74At8dpOlCm5zjlpWlasfysMte+R2bg5a7yIZnTX7M0KuRyAinrp075xLa/
 DNysOqA1T8Vd7qTTbCKAXuJngVdB/g0DVolV21gNqebw2O/KOnh6dw5In/fFS6hRWcsB9Oj+ngt
 qHoASaTiEl/4hhKXiyfOgMHpvzqVVJW8vsK3lpL8t2WSeZ5uPWf/m2JQTsv1zj7DaDFcV3rPkvP
 zKbze4uiQ9HgCzoUPbNtLsRrRPgCzMUuUmXOS42X8EBrVnWH9TyDkIFQLdEn19MJ1QS+sQiD6w/
 RlUxB2AOg
X-Google-Smtp-Source: AGHT+IHsGpoWfJCiuKkzQy4iEgGqU3T6HoDlkuDs3lpZ947993+ze5iOUFxRE7+eO9gBwOMjl4IRFA==
X-Received: by 2002:a5d:5f8a:0:b0:39e:faf8:fefc with SMTP id
 ffacd0b85a97d-3a072bb4903mr599798f8f.47.1745526706613; 
 Thu, 24 Apr 2025 13:31:46 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4641csm252073f8f.80.2025.04.24.13.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 13:31:46 -0700 (PDT)
Message-ID: <2915e5a9-1fca-4876-b815-7ae2a776607e@linaro.org>
Date: Thu, 24 Apr 2025 22:31:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] qapi: make all generated files common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <20250424183350.1798746-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424183350.1798746-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 24/4/25 20:33, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qapi/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qapi/meson.build b/qapi/meson.build
> index ba9380d3f03..58ca8caee12 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -144,7 +144,7 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
>     if output.endswith('.trace-events')
>       qapi_trace_events += qapi_files[i]
>     endif
> -  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
> +  system_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])

      system_ss.add(qapi_files[i])

>     i = i + 1
>   endforeach
>   


