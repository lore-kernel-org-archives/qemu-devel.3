Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCBDE9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqF8-0001y4-Jd; Tue, 24 Feb 2026 06:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqF6-0001xb-Va
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:17 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqF5-0006o2-9N
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:16 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-5069df1d711so50087481cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:06:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931174; cv=none;
 d=google.com; s=arc-20240605;
 b=Wy6bayofaEyN32H+3igUG0hTUx9lblWeNqlivOR1fblfwxSEDgXSJJM+uonX3mxkch
 FLu3RVj++4NQxbTj7TM3DHpRWW4f1H7NEt9lPL/n5bMJI2LEbr1eYHd8n7L+zd3pbxks
 ZWY2789RO56a0hPW3QlCQ9RO+b5h6/MDt29y9EW1ACI/LzTYP5BFxwXThKN5mczAfHSi
 FiyH7t2UcM28YLuQMZxSqJYb5GUwVEj3KkeAaKUU5eayaaQT/R9vNXrRkbzVUwu38TlD
 7gP0aC8te5CaNtDE8XrdDqIRziSDwQhNgd7r3iqs9ychsbX3kBtPF0p8UbVORLF1nT75
 jFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fjtg5GykKdCSYGjDCH7xqhFmVDdw6OqgB6OS94jZio8=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=fr36/dqgIDil1EJpNwKuxLb8dzBvA+iPQm9/LdeUU7B7bBcIQWVDbPPTY8DEc9w7Xy
 zNI7kFnWXrMf/lpeNFhVApjOb61YvFit0K+sKXU2WOIwXNLya6GFLS8A7tNvi+WG7tVR
 hEncRZRGJfrAls8ZRbV9Cgjpn5FFDamA0YoJS5mvEei6KAYyMJ/F27MDiV3vh6byqmc9
 ar4pWF9IUaVdjsT4GXmIJkbUJc/W04mkPcJXwRBURxJwy+WpcZZfwEs0nCZCoCKbuWLo
 CI87AGNFE27ZGyP0xkopHSe45yN5QY1uskKZgH4eOPieZOwHf4argGpCpCNPVmBqLDsG
 Metw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931174; x=1772535974; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjtg5GykKdCSYGjDCH7xqhFmVDdw6OqgB6OS94jZio8=;
 b=ez7LsNW7NrsBq5ehS2ROrDYcHqHdILGEOBEVSyeiNjGEEmiDxAlH0smXw13OYaphF2
 OTaTMcHAqB3RN2qAjVxOlfEnu4+NRLJcN3MQmk4sGZ6pYBiuz0mnnfCFs4Bg4xMc/yQu
 pNtCxAImcO6RbOg67IK7T/EpbgPe4XufBg+2LZxEOI/ptk0ns4s7d52STWLZxhG5cFul
 F/VaJJ140t+KORNKHvfcVY9/Q7VpEh1NJ8zDUvYxS5XD3XDbRhqrOiegP+DZZS0YcFpm
 tjTdZPwtaMhbmlci3nJEVM4J3CRCQ+KYGhveIDqHw2Ie74SQkQnxvKn0U+0M714YCiSa
 wXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931174; x=1772535974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjtg5GykKdCSYGjDCH7xqhFmVDdw6OqgB6OS94jZio8=;
 b=JpRff2Tc6BuPwVyLpt2DxaxC1Z9zzxcgNtIYHVcckO1vzmQlnxX8QurrAMjGU5q2LD
 hcfn6eEBLAraMtKjzr1qNaZ9vq9mWkh1joOGCN0RhFcdpjknzOksAmZoI0kk7cd0mRVa
 8TglJpyNqXBrw4T25sWw96Fzg7YOnNL+dT7mgScwUI1Jedd9Ljb0qzTRyum2KYn0xokt
 KrMOtVxmRkV/LvJnLTpa2ZzUZczJf9oBb931aInDxcAu/7gL80j24gJmNJy4+kxol/2R
 2sjvHJ3SWDdzXQT4rcv6k0bT48NEHQ8NBqTuKLsTvEnvPedF7FDU+SiFJ4thjLzY6frf
 KCSw==
X-Gm-Message-State: AOJu0YzngERzU47c70AUtENNaC2Iwvxc2hQj6Nc5nNwGahKGD4EWBopc
 93swIhnQL7ieeieV7k59VHQ7jRuIdlLY5noe62jFJcCj+KSH3bcsOJhUPbhyQl1AOIllYithQuO
 QP412ZsF0m6pogtEFrVouWL+n0vV0IyI=
X-Gm-Gg: AZuq6aLleZ3BvJrUl6aHHi1vA1Y63JgD2u7ov5zYSBg6P5MBhN7rXx1h6oe9TDNGiM0
 3StYK1C8nSIcPoYRMajKYokMKMlHKrh1bimR+D6RSCN8WrlxSYlhUGw9nqYpysFToYa24300RQW
 mTp6egWJZHkwRu37ck7bPAtLASwMLMPAAoY4Yk7nFWrZQoNfw0zOOgahbIVX12w/jXCl5dvCqX2
 V0FBlU7BCyAGXewCn7pbHRHqkLttSPTbdGag73azHLbVyqTlF0auN970pkqzAFMcmJqDJx686wl
 3vb4Gp8=
X-Received: by 2002:ac8:5fd5:0:b0:4ff:8754:eec2 with SMTP id
 d75a77b69052e-5070bc4b73amr164464161cf.40.1771931174137; Tue, 24 Feb 2026
 03:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-6-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-6-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:06:02 +0100
X-Gm-Features: AaiRm51FO2wRA7crgPgXcKFtkOtTgBl3mFAxJDybc2Tzptvbqa4dkEvv5CU2TGw
Message-ID: <CAJ+F1C+1fbJ+CC5Ltu00D60qG=e=_jM+wsM1K6DHyRXe703oQQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] Kconfig: add AUDIO dependency to audio-related
 devices
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
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 23, 2026 at 9:26=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> The idea of the `--disable-audio` option is to stop building audio-relate=
d
> source files. Although this is not yet implemented, we can already make
> the existing AUDIO Kconfig option a dependency for a number of devices so
> that the build does not break when we remove `audio/` and other sources.
>
> Note that some machines have embedded audio devices and therefore cannot
> be used with `--disable-audio` at all. `-audio none` should be used for
> such machines if audio needs to be muted.
>
> The only device that is purposefully not included in this patch is PCSPK
> (PC speaker), because its code has already been modified to work with
> `--disable-audio`.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/audio/Kconfig | 21 ++++++++++++---------
>  hw/usb/Kconfig   |  2 +-
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index daf060e1be..0479818e3f 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -1,37 +1,37 @@
>  config SB16
>      bool
>      default y
> -    depends on ISA_BUS
> +    depends on ISA_BUS && AUDIO
>
>  config ES1370
>      bool
>      default y if PCI_DEVICES
> -    depends on PCI
> +    depends on PCI && AUDIO
>
>  config AC97
>      bool
>      default y if PCI_DEVICES
> -    depends on PCI
> +    depends on PCI && AUDIO
>
>  config ADLIB
>      bool
>      default y
> -    depends on ISA_BUS
> +    depends on ISA_BUS && AUDIO
>
>  config GUS
>      bool
>      default y
> -    depends on ISA_BUS
> +    depends on ISA_BUS && AUDIO
>
>  config CS4231A
>      bool
>      default y
> -    depends on ISA_BUS
> +    depends on ISA_BUS && AUDIO
>
>  config HDA
>      bool
>      default y if PCI_DEVICES
> -    depends on PCI
> +    depends on PCI && AUDIO
>
>  config PCSPK
>      bool
> @@ -40,18 +40,21 @@ config PCSPK
>
>  config WM8750
>      bool
> -    depends on I2C
> +    depends on I2C && AUDIO
>
>  config PL041
>      bool
> +    depends on AUDIO
>
>  config CS4231
>      bool
> +    depends on AUDIO
>
>  config ASC
>      bool
> +    depends on AUDIO
>
>  config VIRTIO_SND
>      bool
>      default y
> -    depends on VIRTIO
> +    depends on VIRTIO && AUDIO
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index de95686720..e370585892 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -98,7 +98,7 @@ config USB_STORAGE_UAS
>  config USB_AUDIO
>      bool
>      default y
> -    depends on USB
> +    depends on USB && AUDIO
>
>  config USB_SERIAL
>      bool
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

