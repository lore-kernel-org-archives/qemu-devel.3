Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7437FC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 10:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ecq-0000rK-Hf; Fri, 04 Apr 2025 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0eco-0000nC-W6
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0ecm-0007jn-1O
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743763811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ys1LfRF5ONz/v75SJU9//rf+2uXauDMfR0ipKMSR4Q=;
 b=QGpDaoWpX/yMlZVVOJiKVbCAaCNwKV8n6KR178oRelEDYB20532cp3G81lH44r2C2RzJpc
 oKqdRfN0N8T5rFp5HvEWTFSU5DdpKtGsVgLdT2GJgQB5cAvtvhXE9dK3XkWGIDd0zYxSTl
 l6L0XPm1P7urJqmQXGuPlF+oDirtVdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-2WnfeBviOW2x1_6c1DRjyA-1; Fri, 04 Apr 2025 06:50:05 -0400
X-MC-Unique: 2WnfeBviOW2x1_6c1DRjyA-1
X-Mimecast-MFC-AGG-ID: 2WnfeBviOW2x1_6c1DRjyA_1743763804
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so10947995e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 03:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743763804; x=1744368604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ys1LfRF5ONz/v75SJU9//rf+2uXauDMfR0ipKMSR4Q=;
 b=QEopM34RrYz+G0zj1otxRr+/2ISJdTUQe8qYW9FHByUvA6sAvZ8cNc9xAsXfbUGeQG
 ByNjcR3gXLD+F5kiDc7lfcckAl4XzYGf2LCk/DvDqSyI5cjxgLW+DdfOTOIv9pLXMOr1
 Q8gUwwOiM3Y9AaXznjh6sjNKjs3WbuAJuleSJeQl8CSgmt4spK0PuUUbnyJdsvflk6Co
 9IRw5v8L0+hu0keOT4X2VimVVXIa6ljxbA3F2lRk2Ils/pCwS6EGxfA1r9x2hYboRBbp
 vrdRVgPUH4gefup4UvTx+tNe/rNRt8nWmoOGgewyKKwG/QcE/uR/GjefSY+tcLYJZHdZ
 3iWA==
X-Gm-Message-State: AOJu0YyGgVnyn4D3sQACk2+i0gjaAnmWu0KpSWPvhZqvGGt5g07gZdrw
 okhvq6m/pOGE+exgFw5mWu4zB/eyyA/kvgIm7ir9tLeGoWKLLIyYPe9cLrwF9m65qjRemhGXQ3k
 6jfu+LVYd+hy7tR7iRRO1jH3tTgtuA5sgwqIIXVOjI3+LXHfOWVDE
X-Gm-Gg: ASbGncv59XqlqbyUYQixSNt1cqd/D29BN/39t9M+Kd0U2KN9qvECUt1+4XWoDphOEei
 Igqv3CTPqNZsFBjor6VHk+gnf+2m868ts6trmPzd7COzhnfZ5HiIhOzYPFGBcTzsReVvVgeRaPj
 lTrr+4AEkA+tyYtesbRR1JNKvQkHEisT1HgDW+aqknyqDiTZUavdZ0Jz6DQKnKrdYaVQCNQN5B3
 An+ZvC3kbRCJy5l73qy/22ZlFGfLVCRyeysU140aiEBfSyWOFQeSfOuaPSoswrCrg03qgJ91Qh6
 2p2OEq5w/3WhkWUdRW5jeWHkiGlvVmufHiwu
X-Received: by 2002:a05:600c:1c92:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43ecfa05104mr20018105e9.29.1743763803844; 
 Fri, 04 Apr 2025 03:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8c1gSZK5uXPhy1i1KFPGP4Z8o/SCkxxohB9rPjROBJ2ulm1ZNhQ6tdpz2mEIj9xD3Uh4K+Q==
X-Received: by 2002:a05:600c:1c92:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-43ecfa05104mr20017795e9.29.1743763803450; 
 Fri, 04 Apr 2025 03:50:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a7615sm42303545e9.9.2025.04.04.03.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 03:50:02 -0700 (PDT)
Date: Fri, 4 Apr 2025 12:50:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>, Udo
 Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH-for-10.0? v2 11/14] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
Message-ID: <20250404125001.66c6eb61@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250403151829.44858-12-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-12-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  3 Apr 2025 17:18:26 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
> test. In preparation, copy the ACPI tables which will be
> altered as 'its_off' variants, and whitelist them.
>=20
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
>  tests/qtest/bios-tables-test.c              |   1 +
>  tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
>  tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
>  5 files changed, 4 insertions(+)
>  create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8bf..3421dd5adf3 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,4 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> +"tests/data/acpi/aarch64/virt/FACP.its_off",
> +"tests/data/acpi/aarch64/virt/IORT.its_off",

1) separate patch for this please=20

> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index baaf199e01c..55366bf4956 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2151,6 +2151,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
>      test_data data =3D {
>          .machine =3D "virt",
>          .arch =3D "aarch64",
> +        .variant =3D ".its_off",
>          .tcg_only =3D true,
>          .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
ditto

and the same for blobs below as well (commit message for those shall
contain relevant diff for changes or explain why there is none).
blobs update seems to be a bit confusing at this point (aka unexpected).

looking at this patch, I'd make a copy 1st, then '.variant =3D ".its_off",'=
 patch
and only then whitelist right before patches that would actually change
tables.

> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/=
aarch64/virt/APIC.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73=
eb7cb9100fcccfa
> GIT binary patch
> literal 184
> zcmZ<^@O0k6z`($=3D+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
> bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/acpi/=
aarch64/virt/FACP.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3=
a4127eeef227434
> GIT binary patch
> literal 276
> zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ =20
> CVg~^L
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/=
aarch64/virt/IORT.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf=
568a8e93e426738
> GIT binary patch
> literal 236
> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=3DRgMkDCNC*yK9F_<M77!bR
> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@ =20
> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
>=20
> literal 0
> HcmV?d00001
>=20


