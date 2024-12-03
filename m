Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE4BD4979A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPhn-0007VJ-Ju; Tue, 03 Dec 2024 05:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPhl-0007Ui-0g
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:00:29 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPhj-00079Z-HY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:00:28 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e2880606so3377325f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733220026; x=1733824826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mou40D0ZjD2Lf1VQwRddwv9731DnFFHuY1Fb6AhznBU=;
 b=gb0NjVPV0uHoLLftcv+dgNLjneuRJPWrUsEJHOLjZrkKZQywPPocKmdWqf1vpdYuCs
 UrOITPYiXqaXZ2OhGKAAfHpi7ZSE8B7yCzYbKPV/6JDoXRdhUXLPJMvMOPlFVG33n3vb
 2LHSmUxstpkD6P5sXg5NqthMHfFAzApduoiTkIHfN9OM2B5caf1c+NSXsjwLkWR2F2Dh
 VoK8wL6+AulUHXf1rwfNG365qD1H7n712tBlaAhBdbWA7Iz+glwKkoJX221PrzKVSGg5
 Il8E0BYjQA2DGSDOTxhaU7U4/6xyHYbPpPMM10V3rCipjiqBZcAXFex7TktflAw5EM5+
 M0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733220026; x=1733824826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mou40D0ZjD2Lf1VQwRddwv9731DnFFHuY1Fb6AhznBU=;
 b=nnCXD1Fkp/uLtAZM+EmL1eRgpmr72BFeC072AgX7NCq7h9brD5rkhwGaB+Q1tgHk88
 zVxL0dvQ+n1VweOE5IIOiDUvPUOQD8lI2lN8+nARunYPfUOM0azcS6k+1Ez7SUpjlpaw
 cpGcvqCAUsWtyM7QxurVBCT9v7s4o9c0STCUtlZtR3vkNje8NQIWDXVASJYGcfBfwJw7
 WBs9cZBL63Fu9Iv29JTPF/erOuWs4X2JgYDRcxzvD1RBN0ECR1QUOqkOiBlaD4zfdBtX
 5xjlk1H/Dc8lN4IbbtwB7aD8YaXE7qVKtsZ+Yn4gat1UyJoc9wZuVa0GmJ7LXUeycrGI
 ZZ5Q==
X-Gm-Message-State: AOJu0YyPI/ivH7pszPPF1Zu2HIgv/l2E9rW/v4y0MaFpEtG8wXlncnAi
 UiFU6/I9zTYKCOQMV7ABNuSK24TCnvzXKZyaT023IdGzeja+n9Hl7ObpJBoFJ3M=
X-Gm-Gg: ASbGncv4vJU0hT17vrDi30YiKr3quensxy2/GMMt/XJnHmqeESH06I+KqBBbjVpswPE
 AJKa1w0CQj2jq5t+ChnwpNJnbDE6lHc5sA/blfIeS8E+QRncTRBCqgvuENHPXYm/dDdcwV6mpS8
 AonOj3mP1SfUP1GuXhN1I7TFbKuv1O8RDhakzwlp9qVG5ZpaBgY2dFzQV0kozMBR68QlwH2D6ph
 49cpaTaavfZEn968asEgJ0LZr8ZHq0POct0l23tl68Ggp9R/4mBDXtNeaQLXbACbg==
X-Google-Smtp-Source: AGHT+IE9vxZfRp24W90RJX0+iLYHphI7Leo+DbgvnW1oVtIyTYr8wsT4fzpvKsL/PjdyubjEmCbDIQ==
X-Received: by 2002:a05:6000:4024:b0:385:f062:c2d4 with SMTP id
 ffacd0b85a97d-385fd435560mr1562279f8f.37.1733220025994; 
 Tue, 03 Dec 2024 02:00:25 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385db7f86dasm13053820f8f.66.2024.12.03.02.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 02:00:25 -0800 (PST)
Message-ID: <0ca2c3e9-2ea6-4cd1-9f97-56068b48d870@linaro.org>
Date: Tue, 3 Dec 2024 11:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] qemu-options: Remove mentions of legacy '-machine
 foo,accel=bar'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20241203092153.60590-1-philmd@linaro.org>
 <20241203092153.60590-8-philmd@linaro.org> <Z07VR-YvVCxdTua_@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z07VR-YvVCxdTua_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 3/12/24 10:54, Daniel P. Berrangé wrote:
> On Tue, Dec 03, 2024 at 10:21:53AM +0100, Philippe Mathieu-Daudé wrote:
>> Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
>> options") we prefer the '-accel bar' command line option.
>>
>> The new form started to be documented in commit 8d4e9146b35 ("tcg:
>> add options for enabling MTTCG"); it is safe to remove the mentions
>> of the legacy option.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   qemu-options.hx | 9 ---------
>>   1 file changed, 9 deletions(-)


> I'm not convinced we should be removing documentation for options that
> currently exist and remain supported.
> 
> The documentation should be updated to say that we prefer use of '-accel'
> instead at least.
> 
> Beyond that, what is our long term intention with '-machine accel=xxx' ?
> 
> Is this a case where we are happy to leave '-machine accel=' as syntax
> sugar forever ?  Or is this a case where we want to deprecate it and
> eventually remove its impl (and thus the documention here)

Right, we should deprecate and then remove.

