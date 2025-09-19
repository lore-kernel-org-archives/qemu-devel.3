Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978C5CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWOu-0003ww-Oz; Fri, 19 Sep 2025 04:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzWOs-0003wb-4m
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzWOo-0007TJ-M6
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758270198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=mPNb3CiSIXbcGKviHdcLEu10TbMSdL5F918yJiveqq4=;
 b=KBlneDkQQeic9neYnDuvf2SJ8xSqctYCn4JvWU4elddfIbR3t4GzcF7z2xKidbLJFRXZHT
 6G8knvrtuzAc1Ga6WyAnCwDH2UHTZ1Oh8wExqX7lImE9NpY2btERsMlcxR008g7UfHvCix
 C/5QpaeZbW8DljW1ajAqgXSjuuA5si0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-eL4c7WawN1627oh4-OL1Yw-1; Fri,
 19 Sep 2025 04:23:15 -0400
X-MC-Unique: eL4c7WawN1627oh4-OL1Yw-1
X-Mimecast-MFC-AGG-ID: eL4c7WawN1627oh4-OL1Yw_1758270193
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED0E41956086; Fri, 19 Sep 2025 08:23:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7EBB30002C5; Fri, 19 Sep 2025 08:23:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E536921E6A27; Fri, 19 Sep 2025 10:23:08 +0200 (CEST)
Resent-To: qemu_oss@crudebyte.com, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, richard.henderson@linaro.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, dave@treblig.org, sw@weilnetz.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 19 Sep 2025 10:23:08 +0200
Resent-Message-ID: <87ms6q6ec3.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 03/20] system: unconditionally enable thread naming
In-Reply-To: <20250910180357.320297-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:40
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-4-berrange@redhat.com>
Date: Fri, 19 Sep 2025 10:20:51 +0200
Message-ID: <87zfaq6efw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When thread naming was introduced years ago, it was disabled by
> default and put behind a command line flag:
>
>   commit 8f480de0c91a18d550721f8d9af969ebfbda0793
>   Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
>   Date:   Thu Jan 30 10:20:31 2014 +0000
>
>     Add 'debug-threads' suboption to --name
>
> This was done based on a concern that something might depend
> on the historical thread naming. Thread names, however, were
> never promised to be part of QEMU's public API. The defaults
> will vary across platforms, so no assumptions should ever be
> made about naming.
>
> An opt-in behaviour is also unfortunately incompatible with
> RCU which creates its thread from an constructor function
> which is run before command line args are parsed. Thus the
> RCU thread lacks any name.
>
> libvirt has unconditionally enabled debug-threads=3Dyes on all
> VMs it creates for 10 years. Interestingly this DID expose a
> bug in libvirt, as it parsed /proc/$PID/stat and could not
> cope with a space in the thread name. This was a latent
> pre-existing bug in libvirt though, and not a part of QEMU's
> API.
>
> Having thread names always available, will allow thread names
> to be included in error reports and log messags QEMU prints
> by default, which will improve ability to triage QEMU bugs.
>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/about/deprecated.rst |  7 +++++++
>  include/qemu/thread.h     |  1 -
>  system/vl.c               | 11 ++++++-----
>  util/qemu-thread-posix.c  | 18 +-----------------
>  util/qemu-thread-win32.c  | 27 ++++++---------------------
>  5 files changed, 20 insertions(+), 44 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index b2420732e1..7187ea15fa 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -81,6 +81,13 @@ kernel since 2001. None of the board types QEMU suppor=
ts need
>  ``param_struct`` support, so this option has been deprecated and will
>  be removed in a future QEMU version.
>=20=20
> +``debug-threads`` option for ``-name``
> +''''''''''''''''''''''''''''''''''''''
> +
> +Thread ``debug-threads`` option for the ``-name`` argument is now

Do you mean "The ``debug-threads`` option"?

"option for" or "option of"?  Not a native speaker...

> +ignored. Thread naming is unconditionally enabled for all platforms
> +where it is supported.
> +
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
>=20=20
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index f0302ed01f..3a286bb3ef 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -215,7 +215,6 @@ void *qemu_thread_join(QemuThread *thread);
>  void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  G_NORETURN void qemu_thread_exit(void *retval);
> -void qemu_thread_naming(bool enable);
>=20=20
>  struct Notifier;
>  /**
> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..a64fd90d4a 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -403,9 +403,7 @@ static QemuOptsList qemu_name_opts =3D {
>          }, {
>              .name =3D "debug-threads",
>              .type =3D QEMU_OPT_BOOL,
> -            .help =3D "When enabled, name the individual threads; defaul=
ts off.\n"
> -                    "NOTE: The thread names are for debugging and not a\=
n"
> -                    "stable API.",
> +            .help =3D "DEPRECATED: thread names are always set where sup=
ported",

Please don't shout :)

We rarely note deprecation notes in command line help texts.  I found
two.

block/qcow.c:

        {
            .name =3D BLOCK_OPT_ENCRYPT,
            .type =3D QEMU_OPT_BOOL,
            .help =3D "Encrypt the image with format 'aes'. (Deprecated "
                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",
        },

block/qcow2.c:

        {                                                               \
            .name =3D BLOCK_OPT_ENCRYPT,                                  \
            .type =3D QEMU_OPT_BOOL,                                      \
            .help =3D "Encrypt the image with format 'aes'. (Deprecated " \
                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",    \
        },                                                              \
        {                                                               \

Suggest something like

            .help =3D "Enable thread names"
                    " (deprecated, always enabled where supported)",

>          },
>          { /* End of list */ }
>      },
> @@ -554,9 +552,12 @@ static int parse_name(void *opaque, QemuOpts *opts, =
Error **errp)
>  {
>      const char *proc_name;
>=20=20
> -    if (qemu_opt_get(opts, "debug-threads")) {
> -        qemu_thread_naming(qemu_opt_get_bool(opts, "debug-threads", fals=
e));
> +    if (qemu_opt_get(opts, "debug-threads") &&
> +        !qemu_opt_get_bool(opts, "debug-threads", false)) {
> +        fprintf(stderr, "Ignoring deprecated 'debug-threads=3Dno' option=
, " \
> +                "thread naming is unconditionally enabled\n");

Not sure this is worth the trouble, but since you wrote and tested it
already...

>      }
> +
>      qemu_name =3D qemu_opt_get(opts, "guest");
>=20=20
>      proc_name =3D qemu_opt_get(opts, "process");
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index ba725444ba..7c985b5d38 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -22,22 +22,6 @@
>  #include <pthread_np.h>
>  #endif
>=20=20
> -static bool name_threads;
> -
> -void qemu_thread_naming(bool enable)
> -{
> -    name_threads =3D enable;
> -
> -#if !defined CONFIG_PTHREAD_SETNAME_NP_W_TID && \
> -    !defined CONFIG_PTHREAD_SETNAME_NP_WO_TID && \
> -    !defined CONFIG_PTHREAD_SET_NAME_NP
> -    /* This is a debugging option, not fatal */
> -    if (enable) {
> -        fprintf(stderr, "qemu: thread naming not supported on this host\=
n");
> -    }
> -#endif
> -}
> -
>  static void error_exit(int err, const char *msg)
>  {
>      fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
> @@ -361,7 +345,7 @@ static void *qemu_thread_start(void *args)
>      /* Attempt to set the threads name; note that this is for debug, so
>       * we're not going to fail if we can't set it.
>       */
> -    if (name_threads && qemu_thread_args->name) {
> +    if (qemu_thread_args->name) {
>  # if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
>          pthread_setname_np(pthread_self(), qemu_thread_args->name);
>  # elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index ca2e0b512e..9595a5b090 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -17,8 +17,6 @@
>  #include "qemu-thread-common.h"
>  #include <process.h>
>=20=20
> -static bool name_threads;
> -
>  typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
>                                                   PCWSTR lpThreadDescript=
ion);
>  static pSetThreadDescription SetThreadDescriptionFunc;
> @@ -44,16 +42,6 @@ static bool load_set_thread_description(void)
>      return !!SetThreadDescriptionFunc;
>  }
>=20=20
> -void qemu_thread_naming(bool enable)
> -{
> -    name_threads =3D enable;
> -
> -    if (enable && !load_set_thread_description()) {
> -        fprintf(stderr, "qemu: thread naming not supported on this host\=
n");
> -        name_threads =3D false;
> -    }
> -}
> -
>  static void error_exit(int err, const char *msg)
>  {
>      char *pstr;
> @@ -328,23 +316,20 @@ void *qemu_thread_join(QemuThread *thread)
>      return ret;
>  }
>=20=20
> -static bool set_thread_description(HANDLE h, const char *name)
> +static void set_thread_description(HANDLE h, const char *name)
>  {
> -    HRESULT hr;
>      g_autofree wchar_t *namew =3D NULL;
>=20=20
>      if (!load_set_thread_description()) {
> -        return false;
> +        return;
>      }
>=20=20
>      namew =3D g_utf8_to_utf16(name, -1, NULL, NULL, NULL);
>      if (!namew) {
> -        return false;
> +        return;
>      }
>=20=20
> -    hr =3D SetThreadDescriptionFunc(h, namew);
> -
> -    return SUCCEEDED(hr);
> +    SetThreadDescriptionFunc(h, namew);
>  }
>=20=20
>  void qemu_thread_create(QemuThread *thread, const char *name,
> @@ -370,8 +355,8 @@ void qemu_thread_create(QemuThread *thread, const cha=
r *name,
>      if (!hThread) {
>          error_exit(GetLastError(), __func__);
>      }
> -    if (name_threads && name && !set_thread_description(hThread, name)) {
> -        fprintf(stderr, "qemu: failed to set thread description: %s\n", =
name);
> +    if (name) {
> +        set_thread_description(hThread, name);
>      }
>      CloseHandle(hThread);

Modulo nits:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


