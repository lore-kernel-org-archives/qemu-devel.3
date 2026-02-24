Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3240E9B251
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqF1-0001qH-BN; Tue, 24 Feb 2026 06:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEw-0001gx-0W
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:07 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqEu-0006nN-BO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:05 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-5033387c80aso83651871cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:06:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931162; cv=none;
 d=google.com; s=arc-20240605;
 b=kk+uQBbGFulX0OVuIJ2BxwBuc1ARlSV/zAA2ZoZaGM+KD83wZwsqa46zCi2mqrjnc1
 TAHw1PI5DKB/qX+eIzbd/1OH4oOo8tu+PGBNw5w2m95JlwugkgEAlrMkJXyoWjcEFwCr
 zkWEyyLjVNCE/JiB+aUBhpitBiUYueZyAzcu0zmq45mUwVQMyuOtrVqNkIN4ip6Zgy4x
 /mTSJYYPzpe82QGBaUl5OShxYSPlWbOJbMz3+3SNaphAIFlmDwM1ZHc+b297JyKpu8ZJ
 k6+l2T0jbSFXigjVXDIWy+6/5wlp86O/5125bt61VW0894S8XGg4Ls0PyLKr+jFPokna
 WpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YdScLTIZ/3JZgbhsowERbAcaVxST5hmbDGoz6g+Ir7s=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=Lx2jsBtBhYSvoQXc8zfMX+KF4YKWQU2j6cUggI92LOuOd7BYFlVr5YKkpQhZI4sy1x
 fh6InU0dYDKgTyhtUGwcjh6fRo4euRGD86raM4svu3LegnRI9fTVf9EqyVlyRKe4vMwx
 XqdxNUQMZj6+WRH2PrLjjvc+1r5XiRF3m6mlBsvxXhlnwxQIh26uPSAC/7YnDtlaURQf
 B6MRDbnxQbMIv0bPedtyfFPR1KkNjg9BDAc9tYc7nSYnmU8J5grEpkZgLeQgIwjrUAFX
 juo5KdHRRxycA5JdXeBbtBOuqJc3m9Mczg6YSIYmi8c9rryHf+O3xHuaEjUX29XekPVv
 NFig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931162; x=1772535962; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdScLTIZ/3JZgbhsowERbAcaVxST5hmbDGoz6g+Ir7s=;
 b=ho5u3hVzCKiaatb7/ZBcpZ/NXNQ8p/kajzfLT8O1LKFAipNf3IUdFXtKZIORhiL0Ri
 U26rxlqpu4Jyw2hio/CoUMYeiVfCGWO8b1GZk5E+jCpnT1zq+M5SDU+Z6DVqVPOBa+vg
 xWuUc0VtHQoQ2BGRLllMyfV7jTvzKHI1LPzfpmGJfwUigCKMK/J8bEEYuvmrP8cSuyzv
 URN46uF8YyrfuThu9N6SDet8agAoce9Zkq0Eh6h7CQf/4l3gW+BAAPGiqSs3sX5PafMv
 hSszLmJ0d/qW/pmt8xqtqKxzcn5mZgoB5PwZPbhxaSbHvIqHrlyC7e2ApoyCg+Nlzv86
 jWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931162; x=1772535962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YdScLTIZ/3JZgbhsowERbAcaVxST5hmbDGoz6g+Ir7s=;
 b=Nxdp18d7S6VxlszJWYwR8X0oqwibXHW57kBzjUZqLgLnLFZkquCRqCL7rx/BvnnEfQ
 99PPjkhpqCKM1ChthO/S7j2CPXAi/oegcxXga8O5hdsqwhYdep+LX8LLe8li+hwZ2Ifo
 G5LhibabOTp+XgZR0BgJrfpQailgHVe0riy2WE3v/muCK/jtfmTkpxIg9WOSTIoLvyL7
 Y5twvWpLPiboCQJPESWKDNvKDH3jl98MDi/UPSLGoxIpL4JeQNnR/66l0LN3Xqi/xzXU
 9sl7TR6My86IYEs7mdWM2H6GRtfKczsANhPbGZkzwBKwbUY9o3apiGleAun8d/YYjU+R
 TNAA==
X-Gm-Message-State: AOJu0YwjZjG9PHRULAhGqWpElkClsThrAii7+ex52PiD6/+yv9fWXTm+
 d3La27kdjlFZihsThcKJl8NswnL17DYAd1YiIfmK1EEYlesXy9ZETZU4VEGnmnRRr5nyYV62Fi8
 mXyWQ94Vj/MAsBrYCt1RkxVYPMWBjAHY=
X-Gm-Gg: AZuq6aK6oLYtsN3y3NjRURM/UJEhe1PGhLQEdyqE4Kk9orbpujNfT3lr5eMDzjWeWBL
 EuItiMPy2N8dcitAzhBt1hL9S9HOFynRref7p2Hj7jJMYB29wXjJ+pAUkC2euWGud+NC4REVW37
 4+uAJF1nxI6EFGTWg/bdi7fLcvSumrW6uDuY1Mc9jajXek/18imibmuaped43jVJMAZGz737DBW
 teVz487N1zR9+mDWohDmdaKv3W65GQJpKvifqsqxSbQFregGR3QdfRZhBGzxriZ8s3cwigoi8g1
 42kwdm8=
X-Received: by 2002:a05:622a:409:b0:501:40b2:453d with SMTP id
 d75a77b69052e-5070c2bec64mr133246341cf.23.1771931162232; Tue, 24 Feb 2026
 03:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-4-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-4-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:05:50 +0100
X-Gm-Features: AaiRm53BgT4SD12Z3hn_-iWYEV90YkAwRO-IawU2Pq_ur-vZ5ftIm2-cz7DVimc
Message-ID: <CAJ+F1CKvBQ4DGAXW16KU9gP5Vo4Y2DJGOqaEE6L_D6Hd8wDFzA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] tests/qtest: remove -audio none when configured
 with --disable-audio
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Feb 23, 2026 at 9:27=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> It does not matter much whether `-audio none` is passed. In the future,
> support for `-audio none` with `--disable-audio` will be dropped, so we
> should remove it beforehand.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Tbh, I feel like we could still allow "-audio none" for compatibility
reasons, even if compiled without CONFIG_AUDIO. But "-audio none" does
not mean "no audio"! it's actually the "none" backend, so better to
remove "-audio" altogether indeed. It may be worth explaining that in
the commit message.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




> ---
>  tests/qtest/libqtest.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 794d870085..adb968f40e 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -464,7 +464,9 @@ gchar *qtest_qemu_args(const char *extra_args)
>                        "-chardev socket,path=3D%s,id=3Dchar0 "
>                        "-mon chardev=3Dchar0,mode=3Dcontrol "
>                        "-display none "
> +#ifdef CONFIG_AUDIO
>                        "-audio none "
> +#endif
>                        "%s"
>                        "%s"
>                        " -accel qtest",
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

