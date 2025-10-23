Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6DDCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwL7-0001hr-D5; Thu, 23 Oct 2025 10:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vBwKz-0001ce-BG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vBwKw-0001k5-1j
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761229838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92V2O/X8BX24ptskVqcVZL1ExbFKWFAN4L5ABH2A8ZY=;
 b=OLiEpeyTi0C+1uSfSebwi9bObjn4Ip8GIoGGhvDYHmkw0sMZwK8trslZr7lgAhkChGIwJ6
 lnLEp7ENlgs3FTV+Rec3D0w898jOqSF5XbKWdsaKrKI1r7Xn3zeV8no7+Q5nN4dJBfkAIx
 +5aCZWd0Obvk75I+GjAyE39YP9hgLz0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-9mmuSxSeOUOE1JZcajYXOg-1; Thu, 23 Oct 2025 10:30:35 -0400
X-MC-Unique: 9mmuSxSeOUOE1JZcajYXOg-1
X-Mimecast-MFC-AGG-ID: 9mmuSxSeOUOE1JZcajYXOg_1761229834
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-63c348b15f9so733438a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229829; x=1761834629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92V2O/X8BX24ptskVqcVZL1ExbFKWFAN4L5ABH2A8ZY=;
 b=KgwYUCQ8GDuvSVAhkCC+c7iRxyAKl47jANWmdZFn2r1cFh1bWagAXfv9Ce/aR4biYV
 B6C0kaJEADjMklgc/gPmS45/30w4wG3FRLVL90+YVv8OE6ziJ3o+5RLNZnV9AsC7A5ue
 C8PAPdtwnee0SEN/la0yz4pQGbGOdV4kRVMSxgCkZf++BhWFn0Vpw89r4SSWO2CuhT7v
 DP7483zUEjngQQXbkTIgKcvukfTdAOuMWkqbTvRQhE5Zq3N0mUnVYy+wKENaAwsf0jZ9
 e/SvaO5ztfKLGdIU7gYaZnUen6rKkTn7dPvuhh0kaE+/JJburMmtmNUpoBiZbf76/R7a
 HOqg==
X-Gm-Message-State: AOJu0YwQoL9eEDau+kRjpyeq8xFT4TsbXLrnPegRKIXubsirUknYqAkZ
 MNE3i2RioMG9tTC3rqQmIcb1eAWyRCU9kiLkNHWrJqf0ewC7k3nmjREgx/a0qDfrHS8ejEecpfF
 2HBYJ0fPznp1En0oDgabtX8nDsX9guG1UKKlP+zT3GxIZsduTkhMKlTVOauMdoYQYtiEfiGANqe
 ICGQNeUS06ZLEaNkd/nz4j0Q8jaKt0/YE=
X-Gm-Gg: ASbGncs0TgiA+gnKIh0XpswKjlnUg5bcVjI5c9VEPtnxqBWMO+meP5jibJmh7aB/mhV
 Y1yH8fnXuzAWuEW09sLrVu/G5RU3BL3iSAkImQQKHW0MBlkj1A7/mOdh6F3d7+m97eM7ubpMOii
 dLuORXs+cpVtpzixxOSWdctYHmUZwn1BHm4T/syHq5GbMLK+1BTvg2YkhQ
X-Received: by 2002:a17:907:3f1f:b0:b6d:5003:8746 with SMTP id
 a640c23a62f3a-b6d50038937mr371959466b.21.1761229828690; 
 Thu, 23 Oct 2025 07:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH17DMlcaU6Wgpe5rcYsSX3y99s6Ie3fBwq9I6sTKYWNIFBy/6nYck38oyRxi1IB7TtgfdQKM5Hl44aSU7kvFM=
X-Received: by 2002:a17:907:3f1f:b0:b6d:5003:8746 with SMTP id
 a640c23a62f3a-b6d50038937mr371955866b.21.1761229828275; Thu, 23 Oct 2025
 07:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
In-Reply-To: <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 23 Oct 2025 22:29:51 +0800
X-Gm-Features: AWmQ_bmDbFtlDdsAnowdDsEqoY-JAo1nN7G6z-I98-vBkFEtXi3ABF7GNJh3JL8
Message-ID: <CAPpAL=zL2iQWQM98R-xRoSFkMEYB+xqtB3KOGc9gAfQnymJxMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Alexandr

According to my test result, this series of patches introduce issues,
it prints the following error messages when compiling the process
after applying your patch.
The test based on this commit:
commit 3a2d5612a7422732b648b46d4b934e2e54622fd6 (origin/master, origin/HEAD=
)
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Oct 17 14:31:56 2025 +0100

Error messages:
[1849/2964] Compiling C object
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
FAILED: libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
cc -m64 -Ilibqemu-x86_64-softmmu.a.p -I. -I.. -Itarget/i386
-I../target/i386 -Isubprojects/dtc/libfdt -I../subprojects/dtc/libfdt
-Isubprojects/libvduse -I../subprojects/libvduse -Iqapi -Itrace -Iui
-Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0
-I/usr/lib64/glib-2.0/include -I/usr/include/libmount
-I/usr/include/blkid -I/usr/include/sysprof-6
-I/usr/include/gio-unix-2.0 -I/usr/include/slirp
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0 -g
-fstack-protector-strong -Wempty-body -Wendif-labels
-Wexpansion-to-defined -Wformat-security -Wformat-y2k
-Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
-Wno-shift-negative-value -isystem
/mnt/tests/distribution/command/qemu/linux-headers -isystem
linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
-iquote /mnt/tests/distribution/command/qemu/include -iquote
/mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
/mnt/tests/distribution/command/qemu/host/include/generic -iquote
/mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
-fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
-fzero-call-used-regs=3Dused-gpr -fPIE -DWITH_GZFILEOP
-isystem../linux-headers -isystemlinux-headers -DCOMPILING_PER_TARGET
'-DCONFIG_TARGET=3D"x86_64-softmmu-config-target.h"'
'-DCONFIG_DEVICES=3D"x86_64-softmmu-config-devices.h"' -MD -MQ
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -MF
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o.d -o
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -c
../hw/block/vhost-user-blk.c
In file included from
/mnt/tests/distribution/command/qemu/migration/options.h:19,
                 from ../hw/block/vhost-user-blk.c:34:
/mnt/tests/distribution/command/qemu/include/migration/client-options.h:26:=
1:
error: unknown type name =E2=80=98MigMode=E2=80=99
   26 | MigMode migrate_mode(void);
      | ^~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:66:7: error:
unknown type name =E2=80=98BitmapMigrationNodeAliasList=E2=80=99
   66 | const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(vo=
id);
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:80:1: error:
unknown type name =E2=80=98MultiFDCompression=E2=80=99
   80 | MultiFDCompression migrate_multifd_compression(void);
      | ^~~~~~~~~~~~~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:89:1: error:
unknown type name =E2=80=98ZeroPageDetection=E2=80=99
   89 | ZeroPageDetection migrate_zero_page_detection(void);
      | ^~~~~~~~~~~~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:93:27: error:
unknown type name =E2=80=98MigrationParameters=E2=80=99; did you mean
=E2=80=98MigrationState=E2=80=99?
   93 | bool migrate_params_check(MigrationParameters *params, Error **errp=
);
      |                           ^~~~~~~~~~~~~~~~~~~
      |                           MigrationState
/mnt/tests/distribution/command/qemu/migration/options.h:94:26: error:
unknown type name =E2=80=98MigrationParameters=E2=80=99; did you mean
=E2=80=98MigrationState=E2=80=99?
   94 | void migrate_params_init(MigrationParameters *params);
      |                          ^~~~~~~~~~~~~~~~~~~
      |                          MigrationState
ninja: build stopped: subcommand failed.
make[1]: *** [Makefile:168: run-ninja] Error 1

Thanks
Lei


On Mon, Oct 20, 2025 at 1:47=E2=80=AFPM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> In vhost_user_blk_stop() on incoming migration make force_stop =3D true,
> so GET_VRING_BASE will not be executed.
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 52 +++++++++++++++++++++++++++++++++++++++
>  migration/options.c       |  7 ++++++
>  migration/options.h       |  1 +
>  qapi/migration.json       |  9 +++++--
>  4 files changed, 67 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index c0cc5f6942..49f67d0451 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -31,6 +31,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "system/system.h"
>  #include "system/runstate.h"
> +#include "migration/options.h"
>
>  static const int user_feature_bits[] =3D {
>      VIRTIO_BLK_F_SIZE_MAX,
> @@ -224,6 +225,11 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
>      force_stop =3D s->skip_get_vring_base_on_force_shutdown &&
>                   qemu_force_shutdown_requested();
>
> +    if (migrate_inflight_vhost_user_blk() &&
> +        runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +        force_stop =3D true;
> +    }
> +
>      ret =3D force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
>                         vhost_dev_stop(&s->dev, vdev, true);
>
> @@ -568,12 +574,58 @@ static struct vhost_dev *vhost_user_blk_get_vhost(V=
irtIODevice *vdev)
>      return &s->dev;
>  }
>
> +static int vhost_user_blk_save(QEMUFile *f, void *pv, size_t size,
> +                               const VMStateField *field, JSONWriter *vm=
desc)
> +{
> +    VirtIODevice *vdev =3D pv;
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +
> +    if (!migrate_inflight_vhost_user_blk()) {
> +        return 0;
> +    }
> +
> +    vhost_dev_save_inflight(s->inflight, f);
> +
> +    return 0;
> +}
> +
> +static int vhost_user_blk_load(QEMUFile *f, void *pv, size_t size,
> +                               const VMStateField *field)
> +{
> +    VirtIODevice *vdev =3D pv;
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +    int ret;
> +
> +    if (!migrate_inflight_vhost_user_blk()) {
> +        return 0;
> +    }
> +
> +    ret =3D vhost_dev_load_inflight(s->inflight, f);
> +    if (ret < 0) {
> +        g_autofree char *path =3D object_get_canonical_path(OBJECT(vdev)=
);
> +        error_report("%s [%s]: can't load in-flight requests",
> +                     path, TYPE_VHOST_USER_BLK);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_vhost_user_blk =3D {
>      .name =3D "vhost-user-blk",
>      .minimum_version_id =3D 1,
>      .version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_VIRTIO_DEVICE,
> +        {
> +            .name =3D "backend state",
> +            .info =3D &(const VMStateInfo) {
> +                .name =3D "vhost-user-blk backend state",
> +                .get =3D vhost_user_blk_load,
> +                .put =3D vhost_user_blk_save,
> +            },
> +            .flags =3D VMS_SINGLE,
> +        },
>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/migration/options.c b/migration/options.c
> index 5183112775..fcae2b4559 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -262,6 +262,13 @@ bool migrate_mapped_ram(void)
>      return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
>  }
>
> +bool migrate_inflight_vhost_user_blk(void)
> +{
> +    MigrationState *s =3D migrate_get_current();
> +
> +    return s->capabilities[MIGRATION_CAPABILITY_INFLIGHT_VHOST_USER_BLK]=
;
> +}
> +
>  bool migrate_ignore_shared(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> diff --git a/migration/options.h b/migration/options.h
> index 82d839709e..eab1485d1a 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -30,6 +30,7 @@ bool migrate_colo(void);
>  bool migrate_dirty_bitmaps(void);
>  bool migrate_events(void);
>  bool migrate_mapped_ram(void);
> +bool migrate_inflight_vhost_user_blk(void);
>  bool migrate_ignore_shared(void);
>  bool migrate_late_block_activate(void);
>  bool migrate_multifd(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..c9fea59515 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -517,9 +517,13 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
> +#    region for vhost-user-blk.  (since 10.2)
> +#
>  # Features:
>  #
> -# @unstable: Members @x-colo and @x-ignore-shared are experimental.
> +# @unstable: Members @x-colo and @x-ignore-shared,
> +#     @inflight-vhost-user-blk are experimental.
>  # @deprecated: Member @zero-blocks is deprecated as being part of
>  #     block migration which was already removed.
>  #
> @@ -536,7 +540,8 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram',
> +           { 'name': 'inflight-vhost-user-blk', 'features': [ 'unstable'=
 ] } ] }
>
>  ##
>  # @MigrationCapabilityStatus:
> --
> 2.34.1
>
>


