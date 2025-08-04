Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947E6C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj3Td-0004aO-P9; Mon, 04 Aug 2025 18:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj3TP-0004HH-EE
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:16:04 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj3TN-0005EX-BO
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:16:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76bdc73f363so3024895b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 15:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754345759; x=1754950559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FZdfH+6Sxbu1bsMX4Kvr/l+nPMXRzMZXajPSIE2P9lQ=;
 b=Kg2tazCZcoBaweDSQ8DATkWQJZ39AL/GSUYXZ7zBYv/qRpUfUj58/bh4Din+DbRi7j
 6BBLNTTX8oRWgP3xF3sKvrHdu19BPt/hMujkny419HKrh5q9vTB9RWHACUK+yPm5cvor
 FtilPu0LaQKqnoB2/JqrUpP7x+1xS3iZQO4WwCpv1eyahsGpZ015mxrt3ecvhwKVpzku
 yS8jLRoMCHlHlhIBzxxIyXSAhTofGiwG9yhIwQTYH7Ucv29hsK9+4C541xM8rtnMusTn
 6VpmcqjDdLz6mvB7s7EpmvRvyJpt2qICjtBULXVVHq6og/Vovpy1ieHHTNoiVMtllAcs
 iMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754345760; x=1754950560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FZdfH+6Sxbu1bsMX4Kvr/l+nPMXRzMZXajPSIE2P9lQ=;
 b=cftTBcvYj6p7oMOWGRS8hVWCO+rZgiJ857WYT5+a/xHGlO9wq49a/3NTpwHMVIq1vd
 84Ceyn1gesQ/6eUH5Xy3sjupa/SBoK0hf/Ku02gEzzvib6IIEjxoF1ejOR7wo2blZtgz
 C8QkWeOVUcktZh6v0oLkTO4XZav05CxNt9bSSDnr5qWHXNvIyifAm74Bt3gn8RZvvQj+
 oQeyYPCKyBJdjqroN7EnwZKMQDPK+5Hc5+nNjx936rpEdo7IULyBsTXBH7Jz0MRzPS6/
 byAsMGwjaw3XN6EQAbK/mZU5H+QZOpl9SSLuFMSJNhqsGVXFqo6FSzGJMKqM3hIwAOcY
 dCLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLly7aZ0P4fxm0cMr5rLm1kpJn1CSvf212EDLEQNzrOZajJTXjLg/XEPD4xl225+e7oZqJGyg4oKta@nongnu.org
X-Gm-Message-State: AOJu0Yy2WDVAZpQx4crw6oCQn5MoPLPH8dhrvsVbaObr5ecsGpvGpPJp
 rKGj7nRySCUxjC/6CpBsvYKQywjxg5Ksps8/Nim2xrw4RXK6WhRdukXWClZQ/3HoLWA=
X-Gm-Gg: ASbGncsXCtFxPnL/TW2SwNiB6ViIJKebiXjO3lvCyPXUb6ItcR3LsTXksFuZbzFxMNK
 TYsHl+9Kak8ieKAEW23Um97uiQ2i/nLTR2eohIMmyCZb2e2OqXG+RrE7X93T5mO0zlljFpt9cDr
 W7QqQX8q8W9fcV+6RY/LteBvcqebMfZNRCcjI5fqIkOZOJOA4NTJyDmx8S+3I/vDpYjT+umLnLJ
 j8r4kR9WQs+M0P0efcvB9jRBMaQmZwnm8dybihT0cSCIbB2M7GPkEVsOvhORA0xR6K8LnIb0FAF
 Fws1QSYAn1lnX5icghGpnRWPHUOH1FnVs9sPpf7iH7Mhc8HXU3rOY65kg+5ovJV6KzTMnIdEdPM
 HhBnCiGL2LVhTcrOafY9tVpXM94E3T3giiWg=
X-Google-Smtp-Source: AGHT+IFaeXXs0iqjcnaWnO4u4TXN+BXliP4Ucck6C04BwFxe5lAqbB5KkIvvc18PtYNUgm6I9+KWuQ==
X-Received: by 2002:a05:6a20:9389:b0:240:1a3a:d7ec with SMTP id
 adf61e73a8af0-2401a3ada6emr3676216637.4.1754345759646; 
 Mon, 04 Aug 2025 15:15:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f474sm11261399b3a.4.2025.08.04.15.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 15:15:59 -0700 (PDT)
Message-ID: <8fc78a75-dbde-47c5-b382-34d90b034052@linaro.org>
Date: Mon, 4 Aug 2025 15:15:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] whpx: add arm64 support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-10-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-10-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c    |   1 +
>   meson.build                 |  21 +-
>   target/arm/meson.build      |   1 +
>   target/arm/whpx/meson.build |   3 +
>   target/arm/whpx/whpx-all.c  | 845 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 864 insertions(+), 7 deletions(-)
>   create mode 100644 target/arm/whpx/meson.build
>   create mode 100644 target/arm/whpx/whpx-all.c
> 

...

> +        case WHvRunVpExitReasonCanceled:
> +            cpu->exception_index = EXCP_INTERRUPT;
> +            ret = 1;
> +            break;
> +        case WHvRunVpExitReasonArm64Reset:
> +            if (vcpu->exit_ctx.Arm64Reset.ResetType == WHvArm64ResetTypePowerOff) {
> +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +            } else if (vcpu->exit_ctx.Arm64Reset.ResetType == WHvArm64ResetTypeReboot) {
> +                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +            } else {
> +                abort();

Just a nit about style: would be better to use a switch (as this is a 
propert enum), and g_assert_not_reached() for default case..

---------------

The rest of the code is pretty clear and straightforward, congrats.

For other reviewers, most of the constants and functions used can be 
found here:
https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/main/virtualization/api/hypervisor-platform/headers/WinHvPlatformDefs.h

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks,
Pierrick

