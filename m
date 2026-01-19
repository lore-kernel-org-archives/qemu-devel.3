Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F10C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdaI-0003MA-1c; Sun, 18 Jan 2026 19:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdaG-0003GX-4C
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:57:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdaE-00009q-Mj
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:57:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a081c163b0so20252885ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768784249; x=1769389049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7l0jhe1HkAh9tkj/W1Z7gDkgl/N+bl26tdDcNz+ciQ=;
 b=fN5cmCnHBiI1+UxGc6NMhEcRg+tGgDa2k3Z072u/igJkBNFXd06KmB398uD4H3prCg
 /RTyvP+9VBu52G973ZjdWi8YEQnVdGkZebKVBE/e/7j12t1fixxPT5+ZleoA9NYE0Dyz
 1FJAq2V+YVxd1Kvomg7WGD1XWXK0szury/1pCAoKlEfq4S8DhnyBWyTO9ZlrIFoz5eXf
 l4rSxS76+W33XX7BUVfnSWoqrKbhEjJsBPGQno24Y3WgKDlwMHifBLZTYrwb9EF53aXH
 UlBGiN6iB5zaf8LlG/uw56FsJ4iCdbhvN6DLfGLur4cZ4FXJI5SA0Wji2ggHQCwJ5zmf
 rv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768784249; x=1769389049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z7l0jhe1HkAh9tkj/W1Z7gDkgl/N+bl26tdDcNz+ciQ=;
 b=QgRIIlhjp0LGSyzNlEZHMvqJNLZQzkcCP1eoLt2QNdBL3d2dT0+Gkh3VzaHNVZl+Kd
 4jeyM1sCt+CPoTBkINN97PQhqkUvp6fcpckrBbD+FN9KVMvKyz94IfoPKz69kR+euMhn
 tHlZizSMNCxIMTiNbmpY2oH2JtpamolJ9pmA0HOG3v+qOjhUjytN7SOlhmhq6OAQpIeH
 gva9ZTRREL4nukg9cTDYMtdF13TCmun/EzXpffRsnG5/QvJ6lFDG218fBgujKZpJODMv
 G/MDLe4v3RLgbSPS9BRND9esNcBvwzFKLwPbpF/1o9qIwMtwUtds9VtPl5FpBBsB4qJE
 IJRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYAnR65W5cv4B5Mml6CiOBwDA8hQjhefZb/307PVqgEYJKiiS3ZfEviBm7KR2x2cqtzwPhylAVIj1I@nongnu.org
X-Gm-Message-State: AOJu0YxAU/ga6BMSDtkG99CkDlaug81tgZBN+8/iLnWUVNSGYCQni24Q
 QTCSVBbtsrvaSIl97cT084QfDYHRuJxt11LdFvVhGlJFTToaj9f1peDIlnSSiaWfQvw=
X-Gm-Gg: AY/fxX5/yO6V+vg1CANGiMQ17Q4BIih8mS2CI5qB14ee0fa/DNKVFG4WHYX9ZhBnQJx
 DWnE1sKT+0CM7k83l4ChNSvCiHETgATBLHGxpJX3czw89F6pK0d7qVNdcxIH5lTriZiOoEayeCI
 LeVww3BtwpdJAmcQjlBFqC4801RvCEXu4rKbclOylshfboRQYNjJdOgf3yFXX9PfA5rYdCRN8eF
 mVupbuMMVhcRSSsCt0PnEEXZczgyRDFivVU6LqxytdFuV+tZS+tEuIfBow7j5ZoAcme8vDwn6Yj
 uj6HkCyWckrzF3hmp/CAD0HwrH4oHCEcK4oM11nL9wtXrCRc16xlFaOD7U8NNgocm5nH7vy5Tdy
 q1ueW7Yd9P6Jz0Kz2i6fBA6OVd1daWd8hOuK/aPQqSYgSK5xts4V17obau+pGR0j29w7zyBSFka
 5qtkg42ofBlffilCyCsUV87a1NsQ/Rbg==
X-Received: by 2002:a17:902:f707:b0:295:570d:116e with SMTP id
 d9443c01a7336-2a7177cdb1emr85882535ad.41.1768784249182; 
 Sun, 18 Jan 2026 16:57:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352678c69fasm9911446a91.14.2026.01.18.16.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 16:57:28 -0800 (PST)
Message-ID: <0a186e5b-0b07-4979-b576-4ef4107cf399@linaro.org>
Date: Mon, 19 Jan 2026 11:57:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/i386/tcg: remove dead constants
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260115113306.126905-1-pbonzini@redhat.com>
 <20260115113306.126905-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115113306.126905-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/15/26 22:33, Paolo Bonzini wrote:
> NB_OP_SIZES has been dead since the conversion to TCG, REG_L_OFFSET
> since 2015, the others somewhere in the middle.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 24 ------------------------
>   1 file changed, 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

