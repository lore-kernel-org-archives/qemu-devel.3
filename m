Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE8FCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgu3-0003fx-CM; Thu, 28 May 2026 16:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSgu0-0003Xq-6J
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:00:24 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSgtw-0003gs-2s
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:00:23 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-368f25ff4c4so7627822a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998418; x=1780603218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZLtWAblyRSu7LvWSy+oeSFyJEExHTciFgWuOWW8KVo=;
 b=TIpe4ZR/WT2oWvZuKsD0IynrosI8L9rNFRR3m/v2OryO4cDCQtjMkXeuDQooVJ38es
 aGDT3XUcvFBLQg8jga6EU33OIv4maGA0Nji/wRu85s7xf4btBIDxTxlP7ABqQdJnITvc
 bFBIN0xyNqmiP5M0kg4a3uvPNLlrMUv6Bzz4FKG+tsJJP30Ii2CcrLUNHDjP8CVvF3WM
 eCBqP8+2rkuJLR7SEAVi9IMpK2ECcDQ9HWMKuFW2QJpp8sI3hF1YqB2axpySx3CDRUDO
 mnvvKgoFM/2DI30UbVrDwh2Y2JyDK2lEG9lh45gsbL/OZQDfgfnbOeavGyTqp0qN+XAl
 piGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998418; x=1780603218;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZLtWAblyRSu7LvWSy+oeSFyJEExHTciFgWuOWW8KVo=;
 b=EOVMKU+GzhBNChchtQLcDlpBxrMyffWEzXh3xQaE/QrwKByBbpAYXYsmF7u/D3vDUi
 KFxit5lzQY9AfSRnj+2mspGW57tzYkeepTFQEogJW/j/nRou6bSVJ/bikPHJ8HxTOKWo
 2vva9pl04oL6CorsMqf079UTx77JjhaFL+VakRSDiB/Bty5owWGqSYRu/mTYDhonyyFr
 s/PxNEeymiML3xW1ylL4m7cEvhCq5XgFg3+jwG0z/qNQbLIxPCDVJkiQC2ztialgZBfm
 lrkncAlYSJreAkOHf86bcg1GbjIbN/qMrLP1K5iIEQO2k66A/1yEzlt3kcFzYqLItHpI
 w1ZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zSTrYrEf5W6d4/kFntYyZsB9079l6gOzsSk47Ge8Dejnhhpr46U0zQvpHh/mVmPVBkLjxlo8bV/DT@nongnu.org
X-Gm-Message-State: AOJu0Yx5egcJTfu4E6325s3Wi1lT4vBBAuBJEpwyw6RSixrTN3Grlahm
 EPB+hGfg9k43Ipm8lFQmuRYHSeqW4a2uzTF1B6Gn6WeaKgJwE/Se76dMN7NDagLNMi4=
X-Gm-Gg: Acq92OE9F8X94vDt1F3MDk8TU8He0cgI7wqFsgUi0x5QDUVfhGoZ05tq722iYPbPmeN
 K/mYN5dKcRmAJ5AgIiINvFYCmExu1aPPyo0LxchKgAApf+UEvY7FgdI6fTwIzeURItj5YBnyQZ/
 KEWErfP6sUWh1AxwGHSzmVCnYEzz5ptTY1xKLu8gV8XUXOwbW79/CfSDQtIlUTz6RwXy3K/QBfE
 JxKxFX7O+EW7q23sw2qPBPUfK3pnCUMoPeUsiMhz8xwggrjQJuqYpzxT/uUqBEdMu9DB0BI04uI
 T+N78r6ZSSGaT6B7ORboYD4fhMp4hpaYMLKGi81rREyoIX0DW3xQob/P1y02OWmLIy+9WZIDeH/
 MQP3TWLh5Y2qWkVieyHFZ05BJ4xZ4mO/QlXQOKG3tcfmyFuyumZxPKCzepKd7GjFZQVjzYHcDGW
 zrPa729lfWZihfKREv2feSOcUKbDX+anFBa7l9d8b2I0QPjBs=
X-Received: by 2002:a17:90b:3a50:b0:36b:769c:e5bb with SMTP id
 98e67ed59e1d1-36bbcc145cfmr53578a91.5.1779998413045; 
 Thu, 28 May 2026 13:00:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b9092ff50sm2189180a91.10.2026.05.28.13.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:00:12 -0700 (PDT)
Message-ID: <cf5b2f6d-fbb8-4c9e-8ce6-94fecf2b6d9c@linaro.org>
Date: Thu, 28 May 2026 13:00:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] accel/tcg: move jit thread manipulation into
 do_tb_phys_invalidate
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
 <20260526110243.470002-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526110243.470002-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 5/26/26 04:02, Alex Bennée wrote:
> To invalidate a TB on MacOS we need to enable write access to the JIT
> buffer. We were doing this for tb_phys_invalidate__locked but that is
> not the only path into do_tb_phys_invalidate. Move the manipulation
> into the shared function that does the work.
> 
> As a result we can drop the tb_phys_invalidate__locked function and
> update the calls directly.
> 
> This enables watchpoints to work in MacOS TCG guests.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3444
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - make everyone call do_tb_phys_invalidate
>    - tweak the if statement so we don't miss unlocking on an early return
> ---
>   accel/tcg/tb-maint.c | 43 +++++++++++++++++++------------------------
>   1 file changed, 19 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

