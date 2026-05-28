Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F53CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVAw-00053S-A4; Thu, 28 May 2026 03:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVAL-0004qM-RF
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:28:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVAJ-0003G5-6w
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:28:29 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ea19f412aso4175452f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779953304; x=1780558104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CaPIm6kuVkuS05YEUBKN86/i2UW7SsqH8aglR7vMRkk=;
 b=pSp+lV+oQfHXYdeq9hOoNBQYP2bc2/Xoqo7riZNQgfUnRmrbwRckZCdDKgkzB6Hs8p
 Bimck/ADfNN+l0brWcCJbbXgyBdxPtX5YhEZw44oPm720k+ILUNzfBaLjaVVaX1UrTcz
 8/Dk0Bt7GPJ4EZLJUkQI8BzfSu3gGWolvaaapmePV8iINH8VX7pqqhCGODnwo0nzLPx2
 DBbmvCY4j26qZ7LXPyFeBg26dNYTxVMjXaDAD/eUOGQtYbOnxGq/8QQlFccyUZPYkxol
 yNR39FMCGvaHYquSKuHB6FIF2GpT809nYAA5Jq9phSwSzb2zdyFeqXjWl4zkatbWEaHz
 XeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953304; x=1780558104;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CaPIm6kuVkuS05YEUBKN86/i2UW7SsqH8aglR7vMRkk=;
 b=EHn43K63FuUC8Ru9VGfITW8XPhWHI2gx1XpLoFRxnAO3jcslBBZT2QX+4VWwLN7P9K
 52nup4gKR0JF6ARxVSJZjTxRDEZ2eKOj7hDgTgIofVujB2TcF5m0D9yBm+kLH9j/4eYk
 9FUuAoiOPYkBlIRwW+l8Gkg52rFZJNWJ3mBGLoVufPFUdZKLpsYE3MEy/fAQzQzfZoga
 1I3S/c/UeKggEx9ZCB8y1gTUh7uKVBnTUGD8RUzuy3i6YKS4XOMCY26zpsQetaB/cz+e
 BZ4QV6wrqQQ7vbVBmvqeGGFZ5mmnp37YkFxvlsmiwHC2AUaYQDv25UEjSvtMy9xO0cP1
 IasQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oSjBrzonYvsB6zZnsKbDwHVvqMV4lr1Ay+u9XMS0RmBI/45OS/GLA5UIF+zGlSGJE3q1xDZTfh7yv@nongnu.org
X-Gm-Message-State: AOJu0YwTQVgl66EA9cYBb1BrFIoMdXakiN7SyzBqBjypXokcj67aVSMw
 guWL5TcVMh2OloKRE6YLTGftZbNBL3oYP+XqqBfu0OCnXUFQwYmhf+fRBtUczeLaj6w=
X-Gm-Gg: Acq92OEePZdrLWt9pVJ9pb7j+QFV8AYYevmOCminBnnOEig0Ya0kmIiGsRp4kiszpu2
 Pwgx3hNUH+b83ZUIOI56Po2xSkLGrOGLbHFARvSkiiVNGyBE09v5lbGH+dSbN6gRvcGpNOowVH/
 nWpyzAGNMCWJDnKP9IeZacKY4svw9Wjji4KLabhwRu/oTOBzgII/qWeWxBSHRytUhcIifQeKWfE
 qcyShwqJ9/+49TEgQbFQMlMJsRdu8PNRnW6EfgUtVR53PDhG1SSa1UE/rhcvkWnv3EDgU8EmS+p
 i8GnBfQDkE30C/UBnDG7xM1SmhpGnGy/z/4iLnSILirOSgTJwy+GUbxbqz15NAYhLEfxEoUPu8U
 opyXbcSeduaxd9rGtGzPTFfQm9az78sepCIUIsOEiTQ6Y+UI5NNw71pZ/WFl1RZJvT7OM8KMIkA
 4xdOnmDF0etF8sVW4l1MPUnR7ey0L0tzEIZgfZzuSRZExj2l/ZEu71utmT7yS75ruLDw/qligad
 0XeQURDq2ns8bM=
X-Received: by 2002:a05:600c:470e:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-490426aa413mr426075305e9.9.1779953303632; 
 Thu, 28 May 2026 00:28:23 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eec25e7c4sm479570f8f.37.2026.05.28.00.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:28:21 -0700 (PDT)
Message-ID: <60f502dd-31e4-4065-a988-7f8fc57ff334@linaro.org>
Date: Thu, 28 May 2026 09:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] target/arm/meson: move kvm-stub to arm_stubs_ss
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Brian Cain
 <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Peter Xu <peterx@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528051642.115721-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 28/5/26 07:16, Pierrick Bouvier wrote:
> This eliminates symbol conflicts for kvm symbols on linux-aarch64 host.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/arm/meson.build | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

