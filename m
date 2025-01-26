Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BC5C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1sO-00040J-Bg; Sun, 26 Jan 2025 07:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1sJ-000403-Aa
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:36:27 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1sG-0005xw-OW
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:36:26 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2161eb94cceso42402505ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894982; x=1738499782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IoeRuttxce3YUzAWysd9Jnf1Lro8XZQ+5UYCNMx9YdM=;
 b=CrV3CSoyxuelQL1/EkioGvF1JPjEs9dtwC607Q7rKW/v4Oel/831VCRmhiyqgxPcOm
 bOcWEejnskXDQbyOjyn5sRiZNRB1aQoBGPcrWLbeAf9AwmDgl8cqEG9mwo1d584ddbyg
 AYJ9Zq5uj+SsSb50tcZCaR19Id+uhMXkxKVxtHX7ThpMnW++RA99SvZYthm4k/f9N8pi
 YqK7VZXKE1MZ5nW7OWRP0VQkGRUjx0g0x5UcEopFEDbXoJXvvUCdH4dOh5ht5CvLQs7X
 XQZ2FCzgq6OsN/7tBsxafvYrdFsBm0MPfmC6GJl7xzNDk+gxVz+yDdxbwNTckdULY/s1
 PEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894982; x=1738499782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IoeRuttxce3YUzAWysd9Jnf1Lro8XZQ+5UYCNMx9YdM=;
 b=Zt+p5kfF9iHiIgOQLB7bW9nR94dx2mFHkxZZp0CnDskxyDJ78+yMqPBTBDWAMr6iTr
 p+6e0VWpFwxhs5rtjn9ECziooS9qmWIL+SoG1m7EcRSDbAslUMfYgp7lmXC+mPd5FDNv
 G6vFXoLkBeKWqI3N1VOk0csJyJjG1hieQbBqJG5122da/MtMhBGZEEefOpsFHYFicBYn
 zG4uYxwLB6u+hyCm/HorKOmsC8xTu6ShCXEfI2CrDnb7P8AnwCKaXxUzDu3CaJZGOXp0
 FJsuGD/+14q9S2BmM/RDNLod2YpMTlZamiGKiXZYhj4BUAIFep/Mt/hF0DzB6E7TCEsy
 c3YQ==
X-Gm-Message-State: AOJu0Yy9bka79z6Qzz6nOX16/cmhb5VZLtzrAuS+iY+50+lEAKAIREO/
 Y9tPdFoPIlpfm8qSuxfxKuNUOqRD3dVzZnqCCapIPuPNO9ujCi5AVQWwdceWDICdNBEy7sEsL7z
 x
X-Gm-Gg: ASbGncsMzyDax8vhQsZ3fBtPZXmDYwM2RZxKMQiALNMOOWvACbxYnM3PB/smo8a84T3
 LrNdxrqI85zmehegVoavN7meUY394jiJonFSYDl+GUposh9tAuuBcUIhkfbUyCh15HMDr1NlrMU
 95bCuuwGSVJ1QX0nc10PpQ+Gx0Hlm1RdvFb1MCvqsY4IvLYjq3c8SH7pW2wInw+iKTUGi4vYasF
 SYOrzKpKoLqvLc3K4JTKBOE2GqN5l94vxsBi6f+Hs7CzHOYZzhUej3WJpxrH4CpoJXQDB1Zv5Qy
 Y2akh5DgiSM3sXp17526F5c=
X-Google-Smtp-Source: AGHT+IGnHr6lNdgEvZnwvZMuDgEUyzWJO/ZQ4oYIbL/xkYV1owLJIbw13KDx06ZZi70pLPRetyglWg==
X-Received: by 2002:a05:6a00:1813:b0:729:cc5:fa42 with SMTP id
 d2e1a72fcca58-72dafbaa1c1mr54520685b3a.20.1737894981644; 
 Sun, 26 Jan 2025 04:36:21 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6a02fasm5175000b3a.36.2025.01.26.04.36.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:36:21 -0800 (PST)
Message-ID: <ea49a1c4-2af4-4155-9133-8c7d8cc5f5c4@linaro.org>
Date: Sun, 26 Jan 2025 04:36:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/76] target/arm: Handle FPCR.NEP for FCVTXN (scalar)
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-44-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-44-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Unlike the other users of do_2misc_narrow_scalar(), FCVTXN (scalar)
> is always double-to-single and must honour FPCR.NEP.  Implement this
> directly in a trans function rather than using
> do_2misc_narrow_scalar().
> 
> We still need gen_fcvtxn_sd() and the f_scalar_fcvtxn[] array for
> the FCVTXN (vector) insn, so we move those down in the file to
> where they are used.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

