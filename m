Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE47EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seres-0003Xb-MU; Fri, 16 Aug 2024 03:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1serep-0003O0-Dd
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:45:59 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1serej-0006zM-Mw
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:45:55 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52f04c29588so2406565e87.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723794351; x=1724399151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E8zfuy3NR7AlHNHDsbR3o+wf44AiCc4XhXo8y8oRdlY=;
 b=DplPEWyobmz9FqOssBht97FUgAL9ABsyrxbLHO+CUGKjioPP4lkUFvWpxMPEHCT8y2
 tQw4HIaT5sUcDrdcztfj/GzzuDf0w2z4m95BeviO1TNB4ZnzHR6u2dfxxQkqM7S9sVtq
 vowWj+6skZqRfQ2RZN9sNdbOYJqkXWOKPpHFdLdUYTL/tJKC2XKGeHVNCS16tQTByHh8
 vY4zPujluhFxE/DWX0zmbzJXgBIJkYVi4vE2nauw61bETMsRNXynPO615jQnEibBbGya
 UE0qGOuXvkf8VjVlfMRC3bk8+XNL7zo/sirXMOVibaav8/4c/e854tAcqRgtklHGSD9c
 5XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723794351; x=1724399151;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8zfuy3NR7AlHNHDsbR3o+wf44AiCc4XhXo8y8oRdlY=;
 b=JVGEp87yw1j7PeRwzda/hgjdeN+HpSSLMF2v6UtODz5PLEokT37kQo4/AZexWXCKDZ
 mByfzRr8Zo6c9IPXnp+IvK/aRX0+d0Kn2oiByTwbx+ru4kkbBMjMqRCl0Lm3F/59WihI
 SiZQPLy1Xo+QYYUvefhFFTZrfOA0d23kmq+PW4IlKB1JxHAWTzkVT51ekkSf2gOLBlnZ
 /rWlDbRtgt5HsLnr7qiNq+lWVrKvVw9rLzLZR2jvRvpc7+GVKBHLruUXc9gZr1loGHl2
 jxnt4vvOI73LkcKNDZIwGJtVAlp+NAk1IvJnxtkHoOT0os7Cl/jH9eUEVIOdB5p4z52c
 CZqw==
X-Gm-Message-State: AOJu0Yy8MmxLN76EfRQJfKMBkWQNK1gu1oQBgO1tZb6FWadkfIwKeOGd
 L6apBUoxhCEsv7pb5cncoJ0K8vUq6caOaQdfm1/FXt9w74D79/1oIb4Lf9HfZEs=
X-Google-Smtp-Source: AGHT+IFFYwM7wrPAWIni94g38liogVdTfBjra76TFjahXzDBLUfWQdwObwJ4O7g8fheKu/Hsh6aFVw==
X-Received: by 2002:a05:6512:ad0:b0:52e:a648:a72f with SMTP id
 2adb3069b0e04-5331c6dca2fmr1551146e87.45.1723794351154; 
 Fri, 16 Aug 2024 00:45:51 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded7cfc6sm70328735e9.42.2024.08.16.00.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 00:45:50 -0700 (PDT)
Message-ID: <ddad1d38-2f4d-41b8-a7b5-69bec00ebe02@linaro.org>
Date: Fri, 16 Aug 2024 09:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/5] target/s390x: fix build warning (gcc-12
 -fsanitize=thread)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240816072218.27125-1-thuth@redhat.com>
 <20240816072218.27125-2-thuth@redhat.com>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240816072218.27125-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 16/8/24 09:22, Thomas Huth wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Found on debian stable.
> 
> ../target/s390x/tcg/translate.c: In function ‘get_mem_index’:
> ../target/s390x/tcg/translate.c:398:1: error: control reaches end of non-void function [-Werror=return-type]
>    398 | }
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-ID: <20240814224132.897098-4-pierrick.bouvier@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/tcg/translate.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index c81e035dea..bcfff40b25 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -392,7 +392,6 @@ static int get_mem_index(DisasContext *s)
>           return MMU_HOME_IDX;
>       default:
>           g_assert_not_reached();
> -        break;

Why aren't the other cases problematic?

$ git grep -A1 g_assert_not_reached | fgrep -B1 break
accel/tcg/plugin-gen.c:253:        g_assert_not_reached();
accel/tcg/plugin-gen.c-254-        break;
--
block/ssh.c:476:        g_assert_not_reached();
block/ssh.c-477-        break;
--
fpu/softfloat-parts.c.inc:1375:            g_assert_not_reached();
fpu/softfloat-parts.c.inc-1376-            break;
--
fpu/softfloat-parts.c.inc:1388:            g_assert_not_reached();
fpu/softfloat-parts.c.inc-1389-            break;
--
hw/gpio/nrf51_gpio.c:42:        g_assert_not_reached();
hw/gpio/nrf51_gpio.c-43-        break;
--
hw/misc/imx6_ccm.c:303:        g_assert_not_reached();
hw/misc/imx6_ccm.c-304-        break;
--
hw/misc/mac_via.c:497:                g_assert_not_reached();
hw/misc/mac_via.c-498-                break;
--
hw/misc/mac_via.c:558:            g_assert_not_reached();
hw/misc/mac_via.c-559-            break;
--
hw/pci-host/gt64120.c:691:        g_assert_not_reached();
hw/pci-host/gt64120.c-692-        break;
--
hw/pci-host/gt64120.c:935:        g_assert_not_reached();
hw/pci-host/gt64120.c-936-        break;
--
hw/scsi/virtio-scsi.c:359:        g_assert_not_reached();
hw/scsi/virtio-scsi.c-360-        break;
--
hw/tpm/tpm_spapr.c:208:                g_assert_not_reached();
hw/tpm/tpm_spapr.c-209-                break;
--
target/arm/hyp_gdbstub.c:160:        g_assert_not_reached();
target/arm/hyp_gdbstub.c-161-        break;
--
target/riscv/insn_trans/trans_rvv.c.inc:3174:        g_assert_not_reached();
target/riscv/insn_trans/trans_rvv.c.inc-3175-        break;
--
target/riscv/insn_trans/trans_rvv.c.inc:3259:        g_assert_not_reached();
target/riscv/insn_trans/trans_rvv.c.inc-3260-        break;
--
target/riscv/monitor.c:186:        g_assert_not_reached();
target/riscv/monitor.c-187-        break;
--
target/s390x/tcg/translate.c:394:        g_assert_not_reached();
target/s390x/tcg/translate.c-395-        break;
--
tcg/loongarch64/tcg-target.c.inc:652:        g_assert_not_reached();
tcg/loongarch64/tcg-target.c.inc-653-        break;
--
tests/qtest/migration-helpers.c:78:        g_assert_not_reached();
tests/qtest/migration-helpers.c-79-        break;
--
ui/qemu-pixman.c:51:        g_assert_not_reached();
ui/qemu-pixman.c-52-        break;


