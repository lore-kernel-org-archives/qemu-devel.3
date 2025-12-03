Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE36D1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 02:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQcI2-0002az-PV; Tue, 02 Dec 2025 21:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQcI1-0002aL-5r
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 21:08:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQcHz-0001km-CA
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 21:08:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2980d9b7df5so72935745ad.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 18:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764727697; x=1765332497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jCv4erge1qxp12sgEIYuHn8oVSY/Ugd2Iae0C5kY2+Y=;
 b=JMBGPCb1YoB54eGU6Gd8NCgMxRzsLpQaL8QXHdwujuqbabttv4SHeBfzQhBdXizgOD
 hCCo75QEszNt+7KxTMhOtsD8W6rE6FFCaFGmoqGH9Od2aZdMGUqARcbSDEUaovjAFNGF
 C4aTGL2rOA3zIifwMApb/LFZ/D/iVERRTdyLRBq3SS5M8KCbiF+kWu9Cf0LbdLAykn/2
 cRRyROQuFqOpHkhFq/OJeuo0FLQIbevcKPhnlnvlZb104uqReiuAaj0k4SDHDznOUiof
 kqnbrOtmNNmuLYP8V9RAPf9in2sfgBhkXvJyNaNnrJtUnr8I8r3zkQz3EYWBtOX8IjPW
 th0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764727697; x=1765332497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jCv4erge1qxp12sgEIYuHn8oVSY/Ugd2Iae0C5kY2+Y=;
 b=sU2xlc4eo3WD6BuBjNhuxTZNOVbDWzdb3NYFrGNakh71ltMz+Y3yUD/DY6sLUV4MAZ
 u7mYXTJcJtoknXz/IZwNsclW4fDun63/tjxIZqOIDpN/fx1fs8dEVL8xsDLfexBO8Qjn
 NEafgrdHJ4rrwZEnLO2MbYKfQuVqxJbgEInuTRB9aJcxLhBG5X5xDIvl99MOuru+LRdQ
 en1gfFeT7sk7oWppJbKhsCSO3kkGsAZiphcjHivhv34eWQlxNkiIOOrYMNPi1xQDzrRZ
 Vd5fFhop6F1uwjd7zYKnGpdP3M+Lrp3r6kqt6ZR99bQ+numnQe3SylkwnLj9be5LPhDV
 I6Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRQ18JcmVyt3dpaaYQbp30GhFupHtUbf6TXOsJRdSxSxVKHcKzOkTZcQAZyVosYC4RdLoAXmO3/ZmK@nongnu.org
X-Gm-Message-State: AOJu0Yxkkp11kUIBEHTHYP7a1I4UmYs6NaMl7h95I4iq/xeOhz1AUr5V
 SOs+oawWZ5U9gbXzKD07EC1tjYxyJhzismOGyYHZbBgEGtOrOkC9nXJ3u0upf//M9No=
X-Gm-Gg: ASbGnctzHH0E6iAIrxvnE72Prwolr0V+8yWaj3uTtR+k8R9Vxg7kDrP4710X42MikSM
 yweME0ic4qI/wsx9hNY+yBLRoe+/+p5KkYeFA4wqgZOkVsZvqZJtocx++gP3YOz8oaOTNwFc/IQ
 qnApPrLobD5qGrnUQ8r6J4ylxBixfJiYooaab3U7o2G78U6FV14/spZSG3Qk2kTmi7fDOUCVhFZ
 +H7LxKaYefsXJeQEPyD8U//cDAI0/ABHDZoBsl+W3nHdSTFSR4xxdDWhL2ZDGvvNFHSBp7kErcu
 tCtz2o3DaWBY2OUHR4qEY5BV20Pt9HOJd1N1/F+bPIqiZj2hVx1+LkYu4dEe5MqcV5EPysRlIo1
 K6++NQKgJztOWKiErzGbzlYKzfTiLNkviByov78/CpfxWpmGfQoTuMdzKt3sHpaNESh29Z74TjC
 Cx0X/C1d+AgaXmVOgFRLzIK34=
X-Google-Smtp-Source: AGHT+IH5vSN4Zgq5wr74jPYNxiOdhcRcrxLvosD6DLyEGaRv2pzjo3rM6uqjWGbUEvJL6TQ7Kna/4w==
X-Received: by 2002:a17:902:d4d0:b0:274:5030:2906 with SMTP id
 d9443c01a7336-29d683b08c9mr7038145ad.46.1764727697068; 
 Tue, 02 Dec 2025 18:08:17 -0800 (PST)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d150b68367sm18511178b3a.12.2025.12.02.18.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 18:08:16 -0800 (PST)
Message-ID: <f4597ca2-5e75-4050-95d1-64239fc90530@linaro.org>
Date: Tue, 2 Dec 2025 18:08:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg tests: add a test to verify the syscall filter
 plugin API
Content-Language: en-US
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20251110133442.579086-1-functioner@sjtu.edu.cn>
 <20251110133442.579086-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251110133442.579086-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 11/10/25 5:34 AM, Ziyang Zhang wrote:
> Register a syscall filter callback in tests/tcg/plugins/sycall.c,
> returns a specific value for a magic system call number, and check
> it in tests/tcg/multiarch/test-plugin-syscall-filter.c.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> ---
>   tests/tcg/multiarch/Makefile.target           |  4 +++-
>   .../multiarch/test-plugin-syscall-filter.c    | 20 +++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   | 15 ++++++++++++++
>   3 files changed, 38 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


