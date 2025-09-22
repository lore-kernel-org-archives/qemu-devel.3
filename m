Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FCECAC5AC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0chX-0006Bc-8a; Mon, 22 Sep 2025 05:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0chT-0006AN-In
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:19:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0chO-0005MB-73
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:19:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso14535875e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758532738; x=1759137538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IN43j9K5l7VQJJTqnwrMALOwqocmjhkMZ+WpHBTrhY=;
 b=s01K+NORiKfYPTrbK07+6NMG+mr6kBu3TBV+Zeq35KkoEZ9K95jAq/HMypGfD7CfvE
 B+dO0T6QbBs6O3KSQdpeHL+xHx9AV7gFOCitlEHa0sfjRQkqcxqLPVdggSSHlNyJDje+
 VpgqoI2kMfNNiUVa0t71bzhsUgGeDcTnDssqMcyaIa39CIKt71vz0JArIlddZ9Rec9Ke
 GY8A2OcLS1G7URI0rzUYC8FIUGUIV9zMY+2+AfYUob668iNchooAQKPEurzx7OD0T34+
 RZHML4bkRVJJ1mS8jxhY0DEnDLwZMltPBl0OLvh5jiXOY/wMqhPt/JTIKu9VDxKhLYwu
 0nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758532738; x=1759137538;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9IN43j9K5l7VQJJTqnwrMALOwqocmjhkMZ+WpHBTrhY=;
 b=bAusKAr/1URcvtvedg3r3YPVSOKOJK6u1TgbP3qWgJ7gbroFMNzfuuh8n/EO2ci50d
 1nhBtUdgW2m+cflnAHYKnrNrmd6jZYXKUfwXyTv1ey7iNXhTQaellltjZIr9Q1LcspmJ
 +/uA/bwPPeMsmruQ16J/QXygitnaO6ghfdkdlfe4D+6xIWVjVhj59zzucLh5Hn5jbfkU
 c2vBSLSy62fpaZIZWBHfPDoofsXXeyGYXVPRZDlUjEwPSEPeJpInAhqwW55RfyryL/C2
 UcBtcLzHniiAzc4F/aQQeamvLlrutL+N3IjDKXApGjS+Zt8dQWN5rzfdVUb8DU3UqNC/
 gpIw==
X-Gm-Message-State: AOJu0YwVIq4QOEv1dX2QHvDdxKhJu3HV0i1LqbmPWxbmZiWqirHFsU/Y
 mBdMZSoqe5kCNc9JV+i5LlauieeWj7JtVd/yeH+gMhhEyl5JOEiPSrXcPtlDANgYJ+ZCVD0Wbg5
 789rAL1E=
X-Gm-Gg: ASbGncsQbNM9wpR6bwRfJwFDxeYK0wy9OdvmaFJgVrwqVoAHG9f4Bt6X2vsGK3NhbAV
 hS25xGnqxhD3hwrGsK2VpsjZTEOVizx4ljJUgruh0QSM31PDOSFdxt7KnCdNi0U8MLWtA3/CWKn
 9dIIJ/o4j354fPSdj/5jZ9rKLCJyQXLnpp3A/roKFqDV9UXVUDL4YeodxE8bYWp5j20Jx6GaaIK
 oaLCa9/LVFp3zK9hWpfpfmd4DXj4BgnSAvExPpyHfDZ82Hehq5CQwJgH6gzlRQcuyoCGzafE/K7
 dQmX2nmxYQlKcVCTybPcLk6WWAuWFFpLN1i9QJosKuQl5EenAzekNJ9jIGTmC+g/KNVH08zSh5N
 bpciPJESm7cQqhfTIkjL7gCo=
X-Google-Smtp-Source: AGHT+IErqLBc3fOQifrDKub8BZ+O8+mQSwDUj/wEoiA04pePJRGa3FJBVns2ZBco6lr7XSLBv+zfVg==
X-Received: by 2002:a05:600c:c4ac:b0:45c:b6b1:29a7 with SMTP id
 5b1f17b1804b1-467e78cab58mr131546155e9.16.1758532738189; 
 Mon, 22 Sep 2025 02:18:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-461391232e7sm231498915e9.6.2025.09.22.02.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:18:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8202E5F7B1;
 Mon, 22 Sep 2025 10:18:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/2] hw/pci-host/astro: Don't call
 pci_regsiter_root_bus() in init
In-Reply-To: <20250918114259.1802337-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 18 Sep 2025 12:42:59 +0100")
References: <20250918114259.1802337-1-peter.maydell@linaro.org>
 <20250918114259.1802337-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 10:18:56 +0100
Message-ID: <87ms6mq1z3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In the astro PCI host bridge device, we call pci_register_root_bus()
> in the device's instance_init. This is a problem for two reasons
>  * the PCI bridge is then available to the rest of the simulation
>    (e.g. via pci_qdev_find_device()), even though it hasn't
>    yet been realized
>  * we do not attempt to unregister in an instance_deinit,
>    which means that if you go through an instance_init -> deinit
>    lifecycle the freed memory for the host-bridge device is
>    left on the pci_host_bridges list
>
> ASAN reports the resulting use-after-free:
>
> =3D=3D1776584=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x51f00000cb00 at pc 0x5b2d460a89b5 bp 0x7ffef7617f50 sp 0x7ffef7617f48
> WRITE of size 8 at 0x51f00000cb00 thread T0
>     #0 0x5b2d460a89b4 in pci_host_bus_register /mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:608:5
>     #1 0x5b2d46093566 in pci_root_bus_internal_init /mnt/nvmedisk/linaro/=
qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:677:5
>     #2 0x5b2d460935e0 in pci_root_bus_new /mnt/nvmedisk/linaro/qemu-from-=
laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:706:5
>     #3 0x5b2d46093fe5 in pci_register_root_bus /mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:751:11
>     #4 0x5b2d46fe2335 in elroy_pcihost_init /mnt/nvmedisk/linaro/qemu-fro=
m-laptop/qemu/build/hppa-asan/../../hw/pci-host/astro.c:455:16
>
> 0x51f00000cb00 is located 1664 bytes inside of 3456-byte region [0x51f000=
00c480,0x51f00000d200)
> freed by thread T0 here:
>     #0 0x5b2d4582385a in free (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu=
/build/hppa-asan/qemu-system-hppa+0x17ad85a) (BuildId: 692b49eedc6fb0ef618b=
bb6784a09311b3b7f1e8)
>     #1 0x5b2d47160723 in object_finalize /mnt/nvmedisk/linaro/qemu-from-l=
aptop/qemu/build/hppa-asan/../../qom/object.c:734:9
>     #2 0x5b2d471589db in object_unref /mnt/nvmedisk/linaro/qemu-from-lapt=
op/qemu/build/hppa-asan/../../qom/object.c:1232:9
>     #3 0x5b2d477d373c in qmp_device_list_properties /mnt/nvmedisk/linaro/=
qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:237:5
>
> previously allocated by thread T0 here:
>     #0 0x5b2d45823af3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qe=
mu/build/hppa-asan/qemu-system-hppa+0x17adaf3) (BuildId: 692b49eedc6fb0ef61=
8bbb6784a09311b3b7f1e8)
>     #1 0x79728fa08b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5b2d471595fc in object_new_with_type /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/hppa-asan/../../qom/object.c:767:15
>     #3 0x5b2d47159409 in object_new_with_class /mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/hppa-asan/../../qom/object.c:782:12
>     #4 0x5b2d477d29a5 in qmp_device_list_properties /mnt/nvmedisk/linaro/=
qemu-from-laptop/qemu/build/hppa-asan/../../qom/qom-qmp-cmds.c:206:11
>
> Cc: qemu-stable@nongnu.org
> Fixes: e029bb00a79be ("hw/pci-host: Add Astro system bus adapter found on=
 PA-RISC machines")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3118
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

with the typo fix:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

