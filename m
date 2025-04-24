Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7CFC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83np-0005Iz-E0; Thu, 24 Apr 2025 17:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83nn-0005Ik-Kr
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:08:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83nm-0001HM-0w
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:08:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so1389259b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745528888; x=1746133688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cunkuODgn6HcMGmVcEuAy0+e4wvI2wOirg1YE4LADAc=;
 b=GldeAnqWPj+6QWQC4IO/McnOtrNBKePP5q4Fdd8pNsvweOejuAFZoAB4kBmNQGgzHj
 JeYq3Evr7T1Srn9fGHzsJVNKMu6ELbaGNJYjxZZFG0MUypzR/e2F3mxN2116WHOUXo2y
 2eB2dPPkV1AhWqhuAzIKMmRlLZrwXrKbUMkVVyA8Md+qUeTaGNeQn63UmduI/RVZKYtd
 EhpXyDWdl7aUePb46FSdupvokWJj2wH2QdvCfXaosXi2FEIaK69jwAzy4v1C8wJWQcSL
 nNba2n2w/8moyIgeHNlqbuArmDOwHB9Dsc4dR6VflnWFOAr69hZ4e92wmIQ9/89NS0Kj
 Gq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745528888; x=1746133688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cunkuODgn6HcMGmVcEuAy0+e4wvI2wOirg1YE4LADAc=;
 b=rLqLlVHhuGfisKNntGtQI91jYa4+2JLcy8wbzp7roWQ5tOLgOxczwvDI7MFkZnVK7M
 HivuuvzJPBoQxaU6C5eZETG//mZjNBpa5DqqXdZG6K27dDuV3l0t8JXAx1yWxukDooMz
 dkDFc8+lrSIF62VD9+FoXd/3UPeB1etjqCrVCa1ma6B8dpGrh9/WhjSZCrF7Lfs+hdyc
 8vPfb8xX6sjdjg0uIuKnPczD/pBhz+FbR/F1y6mIWhlcNX9KhM7bmajjjumIpoHO9VdW
 rYsZRHUyJtE8YEipKlrqVWfnST6/+ll+DWfim8Lks/AjY8MAzUdONSReXixgD9y0hVon
 wuTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2bDIhjaedGEi70Oe0oNM60Mv0pUcwNLoVKQ0M2PjWstiKtUeg6wPu8Hsjys1PPjoZXrQFkZhc1ikC@nongnu.org
X-Gm-Message-State: AOJu0Yw7ju+r1N4CV1JLI/KZBpetSza4/fp6VYvEapCUwHpgoZ6Se4KV
 oUuXw9xzUn+LvM/jX4U+4jM4WP+L+saygvfxcfpm9YlbuQnKIUPvu4O5l6oMgDg=
X-Gm-Gg: ASbGncuIdNBUg9auYut9KHaHVrv+gW2CVodS6VIaHYndUpp/yShjlEyyh8H9U0Qu7GU
 KBzSUqSbEV715mkEvU4h8hCQljvsseSxx22XCxv6Pm0qb1A5nkIYlZWGbOrHs5ecPhHUbAuUSE3
 Uxp6jUY2dw6oOM0MMJtJUTAkTKoKffVVfecpfxX5hGeftNlZGYvDF/v5uAb4reNCIQqJXFt4p96
 3XVf/IuzeamCxj+XLBNcQWfrCUywdQz91ZNO/iyQiQtsdvlIoaKVoKqeUiM/k84sOlNKbxLa76h
 1qOTpz39TDZA3aaTBNLdJGhtiO5rD3nNGSMNaiaiqS9Upiy9kJVQgXqg4gjSInT41M3Cxk6hofj
 wiM4aAzvwXfU4kwkUGA==
X-Google-Smtp-Source: AGHT+IFrunSy9gWZEUK8t6N8sTPdNQDEL2j5yBTWFpN3srrnf6jTooPXxT0Cf+9Lqt2H4qOAfeTrCQ==
X-Received: by 2002:a05:6a00:328f:b0:736:a7e3:d4ab with SMTP id
 d2e1a72fcca58-73e32f5df9cmr1434964b3a.5.1745528888354; 
 Thu, 24 Apr 2025 14:08:08 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a409sm1874447b3a.117.2025.04.24.14.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 14:08:07 -0700 (PDT)
Message-ID: <bd559b67-3c57-4ea7-a938-8fa7ce5c5fd3@linaro.org>
Date: Thu, 24 Apr 2025 14:08:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] qapi: make all generated files common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com, berrange@redhat.com, peter.maydell@linaro.org,
 thuth@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <20250424183350.1798746-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250424183350.1798746-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/24/25 11:33, Pierrick Bouvier wrote:
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

You no longer need the conditional by moving to system_ss.

r~

