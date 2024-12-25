Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D3E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 06:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKxk-00088b-Ip; Wed, 25 Dec 2024 01:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tQKxh-00085U-Hz
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 01:33:41 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1tQKxf-0001vd-Sq
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 01:33:41 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso4954082a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 22:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735108418; x=1735713218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnL9L8+E9JeJnL0Qgv7sIBT9ZPbbiwKfmj1i8Doe7uY=;
 b=DsycIl/fgOkSHuwyVWb3eiH5vZFZQ3t8I22mODEhWYHXiCddZquvB0/fqPXtJwJTVu
 XRoCET7QurH42KDfXQTHdqbKgeBrC1gBLHD91xnBtHVWo0wkol1NH5W/D3jZqJ8RDY/U
 SafJw2QNM92XkgEHR5u1A4FSYvoHpZj9kDGLqhYcNXWerZ3BdyENvA8l+DCYqijqP6vD
 wy/RnjninsHX1D9aEJoNrbN+TA0ZVG1yxXlKTwCfYXJKHmkynl1GFug8xn/mzfYYd3CK
 JclnIOvGh9wPybnlMfggSibck3PQsIx23lL054FV+y2X2Lhp8GZVh+G/vJo09ivh/+so
 kH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735108418; x=1735713218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnL9L8+E9JeJnL0Qgv7sIBT9ZPbbiwKfmj1i8Doe7uY=;
 b=dwqWqzk6n5/+B7ZJjReaT7zECMG03DrvCDhAM3S2EFvf4F+o0oi5Q0pWos6RnGRtYZ
 CrBhsO4N39uXC1PP2CN3ZTCjWxypPZhllaa54QL4M136n/pFdDT/kptwjJM1d4O0J9M4
 DLl+0soHnI2Jr+DMI45sREXDoXgPNhzW/tan+IxLsrcofioqw8PcYSzW7meMkhaIvws3
 Y1F4TcLVpK+jn7BRqXcgNLiyEyTCUlki16sG3sSFVL0AsCN33miLY/QdwamdouUWLsun
 /ysDWbUiTLoR0lgNO3DsZHpDu00ZXY/oF0kHLhTjgUC6cvKqzLEXPDBZGJAZkC4jZVBj
 DDwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSuWSmTB0Dp/APJlgWhX8h1ZI/+uWEKl3HNm89p+gXbFKZy89lVHzZSBRbJNs+n6A//s8FSjSZ8jZh@nongnu.org
X-Gm-Message-State: AOJu0YxjHboZGHk9vwgpo6KtLlmedk0fSScHsnlVfkGFj7lBhoG0ASHK
 3CgCoKLYeQUb1Lp5NktVnrpZXG/K4tfpYhs4yySB7b31ro7pbV1cUT+VAHyj/KU=
X-Gm-Gg: ASbGncsRi7/jYcy2pwfOuiHw574+VaTgvKf+MZxtTH+eMRBcmGVh3ec/q8GxBejVmaN
 zOV5oeZbjY6HtdDmJFvIAruwjYzKXQik8HI7avVeRdEGZaS0S7S60tdpb1ceWWfoze4Tlka3PPF
 +bReBibGryCL1RJvbfkLpFfgbWHtBQ/7envzYS6k/GVrxsDzYR1VybZE8EjAjdXZgGWy4W5y7vs
 xgRQy9UefmjdECqXS7shvAFoLKHToXrJZ/UkwBRxqSY8o1uLLRbPx9xThBZ4w==
X-Google-Smtp-Source: AGHT+IGFiN5CDdaIChuSewvmfUkhapD8nIrbvolWvEd+C3DRoK2xVzqULSHMdPeQjD6v0SRstHWaHw==
X-Received: by 2002:a17:90b:2c8c:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2f452ec6fd2mr26065004a91.25.1735108418504; 
 Tue, 24 Dec 2024 22:33:38 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed52d227sm13361037a91.2.2024.12.24.22.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 22:33:38 -0800 (PST)
Message-ID: <3a2eec42-e2a4-40c0-b655-f4a52f0f8305@bytedance.com>
Date: Wed, 25 Dec 2024 14:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
To: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>
References: <DM8PR13MB5078933D25141B3F23ECA782B3022@DM8PR13MB5078.namprd13.prod.outlook.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <DM8PR13MB5078933D25141B3F23ECA782B3022@DM8PR13MB5078.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pj1-x1029.google.com
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

LGTM, thanks.

Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>

On 12/24/24 07:46, Gabriel Barrantes wrote:
>  From c808fa797942b9bd32221594b7eef690a7558b14 Mon Sep 17 00:00:00 2001
> From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
> Date: Mon, 23 Dec 2024 14:58:12 -0600
> Subject: [PATCH] backends/cryptodev-vhost-user: Fix local_error leaks
> 
> Do not propagate error to the upper, directly output the error to
> avoid leaks.
> 
> Closes: #2714
> 
> Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
> ---
> backends/cryptodev-vhost-user.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost- 
> user.c
> index 43efdf9747..09bfbddb47 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -281,8 +281,8 @@ static int cryptodev_vhost_user_create_session(
>          break;
> 
>      default:
> -        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
> -                   sess_info->op_code);
> +        error_report("Unsupported opcode :%" PRIu32 "",
> +                     sess_info->op_code);
>          return -VIRTIO_CRYPTO_NOTSUPP;
>      }
> 
> -- 
> 2.43.0
> 
> 


