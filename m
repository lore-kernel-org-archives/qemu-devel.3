Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EC2CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPwb-0002Ez-K1; Fri, 05 Jun 2026 04:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wVPwY-0002Ek-OK
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:30:18 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wVPwW-0006aa-S0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:30:18 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso2831322eec.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 01:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780648214; cv=none;
 d=google.com; s=arc-20240605;
 b=OGSi9FnWES7nWhL+yq+iRCWMM+pqP20+uG1vb90Pgrp2elxp4LN3gzkA2wQMIV6N7w
 7T36JR8Qrw5h6qJFyhC5GR0BPZb4QLWQf7KThN/DTBslEin+Dsptu3VzflBsapBGUri9
 iEU1pF+p89IDOqSuRlUaN8si5sHA6994UF7l6MEA4SzcYy+gptVIlx7PnSlXIWmg5cLV
 0x9xXOnBdPA0ho4jP924jRaodmcuPU/cvyMJRMrmwtRRADccb4A1ea6xaYR7Mco8ogOc
 8dq3uBvQYOx8OUiEJ8kzzRauguAZMl7hzyTXIBZeRzDVuFzUCJYNC87R1tPoyENvHQF/
 FEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gug/6neEE3H7MJPsoEVfLFTA/OYfPi0vxIgu6Xly6KY=;
 fh=HeCjC7wjcae/jEorhX/Uph6IOJ9PtkUbUvjv0IqhXQU=;
 b=JU3q1WtogqwPCrl4icf16NpIFvkLTLRcsrYdQTZkqbLEaaPGs16yePCC/ho6i+1bZh
 C0hCOJLzbH1rCEXQ9QzGSnrqtG3EmAoN7VA5UJMzKYlf5y4RikcCgfkiR/mykEZgLWep
 ywkjsl6nwGtuYJ8uXQXAm+PNTtcriYHQROsA8iFOgvLZ2CoqkQkp/q2mQRx9qB0uixdN
 sdXgelDjvOqrlkhmmL6NBJKcjWvFx7WmNyb/bsNPJPc/LOL5ZtfYAJT7VvKiTWJkglza
 XUzMjlOzWCQDpc9wAPDUqCQYQDu0HPTT6+vSYkskee0DWDkXOeqsOgm8UUQW/yy5/onF
 LJNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780648214; x=1781253014; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gug/6neEE3H7MJPsoEVfLFTA/OYfPi0vxIgu6Xly6KY=;
 b=bjPPMcQHI13Q4LLr1wavBXvtOnJ3U6T9hEEvV0OuAtaCwLVvrS6Z6jBRWLN8y6Llfp
 FdJ6Y0CANr8O2/drIlPlr6KCJ/yRBll9dIRPbK0QhoqD0P6xqZ0ErZDCNHjyd2V8YQhR
 N+HK/vJx/mcyEmRkOorUAxVz+Rze1rLMxkdEvktVQhzDaDHhEst/OreXf97eLoqs9JAm
 C6mmWj4EQ10Ftq+Hm6tPytHEmeLix293Ieb/toPjkakZFxQwJ5NorsOavnFitxDgoJlg
 bZrVGqDVprL+4kbKR56mwC5MaYH2PyLwgNyj2Q3/tif4gDokXhbHU0B30nt+SfvHOVOU
 U9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780648214; x=1781253014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gug/6neEE3H7MJPsoEVfLFTA/OYfPi0vxIgu6Xly6KY=;
 b=rgznahnHZIAaiRrGix4MqdXH5zUTGOfpTap3hsR3uQgjBPEZoZUk2GIc1c6NwEU91Z
 jW6gpsRD2yHSH8kROBOEgzUXzSdFnzYYlc4KUEUd5c3/i1kLvzdvyywdk17d+D4LDiDn
 MdcVQsyup3qVdpYyRTC95fxzuQA2wv3Hxn3S7T+uYCwxzAwS5CMNEuoTv/maq/konwhQ
 aizVpbJTPKYR/K6HkdOpxQXDKd0r9GZVt3Q4kejvd2IGL7+jbMp7tt9xThp4dFqLyfat
 dVKLcJbxxnGMDbzxynPC4uCYpScpp4vJetxrofiD1TmxqU/NHuK1IbSXaeu4EKZPVKvz
 K6YA==
X-Gm-Message-State: AOJu0YwpgwKmnAHxGNQrogmukSgli6mA03LobG3htdQvbGwpBrQGvEFm
 XZTIiuT1kmB5V5bD+q//I07fLq0JWRJcx/5Dy6LS9ZejC7N2q7UlbvC8vLUdKI/k4/eXkFGOzy5
 jKLa1WoDys/WsOuG1q8poZ4f6oyF9hg8=
X-Gm-Gg: Acq92OECZDubKpoAlEMHrXiBIpAB6gby3sn/rSaPHKlohJc2yYWMzDvJDVNGXVPBPsF
 MAoidMWPG3OgrRdE8f6ghONFZeGdet4GVLFdIKTgBVSppiUQ/y+7t9M54sKwJJZnGhl5GCf/E2a
 NMNGCqQRosOHmkmiMa1YS6dbZkrcb2ZEhUbOgUQujgeEpDfEPZ1aeoRnwtnQAoNjUOlAOy5LDz6
 okoRraG8FBsboTgg0mvn4gD2bVV4UyJWgSCmkPv8+WfI0dekoPsg/cLgvRBEms7+jdSlqMz7Quz
 fdT43dUTO1Lgw2FDRwXRVZJJ8QdPhVg+DEdJ+8LTieVB/LfEFA==
X-Received: by 2002:a05:7301:9e41:b0:2ea:ed3e:13b7 with SMTP id
 5a478bee46e88-3077aee8674mr1145917eec.7.1780648214411; Fri, 05 Jun 2026
 01:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-5-peterx@redhat.com>
In-Reply-To: <20260604231118.1584889-5-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jun 2026 12:30:01 +0400
X-Gm-Features: AVVi8CcfXaa_G_jpC_lsddc1rbjmT_NCLtwp5738kgP78nQVkkfss3SWVkCk4P8
Message-ID: <CAJ+F1CLLOd0YUkaQifbzn5vDDh28UAv2=8Z3vpb9BNRYd-JYaQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] migration: Remove dependency to TYPE_DEVICE
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Fri, Jun 5, 2026 at 3:12=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> While doing that, we still want to keep the Property list that migration
> object used to use.  Apply them directly to ObjectClass instead of settin=
g
> them with a DeviceClass.
>
> Manually apply the two extra properties (compat properties, global
> settings) in an instance_post_init() hook, just like most of the rest
> users, see callers of object_apply_compat_props().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h |  2 +-
>  migration/migration.c | 33 +++++++++++++++++++--------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 841f49b215..8bdb8e8e6b 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -274,7 +274,7 @@ struct MigrationClass {
>
>  struct MigrationState {
>      /*< private >*/
> -    DeviceState parent_obj;
> +    Object parent_obj;
>

You need to change MigrationClass.parent_class too

>      /*< public >*/
>      QemuThread thread;
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..f9f102e78a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3966,11 +3966,9 @@ fail:
>
>  static void migration_class_init(ObjectClass *klass, const void *data)
>  {
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    dc->user_creatable =3D false;
> -    device_class_set_props_n(dc, migration_properties,
> -                             migration_properties_count);
> +    for (int i =3D 0; i < migration_properties_count; i++) {
> +        object_class_add_property(klass, &migration_properties[i]);
> +    }
>  }
>
>  static void migration_instance_finalize(Object *obj)
> @@ -4028,21 +4026,28 @@ static bool migration_object_check(MigrationState=
 *ms, Error **errp)
>      return migrate_caps_check(old_caps, ms->capabilities, errp);
>  }
>
> -static const TypeInfo migration_type =3D {
> -    .name =3D TYPE_MIGRATION,
> +static void migration_instance_post_init(Object *obj)
> +{
>      /*
> -     * NOTE: TYPE_MIGRATION is not really a device, as the object is
> -     * not created using qdev_new(), it is not attached to the qdev
> -     * device tree, and it is never realized.
> +     * Apply these properties on top of default values:
>       *
> -     * TODO: Make this TYPE_OBJECT once QOM provides something like
> -     * TYPE_DEVICE's "-global" properties.
> +     * (1) machine compat properties
> +     * (2) -global settings in cmdlines
> +     *
> +     * Need to be applied in order so (2) takes precedence over (1).
>       */
> -    .parent =3D TYPE_DEVICE,
> +    object_apply_compat_props(obj);
> +    object_apply_globals(obj);
> +}
> +
> +static const TypeInfo migration_type =3D {
> +    .name =3D TYPE_MIGRATION,
> +    .parent =3D TYPE_OBJECT,
>      .class_init =3D migration_class_init,
> -    .class_size =3D sizeof(MigrationClass),
> +    .class_size =3D sizeof(ObjectClass),

and this should still be MigrationClass

>      .instance_size =3D sizeof(MigrationState),
>      .instance_init =3D migration_instance_init,
> +    .instance_post_init =3D migration_instance_post_init,
>      .instance_finalize =3D migration_instance_finalize,
>  };
>
> --
> 2.53.0
>
>

Otherwise, the series is good to me!

