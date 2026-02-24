Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38338E9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqFI-0001zE-Ui; Tue, 24 Feb 2026 06:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqFH-0001z2-VY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:27 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqFE-0006p0-TG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:27 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-506a1b23c05so67978931cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931183; cv=none;
 d=google.com; s=arc-20240605;
 b=emHH0bDo4p4pgVmndEPia81QFlq7anVuT7sGIeW5PJEyzirQWvneHwX4Vl6dlDmn3q
 XJonhntBzjAvb2Q6b9+sqOZROgeh4Uqw+BT2GpmCuETNr1weZmtqi7rl3zuH4+/lrZ9R
 +sD0D+yvOyErM0EXZHahmqo2JPCkogk346lApKQLdudhEpFN/AQA4mfhH6p2JWlsRX4h
 gpx0bNsnhN0vaILlMq4rQdFo/CnPOd0rzjJfHYqKuBjBZuX3ey+EYiU/yiZTpccTzV5D
 GE/5y3QDP61L4yiYWvB6qXxfuI0NAZDBTraD+y0zpcPTcVEHgcZ2j0E4upzc9czn5u2K
 pW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NOWds3IlB7Fg0rqYWHR9pYHCZ8zjUuHpShVmAvzvFx0=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=iRhJmMN3rKCNDjJ6r2+bG71KO5fAqWnpgq1l70q24Gc17sXCYEM3plhX0RGVP7coOX
 nSXpmyDvfMJTKztp32TtDI0NjHpdEuht/chYHRCMEm+pnCvub3HIyik0+/AO3nuIt0xB
 u9MYQQsqfwzBFpXBolQ8dM597WKnMXTIZkYmbRXLsH9NpKLrxg1jR/5Rt5wgW+NuNDJN
 3SrChxdlM/GmhoK5FlHWBBuMAprxD6dkACCVQgsXx2weiltO+RZIqz4bYFvbkBweyUJE
 H0fZDQB1etw7j4GIyOWupBnVQBP3m0J7Nj29tDqDhxzd6O9U531KK69T5JSxeuiqgU1S
 BP6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931183; x=1772535983; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOWds3IlB7Fg0rqYWHR9pYHCZ8zjUuHpShVmAvzvFx0=;
 b=lVG5puymNNYxWbB7BT4Ev9MuGMR+19yaw69yI5m0mATO1kcZwxkabchZml75ukCQXp
 nnibFkxPp5uBr3o9mEazhSFcUYiAmUH9YW7cnS2uyVDTh19B5OtgPIubEySs7s3+YJJH
 GWRzpRIbeZVeoHBsraz/JWfWt1y4XcofH5GAHb9E34CpkFjL2nIxYp2rc2SXcq590CUV
 3lQDO1IrjjHLi2t4pEi6IQ2IxlFvTOduV4wTWO/ZqFhJgkUsE1oM/cfdyqzaNwQUsG22
 DxZ5rWQBHjXtNvkZKbC4cBmF9kVEkHIbVErDOL/xAojmhEBKcZVBFScCjv0w1P+TjCjp
 opdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931183; x=1772535983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NOWds3IlB7Fg0rqYWHR9pYHCZ8zjUuHpShVmAvzvFx0=;
 b=J6KwDACf5V2c3cNMzL4Z/uNfBsI/PqoQ2kyfwn+eJLmL1Hz3cSxOA1NRoLwIpEeCr2
 gpABEqE0Kq26pEbasptsO1eS96EoIyZgl+ZfNKtwWFaC7RKHSC/Aw5nwwhdc+ZFxoPdt
 WrxnLOWhV1k1WqNFE7xAOw599TuBkaxVJEXBN58DstdCX1NegHWwsXrBn8vgwjAN7TU9
 +ptPsSBMqxviBtEWWQD6wyUvxS9HvTs4NIs6VD8nOpDuKbWWM8N98tGfQ9Vo3g6wbNQc
 FI3oLdboEho5hbvdgSNhGB/al/3P+16baLNuf0eWZqa7wkX0YCnRzq2m5d11nnVAuz1L
 LGdw==
X-Gm-Message-State: AOJu0YyhBs2sPEyaIU6HJk2I/6yCrOSRvLFbEkzlObja1nVzOsyOh5R9
 OI2/6YJLFVOc4oQ1H6PaT6MAzbjnGb9am6w62LxvKK+FY51jY3JdZUnrgFsn2Om49UVHxjAF4Vw
 fpjDKBl6RHoPTneZ2j8ndxBXRC0pgiB4=
X-Gm-Gg: AZuq6aLjPzT8wawzrwBGNa3b9DxKdzKwqSCbmlIXVKAWXFB+P4ClIb2xTBJcIN/SvGt
 esjuHZlBySoJzPBVgHsHwoQMGQbw6chB3fpLqi6MwkCL2uJIog3EQILHw3CRGA5HMeHsnNncTie
 QzoPdornfpD1pUnPJ1TVPyYAki6fCWWF6Vp/GYHDo1/h28xsH1PfgwOemBQE7Mnh/3XRmac6cwU
 LJXbSYyB7BuZpgH5dNpLwauJOXEr2VQa7HDJklKPtxADtp8R0DJCzmyU1ENWR4mSMymaXfh47bz
 /cSBwCs=
X-Received: by 2002:a05:622a:4cc:b0:4ef:db28:1f3b with SMTP id
 d75a77b69052e-5070bbc0f34mr164850161cf.16.1771931183662; Tue, 24 Feb 2026
 03:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-8-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-8-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:06:12 +0100
X-Gm-Features: AaiRm53SoB0TWjWFsrqdjv2Vm9e5CSOa2pCblIbCdy8QG6qcJMTQn2syLjRGEZc
Message-ID: <CAJ+F1C+Zb-KRBf+bFv2FbVx6Q5P4rKumTZRJ68VC65ZVVWKKNQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] ui/dbus: run without Audio interface when audio
 is disabled
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

On Mon, Feb 23, 2026 at 9:26=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> D-Bus display can be used even when QEMU is configured with
> `--disable-audio`. In that case, audio interface will not be available
> on `/org/qemu/Display1/Audio`.
>

I think it should also disable "audiodev" (from QAPI DisplayDBus etc).
Or at the minimum, it should return an error if the option is given
and qemu is compiled with !CONFIG_AUDIO.


> (The current handling of the situation when audio is enabled but
> no D-Bus-compatible audio backend is available is different and
> hasn=E2=80=99t been changed.)
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>  ui/dbus.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ui/dbus.c b/ui/dbus.c
> index 905ee6fea7..60c8e0b473 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -219,6 +219,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp=
)
>          return;
>      }
>
> +#ifdef CONFIG_AUDIO
>      {
>          AudioBackend *audio_be =3D audio_get_default_audio_be(NULL);
>          if (audio_be && !audio_be_can_set_dbus_server(audio_be)) {
> @@ -234,6 +235,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp=
)
>              return;
>          }
>      }
> +#endif
>
>      consoles =3D g_array_new(FALSE, FALSE, sizeof(guint32));
>      for (idx =3D 0;; idx++) {
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

