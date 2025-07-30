Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECA2C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 06:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugzxC-0005Yq-ML; Wed, 30 Jul 2025 02:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzx9-0005Tf-2n
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:06:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzx7-0007P0-99
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:06:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso4488028b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753855571; x=1754460371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/3GUL9XldBabalYIhI1YNtpqmg005bmPwrwL4S8Mi4o=;
 b=Pvl4N6p+1Rj+w0kTyMeG4teUkC6YTwpxQUCplFed7x4a6K2/mKYSSwNMujGbUEBWIu
 c0wa+cYgs7oeKSOGcxdSh8jvfGd+wJS9UtJ4RX9uRfVL5A7Tj/d8r42AN/ObfO4GStvD
 neMbzG+owNPTaWBpfpoOP48Y+lrdcAFu4/ZaPVIHUqhQBdtddRXUgw+trWOof/N5mDOJ
 bw1QvPzPxRBJSfEoMmw7SvTrxqjpAulOkcI0QsG1A/nW/eme6GLDzjV2KX2kNeHVAeQL
 ouT6irVaPHr/oF8mknn/0zL5cdVKOzDNpc007XMSH66vQUHmkRIM24KtQnDX9e/1ndWt
 xHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753855571; x=1754460371;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3GUL9XldBabalYIhI1YNtpqmg005bmPwrwL4S8Mi4o=;
 b=d75l0HIxltkH4dfF3lbWKPbdbbfT/aZF7jJEvnhircF0uXnVlxpplMleoMoDEiqnoX
 JA1iIfN+0kpEaTPViCtO0HlB8K9yofaa3NF8j1XfdA4hdwtdxDiylK1pfQp/3cA1aUS8
 50F+gGAfXP0ODdjSMJeEL3v55SGQhBoexLp+JnH5cmBm5IfRT6jLlN4qa86SIIi3cK8I
 BAv54OSKu6vs1CxCaHoQfy0kHkEnn8pmGjUKUvPE1IGQ9BQpKGiHShkAqLLXGk13mWB/
 OLfYBvvSPmQa36WPJ6VPzNd7mN+eHmBTJTNdUfJlLu3CBZqtd+Vq4jF2rVynuFopyxoH
 OFLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW4lnfAa+KadmLzn6IvcmwYOnh2mI7Xcyhdk8QGqhHWZx7SZWNcJkCWN0VYWtEv6Z4J/rmJNRy02Ho@nongnu.org
X-Gm-Message-State: AOJu0YypP5iVi2f9xcBrvjYA8/lKFaDUmfZw5S5ifMeKouCm7ZEfP3E/
 8EvzQhXLhYcjLlJBzVGJMfX+Dmpu53tBqGCBMxfu8oTuq/xwXVSdJ+iHjXjQgBd4JqFVMuH+juM
 Brk4m
X-Gm-Gg: ASbGncueFyUqi6Z4r98UmOyORWFjp20hm7UrurY7/VoSibNle1foBq5ZHl6djq4KI7d
 Xh/mj2QJZGFQscZfSyKDiZXvACx19Se/0hxgCBmQIkZIaghxQI9ULWxhJ5gTiZ7jjci+2UOB4dC
 YRdkRuSa5RPQOHFRd1cQOIE3ve9SE56C2n4zM215TfaKUMn2hoJtlnCLrt1zOhx571RpWCoOrZw
 Lv+ItResrV66hdFE44bvwRUL0TbHXjOobmmepE1G+0cWU3uUNcJiJr6diL30+Tu3hmJlnlgEDjn
 /sLk76b+RPH7bULMjhXXUc3FN3OZfUEiCUFJ8iqrnTBbzoG4pplWvUNiuvj4Xzq/ML9BNMhhBWx
 Nks+oWZg+VXn2Q09ZvpvNKqVX/sZOUqQMzj5fxMv995fmho3kNRhcCQTHQkk0ltlkVKMmyFTAvu
 Kljg==
X-Google-Smtp-Source: AGHT+IG8eXAYO7xsxw6iW10dipjVRAXILgYXYDuqqNzuvqRoC+LqsFgcaISppw689vVcph3NUWVubA==
X-Received: by 2002:a05:6a21:33a0:b0:23d:491b:76a6 with SMTP id
 adf61e73a8af0-23dc0d60acamr3188471637.20.1753855571437; 
 Tue, 29 Jul 2025 23:06:11 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f67a5a0sm8314033a12.32.2025.07.29.23.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 23:06:10 -0700 (PDT)
Message-ID: <bc5d8047-e816-4550-a7e7-9c0803f8af04@linaro.org>
Date: Tue, 29 Jul 2025 20:06:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/19] target/loongarch: Use MMUContext in
 loongarch_map_address()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-13-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030202.3425934-13-maobibo@loongson.cn>
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

On 7/29/25 17:01, Bibo Mao wrote:
> With function loongarch_map_address(), parameter MMUContext is added
> and remove parameter address, prot and address.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

