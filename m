Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F54C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeNP-00068E-16; Tue, 02 Jul 2024 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeNC-00062H-33
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:20:48 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeN7-0007sF-9E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:20:42 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cdf4bc083so6532155e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719930038; x=1720534838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b05OdKC7qRpMTJ/rt4WWEUSDUsmruZyUovh4hUJy6e4=;
 b=gCQugORl3kX0kRubObchUcQeA3ajM8IECR+clBvDDrvvDJYpKLNRdV6RltWhmh0l+U
 ripXPnlDaFsieRHWYU/tQVxGxiiaZFOJgIdpI1ok8kdinSrDFWluL+cePp09NG/3/2BA
 tmC+GNHFwKg71M2ud66fSb38v2vubKG2aW7tEcd+iVAI76NXYE4QqaLh2AlsO8M7xET2
 pfrAAEHawu4NjvJ7xJL5w3U4Zjtk8h9e+hGCifDyYsyjjRCOheTIArhHnULMaRf1l3x0
 v824lIx2rqn5uJELXRugxy/TV+NakazazjQu0IAyboIR5Ky5kI+E4G92XJM0Ry8w2Z3O
 Z23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719930038; x=1720534838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b05OdKC7qRpMTJ/rt4WWEUSDUsmruZyUovh4hUJy6e4=;
 b=hlgq5S00EZ4wioX0SwkYNLuXtQ6+3ybmVRoNpzaz4NpKyqKW0AMEex7FS9ye5PzwCp
 A52MWW1wkyYq6rBx1Pif9G3jxKFZqkhehtGPsPJz4swKpdYUkFQXTtKWBlMtN0JFSX0R
 3QVyt3T3Lnz216rkkC+Uik9iSGPF+FU/SrjMSDAlYm7+12t7hOxLyVSdWOqvdObQkm5l
 Qr2bXx//5twyw7rxGXfxSqGBxyza+iaVesuL3zPuTppdDcCLPn0NAAzsdtQOFbkJJGqU
 m67lrUNA+78W8mbeQ9rs1eiXE3rbVcrUD7PTmMrwut5ug+vyOA4wHNeMWXsCWirdATso
 xMHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5xNHzOMGOWrPvHxhrwiuFv1iKakeuI6vcJDjKiOnHnB0tESZHsbV49+0lV19lH/ye2ZS42x0i924lLKti1kNJSuJgB6o=
X-Gm-Message-State: AOJu0Yzn7gigyWJZTBj0aWQJvHF3lxY+wxtiriwb38nDN7fdkXAZvfNx
 094RmFYHoC01k4E3MFrtr+6UZsKZ9R3MEGZHbK+jOmKGBp00DHFotvTHCd9+Aok=
X-Google-Smtp-Source: AGHT+IEforiev8MJVoghSzGhyXNHIb61PX0oxG27M2E1+miRYayGTegASw/GC1pya+2iP4bnHahYNw==
X-Received: by 2002:ac2:4c12:0:b0:52c:a8c4:4d99 with SMTP id
 2adb3069b0e04-52e8272f459mr4342698e87.68.1719930038084; 
 Tue, 02 Jul 2024 07:20:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b66csm196547145e9.18.2024.07.02.07.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:20:37 -0700 (PDT)
Message-ID: <56d0c526-5d41-44a5-a737-e4eda60f61e7@linaro.org>
Date: Tue, 2 Jul 2024 16:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ui/cocoa: Add cursor composition
To: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
 <CAAibmn0S+BvotSV6Sw-d17ybCu10a6Hgyu2sEUrJrzejHs9WZA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn0S+BvotSV6Sw-d17ybCu10a6Hgyu2sEUrJrzejHs9WZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Hi Phil,

On 2/7/24 15:19, Phil Dennis-Jordan wrote:

> I'm still keen on NSCursor support for absolute pointing mode though, so 
> I can experiment with doing a better job of cleaning it up as part v3 of 
> that patch series.

Do we need a v3, or can you clean on top?

Regards,

Phil :)

