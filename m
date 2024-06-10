Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5983BC27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYSo-000109-C2; Mon, 10 Jun 2024 02:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYSm-0000xE-I6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:25:04 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYSk-0005Gw-Kf
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:25:04 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52c525257feso2085523e87.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000700; x=1718605500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+0GdibTRrJ+MB0GA2hbpLcO8vpDArVCG67e5p9bW9aI=;
 b=zicOMflkBJhxSs+gpcxP/ZCHc5Pu9EYUsUGm6n3yoXGx2iV3qMr1E/4elTQxOkJc3Z
 d4Am3kZclmvAyCr03+0lG1AZVQFKgd9jughSvjTqe1bJb0TZalMPTbfSdJOweSWHInR5
 B9pRQ8LxLdV5jK9XSwQYlP3Ca69VWPr5sYnmpA1nPjGMtcltX1ZCEgn0jIdV7o7JTAkJ
 X5iutc980hM2lnSfdWLvGlXkZEihib39zZSDe+hM3l0s/pNFPkzCAAjPQaa6SaMQxFZR
 qhq0k91njT7WEZS10Bjj7006AcKdz77ZMsNsbALU2IQSnUVO6awfsTIn9aRj2K21HqM5
 lF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000700; x=1718605500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+0GdibTRrJ+MB0GA2hbpLcO8vpDArVCG67e5p9bW9aI=;
 b=Mu26Hy9ScgFze7g2FxD+6rJb5WA9O57kbrShCj6zGXpBfiC+ATZjUx6jZUc5f/U6lu
 fYKbPcCdBwBhZLuIIb8RbiFOkeJVkcRgcTl3QidZZrBOPu+e4QlqrB3NiDIITabgZ0L3
 ijRntIMz0lpS6d0W7gvNBkTO3cwj23+Kqg3wAXze1dqhbtU2Z3jiFtXzvPrSzABQ/HNR
 wJsh9SNQKv5KHRAFHc8DyMNvKZwZ2YfIPVNLMKWIGmfUqlQ/8SHeOSxHewG/2fjil+Sq
 Pfn+gmxusc+8BS5K9A0i2j28S2sOznLuVml3v3yXjMEQiF/R3+BO0bJLMtCWStB35O1M
 7b3Q==
X-Gm-Message-State: AOJu0YxVK4MpA2h0DWLrNNNqeKJbhawBdS8EuFwk4P3AmVQTiw0Lr0tv
 4ypI3DnlKT2tTBRDStCuED7uRdIkCAX5RZOGy7T3fkJ/kkQM7JbttqEZxmSZLdi7Sm4cTRIbXos
 2
X-Google-Smtp-Source: AGHT+IEZ0CnKd8Y22E5FnKtCDVogfFH7/PQPhc67cZdyC9Kpn9bfsst8hzh9+Bpz87X/UG3rXUnkyw==
X-Received: by 2002:a19:8c41:0:b0:52c:8c57:2d04 with SMTP id
 2adb3069b0e04-52c8c572d54mr548345e87.47.1718000700115; 
 Sun, 09 Jun 2024 23:25:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm36331295e9.6.2024.06.09.23.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 23:24:59 -0700 (PDT)
Message-ID: <79d16330-79ff-410f-b9ae-e1d4db6524ed@linaro.org>
Date: Mon, 10 Jun 2024 08:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/6/24 08:20, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series remove uses of Monitor in hw/ppc/,
> replacing by the more generic HumanReadableText.
> Care is taken to keep the commit bisectables by
> updating functions one by one, also easing review.
> 
> For rationale see previous series from Daniel:
> https://lore.kernel.org/qemu-devel/20211028155457.967291-1-berrange@redhat.com/

Or more specifically commit f2de406f29 ("docs/devel: document
expectations for QAPI data modelling for QMP").

> 
> Regards,
> 
> Phil.


