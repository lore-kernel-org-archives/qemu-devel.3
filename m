Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B87C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7p8-0002N4-Jf; Mon, 03 Mar 2025 10:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp7o6-0002CZ-S2
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:34:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp7o5-00066I-5L
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:34:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bc38bb6baso6378755e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 07:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741016050; x=1741620850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zIOZk3wDIbg6mQhTEtf61Fb6ROhIRArMbpF/7UU5I28=;
 b=o5yy5hr4nOshFrhvGex5uGKMOBfYDrHo/4FXS7PwTzuAy9OFX6+/kWrtyw0/TGsVSk
 MJtc91f+soas4gSLRFtJ4T4lDMNN4MZMvzFT0o3f1WaKiZLSPH+gSbLWY+UOFORDGe3g
 lOFLDjd2skL6vvbLUet+bL+mhqoHsZieYq9AjTMsl6YF5TSNQfMTRtFazEiWjjisNXYp
 bHdtR+pXGKUuQa5rIQNqs1GIC15+4WaMXsfqmLdBuLO9QqsK5pSpnYixb8uOHt9tD+Zv
 uZtOLVp5lyKPJ92+zRu0601LxqIrCefmeYXDDNA68M+8bSqCPJgRFTG0SnNfy91nyz+z
 VpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741016050; x=1741620850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zIOZk3wDIbg6mQhTEtf61Fb6ROhIRArMbpF/7UU5I28=;
 b=AY+cUtLQT/YzZvemswf/YmqG1/6nYYXqt5sCyx0pKgEYrhcL9oITUWEoh8B0ehZu6k
 lUkNhRELN3uykuo/Kxkx6lvOYUN5etc87R4WTE2eLOB7gzi3T0slaUAjJmvPhYwThxhZ
 bwBBhGCrjOUZCyVcVb91mD5VRGmyjBn3nb3A+vvIoYSoMmfAtxOdGe5SFezvJTZ39h+x
 quuv1lBONDZZ4TLkRCTJVzyIcNhJGN2i52PikisuKWA7GicZpDUfG1pu3bHgXnd+NokG
 PDCT+WtABw5gPOiUcJOy9SbIFiPdZqteQuU/e23fyrCrwfmjkVsNqnLIM+VaqKj82kz2
 soJQ==
X-Gm-Message-State: AOJu0Yyvu9AndZbZR2AB9IaLe3oezwxRe2c0NAE0fyj0a20Zca0Edpk+
 QB98TEjc4sRElnC/7a2ORdYsNmmyjFveKuuCkM+nWN2po9ycrb2eAEwT0LVQXorKmOswx8bzj5g
 C8Lt+iw==
X-Gm-Gg: ASbGnct6z4jAWqUeF/cHHBUbb3wnqAW5FdKYy9JP9+2x08NcuFEciVtdVw0/i/61PPY
 DJZZ448gZ9A3N3kV7ida/VXzEqHW1tpntp7bkf3zgcR3LkARs3V5ezVJQXoGLTWI5eYhMyQ2OUb
 qOfrmWw+CO/nE/Hd4EN3c/GRCTCDatJYt4whAHkEifjsr2Xk7pvazbCNK9PENHCLLb+QAiMq51L
 toydIuwceatKNCz13nNlzSBynxfOHOucsNUeGq4Wno8azZ8wxeITrog6ucTG00d3bIk6G/2y4xi
 D5sePHxmQNlDFbbX3TzGJcVrNN9YWX9JxB6s/mBe49DKeVpCV4F7zEOAWNQNsJRmtpDR+K+DhdA
 IH0VuMZnCji2+
X-Google-Smtp-Source: AGHT+IGIR4uFD3kJXG9qeNIcwlO3sZp/Z8NufdaV2V3nrAzFuU+YN1ieeMP+R8wLcCfThUEVlooqfA==
X-Received: by 2002:a05:600c:3516:b0:43b:c528:d0b8 with SMTP id
 5b1f17b1804b1-43bc528d48bmr27284525e9.5.1741016050644; 
 Mon, 03 Mar 2025 07:34:10 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc63877desm17074825e9.1.2025.03.03.07.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 07:34:09 -0800 (PST)
Message-ID: <f6b74258-1dd5-4d50-92f5-bcc8d7f015b1@linaro.org>
Date: Mon, 3 Mar 2025 16:34:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/intc: Select generic ARM_GICV3 when KVM is not
 available
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20241227202435.48055-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241227202435.48055-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi,

On 27/12/24 21:24, Philippe Mathieu-Daudé wrote:
> ARM_GICV3 is not restricted to TCG and can be used on HVF.
> 
> Philippe Mathieu-Daudé (2):
>    hw/intc: Remove TCG dependency on ARM_GICV3

First reviewed/tested patch queued via hw-misc tree.

Thanks,

Phil.

