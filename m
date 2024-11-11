Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8FDD2E9C6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 15:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVuc-00085J-P7; Mon, 11 Nov 2024 10:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAVuT-00082D-D7
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:00:59 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAVuP-0003Uq-FS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:00:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso4287406f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 07:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731337251; x=1731942051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qh9LWpTD8TcJDgDm8ylFnfDTQORAFdZ7MbLa7KMdD0Y=;
 b=jVOTcJT/j10/juo1NOUjG2eTIlPdOc+0SyBtrp+FQzMXoYOWhHpx5KIGqDpuxBoFaR
 jUzv5qODOoQGKV9ToG1SIfM8tk7sRDl56dPBU81urwZI/KwgsUADKaa6S/FwNvBXEQy4
 wAownCp+xToGsV46O6Sj3c6SNXxICktbllagV22x7BS+hrO3mWm/a0UygAXH9UTEOomy
 BVdUaw9oSnbSmC5JASdSSyOxNA4pxuh17n4Rf8dZqhqZXzPEmPzkpzCTUhmeuR++9eXs
 d48ELTvbsvIV37sJSqUnWY6Xmc8DUJ/igT7Qd7Nbis+0IwiRJzhKRQs1/R1Z/gbMGxe6
 OZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731337251; x=1731942051;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qh9LWpTD8TcJDgDm8ylFnfDTQORAFdZ7MbLa7KMdD0Y=;
 b=uDPg199ob4CVmobO4t1Nj7hwsgubr5w8zGP1IFdxeAWU2nlgd0ZypnfoepxgX3nvo4
 BTHaUG/KTBkIPEv469S5OIysOsJTUcqzC2bf3gvWXLZ3uGUj5opxFR3qlwI3MwtJoX5W
 6Uf6ShLDjFNQR7jSTQryNKAlDc33Wmj25zO0n3uowQggaxx51GCbtz1C3Z1GNIzscIES
 d5IAanr+7FZiqzshg7LFQIvlt5h17gOL3dvZ4Gu3HUoonfGBahvA6PMD4/aMeD8Yzb0T
 VxmVrg2O6UVNALsZfASoHxsflAMfxT40c8cOCEE35955qYI43KGh06lPxmaRNPHvgmiO
 4U4g==
X-Gm-Message-State: AOJu0YzgwDoYr0TLzqNj9lUD5CzNX22BdzyOBfphyfUwHRKq/1MBdUXX
 2D3OnQPDvnB8H5shA7ougV2T5o+6vs0Qx8ZsJg12FOhf3pvwfbqHOZ7+3L0EweM=
X-Google-Smtp-Source: AGHT+IGIzBA/8OBgSxw1jyKAtUaXL2rT11BnRGzL1rJSyypLsueI5oJCob9ZTRH0axDWMQXBqZQusw==
X-Received: by 2002:a05:6000:2587:b0:37d:39d8:b54b with SMTP id
 ffacd0b85a97d-381f188af64mr13755964f8f.58.1731337249743; 
 Mon, 11 Nov 2024 07:00:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970f85sm13372418f8f.6.2024.11.11.07.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 07:00:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 945545F885;
 Mon, 11 Nov 2024 15:00:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH for-9.2] accel/tcg: Fix user-only probe_access_internal
 plugin check
In-Reply-To: <20241111145002.144995-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 11 Nov 2024 06:50:02 -0800")
References: <20241111145002.144995-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 11 Nov 2024 15:00:45 +0000
Message-ID: <87ed3hq0gy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> The acc_flag check for write should have been against PAGE_WRITE_ORG,
> not PAGE_WRITE.  But it is better to combine two acc_flag checks
> to a single check against access_type.  This matches the system code
> in cputlb.c.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2647
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/user-exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index aa8af52cc3..06016eb030 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -800,7 +800,7 @@ static int probe_access_internal(CPUArchState *env, v=
addr addr,
>      if (guest_addr_valid_untagged(addr)) {
>          int page_flags =3D page_get_flags(addr);
>          if (page_flags & acc_flag) {
> -            if ((acc_flag =3D=3D PAGE_READ || acc_flag =3D=3D PAGE_WRITE)
> +            if (access_type !=3D MMU_INST_FETCH
>                  && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>                  return TLB_MMIO;
>              }

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

