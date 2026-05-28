Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E6BCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 17:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSeI5-0005Nu-QH; Thu, 28 May 2026 13:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wSeI4-0005Nh-7n
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:13:04 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wSeI2-0001og-Ct
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=gLNl+cajsEn3x79silvY9pqLaToQJLACqCwd3QPy3Hc=; b=XX6b8Ngx/9ZvGMW
 BOHSXv1yacjSrX97rSj9W1wlwbFX6JU3n+d+HdI8LLzvO37mrpUuF1kz4gN4k4ciQrHZ2YFAy9zcK
 rBg9SfOWZmoAkd4Y/phhl0AFGB/H68pNDVLCmfDaaJ7Zkb4sINJtrr7c3U3GLR59jtQk7ZYcSilwm
 h4=;
Date: Thu, 28 May 2026 19:17:45 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] accel/common: Remove last bit of target-specific code
Message-ID: <ahh2_kNA1aQP9BJD@hive.localdomain>
References: <20260528140857.44130-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528140857.44130-1-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/05/26, Philippe Mathieu-Daudé wrote:
> Initialize the TypeInfo structure at runtime using the TargetInfo
> API to resolve TYPE_ACCEL_CPU, replacing CPU_RESOLVING_TYPE by
> target_cpu_type(). Since the code is no more target-specific, move
> it to accel-common.c, removing the need for accel-target.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Pierrick, this is an alternative for both
> 20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com
> and
> 20260528051642.115721-5-pierrick.bouvier@oss.qualcomm.com
> for your "single-binary: fix compilation/execution for {arm,
> aarch32, microblaze}" series. WDYT?
> ---
>  accel/accel-common.c | 15 +++++++++++++++
>  accel/accel-target.c | 41 -----------------------------------------
>  accel/meson.build    |  1 -
>  3 files changed, 15 insertions(+), 42 deletions(-)
>  delete mode 100644 accel/accel-target.c
> 
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 9c5b4111c8d..62590a7d9a6 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -134,3 +134,18 @@ static const TypeInfo accel_types[] = {
>  };
>  
>  DEFINE_TYPES(accel_types)
> +
> +static void register_accel_target_type(void)
> +{
> +    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
> +    const TypeInfo accel_cpu_type = {
> +        .name = name,
> +        .parent = TYPE_OBJECT,
> +        .abstract = true,
> +        .class_size = sizeof(AccelCPUClass),
> +    };
> +
> +    type_register_static(&accel_cpu_type);
> +}

I think this is a nice solution compared to including accel_target_c in
every target/.

Reviewed-by: Anton Johansson <anjo@rev.ng>

