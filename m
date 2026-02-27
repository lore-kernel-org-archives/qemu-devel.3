Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A97104891F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6ev-0002JW-D5; Fri, 27 Feb 2026 17:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6eu-0002J8-0x
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:50:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6eq-00047r-DS
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:50:06 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48370174e18so14553595e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772232602; x=1772837402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sPopO+rtxGbf8mbPUkMqTuisGzC582vtWQ6t1kx3hPM=;
 b=Uva4AdQCWbAbSI7ESiavlXUWTrtSDyNI/0tB6SFgq/M/8je52YiGy1zUzQ8n5yXUh7
 843UnQ+2qnsndn+92cJcnF9X6e+iy6c2AKFbMKt0P4R8kq3GlvWT8P3PqACBwEUguvEP
 erO2tqGkDfZ/Yx8cBDXgPlJu01+eEQg4aJs/Sp8zA1vF6P9nDl8IcnfvllAcD1xkuQqt
 kK/5uNV3h0Lzu70yL1agMc7DXj0clKolHw3GaJ1VDajZ/Dgl+6OYj13VH5MAvkCPtXk4
 4lRunAcOhvljoe4yi3S2ZMgfMQ9uIizGHUt1fxTfZE3JEAgSzJAqlv3fTpPptM49P0I4
 aKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232602; x=1772837402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sPopO+rtxGbf8mbPUkMqTuisGzC582vtWQ6t1kx3hPM=;
 b=bFLi0pj3GrLLiMEDw7cmx/hlbRZTz/iicPGj7odbZF+fYJFfTzIA5itf7x0qCxmqW1
 W5O824UmNvx7zFAgAuu1KmFDSPDNpE1q7y8rfgFHvYP8QDDWNGCFZ8o6f6b7l1e05pQ8
 LjdpHFJINW/ilV3Q25lNqtuJkh4ubsS7vHkD680RBtPvwRHrEmSOBWkLqMkXrZ3JTgs5
 Wbz1nn4wPbImXoxaGnaTLe1M5zfEUksm89r3FNIM7wH/WPFbD67scSVul0fsGT8MCK3s
 uVt9B/Gpvc5NO6ts8jXmMbMm1Q7uQ6gcb3oyvIOL6GMOti4lwQEWDtefLyakH++UiyFq
 TIKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXITH/kg49TGetSfnCbZ1rrBEeqahn/W3OBhTowA3cm/4z4vkrOARXr+PtSBnLlY24dK3NI7pUqG0T@nongnu.org
X-Gm-Message-State: AOJu0YxBoERSlfQ9QsZVEIJ5Ny8XkDbXhx6NNy36bOJL56EAcOaQ9ydO
 CChnCq9ifJCqNNCDSKwo835WdyagZw+T2bRbEe+n/HboqJW09PkVWJheg7HlCkaDNrE=
X-Gm-Gg: ATEYQzzWXMJy/b0XvyXSiqz2r90IfxwoyBD4dSTi0jaRIpekeJwe6fBjHjPAh6/jqeT
 FzHdZMmUaanVaIMkk6I8mAZEKz67HtlBbaeJHGoWzjgwssFJspNgC14TpRZmR0PoRnnHebO8xYc
 FYP6u5vgNtkAC2bURyEBpzNgU6qWHfxmMiCxaTZxkfRaI+pjCFPla1aO/SzgsH/eua1X1m2nx7b
 vM9PUdyybm+dqx3e+zv4GT3SiC8xZKRX9M37MR98iBHkvJSEJ8PEFhiAT3n3wuGkXkxxKyEY7Lo
 9Lnf/3oCNZv6mGMATuUtEvreE7lSbHnFmGmnS5NHn+eFnNcNe2D4YHoET9dAws9JC8qJiyHLzBy
 bo6ojBQGUGmC6hJr0JBo+1K+6iYwoRLLMQscrNaS3JLojnVmKsdFW+CDupV0oHz49J8ULGPHuAn
 CXEgMSA5pFEPwgxEdaOAS9xvQGI5KOA2FZi0EswKoYbPlTZzgcyBAvuBoIjS6kmQTiLQ==
X-Received: by 2002:a05:600c:3e8e:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-483c9ba2922mr75058575e9.14.1772232602347; 
 Fri, 27 Feb 2026 14:50:02 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b3ce8fsm135027055e9.4.2026.02.27.14.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:50:01 -0800 (PST)
Message-ID: <c17ea52f-223f-4845-86b8-7ceb5182480b@linaro.org>
Date: Fri, 27 Feb 2026 23:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] config/targets: Add RISC-V userspace targets
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-9-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225102016.200654-9-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/2/26 11:20, Djordje Todorovic wrote:
> This commit adds necessary tagets to build Qemu for RISC-V userspace
> emulation.
> ---
>   configs/targets/riscv32be-linux-user.mak | 7 +++++++
>   configs/targets/riscv64be-linux-user.mak | 7 +++++++
>   2 files changed, 14 insertions(+)
>   create mode 100644 configs/targets/riscv32be-linux-user.mak
>   create mode 100644 configs/targets/riscv64be-linux-user.mak
> 
> diff --git a/configs/targets/riscv32be-linux-user.mak b/configs/targets/riscv32be-linux-user.mak
> new file mode 100644
> index 0000000000..bca84945d9
> --- /dev/null
> +++ b/configs/targets/riscv32be-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_ARCH=riscv32
> +TARGET_BASE_ARCH=riscv
> +TARGET_ABI_DIR=riscv
> +TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
> +CONFIG_SEMIHOSTING=y
> +CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
> +TARGET_BIG_ENDIAN=y

See commit 91fc6d8101d ("linux-user/microblaze: Fix little-endianness
binary") and its references.

