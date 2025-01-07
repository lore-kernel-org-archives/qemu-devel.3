Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B695E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV40o-0003pj-N8; Tue, 07 Jan 2025 02:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV40n-0003pY-P6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:28:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV40m-0008Np-33
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:28:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436249df846so104902605e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234901; x=1736839701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nvotU8vEmwT3jcuDYkX7w0NflOQasRvzk96g56LUaVk=;
 b=PDXuSrr7NEe04cDtUkQ4PqnZ9Irb5qQYIdNqWGTM3m0rDG1cpSe/XKQQGFGIyDEGRb
 yws7B1euVzI2YOQ0mNPts5tO/oAHM3aBD61SdMntwWKdyMoVzQzVZUkE80lOiB1PpUb+
 44a5b7/RpacK4lx7/zSw38Lhsy7x9F+O4rGTe/0dqpy1EfaUcW6IoE/O2dmSPWKMKbUx
 dHVDupyJqVQhjZBnkIP2whqziw/s6bWCTYR36g6uC9WYcNnGeJZxZRe6VDF61GD9wNNu
 gZ+ck7wFBKc9pbX/c7vmnikPOmzAJovsdOtC8hyAV6x0Zu1aSKHsYdYH0wxW5AF+oEVX
 WTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234901; x=1736839701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nvotU8vEmwT3jcuDYkX7w0NflOQasRvzk96g56LUaVk=;
 b=qaErOIc8mN8uldt6NRxbppHu2ZhqbtCNnpNqJNA8izOgRjkSJUUhsqj7EEukw1kWuh
 md0q6UbRycUOGfCTzRmG5G6CWaTQkYLbXqdwiA3GD5tYc20IR2kctFy6Km7fnnqjFTzj
 yGWDe9kem/2TTiPZaoRtf18LcytKcNqulEZSPqfGUgoLMj6TfucXZGdO7BNDWNtGfTjT
 UBRzRXMIhE6h9HXm19k4ykYL7YBpKjS+LDcmnU1xuYpqlCbVV37qEVESIQP3PR/FHSJo
 KPaYFwPGqYnwrS1rNdLdHMXfsOVapQCAwn4eP+wNpPHuD92b8HBoFchyc0VGU9DqcBXV
 H6tg==
X-Gm-Message-State: AOJu0YwIiSjCHjrvaeF+GatgSCrSzKN4/VF0uOMiEWMZrKHza/nI/mle
 JJwabHbyxeoMq9V4vhUXrlmle5QZZVUPwF1t6gG34S1b+Yu8VFueTaP4DPt7Qwc=
X-Gm-Gg: ASbGncs6EQGPLaRTOkS8tEkXPbclR67PsMVta2L+756u5jw6W1KQP8PkpFG30AQ3+1J
 /dIkj9ta0ymLXQN6YeqAzYPma+KPnlFbE2C1ugq0wB4B+C/77D4k/mMgR0hY1i/pdv5bNLNv+qP
 1EJjCkprB9PDeSL9BvrDazwJlz6uJT7YtasI9XFrHtv67Q2sua7/wUK0fD41GQuvqlPNXiC0Spi
 yZJ4ocmhQdy6lNUsR024rfmAvvIIJl+MZNaUilT8/nMzB+Y61tA64+rqT8zTaHbnJDdr+rYAjVy
 M1cVEcn9cCXHdKkyP9n8xzCN
X-Google-Smtp-Source: AGHT+IFSFIFYQ4l6YjSmPlC7fe4c+xV5566OLnFOkbPYNwFS5B+jRfpLHrBfWyTejGkfuevM3DvUvA==
X-Received: by 2002:a05:600c:468f:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-43668b78324mr404904495e9.28.1736234901575; 
 Mon, 06 Jan 2025 23:28:21 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a71sm585173415e9.26.2025.01.06.23.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:28:20 -0800 (PST)
Message-ID: <674703cd-3c56-422f-911f-6628a9a75f17@linaro.org>
Date: Tue, 7 Jan 2025 08:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: Adjust value to match CPU's endian format
To: keosung.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>,
 Yoochan Jeong <yc01.jeong@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CGME20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
 <20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107070209epcms2p8b39b26cf5a32a7b66246f2d122005f29@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/1/25 08:02, Keoseong Park wrote:
> In ufs_write_attr_value(), the value parameter is handled in the CPU's
> endian format but provided in big-endian format by the caller. Thus, it
> is converted accordingly.
> 

Fixes: 7c85332a2b3 ("hw/ufs: minor bug fixes related to ufs-test")

> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   hw/ufs/ufs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 8d26d13791..428fe927ad 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1164,7 +1164,7 @@ static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
>           value = ufs_read_attr_value(u, idn);
>           ret = UFS_QUERY_RESULT_SUCCESS;
>       } else {
> -        value = req->req_upiu.qr.value;
> +        value = be32_to_cpu(req->req_upiu.qr.value);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           ret = ufs_write_attr_value(u, idn, value);
>       }
>       req->rsp_upiu.qr.value = cpu_to_be32(value);


