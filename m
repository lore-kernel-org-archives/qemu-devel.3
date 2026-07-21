Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C850C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCFw-0006qp-7g; Tue, 21 Jul 2026 11:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmCFt-0006pm-VF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:19:37 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmCFs-0007DU-Dy
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:19:37 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cbb662575d3so564811a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784647175; x=1785251975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3BB5gEj1PmQnCqJnAaI6yvp0ctrN2b8GNGEP4+jeUKI=;
 b=beKjSFDo+UhAqO9PKgTARQ+LbLjh2N9iD6Wbaq2VgrpTLr/qzCEXqRXnXV2ehYaoBH
 qOqWGIJpDEWFNh1JK/vD8eIvhjxIlCdECDDbgu5KHM8O8URQEBald/ol8j/ZyYw/FGG2
 Aq7qfvbzND28RwG0NR/9od7GwQ9f1lTGAQBb4K/qZ19xQPdrJQ1HOJr1J9w7alEsK2Wc
 Zuc84AdexzdjyjOW86QQm3vQCn8PM/4i3NPXb3l1rqdo2/FD5NoxJowVwIMMGbz5eJoc
 eka0X+3JRIdegX7XTGRF6gJFPRTcgEVCs8/LaR1+voh1YuwuKUn3e9es0UcO+VUEox32
 S8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647175; x=1785251975;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3BB5gEj1PmQnCqJnAaI6yvp0ctrN2b8GNGEP4+jeUKI=;
 b=Phz1VBLxJ8GFnABkSfVQ9Z7Q19fXecgzzmTi0s+wz/SyzUwkMfGFkUTxZkOwr15ZP+
 ZnkdR5ZJwbVzmKInpzCohAJinWH5sHw0yUWfHjVH1sHgBldv3Y/l5u/TNocNO3KWdsC0
 RU4YD49KMeZvuyTLMfFSTMJcECeNBdWMVtHsqsW4t3rXshqCPaLP6xY67k7xU1aBd1yj
 LD86IxNwTsm/4OR2OvHVHSI/rglBTZWs3787bs3tfeMy1UeYVZW+7lWSpN21AN1IN5Gx
 z/MEMl7xphVDDvqeeMDdeydj/sE4za+2bHAEAfsw5oKM9yeM8CzVxHDbc3yOO8OdM54p
 k4bQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/pzkjKMYyTWt9skx52qwbD5tkdnw1Q7nlHgQs7iZn/fUjQGJmLFs1d4txU1xCUSBAVfsPAryURoXW@nongnu.org
X-Gm-Message-State: AOJu0Yxg4mLPio7KGUrD5jfJwlczFiMvinoWzif33kY4/PGmipuKmhqz
 r3/6yI6wtuy7MzCp25AQHBOPBnXflQQDqiclCtOBvta07gYSXwK1nU74a/1tXPHRDN4=
X-Gm-Gg: AfdE7cmfAZFcu2tLxcQtf2/75UEfP57C9u4W3OIM9PypXxoXYZkpfr95rfRNxhq2AS+
 ZLLpKhfOb7kUW0xW4gt6Sp10wPaNOfeVVhyUcJQvuN8LplTYZRINlJ2Wx/Wicdlyp45SAoTJ+KS
 h051oGrHAANDIca2qmQA6QYx/f4cFQIJc4AwjB9yY70dJXg4hh+UcbvezmgjBAux0KUiXiodkuB
 vU9XY1sH7DlypFbqOJCuzLK5x60/ozrS1ebjoKLS2zJ16MCdvBrfz1rSdl4AlCExvtY+HHcvxqE
 46XLcxlEcKUWRvA3sohdg5mDThk4d2y8DTjll+K4BU8i48SdH+8oa83YRhxKv043ShBUw9JPVS4
 0urVJv7q0xLQ4xJ61JuuSlnLWTiZsZm/pUVIlly2d8ii2DD17QeJQZDYeqz5pKfq0/uUj6/ijrD
 ai6zvpW1z7OLEo3AxvMrBvs73SRA==
X-Received: by 2002:a05:6a21:ae11:b0:3c3:c130:3532 with SMTP id
 adf61e73a8af0-3c3c13044f6mr12784112637.41.1784647174730; 
 Tue, 21 Jul 2026 08:19:34 -0700 (PDT)
Received: from [172.20.2.34] ([32.140.233.50])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb517ba3222sm5997806a12.5.2026.07.21.08.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:19:34 -0700 (PDT)
Message-ID: <32e3c6f1-72b5-45f1-b10c-64d89f762c64@linaro.org>
Date: Tue, 21 Jul 2026 08:19:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/accel-irq: Avoid using inlined functions with
 external linkage
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260721111201.85714-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260721111201.85714-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 7/21/26 04:12, Philippe Mathieu-Daudé wrote:
> Similarly to commit 9de9fa5cf2 ("hw/arm/smmu-common: Avoid using
> inlined functions with external linkage"):
> 
>    None of our code base require / use inlined functions with external
>    linkage. Some places use internal inlining in the hot path. These
>    two functions are certainly not in any hot path and don't justify
>    any inlining, so these are likely oversights rather than intentional.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   accel/accel-irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/accel-irq.c b/accel/accel-irq.c
> index 830be27c7f9..b687f663394 100644
> --- a/accel/accel-irq.c
> +++ b/accel/accel-irq.c
> @@ -90,7 +90,7 @@ int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
>       return -ENOSYS;
>   }
>   
> -inline AccelRouteChange accel_irqchip_begin_route_changes(void)
> +AccelRouteChange accel_irqchip_begin_route_changes(void)
>   {
>       if (mshv_msi_via_irqfd_enabled()) {
>           return (AccelRouteChange) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

