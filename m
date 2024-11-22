Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22E1E6918F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 19:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEZiO-0001N9-5R; Fri, 22 Nov 2024 14:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEZiM-0001Mg-Pt
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 14:53:14 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEZiL-0008LQ-Es
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 14:53:14 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5f06787eab7so1115409eaf.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 11:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732305190; x=1732909990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/TdhaA4cgmHWBvGWzYY3pi+v0OjOybIwBAljQPz8crs=;
 b=wHKvq9MfStVaHiY7g982aDwilbNujxFu5pTpTBYg81oUkNEs35wOGAreXqENkzmDW7
 JAlEc/uW+bTblYSOZXHhbQT90PDQGQ2FDLCGnIM59RQJeS+tm3TZnUe1w+3oFjrkoM7t
 w+tD2+DDOP/wdj+ZgugYfQTZEcexvL5iRp5CcO6K6iiD9R7XWSs4DshD/fUmYtwl98qK
 oglAlVVP3pijpEPWyh9W9VLG6ljkDAcJX4fomyov8G0vAOzeJp2jabbIOHnm9PuqVsUy
 oxwmGbVBY+rKRx/MpbXNPJot8L3s2u8hyLugtw3DgtYujI/4aGEgxzTRLoAPTZd82rPc
 r43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732305190; x=1732909990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TdhaA4cgmHWBvGWzYY3pi+v0OjOybIwBAljQPz8crs=;
 b=GJHot7n6KSs1TMbBkcZtgbSmMdWw8aCC/yCeEP0Stc/hGBIexIJxCKmZJTMoKjDm+F
 VVepXKgympEWQpVlKc5D2OHCd61PSEKFf1O9AN68TIfeuUdI5dlbbEZ29DLredBFQIIj
 ciIhtGbaqrd3W1Rr526zuqcvHtfANRIkrfrps9mUEIEzHoRKs6C0OX8mw00oFKtK/IRN
 7EkKJLllUKrvUWlIhQlnXe4W7hexKA+KPNPwEp7ifUumQvULM4drYJjSDjZVvJZ8hGK7
 l8hC6+2A6f7xBd8EiMj4wZrh+kXU92DbdaF4puvR47EjdlvPggMSxdu8dxTedYJfAGrX
 JcBA==
X-Gm-Message-State: AOJu0YykejXBpqNrVPTAGiKOUQTF1X9WekL7d0cEyGHvQB3yWiF1OXNe
 9pAGumQP14s/VPGVkW1qIMHkjwdahBn2SFtAK3I4RdoxMMz8LtkGrFKRls7tpBP95Q2TE8DZFvs
 PuJY=
X-Gm-Gg: ASbGnctqEsUCXVDj++D101FNAMq3Ietu8aZfcdLNfoV5OUxu44TfybG9doFxUzc6stk
 MYKR8atovOh/pn2D4qr/u5GJJBsSaoNWaDFkSRL4hZd4VntK+BVuaUTS8OeAuxQCUz2Rdx8H+/F
 UUF0r9JeSJ3m9xezQW4YKhvXCl81llLQs4j4m7tJRXB7GeeFoLinT3p/bnxdFOTVNJ1WEke3wHR
 HKovj8mnB72Yq5hpH2RWiXW2HRSouIQsjxBvAxeQKKoQeo5hJZSqExer5EmOk6rZg==
X-Google-Smtp-Source: AGHT+IGTCy1lyO0ueUy1jvtwkjYX3uYz4AQpRjPq6HQ0VtmTbMu+2WZMs+/3Y14JUlao0ODdZe3Jog==
X-Received: by 2002:a05:6830:6b0e:b0:716:a62d:a79a with SMTP id
 46e09a7af769-71c04cf0dd9mr4985991a34.29.1732305190484; 
 Fri, 22 Nov 2024 11:53:10 -0800 (PST)
Received: from [10.25.2.124] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c03759d13sm573256a34.12.2024.11.22.11.53.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 11:53:09 -0800 (PST)
Message-ID: <ef0bfcae-1682-4772-a9d3-018e12c93da4@linaro.org>
Date: Fri, 22 Nov 2024 13:31:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/39] plugins: add missing export for
 qemu_plugin_num_vcpus
To: qemu-devel@nongnu.org
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-36-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121165806.476008-36-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

On 11/21/24 10:58, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Fixes: 4a448b148ca ("plugins: add qemu_plugin_num_vcpus function")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20241112212622.3590693-2-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/qemu-plugin.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 622c9a0232..0fba36ae02 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -803,6 +803,7 @@ void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
>                                       qemu_plugin_udata_cb_t cb, void *userdata);
>   
>   /* returns how many vcpus were started at this point */
> +QEMU_PLUGIN_API
>   int qemu_plugin_num_vcpus(void);
>   
>   /**

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

