Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DABAC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawVW-0003iZ-HD; Fri, 16 Feb 2024 06:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawVO-0003ci-QJ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:35:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawVM-0007Vc-A6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:35:45 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41241f64c6bso4122295e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708083342; x=1708688142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byXr1vxX/CMuu+s64IJfOeg3jjw+pETDY7XOlELiJtA=;
 b=gHGMAUW9hU4qcTOz1ulh+NylQNnYde2MD0WOy0FPUYEiGfx/ToXUzY/jXzGPef5FZE
 HDyym7SEHY0IuegS/lcLzdkNhUGdOZOSBuTUNInkeShTjwHRBRkL852PBChbSk2YrEAG
 83NzJ45kE3PBsn3neBTSp7jm5xUUha2CnRpy/e4o6fFCdp5pBazjYzWDh1ehAdnZI3G1
 HIPPem8B71s/HcQDRJNAl7Ka9pIYGVKZeDj5FQN6N91lT/blxnEu9KSgSCuVD1fBvR28
 560z5f2YM1dkcSOUTmFIAZxAFUyO6bbae8UtNzUljz500S5dBeAmPGrlHKy0cMtoCFUP
 WfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708083342; x=1708688142;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=byXr1vxX/CMuu+s64IJfOeg3jjw+pETDY7XOlELiJtA=;
 b=TMcQtefGUdlHcmz18kcFhHjXCZlUKHVfac7G2nPC+gpmcXQl3Qua6TMSxotifsiNWz
 1DzG2sRK96G1fP2MXBYHTRAu7ZX8tLObL+C2+tUMvVMcSfsEUAa4lA86U8rd8yp3Mm3W
 3JbpoOkY690EPrKETjtyB74SuqztL1ickxVLu7FwIKbbrAL/mWaD2O/4zO/40YJJ+Dl6
 oGGinpU2hz9347zbgNkefOKJA36WuJcljy0hZVqIC/obGz5UIhB/YUv6x0ZfUG/grw+8
 4DthyjsTK4W8iRTQQiy0BlJwOJhsyJ0WOX/z1+Mf7akOt15QQpmlsZKcItqzl4B2nOMV
 vrZQ==
X-Gm-Message-State: AOJu0Yw8obt0OvzTuO1qJEBB0O1KpsbH7L/TIN/0F+3VLmE6i3trjWvn
 TsvihC+eGKEZFh1U2yY9FmN9uH03Ss4t/i09ZU9XqK+Soo0uNR06h40HTqx3niU=
X-Google-Smtp-Source: AGHT+IFhx+R0Fb5gXSRKaOmtNxqgvOWp3Bg2CrwG5uTNSlq6xYM9dL4Vj4J7KqSFLK+Ry56X7vdhCA==
X-Received: by 2002:a5d:4fc5:0:b0:33c:d9f8:9d8 with SMTP id
 h5-20020a5d4fc5000000b0033cd9f809d8mr3449559wrw.48.1708083342546; 
 Fri, 16 Feb 2024 03:35:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600010ce00b0033d06dfcf84sm1934846wrx.100.2024.02.16.03.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:35:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA0CA5F83F;
 Fri, 16 Feb 2024 11:35:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 02/36] linux-user: Adjust SVr4 NULL page mapping
In-Reply-To: <20240215062018.795056-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 14 Feb 2024 20:19:44 -1000")
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 11:35:41 +0000
Message-ID: <87sf1s4p6a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.
>
> We really should be attending to this earlier during
> probe_guest_base, as well as better detection and
> emulation of various Linux personalities.

Do we know all our supported systems support this flag now?=20

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Acked-by: Helge Deller <deller@gmx.de>
> Message-Id: <20240102015808.132373-3-richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index b8eef893d0..e918a13748 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3912,8 +3912,9 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)
>                 and some applications "depend" upon this behavior.  Since
>                 we do not have the power to recompile these, we emulate
>                 the SVr4 behavior.  Sigh.  */
> -            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
> -                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
> +                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOU=
S,
> +                        -1, 0);
>          }
>  #ifdef TARGET_MIPS
>          info->interp_fp_abi =3D interp_info.fp_abi;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

