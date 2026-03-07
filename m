Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8A3FC9EF9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 13:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyrN6-0000CN-Vu; Sat, 07 Mar 2026 08:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vyrN0-0000Bm-E9
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 08:07:02 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vyrMy-0005Io-D7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 08:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=z0Zs7AhbqosNKjbAXXNlgKT5J/ywJbNhMxXGbJo/3cM=; b=c+nosCPuxTVWbOUZZrWqORbUmv
 6yLOd7bP7RUOBmrCLfkz0cjICv2OWfHHxJvxtuWhRKkb6Ttb3HCWeas/4Kqd5yTaIEJs3byWwlEoV
 bSMSuABNzqXra7ktLcDyrYwNnBPT71KG/R3Z3pyJJfxUlD3zDWvpS+KjmQfQo6DK6cuw2tExVi8Dp
 l0qUUcV22QfBuFSwOUDx/V98Ld+LGGP8PSFQTscKQZmswGuYvjZzqFc520D700aDtR3OAQXhJjYRH
 ZC0eLQbqQI1iSnz8Vmk3LQUqtYOwRF19YLhCGzcHoQBmzsX/+KP5lkE+RW/FUhwNBgGpT0ZvDc14Q
 VZQke3Z5gcgH9abavxXBeaCZjZ4SSjg32EoSQq/DwY6reZTxoiU50VWT4fdnxd/CIZE8HOecUc5B+
 cyx0jk1YqrYz+UX6G4khjPXOEwXZG694BrGgOgNYwciOXc596M1A5hDQqXMval5CBs34IaDKf+cTb
 dWD2EhovNu1MlENYgAJxosVQbHTkNYWX8jeXglKKPdaf1gFEvGASIobyq73PPn8k7SDEk7L7vr+Xs
 IHys4/qQUKo1k+jJ7y8Zu9UKu1QWnLA892ArIJbHtWmXsaqrt08lmswLuroLMlNkLSIv8h/RIWD39
 IS60rryhrzJGF2p4OTqjiBHlwr1QS8TASCyW57BUo=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Daniel P =?UTF-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH] audio: Fix macOS JACK Audio Connection Kit
Date: Sat, 07 Mar 2026 14:06:50 +0100
Message-ID: <5083100.31r3eYUQgx@weasel>
In-Reply-To: <20260307114923.75394-1-philmd@linaro.org>
References: <20260307114923.75394-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Saturday, 7 March 2026 12:49:23 CET Philippe Mathieu-Daud=C3=A9 wrote:
> Since commit 8f68a33ad46 we get on macOS:
>=20
>   Audio backends
>     CoreAudio support               : YES
>     PipeWire support                : NO
>     JACK support                    : YES 1.9.22
>=20
>   ../audio/jackaudio.c:654:12: error: unused function 'qjack_thread_creat=
or'
> [-Werror,-Wunused-function] 654 | static int
> qjack_thread_creator(jack_native_thread_t *thread,
>         |            ^~~~~~~~~~~~~~~~~~~~
>=20
> This is simply due to a missing #ifdef'ry change. Update
> so we can use the new qemu_thread_set_name() exposed by
> commit 46255cc2be9.
>=20
> Fixes: 8f68a33ad46 ("audio: make jackaudio use qemu_thread_set_name")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Nit: the commit title could have been a bit more precise, e.g. fix use of
qjack_thread_creator() on macOS.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  audio/jackaudio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index be6fb378f72..589aecede9a 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -712,7 +712,7 @@ static const TypeInfo audio_types[] =3D {
>  static void __attribute__((__constructor__)) audio_jack_init(void)
>  {
>      qemu_mutex_init(&qjack_shutdown_lock);
> -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +#if !defined(WIN32)
>      jack_set_thread_creator(qjack_thread_creator);
>  #endif
>      jack_set_error_function(qjack_error);



