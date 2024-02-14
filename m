Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C520C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra9Kd-0001cc-0B; Wed, 14 Feb 2024 02:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ra9Kb-0001c8-38
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:05:21 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ra9KZ-0007Mt-30
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:05:20 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-42aadddeaf8so33107451cf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707894317; x=1708499117; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uAkgcCPagxL0XuWhRA9qkMmVRwHGQgkENe7igu1Xuc=;
 b=KhSOwkEwk+RrHpScwkjTO4foby9giXxR0+xYNWYWajeday8oXLhNmqrrlv/PVbxHzo
 Dsce2BylYYf0ziXkw6bkYzoNsLKzWaNMfGuvHmDGII945pl3lvpdMc5ak1YckfCPqkKL
 PNHgGyOCo2zPyQGB+fvWQ4+FAuV/Yt5mw1uMcDIwSDfxGrkPlizNQ+GW5fUtSmUhy8sK
 dqLM0eBvIGqkeP2dVZB43WeZn3veqfNVt1slmslGoQ/tVQgnzoq3s/GH3umU8/oH8Fg5
 RqNYdMXxHjJuvoq2pnTk82VPyXqYf4tZCWmtmzc0O5vBycv9BYvJmz6uRnwB6fGrKgI2
 2VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707894317; x=1708499117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uAkgcCPagxL0XuWhRA9qkMmVRwHGQgkENe7igu1Xuc=;
 b=ifJ/0gfpR1ppuA2Ie6Rco8jj5dF58MYgH8PJxgKk5qBEaaCiyYnRH8mSFbiiatA7fs
 J6LzetsuNaxLyGHCzLkXJ/PKPGtzqwVh+NZU6paCiueLyN/0hFwEI3UmdaTzjjiOAfax
 f+r2XwBJYjxnNeiEtvPyARWxjfTYLkI6DSSFVLCl+EBZlFELdt3EtqzvdC8v0JbctiWQ
 SLhWJMU7UX6hR9UsAm2IKnLchjDBFtFgS6C/DQArkCh5EDQpqDT5ptYK/BkQtuKS9k9u
 XqW3qOKqEGSQbJSXahXkzVovlLytkgYIjq43GxRhd5b0hvT1bVqv3Sh+Hp/djK+LbDTk
 FXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjUdKpqL8PcfDqTEOOBtZe5qm4acl5gs77atyv8auPCIXYRvlZqytU0PuflrFK3o59JFC9288JCNQcXvSJlEQebyyOdXc=
X-Gm-Message-State: AOJu0YxmREEKWNM8XArAKUK0khSTGIYky4v7zJCFIPIGtMIe9kZFtMRR
 Wm6aBPAePXXgzb2JFPodrVENXjFyMQzN93uP7CD6MzNntV5eukXUdfJGqbItsAk3/nfE6DPnIK5
 hQ8YSHQ0qK1G1zhSxLwgsG732aiU=
X-Google-Smtp-Source: AGHT+IEzMJmofACW35bo/JG2kUcNIupKyYhkpV7er8XSXlDVxnfddbzCqWDMxCv8TY44MT5alARb+yOXIGYFjq5HoYU=
X-Received: by 2002:a05:622a:1705:b0:42b:f020:f36e with SMTP id
 h5-20020a05622a170500b0042bf020f36emr1952859qtk.59.1707894317470; Tue, 13 Feb
 2024 23:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20240214-dbus-v6-1-411af2b9289e@daynix.com>
In-Reply-To: <20240214-dbus-v6-1-411af2b9289e@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 14 Feb 2024 11:05:05 +0400
Message-ID: <CAJ+F1CLw6FCMzz1vmNQTon4zR2ae=O5Er+5kU56xQGgCMp77Gw@mail.gmail.com>
Subject: Re: [PATCH v6] util: Move dbus_display1 to util
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

Hi Akihiko

On Wed, Feb 14, 2024 at 9:39=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Move dbus_display1 from ui to util as it's used not only by ui/dbus but
> also dbus-display-test.

It doesn't seem like the right place either. So let's focus on what
this is fixing.

> dbus_display1 is now added to util_ss accordingly. It ensures that the
> source will be linked with audio/dbus, and also avoids recompilation
> when linking with dbus-display-test.

- "It ensures that the source will be linked with audio/dbus"
Right, this could be achieved with: module_ss.add(when: [gio, pixman],
if_true: [files('dbusaudio.c'), dbus_display1_dep])

- "avoids recompilation when linking with dbus-display-test"
Similarly: qtests +=3D {'dbus-display-test': [dbus_display1_dep, gio]}

>
> dbus-display.h is also added to genh to ensure it is generated before
> compiling ui/dbus, audio/dbus, and dbus-display-test.
>

meson should take care of those dependencies if they are expressed correctl=
y.

> Both changes combined, it is no longer necessary for ui/dbus,
> audio/dbus, and dbus-display-test to explicitly state the dependency on
> dbus_display1.

This is eventually nice for things that are really common, but in this
case I don't think it's a win.

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> I found it was failing to build dbus modules when --enable-dbus so here
> are fixes.
> ---
> Changes in v6:
> - Dropped patch "audio: Do not include ui/dbus.h" (Marc-Andr=C3=A9 Lureau=
).
> - Rebased.
> - Link to v5: https://lore.kernel.org/r/20231217-dbus-v5-0-8122e822a392@d=
aynix.com
>
> Changes in v5:
> - Fixed docs/interop/dbus-display.rst.
> - Link to v4: https://lore.kernel.org/r/20231217-dbus-v4-0-4fd5410bf04f@d=
aynix.com
>
> Changes in v4:
> - Moved dbus_display1 to util.
> - Link to v3: https://lore.kernel.org/r/20231216-dbus-v3-0-b4bcbed7374a@d=
aynix.com
>
> Changes in v3:
> - Merged dbus_display1_lib into libqemuutil.
> - Added patch "audio: Do not include ui/dbus.h".
> - Link to v2: https://lore.kernel.org/r/20231215-dbus-v2-0-1e2e6aa02115@d=
aynix.com
>
> Changes in v2:
> - Updated MAINTAINERS.
> - Link to v1: https://lore.kernel.org/r/20231215-dbus-v1-0-349e059ac5b2@d=
aynix.com
> ---
>  MAINTAINERS                     |  2 +-
>  docs/interop/dbus-display.rst   |  6 +++---
>  ui/dbus.h                       |  2 +-
>  audio/dbusaudio.c               |  2 +-
>  tests/qtest/dbus-display-test.c |  2 +-
>  tests/qtest/meson.build         |  2 +-
>  ui/meson.build                  | 20 +-------------------
>  {ui =3D> util}/dbus-display1.xml  |  0
>  util/meson.build                | 21 +++++++++++++++++++++
>  9 files changed, 30 insertions(+), 27 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f80db6a96a3f..0a81159e33d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3413,7 +3413,7 @@ S: Maintained
>  F: backends/dbus-vmstate.c
>  F: ui/dbus*
>  F: audio/dbus*
> -F: util/dbus.c
> +F: util/dbus*
>  F: include/ui/dbus*
>  F: include/qemu/dbus.h
>  F: docs/interop/dbus*
> diff --git a/docs/interop/dbus-display.rst b/docs/interop/dbus-display.rs=
t
> index 8c6e8e0f5a82..efec89723a34 100644
> --- a/docs/interop/dbus-display.rst
> +++ b/docs/interop/dbus-display.rst
> @@ -18,14 +18,14 @@ QEMU also implements the standard interfaces, such as
>
>  .. only:: sphinx4
>
> -   .. dbus-doc:: ui/dbus-display1.xml
> +   .. dbus-doc:: util/dbus-display1.xml
>
>  .. only:: not sphinx4
>
>     .. warning::
>        Sphinx 4 is required to build D-Bus documentation.
>
> -      This is the content of ``ui/dbus-display1.xml``:
> +      This is the content of ``util/dbus-display1.xml``:
>
> -   .. literalinclude:: ../../ui/dbus-display1.xml
> +   .. literalinclude:: ../../util/dbus-display1.xml
>        :language: xml
> diff --git a/ui/dbus.h b/ui/dbus.h
> index 1e8c24a48e32..a847bee98876 100644
> --- a/ui/dbus.h
> +++ b/ui/dbus.h
> @@ -31,7 +31,7 @@
>  #include "ui/console.h"
>  #include "ui/clipboard.h"
>
> -#include "ui/dbus-display1.h"
> +#include "util/dbus-display1.h"
>
>  typedef struct DBusClipboardRequest {
>      GDBusMethodInvocation *invocation;
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 60fcf643ecf8..2aacdac6715b 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -34,7 +34,7 @@
>  #endif
>
>  #include "ui/dbus.h"
> -#include "ui/dbus-display1.h"
> +#include "util/dbus-display1.h"
>
>  #define AUDIO_CAP "dbus"
>  #include "audio.h"
> diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-t=
est.c
> index 21edaa1e321f..d4871e2fd80f 100644
> --- a/tests/qtest/dbus-display-test.c
> +++ b/tests/qtest/dbus-display-test.c
> @@ -5,7 +5,7 @@
>  #include <gio/gio.h>
>  #include <gio/gunixfdlist.h>
>  #include "libqtest.h"
> -#include "ui/dbus-display1.h"
> +#include "util/dbus-display1.h"
>
>  static GDBusConnection*
>  test_dbus_p2p_from_fd(int fd)
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 39557d5ecbb0..627ff8fbe1c7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -344,7 +344,7 @@ if vnc.found()
>  endif
>
>  if dbus_display
> -  qtests +=3D {'dbus-display-test': [dbus_display1, gio]}
> +  qtests +=3D {'dbus-display-test': [gio]}
>  endif
>
>  qtest_executables =3D {}
> diff --git a/ui/meson.build b/ui/meson.build
> index 376e0d771ba9..74e2a79b8c1e 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -74,25 +74,7 @@ endif
>
>  if dbus_display
>    dbus_ss =3D ss.source_set()
> -  env =3D environment()
> -  env.set('HOST_OS', host_os)
> -  xml =3D custom_target('dbus-display preprocess',
> -                      input: 'dbus-display1.xml',
> -                      output: 'dbus-display1.xml',
> -                      env: env,
> -                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
> -  dbus_display1 =3D custom_target('dbus-display gdbus-codegen',
> -                                output: ['dbus-display1.h', 'dbus-displa=
y1.c'],
> -                                input: xml,
> -                                command: [gdbus_codegen, '@INPUT@',
> -                                          '--glib-min-required', '2.64',
> -                                          '--output-directory', meson.cu=
rrent_build_dir(),
> -                                          '--interface-prefix', 'org.qem=
u.',
> -                                          '--c-namespace', 'QemuDBus',
> -                                          '--generate-c-code', '@BASENAM=
E@'])
> -  dbus_display1_lib =3D static_library('dbus-display1', dbus_display1, d=
ependencies: gio)
> -  dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,=
 include_directories: include_directories('.'))
> -  dbus_ss.add(when: [gio, dbus_display1_dep],
> +  dbus_ss.add(when: [gio],
>                if_true: [files(
>                  'dbus-chardev.c',
>                  'dbus-clipboard.c',
> diff --git a/ui/dbus-display1.xml b/util/dbus-display1.xml
> similarity index 100%
> rename from ui/dbus-display1.xml
> rename to util/dbus-display1.xml
> diff --git a/util/meson.build b/util/meson.build
> index 0ef9886be048..d23c8382fa37 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -128,3 +128,24 @@ elif cpu =3D=3D 'loongarch64'
>  elif cpu in ['ppc', 'ppc64']
>    util_ss.add(files('cpuinfo-ppc.c'))
>  endif
> +
> +if dbus_display
> +  env =3D environment()
> +  env.set('HOST_OS', host_os)
> +  xml =3D custom_target('dbus-display preprocess',
> +                      input: 'dbus-display1.xml',
> +                      output: 'dbus-display1.xml',
> +                      env: env,
> +                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
> +  dbus_display1 =3D custom_target('dbus-display gdbus-codegen',
> +                                output: ['dbus-display1.h', 'dbus-displa=
y1.c'],
> +                                input: xml,
> +                                command: [gdbus_codegen, '@INPUT@',
> +                                          '--glib-min-required', '2.64',
> +                                          '--output-directory', meson.cu=
rrent_build_dir(),
> +                                          '--interface-prefix', 'org.qem=
u.',
> +                                          '--c-namespace', 'QemuDBus',
> +                                          '--generate-c-code', '@BASENAM=
E@'])
> +  util_ss.add(dbus_display1)
> +  genh +=3D dbus_display1[0]
> +endif
>
> ---
> base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
> change-id: 20231215-dbus-86876ecb7b09
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


--=20
Marc-Andr=C3=A9 Lureau

