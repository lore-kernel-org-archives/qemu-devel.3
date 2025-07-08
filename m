Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D63C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFET-0006Pn-Va; Tue, 08 Jul 2025 16:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDxT-0005YN-2u
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:26:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDxO-0002El-Jh
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:26:25 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74931666cbcso3907172b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002776; x=1752607576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NpokmzBZf9Ndynik64SY0VCrm5Id9j2SDPXgY+3AKfI=;
 b=AX42Q45Usi/XmY3xXerTLGVDuBZI5hy0YIpN4aZn74Y2xHWuPgAHJX+dd/4z3WkTE6
 bPvJQmy9RnFqCeUCIokQe96wAhpRM544JyD2Ro31jcue866WbAnpdc5iyBZLvSO4yn7E
 lC/6dgxaJz/FPfZbakbpxeCdKm2OuekgBg5dfPrX73B2Q5E9G655gRJIUpLKzZrkwdmz
 OzuyYtKWf1bAmhPkEf9ishZdMR31rjT3n4ilOBTyLbWf85CY63oLKJPGaBB2wWaCioNo
 veTlXMI9dRWkYQaoIf9LPNrha0S9WRfjjMoIPFc7r++C1ztKyOUQ+7MiGrOnQAErSaaX
 fydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002776; x=1752607576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NpokmzBZf9Ndynik64SY0VCrm5Id9j2SDPXgY+3AKfI=;
 b=KMHkvNuZJjznYZ8+kIQcPJpdTOxDWS+4Y2vPp5pq8ksEIBzenyZg7vsO3Sk+NWF52G
 5QpwJBSIB02VhGJ2WkNL95ZeRw4T8IFYsTncSJmfvNu0CRxouXvy6izA+fj/JMQLdaAG
 M+YriTlKlnb74w6pSAmakesN+lPh2SZ7lwaKEpom0ZZahOO+KuQ3jkKTvDAudDnKk4zV
 PaG9yh0AenRm4mwJvtuhIICWVxmNBhUcbE49PRgWVcWFuY5TZGnOkiAOMji1T9835FHE
 RJnXriC5WL4JxijZSEyeN37oN+GMKzyX1RxgVUGvi6oIPbZRTu+pmIBmLzD9uX4PtITW
 OuZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyNeinw1PclavA+PBQRZmi1K9g8JQbQLJysWv149iZLY5CLdwKKJs48t3K3plqacVBYDNsC6uqWKPp@nongnu.org
X-Gm-Message-State: AOJu0YxxL0gT1qee4HFAksQP+L9bQ+Xd22viUu/5J85GpTw5sRMIa+Kj
 puX8SKShnvnc9zw9f4g1xCBDgw4VmFnJyAWUn8x1rfucppY8nR1zIGr7PGbZN4r/Umw4Jx0u/XK
 tqAVl
X-Gm-Gg: ASbGnctjaal0eYpzW0F8v0pWew8F6Cr1vzKW7Iq8JVIKB0L2XDTNegalNlkXmEo2O4i
 8Vawbwe9edgVMSao2DxR9gofw9nV00AMgmnNPWRttdrjVnKIh1FIeR8fS+h2ycX++u6eYNZUaG1
 BrDxShXEBCpRBRcLze7nVB2jM4QJucaTL9jmIy6AtQK707xmFYS5U4W4KlZhkEQvurhhY1uOv1K
 dC4vTL6ORqUZggxblZDRXRf1PIHBQAFXCziChmgiGrYaYCyzRffX77JRszXNt7aiHLqjfV3stmN
 1d+OUHYAkWMwXfiACTlVwnnDTwr42BumhxOJTxkMJpud7M1LYt3UPJlNVUiCa994jkITKT1N7PM
 =
X-Google-Smtp-Source: AGHT+IFD/tw8S92eqLq6aXF3gXU+MXGEhzjZU7LiY85OvpsrbqvoO6pCAQlmjdzy+5IRmNr/dwAXUw==
X-Received: by 2002:a17:902:d2c5:b0:236:6f43:7051 with SMTP id
 d9443c01a7336-23dd98356a4mr4888025ad.23.1751996046753; 
 Tue, 08 Jul 2025 10:34:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8455eb3bsm125752875ad.115.2025.07.08.10.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:34:06 -0700 (PDT)
Message-ID: <c51f3075-5511-4a97-9eb9-7605d224c237@linaro.org>
Date: Tue, 8 Jul 2025 10:34:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 6/8] gdbstub/helpers: Replace
 TARGET_BIG_ENDIAN -> target_big_endian()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> Check endianness at runtime to remove the target-specific
> TARGET_BIG_ENDIAN definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


