Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6F8C2A074
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYBL-0000AS-TM; Sun, 04 Jan 2026 19:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYBI-0000A7-Bu
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:10:44 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYBG-0006hY-6d
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:10:43 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so12897366a91.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571840; x=1768176640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PBiesu5Ev2OD7QXZoscUFBdlGUQrDi+h/3tZk/PSx3U=;
 b=XbjQLaj7hwYu7t7FHoESNqftTC4+RIN0C9W1caHkl/on88dxYWrDxdK/tbVKxrrCpC
 SW2CF7+9YYIqXE2dW/x9LbaKq8FMyeu+F1JNMuy4HEiwPiE96KhXBlB5JuFMd3lF75g+
 LgIJ78pip+Mnlca/Jnhd20nfbHcA2BHvwwKKU6UGqZF9MXrAta/FQZvYN/cizi+mByfV
 wC+B+V/8V6qmzPrP1mjNbzYhsRwX6kD3OgSRt9jfV6TsmLI/YBLn42hAmXxotiXT64j7
 LL/OQ7T53JJelYsmi8yKJoKPkxuinRBN4wL1Yns3Kh3Fzfm2pBa6T9Nagle5lwKOeKBm
 Kf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571840; x=1768176640;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBiesu5Ev2OD7QXZoscUFBdlGUQrDi+h/3tZk/PSx3U=;
 b=HkvM1vpfwyLwQwqYh80tTcXCTA/M0s600iEbXG3Z5DanYeFjMoN97dagAxAF17dQZo
 SC5++RYevknLyzoSm8986b73LQfhu3OKNBlVsPtodKqeSlVzMBn9G3Sn0/mLA+g187dj
 s+8HocmQok+8kVgcvcrpXO4GwPZsp7jdVkx2LXv4ZjyKwbERDHi7I4UajfI9TAzDkDu8
 sDNgJPQbakkXIOEflOyonRnx5LOlKwDwMSrAzmnpU9b21ot7g6vbT1hR7d/iGGJQPOn2
 lV1mz/KRhxnMEP+GL20bIv0QXDKuE8NkdwpXhaH1N8tugK/Ng67IbrDL1o763vmZnT9Q
 mEAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoX7tLfRslDXhKjDikmp3+2xAT0vnW49S4jXaQgxuWpkC828Hop7wWeCO3vou5lGZ1HG+h/d/ab5dU@nongnu.org
X-Gm-Message-State: AOJu0Yy06/b3CxmvjKqdViIzhlGe7TrQWE8CoeluKY84h/cK9YbIreOp
 JYRI92E1f5TxyYljas7NZCXgHM9gq9PGetvl4Aijhr/4JNm2UPKfkByuo4qLom/Nj7g=
X-Gm-Gg: AY/fxX5xFRVHFpL2uaEvlrvY9GheIqhJm3Z1cckV0AbbDYE0SQAmXm7BAdB8c8YXZTN
 xZTPliIQHOpMrIs8kvfeoKjxnoKk7y28OfeuDlBkQ8ls3nf0AP+dOCtBpnnXQOhd+xzdGjghhTG
 FDFtg7CVuCU9dGm5S15DVQOjKQfEj+eqcMLFqPaQmXU0BPfWCeaMtJ3KgFCbwzzw45iSX+Ry0gt
 dssXcwTM6g0dKoFZpsHH2y94eTmS/AVY0F+nWZL4noNZ+I4Lis78f+CJ8gPMAu8x8asoxQC0dQz
 fI2yhLGGyhVxAXxS71jblQewn2NI/hA2R4VePJPEn8bdDtHH9/IyvhThA/1zM0Gv0qZFpzn74k1
 4MjbVkqbq+dBEOGRgcyObhGDi0/atMPC2pwUvgXVoTT4cmP+deI1PXvkwuvVBjku1eJpVqEQS96
 EkeDiM5ypuExL+hg0MSVQY+jq5u2xEEw==
X-Google-Smtp-Source: AGHT+IFyDeybToRirfPsPZrbYHBWLa6rZIkzWRvbLtCaD/cxf0HhmUfq7rvo3PskgEdnedW0O5AEMg==
X-Received: by 2002:a17:90b:2585:b0:340:ecad:414 with SMTP id
 98e67ed59e1d1-34e921e7557mr44261764a91.27.1767571839671; 
 Sun, 04 Jan 2026 16:10:39 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f477262fbsm4451427a91.14.2026.01.04.16.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:10:39 -0800 (PST)
Message-ID: <88f04645-9ce8-4efb-a26b-56712496930a@linaro.org>
Date: Mon, 5 Jan 2026 11:10:32 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/openrisc: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224161804.90064-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 12/25/25 03:18, Philippe Mathieu-Daudé wrote:
> The OpenRISC architecture uses big endianness. Directly
> use the big-endian LD/ST API.
> 
> Mechanical change running:
> 
>    $ for a in uw w l q; do \
>        sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>          $(git grep -wlE '(ld|st)u?[wlq]_p' target/openrisc/);
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

