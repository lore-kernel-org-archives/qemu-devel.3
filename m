Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B982C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 16:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIs9S-0003tX-Nd; Sat, 24 May 2025 12:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIs9Q-0003tB-OD
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:55:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIs9O-0004DW-Fu
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:55:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so6511165e9.0
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748105709; x=1748710509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vXPuwt6b4HHVKgOAMOCmQqYJTLrU3fsUzJUX4VBqOh0=;
 b=u5foMsjWRWUTRzeQfwAgnaRNViVc8XGVD9o/hYeSdBnlTPEMJ9h50+1a5GzK+oZExs
 OI7WwR/vvqhgkeVzBnJdlclMQSNwzsWpAMx41Fhgv28j1OCdyICHi/f8eNPW9ErNECcQ
 v+DoqzS7RTm5hDapbFsJzxLzG+tJfVjgKdX6ygt/DPSq6SKGL/3BgXpVdVVIsrckObzW
 kGzK+wrvnY1eD+e8srqNMgIWFSZSaAQa4oF/lHSJtAbY/5QLTfC7nz6H4CdXksL6Ppxo
 16EvuOt+sh9wWUcXUsB+15DlBLZ6tyG+YURYeuCd40cM4uiY89nTXS/9HQ3p5VviNVWN
 vClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748105709; x=1748710509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vXPuwt6b4HHVKgOAMOCmQqYJTLrU3fsUzJUX4VBqOh0=;
 b=PMogPW1jKVmnLUFwH05i7L5AGtBsa6wQaYIcDCm2mfaoUMFLH7tGqABchGk3P3SasT
 dBFRNY5wtRo5rlfnqcSF5xDvZK+VjISrafbYEVKkXXYsvSaO5Qt6cj2utay3xsRXbOTl
 PK8gm9dxaz/4igKBzHVZ7R28IUn6T1uVaXQmjYlBJdivOsnNMOxouA/A7cmaCR21D6wU
 EKpYG/wIxoHLQ5B3M7Mu0r/vxKtciZCO1Fb0GcY+2+0Jy+1sLZrxp7GXrGlLLDGWlb5t
 2vCAE2C+rFGqt89QsqWVSsxlQwtDFznYGlxIewvwe3gvtTygQOozU5r2N9r5meA+tNf/
 Gjew==
X-Gm-Message-State: AOJu0YxSm/rcBrHxoSKu/wH9mLL9J68bgXj7BLavLbTI4LxoujGlaAlg
 9eTBtLlBqUEYQUg/YPLc2kuOBIbKfipPKV4KleUKWgu3ItDd2GfBIeJcyJXpYoqHx5y4DWZM9A4
 fBuVNdjP4vQ==
X-Gm-Gg: ASbGncvKFBdOZCNzCkSbydHcKjvBLO348k+AzgqHj4EXAL9KbmqtZF4XjfD5ufTP9zZ
 aegGGCYY9iyrzRal2y8B2nWfY4zRHVUY3Hc63UceJDsavIdwpSTJsY3FkClDDJpTAoOo8hBygqo
 /uxet2Dqa+GISwWqfgvpCwbHZjps+z8IDCczinipXY28VgPxk/kIuMfyRgwMh7rN9SAk4sUP/pO
 Z/Tm9ZUWsqT6LKg0EOTJ8KIF5U9n+wZzx04M8RnqWEVJZY4DJGN4NHQob3ohJ9B/MltE5lHpa2Y
 xfpz6nwrTDs/NqrBysX+3iqkTnHlOOJuuXnKECww+3y1dthz7zNRfC+UJUlvEvvZaA==
X-Google-Smtp-Source: AGHT+IF9p93hBUsxwbUtcEhvaTijY7rE0DmsctXOgWrion8ljaMaDDVFBNNyjPgsOOnGTN+Ip1gzAQ==
X-Received: by 2002:a05:600c:46cb:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-44c919e16a8mr26533465e9.13.1748105708609; 
 Sat, 24 May 2025 09:55:08 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca888fcsm31645738f8f.78.2025.05.24.09.55.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 09:55:08 -0700 (PDT)
Message-ID: <edf78ed0-7ada-467e-86de-47e2515588bc@linaro.org>
Date: Sat, 24 May 2025 17:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/25] plugins: add hooks for new discontinuity related
 callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> +QEMU_DISABLE_CFI
> +static void plugin_vcpu_cb__discon(CPUState *cpu,
> +                                   enum qemu_plugin_discon_type type,
> +                                   uint64_t from)
> +{
> +    struct qemu_plugin_cb *cb, *next;
> +    enum qemu_plugin_event ev;
> +    uint64_t to = cpu->cc->get_pc(cpu);
> +
> +    if (cpu->cpu_index < plugin.num_vcpus) {
> +        switch (type) {
> +        case QEMU_PLUGIN_DISCON_INTERRUPT:
> +            ev = QEMU_PLUGIN_EV_VCPU_INTERRUPT;
> +            break;
> +        case QEMU_PLUGIN_DISCON_EXCEPTION:
> +            ev = QEMU_PLUGIN_EV_VCPU_EXCEPTION;
> +            break;
> +        case QEMU_PLUGIN_DISCON_HOSTCALL:
> +            ev = QEMU_PLUGIN_EV_VCPU_HOSTCALL;
> +            break;

No point passing in QEMU_PLUGIN_DISCON_* only to covert it to QEMU_PLUGIN_EV_*.

> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_INTERRUPT, from);
> +}
> +
> +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_EXCEPTION, from);
> +}
> +
> +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_HOSTCALL, from);
> +}

Better to pass in the value we really want here.


r~

