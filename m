Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390A6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCha4-0002rR-QE; Sat, 25 Oct 2025 12:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCha3-0002r5-20
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:57:27 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCha1-0000gY-Db
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:57:26 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b6d53684cfdso700164966b.0
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761411443; x=1762016243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jtsWXM/OZR3g0EAVLFcOFgITKeT5NNe5kCn2ZFCouXs=;
 b=XFxA4Bnk8J/Ylpar3hKYAULZDkng3ijmmDbUL88w12XAPJpYEMBT5i9rdKnmL7kpUs
 cDZx/OdClPTVOBx/ntZa94GwGuj/hWJdJlB6Ty9jP5H3yYoEVOiyF5EImepeX61ISxKf
 grlMpx/w8hTV64zoj+OCOqFiUSTlRcGBhqJEFJXaG9rE8jWOYS55nxsKnkEsWrRMKx0q
 33uOcHTUv4Ne3v1XQaqeBCuYh8c7xpGKCeTV/bw3lfoNEhBa8A7pBidUsnP7ySvllx88
 RKnBN6H5B8dfmxRlhOdyWj6LZFdPLKCTkN1h650h+ffgHZ2JABaZQIehUSmuWgXj9Uj9
 ORhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761411443; x=1762016243;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtsWXM/OZR3g0EAVLFcOFgITKeT5NNe5kCn2ZFCouXs=;
 b=mZrUyIC9OXvul822MClvHvuG7nkenET+Ngu2eF0LcVry/zqSNoQmW8jLuhKJwsxg/U
 a5Hoh+rWDEU07lN7PXfuEt09Xj1DxH6UQt0bZlGkm5d1b0VRrfeYPQ1HRirHTh4Gz1uK
 k+tLrd3MMuh9R3woIW0DZAObE0H3Afdq9U4XPxBrgwgyf+U2a2Hu8y5tC2bZk5QQR+l8
 VL1aCac97k7fxh4WmhcmIY/Iv4MvZA9WSr9YxIV5amJrirH1IUpyO43Iq5KCu1dWqt/5
 xczf0Eo0ohfuSKMSiWyyN2TzvV//iXS+1DSsC0D/48FSxw5nbETPq+gwEsogQj7qcvxF
 tukQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvuOu5Eclu0lQxI+kxO7LkMxnU/axdszDusbTY/fIrl7skEmIn4DW5JrAvuOxM9Pb5OYPR9VwFXMUr@nongnu.org
X-Gm-Message-State: AOJu0YyDuI1VO30HR2q7htromTFsr9aZ+DquwVgWI+mlwnKEoVyiO1Ik
 fqBJT6d0aiWbRknHM2mYC2J0FWSLp1yupyUcqOrIcjyo78BQLm9KcbDtm4QdnMweONY=
X-Gm-Gg: ASbGnct3TRH+HqLKE9NMTi/yDZPdM+kzBiVzKMRp3jjxv+L3ucIWpExUFCyjoreYkPC
 lw+YhelsnkSypb68z6Gs1UzkH9qi9p/1vtDpG88LId3v8on9djJxyLraMKRvjFBTVKEhQZxOk7k
 EMz6oE20dS3elLkA++GLOqkuZI58C+dTC9C1I/n4KWA/nepAK+BXWi3zvksMQgWgd+vJbzOiPyH
 WtVMaaZBwscYLFBnqT9TpHA63lZG2HwuWtwGEUtaHgi3CxM5pJNZXGGU7ITgFngw9LRpeDVen2A
 I+Cdx7NLSrBnzLL3wpDVXRHXxA1kWa/7UNP8a8hIRu9uTN8oS/A9moVGqQk3Xh0X1OZJUzHkACH
 GuJCYURfHd/oNZ3btSUBBmt5G+sSBw61nMI9zRDVIYFZtFPAGRJiUdJtyEmX/1sZdAXfSG+UMi9
 rI2iuVRJq1ociaxh0f96V056tbs7RQPiQCT870Xs4tWN6ifz4MAQKjR54GUe3RwOA=
X-Google-Smtp-Source: AGHT+IELrtfppq79bhSOGpd53X/yIc9ylDMVjJy9oW9n16/v8ZtoDWV6Asl30v4PtttmUZYPwMVgtw==
X-Received: by 2002:a17:907:96a2:b0:b6d:7f84:628 with SMTP id
 a640c23a62f3a-b6d7f840a0fmr467118866b.43.1761411443315; 
 Sat, 25 Oct 2025 09:57:23 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8992aa28sm188031366b.41.2025.10.25.09.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 09:57:22 -0700 (PDT)
Message-ID: <2cb41dd4-be6b-4daa-8de0-bf1d9d542e11@linaro.org>
Date: Sat, 25 Oct 2025 18:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] hw/hppa: PCI devices depend on availability of
 PCI bus
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251025161901.32710-1-deller@kernel.org>
 <20251025161901.32710-10-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251025161901.32710-10-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 10/25/25 18:18, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Only create the PCI serial ports (DIVA) and PCI network cards when there is
> actually a PCI bus. The shortly added 715 machine will not have a PCI bus, so
> avoid creating further PCI devices.
> 
> v2:
> Clean up sequential testing of NULL pointers - as suggested by Richard
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/hppa/machine.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

