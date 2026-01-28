Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521C5D3F097
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl8xN-00015R-6h; Wed, 28 Jan 2026 12:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vl8xI-00012U-5x
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:03:48 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vl8xE-0003fZ-L4
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:03:47 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-385c23b88e8so288051fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 09:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769619821; cv=none;
 d=google.com; s=arc-20240605;
 b=ZDgBGO1TO5EZ7Rvf7zgeOxyXcRmm/biB3toVyPXp5dWONMxahg12B9YjJmn+GRJfNR
 vgW2Hf0W1DTM7sMFh4upUUPFYiEtxGDblHclz3bqzetIjaf7x9CfrpHp95RzB2CZfxB6
 B3FPmkcgc0c8sHz/ABdmnJlLLTTfm0Kra4GrXU+8eyShkw448Lm1GIkF3a8uS+UsS/ma
 Z3I71HZQ+hvmHXwxMRtILlHHn4AfQFfyzMmXSJYs7ghz79qPyjtDV4mgQpEfyWewTvxr
 yikvLVj0tD/T0VXWvFEAb8ItRAE1mO/XXLDNPMKTbUxIH7nCjcuHLYbBlcqKc1DK0YFz
 Y0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MwG6ook7ieLG58XW5GLuDJtAo74ARhmHcNLCIlawM7A=;
 fh=YsUiTEDja/AJyuFct3MbvPsevVCXYPRnqRUIu1zIX08=;
 b=OBFL7ocTetRpdzLjK8r/z/2czX6+azR4jVo7M3YYK34UGLzbPpnc4xb12ZjjjU2lEe
 rwojGsp2cWFxjKyNJVqvPX+nslu1aRnSMinlJ16am3VDOT6ABkITiw6zMe28wFD1T0cD
 SGmQQHlQTN0Rcd6xAnM2Uzv5EHZVpiSi30fT4sp+VKcMB38A16lJ/RoTAICjn9njfH64
 nxl0OEJR/A36IZrNGt6VWipzeoa/DlgAE1mIovlt/ak7A4sF8cQouuol5fuSyRPqlfoq
 q+k6yIdtYY0Af+XZ4upqKDfz7bPSXqlc2PZMgqDt0i18+4jzXQXix7XC1mjOHVudUCmA
 n4jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769619821; x=1770224621; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MwG6ook7ieLG58XW5GLuDJtAo74ARhmHcNLCIlawM7A=;
 b=KVzEFOEnnK776n2k1SkGVSLWG61w8nUIWAApuCiIZcyAfcf4crf9SCQrFYbWcqCPc+
 0KJx+z0eYPfOokwXhudGKSbRG9wrQ9A5szCqzAbT6ikyNJJGrj4dCJ0obMGq7BsiQxXl
 ycknKbWwPYA47TjhbCcGPjv1OE/+5JQHHpBH+HONc6S0gIQd0Re7K7FqCTPOjcSeMRtz
 2lh8Pdm776M5/DtLlcUu6CZn8O0Ef9DYqThTUJnrVp5S9kNzk/irZo1HT85qQj6+0TQq
 cTEvj+n6m0WeQ3WX6R/FInI1WK2a/hGbj9wXsiFaRXJS6kum1YjTun4dvt27DMGWuZyb
 qy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619821; x=1770224621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwG6ook7ieLG58XW5GLuDJtAo74ARhmHcNLCIlawM7A=;
 b=YSDNIJNlkPB/yS8GwHo4pAsRSD5NKcaLvyOD2Y24qt4F1tfWMU1c1S9456La6EUeWr
 1Qu0fT92Yk/9Pl5Y/4cgnxJycDgKm5eXdt3DdFSKQQiKSXx3lajGlpbNT0DOVLExyG8w
 gsDZ89Xdg8LcsExr3dJbROkqXJKb1oMESlB+TyC7D/2mdxoqruLC5/+tKBoQCtXs5lTB
 Gq0ijhjq3kUTLpWNK1THOLlGITR296cJYkuB8kEYV/8mIqi77X7nELXiH6+jC36jO8sq
 Qv0HWcOvZJ+yGKL1bz+6HSDCq9id9De4R+r34hlxtA+F3w0O86bwWBP8EmRu8a5Ob7e+
 tNUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr0Bo0TJ5rr4In1rMI367sUNyV/+fk2ty6exVSp9iVhRnPYDXH4d4itoiJk3XrTq8OEsPr0e3fFgB2@nongnu.org
X-Gm-Message-State: AOJu0YxouRf9GCO5OSP5PwkD1t+sEnhCkxnU4/jny5O4dIjcYKgI00Mj
 CjojFd0C1BKvgAlkhifTF0slaKODwp0f0DxtjhOpB+eWPvcHFh4L7UiWsl2tHrPFgXoekX2GtHo
 fmQ8cJoZEYErNVEPfMt0nlXiFBvWfVTdYNeDwiE2Gkw==
X-Gm-Gg: AZuq6aKTouzwPSXhTtnv51XNLY4ZRS7Sa62VIZyhN+/KEZ9IMUZr9YvA8TPjkT7nAWx
 8QQdB1/d23L6NGoQHWsazlLHv7LePF4o5DeuBw0K8s0hivjfa0sF0A3TmX5gxSy06SZWzcM+Wjh
 6El415eXMmRDqUQIJOA/6FSGYHkTUrSxsfg6fQ/90iGIV8h0md1QG2DR679IHdPJ865YyiH87JI
 RmfN/KYJiF8TXtm08rhXOmIB5wLPhFLJmwEtWXBhh4TFt1be4wm8fH9I5jGit0d3PxbJQE=
X-Received: by 2002:a05:651c:4cb:b0:37b:926d:5bf3 with SMTP id
 38308e7fff4ca-3861c81f313mr23846221fa.6.1769619820573; Wed, 28 Jan 2026
 09:03:40 -0800 (PST)
MIME-Version: 1.0
References: <459ffb4e-c831-4694-83f3-32ea610f72a2@linaro.org>
 <20260128074236.49624-1-3160104094@zju.edu.cn>
In-Reply-To: <20260128074236.49624-1-3160104094@zju.edu.cn>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Wed, 28 Jan 2026 18:03:26 +0100
X-Gm-Features: AZwV_QibLuVDh1FR2ytcG1IKbNBCqyC0mAonVdZF_C_1y0YGe5WTjKGuH9RaMUc
Message-ID: <CAPMQPEK1oF9K86_dnO9bEOMn8UDtZK0GBZZkB0zxYa0+-2WPjQ@mail.gmail.com>
Subject: Re: [PATCH v2] accel/tcg: Ensure get_page_addr_code_hostp nulls
 output on failure
To: Panda Jiang <3160104094@zju.edu.cn>
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-lj1-x22e.google.com
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

On Wed, 28 Jan 2026 at 08:43, Panda Jiang <3160104094@zju.edu.cn> wrote:
>
> In tb_gen_code(), get_page_addr_code_hostp() is called to get a host
> mapping for a guest PC. If the function fails (e.g., for an I/O region)
> and returns -1, it previously left its output pointer parameter
> ('host_pc' in the caller) unmodified.
>
> If the caller's variable was uninitialized, this leads to undefined
> behavior when it is later used, for example in setjmp_gen_code(). This
> was observed as a segmentation fault when running QEMU with the
> '-d in_asm' logging option when mmu translation fails.
>
> As suggested by Richard Henderson, fix this within get_page_addr_code_hostp()
> itself rather than in the caller. Ensure that in all failure paths where -1
> is returned, the output pointer is explicitly set to NULL.
>
> Signed-off-by: Panda Jiang <3160104094@zju.edu.cn>
> ---
> + Changes in v2:
> + - Moved the fix from the caller (tb_gen_code) to the callee
> +   (get_page_addr_code_hostp).
> + - Set the output pointer to NULL on failure paths inside
> +   get_page_addr_code_hostp, as suggested.
> + - Updated commit message to reflect the new approach.

See Richard's elsewhere fix:
https://lore.kernel.org/qemu-devel/20260128010715.347776-3-richard.henderson@linaro.org/

>  accel/tcg/cputlb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6900a12682..6d7cfd2b5a 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1543,6 +1543,10 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
>      CPUTLBEntryFull *full;
>      void *p;
>
> +    if (hostp) {
> +        *hostp = NULL;
> +    }
> +
>      (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
>                                  cpu_mmu_index(env_cpu(env), true), false,
>                                  &p, &full, 0, false);
> --
> 2.39.2 (Apple Git-143)
>
>

