Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD55C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wze6w-0005oy-51; Thu, 27 Aug 2026 13:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wze6r-0005mX-TB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:41:55 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wze6o-0002iJ-0H
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:41:52 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc1cc1b42b5so158121a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787852508; x=1788457308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nBQJAcWgK5ffZdqmguQ4n49p1A3fQBv3MT/7AlkoKaw=;
 b=RcM7HKA2nQItUhCYWR+54pwjUxIum1upRstjI4/ihgqLfsX1Zqu1HZR9RpQefsSwJd
 AKe1y8s+3suKUEE0ZwyTrOBqClngBEKlh2v8eIwWi6ZgnmzQ63pUpwpbQ4NcyGVTUMpY
 AvIYBNae/d+wRXzHW4HnYAHz0DopYasa55ui3lQJHHmdMSM7o69ylVeNwsfN8+xP9n6u
 g8LN8fNd07mLH+HvC6Edn0JkijvdvW05GelzmS5Rch4As/Rnp34pugc2EwsdcS8Uz35J
 nlNt1fpBWH/eEvvFgDkAMCBDXlSwqbsanJXQe6LExEB/b/wFV6V9KwcYupQxZmlvvlFZ
 2mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852508; x=1788457308;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nBQJAcWgK5ffZdqmguQ4n49p1A3fQBv3MT/7AlkoKaw=;
 b=fNX0ik1dCasyki38QEdIntWzYE4JHXfNv5s4mQlD03DPpqz31CYeo8jb/PUO2iJTXM
 58F22J5TktlxdBHg1G76fb4QLa1zoIXKCgEduSXske+IIHR5QSy78u0JQkivc2KTZkMr
 AsDBTjYVjlcGHxZntGPUiqtt4iKzrni0XSKD7reJcjud0bCVi1OE2nIPQTRw205OV2Y7
 dvi+AIQZoBTr/GzLsZE+06oOImO0dt7rYVhwuBi/xW51RjMgy96dtncUcaNTYA63azH/
 l7GojroT8ZhvjlhVZ05JZFWp/pay+G4H4R1TjybNKhfy5pN1bFM6bZl1kwsHvr+J2GGS
 310A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqee10DfmCfOVbc2/IJSkV00TC5/rVVexdFPkofb9K+VB5JtYMd3AxBFDIxFZ4aOTd+g/XRDQJU+t47@nongnu.org
X-Gm-Message-State: AFuF++mF3F4tpTvr4Mf2gjQ16zqPLQ0TTLW4K0LgOsRcOswgFashfwDJ
 R+Sn7gVXRPIveJe7V0fIhzYDu/EvmYGmOU6BtKhDX7h2dU+cjYkK49i9nqZyS2ekq7Y=
X-Gm-Gg: AR+sD100FvFIH6iLxQVpH91VgMnV9ZqbYvWmPyWaGr8QyIeVEVfGoRWCHhmrGw9UVXK
 cW2N2NI8hIdW8IkdcQ4AExBoyTlQQtBm39TISj2+XbIt7oW/MsNj9SSCRzcsC3fY0kMSurSSWeA
 Bvk1Hj8dU348IwCfbDC0RkjTCyNUIjMLbF7inwAPByR9jH34NApSw21KVyk69RG90FtvF9C6N6F
 eHzt47rD+cQWpz/GOAIf7qnOLaBtMpe0sB4L60zAd6zJwybnC1Ng+iaOWoSi46Y06nFe4mMkSOW
 xc7Noj/vhGamuyiiKWR59JWUj7y9Nq5XehfE5/QQWMTWftdiZk08lniI5YGuG4mMa6ZjvkyxkUB
 eG2c8xc45sFINx1mgvYZmfc7GUh29bk9fQy5IUWe4FSDPWSqDJjiouhNrGPLIbmdsGDzCs+GvIb
 sF8B+lziUC5s+2HxA07QMYjqJVKFtOU1vklvDG1xu4UeBLeGmgzs0V/sS046MaybY1YgSYUhmMm
 /VcB/G+lahQZBYX6rJDQHgoqiuJ
X-Received: by 2002:a17:90b:518f:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-396d0ff2eccmr1653428a91.16.1787852508268; 
 Thu, 27 Aug 2026 10:41:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b112b57bsm3778421a91.17.2026.08.27.10.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 10:41:47 -0700 (PDT)
Message-ID: <6bde2090-3e9c-45ec-b99f-dfcc33fcb3e3@linaro.org>
Date: Thu, 27 Aug 2026 10:41:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: clear C1 for all x87 compare instructions
To: Simon Scherer <scherer.simon89@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260827152638.307913-1-scherer.simon89@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827152638.307913-1-scherer.simon89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/27/26 08:26, Simon Scherer wrote:
>       env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
> +    /* C1 is unconditionally cleared to 0 */
> +    env->fpus &= ~0x0200;

Then merge the mask with the previous: ~0x4700.

r~

