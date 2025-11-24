Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAFCCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 13:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNWkN-0002WI-JU; Mon, 24 Nov 2025 08:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNWkL-0002Vs-ED
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:36:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNWkJ-0001By-0c
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:36:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47755de027eso22728075e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 05:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763991405; x=1764596205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4xz24Wztw7HTdPYy7ecg89+rhyVWxJPlTjrMGFkQrQ=;
 b=VVPOR9XrwA8NdL6RhZYf1lVrVbmd2FJ+cjg1xZERMfjlXADk+VtukmLgg9D2u6vpWA
 9qa/cQntSZp/Qy2q6C9KNCpOTK/pe/Vr/50TqKcTgbvozLiEwEQqGXJaenckqitlf2tH
 OjdWxHxdjfxgj3Oy4R/YAkMR8g3sZbkwNp5/osWHCZNYuRJhg+qtBwyGKfitYvZ1bPLg
 nmv0N52b63c6LfRFORfWrB4j+LtOX0Owb7NoESMYIMg+xHvLbYcb6pfFFE+cn/3MHcZK
 0iGOcgl2lMnQw6EaZSJd2GsuUCjjvgHoFpR5vX3heSBU/J6Xy2FL6AHlfGZj16ILdiv6
 pSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763991405; x=1764596205;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4xz24Wztw7HTdPYy7ecg89+rhyVWxJPlTjrMGFkQrQ=;
 b=D5WJ8fWDb+7kelOQRCzcNRFd+dg5tvtaCb/yspX8ykG+hSWdfVfk8OVIt6KC2i+aii
 2nO9YFSEsVNUNO6e22nxkVpq0oCHJD7S8382toppZkUu6sS1z9mG8n6SpW5gKUEB4g2q
 7UbhwU4ERmXSyHGJgsAAde5kkfzrXLyjUL7SXafL1eqblK+hAS4QAeHlS5WPIt0VTMbK
 mmNKOcw7vOcbNQ3yvF3MmhTgsKODGr777Qux4xvZYoCvOEoSiNstX4XVvnaGYtk51X/W
 bKXFg5uwCeKpoIf/3LqXB2MlfiqWNqJysmZuZF5ubVS0CQE+tc7kfetNuxn/6OxpwaCn
 ZciA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkKlNxhRNnHPOR3FVr2hjOrFlTxJqYAxbFWoUlasFWD5LWfkwjQ/PBsWXJshg952JRlpkLom/lCgp1@nongnu.org
X-Gm-Message-State: AOJu0YwxjAJx3Uemv5VfA4WJrA/s7pHv2ZqaKBMeox/cLf7gpr+LotGC
 7a+3Upo1ncPxF7c+ff2iCbPqjG8h4vuCuvDjOb2gK842AzHUbbKfPokNW52LpnAjVsc=
X-Gm-Gg: ASbGncst7ZNY86imEV+2DFu+BNex0mLbPKYw74iC3ctkjm9dsfAvcX+UxRr3tMa7Da7
 WKWs8HkFR1aA+fuhWnUx6nY/q0kY0Q0fDufC5dp3kogx5ljbsu1386UxAO1r4QsO5zAlHn1smsC
 RngnhVgA8k9PwdiQVOPxDgKmX5jyNifgFn41bQZmfiwq5wV+63M2X8j1qtBXcFozDqGRFeqHepl
 3o/QT+SKr5yKm6ysAAJint06sQ3HKd0lQMz19O+4YqzAfB2BkAYRZ7g84SWs5M6gudF06ZW9EAO
 rPXGmdm+MZQj7Hd0eZR1ShxTPtictf+QYA0WnWzgbFB3GM2ixoDEVyGDlA0v2EjWW1GZUDPylYH
 LvH7AWuHSZaygCAbE4XdWI5ySwFL2osdpb7ZbG5rP0cwpkmWao7VnbMQwatHqVU7N1ughUZFsbC
 sfUTYWCAuJ8rk=
X-Google-Smtp-Source: AGHT+IF0dJ+uMYoGxGrKESeuk5j4XBM/pzNa5EuAcMp8he8Y2t4N1T0BAg/Un3bNs5VkrlausSw3DQ==
X-Received: by 2002:a05:600c:4694:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-477c016bbf6mr110840675e9.5.1763991405177; 
 Mon, 24 Nov 2025 05:36:45 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de4631sm150284365e9.7.2025.11.24.05.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 05:36:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B54585F83A;
 Mon, 24 Nov 2025 13:36:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,  qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  David Woodhouse
 <dwmw2@infradead.org>,  Paul Durrant <paul@xen.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  xen-devel@lists.xenproject.org,  Anthony PERARD
 <anthony@xenproject.org>,  Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/i386/isapc: Remove dead Xen code
In-Reply-To: <39f5f781-398b-4974-8b1e-e7061ed9194f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 24 Nov 2025 12:07:08
 +0100")
References: <20251123185832.53802-1-philmd@linaro.org>
 <066cb998-e89a-4cd1-a89b-865f4a6dcbbd@nutanix.com>
 <39f5f781-398b-4974-8b1e-e7061ed9194f@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 24 Nov 2025 13:36:42 +0000
Message-ID: <87wm3f8sd1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 24/11/25 11:27, Mark Cave-Ayland wrote:
>> On 23/11/2025 18:58, Philippe Mathieu-Daud=C3=A9 wrote:
>>=20
>>> We don't use Xen on the isapc machine: let's remove
>>> pointless code.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>> =C2=A0 hw/i386/isapc.c | 27 ++++-----------------------
>>> =C2=A0 1 file changed, 4 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>>> index 1ba9ae22cc3..1e13a30c505 100644
>>> --- a/hw/i386/isapc.c
>>> +++ b/hw/i386/isapc.c
>>> @@ -17,8 +17,6 @@
>>> =C2=A0 #include "hw/ide/ide-bus.h"
>>> =C2=A0 #include "system/kvm.h"
>>> =C2=A0 #include "hw/i386/kvm/clock.h"
>>> -#include "hw/xen/xen-x86.h"
>>> -#include "system/xen.h"
>>> =C2=A0 #include "hw/rtc/mc146818rtc.h"
>>> =C2=A0 #include "target/i386/cpu.h"
>>> @@ -37,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ISABus *isa_bus;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t irq;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSIState *gsi_state;
>>> -=C2=A0=C2=A0=C2=A0 MemoryRegion *ram_memory;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS=
];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>> @@ -77,15 +74,9 @@ static void pc_init_isa(MachineState *machine)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There is no RAM split for the is=
apc machine
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 if (xen_enabled()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xen_hvm_init_pc(pcms, &ram_=
memory);
>>> -=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ram_memory =3D machine->ram;
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcms->max_ram_below_4g =3D =
3.5 * GiB;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86ms->above_4g_mem_size =
=3D 0;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86ms->below_4g_mem_size =
=3D machine->ram_size;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 pcms->max_ram_below_4g =3D 3.5 * GiB;
>>> +=C2=A0=C2=A0=C2=A0 x86ms->above_4g_mem_size =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 x86ms->below_4g_mem_size =3D machine->ram_size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_cpus_init(x86ms, pcmc->default_cpu_v=
ersion);
>>> @@ -94,17 +85,7 @@ static void pc_init_isa(MachineState *machine)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* allocate ram and load rom/bios */
>>> -=C2=A0=C2=A0=C2=A0 if (!xen_enabled()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_memory_init(pcms, system=
_memory, system_memory, 0);
>>> -=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(machine->ram_size =
=3D=3D x86ms->below_4g_mem_size +
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86ms->a=
bove_4g_mem_size);
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (machine->kernel_filenam=
e !=3D NULL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
For xen HVM direct kernel boot, load linux here */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xen=
_load_linux(pcms);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 pc_memory_init(pcms, system_memory, system_memory, =
0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gsi_state =3D pc_gsi_create(&x86ms->gsi,=
 false);
>> FWIW I did contact upstream about this (see https://patchew.org/
>> QEMU/20250618112828.235087-1-
>> mark.caveayland@nutanix.com/20250618112828.235087-13-
>> mark.caveayland@nutanix.com/#91b96b24-af60-4a89-91ec-
>> d0e660a76a0a@nutanix.com) and they mentioned that it should work,
>> which is why I left it in.
>> Unfortunately I don't currently have any way to test it here :/
>
> OK :| IMHO upstream Xen maintainers should provide us a test, otherwise
> we can not make our code base evolve.

Ok how about this:

  As of the xen commit 9e8672f1c36 (tools: remove xend and associated
  python modules) there is no longer the ability to emulate an ISA only
  system. As a result we can drop the code in isapc. We still need to
  support the ISA bus for the -m pc type as Xen doesn't support the q35
  machine model for HVM.

I think the actual support got removed earlier but this was when the
last bits of "Simulate an ISA only system" where removed in 2013.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

