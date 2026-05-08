Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8389CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHke-00010f-RP; Fri, 08 May 2026 05:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHkc-0000tz-JC
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:44:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHkb-0005Jn-33
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:44:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so28245445e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233443; x=1778838243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1YB/Lale1pmLKch1OsaYb+u7+p/Z7p8rrTMCVpPUeDI=;
 b=mH+T1EMK0t+j2+3qaEA/rRWiCx4V3GZvo1LeGzpV2LoidgjD7EahS+EV+wJVU6CDsk
 rrS9v6ZCN6HqqBv1LQO8ti8nfV6MOJjIHJfKDz8T+ZD4uoDypspmYwKIs9WA+s98EOE7
 XTZP3bbuksUcpL2IzYlE9+dZTPE8qkKa+EmeOzMJlSZ72pRBM9SleJckmeHPqznNAZcP
 NluOUVOFdKzPjYSwj3U1keCRNzHs/+AHNqZB0rT3hwqTKJUgX4p6+z2rOZ0YhujK4sY1
 HtWFMdlQkNYWek2s4px4p5vATaTB+WhVagUOGLa+tBprM7n0ZDlHTQfSHxikMn+QUFay
 dwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233443; x=1778838243;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YB/Lale1pmLKch1OsaYb+u7+p/Z7p8rrTMCVpPUeDI=;
 b=MqLSllHiDrkbHY14MO8pLrilYrz3L00AWbj/k6xpk9EgZ7R53C/F8wvuUct1/1+yCP
 a8Viqmj9MuQB24MbM01gf4Q7ERnvVQbP4T7MKBxgSoZ4OqejofCLS6m31BNHbHihZZeB
 odtNs5lFjdRzcz9MW7HQr+ggm5+fBX9TFwBO+xMtLIGXy63LQGIDgmS4sNXKSDOOIL40
 WQl7E7f9BhB3mg2S0cC26D3v5AYBy+xhlWrMyHuNIy0Y4isnO3PQm9bzlupiie8WLiVe
 NUzb3k61z8OgwuJmdEgdO/aCEfV65QB0m1SRXKcMa8lYUPiQRELN8MQ1Zv1ZI5scuFXQ
 tMsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tFrRg3sXF0ni2vIppEj0X81NAl9Vug3cxruN1hkPdnqxBm+Ms8DOps+CL5lGurV/OJTtkshuK2pvy@nongnu.org
X-Gm-Message-State: AOJu0YzE8qIjZ7SMpfT35caQZwD3mZsOMYeBP0oc59LaCEmle1mSJYSe
 xdhPr0yhXwc9aSs4YSFRFaegGx2hzfREPo3MbdqM25OHjuy3C0sFcLULAufqj+oO7yw=
X-Gm-Gg: AeBDiesj1BvU9DpYYyKtIyARtR4SFvF5Yp68snDFN7lVYNkOizst0lO0mDZ+z/lNt4K
 tB8HdRgw+iySlbpsyPWt38hqNKEIO/BMQGtWQOLevKnbb8kca7l1rqw8iSFgus0Lwikl/uVP4sJ
 BBiKQdoexLE+O63nXDbMifJPzbRqYLe5sdoe6zgw93EEKPdPkuGxMPn08CiNILFTy0BuiFknH5L
 hu8Pl28KdmDkh45WvEoRUh5GWkuCvb2sZFRz/+23dHh6r3dgqSUgdvYLSU0dSgjv+Ekqop7r8nk
 PmOXjPD6/dWNDrO4p5gPgPlIAqe5+QuILetX0PF4cMXy2caaFmzr5mJsbTyxZ5atH2kKPNvOzq1
 uCCuxRk728726ZTFHW8FFhs9tYmcgEDUS5GG+a0EZ+kv6Ma6FUFUOswFjsfbE3HHr5Q5V2VcSc5
 uC/48DBZQh7C2UB6z6YpT16lG0PD9XwaV3R5pEzCew++tYcJH3Gx9H1QLXS4ny5HetRo13+5P4v
 nw=
X-Received: by 2002:a05:600c:a111:b0:48a:7b7b:c2b9 with SMTP id
 5b1f17b1804b1-48e51e0bb44mr147181995e9.4.1778233443556; 
 Fri, 08 May 2026 02:44:03 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491da03a7sm2934843f8f.33.2026.05.08.02.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:44:03 -0700 (PDT)
Message-ID: <9d7257e2-dbfe-43fa-ae4f-a0afb6d43c25@linaro.org>
Date: Fri, 8 May 2026 11:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/alpha: Use FloatExceptionFlags
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/5/26 00:17, Richard Henderson wrote:
> Fixes a bug in which we were still using uint8_t.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/fpu_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

