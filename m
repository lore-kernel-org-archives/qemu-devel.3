Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61699CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwU1-00068A-SN; Thu, 21 May 2026 02:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwTz-00067l-3E
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:02:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwTx-00067d-A8
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:02:10 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso3043813f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779343327; x=1779948127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kf8uHWQIx+rhGhwVlOEmCrqlFf6F59bZiK9yJTexNF4=;
 b=JyOMJPhAyBr7+VRFq4UacRoGkT5WnV7eBRpyljoG9WQL82InJ2zT8+owcw68CD/ENL
 TNyzVggjEtFroZ/WOSSD7/mkpsLcIdm4JTrEdIZ+WHB0Acxfpf/BzoLbwAWZmr/EAwBs
 6brX3vqIqjwBko7KX9VEzMXVCPRFDvSUEoVFzxo8JFYG/8tXAANNdm+XUXTvZ9IKxMIr
 g9G8r0P/92uNu6gzveCHorI/+kpp3D1wWb4PwBB5mZpcrszymyqLNELFlLYGnziJ5GDm
 rTwUhiR+4dBSHMJb/7FTJaQ5AIetrBURVZIOCVaCrYx+oOXx/8I5jRTFAP03J+jYkQz1
 TIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779343327; x=1779948127;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kf8uHWQIx+rhGhwVlOEmCrqlFf6F59bZiK9yJTexNF4=;
 b=QSPMMUitX+yZiruObfZSL7s5YoLObjPi/g8wW0AzIzvc4CpOBvJwI8QIwkwszWAvk5
 DFG3GRoz33drVUZLwKpOTpLGF7f+jSjpDPXfX0KwPcJ/zVkdHkvCsegrAp4oQh3N7cBp
 5H4PAPRpetDExU5I1pwwqQtWUfkGlr+g8p5BytA0GFnFjtyFYTdaiqNZgBXYf/em8Qv8
 miis8djDfAlVJER4XGs6384DEuinqvUi2zVh3icOVd4+J52HiLSij9J9Ej291u016Jsk
 HnHNEYAdJoWNm8q8hAigdPs+kI9jRnDu47w7v4M10Ai/OD+XAbZGusH19VmFuTkGhcyz
 QL8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UB3Lmuz8ONp9HMiGs2vLg97KJCV2we82cl3ZGTn2fl+cqGtjMAwDVRrn0agp4zTSOQica2qxM4+Do@nongnu.org
X-Gm-Message-State: AOJu0YwI3B4nuDRaWZGdUEBm9bCSsnfuKa7qCF7ssyz8XoYzXWOw9lFL
 J1tZ0QVscCNcIJFexRhUZoFPSvMsiuru+puge9PvR8o+JiFsAQClDxvag4CAVD+M6J+pWc2gp9r
 ocq1e5OM=
X-Gm-Gg: Acq92OFxaARwrH/562QdEFYRWcPUDIetMbhswpIXQYcGtR82hjAZlN6ILVEODG3eBlk
 W/AyzlYv8kIjKU3tdK35hOHpUJ/FkL4HHET86ku4jdQOWztmOp549yzNY/fldbVqUeqZQZuEwy5
 g/BMghGeJiWAPcao9/8+x9LBIsS0XjwNfo/c9T4VL3JAsD6npwc6RTih/MWE2YlfJ1M8fI1NdrT
 kxEuIE7HM42MvIG1Fze8iVaeBv/kDPHuVfKWg9ZWUUMWfTs0WYVTORPCTnQotggsVHDsAv0UX8c
 mv2nO7KIwFjdcARGFBgw2jJVej/Gg0vLzQLUnshqGeNSPR1efGl2zYQCE/Jy3HmHlT7+xAJgxZm
 FSGdgi2Wy1jXUOxs9zm0UaEyYPJf9I/3MpSHnRCsHHOs9/aJeTTgVgfe4gh2HgUJEnREZzF/lBH
 ne8L5Y+Ay8ohHfIPgRf4eiCkfVQqntpDHyfwl/0mK9IZyertz9LxEfi6AuUoTeljpTvQ==
X-Received: by 2002:a5d:5f91:0:b0:45a:e3dd:5869 with SMTP id
 ffacd0b85a97d-45ea41066a3mr1822013f8f.30.1779343327265; 
 Wed, 20 May 2026 23:02:07 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7d9daasm125702f8f.11.2026.05.20.23.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:02:05 -0700 (PDT)
Message-ID: <aa414d23-afe6-429b-ab20-1364ec5ecd45@linaro.org>
Date: Thu, 21 May 2026 08:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/40] qemu-io: propagate errors through Error API instead
 of printf
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-14-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-14-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> Convert the qemu-io command infrastructure to use QEMU's Error API
> (Error **errp) for error propagation instead of printing directly to
> stdout/stderr via printf/fprintf.
> 
> The cfunc_t typedef, all ~35 command functions, the dispatcher chain
> (command/init_check_command/qemuio_command), and helper functions
> (parse_pattern, create_iovec, qemu_io_alloc_from_file) all gain an
> Error **errp parameter. Async completion callbacks (aio_read_done,
> aio_write_done, aio_discard_done) use error_report() since they have
> no Error path back to the caller.
> 
> Update tests:
> - error_report_err() prepends qemu-io: prefix
> - copy-before-write: check the HMP return value, rather than stdio
> - other tests: update to check JSON {"return": "Error: error text"}
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qemu-io.h                          |   4 +-
>   block/monitor/block-hmp-cmds.c             |   2 +-
>   qemu-io-cmds.c                             | 426 +++++++++++++++--------------
>   qemu-io.c                                  |  17 +-
>   tests/qemu-iotests/004.out                 |  20 +-
>   tests/qemu-iotests/021.out                 |  60 ++--
>   tests/qemu-iotests/060.out                 |  44 ++-
>   tests/qemu-iotests/071.out                 |  10 +-
>   tests/qemu-iotests/072.out                 |   2 +-
>   tests/qemu-iotests/080.out                 |   4 +-
>   tests/qemu-iotests/089.out                 |   4 +-
>   tests/qemu-iotests/114.out                 |   2 +-
>   tests/qemu-iotests/134.out                 |   2 +-
>   tests/qemu-iotests/137.out                 |   2 +-
>   tests/qemu-iotests/171                     |   2 +-
>   tests/qemu-iotests/171.out                 |  68 ++---
>   tests/qemu-iotests/214.out                 |   2 +-
>   tests/qemu-iotests/220.out                 |   2 +-
>   tests/qemu-iotests/244.out                 |  12 +-
>   tests/qemu-iotests/249.out                 |   6 +-
>   tests/qemu-iotests/271.out                 |  14 +-
>   tests/qemu-iotests/tests/copy-before-write |  66 +++--
>   22 files changed, 404 insertions(+), 367 deletions(-)


> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index de4c1966fea..5093aa4169a 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c


> -static int reopen_f(BlockBackend *blk, int argc, char **argv)
> +static int reopen_f(BlockBackend *blk, int argc, char **argv, Error **errp)
>   {
>       BlockDriverState *bs = blk_bs(blk);
>       QemuOpts *qopts;

> @@ -2609,37 +2624,41 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
>           qdict_put_bool(opts, BDRV_OPT_CACHE_NO_FLUSH, flags & BDRV_O_NO_FLUSH);
>       }
>   
> -    bdrv_reopen(bs, opts, true, &local_err);
> -
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return -EINVAL;
> +    {
> +        Error *local_err = NULL;
> +        bdrv_reopen(bs, opts, true, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return -EINVAL;
> +        }
>       }

         if (bdrv_reopen(bs, opts, true, errp) < 0) {
             return -EINVAL;
         }

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>       blk_set_enable_write_cache(blk, !writethrough);
>       return 0;
>   }

