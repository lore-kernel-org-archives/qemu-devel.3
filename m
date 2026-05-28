Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE2CD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 06:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTyP-00046m-US; Thu, 28 May 2026 02:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTyL-00045I-FO
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:12:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTyJ-0004VR-Qp
 for qemu-devel@nongnu.org; Thu, 28 May 2026 02:12:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ed18d8a1bso1920226f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 23:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779948718; cv=none;
 d=google.com; s=arc-20240605;
 b=d/ONwCV2toVdAucTmPLqCKDUkHfWUm6jo5rXOvZowZyrCn7XjwsQ5LzkYyMGS3Eviz
 zcfyOQnKQtnEIv+Pcu/kZa5xs2Axv/ufo+ErVKR3nPa/CHeqn8WWLviraV8hclB63KXA
 ezCL5Bwp3beh+Cz5ujnc5Ox6qPEREY5VhcjUi21v12oT/PzrGrnI9L6wbOuXRqOmhkve
 zCib5gEMakxvhBzsF6AYhM3SAcJLdp3OOwXB/KW6IegPC6JdKxV+WXGpXkfc/2fsKtVM
 z7jhXUEe3GQPbGtmkcNOWIo5mSL8yihlVh9TgTBRFsEqbIKQJL3AWEldZPcRvP5YTprf
 cX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nWJR1mFWqJeDyXtxshoXxGQrOxpYQAsGxvjy+YZyY0k=;
 fh=XBvXNygMbloJp+VR+lP4ESgdVtRHCxc7UtbU1PDcF3s=;
 b=MbmTIN1nA3evtYajhuhmMJW7MEC0+9T8Mf5EzXAm6YZhQ6kM1tf5AXvSA5XFbi5RxU
 ghzrmkWqoGpsf8KUVkay+mHWvw3ooJbLkIBOpTK6ZozPqLRMorCxbCEhiymXr66K3Xr0
 PcBDc/O00yre2CMtsgaenBVmgVVx7ps2y/gKK6ANcOyzHnZAyvhERaAwNRTBVvSL7EFX
 vwxsadYAofS8YT83qJk0TwgFeDcON2DyM2lRl1E/e0XyPHnabDJv6P0P/O+DX8miZKG1
 8P1w2zqOvcA2PlzMTp2brXm1R0tfMzuAFBnkyU4/wYHk1biOqzY+NChMGv00Fc8dO+It
 P8SA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779948718; x=1780553518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWJR1mFWqJeDyXtxshoXxGQrOxpYQAsGxvjy+YZyY0k=;
 b=VI6ubiH4psojojHraq3UAjB6GRyawDeVrNQl5PnJgxe8jwbyT5sUFrQ0iL/xShhx4S
 W9HTFUCUW4JnsBDLo3qJGztJDgMCzevMtotuBtGUEUjb7/eizmthE6Re3tCdhb534MyM
 Ua3Jy3ZzwHzn7FKRZQffc2j2UBx0GBrQqJcrVzN8RU0O/EXGn+CPTSLpwYG9bXZcqAR3
 RGB2wElPiLNwpbZlXW7mhe6KzdcHxEdIQTs3HG4giVnp8Dpg260bTwGtFNeM48mtflvy
 6luV0sk043QcqUQ4uZYlQu5fC/5VuWADDcE3MZXegBxbZWJbVQB+NZ5MtxWIDDXnnw1T
 Ktxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779948718; x=1780553518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nWJR1mFWqJeDyXtxshoXxGQrOxpYQAsGxvjy+YZyY0k=;
 b=gzZZUVK/BhowA4qWxwdARAe2mgXIn7OOkESX555Fg8nYjvLOBk5+kL0ZvTHQVd8YDP
 MsSTNPDm6Es5to1OqQ+1NAW0jR46HeGm2NoiUYEKFxwU03m66l0URcS3BtfZnMUinXot
 w7vO4EKLCYiFQm9BCUKPAIou7EE1JU43OxSLFcqhf9BPUS8xEOCpaFQQ+S098lPIsKpL
 WGjYXS4g+MzIh/mBIyvr54TqA4gDoERemBlIxDhffi0cL9kkHG+8mqjS9Hwum3kSKCUM
 Xc5n//lf1DYXF316nD9PKdjAnsBovdq8tDWBJPdPJLRe2O6LkNTOoNMo/mNnx7wR0Agw
 xV1A==
X-Gm-Message-State: AOJu0YziabPxbd07ODstB6Jc7uJI/B7/ACiNN3Z/DFKDk6i3XPKpwFWm
 51Tk5gScxp0DBmAKQ+5BKdtfcPbgkx+2bDX69OcwRMhqEhiPmSdvaBTy8PPsNnNsOpUD49bppei
 XinQv6mFUS1LE2BgCb76zA+jJCC2bsjl6+Ee4O2Pogg==
X-Gm-Gg: Acq92OFOWty8aoBpYmAUnEOEP1VhgXGZwzkfeHmjXN0r2ZWQZHox7GPTHAYzrr/DPH5
 8cdckh/rxjsprmV9H961MOcKCohrOgaGPIMHm4lMMhIGBfXO00XQI+EiZIaWD8WTQOUWwkOAfU7
 SmBlD3E7dXMg8KQ34B10j/2YX+uzkFHzl/UMkGF5UjnHxdHDhUZJIg3sw0fKsRzwqd0UTKlQOe4
 guY7r2BhgYC1h4AHieF5Iyax18lSTMGYyHCattLxojDJkXpJg9RRQWnmBSw9H3lCNvj4P4IufAw
 v/fIZEjPpvRoNYcE/b9yseoLW+nif/Agmp0T1SjZBBbvxhRmYSig2HxLo8ZB
X-Received: by 2002:a05:6000:610:b0:45e:739e:499 with SMTP id
 ffacd0b85a97d-45eb3690838mr47401039f8f.13.1779948718329; Wed, 27 May 2026
 23:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260528051642.115721-2-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 May 2026 09:11:32 +0300
X-Gm-Features: AVHnY4IicJF0awCuwWI625F07b2UbZojXl-1f5k2gfheLZgVQwHOzrRbzB4BIVE
Message-ID: <CAAjaMXZdNBV=4ECRQz74MgKZE_WSBDrCZz-ZTQ6SynFW_ZtabA@mail.gmail.com>
Subject: Re: [PATCH 01/10] target/arm/meson: move kvm-stub to arm_stubs_ss
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>, 
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

On Thu, May 28, 2026 at 8:19=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> This eliminates symbol conflicts for kvm symbols on linux-aarch64 host.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/meson.build | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 9408131d178..4412fde065f 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -35,7 +35,10 @@ arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('=
hyp_gdbstub.c', 'kvm.c'))
>  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>
>  arm_user_ss.add(files('cpu.c'))
> -arm_stubs_ss.add(files('cpu32-stubs.c'))
> +arm_stubs_ss.add(files(
> +  'cpu32-stubs.c',
> +  'kvm-stub.c'
> +))
>  arm_user_ss.add(files(
>    'el2-stubs.c',
>    'cpregs-omap-stub.c',
> @@ -44,7 +47,6 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTIN=
G',
>                         if_true: files('common-semi-target.c'))
>
>  arm_common_system_ss.add(files('cpu.c'))
> -arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c=
'))
>  arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
>                                  if_true: files('common-semi-target.c'))
>  arm_common_system_ss.add(files(
> --
> 2.47.3
>
>

