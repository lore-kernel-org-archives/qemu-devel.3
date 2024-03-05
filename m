Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA75FC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbhy-00010f-By; Tue, 05 Mar 2024 15:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbhw-0000z5-CB
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:48:16 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbhu-0002Fe-18
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:48:15 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-36517375cc6so16898835ab.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 12:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709671682; x=1710276482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wlEF3y37FY5TickhidoKfbi6EkE0mgKVaV6TKQXEq8=;
 b=hph8Fph/8pMwrcDtSRAsL5M/zmjYhnf3IKRaUhad3IUM0JNLobtKgEbFQOWmEOODp/
 o8jUQRQEvY82yq/eyq81Oupa1Ik8dtdhXFHiadeJq125dRbfCdExf23c9caVccitOcwF
 O+YlUISJsUcJtO85PscYU1Xwgb6DPDa5b2oihfulZ+9F4KLNzexzHw1ohap4dVQBcdsv
 A49s9R7PfZEvrA3jhh2rOl2zT41PFCcxs8rVu2Oku8kYD8+qtIWUtvuOf9Wa0gzVecZt
 yHjqmyhe2YAIenvG/vCujKULQOVbTcEqQ+bzaYGVt94CkAxLyJRGFCEUC+YF2WWn9xZk
 1BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709671682; x=1710276482;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wlEF3y37FY5TickhidoKfbi6EkE0mgKVaV6TKQXEq8=;
 b=OJoN2viK6c1sNR1IIHQi8UeuT2tj54dDnMS0Sk9viDzhX6yD+/pmS95pO/jF4t2yfk
 CSzjLTD/jh9tVzoI5PSCEXYm5an8lPcbYS1aqac5/k90XNY46M/oawasFimPPQzLsayX
 IFDXAZHFIs1tmvo6j3f8fhnYlZp9fvemnWRtZrc9S8MIs0PRNUX2fYf6rE3SETaEQ9ps
 jlIHSa/FhXdkoG18xsVzqVT/b8ZQAlMZrQgRwoApkISEmb9sUUvXL983J6AK2I+38NCI
 B8SSLJlXEH3kCqZ8gjaoS3DbGdn4xA7U6tYCByH3xR9Ium3et6wFQEqCtgPphIgPAsRn
 5F6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWciuJlYvBWR2VFnny2Mo6Sx3GkapisZvgVedErbbS//LGpgXhcP+o+oL5Dy3s5VuHk/D+Rq2vo/M5FEmQq09aMZdZQvDM=
X-Gm-Message-State: AOJu0YxwWbAkKaPqNco4qm4T6hf0I4IHogXWTjEpDuSm/xw+HdQBjvPb
 nH93kmPcPJhmrGZNZW9SSmRJgCwGZhmum7siMtxEtmeBQ8chDc+pWGFvZfjJyO4=
X-Google-Smtp-Source: AGHT+IE7l76U6OwT9e9bI1tCOpzUDeB0KI9r7HMKVAyTogZ3D87rAoSVAWRsxbpK8ykrdagXgCVpzg==
X-Received: by 2002:a05:6e02:1aaf:b0:365:117c:c957 with SMTP id
 l15-20020a056e021aaf00b00365117cc957mr16535325ilv.16.1709671682405; 
 Tue, 05 Mar 2024 12:48:02 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 q67-20020a634346000000b005dc49afed53sm9621106pga.55.2024.03.05.12.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 12:48:01 -0800 (PST)
Message-ID: <3b1de2bb-abc5-4ec8-bb35-7bbe0ed1027e@linaro.org>
Date: Tue, 5 Mar 2024 10:48:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/29] target/riscv: honour show_opcodes when disassembling
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
 <20240305121005.3528075-30-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305121005.3528075-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 3/5/24 02:10, Alex Bennée wrote:
> +    if (!info->show_opcodes) {

Inverted.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

