Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E84ACD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5Ud-0000Ih-5O; Tue, 23 Jun 2026 14:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5Ub-0000IN-K4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:05:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5Ua-0004Ti-2N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:05:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2c6dadfbaafso1153595ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782237898; x=1782842698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nhrvuvq28YQREt3eqZ5yB+evCadboW75+93iOyMNHjU=;
 b=o9fXk2VcWiDovsJg7Rthb0VQXBbzfJk7f3hoghwGDmA8NdJlBBh/cF3x0Vb4HC1I8k
 BUsg6WySGJtCjFJoiF72gbQCSq+OWff3gTv1VpqGl6/7UJtj5crbLDGRhMfljtVIjbIV
 DQH8Kvtv1rH2w5AxeCZgr4vEu0fKndnnM55oTlQQ9OOg1/igqO4jAOPT32YH/FnPqTVq
 7x3nWey0ghQqPYMKdetxEBE6xfgrpwuH3vXpQgql2XiJVQ6go2D+31Rgpgup9nR/EM+h
 bZ7INoi5bR3NF48fdRleo95tyJKooWfAh8qbXpcks44fN3ZDT4CAjPhAjteYoLb5Dw+T
 bgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782237898; x=1782842698;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nhrvuvq28YQREt3eqZ5yB+evCadboW75+93iOyMNHjU=;
 b=IkcpL6SlSYeMZm9NHiLz1RaidQ96o02evXv/Pg+KPOeDdwvvi7WWbB/Kv9/5cvuPyt
 VqlJJPXq6wjiEzHQIwr8Jfhcxd3yTEjEcOLQFqeGVhIv+k5kUDIFK0w4gDgqZG/V2JVg
 GmqRr1IwyiFGp/KB/MRKH+T2NTeoKqEDsx8X5jQyp2Dyvhup00X6HuFDKoC7Cgv3AOyg
 zPyAPQt8jr8sNuNWQFsM6Do9JSMJpywVcQQfx1fO5hIxY0NcEHX2VDhmHFqzAwn0IHGv
 WFpS2/rWR7tbMk/y9/uzUzYz8DBk5+Hg1SmkHOdxIv/GIOrunTHKmmXRB/J2Lp2RsJWt
 EUgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rosr8M3+BmblKAVD0RWYIyWliH7zougydca22IgiRc+v0nvUBWn8xpfqP7urYcpaZL5xCH6ZRHyD/zv@nongnu.org
X-Gm-Message-State: AOJu0Yw7w2eJelirPE2RYUc+G1ysNsKx2XJirSViBVkA1zrDHp4FlgT+
 d+4clngF/bUEdRvpSvWcbyy6Ivgn65O3hsQPyt6YJdl2G0WWIhG6zJUh0wgpyuXowHI=
X-Gm-Gg: AfdE7clSMwXzj/hV53YxMxVhnzfnB5EKcFytTSEF6dknX1q+raz/EANewir3PRtVSNf
 L4sf8oQMUqYJdW8tlxADen2FZ/T6dNxakqzbOd1aCwQq66aWI0gTgZwOd4Ulaucz9kEaDwnBfDI
 87rLfsTnl4qCjP+UYht6Wq4tn/TaW3+fOf7liFFFY1xn8LM95ine1mo47zOYYy4ODjr17+a0bH3
 V4RWYZqay+FDnugEep46M/T6lJWGyh6YwU+BPMh5Beu/uBNABCxXHLZ9zUrFjYzn0edPCDzm94u
 kBUAglpaFzgMq3PNLbQEIGZe8WgVds4xJi4LVMQA0zcWi4+LON2G2jQQEKrV6z1k2Amq7qYQifZ
 kBMarJzeD9elqAe12DKX7m4RAr/uYOs/EObc2MkyG8yegA4KkzntM/uorTFBF0tXnVpfV0VllUP
 0jKwRFvgsZtEN0LWn3HPalpqT1hDVHIA9FliT2ybZd4BUsiFzezhjfPWD+fo7ch2MEdA3J
X-Received: by 2002:a17:902:e74f:b0:2c6:e1f7:b4ce with SMTP id
 d9443c01a7336-2c7c9a2a093mr34134615ad.28.1782237897793; 
 Tue, 23 Jun 2026 11:04:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436af585sm118342315ad.5.2026.06.23.11.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:04:57 -0700 (PDT)
Message-ID: <b2c00b57-cafd-4e4d-b506-9c60d8669bae@linaro.org>
Date: Tue, 23 Jun 2026 11:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/40] bsd-user: Fix copy direciton in preadv
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-3-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-3-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> As written, we copy in the vector and data then don't copy it out, when
> instead. Instead, we should copy the data out. pread and read are
> already correct.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

