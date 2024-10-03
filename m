Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A792FCF34CF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUOi-0004Dx-4k; Thu, 03 Oct 2024 18:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUOf-0004Cl-O0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:34:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUOe-0007EN-70
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:34:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b78ee6298so9372325ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727994846; x=1728599646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J7bBt6CmLbj1cMr7uXzauCS8p6kN5TMr9ti3dZWMwos=;
 b=TuObqK6R0wRoqknWAGETzp3MOfn8TosRYLYKdOGCtXrTXjaRF6ArfH+fLLvR/CF0OR
 Yx1Ng6xVAh/pkQfzRe66WHx0M14QODivrPLuZ7OVxxjAf+i3YE6w6TYtFzbKBfovU/YA
 oTi2gmYbthEgymOVcCKackwHvdSkYW/Lg6I6i0IXKf4JhG8CnCBQviP+bFbOBz994VQH
 QkiVX2KIs1ikc8VjyrYCUbCz+7jDCR96r41hmKCIagjNISYfv34FqbypjvYIR0eI+qeI
 KU2fjt+nOJ0ufRC+dGuVTh4HHU3oEajM7uYQp0zU8AK6JngLqae/z31Mimkh5pBbvG5K
 oPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727994846; x=1728599646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7bBt6CmLbj1cMr7uXzauCS8p6kN5TMr9ti3dZWMwos=;
 b=jDigUhaqkFWJg1wcnrgl3+Z+RuNuXCnbAHbcnztfnlXlzXBbb7DzoYHMJKaMeyj/v7
 tELrtG7LK2HfSJeskSVNMwK6wa6MHQ9KmLpxd/e056UcPFCsFI6vAI9S/r+sn4EIqDxc
 Pq9b45iZ7gXDEHzt5ZSFEJIZFvysSDRA+6D4aaAsiQnXLXyY2jmX1b7uKX9jJ4XZB3lM
 Ugtj+tsxqQd6BF+epgmaM2AtzztXbIYACAKC+aHUnK9ns6K+Fb53zB9N41rZDABOAMEG
 IrKObJQClajUV/NSSdr1o2rT82yhNlI2Xq0g8ZAoRj1yxxROSkvMJuc24RVra31tsIGv
 jIog==
X-Forwarded-Encrypted: i=1;
 AJvYcCW121JM8ekq+19/V7+VXxq18EPaB/Zba6TWhcJOMBbgnVCl683can7/3t8V+Z9i7JkkJoGOyXyVMNZ+@nongnu.org
X-Gm-Message-State: AOJu0YxGQsXUl5I+PANtheF/dkp7BMAGJpOyC1918puKaSENf740y90t
 UP0dlsRslGRdP2oiIvvHhZ+x7Wb+v6EKGtLrRIR+43HUWTivIKls/BkcdaOEFiM=
X-Google-Smtp-Source: AGHT+IFIaD/PUBZ6ys5i+4kTnynUykBKsGNzGiyEF5wUGV4ZYHTUO2pr9V2EccMTIlAqw+g2AlGxkg==
X-Received: by 2002:a17:902:c949:b0:204:e4c9:ce91 with SMTP id
 d9443c01a7336-20bfde55489mr10894295ad.7.1727994846582; 
 Thu, 03 Oct 2024 15:34:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefafda0sm13497735ad.211.2024.10.03.15.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:34:06 -0700 (PDT)
Message-ID: <f7ce2afa-9f64-4965-bbd4-fa7d04cdd060@linaro.org>
Date: Thu, 3 Oct 2024 15:34:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] net/l2tpv3: Simplify LD/ST API uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240927215040.20552-1-philmd@linaro.org>
 <20240927215040.20552-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240927215040.20552-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 9/27/24 14:50, Philippe Mathieu-Daudé wrote:
> Directly call ldn_be_p once instead of ldl_be_p / ldq_be_p.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   net/l2tpv3.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/l2tpv3.c b/net/l2tpv3.c
> index b5547cb917..7a0d5dcfe9 100644
> --- a/net/l2tpv3.c
> +++ b/net/l2tpv3.c
> @@ -318,11 +318,7 @@ static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
>       */
>   
>       if (s->cookie) {
> -        if (s->cookie_is_64) {
> -            cookie = ldq_be_p(buf + s->cookie_offset);
> -        } else {
> -            cookie = ldl_be_p(buf + s->cookie_offset) & 0xffffffffULL;
> -        }
> +        cookie = ldn_be_p(buf + s->cookie_offset, s->cookie_is_64 ? 8 : 4);
>           if (cookie != s->rx_cookie) {
>               if (!s->header_mismatch) {
>                   error_report("unknown cookie id");

Is this really an improvement?  I don't see it.


r~

