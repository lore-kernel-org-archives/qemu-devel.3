Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409A6CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1hm-0001ka-Nq; Mon, 01 Sep 2025 06:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut1hk-0001jv-Dz
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:24:04 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut1hh-0004Yr-MP
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:24:04 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b042ec947e4so114463066b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756722239; x=1757327039; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmZph1RVlIckYsUtSQ1kRyrwHKO66MXhKOVe8f3dlYU=;
 b=iChANKMHcfMooy9szlScX4ttzzpfG4x8dBxoWQldaZXMt27fn7GHycgVBk8CSODgik
 1egU3eA6WUGb5CrWiOxwqpW7SvpvoV2zpjaPuuarrKPV1yM/T6PznJ0jIpVc6LzvDvmb
 nsAkf9WPAtr9X8m14BK9rQwf13tf/l5lMV2pbkDu0AY7AqiQaayxWbuB30l02/aspqvk
 a7Q/LG014pIaTAYXN63NF760ZghIoeqLW7D+DlIkBOZ2T5XPAl7rSu0nJYmne0nhTTN1
 gHrONy4aN/uqQ8yYwLaxeWEbDr3tdkfQB5t4Jrbn0Aq5xcpSidGEqXmMGZlSiHbuvE6F
 +XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756722239; x=1757327039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmZph1RVlIckYsUtSQ1kRyrwHKO66MXhKOVe8f3dlYU=;
 b=M5PCeBeNP1mcdSf5/NujCnZkR89us3ukn7U3+V9SlX1gWXI1T2WVV7mkfRk6rG3wXn
 tWU9Z6BOIOVkDPXjnkT1byNANlRRJTu65t4ohQUiQaDWyHCn3eCcW/uZeflw+XG9/COw
 FqKM3M4wua/W4Bsl66jngxe1Z5Ml8iK+GUEB59T06Q3LPBC6cr5cel1FkzwPmjV4A4zP
 T+lDiSuy6ZxMUnFzFCuzsYp83qZu9eFgT28/rY5s7q0RKZS5MN0Ehan6r2NLTdLonrsO
 EBe91b95BCIWYKoSw3ZND5YJ5MVDRqqYFVPEr3WUkeOVomGe2N9fH1japmzhHyDHWeel
 5K3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6SQ/IWjrYCdaXm5qQxKMLcPWardsDXk4nOwn2N4lXPCEfyZvItLIGACQbDaazw9R5Y+T5WKbUZs+c@nongnu.org
X-Gm-Message-State: AOJu0YzCYeWyKHfnUC2GoCMP2hQSJycnh+WQWmqoxXDQvv0i7OwhgWp5
 nDWgz2Ib1v76R96ZU1Hj1QoSOaFpZaA16Hqp3WjUNvdJz23Nd/CvufcqPsrWKhoGR/FjbdcOv/C
 xlbIKDHTxNkLxGANSbuW7nQaEH62z+sDL4ZWsB5Pp9A==
X-Gm-Gg: ASbGncuaONg4sUxfFG1O4wQpYI6zdl2rlUxdtricu2tWSJReaATN2xQ6D6F7tLfhwHV
 lSCIIUkEeZMncgxQi/9f6aDD9xibI6Y/rn0qYScCnBlHoPWgnnVCEy1diSYRBBc5l8e8SZLmXqm
 /GSWm9XQ/du8WS54in0ENHNK2AVFsO9NLoqdcj7+2v3wkcBgE21MDeuSfcRP5/chmo8i4GwddS9
 cC7xuXP
X-Google-Smtp-Source: AGHT+IEjMtgAI856oBdkpRPUG6G/3DjavL3E5L1+Whkd/Q6cX9Ej62cdVnUb1GsMzPfwmBGQpnfWYj32GipbEG+/xUU=
X-Received: by 2002:a17:907:7f1f:b0:afe:97eb:4327 with SMTP id
 a640c23a62f3a-b01d8c749admr728626166b.20.1756722239246; Mon, 01 Sep 2025
 03:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250901102214.3748011-1-peter.maydell@linaro.org>
In-Reply-To: <20250901102214.3748011-1-peter.maydell@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 1 Sep 2025 13:23:33 +0300
X-Gm-Features: Ac12FXyMDh1tCYB-M5ItDsuaaJJ1dTyUH4Pi830LZAZnwbbHsVpYFPwCMTid1k4
Message-ID: <CAAjaMXauWTbVhNVKpLgtbaz5qtorAZRBFM2-Rp+V5Z1GOmknnw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: Correctly free the MemoryDeviceInfoList
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Mon, Sep 1, 2025 at 1:22=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> When running the bios-tables-test under ASAN we see leaks like this:
>
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x5bc58579b00d in calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qe=
mu/build/arm-asan/qemu-system-aarch64+0x250400d) (BuildId: 2e27b63dc9ac45f5=
22ced40a17c2a60cc32f1d38)
>     #1 0x7b4ad90337b1 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.=
0+0x637b1) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5bc5861826db in qmp_memory_device_list /mnt/nvmedisk/linaro/qemu=
-from-laptop/qemu/build/arm-asan/../../hw/mem/memory-device.c:307:34
>     #3 0x5bc587a9edb6 in arm_load_dtb /mnt/nvmedisk/linaro/qemu-from-lapt=
op/qemu/build/arm-asan/../../hw/arm/boot.c:656:15
>
> Indirect leak of 28 byte(s) in 2 object(s) allocated from:
>     #0 0x5bc58579ae23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qe=
mu/build/arm-asan/qemu-system-aarch64+0x2503e23) (BuildId: 2e27b63dc9ac45f5=
22ced40a17c2a60cc32f1d38)
>     #1 0x7b4ad6c8f947 in __vasprintf_internal libio/vasprintf.c:116:16
>     #2 0x7b4ad9080a52 in g_vasprintf (/lib/x86_64-linux-gnu/libglib-2.0.s=
o.0+0xb0a52) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #3 0x7b4ad90515e4 in g_strdup_vprintf (/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+0x815e4) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #4 0x7b4ad9051940 in g_strdup_printf (/lib/x86_64-linux-gnu/libglib-2=
.0.so.0+0x81940) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #5 0x5bc5885eb739 in object_get_canonical_path /mnt/nvmedisk/linaro/q=
emu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2123:19
>     #6 0x5bc58618dca8 in pc_dimm_md_fill_device_info /mnt/nvmedisk/linaro=
/qemu-from-laptop/qemu/build/arm-asan/../../hw/mem/pc-dimm.c:268:18
>     #7 0x5bc586182792 in qmp_memory_device_list /mnt/nvmedisk/linaro/qemu=
-from-laptop/qemu/build/arm-asan/../../hw/mem/memory-device.c:310:9
>
> This happens because we declared the MemoryDeviceInfoList *md_list
> with g_autofree, which will free the direct memory with g_free() but
> doesn't free all the other data structures referenced by it.  Instead
> what we want is to declare the pointer with g_autoptr(), which will
> automatically call the qapi_free_MemoryDeviceInfoList() cleanup
> function when the variable goes out of scope.
>
> Fixes: 36bc78aca83cfd ("hw/arm: add static NVDIMMs in device tree")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks,

>  hw/arm/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 1e57c4ab9ee..d0840308f5a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -549,7 +549,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>      unsigned int i;
>      hwaddr mem_base, mem_len;
>      char **node_path;
> -    g_autofree MemoryDeviceInfoList *md_list =3D NULL;
> +    g_autoptr(MemoryDeviceInfoList) md_list =3D NULL;
>      Error *err =3D NULL;
>
>      if (binfo->dtb_filename) {
> --
> 2.43.0
>

