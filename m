Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C79D13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkYxE-0004p6-1i; Mon, 26 Jan 2026 21:37:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkYx8-0004mb-1A
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 21:37:14 -0500
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkYx4-0001RI-V2
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 21:37:13 -0500
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-1233702afd3so6911422c88.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 18:37:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769481427; cv=none;
 d=google.com; s=arc-20240605;
 b=Qj0+M003hDEcLdtIpdF3DAz/atcbnERbMwHdJ759t+bgnm4ebQf4x8uMEBdcdRQH1X
 HtuRo/7iLSArLdn7efN5f68waMay1ZkcRBpLZ41l1r/DQDLBglDFZZGnCrkEydeYzCwB
 h9wqeD4DcyjGRXB2QQo7hDHDeug8FsNNV2QKoEH9tfIjXztxU/lQg8iK9GIzilcyJEsf
 uH7OyGKMTTXPaSS0nMlOE6UbgXs/rd7xNucnx/XBc0Ut1Lu97LmVl29MSULNYE0fvQgw
 p+rS9rmx1Ftsnf3dOeVNzNsrUoR6c9kKj6LqQGs6o7/SFgK4E68BVMrcxvF+c0Fy+TUY
 GOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u67F4Kn5QxHMSdtqm0A4ShGfMSUUdj/w6/KQsvswZN8=;
 fh=8xCNHXiA+ilHFSGRbtuEeBZTmbC3/Kfq2a4UhLZ5wDM=;
 b=Hb4mEUMNG5ycs2YV5SRGx9tRTItpCHuaBA0wcStk52+BYr+Kavw6klq2QQbWD86ewS
 QuA9VB11qdBNbHhcS+KtwhUUIy5TFDpNHCFZh0edzxA1g9ammctY1DQ8fH2nmq4C4nO7
 DvutsNnnOfWWY4aMTp69EGTn+CWxbGDpT7NtsLnR6SChJYq15yn5763zt2SfV9lDKBxM
 sa3i+yh2ofPnF1K+6AaratQnUPz1Oju7TSkeseZ6bVzrE2/Hxr1Gb9yg92yrcNV2xk8E
 ejfk9j9e95Cw5eT7ZEylW9sCwgZu7i5nYPj9Q6Q+WDpPHmGj4n9/7RMhFe3h7bS6+hWJ
 F5kA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769481427; x=1770086227; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u67F4Kn5QxHMSdtqm0A4ShGfMSUUdj/w6/KQsvswZN8=;
 b=m2PSuBhjLt/5Vs/axE49Z1f9Zvldz47aVLz4qZ00XMlqkPertqURPcPVhDNcTQEd+s
 5bR7GUaU6oAjjCQvnt6ZTpW3g84xCGOFkYVs5Ux2ohu5Yna32kSkssdhTEdL+/xElEVG
 cfmYVmpvcUNCkffMoPgY0yrRioQRJPzvZuFmRkSCTeTsYXaCfC9V2IR5f7SoQ2FBeIN5
 S7UYLXeKup56f+tUcBzGekWYKQDJQufQA+shQPBg1mULo5ZALM/1/fPKJ+kJNlF14Bnl
 I38j6t40vm8H6HO6ZThj1ZkoGJWvs0CNu0Po2tCWoCAY5RVUraGo1/n3bByzZ73O877i
 AxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769481427; x=1770086227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u67F4Kn5QxHMSdtqm0A4ShGfMSUUdj/w6/KQsvswZN8=;
 b=Fd2qo4+IOvUK6nqR/hcPgbsHSScV+E0UmFrSpWWzJKAili8fhb48Q55s7ZQmENNnft
 7G7N5ELlcU+Vt+MzsBYmbomSTANplO97oYmhIzLmu6AONl0dvw1c7MCtklRfStPa4muq
 nliUMOuCdHcHbGjPKRzziSYrlFru3+mlJlZo2yF1BRT/yiGiLUb3L1i5NMQq4jzwF9kW
 SQ7rNAV/SWtfgMMlP+FOMvlgxZ1HPtbnXaUHbm8tFTBLRWIa/xswItOze41kxvPTJ1Wt
 426Ck9BsbBW5m+GKrvgLEDi4B2d4KEp9VUU/rzkGk134S6Jx7x9b6TZOS8GnePJbsCXu
 t/Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIA0lfqdzxvRVlMLufeX47DLDC5WzTYrtuanK7oor7PVjjaKrKutf0UYPf5rwMtoUdFv1/oDQTQp7i@nongnu.org
X-Gm-Message-State: AOJu0YxYdUnnZMH2aZrKRShgptf38IGYAu7D8t2m3tbymf1uvYE2PBCY
 YdFOR9xJ5qDnx17nIjDTBFi9JGGi0R0f9jUIKvm6p337heRKktcjFZEJ9VU8RPElJ7FWaZ9MPxE
 JIsd50Ce+u7phEEkjKwzZ3p34RLR2CYM=
X-Gm-Gg: AZuq6aKn3XscSVVFAr4Adr4yn7zlVHItQQRtAgAc02qvQMpm7liUbjv8wRn2Taa9VfQ
 IUkq6haPjVoczEul7J0PEGXUFmLWfM/UYR8RIk0KBT9rFzUYGe2LabbN4VyvGRiKjS1EXqk+5jC
 hn5Q47hLr4Tvvh1hIBHXp7fMt2n8nF5I0lRX9jlZY1l6hvbUYlTlyxCwMMBlQviz+sTlskVmbpq
 wYKPSYqnRC6t7cgMb03asfKkRU1jmtrWtLdLt3FD8vLdxCX+2WIlN7S/g69lWzWs4DEi83aJKFH
 8HUOgPCYydY8xb7SK34yb9imRA==
X-Received: by 2002:a05:7022:128c:b0:11b:9e5e:1a66 with SMTP id
 a92af1059eb24-124a00993bcmr141137c88.14.1769481427418; Mon, 26 Jan 2026
 18:37:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
 <2af460d17a47ec69d691dfb876f834e4685f9d6d.1769407033.git.ktokunaga.mail@gmail.com>
 <6dce5ad6-e88b-433c-8eef-98dbe72acbbd@linaro.org>
In-Reply-To: <6dce5ad6-e88b-433c-8eef-98dbe72acbbd@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 27 Jan 2026 11:36:55 +0900
X-Gm-Features: AZwV_QhHJEGZmFJKMZT_p834jgO-uKjR83sRYkMiNigsB_dZdwm-HpImEqqJ3eY
Message-ID: <CAEDrbUZhz8hLQJ=Cvpj9MAy0f+bLqOk8wonHHLMaYEKEQAAFYA@mail.gmail.com>
Subject: Re: [PATCH v4 32/33] scripts: Add a script to run the wasm-compiled
 QEMU on node.js
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eb03cc0649557f0e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000eb03cc0649557f0e
Content-Type: text/plain; charset="UTF-8"

Hi Pierrick,

> I followed the instructions but could not get this running:
>
> $ /usr/share/emscripten/tools/file_packager.py qemu-system-aarch64.data
> --preload pack/ > load.js
> $ ~/node-v24.13.0-linux-x64/bin/node ./scripts/run-emscripten.mjs
> --preload ./load.js ./qemu-system-aarch64.js -- -nographic -m 512M -L pack
> file:///home/user/.work/qemu/scripts/run-emscripten.mjs:51
> if (preloadModule) preloadModule.default(Module);
>                                          ^
> TypeError: preloadModule.default is not a function
>      at file:///home/user/.work/qemu/scripts/run-emscripten.mjs:51:41
> Node.js v24.13.0

Thank you for trying the script.

That script requires the --export-es6 flag to file_packager.py. This flag
was introduced in Emscripten 4.0.13 so please update the Emscripten tools if
it is not available. If you're using emsdk, it provides the way to intall
newer tools, such as "emsdk update" and "emsdk install 4.0.23" [1].

[1] https://emscripten.org/docs/tools_reference/emsdk.html#how-to-guides

Regards,
Kohei Tokunaga

--000000000000eb03cc0649557f0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Pierrick,<br><br>&gt; I followed the i=
nstructions but could not get this running:<br>&gt; <br>&gt; $ /usr/share/e=
mscripten/tools/file_packager.py qemu-system-aarch64.data<br>&gt; --preload=
 pack/ &gt; load.js<br>&gt; $ ~/node-v24.13.0-linux-x64/bin/node ./scripts/=
run-emscripten.mjs<br>&gt; --preload ./load.js ./qemu-system-aarch64.js -- =
-nographic -m 512M -L pack<br>&gt; file:///home/user/.work/qemu/scripts/run=
-emscripten.mjs:51<br>&gt; if (preloadModule) preloadModule.default(Module)=
;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^<br>&gt; TypeError: preloadModule.default is not a function<br>&=
gt; =C2=A0 =C2=A0 =C2=A0at file:///home/user/.work/qemu/scripts/run-emscrip=
ten.mjs:51:41<br>&gt; Node.js v24.13.0<br><br></div><div>Thank you for tryi=
ng the script.</div><div><br></div><div dir=3D"ltr">That script requires th=
e --export-es6 flag to file_packager.py. This flag<br>was introduced in Ems=
cripten 4.0.13 so please update the Emscripten tools if<br>it is not availa=
ble. If you&#39;re using emsdk, it provides the way to intall<br>newer tool=
s, such as &quot;emsdk update&quot; and &quot;emsdk install 4.0.23&quot; [1=
].<br><br>[1] <a href=3D"https://emscripten.org/docs/tools_reference/emsdk.=
html#how-to-guides">https://emscripten.org/docs/tools_reference/emsdk.html#=
how-to-guides</a><br><br>Regards,<br>Kohei Tokunaga<br><br></div></div>

--000000000000eb03cc0649557f0e--

