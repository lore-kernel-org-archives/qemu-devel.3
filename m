Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B584FEFB5A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvz9e-00007Y-AB; Fri, 27 Feb 2026 09:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz9a-00006S-Tm
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:49:19 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz9Z-0000dE-Eu
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:49:18 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48371d2f661so55965e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772203755; x=1772808555; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EMytu01jL5efHCJb/FWsaKOhAjnP/YXQLGi72/gI6no=;
 b=RU9hZCih0oiUB4h/ZNNUnqC4KelrlJJQE4ajcuIlBcuC9UBGgbOUlFPEYUOsKgFF2A
 tN8hP5tpS20xJ8ow4xAKlyIvMAFspVSOG/MIZMHBxG3PLi1aJTKtG/pgWg/5y02Wr9JT
 P+ryO4CGlEmkEx2zsQCEXzGAT/f78yyWg7xaNyGl10rJG/GRecC97ev2rCrBiuCJrvBD
 gOOb8CnQWo/SQVM21h9Q07cYeDWwKIWF7AIe/BSLbFlT4z6BM1GLQGToeNAL89Gw2UWA
 SH27rSCEf0gIQbrWK3GNpQGbBdcloXRNFVSqfAjPg+EefTyO7q+/MdRcqnfCePhq8pJH
 lCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772203755; x=1772808555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMytu01jL5efHCJb/FWsaKOhAjnP/YXQLGi72/gI6no=;
 b=ZCFPy0OlhSvdU1wjhXa7zr5lY+6m6bs24c45imcjJP4RUyCC5O5KXk8y/55YXhYREh
 Z7LS7MdJq6XfQ2f6XnVRT12nMogbgUGkxYB7HTrG703lotFmJ2ZnlDG/CysiRuo6Ym67
 PUiaJj6a5wDfauTdU+uyvF/vsk1eDx3x5ijdVvH7a+aSl257g/zDPStTi0gbz63Age4f
 YMplDgzXDECdoUBszgZ0XngvJua3Xcoh7a4WjkOC2zvyLhdq2bHvfMi4thAyIv1uK9PN
 Y/65m+9CPnOj695Lz/aQQE/OVUnoLkXjr4giDSn0SW1Vxt8NxBsLAE1SO1vW0pk638od
 tgLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPN+EuYvFD5KzaH3uV1KRVgkHNHPRKZxs7UNux9zTNdXMm72Q3rwGRIcKv0v4ENqIq5PZ1XUOfRo0f@nongnu.org
X-Gm-Message-State: AOJu0Yx2Jz2D+SaThizd7mPgi1oFHCSF65tZwFIGnWnULSw60RQqErdU
 SJws8HMX4+/FKZXqZwiZgcyBP1Ss7aGPvwSvBVpDcgQjAvUO6SiKkKSQvzC6y5zfq7NxECThjy1
 KHFvQyQ==
X-Gm-Gg: ATEYQzzkUvgcSsiAQ5gOEVp8wGZUvxT6Ml4bf737/vzy76GIs7B6FiAj3DqtbXvNkEh
 +DmSnH5oFoSUGqJlsDdyZdroly6ynJgx+OqV4CGQwyw5/fQJ59YOHMq/3npluCcvWpLVjJ0BgBx
 FoahXx4nd+Yeu1uac4qUalOSc7YHbbG67m6HbXwFCiMRYekZbJeJrKNeqwKlzYWOxt4It7PlQC9
 ov99SFVUflk6bfKs15p00JzQcIs+DiHT9Wh4kpA8FyI6PGqorL3f7uLGSrfj8ggXJWsaquRF9iQ
 2Wpm2xw2IexYky+9Si21u5zNOS+g2VLd0nzfL9vyotuAonc81fogqrlUuMgIHVSPbDKR05WIma/
 D9xTFDPZ8INq4S+oygjbITPD/8lekef41vRdxopcunGQIL29CClvX40kMy+sYYkScDFJ5gVLTMo
 4MymwzDbWBlF+Ldwtr3akhK3i7cvYqsPheh12rNLNcGPYDLUfdGygdhY0u0gfDNnnI
X-Received: by 2002:a05:600d:9:b0:47d:1e65:e841 with SMTP id
 5b1f17b1804b1-483c39ee08fmr1489425e9.9.1772203754670; 
 Fri, 27 Feb 2026 06:49:14 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c6100b8sm8556456f8f.2.2026.02.27.06.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:49:13 -0800 (PST)
Date: Fri, 27 Feb 2026 14:49:10 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
Message-ID: <aaGu5v0To65M5LkB@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Sat, Feb 21, 2026 at 06:17:33PM +0800, Tao Tang wrote:
> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
> and return CERROR_ILL when stage-1 translation is not implemented,
> matching the architecture requirement (IHI 0070G.b, page 176).
> 
> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>

This is a separate fix, it can be sent standalone to make this series
smaller, similarly the first patch.
Also the "Fixes" comment is not accurate, that was probably broken from
the stage-2 implementation which was added later.

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  hw/arm/smmuv3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index fa09099a09a..d4c58c0c724 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1461,6 +1461,15 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>                  break;
>              }
>  
> +            /*
> +             * This command raises CERROR_ILL when stage 1 is not implemented
> +             * according to (IHI 0070G.b) Page 176.
> +             */
> +            if (!STAGE1_SUPPORTED(s)) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +
>              trace_smmuv3_cmdq_cfgi_cd(sid);
>              smmuv3_flush_config(sdev);
>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
> -- 
> 2.34.1
> 

