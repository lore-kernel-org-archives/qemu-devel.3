Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E80AC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZT4h-0008Fq-Lj; Wed, 09 Jul 2025 07:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZT3r-0007iJ-0V
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:34:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZT3o-0004ev-Et
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:34:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60c5b7cae8bso8827580a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752060836; x=1752665636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvAZam0ZQJwkDglxrsrVjW7kXanQqVCIb6b4rhhIE0s=;
 b=WffrIeOXUTUeDO7G83GOP2kcr8jwoOCS38m+dlA4lrbKt4Gt+6bTZ6O3TTVVXNu/D4
 4uYOWE9sL+jS+wikJDBXpPuesQrWDPCY8tgv9k5AnCdoRUZ+eME7fyBrYa7ZaFrqLsez
 duPccPzVuD8D53rFwl/PzUIza4gbBJz1tracco17vTEE6wUDMZsRadS+vbFW6YopbvHv
 8UPDhxSyJij0bYrQ1hAbmh3X8zQbvy8AVXS3b/4OPA75zknVlXvw5KZMqKiyyVfqNZAk
 zaUAPb4eyoLU01mZMU8wta/OqNmDlQWT1uv1bggw1DGPtpSH1fr5yQs1hCxqkx8BRCw7
 dWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752060836; x=1752665636;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvAZam0ZQJwkDglxrsrVjW7kXanQqVCIb6b4rhhIE0s=;
 b=XfLbgfkI4evfOE6RZAWBGhESQbuKPMTNjv5DCqKVMqVOnNR1SOOlv5VKHXiMrmvOAK
 JgNqfuefsESw1A2ph2BqTHnDpvbKBi/dEKNzsfDCMQSah6vnmrHhjr6S1TKVY4W3Yu+b
 cfLibMbhZDs5VASD4enszVWSI6Fm7GVlnB5abVdDGML9Lg3TE6qDiL8zsRX0SXyIiR1m
 Q7H8w/LOwmV8edgD2LT5nJ3xqxxKRepix3Qoz4tJ0Ee6o7IrMLW1Y54QTlOarkBmmdmQ
 cCy/2pK4HLhs1aSbgaGBrjmtQe4Yvd4p/a7IE74AvFwCdDaCV8ypXAMEzeQamd6v9xqk
 Kl3A==
X-Gm-Message-State: AOJu0Yy3hYAiq4nqloEdYtDoESMaA6tTfhU69fd0CwysFFsIclEOP24e
 BxhHomfp+oez+AwQnrOPPc7sq0pxIa7litz3gZB2Bn5o5iNS1QL+M7ioplWsVLSe+ek=
X-Gm-Gg: ASbGnctSbHNJdnoslJcsnStr+Z3iHHeUsNJXME6fv6s2A8NGuiPBGtrz1R2J3j+zaL7
 kc+ETJkp0tnQLZJkOsUcpyq8jc5Z0XfoQpWCklvIDNPxLwn57/v2NcYwTws8G+0wxurlA+ev+Fi
 9DR10WU0As+ClJnWzEjPZQqKLBqAVWJbAvFPpDxyqkWNp3tVLE7snuElECPI+BxFzmKiqm/fJOk
 xyfQ1WjyThhBm/TdWPEkx034HMou5NS/hl4yVFfeX/1nI9+JoEFABuYp7itDT6FFCdWCLjADKOx
 C//fjQkaF1chfK1Hkc8MWagtoRZ8ynxwIraSIfXZLmEMepywtjT2yYlhgJ/mIog=
X-Google-Smtp-Source: AGHT+IFAKBCfKXMpHXMS3952twYF689K0Vi7JjzWVKoKYwRf2zllsr0H34U0MKUeln2/M2SotKzeYw==
X-Received: by 2002:a17:907:d15:b0:add:ed3a:e792 with SMTP id
 a640c23a62f3a-ae6cf7a92ddmr236663966b.47.1752060836499; 
 Wed, 09 Jul 2025 04:33:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6929852sm1077161066b.43.2025.07.09.04.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 04:33:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D144A5F767;
 Wed, 09 Jul 2025 12:33:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] docs: use :kbd: role in sphinx docs
In-Reply-To: <20250703-docs_rst_improvements-v1-1-0dbbc5eb5871@linaro.org>
 (Manos Pitsidianakis's message of "Thu, 03 Jul 2025 13:38:01 +0300")
References: <20250703-docs_rst_improvements-v1-1-0dbbc5eb5871@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 09 Jul 2025 12:33:54 +0100
Message-ID: <87y0sxtx7h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Sphinx supports the :kbd: role for notating keyboard input. They get
> formatted as <kbd> HTML elements in the readthedocs theme we currently
> use for Sphinx.
>
> Besides the better visual formatting, it also helps with accessibility
> as screen readers can announce the semantics of the <kbd> element to the
> user.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  docs/devel/testing/main.rst     |  4 ++--
>  docs/system/images.rst          |  2 +-
>  docs/system/keys.rst.inc        | 22 +++++++++++-----------
>  docs/system/linuxboot.rst       |  2 +-
>  docs/system/mux-chardev.rst.inc | 16 ++++++++--------
>  5 files changed, 23 insertions(+), 23 deletions(-)

I would be better to split this into a commit per-file so we can merge
the easy ones quickly.

>
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 6b18ed875cd91e961d07b3afa3179c7fba0e5fe3..2b5cb0c148048e3a81d2db8c4=
a9500591880997f 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -604,9 +604,9 @@ below steps to debug it:
>  2. Add "V=3D1" to the command line, try again, to see the verbose output.
>  3. Further add "DEBUG=3D1" to the command line. This will pause in a she=
ll prompt
>     in the container right before testing starts. You could either manual=
ly
> -   build QEMU and run tests from there, or press Ctrl-D to let the Docker
> +   build QEMU and run tests from there, or press :kbd:`Ctrl+d` to let th=
e Docker
>     testing continue.
> -4. If you press Ctrl-D, the same building and testing procedure will beg=
in, and
> +4. If you press :kbd:`Ctrl+d`, the same building and testing procedure w=
ill begin, and
>     will hopefully run into the error again. After that, you will be drop=
ped to
>     the prompt for debug.
>=20=20
> diff --git a/docs/system/images.rst b/docs/system/images.rst
> index a5551173c9789323ceb150c51fd68c6d4ef80d71..43706969fddae7bcb83de172b=
1a04b5c6cffe0f1 100644
> --- a/docs/system/images.rst
> +++ b/docs/system/images.rst
> @@ -30,7 +30,7 @@ Snapshot mode
>  If you use the option ``-snapshot``, all disk images are considered as
>  read only. When sectors in written, they are written in a temporary file
>  created in ``/tmp``. You can however force the write back to the raw
> -disk images by using the ``commit`` monitor command (or C-a s in the
> +disk images by using the ``commit`` monitor command (or :kbd:`Ctrl+a s` =
in the
>  serial console).
>=20=20
>  .. _vm_005fsnapshots:
> diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
> index 59966a3fe7cf2cbb6a19dacd48612b768b7a1e96..f33f1acd08607c93d2ef250e3=
ca183f41f237658 100644
> --- a/docs/system/keys.rst.inc
> +++ b/docs/system/keys.rst.inc
> @@ -1,23 +1,23 @@
>  During the graphical emulation, you can use special key combinations from
> -the following table to change modes. By default the modifier is Ctrl-Alt
> +the following table to change modes. By default the modifier is :kbd:`Ct=
rl+Alt`
>  (used in the table below) which can be changed with ``-display`` subopti=
on
>  ``mod=3D`` where appropriate. For example, ``-display sdl,
> -grab-mod=3Dlshift-lctrl-lalt`` changes the modifier key to Ctrl-Alt-Shif=
t,
> -while ``-display sdl,grab-mod=3Drctrl`` changes it to the right Ctrl key.
> +grab-mod=3Dlshift-lctrl-lalt`` changes the modifier key to :kbd:`Ctrl+Al=
t+Shift`,
> +while ``-display sdl,grab-mod=3Drctrl`` changes it to the right :kbd:`Ct=
rl` key.
>=20=20
> -Ctrl-Alt-f
> +:kbd:`Ctrl+Alt+f`
>     Toggle full screen
>=20=20
> -Ctrl-Alt-+
> +:kbd:`Ctrl+Alt++`
>     Enlarge the screen
>=20=20
> -Ctrl-Alt\--
> +:kbd:`Ctrl+Alt+-`
>     Shrink the screen
>=20=20
> -Ctrl-Alt-u
> +:kbd:`Ctrl+Alt+u`
>     Restore the screen's un-scaled dimensions

This still renders weirdly as a semi-title type thing. You do get the
nice keyboard icons if you format this as a table, e.g:

.. list-table:: Multiplexer Keys
  :widths: 10 90
  :header-rows: 1

  * - Key Sequence
    - Action
  * - :kbd:`Ctrl+Alt+f`
    - Toggle full screen
  * - :kbd:`Ctrl+Alt++`
    - Enlarge the screen
  * - :kbd:`Ctrl+Alt+-`
    - Shrink the screen
  * - :kbd:`Ctrl+Alt+u`
    - Restore the screen's un-scaled dimensions
  * - :kbd:`Ctrl+Alt+n`
    - Switch to virtual console 'n'. Standard console mappings are:
      *1*
      Target system display
      *2*
      Monitor
      *3*
      Serial port
  * - :kbd:`Ctrl+Alt+g`
    - Toggle mouse and keyboard grab.

Although the console mappings still look a bit weird.

>=20=20
> -Ctrl-Alt-n
> +:kbd:`Ctrl+Alt+n`
>     Switch to virtual console 'n'. Standard console mappings are:
>=20=20
>     *1*
> @@ -29,8 +29,8 @@ Ctrl-Alt-n
>     *3*
>        Serial port
>=20=20
> -Ctrl-Alt-g
> +:kbd:`Ctrl+Alt+g`
>     Toggle mouse and keyboard grab.
>=20=20
> -In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp and
> -Ctrl-PageDown to move in the back log.
> +In the virtual consoles, you can use :kbd:`Ctrl+Up`, :kbd:`Ctrl+Down`, :=
kbd:`Ctrl+PageUp` and
> +:kbd:`Ctrl+PageDown` to move in the back log.
> diff --git a/docs/system/linuxboot.rst b/docs/system/linuxboot.rst
> index 2328b4a73d55b47d731497d57ddb1a837ef5d7dd..f7573ab80aa269bac870d7e6e=
5596a8f02fbd5f3 100644
> --- a/docs/system/linuxboot.rst
> +++ b/docs/system/linuxboot.rst
> @@ -26,5 +26,5 @@ virtual serial port and the QEMU monitor to the console=
 with the
>     |qemu_system| -kernel bzImage -drive file=3Drootdisk.img,format=3Draw=
 \
>                      -append "root=3D/dev/sda console=3DttyS0" -nographic
>=20=20
> -Use Ctrl-a c to switch between the serial console and the monitor (see
> +Use :kbd:`Ctrl+a c` to switch between the serial console and the monitor=
 (see
>  :ref:`GUI_keys`).
> diff --git a/docs/system/mux-chardev.rst.inc b/docs/system/mux-chardev.rs=
t.inc
> index 84ea12cbf58f9550154411f8951e6f608179a091..45d0b2c1d76c382a29076502b=
4f1234db5e25bb6 100644
> --- a/docs/system/mux-chardev.rst.inc
> +++ b/docs/system/mux-chardev.rst.inc
> @@ -1,27 +1,27 @@
>  During emulation, if you are using a character backend multiplexer
>  (which is the default if you are using ``-nographic``) then several
>  commands are available via an escape sequence. These key sequences all
> -start with an escape character, which is Ctrl-a by default, but can be
> +start with an escape character, which is :kbd:`Ctrl+a` by default, but c=
an be
>  changed with ``-echr``. The list below assumes you're using the default.
>=20=20
> -Ctrl-a h
> +:kbd:`Ctrl+a h`
>     Print this help
>=20=20
> -Ctrl-a x
> +:kbd:`Ctrl+a x`
>     Exit emulator
>=20=20
> -Ctrl-a s
> +:kbd:`Ctrl+a s`
>     Save disk data back to file (if -snapshot)
>=20=20
> -Ctrl-a t
> +:kbd:`Ctrl+a t`
>     Toggle console timestamps
>=20=20
> -Ctrl-a b
> +:kbd:`Ctrl+a b`
>     Send break (magic sysrq in Linux)
>=20=20
> -Ctrl-a c
> +:kbd:`Ctrl+a c`
>     Rotate between the frontends connected to the multiplexer (usually
>     this switches between the monitor and the console)
>=20=20
> -Ctrl-a Ctrl-a
> +:kbd:`Ctrl+a Ctrl+a`
>     Send the escape character to the frontend

Ditto here.

>
> ---
> base-commit: 7698afc42b5af9e55f12ab2236618e38e5a1c23f
> change-id: 20250703-docs_rst_improvements-1f0cb3c578d6

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

