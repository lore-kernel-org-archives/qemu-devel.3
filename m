Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0B1ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voBtG-0003ZX-GA; Thu, 05 Feb 2026 21:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBtF-0003Z6-0T
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:48:13 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBtC-0004sb-Tx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:48:12 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so1439896a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770346089; x=1770950889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=faYQ2NgxZcI+lGH1ya635NA/ASBVBezqriE80xsgfys=;
 b=CrpJbX01DwIsSsf0QkJgfuXcM1ftmzCXRlyID1akBEoWu4fR6siMmHcdAIo+EqYtCC
 V2ZLyLv/z2ABkmG4moOKq2ynuGjwhxF9ycY863Ff/dhsDFRuFxQtKHBVM/MtfzBmRRsd
 YK1eCnEp2JWwZDiN7ZfRZSTMDkumLOuZQji7V+1OkT5vGKQ1D9oaziRfFpfGMGw1JSkE
 IJQbDSkj0T4+qz9s8TjooMjj7UheQHZPbeFhe72jKxFfIGNEIzZMFmMc+YVV2II+dWje
 rRsERjmwsIZGWlZCwRB7YfwNDznNJtmUe7KpdIP5znOZsob/th5nRFC5g6zL1TVsZ7mg
 sW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770346089; x=1770950889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=faYQ2NgxZcI+lGH1ya635NA/ASBVBezqriE80xsgfys=;
 b=Kr16MiQ87MMBB1z0J383nQL5WLxsRfXrhWEVseVtoPmRXFxL1e4vR1/QJBtpHgmWme
 7x/SKg0AZmrczQajpnPag4Bs5tTZ9dXHohN9IqGYtTTAaP5U6RhSFrfen+bouWe2R5N+
 bganGJyjJK4ljY7j+jyL+tpLw8KVY0YflXg5QQABLmcycg/hTyHae6cCmKMmrXQtNv9q
 /3ZVn3pz1svB4q8X0bfP0ddJu/54b6tIzJPSou9TtBCmdCUJ5vFAmqVUBXEjd0oefW1S
 7uG5pMi/uxxI+iHsB+tsHizgiGuyXBJfsPl2d+63l6a8yWezD/ob14NozvQN2cZafao4
 khIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQg8Fn372fviuSuRPeHrncbZClzQAAbcUeXqiK2kPTeg86hV8BB/QfAY1c4KcEWnz0N4GC/jr7ycdS@nongnu.org
X-Gm-Message-State: AOJu0YwviPIIAcMKsJrlOxoqz6nCssdAAW1u4G2NafJ+7+xcaFtUid+T
 sM6FIgdKEa5C/fVAGYLSUzZ54oCMLH3A3GS1txqEEKCesQqDmqHMedhNMbewEoi1gys=
X-Gm-Gg: AZuq6aIMlpvL/FGrF7O9evAqdgh+xXDKR9N8dRw+do0qHhi+IG+/1pyH7y64zfRpv+Y
 HcAzBvyU6PCxjD3ocAVOCpnVAEzPIjSGFglNvAROOzeApqS0lbJ+BtI7gCRVCegDB2gHvMknfWu
 s1gzy0wwnVeJIrsFKBetAzA3YWyP3qm7N0fqs5H6DCeF+XLs9AonwDDbgAmbxcsgeJHe+0XT68M
 YNxv89nqHwYxUjtwm+MWxiB/iA9WTPY7WWxrjF0Nxvga7ZC8LgozPrjNItoAVxWIomVG/n90HoS
 pBj0XGRVwoILv30sFKTZZCPfWlyBmyvSJVQ+RW2s9Suz7g6zaz2SfReIAKs/Ow1YkJnLW/uqnp3
 E20eHzmTfDZyWQaQ2dm6/Tsz/DrtGGgG4Ru2DcZL7YAd2n9b+TntVb5IPlm7Vdh28NyiJFMVvqg
 nbG6UH24/li1SYwiH7OUxkScL50Gyr0lVm1nR88V1ybmBaZNJrkhX1YUyi9k4MxAvK26ttp6d4V
 +JhETieEVbPmptzIESgoExfLTwkp+G1eQ54j0BA8bM=
X-Received: by 2002:a17:90b:1d50:b0:353:3934:1449 with SMTP id
 98e67ed59e1d1-354b3bc8501mr1063369a91.12.1770346089172; 
 Thu, 05 Feb 2026 18:48:09 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95223d8fesm7495805ad.98.2026.02.05.18.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 18:48:08 -0800 (PST)
Message-ID: <fc65da71-43ac-4bb6-9e5a-3b6bea2a0927@linaro.org>
Date: Fri, 6 Feb 2026 12:48:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] bsd-user: Add semaphore operation constants and
 structures
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-13-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-13-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> Add System V semaphore operation constants (GETVAL, SETVAL, GETALL, etc.)
> and the target_sembuf and target_semun structures needed for semop(2) and
> semctl(2) syscall emulation.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index 62b9bc752b..becd04efb4 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -95,6 +95,26 @@ struct bsd_shm_regions {
>   /*
>    * sys/sem.h
>    */
> +#define TARGET_GETNCNT  3   /* Return the value of semncnt {READ} */
> +#define TARGET_GETPID   4   /* Return the value of sempid {READ} */
> +#define TARGET_GETVAL   5   /* Return the value of semval {READ} */
> +#define TARGET_GETALL   6   /* Return semvals into arg.array {READ} */
> +#define TARGET_GETZCNT  7   /* Return the value of semzcnt {READ} */
> +#define TARGET_SETVAL   8   /* Set the value of semval to arg.val {ALTER} */
> +#define TARGET_SETALL   9   /* Set semvals from arg.array {ALTER} */
> +
> +struct target_sembuf {
> +    unsigned short  sem_num;    /* semaphore # */
> +    short       sem_op;         /* semaphore operation */
> +    short       sem_flg;        /* operation flags */
> +};

abi_short, abi_ushort.

> +
> +union target_semun {
> +    int     val;        /* value for SETVAL */

abi_int.

> +    abi_ulong   buf;        /* buffer for IPC_STAT & IPC_SET */
> +    abi_ulong   array;      /* array for GETALL & SETALL */

abi_ptr.


r~

