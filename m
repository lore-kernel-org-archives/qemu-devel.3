Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DAFC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 07:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te7rg-0002WK-1b; Sat, 01 Feb 2025 02:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te7re-0002Vg-ON
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:24:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te7rd-0000U0-2k
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:24:26 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1439383f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 23:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738394663; x=1738999463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVIWAAGPh3yeV7XHo5tVG8m3QM4Mz3KwcYo1aDYfl/0=;
 b=NKSGKKUlDbK7XayOKWJMZWBzpgp+Nvd27TcN7O7+homox1r+EJxq+0RZY85y5KAjyp
 WGOrfuwR0xxyByWuMQOF04iF/Jzzpo03RVILR2zhe0HN6c149PedQv52ywykhFtjm5Sx
 t2z7S+iF7cJDO++IEaC+uMxeR0nSgvrxDAJlD9Ske7+BGlufNZwQiiurcgTy/Cw0fjfI
 8hajMptG0/EnCd+oKZvejFptY8RIBRxGJosj/UoccHwnDCDE8AZ1gQVdO1AxiIJflw8d
 6yTMJB3sH4pGIKEqxjv1ospozZ6bqL0AYtkkIUbiEBrOcXLa9yScZc8vYpXSukyW2Ga3
 jBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738394663; x=1738999463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVIWAAGPh3yeV7XHo5tVG8m3QM4Mz3KwcYo1aDYfl/0=;
 b=qosoKvowjkI/yN9bbqatsiSFxDgONVl8uPHgp+EBnJRZD9W0had98t/wUZiAGd7gTD
 eYWcrC2fM+GmbVL2GFcTHB2I6egxdkEGhGr/lfqn3epz5GvEk1h7oMIr2znxjVe1uHGW
 WNWNeuDiV+s+HdF9bgNAJqmFBYeLVpcCt/rkd0w5/aBlJPAGjz7HmLaaTad8k/hQalF1
 djUJ3p71dSdymPyyEwcR6z2T1jVlpqVA7Bf2womxq2YfIJdGjcJvPnuFTwn7PUvsmOiR
 jfBs72ypAeIKQOKZ4TU9zqCCgluYPw5Ok44jJJ1GAPCvqF6qCf0wKSn+1OukKFZ4L79t
 wW7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSnj8ZEWxbaU9+NkAK3wE14YmTiMxewVsfaJI5VoGe4VNRNWvw/oVBGbgF4pmlsaPdpE42Nc4eGrSS@nongnu.org
X-Gm-Message-State: AOJu0YxrYTMqu/kgmbxOWJE+FoygYVogQZY4BhEY5z9MJf57rybEGvxB
 IzNDGQksuFH0jL9b5nxkMgYMxaigxaRGDr4xS3N9sGyZVf0xQlTOtrygB6MCNNM=
X-Gm-Gg: ASbGncttlwcoJjTVokVbtA/5wKrRuTURnJjK2gOoIK1Tb/OOczINf9HUmRYTao0Wv0e
 a46pEgDgEpOKWAl7eQHrhSA4b8ENbIt3WklAMsjS5OIkdiyUaLjdEz7Mj91k1dR91wkNRslTyGS
 1uWpC3XHUj1W1iazoRJBv1WJcSLXqOpxZrshqytDsGX18yXs2AQD5RkzxZCm+ATNLwp0frHjMQY
 bRgiZFk9xPGy0NQA2v7fHVE8vGtwQplvZLGrvyU8XgKEDFbZujPUaLXPttuU905eNnRzTgJJOm9
 nR51ySSzQjQ2I6gKYNifhH12oABe
X-Google-Smtp-Source: AGHT+IHmQqVnsAYtlX7dNylQwLA0EpXuD/uY5FUpqtyshLAkqSqwYY5gzTmH+PBzvhiIJ6k7dWLuCQ==
X-Received: by 2002:a5d:598e:0:b0:38a:864e:29b1 with SMTP id
 ffacd0b85a97d-38c520a3601mr13001378f8f.41.1738394662763; 
 Fri, 31 Jan 2025 23:24:22 -0800 (PST)
Received: from [10.1.1.154] ([45.93.146.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c125f0fsm6656435f8f.57.2025.01.31.23.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 23:24:22 -0800 (PST)
Message-ID: <f586e99f-086e-4e8b-b35c-d87d989f4c10@linaro.org>
Date: Sat, 1 Feb 2025 08:24:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] plugins: add tb convenience functions
To: Luke Craig <lacraig3@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250131210724.3330110-1-lacraig3@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250131210724.3330110-1-lacraig3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 31/1/25 22:07, Luke Craig wrote:
> This PR extends the plugin API with two functions which allow convenient access
> around tbs.


> Luke Craig (3):
>    plugin: extend API with qemu_plugin_tb_get_insn_by_vaddr
>    plugin: extend API with qemu_plugin_tb_size
>    plugins: extend insn test for new convenience functions

Per v2, series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


