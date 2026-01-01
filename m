Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA838EEB56D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 08:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbED9-0002Lc-Kd; Thu, 01 Jan 2026 03:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vbED8-0002L7-9z
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 03:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vbED4-00082p-P8
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 03:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767256744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRW9q/xgyAQpG2tjG0mu9Xt66XuEekaB92G3ktOXeDU=;
 b=Pip+eF7HJqnajpeux465gPSlCONdtbn4ZuEoNpKIZPK99XENd3d2S7wP9nBiWOdxBvlOP4
 Nbh7lIo3TnGe7L8GyratQQS5nTgfsDAwazQBoad6gHzHJkkaSVVw7tZnON926f64hbfvGo
 0PUfAWNH3uPAipqK1jpxoVOH3Ni0VTg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-iCJEIs87N9-7G2YHUmcQSg-1; Thu, 01 Jan 2026 03:39:02 -0500
X-MC-Unique: iCJEIs87N9-7G2YHUmcQSg-1
X-Mimecast-MFC-AGG-ID: iCJEIs87N9-7G2YHUmcQSg_1767256741
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fdaba167so5986366f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jan 2026 00:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767256740; x=1767861540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sRW9q/xgyAQpG2tjG0mu9Xt66XuEekaB92G3ktOXeDU=;
 b=NZ17ln4IWD8Q5Cb5G+/MqDJaX8U6Gh0bAXN0j3mWTo9ciZDVh4g3rs9FG1f4WZFU8d
 LvedJ2BaotK7b4vXC2O5CsBJv5xu22s2tGgriyUWbig8vAGjl0UE1Rgt0AasHW1pNCqY
 DAmPGRkO2iNxAN6IL/bXHv3OVMQBqsmPFHen4kN1CjeyMIfIiKwGapH4qB8I1HDoxnnW
 QyEIYbbrU7W7ozZcoo3I+1B7x0jZHXu/LkszypzEDk7tDNJbZS+n0Bn+kBW8JRad71Ci
 cZj+N7gjeXw6NcszuSnbCBvsh3cq1NHe7LxfhZZJOqyzdlIYAXVNVeKIo3AUW5nJNOk9
 UFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767256740; x=1767861540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRW9q/xgyAQpG2tjG0mu9Xt66XuEekaB92G3ktOXeDU=;
 b=pWhN1E0B8V3sgXhfG29m/+1W7u/7Fk5QylE1m7Knem93LeVnQ+GL0MORioMANwESp+
 Mflfx/2NvpsCS/iTsmgkwnEhDquh063643TqwsbibfWYRcOmloEo0qJca2K8GhreWYeK
 9jnoZT54lkQQL41hXkaOHZcUAVuUDuWjK4BGvp57U56gQi0YgvxnyFyFfea2r6HdpF01
 7G5nbm3fi9chdvYTcTNJrzVnukXw3bDHmHnJpgXcQF5u/ClQ8/CLccWOq+exJpNkQxZ9
 52jRoTY/iE+zWH+p0XI8beU45EJWFW5FWR/UZ401v+L7X+jnT8hyvDnY4JIif11B2hSL
 mP4A==
X-Gm-Message-State: AOJu0YxetP02Y28p6qNvfCxDnjPbknTRjpUZr8RMrvk4FTbzdTEStfjN
 NL7Bpc+Nsu9Alhs2RaxqHds13Jb6id2ay+NfpMQc2HpgUmmqFa9u3Vtxv+pAynWHFERcnGZdinl
 tf3JUQWmbTy9Oe6SBUa2MPExhnIrn1iSbMlbWBqE62ziwjuKdQgTNj51TCWSMeEcn9HKwZPtZP5
 F2NOqtISiB59ftPNrc1EiMf4Ow+uDtItI=
X-Gm-Gg: AY/fxX6hswaOmrY4Ijx/iOewJwPYuuuHOc6AnucdOITcz0JTWJGyBPWx7L/CpDiZYBn
 nqGTP2r2aDW+hlA1IsA1gd12hPaEtTi4yHN8mNjairLkA+miKotd8X1GRbqUEVLp4Z8fG7/MyEM
 b2Xlyc16RepKF7QGnDqDAkk5+gtGhLWNb//5LDTn/RHQ66C8nkEAoygkR8/Gl3ijurMbIZbeJ6e
 mvmnf0OQYNkGDe4fUDVfht3myMTWIvdd2VtGH2gdgqAw+FqilKGbtFV3p1DQwHRTtfq8A==
X-Received: by 2002:a05:6000:200d:b0:430:fd84:3179 with SMTP id
 ffacd0b85a97d-4324e4f92bemr50396248f8f.33.1767256740050; 
 Thu, 01 Jan 2026 00:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmDviky6WpEj3f/eJM07SdniT7iRjBP9W6c80wvKvueK5gIRcK8GarriQD4wzbD7g0GrQLhvdfPSVedhQGWM0=
X-Received: by 2002:a05:6000:200d:b0:430:fd84:3179 with SMTP id
 ffacd0b85a97d-4324e4f92bemr50396216f8f.33.1767256739471; Thu, 01 Jan 2026
 00:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <20251231073401.2097765-6-pierrick.bouvier@linaro.org>
In-Reply-To: <20251231073401.2097765-6-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Jan 2026 09:38:48 +0100
X-Gm-Features: AQt7F2od1VoKGZmB5u3CYaS14j2YDnDfW_Za2-WozUzsYX0Y3ZLohNZKy6BgOKQ
Message-ID: <CABgObfY1wpqryyBbf3tpCwZGT0izto_hda+izOUGZ57jwQzXMg@mail.gmail.com>
Subject: Re: [PATCH 05/11] include: qemu/ctype.h -> qemu/qemu-ctype.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002efb9c06474f867e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--0000000000002efb9c06474f867e
Content-Type: text/plain; charset="UTF-8"

Il mer 31 dic 2025, 08:34 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> This headers conflicts with C++ ctype header, included from iostream.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>

Stupid question sorry: the header is meant to be included as qemu/ctype.h,
not ctype.h; why is include/qemu/ on the include path instead of just
include/? Can the include path be changed instead?

Paolo

---
>  include/qemu/{ctype.h => qemu-ctype.h} | 0
>  block/ssh.c                            | 2 +-
>  block/vvfat.c                          | 2 +-
>  gdbstub/gdbstub.c                      | 2 +-
>  hw/core/bus.c                          | 2 +-
>  hw/core/qdev-properties-system.c       | 2 +-
>  hw/core/qdev-properties.c              | 2 +-
>  hw/hyperv/syndbg.c                     | 2 +-
>  hw/nvme/nguid.c                        | 2 +-
>  hw/s390x/ccw-device.c                  | 2 +-
>  hw/s390x/ipl.c                         | 2 +-
>  hw/s390x/s390-virtio-ccw.c             | 2 +-
>  hw/scsi/scsi-generic.c                 | 2 +-
>  migration/migration.c                  | 2 +-
>  monitor/fds.c                          | 2 +-
>  monitor/hmp.c                          | 2 +-
>  net/net.c                              | 2 +-
>  net/tap-solaris.c                      | 2 +-
>  qapi/qapi-util.c                       | 2 +-
>  qobject/json-parser.c                  | 2 +-
>  target/ppc/ppc-qmp-cmds.c              | 2 +-
>  target/riscv/cpu.c                     | 2 +-
>  target/riscv/riscv-qmp-cmds.c          | 2 +-
>  tests/qtest/libqtest.c                 | 2 +-
>  tests/qtest/migration/migration-util.c | 2 +-
>  tests/vhost-user-bridge.c              | 2 +-
>  ui/keymaps.c                           | 2 +-
>  util/cutils.c                          | 2 +-
>  util/id.c                              | 2 +-
>  util/readline.c                        | 2 +-
>  30 files changed, 29 insertions(+), 29 deletions(-)
>  rename include/qemu/{ctype.h => qemu-ctype.h} (100%)
>
> diff --git a/include/qemu/ctype.h b/include/qemu/qemu-ctype.h
> similarity index 100%
> rename from include/qemu/ctype.h
> rename to include/qemu/qemu-ctype.h
> diff --git a/block/ssh.c b/block/ssh.c
> index bdec94e9e92..8ae7be4b423 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -34,7 +34,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/sockets.h"
>  #include "qapi/qapi-visit-sockets.h"
> diff --git a/block/vvfat.c b/block/vvfat.c
> index e334b9febb1..d495d07e5b0 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -36,7 +36,7 @@
>  #include "migration/blocker.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qstring.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 1f8cd118924..47d4f63d4e4 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -24,7 +24,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index 53f392fdda8..202c42b405d 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -19,7 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/core/qdev-properties.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>
> diff --git a/hw/core/qdev-properties-system.c
> b/hw/core/qdev-properties-system.c
> index fe5464c7da1..420b60e9ba1 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -20,7 +20,7 @@
>  #include "qapi/qapi-types-migration.h"
>  #include "qapi/qapi-visit-virtio.h"
>  #include "qapi/qmp/qerror.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/units.h"
>  #include "qemu/uuid.h"
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 05489c8fbbf..3e762d83194 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -4,7 +4,7 @@
>  #include "qapi/qapi-types-misc.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "qobject/qlist.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/error-report.h"
>  #include "qapi/visitor.h"
>  #include "qemu/units.h"
> diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
> index 1e177f9dd82..7219ed0f219 100644
> --- a/hw/hyperv/syndbg.c
> +++ b/hw/hyperv/syndbg.c
> @@ -6,7 +6,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/sockets.h"
> diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c
> index 4cd6fad6ac9..acd73ac695b 100644
> --- a/hw/nvme/nguid.c
> +++ b/hw/nvme/nguid.c
> @@ -16,7 +16,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/visitor.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "nvme.h"
>
>  #define NGUID_SEPARATOR '-'
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index 25c42732795..6520fee7970 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -15,7 +15,7 @@
>  #include "qemu/module.h"
>  #include "ipl.h"
>  #include "qapi/visitor.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qapi/error.h"
>
>  static void ccw_device_refill_ids(CcwDevice *dev)
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d34adb55220..21adb5955b3 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -34,7 +34,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
>  #include "qemu/option.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "standard-headers/linux/virtio_ids.h"
>
>  #define KERN_IMAGE_START                0x010000UL
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 8314655ec2c..217244643b6 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -19,7 +19,7 @@
>  #include "hw/s390x/s390_flic.h"
>  #include "virtio-ccw.h"
>  #include "qemu/config-file.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "qemu/qemu-print.h"
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 0a676a16fa4..c2563ccbdf6 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -13,7 +13,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "hw/scsi/scsi.h"
> diff --git a/migration/migration.c b/migration/migration.c
> index 9d1bf5d276d..5b21eb07d5e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -14,7 +14,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> diff --git a/monitor/fds.c b/monitor/fds.c
> index cc35d2ec334..d98c117a9b2 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -27,7 +27,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qmp/qerror.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "system/runstate.h"
>
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 4caafbc7146..023c4e77a84 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -30,7 +30,7 @@
>  #include "qobject/qdict.h"
>  #include "qobject/qnum.h"
>  #include "qemu/config-file.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qemu/option.h"
> diff --git a/net/net.c b/net/net.c
> index a176936f9bc..ca2f49119d5 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -43,7 +43,7 @@
>  #include "qemu/sockets.h"
>  #include "qemu/cutils.h"
>  #include "qemu/config-file.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/id.h"
>  #include "qemu/iov.h"
>  #include "qemu/qemu-print.h"
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 75397e6c544..6e1da970d98 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "tap_int.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "net/net.h"
>
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 3d849fe0347..b372c74dd04 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -13,7 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/compat-policy.h"
>  #include "qapi/error.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qapi/qmp/qerror.h"
>
>  CompatPolicy compat_policy;
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 7483e582fea..7c5618ba3f3 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -12,7 +12,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/unicode.h"
>  #include "qapi/error.h"
> diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
> index 7022564604f..ae9711a21e3 100644
> --- a/target/ppc/ppc-qmp-cmds.c
> +++ b/target/ppc/ppc-qmp-cmds.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "monitor/monitor.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "monitor/hmp-target.h"
>  #include "monitor/hmp.h"
>  #include "qapi/error.h"
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8f26d8b8b07..17df96913ce 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -19,7 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/qemu-print.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/log.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
> index d5e9bec0f86..618007fc0f9 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -31,7 +31,7 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/visitor.h"
>  #include "qom/qom-qobject.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/qemu-print.h"
>  #include "monitor/hmp.h"
>  #include "monitor/hmp-target.h"
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 622464e3656..10a01ba76fa 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -31,7 +31,7 @@
>  #include "libqtest.h"
>  #include "libqmp.h"
>  #include "qemu/accel.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/exit-with-parent.h"
>  #include "qemu/sockets.h"
> diff --git a/tests/qtest/migration/migration-util.c
> b/tests/qtest/migration/migration-util.c
> index c2462306a15..1c6dbb6c19b 100644
> --- a/tests/qtest/migration/migration-util.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -11,7 +11,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/error.h"
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index ce4c3426d39..cb852194dd0 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -31,7 +31,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/atomic.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/iov.h"
>  #include "standard-headers/linux/virtio_net.h"
>  #include "libvhost-user.h"
> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 2359dbfe7e6..6dfd5a45ee3 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -26,7 +26,7 @@
>  #include "qemu/datadir.h"
>  #include "keymaps.h"
>  #include "trace.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "ui/input.h"
> diff --git a/util/cutils.c b/util/cutils.c
> index 9803f11a596..2c0a9926893 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -48,7 +48,7 @@
>  #include <wchar.h>
>  #endif
>
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>
> diff --git a/util/id.c b/util/id.c
> index ded41c5025e..0ba538dce81 100644
> --- a/util/id.c
> +++ b/util/id.c
> @@ -11,7 +11,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/id.h"
>
>  bool id_wellformed(const char *id)
> diff --git a/util/readline.c b/util/readline.c
> index 0f19674f526..f756d384625 100644
> --- a/util/readline.c
> +++ b/util/readline.c
> @@ -24,7 +24,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/readline.h"
> -#include "qemu/ctype.h"
> +#include "qemu/qemu-ctype.h"
>  #include "qemu/cutils.h"
>
>  #define IS_NORM 0
> --
> 2.47.3
>
>

--0000000000002efb9c06474f867e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 31 dic 2025, 08:34 Pierri=
ck Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouv=
ier@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This headers conflicts with C++ ctype header, included f=
rom iostream.<br>
<br>
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@linaro.org</a=
>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Stupid question sorry: the header is meant to be included as qemu/ctyp=
e.h, not ctype.h; why is include/qemu/ on the include path instead of just =
include/? Can the include path be changed instead?</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/qemu/{ctype.h =3D&gt; qemu-ctype.h} | 0<br>
=C2=A0block/ssh.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0block/vvfat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0gdbstub/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/core/bus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0hw/core/qdev-properties.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 2 +-<br>
=C2=A0hw/hyperv/syndbg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0hw/nvme/nguid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/s390x/ccw-device.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/s390x/ipl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0hw/s390x/s390-virtio-ccw.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 2 +-<br>
=C2=A0hw/scsi/scsi-generic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0monitor/fds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0monitor/hmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0net/tap-solaris.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0qapi/qapi-util.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0qobject/json-parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0target/ppc/ppc-qmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 2 +-<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0target/riscv/riscv-qmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +=
-<br>
=C2=A0tests/qtest/libqtest.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0tests/qtest/migration/migration-util.c | 2 +-<br>
=C2=A0tests/vhost-user-bridge.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 2 +-<br>
=C2=A0ui/keymaps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0util/cutils.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0util/id.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0util/readline.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A030 files changed, 29 insertions(+), 29 deletions(-)<br>
=C2=A0rename include/qemu/{ctype.h =3D&gt; qemu-ctype.h} (100%)<br>
<br>
diff --git a/include/qemu/ctype.h b/include/qemu/qemu-ctype.h<br>
similarity index 100%<br>
rename from include/qemu/ctype.h<br>
rename to include/qemu/qemu-ctype.h<br>
diff --git a/block/ssh.c b/block/ssh.c<br>
index bdec94e9e92..8ae7be4b423 100644<br>
--- a/block/ssh.c<br>
+++ b/block/ssh.c<br>
@@ -34,7 +34,7 @@<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/sockets.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-visit-sockets.h&quot;<br>
diff --git a/block/vvfat.c b/block/vvfat.c<br>
index e334b9febb1..d495d07e5b0 100644<br>
--- a/block/vvfat.c<br>
+++ b/block/vvfat.c<br>
@@ -36,7 +36,7 @@<br>
=C2=A0#include &quot;migration/blocker.h&quot;<br>
=C2=A0#include &quot;qobject/qdict.h&quot;<br>
=C2=A0#include &quot;qobject/qstring.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
<br>
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c<br>
index 1f8cd118924..47d4f63d4e4 100644<br>
--- a/gdbstub/gdbstub.c<br>
+++ b/gdbstub/gdbstub.c<br>
@@ -24,7 +24,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
diff --git a/hw/core/bus.c b/hw/core/bus.c<br>
index 53f392fdda8..202c42b405d 100644<br>
--- a/hw/core/bus.c<br>
+++ b/hw/core/bus.c<br>
@@ -19,7 +19,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/core/qdev-properties.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
<br>
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-sys=
tem.c<br>
index fe5464c7da1..420b60e9ba1 100644<br>
--- a/hw/core/qdev-properties-system.c<br>
+++ b/hw/core/qdev-properties-system.c<br>
@@ -20,7 +20,7 @@<br>
=C2=A0#include &quot;qapi/qapi-types-migration.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-visit-virtio.h&quot;<br>
=C2=A0#include &quot;qapi/qmp/qerror.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;qemu/uuid.h&quot;<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 05489c8fbbf..3e762d83194 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -4,7 +4,7 @@<br>
=C2=A0#include &quot;qapi/qapi-types-misc.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-visit-common.h&quot;<br>
=C2=A0#include &quot;qobject/qlist.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qapi/visitor.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c<br>
index 1e177f9dd82..7219ed0f219 100644<br>
--- a/hw/hyperv/syndbg.c<br>
+++ b/hw/hyperv/syndbg.c<br>
@@ -6,7 +6,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/main-loop.h&quot;<br>
=C2=A0#include &quot;qemu/sockets.h&quot;<br>
diff --git a/hw/nvme/nguid.c b/hw/nvme/nguid.c<br>
index 4cd6fad6ac9..acd73ac695b 100644<br>
--- a/hw/nvme/nguid.c<br>
+++ b/hw/nvme/nguid.c<br>
@@ -16,7 +16,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/visitor.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;nvme.h&quot;<br>
<br>
=C2=A0#define NGUID_SEPARATOR &#39;-&#39;<br>
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c<br>
index 25c42732795..6520fee7970 100644<br>
--- a/hw/s390x/ccw-device.c<br>
+++ b/hw/s390x/ccw-device.c<br>
@@ -15,7 +15,7 @@<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;ipl.h&quot;<br>
=C2=A0#include &quot;qapi/visitor.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
<br>
=C2=A0static void ccw_device_refill_ids(CcwDevice *dev)<br>
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c<br>
index d34adb55220..21adb5955b3 100644<br>
--- a/hw/s390x/ipl.c<br>
+++ b/hw/s390x/ipl.c<br>
@@ -34,7 +34,7 @@<br>
=C2=A0#include &quot;qemu/config-file.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;standard-headers/linux/virtio_ids.h&quot;<br>
<br>
=C2=A0#define KERN_IMAGE_START=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x010000UL<br>
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c<br>
index 8314655ec2c..217244643b6 100644<br>
--- a/hw/s390x/s390-virtio-ccw.c<br>
+++ b/hw/s390x/s390-virtio-ccw.c<br>
@@ -19,7 +19,7 @@<br>
=C2=A0#include &quot;hw/s390x/s390_flic.h&quot;<br>
=C2=A0#include &quot;virtio-ccw.h&quot;<br>
=C2=A0#include &quot;qemu/config-file.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
=C2=A0#include &quot;qemu/qemu-print.h&quot;<br>
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c<br>
index 0a676a16fa4..c2563ccbdf6 100644<br>
--- a/hw/scsi/scsi-generic.c<br>
+++ b/hw/scsi/scsi-generic.c<br>
@@ -13,7 +13,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;hw/scsi/scsi.h&quot;<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 9d1bf5d276d..5b21eb07d5e 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -14,7 +14,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/main-loop.h&quot;<br>
diff --git a/monitor/fds.c b/monitor/fds.c<br>
index cc35d2ec334..d98c117a9b2 100644<br>
--- a/monitor/fds.c<br>
+++ b/monitor/fds.c<br>
@@ -27,7 +27,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-commands-misc.h&quot;<br>
=C2=A0#include &quot;qapi/qmp/qerror.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;system/runstate.h&quot;<br>
<br>
diff --git a/monitor/hmp.c b/monitor/hmp.c<br>
index 4caafbc7146..023c4e77a84 100644<br>
--- a/monitor/hmp.c<br>
+++ b/monitor/hmp.c<br>
@@ -30,7 +30,7 @@<br>
=C2=A0#include &quot;qobject/qdict.h&quot;<br>
=C2=A0#include &quot;qobject/qnum.h&quot;<br>
=C2=A0#include &quot;qemu/config-file.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
diff --git a/net/net.c b/net/net.c<br>
index a176936f9bc..ca2f49119d5 100644<br>
--- a/net/net.c<br>
+++ b/net/net.c<br>
@@ -43,7 +43,7 @@<br>
=C2=A0#include &quot;qemu/sockets.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/config-file.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/id.h&quot;<br>
=C2=A0#include &quot;qemu/iov.h&quot;<br>
=C2=A0#include &quot;qemu/qemu-print.h&quot;<br>
diff --git a/net/tap-solaris.c b/net/tap-solaris.c<br>
index 75397e6c544..6e1da970d98 100644<br>
--- a/net/tap-solaris.c<br>
+++ b/net/tap-solaris.c<br>
@@ -25,7 +25,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;tap_int.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;net/net.h&quot;<br>
<br>
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c<br>
index 3d849fe0347..b372c74dd04 100644<br>
--- a/qapi/qapi-util.c<br>
+++ b/qapi/qapi-util.c<br>
@@ -13,7 +13,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/compat-policy.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qapi/qmp/qerror.h&quot;<br>
<br>
=C2=A0CompatPolicy compat_policy;<br>
diff --git a/qobject/json-parser.c b/qobject/json-parser.c<br>
index 7483e582fea..7c5618ba3f3 100644<br>
--- a/qobject/json-parser.c<br>
+++ b/qobject/json-parser.c<br>
@@ -12,7 +12,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/unicode.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c<br>
index 7022564604f..ae9711a21e3 100644<br>
--- a/target/ppc/ppc-qmp-cmds.c<br>
+++ b/target/ppc/ppc-qmp-cmds.c<br>
@@ -25,7 +25,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;cpu.h&quot;<br>
=C2=A0#include &quot;monitor/monitor.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;monitor/hmp-target.h&quot;<br>
=C2=A0#include &quot;monitor/hmp.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index 8f26d8b8b07..17df96913ce 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -19,7 +19,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/qemu-print.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;cpu.h&quot;<br>
=C2=A0#include &quot;cpu_vendorid.h&quot;<br>
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c<=
br>
index d5e9bec0f86..618007fc0f9 100644<br>
--- a/target/riscv/riscv-qmp-cmds.c<br>
+++ b/target/riscv/riscv-qmp-cmds.c<br>
@@ -31,7 +31,7 @@<br>
=C2=A0#include &quot;qapi/qobject-input-visitor.h&quot;<br>
=C2=A0#include &quot;qapi/visitor.h&quot;<br>
=C2=A0#include &quot;qom/qom-qobject.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/qemu-print.h&quot;<br>
=C2=A0#include &quot;monitor/hmp.h&quot;<br>
=C2=A0#include &quot;monitor/hmp-target.h&quot;<br>
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c<br>
index 622464e3656..10a01ba76fa 100644<br>
--- a/tests/qtest/libqtest.c<br>
+++ b/tests/qtest/libqtest.c<br>
@@ -31,7 +31,7 @@<br>
=C2=A0#include &quot;libqtest.h&quot;<br>
=C2=A0#include &quot;libqmp.h&quot;<br>
=C2=A0#include &quot;qemu/accel.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/exit-with-parent.h&quot;<br>
=C2=A0#include &quot;qemu/sockets.h&quot;<br>
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration=
/migration-util.c<br>
index c2462306a15..1c6dbb6c19b 100644<br>
--- a/tests/qtest/migration/migration-util.c<br>
+++ b/tests/qtest/migration/migration-util.c<br>
@@ -11,7 +11,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-visit-sockets.h&quot;<br>
=C2=A0#include &quot;qapi/qobject-input-visitor.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c<br>
index ce4c3426d39..cb852194dd0 100644<br>
--- a/tests/vhost-user-bridge.c<br>
+++ b/tests/vhost-user-bridge.c<br>
@@ -31,7 +31,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/atomic.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/iov.h&quot;<br>
=C2=A0#include &quot;standard-headers/linux/virtio_net.h&quot;<br>
=C2=A0#include &quot;libvhost-user.h&quot;<br>
diff --git a/ui/keymaps.c b/ui/keymaps.c<br>
index 2359dbfe7e6..6dfd5a45ee3 100644<br>
--- a/ui/keymaps.c<br>
+++ b/ui/keymaps.c<br>
@@ -26,7 +26,7 @@<br>
=C2=A0#include &quot;qemu/datadir.h&quot;<br>
=C2=A0#include &quot;keymaps.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;ui/input.h&quot;<br>
diff --git a/util/cutils.c b/util/cutils.c<br>
index 9803f11a596..2c0a9926893 100644<br>
--- a/util/cutils.c<br>
+++ b/util/cutils.c<br>
@@ -48,7 +48,7 @@<br>
=C2=A0#include &lt;wchar.h&gt;<br>
=C2=A0#endif<br>
<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
<br>
diff --git a/util/id.c b/util/id.c<br>
index ded41c5025e..0ba538dce81 100644<br>
--- a/util/id.c<br>
+++ b/util/id.c<br>
@@ -11,7 +11,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/id.h&quot;<br>
<br>
=C2=A0bool id_wellformed(const char *id)<br>
diff --git a/util/readline.c b/util/readline.c<br>
index 0f19674f526..f756d384625 100644<br>
--- a/util/readline.c<br>
+++ b/util/readline.c<br>
@@ -24,7 +24,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/readline.h&quot;<br>
-#include &quot;qemu/ctype.h&quot;<br>
+#include &quot;qemu/qemu-ctype.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
<br>
=C2=A0#define IS_NORM 0<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div></div>

--0000000000002efb9c06474f867e--


