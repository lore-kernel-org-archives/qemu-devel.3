Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6676BD29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbBz-0006G3-Jm; Tue, 13 Jan 2026 05:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfbBx-0006A0-Qs
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfbBv-0006Mh-NS
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768298398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OLBLFqHeZGfIwjX5zofVYxZi4bKj7+eFRUDdtbws5I=;
 b=a3XR9uc4dwPlxCLCMIBfozm/NRA8/bZx2GKStYmGdkYx6jjdM7GVZL4kmDq5thMJpowZeH
 MhAnin/qgoGBFyNX1/UORrlYf2zXKzMLzwNHgaxlFDejnY0ExKzJeBhaJhn02axC0PWUXd
 kSVs+GiMad9+tJR4+jaCcFmO9nAH3pU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-Ode9FXKmOG-4Iw-1wWxbuQ-1; Tue,
 13 Jan 2026 04:59:55 -0500
X-MC-Unique: Ode9FXKmOG-4Iw-1wWxbuQ-1
X-Mimecast-MFC-AGG-ID: Ode9FXKmOG-4Iw-1wWxbuQ_1768298393
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED17F19560B7; Tue, 13 Jan 2026 09:59:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5413F1800240; Tue, 13 Jan 2026 09:59:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0BEC21E66C9; Tue, 13 Jan 2026 10:59:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  devel@lists.libvirt.org,
 qemu-block@nongnu.org,  qemu-rust@nongnu.org,  Stefan Weil
 <sw@weilnetz.de>,  Kevin Wolf <kwolf@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 09/24] util: introduce some API docs for logging APIs
In-Reply-To: <20260108170338.2693853-10-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 Jan 2026 17:03:23
 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-10-berrange@redhat.com>
Date: Tue, 13 Jan 2026 10:59:49 +0100
Message-ID: <87ms2hal4a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> There is a gotcha with qemu_log() usage in a threaded process.
> If fragments of a log message are output via qemu_log() it is
> possible for messages from two threads to get mixed up. To
> prevent this qemu_log_trylock() should be used, along with
> fprintf(f) calls.
>
> This is a subtle problem that needs to be explained in the
> API docs to ensure correct usage.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/log-for-trace.h | 17 ++++++++++++++++-
>  include/qemu/log.h           | 31 +++++++++++++++++++++++++++++++
>  rust/util/src/log.rs         |  6 ++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index f3a8791f1d..6861a1a4b7 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -29,7 +29,22 @@ static inline bool qemu_loglevel_mask(int mask)
>      return (qemu_loglevel & mask) !=3D 0;
>  }
>=20=20
> -/* main logging function */
> +/**
> + * qemu_log: report a log message
> + * @fmt: the format string for the message
> + * @...: the format string arguments
> + *
> + * This will emit a log message to the current output stream.
> + *
> + * The @fmt string should normally represent a complete line
> + * of text, and thus end with a newline character.

Note for later: "should normally".

> + *
> + * While it is possible to incrementally output fragments of
> + * a complete line using qemu_log, this is inefficient and
> + * races with other threads. For outputting fragments it is
> + * strongly preferred to use the qemu_log_trylock() method
> + * combined with fprintf().
> + */
>  void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
>=20=20
>  #endif
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 7effba4da4..e9d3c6806b 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -41,7 +41,38 @@ bool qemu_log_separate(void);
>=20=20
>  /* Lock/unlock output. */
>=20=20
> +/**
> + * Acquires a lock on the current log output stream.
> + * The returned FILE object should be used with the
> + * fprintf() function to output the log message, and
> + * then qemu_log_unlock() called to release the lock.
> + *
> + * The primary use case is to be able to incrementally
> + * output fragments of a complete log message in an
> + * efficient and race free manner.
> + *
> + * The simpler qemu_log() method must only be used
> + * to output complete log messages.

"must".

> + *
> + * A typical usage pattern would be
> + *
> + *    FILE *f =3D qemu_log_trylock()
> + *
> + *    fprintf(f, "Something ");
> + *    fprintf(f, "Something ");
> + *    fprintf(f, "Something ");
> + *    fprintf(f, "The end\n");
> + *
> + *    qemu_log_unlock(f);
> + *
> + * Returns: the current FILE if available, NULL on error
> + */
>  FILE *qemu_log_trylock(void) G_GNUC_WARN_UNUSED_RESULT;
> +
> +/**
> + * Releases the lock on the log output, previously
> + * acquired by qemu_log_trylock().
> + */
>  void qemu_log_unlock(FILE *fd);
>=20=20
>  /* Logging functions: */
> diff --git a/rust/util/src/log.rs b/rust/util/src/log.rs
> index 0a4bc4249a..6a3a30d8d8 100644
> --- a/rust/util/src/log.rs
> +++ b/rust/util/src/log.rs
> @@ -134,6 +134,12 @@ fn drop(&mut self) {
>  ///     "Address 0x{:x} out of range",
>  ///     error_address,
>  /// );
> +///
> +/// The `log_mask_ln` macro should only be used for emitting complete

"should only".

> +/// log messages. Where it is required to incrementally output string
> +/// fragments to construct a complete message, `LogGuard::new()` should
> +/// be directly used in combination with `writeln()` to avoid output
> +/// races with other QEMU threads.
>  /// ```
>  #[macro_export]
>  macro_rules! log_mask_ln {

"Should normally" suggests there are exceptions.

"Should only" does not.

"Must" is a bit stronger still.

Which of the three do we want?


