Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F5FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpjZ-0002gY-2i; Fri, 31 Oct 2025 10:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpjU-0002g2-1v
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:04:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpjQ-00042R-Rq
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:03:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4771b03267bso15733595e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761919432; x=1762524232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rZHbRfXJ7JvJdmXH6R62+5+8A8/vuHckHBmQG5mKo3A=;
 b=X5I1E3DPq0h0WmaXOqSW1JvQ0jYie+E66Gky78298fOkeojYUIkA1IJGG3AwqecsJs
 rHn3EKipOdSOt4AugKrAEalTEXqJCx+X9LWouLQ2uTy9qXXv0jtC/gUVl+b38D1xkkFl
 Hb+6GSYLpJ+OgYOO3snY90zlazAWZLFr5txrpdQBOMVPDxzc/+lsGh6r2GUb9Cyziyvm
 hwDs3xaQclHFRiyGgsIB80+F3Gv2RhNxbbOpYnR2lu9a4Z0QIe0PeRy4Tw0prPKviKUQ
 LsX0LH1hVjr16QyWZ6Gj4W/byQE3GhSszAgvdw+8+GgkQZ2LKGM06rn2k0kzuFA0BCZq
 FRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919432; x=1762524232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rZHbRfXJ7JvJdmXH6R62+5+8A8/vuHckHBmQG5mKo3A=;
 b=j6aW32b/QI6ebsGoMNSWz19rwrdjQBZPDt/AejNXGcHsaV11bKejKHSdghR4+m9+ZA
 OkBx7y/vHLEBqC1vrqDR5qm4ojX+uoL6yxlArKIBH9nGcQ8GWcqD1K6sn2F9BdILRi2R
 d2xu2eqarj9jXTpa2Q93LezulStJcJbGfEKf6IfuOixjuLg3JrxjPkrDlh2lBnBtR2UA
 PLx4iwLG8t7MXc7NQJMQN7/fPhf8hp6olD3lMDyi2SIvzpjId+OYwAeXfYRo6Tek6B1P
 6CVJO/A9FnSTIYNZtzTzxrbEgwrMcOKxFotVzsJ0/UQ3xZlU9IlrIfwZsI0c1C5oIVwO
 CZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN20J7gHBcAafF6HFEpBUuuIiPQ6GdkPdM6cJi6Dp+JMoEpFd+m5RibRxhynmLVzGl9GQLM4vn9c7K@nongnu.org
X-Gm-Message-State: AOJu0YxBSl0frwU4vmOeOd9vrjfwquM4pVU1VyQxIaqNdFnw/CEzkwBT
 OQldcPK8lpboeXNbx41GyHNyL0wIR3VlVCbmtW3dhog9axHVSC4gNTzpCrZCkbA9pug=
X-Gm-Gg: ASbGncu9KavUuyspqFlF+AatZmJPjLSOZi4EOkbzMOpHMLsumpjeP3KR6Zh0DrSbfkE
 INzk9lEGS5KON70tWgyklBNH28RPUkCXB5HNWaCX7wVUeMcWMjSieYf8SEJWaIFjj5eTFEjL01y
 ZP0Z7ODct7D+XdJQyotZ6hTs37ABCb8CtwQBkdND4mUd/Ns1jBEg2HEjZ9+iRyTwQ1GacsY9Uc6
 mV355BXqDsskyyMCcIyV48jXKO0qlxgzMCyESWvPI8ms5Uf22nW88sdoT6wn20o3Ko876m1qhQU
 H3mPPJukzLx08H6YA4XLchemAmI4FsGWwKKshsV7l38zgZ8tL36hR7pAiC5pHU6IWq/R0GbfbzH
 Q4TcjwIMwGJGYOnobfJb8evBPwllt4imVpEvomqPyX4A80BgN1UUZMQPLZ8L9GGgkhyvJ0+cYdt
 oRwKuHFpqZeR34yKGef5NlXXGJJZxw/Z9GFOYkIsZ1fHm8HYtTqoJumBr3oFAcBvcMgwFFBuwCH
 GMn
X-Google-Smtp-Source: AGHT+IEGait/270Xwdmbz9TRFwGcPaQUqO7sU6aoLNu3OZqMuYXdWPPrLJgmSRR91/kjqwsC7FQaGA==
X-Received: by 2002:a05:600c:8b43:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4773b1d39e0mr6207755e9.17.1761919432161; 
 Fri, 31 Oct 2025 07:03:52 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1142c3csm3748530f8f.16.2025.10.31.07.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 07:03:51 -0700 (PDT)
Message-ID: <c1e09752-49a3-419e-8849-6dab8507dda4@linaro.org>
Date: Fri, 31 Oct 2025 15:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/arm/imx8mp-evk: Fix guest time in KVM mode
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251029142311.2986-1-shentey@gmail.com>
 <20251029142311.2986-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251029142311.2986-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 29/10/25 15:23, Bernhard Beschow wrote:
> The imx8mp DTB hardcodes the clock frequency of the system counter to 8MHz.
> In KVM mode, the host CPU is used whose system counter runs at a different
> frequency, resulting in the guest clock running slower or faster. Fix this
> by not hardcoding the clock frequency which makes the Linux driver read
> the real clock frequency from the register.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/imx8mp-evk.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


