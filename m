Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2BFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z8f-0007P6-VK; Tue, 23 Sep 2025 05:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0z8d-0007KX-Sw
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:16:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0z8Z-0001HO-0p
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:16:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3eebc513678so3585964f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758618993; x=1759223793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iANk9/Nz3uWdnfd7KcBd/wfgl/58r5Ynyh/yC2lQojg=;
 b=r3T/+JqHV2a74cbPSADzqi8WEEaLcsUNwaUVBq+CMIO9zw9+8JXjtiJrQhPPUbSs79
 cQXfnynIrtZbXn57qZrpcPD2AxU9fQu9hnpDNd2vl7DY+xYm8iXqaR/mtVNqaLIb0oH1
 WwE0saiXadVR0LC+yORDbckg4COK73lX+/wtjw1ksnMqsZoRE5F0ZKnkfdgpyEgbVlc9
 iz2fwmpZm/0y7HU+cWUBjdLg3Rp7q4+2PjU44gV96ow5Utty/CtJ4x/TST+bkKh5sRwp
 U9Cut1M66l82zkdHTaEZ+T3/eWkXskPz9df+Da8SSL7LSSgI/1sne/aiB3W28CwY+kmc
 EfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618993; x=1759223793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iANk9/Nz3uWdnfd7KcBd/wfgl/58r5Ynyh/yC2lQojg=;
 b=h1UGamn0Cd4adeseAWneV83bQ/4KCdM4TqR6qo6y3y4Ahj9UXW9nWLMv5f5hZ3yNES
 noXovWcqLKgLcpxLKIsmVFapVCjsnWPz29uNQGqsLWsWPsHQAd7ACfU51ZF2ywJWdPFh
 LnPaLOxUX+vo0zKE8xe1F8AU3qm/fcqhO03iXCqc02phqi5cdS3vJB3bf+iEBYHRo4Qo
 kWJ2OHd/Z0ecAiqdfV9+0rZ5PElahBqNLCw4vhUT3+ZYgndewyN4zCp5yGBNOsEND/qZ
 JMAJ2OY/dUBGSpYHxyHwxGmlHS41ajdtehUgDhNfvVNc0PEb9HR22mbtpVwxs1aIZnws
 5Tyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmF/0khRCi1SMBnA/hzLChZ+9mhr3Ic0ltvUYeXvzDkgVvgMXpMY+XKofS7l67jmSme7ofqkfavhkt@nongnu.org
X-Gm-Message-State: AOJu0YxDgXCeGKshU6xjPaHa5gj5t2t4vvMjW/d97p3051HR4kcWIQir
 VlkD8nxJajxTvSNDBPjT00CL/QRn3pbR0hhVhXc2zfbnMvYoHFdHFuryEK60QkFnb40=
X-Gm-Gg: ASbGncv/Ay6+bmqao1DoLvMz/8ie45razcmCMFJ+OMt00HsJImnBXIohAhg9zWV/EvO
 kmlJ+CgWm7FYEYPWNjtymNi2WBNnjBdOAKojAvsYI0pSLvOGyWMuj0x+9z3VUU4/CBzMl6bKGHE
 uWWIBm9aYeON/lah3tUVwiqvvncc0RSGh0muMqpbMj8i8iJ7Keh/BO+jK+Dd11ZooonQwVSXqJI
 Y31BL2x0pj9U0EJM2avxx57IlUGn4k14HydYkKjL8ZFAqE9bliXYtJVzJZ1Pbrml6K1uKa2Y1ev
 V35/quGNBLzeB3zSlYL1ZmY/tiFibHJHhGicWmgKybBLUzRDUyK1LOKXYvDKexj3SU2LfwKyNhd
 Y/0zD7Tdzlm/H/4Iq/l9sOtzfic7FkH9bfiNFxNxFt7KhkfQY2HF4WWALmXTmsxxzJA==
X-Google-Smtp-Source: AGHT+IETWMXOZJGP4nXk8JHyBQICd2SFHzipFwMqZhRC9PdJKc207vqEuMui0enmsudMrODhQh2DLg==
X-Received: by 2002:a05:6000:2383:b0:3ec:8c8:7b79 with SMTP id
 ffacd0b85a97d-405ccbd72d1mr1301192f8f.61.1758618993196; 
 Tue, 23 Sep 2025 02:16:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7460sm23452550f8f.31.2025.09.23.02.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:16:32 -0700 (PDT)
Message-ID: <3655c9a7-7fa9-4d5e-9e15-e1d77da39ad9@linaro.org>
Date: Tue, 23 Sep 2025 11:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] accel/tcg: Split out tb_flush__exclusive
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 23/9/25 04:39, Richard Henderson wrote:
> Expose a routine to be called when no cpus are running.
> Simplify the do_tb_flush run_on_cpu callback, because
> that is explicitly called with start_exclusive; there
> is no need for the mmap_lock as well.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tb-flush.h | 13 +++++++++++++
>   accel/tcg/tb-maint.c    | 33 ++++++++++++++++++++-------------
>   2 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
> index 142c240d94..5076b13bbd 100644
> --- a/include/exec/tb-flush.h
> +++ b/include/exec/tb-flush.h
> @@ -8,6 +8,19 @@
>   #ifndef _TB_FLUSH_H_
>   #define _TB_FLUSH_H_
>   
> +/**
> + * tb_flush__exclusive() - flush all translation blocks
> + *
> + * Used to flush all the translation blocks in the system.
> + * Sometimes it is simpler to flush everything than work out which
> + * individual translations are now invalid and ensure they are
> + * not called anymore.
> + *
> + * Must be called from an exclusive context, e.g. start_exclusive
> + * or vm_stop.

Worth mentioning it shouldn't be called from target code?

> + */
> +void tb_flush__exclusive(void);


