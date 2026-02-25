Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FE3F55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6pT-0001th-Bo; Tue, 24 Feb 2026 23:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6pS-0001sj-4z
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:48:54 -0500
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vv6pQ-0000FV-H6
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:48:53 -0500
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2bdbe434b47so1326192eec.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771994931; x=1772599731; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QxlgwoeXYmljQkox/EYOJdJvYedqjiNzXQltXYKTZ40=;
 b=kEoyMUN9u89RflnB3t1t6tojGnKWWGn5ctiob0y4ayIrRcbJ/hZIS6kptwBr8QIWFk
 XacpvFqnDkx2wvquzcBSIYj7CMKQoksk4JrGD/xPuBCCKVwcpwWCfSn5++1McGKTIkb9
 SpQJhrQZ/KIXn3faSlJB+6nmuc1LpXg3qaGNRRXO2crNS4ZZkjdX2DHsuh5eQ7Av7ZkI
 RMLBTJbxM69TXoIfc9OuMR30JB6FKwB8PfGbbXnUr99WMfMtAp/Ql324nC1ceElYluzw
 2bEVeJNa0tR1Vj+4r9W3ZG1B6ECKQa4j8B/81syjyU9HGl3OnVjKhwfd1DZlfeEJRKFv
 REkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994931; x=1772599731;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QxlgwoeXYmljQkox/EYOJdJvYedqjiNzXQltXYKTZ40=;
 b=I4TryrDmIBWcsR+ZhyXGuvLSJSUL8gJf0Iv0kee0M9Rg+36YeDELZ7TfuzM1RsKccS
 8n+FKIhzhiX6mZ4l9eqITmVjNb6GqOcahlDSXV40jP5hFwYVO22teeiJ1kxTQqrDG8Ts
 f3HkufPktkTvZ14vMjjVXmM8OIv+nk6HMD7Qs44xxKVruiGNAAcVWcpT1NQq+BAEoO8o
 wfx5cmPuRsywpEdx4JihW0yLeLsJ0yzuB09a2Ugh82OcmR5rLNinVHJfsz9R1edzC4LD
 oLt+tgCYCUu9OR5I5fgq/3Pby14vvVmgdUouojQ6AdWP02aO69DWQluzhDcGIjHZJU9Q
 AFdA==
X-Gm-Message-State: AOJu0Yz3VcybJcYpYp6F5ShJTRQAHM+0XYpIX1dIdU4UkysFcesIAcLH
 3XHbMaLdvEjb14JBeNiXkFfUn7cRHxh7lgCavAoqypAg7Ert4tvpQxUkxSORNn0H
X-Gm-Gg: ATEYQzzuB4x3MuCHxwqBNZJipB7k+sauuJEa6LQIY+bDG/PaDyf11kXtYixcvRbLdde
 WaP8usb/HvNw0ZKWnEQGeZWIuwnRAVytobbjzCKfJn9WTAxunGLXHfzWNIyWjASmrZ6A8aeFYu2
 g2sRSZI2MrYY4Wrp2y8DicpxC4OA6yeKoMrLfPGD4agB6Aayd0Y8gULAU9lqCMunHMB3Ehw8aJb
 dgB1dMFbyPVh35i7oDtbgxSrRLYnuBLXjCaRjgsxObrWyDkOpfzLr/RXB5Rg0n8rHmoUjnFF9Te
 MS9tLQTozHM+jIOQRBCz55XQeAiHbrCojYYaLk3PCeQ+YvYdy69dID31e5wA3gjojhHqlyboWXq
 5tMytGrMoAHFFcRKfv3sDPYgLsP9FS2VH6reDA2f1YS8Z2crsxA4BPCMijcWnnr33WIT3/m2A2E
 bU7JSp2BNtm1FG9RsbAZdVvJZFDsCCEp1M6Ie+syp6mzWvIfKasFaI15Ngdk4OW9fXUoe/Wh9v/
 KiGsPHNzZMpSFuswoEvSpcV6im8PASGszNHT7+VUQ==
X-Received: by 2002:a05:7301:4446:b0:2b6:aeb8:3d8c with SMTP id
 5a478bee46e88-2bdc34086e1mr393134eec.32.1771994930685; 
 Tue, 24 Feb 2026 20:48:50 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa3701sm7577007eec.10.2026.02.24.20.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 20:48:50 -0800 (PST)
Date: Wed, 25 Feb 2026 12:47:54 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Song Gao <gaosong@loongson.cn>
Subject: Re: [PATCH v2 50/50] DONOTREVIEW Revert "target/loongarch: Build
 'gdbstub.c' once"
Message-ID: <aZ5-7gdpy8e-16Ip@ZEVORN-PC.localdomain>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-51-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219191955.83815-51-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Feb 19, 2026 at 08:19:52PM +0100, Philippe Mathieu-Daudé wrote:
> While the previous patch "target/loongarch: Build 'gdbstub.c' once
> for system single binary" can be reviewed, it depends on Anton's
> "Drop TARGET_PHYS_ADDR_SPACE_BITS" series. Revert it to allow this
> whole series to be tested by CI bots.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/loongarch/meson.build | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
> index 2ae96d68695..20bd3e2f0a3 100644
> --- a/target/loongarch/meson.build
> +++ b/target/loongarch/meson.build
> @@ -3,14 +3,9 @@ gen = decodetree.process('insns.decode')
>  loongarch_ss = ss.source_set()
>  loongarch_ss.add(files(
>    'cpu.c',
> +  'gdbstub.c',
>  ))
>  
> -loongarch_user_ss = ss.source_set()
> -loongarch_user_ss.add(files('gdbstub.c'))
> -
> -loongarch_common_system_ss = ss.source_set()
> -loongarch_common_system_ss.add(files('gdbstub.c'))
> -
>  loongarch_system_ss = ss.source_set()
>  loongarch_system_ss.add(files(
>    'arch_dump.c',
> @@ -25,7 +20,5 @@ common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
>  subdir('tcg')
>  
>  target_arch += {'loongarch': loongarch_ss}
> -target_user_arch += {'loongarch': loongarch_user_ss}
>  target_system_arch += {'loongarch': loongarch_system_ss}
> -target_common_system_arch += {'loongarch': loongarch_common_system_ss}
>  subdir('kvm')
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

