Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B81FC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 13:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbh2j-00047o-EX; Sun, 18 Feb 2024 08:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2g-00047S-RJ
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:15 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2e-0007tT-Nx
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:14 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so474643666b.2
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708262230; x=1708867030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4W2FscuSMk5WUXrrNDl1PETlArCxXxw4fHR/btTHn0k=;
 b=g28mqFrnJ6vp957xT8IFHU61UjPOKPHVVSPQHaXnAklmFF5a7bN+X0pEPPKcKMcPZ3
 vkF19r3sNmW54VaPuRmHi2NJpXgMO7Lgr11WtTttKBjx8/No59YBhh/BcTuAzT5cJbrj
 0v+gd/mKjmyQb3Fvsuhb7j2ZfyxdF4pas8zsMrZJuptGw09HKy7kVPgUXbZM/Ragbgfj
 QMARcUD1JfSRi9firrTa6vWMSnx4/bLdZQH76VCf1Hi394SkmgJd/tyyjs+MiFdgvBdX
 6Xzr7JwX7I6qedxfahnLg1Ypy2i3oRq1Tskq83IIhqD3pqvzcLQ3Wor5dKMSltWR2brX
 1JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708262230; x=1708867030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4W2FscuSMk5WUXrrNDl1PETlArCxXxw4fHR/btTHn0k=;
 b=PDfRji/+zIRvjHgTa9S0Pj7UbjwqejcutIHyBiHnldfx5HuHu6K4T8QK/x9r5Bmx+6
 ggEZAEDUiIYdZk11hiVZJwxhIMVaf/rGuG5QFfPGoZiq2Z61XUsx6BMhgg+fxsiliTpc
 fGNlI/rbp4pJYkeu/1Dwbjrn0H1vZMnK/X5CudPbPZCEwIZFuYF0JlokMqfq9ryLEqVZ
 XAOXDaounNDlh23XBBnhvOx83QMXil10r7HtTDdN7vFNQvHxiq6R0fZb0i1OY6ost7JO
 fhVMS8Ch8y70Xe/Z6LQk9uV2GCnRBR8MIy/X5thGxAWVjFfTK3np17MojflTv9JvOeW8
 YqlA==
X-Gm-Message-State: AOJu0Yzst9NjNHxgDNXQEBRa5FZIqYBkzLrtgHyDVyLO4OlTQu8Ucuf2
 AMmvKXPWBEQAE5YCimDFgSUUKvuwGoU+nsuFiYZe0jq11hTpfxw/W8cGafTx
X-Google-Smtp-Source: AGHT+IEZK4XFqBIG1P5omPvApQfj/gtlIaXi1exAyCsvfO/3Xytox0nYjzwzDGeX5rSxtD5icmWHDg==
X-Received: by 2002:a17:906:2a90:b0:a3e:1ab9:b6a1 with SMTP id
 l16-20020a1709062a9000b00a3e1ab9b6a1mr2041424eje.21.1708262229912; 
 Sun, 18 Feb 2024 05:17:09 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-149-080.78.54.pool.telefonica.de.
 [78.54.149.80]) by smtp.gmail.com with ESMTPSA id
 jw15-20020a170906e94f00b00a3e86a9c55asm255088ejb.146.2024.02.18.05.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 05:17:09 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/5] Implement port 92 in south bridges
Date: Sun, 18 Feb 2024 14:16:56 +0100
Message-ID: <20240218131701.91132-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series attempts to make QEMU's south bridge families PIIX, ICH9, and V=
IA=0D
82xx more self-contained by integrating IO port 92 like the originals do.=0D
=0D
In QEMU, the IO port is currently instantiated as a dedicated device in com=
mon=0D
PC code. While this works and even results in less code, it seems cleaner t=
o=0D
model the behavior of the real devices. For example, software running on th=
e=0D
Malta machine, which uses PIIX4, needs to take port 92 into account, even i=
f it=0D
doesn't use it (does it?). Moreover, the FDC37M81x used in the original Mal=
ta=0D
machine provides a port 92 too, which can be activated. If QEMU implemented=
 the=0D
FDC37M81x more closely, one could check if Yamon (or any alternative boot=0D
loader) deals correctly with these ports.=0D
=0D
Moving port 92 into the south bridges might also help with configuration-dr=
iven=0D
machine creation. In such a scenario it is probably desirable if machine co=
de=0D
had less of its own idea of which devices it creates. Moving port 92 from=0D
machine code into a potentially user-creaeable device (where it is part of =
per=0D
datasheet) seems like a good direction. Of course, machine code still wires=
 up=0D
port 92 and I don't have a good idea on how to make this user-configurable.=
=0D
Such insights might provide some input for discussions around=0D
configuration-driven machine creation.=0D
=0D
This series is structured as follows: Patch 1 moves TYPE_PORT92 into the is=
a=0D
directory to make it reusable by other architectures. It also adds a=0D
configuration switch. Patch 2 integrates TYPE_PORT92 into the PC south brid=
ges=0D
and adapts PC code accordingly. While at it, patch 3 cleans up wiring of th=
e=0D
A20 line with the keyboard controller. Patch 4 simply adds TYPE_PORT92 to t=
he=0D
VIA south bridges which is also needed when using the VIA south bridges in =
the=0D
pc machine.=0D
=0D
Testing done:=0D
* `qemu-system-x86_64 -M {q35,pc},i8042=3D{true,false} ...`=0D
  -> `info mtree` confirms port92 to be present iff i8042=3Dtrue=0D
* `make check`=0D
* `make check-avocado`=0D
* Start amigaone and pegasos2 machines as described in=0D
    https://patchew.org/QEMU/20240216001019.69A524E601F@zero.eik.bme.hu/=0D
  -> no regressions compared to master=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
Bernhard Beschow (5):=0D
  hw/isa/meson.build: Sort alphabetically=0D
  hw/i386/port92: Allow for TYPE_PORT92 to be embedded in devices=0D
  hw/isa: Embed TYPE_PORT92 in south bridges used in PC machines=0D
  hw/i386/pc: Inline i8042_setup_a20_line() and remove it=0D
  hw/isa/vt82c686: Embed TYPE_PORT92=0D
=0D
 include/hw/i386/pc.h          |  7 +------=0D
 include/hw/input/i8042.h      |  1 -=0D
 include/hw/isa/port92.h       | 30 ++++++++++++++++++++++++++++++=0D
 include/hw/southbridge/ich9.h |  4 ++++=0D
 include/hw/southbridge/piix.h |  3 +++=0D
 hw/i386/pc.c                  | 21 ++++++++++++++-------=0D
 hw/i386/pc_piix.c             |  9 +++++++--=0D
 hw/i386/pc_q35.c              |  8 +++++---=0D
 hw/input/pckbd.c              |  5 -----=0D
 hw/isa/lpc_ich9.c             |  9 +++++++++=0D
 hw/isa/piix.c                 |  9 +++++++++=0D
 hw/{i386 =3D> isa}/port92.c     | 14 +-------------=0D
 hw/isa/vt82c686.c             |  7 +++++++=0D
 hw/i386/Kconfig               |  1 +=0D
 hw/i386/meson.build           |  3 +--=0D
 hw/i386/trace-events          |  4 ----=0D
 hw/isa/Kconfig                |  6 ++++++=0D
 hw/isa/meson.build            |  3 ++-=0D
 hw/isa/trace-events           |  4 ++++=0D
 19 files changed, 104 insertions(+), 44 deletions(-)=0D
 create mode 100644 include/hw/isa/port92.h=0D
 rename hw/{i386 =3D> isa}/port92.c (91%)=0D
=0D
-- =0D
2.43.2=0D
=0D

