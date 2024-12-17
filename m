Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91215E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNaVL-00072H-0t; Tue, 17 Dec 2024 11:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNaVJ-000727-FI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:33:01 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNaVH-0007Zf-T1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:33:01 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5401fb9fa03so5516383e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 08:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734453177; x=1735057977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OQvJ20rE3K78lOs245mERS00p/Q4heWR/jOLpUXOFS0=;
 b=n7dZ4JHrC+VyrZCnWxRuqaEQe1olc4pyFgW/SZIMdcJIoA5+mXHHTEzpc5FpwrOjU6
 hmGPH4nBNZbbJNfTNNDbWwy/mWyWnDDGZEmPOXfxYvwpMwuewI+LqixP8m8tXHgwEHUA
 tLNzeweTP2x4FTnKJW8cFUW6LTUvP5GNyAeAMHRsLPwQftOaXtM+K9+OijyNBEuKzyy/
 sA44t0Ro5w3UXN7NKspHX1NFSq1YEtBWE7X6bkkzADgPtrLfYAfdA1t0Grx1rkOrcWjH
 nSAwkmNGIUwHH6OZJ2sVr96jOenrH5YsapDffaDmeHokn2AGf0CNTrTlYXkqnU0QZk4p
 PkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734453177; x=1735057977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OQvJ20rE3K78lOs245mERS00p/Q4heWR/jOLpUXOFS0=;
 b=agIteCTQn/RX39vrZFyRB8nXOF0L1bbO/026/C9zcWb3Zq7/jQaJeI1GzM2J8vqYmM
 n+lT+gjx5wpO9a43dTcBq6aeVk6thMRjcU3/GBkJ/ljogzp8yfLmINxPeKOdBui5uaY2
 Icm5Q4cFU6IOaN8iz8ooextuFW5DlF8bKZuKORmcV9N6jdv9UqtpzDRT5MpOoNxNZfa8
 Ij8T7e5HbLQvtdZAl8mAUosN685x5gLuQIllfIGVTRjHnJVi8be7NEeQaFK6Xdw7Xlzh
 ++ND8d6ls3Jj5KoqgNa083L217H56ltJI9+sad2ZtSPD+KxPU3Rrnrz5Y/GxVSr9Rnpp
 gPNA==
X-Gm-Message-State: AOJu0YwaNPz11Iv/fUYXs3sL+iJIIHAFJhkbp3CDlkXC1mel+gn5HeO8
 klqaiQ1CKatDAZspyg+WRbX3YP48+a2oHMjVBmdX0NZKJwqHN0SxuUwaZShOcnnjLbHMh5+wnna
 CtkYD5bA2
X-Gm-Gg: ASbGncspoCeEVgw453ETvTvOp2F+THhIWoQQMN1cmBbFBuo7pcnG8khbwmC9VmHdhb/
 qXoSrx5Wc9m0tpHN+y0Tqi+aKVLZWmX6RnuG4OtS+6vT+aq0SMN+6Y+tVUDRlF74PT9nlFgtfOp
 gmnCtEEAuuDHZ/10ugVdfFpoda5lhA7QjSzS6hlr2aM0fcBG9fGZs+mj6xfEFmRHcrer898t85C
 UNDu2ZbT111BVuHy0TByJdpqWDCgqIWZh3YpFbFD1TSN3D9rbtG4W3iJCL0DIk4k2JrChJamDA=
X-Google-Smtp-Source: AGHT+IFGf7iBw3TjdyQe+ySJ516k4ldxfDnwtoNgGbEcpxI01lYucQeVG69RccTkd2pzNIp4ycsWuQ==
X-Received: by 2002:a05:6512:2245:b0:540:2223:9b1c with SMTP id
 2adb3069b0e04-5413159e426mr1540939e87.25.1734453177564; 
 Tue, 17 Dec 2024 08:32:57 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13be2sm1195426e87.195.2024.12.17.08.32.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 08:32:57 -0800 (PST)
Message-ID: <73f18a23-63f6-4c8c-8d29-cf1330510e99@linaro.org>
Date: Tue, 17 Dec 2024 10:32:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/32] tests/functional: resolve str(Asset) to cache
 file path
To: qemu-devel@nongnu.org
References: <20241217155953.3950506-1-berrange@redhat.com>
 <20241217155953.3950506-4-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217155953.3950506-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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

On 12/17/24 09:59, Daniel P. Berrangé wrote:
> Allow an Asset object to be used in place of a filename but
> making its string representation resolve to the cache file
> path.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

