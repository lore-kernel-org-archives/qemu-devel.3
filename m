Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A451CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlY3-00028c-Lv; Mon, 20 Oct 2025 04:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlY1-000288-PZ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:47:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlXz-0001op-G5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:47:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47114a40161so44695275e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760950036; x=1761554836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Of3uewAO3yCysevkqNLAwZud/sd1kOhE6Kb4BtcmBA=;
 b=jil/1lfZU/R703+ykTdFUoeNOhdX7sesfVEfyfm83BUAaSOwtf+DyvVGXZaY09snVf
 qVHzQZvrnfk8Hsh+ZakAADBJq2fG1aet3sM6XtAMYMuV8ebMT18//qyLAsSavpyh8b4F
 kWjdDpSL1Tnlhm+8WGc0gGEpBU2JnZreD6Ie23DVcDo8EAAD9EXdP+Thkx6xTdXXNUSI
 ZOoNlhCFLCjEUZ30fWdiFxZE9934Qux35iicTpP6GnmEHmQDnYqEOCoGOPw3wRHX4nwy
 i52WHVpKlqeqL7xXTBs/tcbm//9PFIvUVIwE8zpGwBofu7pcyPscxbn5ofA2faddD3TH
 VHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760950036; x=1761554836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Of3uewAO3yCysevkqNLAwZud/sd1kOhE6Kb4BtcmBA=;
 b=rFHzhg+iT5E0S2KcsLXXmhkAeXOPeMkfSawmYlKkTg/dPUP5UXNYiPOSFVJEKo0Z1K
 nzrSX4xZBv+nT7X9HvwD6ol9azGTYS3115l9K4z/lBza440go1f014F96lFy6EHSq9Rv
 JnSZm1dDcVsYZo9G7W9ZdCRsWDMjJjKtfE3tmi/e0QCYoflKfcBE71ryh2NLB+323Htn
 Y971uNQok3/+14WibnJ/kI+XyCsRks3WQQ/gwQj0JZitzOdzA4FNJqxWox1Y4RyNXYrQ
 bj4w/diwpimQ6pzFaasepMOxSodzYAL/JVGWIBnzK0WPdElpzCZJ5TzZQJPS4ZZ+bptQ
 iCPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUndxlcdKJ+boQmf/BVcE62dz71v9A1Q+eviS6RUDo3VMEvLtFY1IC00CDMh0d9mdi8rcGtFQnUKy+I@nongnu.org
X-Gm-Message-State: AOJu0YzLWckJFadVPaBQriEhBYSp3jfgbaEASmea/lcM9+DOPE9pRQAd
 2wP+GwfOocAaiiVb92FGRB+xqDzbog1Mzleh7b1yk2GaR0Lp08nHdy1auialSMxNzbo=
X-Gm-Gg: ASbGncvJwqzW1xjnZF28UIftA0uJbOYOTtWWfXNFi6zfIL9xnQMjQRlbUf7H/hzhVch
 Qd99vpImKuFwe3hr7woqXl9udKjwGQ8p9biCYEMFBz0t5S/z4l+/2EPeTVV4QMa8C8ddrGdgv3l
 fvJtTYNyN/KjRJheWZ7Uo4eonNmtrlh9Y/BwGmwniEkiE31mmEmPDDUzGOIrw2DfkzDO+Da4ChL
 uj1jSgKGy7VAEQyAJszULOD2BvwxOm99rd5rkaX+iA56JaYxC+SIYGe66SEnmLL4yToB8cz3vja
 PVKA0GpmmRIC7Wac7n1zB6yRPxylr404SPnfAaweeLACFN/LuSBVpyKE7JmIEmPGXtqp+V/49RI
 mHAm8UqgXjUOvwI4NkQjgToUA6WpoC6/QSqs/fOEqZB0OKlCNlsVpRZEk68mw2NVBiWkUYRnj3D
 oT1CDftMEU3P2LEJzeU6hIGnLyH57+nfQxd6hwqSVBq4jQOlQPj0GYxA==
X-Google-Smtp-Source: AGHT+IHY0p/jK/cBNZvwD6LfmSNBe3xGmuuDpVyi3JvyIF4GjVigfEiDTbVZiJXcgwXwgA2Bew06uQ==
X-Received: by 2002:a05:600c:548d:b0:46e:436c:2191 with SMTP id
 5b1f17b1804b1-47117903f96mr95543935e9.25.1760950036513; 
 Mon, 20 Oct 2025 01:47:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520dd65sm132120955e9.15.2025.10.20.01.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:47:16 -0700 (PDT)
Message-ID: <7673cd4a-3617-48eb-979e-e2b4767c315e@linaro.org>
Date: Mon, 20 Oct 2025 10:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] hw/ppc/pegasos2: Change device tree generation
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <f52d9cc6af5249e306ba7a9472ef781b8e1260aa.1760798392.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f52d9cc6af5249e306ba7a9472ef781b8e1260aa.1760798392.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/10/25 17:11, BALATON Zoltan wrote:
> We generate a flattened device tree programmatically for VOF. Change
> this to load the static parts from a device tree blob and only
> generate the parts that depend on run time conditions such as CPU
> type, memory size and PCI devices. Moving the static parts in a dts
> makes the board code simpler and more generic.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c        | 292 +++++++--------------------------------
>   pc-bios/dtb/meson.build  |   1 +
>   pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
>   pc-bios/dtb/pegasos2.dts | 167 ++++++++++++++++++++++
>   4 files changed, 220 insertions(+), 240 deletions(-)
>   create mode 100644 pc-bios/dtb/pegasos2.dtb
>   create mode 100644 pc-bios/dtb/pegasos2.dts


>   #define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
>   OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
> @@ -411,7 +403,11 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
>           error_report("Memory for initrd is in use");
>           exit(1);
>       }
> +
>       fdt = build_fdt(machine, &sz);
> +    if (!fdt) {
> +        exit(1);

To avoid confusing users, either report an error or abort.

> +    }
>       /* FIXME: VOF assumes entry is same as load address */
>       d[0] = cpu_to_be64(pm->kernel_entry);
>       d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));


> +static void *load_dtb(const char *filename, int *fdt_size)
> +{
> +    void *fdt;
> +    char *name = qemu_find_file(QEMU_FILE_TYPE_DTB, filename);

g_autofree? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +    if (!name) {
> +        error_report("Could not find dtb file '%s'", filename);
> +        return NULL;
> +    }
> +    fdt = load_device_tree(name, fdt_size);
> +    if (!fdt) {
> +        error_report("Could not load dtb file '%s'", name);
> +    }
> +    g_free(name);
> +    return fdt;
> +}


