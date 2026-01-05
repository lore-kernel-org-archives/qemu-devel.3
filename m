Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26DCC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 02:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vca0s-0002X0-9o; Sun, 04 Jan 2026 21:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vca0o-0002WX-Am
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:08:03 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vca0m-0003C8-NB
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:08:02 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso15782867b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 18:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767578879; x=1768183679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9HpmkSZMLD0ut4j0JUMC44c3XG3CfxGDEnJE2Rn+WUU=;
 b=fnFTDXN7aYtx7k7POXWBBzs6AFzOAxE7ypAqinGsndcCVCkMmas5DjlkNEiNhjGAS3
 2kIgWa+jcenQUYDye8xeaZ5khJaJqYkbVnSvSH7Hb68XoXNgtJQ91gJonwNC1fZ/ZPdm
 1tNt/KT5o7nNg1NWaxD5sLYW0A5ImvFwfciUYWezDl1sZ98pzkWfQ7ebJ1HMCaxqYXjl
 L+qRrqsm67XHo4KnVC6ZY2JStnlQDH3OmLkZecd366bxqkmgu6Va30u4H6r+M0GD2FfZ
 I6vDy29FW8OAu0DSXgtLwJWogAQRFpQYly5LmBzbT4/LEOAier/eEFD7otLBUGkZT+fu
 XEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767578879; x=1768183679;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9HpmkSZMLD0ut4j0JUMC44c3XG3CfxGDEnJE2Rn+WUU=;
 b=hhOsbYSXZKJeJvBSKGtBcsW9Hb7bViUekMtQAB72h3PeVwPDhZ2E0UjNEudbUXqoy2
 fU8xsR/1c7WxKdAsi12t/NFWIzPUAWgABjDNu9htVl4fcKv1ZgLwkb+KHqE1PRqw6UDx
 IhhnNiSp2HJEZbOhhXrH2+tJMJu/1h7lDoTg1thaSDRBt1u0tccHECA6rczf6d0tSW5t
 wKZMKzp6gp05Xu6kYnpkFeZoD9Ja1Td5KA9q+xlpQtNg8DVH+SJw9AEW+9wSEyWo9rO3
 zsYqsGGFIETF2trciwSrn2K/ujfB7U8s6du/vQ5Q6p4VrhnaMWn8MbvZzo8uuGgiZG0N
 37Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0qPtxhH5X37nHo6YwjSNCnR1w9wUPHrbxR98hSAFJCEhJgWSlm9QL2VQG7KRVhOnH/kM7C+dtXrqm@nongnu.org
X-Gm-Message-State: AOJu0YwAMPhb3+ysaUTxC76mS3kp5ESqa3bwFv/bEhBsjghCGGWrz1Ul
 vzNQ8MLXkvYFznV6j219Mq+AZzquh9wQvNfprLCuiA1UnFvSQVbNRSZciYVECMaPNus=
X-Gm-Gg: AY/fxX76rhNiPJynymNo9FHiHKalhhfbIiDbtPqTMXbPwp3xJzcQjqarAlAxHpQrD+u
 lgpKrTNupVzL8WOvMp0N+TI1gAkbeaiGI+n8jOzXoOLcrTqQ65HD7kKj7gbSqI/bZwjduv7eWiR
 iG4v0JGTD6mE0JV9EpJTg0mq17zAtun7wKMfNToeYgM/DzqNwsGRdMhtrcAeXjK5bdxzkfvO7I2
 PZ33UCXmVnPU6Hzj/GvpxrHclzsHgZlEh9RP+FupXEpEBOUqKF+/+q9Zr+n8ESldFV263YmOREu
 NarDjeK8WW50ZKcuJNkIjYxg7SfML33BFmuXf0581gQnf1bF2yI98dDbVg4ljarCN7vNyjiEtXE
 8wFzaWj2HHStiG9a8w6L2/Uec8+bBE+8InPPVp8f5Eq8hu780bNZfyPpEuFKqJtnLADm2HR0e6p
 0kvd1Ftkp9npD+wObeFPvYd8yxXi5WRA==
X-Google-Smtp-Source: AGHT+IHvsuOBTE5pWR933a+2E8jTvrEeMBZ/gkP2OzehmY1fPaz+uf2f/NzV1/XQEXR8gteugnpdHA==
X-Received: by 2002:a05:6a00:1d0c:b0:7ad:f6e8:d013 with SMTP id
 d2e1a72fcca58-7ff6745661bmr37356402b3a.32.1767578878783; 
 Sun, 04 Jan 2026 18:07:58 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e892926sm46429929b3a.66.2026.01.04.18.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 18:07:58 -0800 (PST)
Message-ID: <01cce7bb-ede1-48f7-a65d-a81d1f64e885@linaro.org>
Date: Mon, 5 Jan 2026 13:07:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] linux-user: allow null `pathname` for statx()/fstatat()
To: =?UTF-8?Q?Jean-Christian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20251229121416.2209295-1-jean.christian.cirstea@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251229121416.2209295-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 12/29/25 23:14, Jean-Christian CÎRSTEA wrote:
> Since Linux 6.11, the path argument may be NULL.
> 
> Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` was
> specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes this
> issue by checking whether `arg2` is 0. If so, don't return EFAULT, but instead
> perform the appropiate syscall and let the host's kernel handle null `pathname`.
> 
> Changelog v3:
> 
> 1. Don't call `lock_user_string()` when arg2 is NULL.
> 
> Changelog v2:
> 
> 1. Removed cover letter
> 
> Signed-off-by: Jean-Christian CÎRSTEA<jean.christian.cirstea@gmail.com>
> ---
>   linux-user/syscall.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

