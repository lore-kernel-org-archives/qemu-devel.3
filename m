Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0739AD41D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 19:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTmMS-0007yu-4o; Thu, 11 Dec 2025 14:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTmMR-0007yf-AQ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:29:59 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTmMP-0004zY-UV
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:29:59 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-787e7aa1631so6876007b3.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765481396; x=1766086196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mevbxx7TpgNghiIVnIYY7MqpGnEtW+DwI5lNA0XJm5I=;
 b=FRslLoh4wgUdOcJIj5Y8pQ2Cl5rNInS2iQjT1CxGRPkJGAXThl9omGAyr2vS/YVgR5
 UvlkkYWCxSYQsNUiJbFNdQnG83O15KxugCCCHlvo7nN0rG44GjOsVtR84kDu/oT70rlR
 ZtyT/qLjYM/hHqLrowLi8ufymGkXt4negwRdMynvTjZiDHrsWnfLC8yw5zI8MJn7M/af
 TUSxOhbJoEPi2sl+KSlThyGUMigxUe0sLUU9tqlO+YGPAVjZHQsrkW7jIgsuIqeuuZsA
 /IsncM1NvMH2vBWmmbv6T2/1HLoiVWtZJnsvnw0IbWBOKjrJmtqRkdtTIgMMlNM10YsH
 J25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765481396; x=1766086196;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mevbxx7TpgNghiIVnIYY7MqpGnEtW+DwI5lNA0XJm5I=;
 b=p+6n4Nq6GR8b3FdTevDS4m78jc0+hwTPZSNYePLnt9Si7a1HqI7X0e2nauir8ewfuq
 yJMoVOMTWqElagT2mOJy2NU33PFwjqGf41jpuuny31QoeWfxyH0WCQ2QHK48lCh/YvpX
 TI3QgoL1CdC466xftQy6KZpsqov4eCMiFLwdGHJt7kMlRhzQiyNEONsYByW1Ge2y+rMk
 Muh7hFG9x6BborCrxseIOex2ZgKbBlG/wBuaYzVySYBcZQzoRg+jQXyPjlAR6MjOe1/x
 hkxs3svqa9TSS5qJJG2EPT6xd6xPXGJTJ2G44jFPcSQ3jy/bGHaul+ohTP+Hqq/xmKKy
 pHDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+U4rEtOLOp+15iUrUgQZA6fpIA3F9lCyhLUhPpxhb2OgRxXmXbDdRmD7Z+QBnZ++9t9ra+YYjk5Ac@nongnu.org
X-Gm-Message-State: AOJu0YyU3vkIhWzTG9n71XM/mKR7hXU+4xzjhzaGYRfSi4yfXklJGfBx
 MeIThQW30Rlu5y7EUrWKvWhLnWC5+uTZxjo5JLzuyqzsFHx8/VPk6z39m8oM5l5SMo/5BH8CWQ5
 GOH5aJMM=
X-Gm-Gg: AY/fxX4VevBehoPM3wmtcz39kKEVD5KWqZ6eJBTeatrXqBJKu47Ih2ZW5zvb9zcvyLm
 XsB4ZpOBzNkCfNcQRHUIbQPkA3GK7k7Ru9EXPePVq7xPN9aYaThoRqSLAKlNSrB0D4AWmJIUf9j
 zAMDVSMPJzV2sv3MvYGoY91VlRCCobmocyH+llsQG5lyC2nmlQeeV+hhS4y1bGw0yzTbWb9fEoG
 4tJ+yfd/DoAkB/Uv/5z3h464//ozrLTRgZBYwbCYUbkWFhjsweLepHTw07LSirHy+cfd8XF6pTk
 mHfDzOJwaahbIhsdQPgsZilo73gCksB9/LBPgbZM3huRhtuXr1TxrNnb13Q7bhwn5XUjoSrhD5O
 fJlZpfmHe4r0mdqpkR9Niuqdn6rYMIR+0FUd2MWHE/YO46oIaqw67D31FO1zV4akxdek+b19RMq
 /hfhmpQLg1OafxzpSWbKvFylY2Wu8Ihmy3HlRDbP6qFnXp4JB+57fJSWlKj5RBq0+f2ujibJXku
 eE=
X-Google-Smtp-Source: AGHT+IEY+c5a7uFympKdBvLDH8O408wxMH8prNbxqb0ecxHcnxEn/udNNv6Q07kM/Pez8iM+yhgnFw==
X-Received: by 2002:a05:690e:1409:b0:644:5317:4bd1 with SMTP id
 956f58d0204a3-6447a774aa4mr3112006d50.9.1765481396429; 
 Thu, 11 Dec 2025 11:29:56 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-64477d58416sm1516522d50.10.2025.12.11.11.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 11:29:56 -0800 (PST)
Message-ID: <56f7406b-4bb7-4dda-85fa-f9109eb22e83@linaro.org>
Date: Thu, 11 Dec 2025 13:29:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] target/i386/tcg: move fetch code out of translate.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-19-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112d.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> Let translate.c only concern itself with TCG code generation.  Move everything
> that uses CPUX86State*, as well as gen_lea_modrm_0 now that it is only used
> to fill decode->mem, to decode-new.c.inc.
> 
> While at it also rename gen_lea_modrm_0.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      | 271 ------------------------------
>   target/i386/tcg/decode-new.c.inc | 277 ++++++++++++++++++++++++++++++-
>   2 files changed, 274 insertions(+), 274 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

