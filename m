Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36899C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafud-0005uB-Cb; Thu, 15 Feb 2024 12:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafub-0005tI-FP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:52:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafuZ-0000Ev-Ta
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:52:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41222a56492so4980455e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019556; x=1708624356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xC2V55t09xskRNxhfqT7zhBMadW+nl3LM0IQTHmZaos=;
 b=IkWdrzmr/g8EuingPVthIqO/UsEPBcFaPGnrpS4PID/qTC/jsYjMFPi712j845cK7L
 m8A/WLQtt2+nPDYvsOW4J2i2/Qqgcvm3DRxy5BJxUSReVEpfiUDgvt7fyqV8v3cv995T
 vHrodB0EFhUHFyuqJDJ4PQs7oje6ltBsLW1sNhG9z+AxB4ChqAP0Iny41jCYGKc/0e3c
 HMXNeww/afPwJ+20xm/MOtxkxHcIvoNdYFZV0ggZ+AIyTozFz/8Ajq7122HyzbfSZhmS
 Ubbj0VSfj3cYl0YUwLdLGiwbrDlPj7c9VUEhwJiKHaLyq9D3a2/83ABBnekvB4o8pLql
 MEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019556; x=1708624356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xC2V55t09xskRNxhfqT7zhBMadW+nl3LM0IQTHmZaos=;
 b=p1OMdqVM6ciRp3kxiIxkNoh5QZhsdJniiDk8FDz2AAlnxAGEyLnMhqV6mUxTHP4XTY
 V4D1/7OjMLMAzMRbgYHNnTQWEUz1v7Cqy7hxCUTLbtGyko9ecEMXQTdyJEVMd9kaWM4V
 uM/eobTws0oIGbApoj3Syhp9H2HseX4gyz/tn/TKZZvyhb46FGuCPbGtZMZIlF45y7OT
 x2ZvcHdRETU8SYWvTO9Np47brMhBtgLW+zjnHVcHnU8vAhYMfyzH3tLsJhh1A+I/7xHQ
 4G8Zy5RldJF8fLgtRb7pvujsp5DKLPWdU4cpM/cx6HEheqGwZIM+7Nt63jr8sJRk87eb
 uUnA==
X-Gm-Message-State: AOJu0YxA8+0IidlG9okZ9I4PbgpdSNgK73PNZh30KOUfh2eirfx/6umr
 aJ8de8Uvw2nWATCX2+bLz+G6WrvrMoDmA6C+KsEL9H3EClWAQ0Wy8Tc00350eD69JjLTa4wZ89t
 31/4=
X-Google-Smtp-Source: AGHT+IEvyIfEVAT1c4Gzhl1XDgM511jdW4GaLWAyrDU+UhjIRtg7I9vKuOHlI5c03YQ9u0q4wCKk9w==
X-Received: by 2002:a05:600c:3c84:b0:410:85ab:67f3 with SMTP id
 bg4-20020a05600c3c8400b0041085ab67f3mr1973241wmb.21.1708019556251; 
 Thu, 15 Feb 2024 09:52:36 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c044e00b004104bc8d841sm5680826wmb.13.2024.02.15.09.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:52:35 -0800 (PST)
Message-ID: <99653625-8132-421a-b544-9433111a9a67@linaro.org>
Date: Thu, 15 Feb 2024 18:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/q35: Simplify pc_q35_init() since PCI is always
 enabled
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240213041952.58840-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213041952.58840-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/2/24 05:19, Philippe Mathieu-Daudé wrote:
> We can not create the Q35 machine without PCI, so simplify
> pc_q35_init() removing pointless checks.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc_q35.c | 32 ++++++++++----------------------
>   1 file changed, 10 insertions(+), 22 deletions(-)

Patch queued.

