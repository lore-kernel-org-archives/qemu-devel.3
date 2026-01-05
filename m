Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF1FC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYtZ-0004sv-Im; Sun, 04 Jan 2026 19:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYtW-0004rN-Il
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:56:27 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYtU-0002cQ-PD
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:56:26 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso9315665ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767574583; x=1768179383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zj8DNp8hBHuwgo4ov7ZWSPxGWbNbxgeI8FuxewYFTHg=;
 b=uDY8LCAp4CKa8uAKOslOD8lf6T/gfaSgZM19kV/xirMDifHWg1vQeipqGniUBuxCr1
 YkdVNHJetBdOkDu6/vrVW/i96yjkxkJS/GfEntBzxzqs/kHS/h3cjK6Fl1Pki7AStM4G
 xvPo3aOHSgtg/od2r57AYAw6MyWjsxt9UW+WAISmmtZwxixs+9SToWeenvaJXc7e3i3/
 keZLw6/roIYfWp/LYqqNG5cFf3uloxUw2q+m313N6r++IS7Leq6vYbhZls4p0aB+alGj
 wSkaa8Yx2z+4GTSBvfcvovW8E2i0fXbcNOpAesfWktYVYZU1qWvvCa+RvaiEdUZctZsI
 fjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767574583; x=1768179383;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zj8DNp8hBHuwgo4ov7ZWSPxGWbNbxgeI8FuxewYFTHg=;
 b=sLzQTPe0xcAR9CxyNas8z5T+WZ1hBr//pAW4LSQcbBG/GOaHYvlAfWe5MuA+cOKaHW
 LwnSnJzw4wuLCTXRO0U3eIE+G1oPOPUBbdLW8xnK3gc5x73TBYUx2A0PpyEL3ySD42UY
 5eGCxpTLPnpVU4KH6DyQkp4Te387/0+P9mVc3eC8T0AqfWPi4Bjhpl3c52oyFila1T+z
 rO9Lwb8uFDk8U1B2sAT5qD3jewt6G8vZiuCZ3JmTcDYhkWZJV9/dm2pLuPxfT0YI9wn5
 o5FZtGN9mmQ4sJZ6XgVUV0BfLRNNy0YYZ6o9iQIC3kWKpA/PD7Iihk5WNo/j1aXGm9YU
 s47A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLzT+Tj3gB/Oihdb6ySXU2+1Kc0zTiLIKvtqBLNvU8uEXAb5RkrYI0ErAwmc55SSPYx8Wzn71odwmI@nongnu.org
X-Gm-Message-State: AOJu0YzayXlFcWpB+E3ZSe/VCmZK+0GBaka6BFAhxo5zr2A/GfefBmLi
 NLnmBw5XpilYeDT5f4/JZFg1JrMKAb4DprZ0jd6a7ZusC6ArC4ePc/GmJMhwsynbfgk=
X-Gm-Gg: AY/fxX5cEqg8A0Gyuv8pibgJ1CDM8//bAcsCxxeL2nfuZPoN14PqLlt08dXmH6uOfsG
 2sYPeMYhM8/dpaNRryLuEVsR9jWt8tI1N742sr2y9REpiHVrMslriTC+CU1f3C/Uom3+PRsdvUD
 4ffiMUN51z01FYJCOnjUd3EWTzsLoNzST9gQmrDtoI0JRYE2/+3UMCEJ1+Mod1D/O3agsPe7cnI
 Z+4QeXSiJ4kxVHq2aJWQWw//9aoghkwn9z0tBsWYbyzgeuHc3RJ+VNUxhSFJNhnftUlKOK3m/bQ
 lQOP8G9FVwMnNHtgpZsfw8UOlxEdYVnRg4NzUduPD03bByohc5NLWiThIoXQpxOFcpQeCoCl55S
 4OvBLXdbqv6o64mjaz7HBxJNb2BEbySzCfAhkBHMhuz3wzP205yZYwyB8ja/58/uxx/V1eGU3Hg
 gkcl/nrAi+cu2A2lT8dhuQlXJzzIsoDA==
X-Google-Smtp-Source: AGHT+IGEbBh7VtkJG1Se7jTK7P+VhtWmA9/Nlpt7fXELNww49GvvkszjmGzh0oNE23b2s8YncZ7Tpw==
X-Received: by 2002:a17:902:cf0d:b0:298:639b:a64f with SMTP id
 d9443c01a7336-2a3c0956151mr52856335ad.6.1767574583035; 
 Sun, 04 Jan 2026 16:56:23 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d658sm428712975ad.78.2026.01.04.16.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:56:21 -0800 (PST)
Message-ID: <439ea357-56f1-4619-a6cb-2cc6ef2774d8@linaro.org>
Date: Mon, 5 Jan 2026 11:56:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/rx: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20251224163304.91384-1-philmd@linaro.org>
 <20251224163304.91384-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224163304.91384-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/25/25 03:33, Philippe Mathieu-Daudé wrote:
> The RX architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=le; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/rx/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/cpu.c     |  2 +-
>   target/rx/gdbstub.c | 24 ++++++++++++------------
>   2 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

