Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C77BC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXko-0007yE-Vr; Fri, 23 Feb 2024 10:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rdXNl-0004kj-Uq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:22:37 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rdXNj-0002QR-OJ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:22:37 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so1220479a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708701753; x=1709306553; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlHHKHkSq14ujZwIbgRPjIG/e+WxahKGkcYlwBOteGM=;
 b=BvTWdEz4cVgMoT7lEoB2fYVvWaBLQFpHurZtfqJOshmLa+Lixiala6U4dxtqz9d35p
 Ibhyr6xZWAedq2IP5ki6DNgSFZGg5dnjzuNniyxYcKxmiDr+RJnXtNL+hLaCGg4cn1MG
 rDWpqucq3qbyiSOmXM8N84M3z7qKIO00KMRRR4w9Bq/CAv9MwXf5fzLXo9oRDXqJaXBU
 gWYfkve8EUsDjRrKuXsLiIdO0gg0DhbusqIfHIE1vIESTJaWTGi4WkAEgjOyffnPPxHw
 RIBymgiITFK1eIWRwwf6NeBVR/o4Ozt5V4QWlbcgSDDO0+ovVyPa2PFilkfj8YAILwWr
 JG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708701753; x=1709306553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlHHKHkSq14ujZwIbgRPjIG/e+WxahKGkcYlwBOteGM=;
 b=rPMaa5jjWvW6m83DU3RIlOyp1IVCeAX0mgpzEPAi57hJWj49oPdZ6I02zaZayVN7sW
 74s8kP23f2hZAOGRxaEIp9QYF4nrtzhcXhLsccZdfRufskEtmMD2JSTBrBm/BzQX9mHm
 nM+5AQASklHn20pAQMVH7H7DebpezkGUYMEdndmOQSnJGCP0FydBwNuxDTieMysE1j+i
 n/gZtDORG+zGOvD3eNi0DNg1bj4XmYc4Wt6DasrbO14N7gzInS5QA4fFwZK/tznstwzw
 q7kh8Lnko3DJosPDrhuzFWeji6KyPOks/gT6ZBfHCS+gCMJgoXpPKMaM7JDaSEqngz/2
 dhzA==
X-Gm-Message-State: AOJu0Yye8yCPohds4VAphZS4L2LDRwaL8TlOAQwC4NsVXz4wL6FWaSl+
 Ow7auyx0KufaJd7W4CzTONN8q7uHGqHGBUWxMQsm7hn9uIqRRRNUyVwkUn0Pm/N6EM+AQY3HFXn
 aEiqgh+LLGAadXbX2IAiOg/Ib4HxIJLNyXLM=
X-Google-Smtp-Source: AGHT+IF52D6oN6xzZO5zjDdosz0kyoPKYQLI4NdMgvZkWl1jkKmGzmZA4db74KL4i5z+s3oLgHP29qaqfevnOjbRF1k=
X-Received: by 2002:aa7:c615:0:b0:564:26d9:b4ac with SMTP id
 h21-20020aa7c615000000b0056426d9b4acmr63276edq.41.1708701753024; Fri, 23 Feb
 2024 07:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20240123050354.22152-2-atp.exp@gmail.com>
In-Reply-To: <20240123050354.22152-2-atp.exp@gmail.com>
From: atp exp <atp.exp@gmail.com>
Date: Fri, 23 Feb 2024 20:52:21 +0530
Message-ID: <CAFgBtdHF_-JJFudbvfyMAM=xULf7H3rVGN4qztmCyJZCEmE-_w@mail.gmail.com>
Subject: Re: [PATCH v4] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=atp.exp@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 23 Jan 2024 at 10:34, Abhiram Tilak <atp.exp@gmail.com> wrote:
>
> When running the command `qemu-img snapshot -l SNAPSHOT` the output of
> VM_CLOCK (measures the offset between host and VM clock) cannot to
> accommodate values in the order of thousands (4-digit).
>
> This line [1] hints on the problem. Additionally, the column width for
> the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
> in line [2], resulting in a shortage of space.
>
> [1]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
> [2]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763
>
> This patch restores the column width to 15 spaces and makes adjustments
> to the affected iotests accordingly. Furthermore, addresses a potential
> source
> of confusion by removing whitespace in column headers. Example, VM CLOCK
> is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
> ICOUNT returns no output for clarity.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
> Fixes: b39847a50553 (migration: introduce icount field for snapshots )
> Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
> ---
>  v4:
>     * Fit the column width within 80 characters by shrinking 'ID' field
>     * Add spaces between both fields and values for better spacing and
>        printing
>  v3:
>     * Make a patch by avoid changing the .patch file
>  v2:
>     * Change email provider to 'gmail' to avoid auto-wrapping patches
>     * Modify iotests for file 'qcow2-internal-snapshots.out'
>
>  block/qapi.c                                  | 10 ++--
>  tests/qemu-iotests/176.out                    | 16 +++----
>  tests/qemu-iotests/267.out                    | 48 +++++++++----------
>  .../tests/qcow2-internal-snapshots.out        | 14 +++---
>  4 files changed, 45 insertions(+), 43 deletions(-)
>
> diff --git a/block/qapi.c b/block/qapi.c
> index 9e806fa230..5f2182c406 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -742,15 +742,15 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
>      char *sizing = NULL;
>
>      if (!sn) {
> -        qemu_printf("%-10s%-17s%8s%20s%13s%11s",
> -                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
> +        qemu_printf("%-7s %-16s %8s %19s %15s %10s",
> +                    "ID", "TAG", "VM_SIZE", "DATE", "VM_CLOCK", "ICOUNT");
>      } else {
>          g_autoptr(GDateTime) date = g_date_time_new_from_unix_local(sn->date_sec);
>          g_autofree char *date_buf = g_date_time_format(date, "%Y-%m-%d %H:%M:%S");
>
>          secs = sn->vm_clock_nsec / 1000000000;
>          snprintf(clock_buf, sizeof(clock_buf),
> -                 "%02d:%02d:%02d.%03d",
> +                 "%04d:%02d:%02d.%03d",
>                   (int)(secs / 3600),
>                   (int)((secs / 60) % 60),
>                   (int)(secs % 60),
> @@ -759,8 +759,10 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
>          if (sn->icount != -1ULL) {
>              snprintf(icount_buf, sizeof(icount_buf),
>                  "%"PRId64, sn->icount);
> +        } else {
> +            snprintf(icount_buf, sizeof(icount_buf), "--");
>          }
> -        qemu_printf("%-9s %-16s %8s%20s%13s%11s",
> +        qemu_printf("%-7s %-16s %8s %19s %15s %10s",
>                      sn->id_str, sn->name,
>                      sizing,
>                      date_buf,
> diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
> index 9d09b60452..dce1ca0446 100644
> --- a/tests/qemu-iotests/176.out
> +++ b/tests/qemu-iotests/176.out
> @@ -37,8 +37,8 @@ Offset          Length          File
>  0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
>  0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
>  Snapshot list:
> -ID        TAG
> -1         snap
> +ID      TAG
> +1       snap
>
>  === Test pass snapshot.1 ===
>
> @@ -78,8 +78,8 @@ Offset          Length          File
>  0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
>  0x83400000      0x200           TEST_DIR/t.IMGFMT
>  Snapshot list:
> -ID        TAG
> -1         snap
> +ID      TAG
> +1       snap
>
>  === Test pass snapshot.2 ===
>
> @@ -119,8 +119,8 @@ Offset          Length          File
>  0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
>  0x83400000      0x200           TEST_DIR/t.IMGFMT
>  Snapshot list:
> -ID        TAG
> -1         snap
> +ID      TAG
> +1       snap
>
>  === Test pass snapshot.3 ===
>
> @@ -157,8 +157,8 @@ Offset          Length          File
>  0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
>  0x83400000      0x200           TEST_DIR/t.IMGFMT
>  Snapshot list:
> -ID        TAG
> -1         snap
> +ID      TAG
> +1       snap
>
>  === Test pass bitmap.0 ===
>
> diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
> index 7176e376e1..f6f5d8715a 100644
> --- a/tests/qemu-iotests/267.out
> +++ b/tests/qemu-iotests/267.out
> @@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
> @@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
>  Internal snapshots on overlay:
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  Internal snapshots on backing file:
>
>  === -blockdev with NBD server on the backing file ===
> @@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> ---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  (qemu) loadvm snap0
>  (qemu) quit
>
>  Internal snapshots on overlay:
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  Internal snapshots on backing file:
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  *** done
> diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
> index 438f535e6a..fedb09224e 100644
> --- a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
> +++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
> @@ -14,8 +14,8 @@ wrote 524288/524288 bytes at offset 0
>  (qemu) quit
>
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  No errors were found on the image.
>
>  === Verify that loading the snapshot reverts to the old content ===
> @@ -47,9 +47,9 @@ read 64512/64512 bytes at offset 66560
>  (qemu) quit
>
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> -2         snap1                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
> +2       snap1                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  No errors were found on the image.
>
>  === qemu-img snapshot can revert to snapshots ===
> @@ -79,8 +79,8 @@ read 64512/64512 bytes at offset 66560
>  (qemu) quit
>
>  Snapshot list:
> -ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
> -1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
> +ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
> +1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
>  No errors were found on the image.
>
>  === Error cases ===
> --
> 2.42.1
>

ping

Abhiram,

