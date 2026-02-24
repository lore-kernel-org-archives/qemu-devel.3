Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B53EE9B252
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqFE-0001ye-A3; Tue, 24 Feb 2026 06:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqFD-0001yU-48
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:23 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqFB-0006oj-8J
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:22 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-506362ac5f7so51270601cf.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:06:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931180; cv=none;
 d=google.com; s=arc-20240605;
 b=LSVZjpdp6IpHvDAIWh5pS6b/f0GOeJybwmCx0ekt7JYYZBV6JbGY3qNa+eLmPeLRJh
 PRdqzff68x3cvQSrMHmNh85dB6nZUY1Fr/L8k9wXux7h0qdaF6RjLp+fMEg0A78AWVwF
 P5KyieKh3R/LBv2tsr3KSYsNJTG3n97AloAJeAlTMjoDOLwzSkYXsO4DrBu0J2mng+n3
 1GsQaTyDD3s0GHFiyhK12bgxws3eN9FmT1ibSM+qu1O5y05VN6q2mkxZ60Xj4m1RDp2o
 YLKddnK8K5HfCKggHe0v/5HFglpepLcj5Quwy/SbGteLabzHrp9qEzDbor4cNIWXHU2z
 8I3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=llM8BMJTZ2LJS55vlb9PVdT1AaBy2qzrnMukAbcKzSk=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=lWyFRqMcpW1BpVORm2+zS35I81fKZQVwBCIlJ87xUDYS3dixVDO9i1vE98m1EdcjKI
 xfMoJK6ZjkLFwTXHId+7aKE7YDOTZ3ImHNF/90SkllIRGjkQVPBv7UIATdIr8AE6i0pY
 aDF7DNdOaWsjNSf8Nuxh4D+nAPgSjxnJ+oLT2Ypw3s9WiLUy64cwYZ6sNo58sQdjvAly
 T4nRWzzKAsYlpR2rquor0EFKKYNovVAxueoDz2ACt8j1FdIWQX8x/NY/sxHouhU0lzPY
 poaSKJiHcCClSINgxm1Y/Ur8WhB96w8/P7kFA7yLy1KZUJkkttobJzs3QaX6kKlvT+qX
 Dhzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931180; x=1772535980; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llM8BMJTZ2LJS55vlb9PVdT1AaBy2qzrnMukAbcKzSk=;
 b=ZhdnhBi7z8vGfetR67Q5RDoDxx3faMeY6fnTzlgLUxuII87UlvQx6kiw70adfecOBY
 OhhirW0IXBK81Z8wt4IIFA6dtOATPitOh5Bo0MZxIPRIHlPY8my0y0kdCxFx0qVue4ov
 /blfSpuhxWbHsldZzMRCUWbOJR1enW+s5TB0pHONdt+IqDKDdj18Ax3yv5TLdzYC9wzY
 I6yIAWFZF0B0+kJ8wANiS18Ip59Z2opmU1cB36kZkJXBx1CoO5MyXxJFrKiauxkqsEuc
 0ze0pbso7t/ifw6QQEcle32s3S4PD8E+qKoPEOQ/d3WvDhFkesTiZjvXak3mxRHpWLXM
 wOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931180; x=1772535980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=llM8BMJTZ2LJS55vlb9PVdT1AaBy2qzrnMukAbcKzSk=;
 b=nPaQHeEMO9m5KM9SDFPq0CONQFS+G02EjpnNTUpSav7quFq7uzvdkaeqQF8ER0TNvz
 AWSvBChDiZ8SpIeP5Ma/FF7SVhJdRrNuEbcFz4n+AJAmJzbT0d0nals5IjtVlj6QIq3U
 E6avnynM+gvLYbfZ/V5QvSV4c0jlBzCoilGISjCsnS1zUaBYhri77U5TzsVuQIqaO9UN
 atYj5F1wEbhlRjAooo8/logTgL0+evO99Oz05MvYXWcqtLtE4RV6T7/ZKXrx5vjPiZBy
 MNaIpdLiuaf48eM3sXqVjMMAqNC5/G2zz8WE5RSNk5xwXEtuofyd+qaGgUN3uwSltCFF
 UvAQ==
X-Gm-Message-State: AOJu0YzhTsfpqDYGWZOOSGIS8VoZm60HKDTv42EqVhGD3zLLJEh0plEz
 oyPsvuCas4PHvIxCJjkJaItgG2J1cIJMp2uvzYBJqLMgPZvQB6v7G+zm7QGHOGAJ+c9puB+E9JW
 mu4OX6kjsokWUWeUg0KpKIAq58kDOsu8=
X-Gm-Gg: AZuq6aKF+5kLlO4IGfHRr2L0zxcJ+sEPLpJaN8QpNHTWA8BI0sY/8y4MjqcYlCUaCWs
 e1PekKp6TPFi6O/FTP71BsmLVVgukErNkyRwl4ItzkjsTZnjxMm/FgpV4Vv/nTvxaedrUlpNUZH
 sQJvXcy1J5PECO+HsLequCFwzmZBh1ZqniAvJkLd/LdICV74DUNAzeGy6Ulpj7fJcxqFIr+OUSL
 G4vcYARXl10CtAKaLprfC/AmYzotCN6SyzJuT+H8pCMAcL61YWsK+8p3mZd8QTrcIIb2LWzFB/3
 ANHqcELTp0aIVJ0WKw==
X-Received: by 2002:a05:622a:24d:b0:503:2f21:6355 with SMTP id
 d75a77b69052e-5070bc0885emr166075611cf.34.1771931180012; Tue, 24 Feb 2026
 03:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-7-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-7-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:06:07 +0100
X-Gm-Features: AaiRm511W3vr8x0XSlp8IBpSrl18ksiA2_tJ6Gwm73Wq8f58PhQ8sGSZqNXhHF4
Message-ID: <CAJ+F1CKEjT741GHZP5HJSKYSW93K7iROmAiVS-oPJmL+J3Bujw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] system/vl: remove audio and audiodev options
 when audio is disabled
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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
> Remove the audio and audiodev runtime options when QEMU is configured
> with `--disable-audio`.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

This change should also modify qemu-options.hx


> ---
>  system/vl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/system/vl.c b/system/vl.c
> index 3e341142a0..1034a4688f 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2248,7 +2248,9 @@ static int global_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
>  static bool is_qemuopts_group(const char *group)
>  {
>      if (g_str_equal(group, "object") ||
> +#ifdef CONFIG_AUDIO
>          g_str_equal(group, "audiodev") ||
> +#endif
>          g_str_equal(group, "machine") ||
>          g_str_equal(group, "smp-opts") ||
>          g_str_equal(group, "boot-opts")) {
> @@ -2265,6 +2267,7 @@ static void qemu_record_config_group(const char *gr=
oup, QDict *dict,
>          object_option_add_visitor(v);
>          visit_free(v);
>
> +#ifdef CONFIG_AUDIO
>      } else if (g_str_equal(group, "audiodev")) {
>          Audiodev *dev =3D NULL;
>          Visitor *v =3D qobject_input_visitor_new_keyval(QOBJECT(dict));
> @@ -2272,6 +2275,7 @@ static void qemu_record_config_group(const char *gr=
oup, QDict *dict,
>              audio_add_audiodev(dev);
>          }
>          visit_free(v);
> +#endif
>
>      } else if (g_str_equal(group, "machine")) {
>          /*
> @@ -3057,6 +3061,7 @@ void qemu_init(int argc, char **argv)
>                  }
>                  break;
>  #endif
> +#ifdef CONFIG_AUDIO
>              case QEMU_OPTION_audiodev:
>                  default_audio =3D 0;
>                  audio_parse_option(optarg);
> @@ -3097,6 +3102,7 @@ void qemu_init(int argc, char **argv)
>                  }
>                  break;
>              }
> +#endif
>              case QEMU_OPTION_h:
>                  help(0);
>                  break;
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

