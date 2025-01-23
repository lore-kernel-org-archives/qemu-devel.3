Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED3BC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6u7-0001J5-Ky; Thu, 23 Jan 2025 18:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6td-0008V4-Ac
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:46:05 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tZ-0004TU-MC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f796586so16014745e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675955; x=1738280755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sIImxUuZ28chVlLL+vN1mb6UQluYe71i/J3SLXui4EM=;
 b=itmCbki7ffk3xHBpIPIN06jc0HTUKug806avCZySxk0qYjz/NCfbbNVZxGLQVf85t0
 iI07rBujE8aBcF+Gid2P5HVzPz4b3z3e8Qqi/bSbxAFnjzLGcOzc4y5l7abqmGCSLppb
 mV6NFoIgmLn+jeSw9Rs4yMF1H2Bhl/and5yGEEB5F88VWmGTFhMz5+UMEdk3dCH7vOGq
 4aoeoNemb+WUEpEenDgvgczDC60iqbT0YCuLljwij29W3V3F5AgoYIyDaageq9ZSE86+
 eNxXclJ/7Sp+jthuDkhbpm1ZvFvzJP5wH3Zky87QAr7rGS3syT7MoHTrSFPTzgudKg1A
 Oorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675955; x=1738280755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sIImxUuZ28chVlLL+vN1mb6UQluYe71i/J3SLXui4EM=;
 b=Pl6K2VLHS1XmknN4Pu4eXxgblo3y3C10EnbPP/CBDVxmPOPp3fiG58ky1tNSHfsGYm
 mvnKRt+LKAU1lWS6s1NCDAt2GOJbnJa2B+l1rox3a5JMgh/gIVxHQrsn3KtFe4Xdw1g3
 7tH4RwjlGePWTA+9pgOUv090jaHSy7AvFqF3MMicRVpA5yySgCE5SdRONS1/E29+nmD5
 0pK8whymMJPoFSUg8cmt3V4NHsb4qC4KJwpXB10CTCMdZKfVViu2cRFdnddhND3hW+TP
 K0ZjniKJoowdQ4KFw1737cBg0nLLDGoWIgRdszbCSs8EzL421HYNT0/oJhmUBWh+R+ym
 sVag==
X-Gm-Message-State: AOJu0YzaLHgIbSRdooy2yD5bSbk9ryTxfQAEanlKRSCHJ4mhzlBcNF7O
 zS5W4BCNIWjiJMM61arhyKQGoTdkG4dE1z/xR+Ha24nncUpePu5NVuqk8TbCVBi5/056XU9ckSw
 H57I=
X-Gm-Gg: ASbGncuHT5ZhO8+4tLTzZVsfzjMFCqIoQY/Np/FFNy+XxgOhPDcx+c04gJDFwptAmw0
 NyB19izpaKMYm6P0jhqmxsgyamHH6PcuO/3bzHKHn+BegXpvPRGj1eV0cw3gW8ECyGviWf6K65H
 GaY1yeFS7r/o1BKGe75QJ14W1PJAj4+OgX3ixypzZyMmqHJnQu5TMdruMpjvqlq/kFOJogLxEhA
 j5zPEQW+Yt0wkx3sExJ8HMck8treEP9lpj86Hs9ak5a/k+Sn18SGbfZY/6CKlo+X5F5vlUPCAPG
 uub3ok/pSknjUZ1tMrFIbDc1vHiRl+y7OGLNHnF1C73bdQiRT3ig1y8QCz0=
X-Google-Smtp-Source: AGHT+IGfBJfULhniARVxaeHND22dVQGvVM8jm6sNf2yido1MC4lasaduEx+qwJvir1julFx+bnHZjg==
X-Received: by 2002:a05:600c:35c3:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-438913cf2e0mr264387845e9.8.1737675955349; 
 Thu, 23 Jan 2025 15:45:55 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f355sm7140915e9.4.2025.01.23.15.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 15:45:53 -0800 (PST)
Message-ID: <3ef3ad0c-0f53-4588-aaf2-f6fd712ebd41@linaro.org>
Date: Fri, 24 Jan 2025 00:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] user: Extract common MMAP API to 'user/mmap.h'
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250123234415.59850-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/1/25 00:43, Philippe Mathieu-Daudé wrote:
> Keep common MMAP-related declarations in a single place.
> 
> Note, this disable ThreadSafetyAnalysis on Linux for:
> - mmap_fork_start()
> - mmap_fork_end().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I forgot to include:
Reviewed-by: Warner Losh <imp@bsdimp.com>

> ---
>   bsd-user/qemu.h        | 12 +-----------
>   include/user/mmap.h    | 32 ++++++++++++++++++++++++++++++++
>   linux-user/user-mmap.h | 19 ++-----------------
>   3 files changed, 35 insertions(+), 28 deletions(-)
>   create mode 100644 include/user/mmap.h


