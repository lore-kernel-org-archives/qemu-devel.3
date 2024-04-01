Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A9CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 12:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrGTk-0001w2-K7; Mon, 01 Apr 2024 08:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrGTi-0001u6-AM
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 08:09:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrGTe-0003n4-PJ
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 08:09:28 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56d7a0cf96cso2720861a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711973364; x=1712578164; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BXF1duU1OKGXKLnQOSqCFJnQM4bRh0O575WQTsd1kOA=;
 b=ddDPYtqVLF8sV9HgZgPSVMc+UbF+jZ6tgKhXdzokUve6awo1URhiQED13HjCC+RfYA
 2psq6KJQZfIMjVXHGTcwBBCuXAScc+le1VZg07oAtZT0H1FkDMjmjUG3uQgRu8kXlvoI
 NHjDVemVWGzx8AVzptElOyCsqGcVoHVUbcc/tdpz3isiGeFNYBqUqQIcNNZunTjGhAIk
 sBX5HnWsk0PcXWmsX/bg2zZHgSJTn65sybvGjWgqAkBP8XHaiBOtdpH0zpgg2ZYU0nqE
 VhkCW0MITtDFZDRcq4xsf9mIiB+OfyU2ZVP+stcKYtuCo9CgNlTNyy9soQ9rv0aCRnYa
 b6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711973364; x=1712578164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXF1duU1OKGXKLnQOSqCFJnQM4bRh0O575WQTsd1kOA=;
 b=dIfq3iuho6L80TZG8IaXzjOmDxjew2XtvwW+JTvODNNp5qdkXx7Imd8ju2bRn9Ys/x
 IprtjjLD7Z51ozCsPwd1gS8/uPAVUnf8C27uVP1K7MXUcgZJNtUcK+/C7wCXGzgI5FIE
 VFKuf5f7jxet1CA9gcn/8+n2fwKCwTJtPHIgG7hExupAzO/xS3XVCyBECBmz4mYlpZSb
 RtylIFpWiuqkBG+8cSmMJ9XlFcmBK5EvFsDolAYAB0HYVpbN00/V1SLB5BwZEaqiDLiZ
 2HpsVYP8Q7CrM+VeFJz/ACTNq80J6BNR6atD1OCMexkTPHHQ/xON00IbUnGRoO7mXU0l
 pfYQ==
X-Gm-Message-State: AOJu0Yyy/ph4sqmigLDvH/mhWm3+gxjHY9ktykp+WYcNspMmq0C6XNHi
 2raWUR4fITqKWxi1KrlIgT7PYMsnoe9gRnG0kPZM/CeIVG/QvjmpdGu4VwE6DBpJMaSwiIzCXXz
 n8nyvCzuintUrzpdTOgmdLYQwRSjdq2LV696QgA==
X-Google-Smtp-Source: AGHT+IFLaWV5lJWrO1t5fF7deF5wbrdLkgrQgE9Gf79xJRAXnIl+i0Nh08nKyCXoWtUecJIDuVszKd2sy3c/LogNs58=
X-Received: by 2002:a05:6402:5112:b0:56b:a03c:4eb with SMTP id
 m18-20020a056402511200b0056ba03c04ebmr8582274edd.31.1711973363959; Mon, 01
 Apr 2024 05:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Apr 2024 13:09:12 +0100
Message-ID: <CAFEAcA8m8nGfqbZDe7TgHT9uYSR=aQBaDOB+ocNBMWr9bt=3ow@mail.gmail.com>
Subject: Re: [PULL 00/18] target/hppa patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 29 Mar 2024 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:
>
>   Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-pa-20240329
>
> for you to fetch changes up to 4a3aa11e1fb25c28c24a43fd2835c429b00a463d:
>
>   target/hppa: Clear psw_n for BE on use_nullify_skip path (2024-03-29 08:15:01 -1000)
>
> ----------------------------------------------------------------
> target/hppa: Fix BE,L set of sr0
> target/hppa: Fix B,GATE for wide mode
> target/hppa: Mark interval timer write as io
> target/hppa: Fix EIRR, EIEM versus icount
> target/hppa: Fix DCOR reconstruction of carry bits
> target/hppa: Fix unit carry conditions
> target/hppa: Fix overflow computation for shladd
> target/hppa: Add diag instructions to set/restore shadow registers
> target/hppa: Clear psw_n for BE on use_nullify_skip path
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

