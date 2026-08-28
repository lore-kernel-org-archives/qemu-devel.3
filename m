Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB34C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x04kN-0006Ns-Iz; Fri, 28 Aug 2026 18:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04kL-0006NC-VG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:08:25 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04kK-0006yb-Em
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:08:25 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1784200a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787954903; x=1788559703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k3x5VxWmaVwVHTL5q5lon6VPfqHRA8pu8djxPN/7Gjg=;
 b=sWUZuMtz41pv32ghU+m8oGTJaba73Ut+qtdbwnutCnNu1Nh/iIQUzFz0Pgx8Wa35Gm
 Yp4yr99N7rUoRfP1FBBHCIY/MvnTkMR8A40G/3BNI7ggIvW1uV/wQZTQEMGQxi6ORBe6
 x0v4YJbjl9B7fkQVKKvPaO/CfDFv3Vl8YrmqGPY3n7AQ+zuSK0jR0327pld62HwuVHQL
 LlPX6EjvdI12oVhglHD43F4Hv66ajFxC0dWN7w7RwCwq3g1tUbecCeBvOrnPnwtR6Xif
 CpSqTYoB8d/hN8Ur+9Q1VvWmooSVBecrou39D6nR1SZw1mod7fRbKI92g9Ch4lXwoBQ+
 qBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787954903; x=1788559703;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k3x5VxWmaVwVHTL5q5lon6VPfqHRA8pu8djxPN/7Gjg=;
 b=L3Yt5/JKEpjxXQikSqyZG2uJsju6cDFtk/0SegBwyBURGg/Xs9JYm6VWhIg3KY8opa
 RObXYZ+T7Fio3n71f0/g7l4mTKK5dUvnjkfbqbk30iHWZg0CgEXNGGCFSfjbGiidO5rJ
 7sxVenNWPV85+pC42W6nFvkJLQaqWAgcRHQfpHEtwJnXHc0piobIdrc4h/K2+SaqhVCT
 Ou9NdqxxPNhTDC4Dr6U2qpEYGryvCP3ZF08TM+DjliNBQQgdAkdO01Z7F3iTBz2ftwPh
 CexJGcdO0k3tBPfLzmvj/mgyiVSFrCim6HBzEperLBHN+2wKXIIXLuL/rfFM7dpJ4Qs5
 QVUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwlScrd87oeIr439lcA2MAW71tvM8xdx5gYArUdfABy8eEEFS6K7TZ0ZqSbk2DpRbz4HSWcFHmfaE7@nongnu.org
X-Gm-Message-State: AFuF++n9iPe0hFj50zllEdEs1uHbbbxtHQbl1A70HfTrmqjPSRce6Gvo
 H0tArrC8erVJ7R9IA4JiWbkGG8Fz49O4wr5HCkfPEm0EmqQ2Wni6gYg8e+b/gum3ZF0omdIR6PO
 nqTAYkBw=
X-Gm-Gg: AYBFou1Rfkzz5gZ35HdtTmIrnwbirvWh1+bmqXYeqrbqlfSgpG8nUScV5AUR20/PJS7
 QBS/0jqnzCA8I3ErwDnqEspeP0kbZP+FHWjW9FH7TSxwgNz/PsJoYBFQZhHQAIFotYiVdqo0KC5
 O3BzbI70eJCWIHVbfY5U/lbuh62g05VixTuRw3ns4tuI6znJmjjOGi5bO0e3FN98MUKjHLmGaLX
 sBPGW47DRW39BhaEg7rOV4xBEUdW/jlo+nrw9kj33b7VfqrlqOiWHAUDCojKMCMrNfYV3pVxsfa
 CNVVf7x404caC621pJzXUHVzvmJ20vplm7SJraMZBGntfFuHKftXu2QjLVlQO5DrHB9RlsQf8zf
 eXmhHXIrF1bCB8ejbZ5xINHL7ZVEFKaLhP0MnVAgeaEOLQX68UwlE1PGgEYrLbN9D3AVuiCM8BN
 8GFiFyw9xgXy/fefnlRIqyYI13M3Mlf4NJ7ol4yH5tRwdTGz7l5PWYGaYUJWimY1VwSAbzqLOHV
 zwlDKkretoZSnQgMCSvRob4LXGaOsg=
X-Received: by 2002:a17:90b:3a05:b0:398:9be8:ea69 with SMTP id
 98e67ed59e1d1-3989be8ead8mr4226861a91.22.1787954902770; 
 Fri, 28 Aug 2026 15:08:22 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b19927a1sm9426845a91.14.2026.08.28.15.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 15:08:22 -0700 (PDT)
Message-ID: <5c338e88-51f6-4c87-be1d-fa033195f204@linaro.org>
Date: Fri, 28 Aug 2026 15:08:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 045/105] tests/tcg/alpha: user tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bibo Mao <maobibo@loongson.cn>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-46-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827221506.91574-46-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/27/26 15:14, Pierrick Bouvier wrote:
> Tested-by: Aniket Sahu<asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/alpha/Makefile.target | 18 -----------
>   tests/tcg/alpha/meson.build     | 53 +++++++++++++++++++++++++++++++++
>   tests/tcg/meson.build           |  1 +
>   3 files changed, 54 insertions(+), 18 deletions(-)
>   delete mode 100644 tests/tcg/alpha/Makefile.target
>   create mode 100644 tests/tcg/alpha/meson.build

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


