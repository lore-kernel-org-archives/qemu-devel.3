Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32375C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsSt-0001O7-21; Mon, 05 May 2025 05:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsSm-0001M8-UT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:50:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsSk-0004pI-PF
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:50:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso29538705e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746438612; x=1747043412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FfGJii8dstPhD4zK2v2r39Grw+mcazrDdHC/aSHx52c=;
 b=YbbEaFR+tlAAKhNRXBODD+5VH1Kt6cICJI5+LLn+SIi+yGy3DnbQjAvvOtbFzoRST1
 Z2gp9kk2CIJ635z7X7qwfYIMXrz8bIvAVGrCINYB4jIIHfdOwhtPNtCsiWCDaymbbPHX
 ZH/NItlBgfS+Hp67VEdpuwqyXqe6MhxC53D7DAr0/WSeNGgmXSRCYwPKoaC1Dy5fJw4p
 n8BjUmc6VkIcALGDm6Z/gzrl4c+sxg/q+lf2UCHBU9OFeK38cOxmiS6XnXjkiUY5fUhU
 ObI5tXP77zk/vPxWfIXZe+IuEkParTF50D0uitxjq4MVT7RhgNzwTKBX60479PElquQ/
 NjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746438612; x=1747043412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FfGJii8dstPhD4zK2v2r39Grw+mcazrDdHC/aSHx52c=;
 b=ho6xOjZmbFJ6J58wp33CNH6CRFjWaUE03hDy99ANGoWBS0QeeB38R499zz7S0ntsWM
 cj6PavKOoiey8ZfV5cbhM0E7PBNRZ2zTt5En2a6cz4BUbuGlNtRYYPvSO/N8vMxfcEBU
 Kma7RxKckyjNDHQ343QbeWptrF3FyZopvOyxUX4C0B/jb1MNL/ukHK3nTtURosnd+zKX
 I7EvIg7D3ufwkJG8WHWtu6v46rRXd0HgSQAmgfy217F3a3phtDOqn2qlASTPE14UhzH7
 wqtjn3uQyO555Cmy5J1jgJ/RPe3LrcV9vCcsh3g7duKiyCkSrk9D0Uyb1ghdVb7OCaRT
 LYbQ==
X-Gm-Message-State: AOJu0Yxl5Y0lM/mjuQdDcdOSPVeU0pUCsdh59Ypvev7bWbUkS6RhYRLU
 QominL/yBUvdJQbeu4PEvzLY+DQEnB9TI/Zbhn1uCnl3id5mhMdUYn3Hc8nWOWdKVTq1ieYvo3n
 Qua8=
X-Gm-Gg: ASbGnctonwOjOUP58qRfbnZjzXMQSP3DVaX7PRry1MZHvyB/swj7fXea+0wqEyNfCfq
 yftir6jQ8KqbjSJARINYqgW6X4o1nv2UAGLfislczl2aOvWEQSHsUOg+gkDYGtqp19yDEDzh9EW
 yecoQ6PXkBn9plId/pv7sXaUvXyVuGa/fEFWWvMx+r3a/0sJKEJc4m8p6aov63IS4bXsHE5cW5c
 qcncecNmXGQApfAhxcZNkndIkUM0lPf7ZmgoQ2eifb+qsd1KN9qupEcXa4Q8yGVMlzITj66FLoF
 YZgHVHu6QlYRFpHXmbTxe32voL1Zqfl7QHzdGNUtjxqRUhZgToni+6+VzIcsY9bvspNRMSK10lN
 xLfXY7BjlPqyjVOsopQ==
X-Google-Smtp-Source: AGHT+IHsmsNafSTmERepxkLgLYJHJl6G+FicjYFhGDo/kbaOsxc+YmgL11xlNg/eRiadPocSaZvBEA==
X-Received: by 2002:a05:600c:1986:b0:43d:8ea:8d80 with SMTP id
 5b1f17b1804b1-441c48b01c5mr53717405e9.5.1746438612490; 
 Mon, 05 May 2025 02:50:12 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b391c42bsm166180125e9.39.2025.05.05.02.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:50:11 -0700 (PDT)
Message-ID: <97eadaef-7c1b-4561-af9a-bd887e00d19c@linaro.org>
Date: Mon, 5 May 2025 11:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-12-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250502185652.67370-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/5/25 20:56, Philippe Mathieu-Daudé wrote:
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c |  9 ---------
>   hw/i386/pc_q35.c  | 10 ----------
>   2 files changed, 19 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 98a118fd4a0..98bd8d0e67b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -755,15 +755,6 @@ static void pc_i440fx_machine_2_8_options(MachineClass *m)
>   
>   DEFINE_I440FX_MACHINE(2, 8);
>   
> -static void pc_i440fx_machine_2_7_options(MachineClass *m)
> -{
> -    pc_i440fx_machine_2_8_options(m);
> -    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
> -    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 7);
> -
>   #ifdef CONFIG_ISAPC
>   static void isapc_machine_options(MachineClass *m)
>   {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index b7ffb5f1216..a1f46cd8f03 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -648,13 +648,3 @@ static void pc_q35_machine_2_8_options(MachineClass *m)
>   }
>   
>   DEFINE_Q35_MACHINE(2, 8);
> -
> -static void pc_q35_machine_2_7_options(MachineClass *m)
> -{
> -    pc_q35_machine_2_8_options(m);
> -    m->max_cpus = 255;
> -    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
> -    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 7);

As noticed Thomas for 2.4, here I missed to squash:

-- >8 --
diff --git a/tests/qtest/test-x86-cpuid-compat.c 
b/tests/qtest/test-x86-cpuid-compat.c
index 456e2af6657..5e0547e81b7 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -348,11 +347,0 @@ int main(int argc, char **argv)
-    if (qtest_has_machine("pc-i440fx-2.7")) {
-        add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
-                       "486", "arat=on,avx512vbmi=on,xsaveopt=on",
-                       "pc-i440fx-2.7", "level", 1);
-        add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
-                       "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                       "pc-i440fx-2.7", "xlevel", 0);
-        add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
-                       "486", "xstore=on", "pc-i440fx-2.7",
-                       "xlevel2", 0);
-    }

---

