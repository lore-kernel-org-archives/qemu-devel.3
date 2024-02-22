Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B3C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8PK-0005o4-VI; Thu, 22 Feb 2024 07:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8PJ-0005nu-VC
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:42:34 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8PI-0002wr-33
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:42:33 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so2482469a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708605750; x=1709210550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlwaMRPuFF+oM4wPgCtefWbSlwv7w5mW4wwJDImByFc=;
 b=Ut2tF1poJqttGYG3MEmMV14M01frQRkhQTY+EHrh7KgNLwBDJZTT1dDyeDX8coVZ/T
 yfCsjjw4Z+oDfAL8M+zUljrd8yesz4IT4oZIGMaxcRu9wFqVmJQ1PumBKx9FWj9qkSiz
 tQkfSHEmxAmrkrmEh6pnpNUGwmlql8nNW4sOPvjbsif4tNSytQObd62Eq0hIfZA7dLs5
 6c58ZnHLjcM4OZk8LKfWAXDk0AR29onrLirPjXa6oBWLmFTYBhTu+f3TXRXSEDMRBLGM
 i+vyU9MSR0B8tK6BjDrw5JaVK+3cgcCZqm8Ao3Sb7C55QfOz4k2HtceBLEAaKIGTSe4k
 IO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708605750; x=1709210550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlwaMRPuFF+oM4wPgCtefWbSlwv7w5mW4wwJDImByFc=;
 b=UuoZT7B1+BA6GIkjLWQo2kCE3BMwFi4p8sx3Yao0BLBFC9H5HVOXNo142E88pVMsoC
 gGf5uTVBXeoKfeK9tRUlYeqJRm6yysml4G9L9MEk/3ZJ3q/a7lxt98GfgfFcgPLRSjsL
 8BI9iLA2+UzjvtttwgOUWn8PAWYvQ9aFYiIG6HGR6Q/JlNyRQJyJJNhEG0ppIJtwt8gj
 WLqSogzTgP+NM3XuqnySVg2nA/IgE4Box7Cw5RxF2ruWXlZWsF1gPb2w+tguoxRq08Cu
 WtucW1/B7cl492BJQ09q5y8SV88iJ/BlBJmO2lC0LNY2Pa9McafwZprpR/49IC15+3Jt
 j1pA==
X-Gm-Message-State: AOJu0YyywZkMHy58W1+opKDc5DaheQwAQ1Yv+d+hDnlb3OP4CWjhAhot
 fCpb3W87SwiUIeEDWDM1si5wcYWyikUA0m+z5zt4sGQcdXD+bk+aQXH7g554HbHWC1fxiK9jNp0
 s547TIdvcXLjXa13ambdcfdsLnCxhh6EdFmyALtOKRvzKVxDf
X-Google-Smtp-Source: AGHT+IGrpTG0Wnssde1lv9LErlcFctcjC57weezlh6GZn8Mbom3m2gSuV+mMVCmiRrK7Fm1t6tbOZodKhTJG2j33wuQ=
X-Received: by 2002:aa7:df87:0:b0:565:2183:d28e with SMTP id
 b7-20020aa7df87000000b005652183d28emr1814383edy.42.1708605750454; Thu, 22 Feb
 2024 04:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20240221091154.3024118-1-gaosong@loongson.cn>
In-Reply-To: <20240221091154.3024118-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 12:42:19 +0000
Message-ID: <CAFEAcA8zR0dKQYbVNTbF8cwwvKUt+eJc7v3mSm58cMissO6GZg@mail.gmail.com>
Subject: Re: [PULL 0/1] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 21 Feb 2024 at 09:11, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83=
d0:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stagin=
g (2024-02-20 10:11:08 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240221
>
> for you to fetch changes up to be57fd1e526e70fd55f1e87b0b70fab3c6baf089:
>
>   loongarch: Change the UEFI loading mode to loongarch (2024-02-21 17:06:=
23 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240221
>
> ----------------------------------------------------------------
> Xianglai Li (1):
>       loongarch: Change the UEFI loading mode to loongarch

Hi; this fails to build for mipsel:
https://gitlab.com/qemu-project/qemu/-/jobs/6232698129

../hw/loongarch/acpi-build.c: In function =E2=80=98build_flash_aml=E2=80=99=
:
../hw/loongarch/acpi-build.c:327:19: error: incompatible types when
assigning to type =E2=80=98hwaddr=E2=80=99 {aka =E2=80=98long long unsigned=
 int=E2=80=99} from type
=E2=80=98Int128=E2=80=99
327 | flash0_size =3D flash_mem->size;
| ^~~~~~~~~
../hw/loongarch/acpi-build.c:331:19: error: incompatible types when
assigning to type =E2=80=98hwaddr=E2=80=99 {aka =E2=80=98long long unsigned=
 int=E2=80=99} from type
=E2=80=98Int128=E2=80=99
331 | flash1_size =3D flash_mem->size;
| ^~~~~~~~~


../hw/loongarch/virt.c: In function =E2=80=98fdt_add_flash_node=E2=80=99:
../hw/loongarch/virt.c:131:19: error: incompatible types when
assigning to type =E2=80=98hwaddr=E2=80=99 {aka =E2=80=98long long unsigned=
 int=E2=80=99} from type
=E2=80=98Int128=E2=80=99
131 | flash0_size =3D flash_mem->size;
| ^~~~~~~~~
../hw/loongarch/virt.c:135:19: error: incompatible types when
assigning to type =E2=80=98hwaddr=E2=80=99 {aka =E2=80=98long long unsigned=
 int=E2=80=99} from type
=E2=80=98Int128=E2=80=99
135 | flash1_size =3D flash_mem->size;
| ^~~~~~~~~


The value you get back from pflash_cfi01_get_memory() is a
MemoryRegion -- this should be an opaque struct to you, not
something you can reach in and get the 'size' field from.
(The 'size' field is an Int128, which is not necessarily an
integer type known to the compiler -- on some platforms it is
a struct -- which is why this doesn't compile here.)

Your board code created these memory regions so typically it
should already know how big they are.  If you really
do need to get the size of a MemoryRegion, the function
to use is memory_region_size().

thanks
-- PMM

