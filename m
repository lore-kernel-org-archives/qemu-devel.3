Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84736ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voBs3-0002kJ-CF; Thu, 05 Feb 2026 21:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBrs-0002Zb-0I
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:46:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBrq-0004lZ-FI
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:46:47 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a743050256so11493335ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770346004; x=1770950804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oAZdFUTTUdLqFR4X0pLruoHJYqcEPYrH0bepKs+z7UU=;
 b=KIZjv9q3IXYdTaVlK3D7ld4zamWakAEjR0DwwTlssFYiCrXcJntDVkB5FAkWkmY2Ea
 iCoGL2+jO4spfg6CaRJeR8F6rnTLpgzR4q27mNBXBT+GferIYVN25jYlxQkJvKwti2OZ
 i2kCbqQ6MIg9UkplurUtbseIk4lr/efVnY6KBPvNc4U7yLOdpyg/qGcJi41T6GQzhWxP
 gVronv+8kBYzWbTGUMZMMGRnTfv1iXajtUxmvG3WI8Ke+pRPbv9RCoy2KTfjPp+u6md+
 fFz7iynlbz3m6eQBvbYgR1L8QeiNry5VXx7kEfs7lddkr69AyaXktzuUJhO3lrVyWl/x
 5WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770346004; x=1770950804;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oAZdFUTTUdLqFR4X0pLruoHJYqcEPYrH0bepKs+z7UU=;
 b=c4nyKIXCUCMzqdJyqvPmU8SvMAut04F9n6p3ypDqn7GZkSmft7Gjiymyr0dfJNqfcD
 wYZ/G1xOTSnWyyjtagRlaGzWXobjzq9x3FKPI95p495CUro085Eo7xfoLwRyBDfR/8Ln
 C4eEQH+Yjdy5BrDdmALL4wlHBqm/if79eTsbKQzig6IZQeOuNUS1yDcc/va5qNheRA0F
 lc7YzRMri2MAZf3d7TxSjXkizYw0SRhFTYc80lXV6tYHLVE/p/baFJ8bodiaNErvhavS
 RyCaOEhhaRouyEvMb6SKrZi1RFCJfXK3DcX6wcENCMxgPHE5Y5Dk12qQq57pzS2amleW
 R1Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrxi2i9QSo0P+S7bdhQpbzf3N94bN1lraZrH94qXn+vKOFMS4cVYwq0ZXwQ+rTx40Nd9DhZzzgFxB7@nongnu.org
X-Gm-Message-State: AOJu0YzlklXfDWct7ptmymJgSU0auUroIeYEpn/jaoav6Za9KsrJ8Fmo
 1nka2HzU9vHFk5/rcSzdPk/xUtIOUwDzzwGsTIJ+4IQeu58l4UzJ9te9ugng5EprfPs=
X-Gm-Gg: AZuq6aL6JxWp1G+En6vaGxny8SiXOpv3AZN/cgxX73Gg8V8zwjm2Lgec8h047UNJfDN
 O8ViBv9vo7ClsYezzQMsHw04ZXUEcEQAynej2CBsRjodjUiYp8OOMeyqh7vM/pDzd1Hk2dmVZyI
 Zjbfq34hRWB34VVa5tI0HjOQOKGEGiVreTVhrjxdJ892X2kt1zIt6gn7w+Pi6FwP+ycXJRhylhC
 4ZIVQ+hQRmXRsSmYIR9IYXryLdPUfUwa2Afse13ePE89mwTXh7ucuQqQUCOzuaL+B2RR5mC95Wj
 sJedMMOD6OJaO2RKFF6tnevVlfsAvLXVZQ8LsytnoEqULbe7mTRxGwqBaULmdwm2kzqb0YZtzv+
 29A4qTJR7reAgrHjiUjC3VTXzENyrso41RJjsHdlYvfqCWROrBmkvfvOVdDwxv8ux4YRQaS1COT
 4a1iU0Ef6E5R35nV9vELEALZLiUmvq5Ol+8DyyCcVlolFlwWrUckkbYLCG+fdLb1a65Z3s2fT//
 BASzmHdkjTXJMVWLzX/E3wrlwAntQj2Xxx1NsFJpwA=
X-Received: by 2002:a17:903:1aad:b0:2a9:ae0:2d1f with SMTP id
 d9443c01a7336-2a9519466d3mr13626405ad.31.1770346003446; 
 Thu, 05 Feb 2026 18:46:43 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c4d8dcsm7730525ad.9.2026.02.05.18.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 18:46:42 -0800 (PST)
Message-ID: <e7e0033b-af4c-49ed-97ae-3ec87546c6ea@linaro.org>
Date: Fri, 6 Feb 2026 12:46:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/24] bsd-user: Add host_to_target_msqid_ds for msgctl(2)
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Brooks Davis <brooks@one-eyed-alien.net>, Sean Bruno <sbruno@FreeBSD.org>,
 Mikael Urankar <mikael.urankar@gmail.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-12-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-12-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
> format for msgctl(2) IPC_STAT operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
> Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
> Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index e7031c5264..03773e2620 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -187,3 +187,36 @@ abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
>   
>       return 0;
>   }
> +
> +abi_long host_to_target_msqid_ds(abi_ulong target_addr,
> +        struct msqid_ds *host_md)
> +{
> +    struct target_msqid_ds *target_md;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_md, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    memset(target_md, 0, sizeof(struct target_msqid_ds));
> +    host_to_target_ipc_perm__locked(&target_md->msg_perm,
> +                                    &host_md->msg_perm);
> +
> +    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
> +    target_md->msg_cbytes = tswapal(host_md->msg_cbytes);
> +    target_md->msg_qnum = tswapal(host_md->msg_qnum);
> +    target_md->msg_qbytes = tswapal(host_md->msg_qbytes);
> +    target_md->msg_lspid = tswapal(host_md->msg_lspid);
> +    target_md->msg_lrpid = tswapal(host_md->msg_lrpid);
> +#if defined(TARGET_I386)
> +    target_md->msg_stime = tswap32(host_md->msg_stime);
> +    target_md->msg_rtime = tswap32(host_md->msg_rtime);
> +    target_md->msg_ctime = tswap32(host_md->msg_ctime);
> +#else
> +    target_md->msg_stime = tswap64(host_md->msg_stime);
> +    target_md->msg_rtime = tswap64(host_md->msg_rtime);
> +    target_md->msg_ctime = tswap64(host_md->msg_ctime);
> +#endif
> +    unlock_user_struct(target_md, target_addr, 1);
> +
> +    return 0;
> +}
> 

Use __get_user and you won't need the ifdef, since the size of the type is then 
automatically handled.

r~

