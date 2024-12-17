Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E84FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 21:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNerN-0005K7-UF; Tue, 17 Dec 2024 16:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNerM-0005Jh-87
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:12:04 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNerH-0001Gn-GL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:12:03 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso2422794b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 13:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734469918; x=1735074718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iVQheL5sfpfsPf8LOc0lx9kGU26P7wcAvZn8IDeXaDs=;
 b=I1Iknq1I2q6c/qLjsa8lVFrvUqkYvfn57isOo14Bzh1fX3Q8wztlCbICAuELCQhqfi
 DtX3gxQfUCtlBFOT/dTesWqw28rp63dyfY3RRFpIXpUVBfw2q637HaNKKkcBl509hSQI
 x2Z6cBgqbdZ/UkiVahCrQgQbjgPPDslKr59224/znMWC0ArE83pVHUCiVunBN+UEXI5X
 PmQRmrQELCcX7WisdlRNT0CEeUutPv7LB7uVYu9YgTFnhD4R+qmGJvG98fxNdRtqn+b6
 mp2VMbZbI8Ax06c9QsRNNj7hgPLOFFi9hCeL+4h/tiDU7yeDeW/csF1YvsuJiTnFOO++
 3AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734469918; x=1735074718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iVQheL5sfpfsPf8LOc0lx9kGU26P7wcAvZn8IDeXaDs=;
 b=AkyUa4fY86goOVL5X0ixfP4yaGR907oFzlTq9cmrdaD2f6zdqwNCACHbcTVtUqilcb
 uHc1Ge478NVCsMfteK5W1zB89bmebXh8QIvB3OsJ4skbqX64UmlQGccZ6dvNnOh4os9V
 4CmxUEO1Pc+DKtb+NO4AZy3aGXJsUaT8hzW/58EYYZPMCHXKpYEcZ8c4lQ02rF3pv9QA
 18fLjZvmyxStvDLfyEyw5akA6vLMfFAfT/0sV7tulAtrCwdEWnixD9p7DVWuGMBbmIJg
 KAgOlNY5Qe6yUbFtIrpBaY0SUIDS6hG0oDzDDL6HyF6Jg0XP9UglChvsE2TKp8wR3VaS
 Obnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2dOQ9RcMxpqd7b/rWa40CrHeYQLWNXbAmWJ/CzoVHj6GJyxASZYLj6w2Liu86saGrq54vUa5+UfLf@nongnu.org
X-Gm-Message-State: AOJu0YzS874IPRpkzbOi61giuHV1O/SMP3dA503nT3WtRi9+08aungpN
 /91PA7LuI8WvpxHh9IEl9Td4BiJw2n6Gt+dp6nTgdrjvLeoJv07lkLIHc7WwfDI=
X-Gm-Gg: ASbGncvbRSvmeKpYvChSbpxKZd3/RTYx5prQWpReHUa4vdPFEn6hwnG5c9kl67Zm2/w
 S3s0zefbnzGpNdtnT2KqyZ1moLMRe0D8Dt5Nj26jytlAXMX6Vw+q3/mpzPjU6qBALOLh0QhK4q7
 jdw/L/K74EL6PJMut2+FClG2ZdEWJVcZNxLDkgW9Px+xOZIsUBJa8u19qc+hX9Lj1p6w28rgEie
 AFO6A2RzFcrJf9Wvd5YG3s2NWmhIf9dsr49nQNxewHbbP2cUn0zrYfIvcasfm46B8/cJg==
X-Google-Smtp-Source: AGHT+IGc0fR6JkKqsCulnAbjxbUeqxVzDKnuT4Q/Fdm4CxYCxlBf5p7HrdWfysAuWRzRjXEoaWkJpw==
X-Received: by 2002:a05:6a00:14c8:b0:727:3cd0:1145 with SMTP id
 d2e1a72fcca58-72a8d0313dcmr646758b3a.2.1734469917761; 
 Tue, 17 Dec 2024 13:11:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bce39csm7362539b3a.189.2024.12.17.13.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 13:11:57 -0800 (PST)
Message-ID: <4ba9f5c6-9ed5-4bdf-b4a7-60ac420fe9b7@linaro.org>
Date: Tue, 17 Dec 2024 13:11:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/bbv.c: Start bb index from 1
Content-Language: en-US
To: ckf104 <1900011634@pku.edu.cn>, qemu-trivial@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20241217142413.148978-1-1900011634@pku.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241217142413.148978-1-1900011634@pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 12/17/24 06:24, ckf104 wrote:
> Standard simpoint tool reqeusts that index of basic block index starts from 1.
> 
> Signed-off-by: ckf104 <1900011634@pku.edu.cn>
> ---
>   contrib/plugins/bbv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
> index a5256517dd..b9da6f815e 100644
> --- a/contrib/plugins/bbv.c
> +++ b/contrib/plugins/bbv.c
> @@ -109,7 +109,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           bb = g_new(Bb, 1);
>           bb->vaddr = vaddr;
>           bb->count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
> -        bb->index = g_hash_table_size(bbs);
> +        bb->index = g_hash_table_size(bbs) + 1;
>           g_hash_table_replace(bbs, &bb->vaddr, bb);
>       }
>       g_rw_lock_writer_unlock(&bbs_lock);

thanks for this fix.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


