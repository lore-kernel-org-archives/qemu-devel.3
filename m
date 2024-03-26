Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BDEC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 19:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpCAW-0007Er-TW; Tue, 26 Mar 2024 15:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpCAV-0007EZ-45
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:09:07 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpCAS-0000jf-Hl
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:09:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e0edd0340fso10048065ad.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711480143; x=1712084943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=09DDMTCL89WNkhlv0C/7aoyscbDE7d0uzxBjD1ddd/k=;
 b=w6kWYs6BaWY9E62pLN9tBjiCr4fv1kn1xG/hEdGJFxt00H4N7umrDFCqhAmtPyFz9D
 mnipeF9TKARvUI9/izEw9WJEJPzPw7uSSSxtx2C66ZnJELcQz4txZGkWsBOaCvKgX0+J
 qbnfOGIeVlazOBvqdBFTFDugFCKTpWewsBlxg04V6sGyFFdJDRevkZkmrdq0o28OtDdZ
 a4OIP4faNkEfPn80Z92RfjUac91viDJ/wXj79dOiEZTSiL3Iejc0gyCNFilyAaZujfKx
 kLoU+LOogzrY2Szl+khHdp0eyqQtALMfx+/tLyDY8m75Glo6XNNsiPsi6VFvWY0/M4ne
 CwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711480143; x=1712084943;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09DDMTCL89WNkhlv0C/7aoyscbDE7d0uzxBjD1ddd/k=;
 b=czPWGlDg+4V3Z6XmTcXLUX7vczHRW06aWkiFE8hYDBI/AASt6dnDwE5bdlMWGYR80M
 ZUhp0dc0uqZYDspD3oROqEcn09dunMVELSKm0XzlKgUW+bnWCqPVxuq45bhwy9OW8Pq7
 CvcWKW4hBnMD2136DFPnAFp5OFyqdJb0gXS/UNKUIlvZovZiGwAiQOGZ6qbyGI/5kjNG
 6urLlmyqzXpDWs2M9uI6xEVsvl1au6i9raieAmaXO1YqRnUDYbJ6yXLf0cnIkacn6HhG
 CT7Dz+jynPXUIhIHmFwbyzadWoJMLWHqSdc4wdflwKJeaAALBVbMgJM7W1OICYbs2hY2
 tG3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ5pB0WT2JyP1z/FyYozkJ/H8hPKIORgsiipb4/7h2etLVbVKnuy3Q/dHvFchxaUSoXKPNKk5e40m0XnJ09CrH8vDqWVI=
X-Gm-Message-State: AOJu0YwdTI3pKmNMXq1JnGvMrkdl//NHMHr/G43aVbxXJQYXwnALTmD8
 G53PNQDFe7d4qjVd0vQgbnaD/Mc6yh9uTIPzZUREf8ICpVwvq+ulA6Ao/a2UERw=
X-Google-Smtp-Source: AGHT+IFNtVsSrD6vAonAuAQP04cWZZTb50mgJv22Tv34Fr7ftlz/JJj/fYg7l3QtCPbQjRlOsVx9lQ==
X-Received: by 2002:a17:902:c94d:b0:1e0:c91d:4487 with SMTP id
 i13-20020a170902c94d00b001e0c91d4487mr6291838pla.43.1711480143180; 
 Tue, 26 Mar 2024 12:09:03 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p2-20020a170902780200b001deeac592absm7329747pll.180.2024.03.26.12.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 12:09:02 -0700 (PDT)
Message-ID: <8145a914-c820-4f89-950e-9086efbcad08@linaro.org>
Date: Tue, 26 Mar 2024 09:09:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 5/5] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, miguel.luis@oracle.com,
 peter.maydell@linaro.org, maz@kernel.org, gkulkarni@amperecomputing.com,
 gankulkarni@os.amperecomputing.com
References: <20240326182345.326758-1-eric.auger@redhat.com>
 <20240326182345.326758-6-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240326182345.326758-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/26/24 08:22, Eric Auger wrote:
> From: Haibo Xu<haibo.xu@linaro.org>
> 
> Up to now virt support on guest has been only supported with TCG.
> Now it becomes feasible to use it with KVM acceleration.
> 
> Also check only in-kernel GICv3 is used along with KVM EL2.
> 
> Signed-off-by: Haibo Xu<haibo.xu@linaro.org>
> Signed-off-by: Miguel Luis<miguel.luis@oracle.com>
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> 
> ---
> v2 -> v3:
> - check gic version/in-kernel implementation when kvm el2 is set (Peter)
> 
> v1 -> v2:
> - fixed test ordering: virt && ((kvm && !kvm_el2) || hvf) [Richard]
> - tweeked the commit title & message
> ---
>   hw/arm/virt.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

