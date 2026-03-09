Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B51FCA192
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 21:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzi9W-0005dC-DR; Mon, 09 Mar 2026 17:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi9U-0005d2-Pn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:28:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi9T-00079n-Bm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:28:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4853510b4f3so27026035e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773091714; x=1773696514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N/1UNcz7/9osod2H20qil2Oz1SHTV0zwVTigCihZgL4=;
 b=PLnIuyU/Wa03jZjOU9lUwYGIOXNiRMhvWMYMj7Zr7wGisJrP9V6EhE2WHzE0mXFvqp
 lYChsVNi+DyfRWw7ysK+UbwStljcFDDjfSu/seR7cTDQiRkehb4n8CZ1Y0HS6xD31Siw
 PIj59oVDATHZXygGgTdTI5va+RpEPbiE3gRYX063OaKnqImDufkXvATGFE4QvTjnHulF
 lBSWnMmEQP6dXlYEXClabt6+z3RJw4K5HRrpsW51uenDVWRM4kYKGUWJzBkYB4YxW+cT
 eKAsi7HNHdM/6LxaymzBvGg3yQJYQzNS5623aV8xBlWSdSwF8jVEkOKPEyNq5IfEqUGQ
 uUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091714; x=1773696514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N/1UNcz7/9osod2H20qil2Oz1SHTV0zwVTigCihZgL4=;
 b=S18Sds9FOopXvdTq2qOOK6anVA2Bjhhtqaqew/iEfCctFuISeIH4PvQ3NICFX64vaL
 aG43h/t/nATiICvlHuz/4RmjKwFP6w49TMTz8pxoQkNzTkmgbVLbyNW3Q9fYsF9jAdt8
 AxBVUCUQQvpTeBiaFIt+iWZQGKOZ/fvox7IMLAhrndUiBOXogyzhG3vwhzUnEu0Qumwr
 TxSfYNMYZnyBB7yWKtAAmVz9ponkU+IpLANNCh43yhBuLwDlcnrJSJpq5tyxbusJNAg2
 9Z5b3MD2CDWMMylJYz5+GvMDcd0yWX/VcXblyvqpGcKyHTjGzGyRss4GFsLOzZBwEpFn
 K/Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5qcSmxWBH9Jc6gctvYjQOJct306gdovGTvTZj+b2kt6j6K2Oe5kbw+jYrOf/J//A5ajCk+II97ccB@nongnu.org
X-Gm-Message-State: AOJu0YwHlpdi52D5mthc7GxVYU8C0v0rfEloplK6MCQsFbssihls3JQM
 FMqp3jw3I/M9lrJqKx4apNvpJLmIVh/b3P1ct9cbXCRoH2/ibpCCak0+dG3DgkPzkVE=
X-Gm-Gg: ATEYQzxSwDibw+ZftHkMQhywhaECk//uNZA3r5xrbi9MZKw91af//5ouKqyKdoLtSPu
 eFrp241RCXQq2PkUpzE0gVu4zIeM+GbAqnmzEbLZpftj0R6wXRhenR9wfPNPRG3sKXPHcnIBk2Y
 UGt7Rx/Hcmn37OjMM/9UyYiU/vA44MsRI2wuymxyD74fMv6ZJHmm/n5roN9+k3qm3jHbgfB9lSW
 e7imTSt9fH39vI8h501uf9IvYF1Ej4uMFcVor1mpYKzbSkPkykoixwTca4h9vggbbmoLwjm3PZP
 X0AKmYB+nx3C1YmcICGkc9OCC2trbE0uXQGwb56SzEpOURPnvHb93NYsDjsqyOt3v9BHpMVwoKp
 /z6Zj+Z53Ky0y86sitwoJaIiBYGP9Gb3nOup+NYpa3ayN4L52KNV2aUpL+9Ap3Uw5mAjjRDeIa/
 qgZ7FdiObcXC3bwLSAZvLVqGwGL5brCqXrnAnJ6id9QfAwFwTOzu7UBKcCA9SjBhb38g==
X-Received: by 2002:a05:600c:528e:b0:485:40a6:442e with SMTP id
 5b1f17b1804b1-48540a644c9mr47446655e9.0.1773091713823; 
 Mon, 09 Mar 2026 14:28:33 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f406sm17350595e9.13.2026.03.09.14.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 14:28:33 -0700 (PDT)
Message-ID: <c1ce4855-1080-4f95-b9e9-d895ccadcfb7@linaro.org>
Date: Mon, 9 Mar 2026 22:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] tcg: Expand missing rotri with extract2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
 <20260303010833.1115741-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303010833.1115741-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/3/26 02:08, Richard Henderson wrote:
> Use extract2 to implement rotri.  To make this easier,
> redefine rotli in terms of rotri, rather than the reverse.
> 
> Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 52 ++++++++++++++++++++++++----------------------------
>   1 file changed, 24 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

