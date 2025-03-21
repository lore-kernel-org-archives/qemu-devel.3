Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7AAC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 19:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvi1v-0001oz-31; Fri, 21 Mar 2025 15:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvi1s-0001o5-Qj
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 15:27:40 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvi1r-0001Ys-1V
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 15:27:40 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22403cbb47fso48154325ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742585257; x=1743190057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BD4Q0d2ARlbHpJDDpX2hvCogsjsARu368abJg8rMPA=;
 b=YODQkEsrzHVVXSI9OzNLVMYtVaKp1VOyvbf1q1PdYWHKeC/eipOz/itgIsRodT3NGz
 JKys+P7Kvf1aXhf2g3Q2v8jAf/wdFZ/f6nzdzTcNEaOa0+b7oJhTF9AqGTJpSJ3v5hFp
 vwMg80EZK+r3EJSolxy+i62am8qjbJHEd2G/tZ/JKX2FeyMXXIbkR0jRRTM5eiFih86s
 5Jp38/WMXYyYmCK4EBO2kgyn0a0W4orXOLr8D9DiOIfWXg2/f5obM0kJ9X+xIJNpoksp
 yFFByI/7osqYlm/6PigfVULrRdXEY/OIR1mAIvyFHCfgLacxqjtkisU6BiAdlC1pFFAK
 YRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742585257; x=1743190057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+BD4Q0d2ARlbHpJDDpX2hvCogsjsARu368abJg8rMPA=;
 b=KZoI3CnvwCgi35wXIDnB7/t0XyLGOcwSPN0UxVOxgBr/pTd+oXAh0ftuO5SJlMx7zA
 y27d3hBUhA+rqvchKmRZ1v4OZamPIufREnTjNsmPdZJltAwMPlHYLFTT7gY+GDpQRzN5
 gctmCQGOYg9cqfOZDLxk8/v+Eajve0et/59u6RWWSnyqa3uTqfUKUMa13jw66+p6dZnW
 hoZLGvRj+UahUBgMBJ+c9cNLhkQNg0UbxzLGClr6RdZwQhCJE9dfdHAnuU+WLDb2VBdg
 5EgxG12eY4eI5+asXz0fMxoNt5TvZZjWGKR8HsYqd+9Q7906MvIdqGaTNAA8N8hCDD6W
 HWDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjpwulKhWvoBwaPw5JgJnXDLyHpcyOD1j77nbU9drkzbSE6FHxh0osPqiqLNCBOfO5PHTISue6wGA0@nongnu.org
X-Gm-Message-State: AOJu0Yxj9OzjvxeLDPSqyBFy5gHK4kCfPXuW4Zcj0n2AwOSH/ZeR3SBD
 o909hJp/A+m5GLTjj+DGTfAXqA8QuGp9Jw8Q49J3dsY96pSzGnOF1kuqjtE7op0=
X-Gm-Gg: ASbGncsABf8sx3TcgbFl2KMoNWY0rXsBkRB17up63jxvD8tyegXRaKyyplyPPADcr1s
 m5JDd2ziPAQiJ6YvZXkwHwMEhnqd2RfTGIMNgYRjRR5HOawW1HzZj7/+06gv+l/Fxlxdv5+hNH4
 INASblsDmS095e69ZYEnBzc/bYIVJuxfK9spKyq5sCy6Y9tTJgCL16VXtkNKlAEniRFTOEDkOC/
 JpwUQGdvYaGAgcf3bWr12MLVNKbXKoGfEPQoRsw+1ZWMNNYX4U6+XfQcOaQwblIj8lonyLKMRNv
 8DTqkjvDswIt2IwHSp6kH0FDHpA8+XIVp+p+gffx6a73rcCIMoTcabKCy1K4JX5iqutqN7w5B2G
 tn+tH0ubP
X-Google-Smtp-Source: AGHT+IGdwHtiK8kjlifCbPq40icJnn3e6WLjtJ4qO1xsRZRyjHJoCQKmv47WszcOxwOHmSQmmthTsA==
X-Received: by 2002:a17:902:e88e:b0:223:3bf6:7e64 with SMTP id
 d9443c01a7336-22780d8a93dmr69838655ad.24.1742585257089; 
 Fri, 21 Mar 2025 12:27:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3974dsm21319225ad.7.2025.03.21.12.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 12:27:36 -0700 (PDT)
Message-ID: <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
Date: Fri, 21 Mar 2025 12:27:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
 <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/21/25 11:09, Pierrick Bouvier wrote:
>> Mmm, ok I guess.  Yesterday I would have suggested merging this with page-vary.h, but
>> today I'm actively working on making TARGET_PAGE_BITS_MIN a global constant.
>>
> 
> When you mention this, do you mean "constant accross all architectures", or a global 
> (const) variable vs having a function call?
The first -- constant across all architectures.


r~

