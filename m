Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B62CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbr4o-00061U-E9; Mon, 22 Jun 2026 22:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbr4n-0005yw-Kf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:41:25 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbr4m-0007oy-1f
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:41:25 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-697b8540279so2086482a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782182482; cv=none;
 d=google.com; s=arc-20240605;
 b=hyDz5NqTl2xp38MR9UZ/BsUCCzO8xIqgG5XR7YT3zqOgo3g/ZldUFhOkbXBG6gZfgg
 WdWCR5+7YqhReEj5pOwSpd3O3GsM11jyvA0VQ0oY4ueW5O55L7JfdUf1c+GAHXjHTv+R
 cq6h+ETkagb6QiABdR9DlQZdAWiVHEM+GHIJw6m+lSdnkmrMnYh1jX4NevjWUSMx6dxt
 WOkhIW/pC1ScVAwpGffQbUzAv9IBP8rsECttUYfOJLqI6ZrlcDEwtr1r+bLskdUpv3zU
 q2AtFA5eeVxSxPYdI2hkDiEjoJ1X2KF830fmFmpzzKpYylUEbHE6lcfxIZvZQJmtUkM4
 l+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jO3or3pR0/dJI2DbKjEu4+x3bVF+eBMI5ZWlVPELNqc=;
 fh=Q6j8XxSEtDgqmNP/9Rv1psPbq8Hu5MTrcYTu9CNSemY=;
 b=HksID8VhfsO6+AHKdlNZumnUqibsc8hSljIFmUX8lYAuyAQxqBIZgR9bP1BqqNktwn
 Kt52L6K2niMO8z+L2A0Kpxp1jyHw74JQFMMd38Fsv8rpGwBsFF45BtmLf3SoO2edHZV3
 0WFngBI2z6Pk6De9E/Sy2ARF6vQ86krivsviFgRcYb8AxDdjo4WExWGo7YbNOQNn4t0z
 oEXb2PSmi0lkKptcRyzYkIdhjAOSNUqObWn/sGY9NC1RguaDpKUiLVPwn526WmU2RhT1
 omzISq+5XdfbUxxfbr+hf6+NYdZMdJB4YZWS5lCbripAb3P9eitl9XOJlmvOYiDQxAjB
 a16w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782182482; x=1782787282; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jO3or3pR0/dJI2DbKjEu4+x3bVF+eBMI5ZWlVPELNqc=;
 b=F3X+jbvCxlt/cB1QSq+dbaGNhXUz7KzX+N411vo4vJf3oZ3u8Ix8fppusR4r6W00tm
 /YypC4PyvB8U2BpSy1QjAuz9KD4ACpoBnpb2HYWiVyOaAM5mUWiqPDkcEOvPjj3FMdsH
 gWGRXMyVo7bxDaHUYUJOeCB78upRuGEK7HUCtxZE6Vpo2Srb/7nHwKH6uJQLgV6iyPTZ
 9nVmpHwRbdb6F0G7XDq3h1sRHdGHEVsNvcVdgvbK2LcGRMzWrBvbmkzL6KiN/gJqOBKm
 CKMzrbFx9KoeuVTiNqZN/Ka77vuEhnbAfAbpkCegrldLibD8QyYfYNJr3ffQRBRfr3t3
 XjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782182482; x=1782787282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jO3or3pR0/dJI2DbKjEu4+x3bVF+eBMI5ZWlVPELNqc=;
 b=VeliaPzUgC/maKXjwij9vjgxw34bMxaOBewb65SXsu560be6qdAzjmipCt35dMxgiv
 BbCK5vTVfoux1+JCRfVMsUBfLYT09+HiHNJzUVD6MxCa0qQESBah2780T1WdiozImh+1
 5AEkseWA/qxOQXM8n4cY8mY/HcjfGVCPPNgGuIMI3rwLbftKC9DyY2IxszCY3fTGgYF2
 RVf1aDDcE9fVqtFYb3xiJkKRp8CA/v9LfowQiS0auhv1hQZyymljXD425UwtVwL6NS7h
 hMvvfGmhxxPnjUxCMD7AdTxusxLsVMtN3l0JPA8POSttQ1eSwVj9OhZJD+OL+I4CqhkW
 2+Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jYIDHkxwrrAxnW0wngmHgO5Wa5yDg4j964pJF5oe5GYP6rpyUjyTI5r2/qfxd+rbMqgDbth/9wnG8@nongnu.org
X-Gm-Message-State: AOJu0YzwQZKdx0/2YA+kGMVDtM1KetKBifWGgGu6tDXOMj3sKg3GpgwB
 VMkCfWwqMoHoaxo58uokk7ObXybxoFZrOxDX9qfIsMSQ+Xzg+GGjdf5vrl0I7Urs0OXxm5jRn1h
 cwX0e7kF9LZNDUJIqhnIy2172vsxwQTE=
X-Gm-Gg: AfdE7clT79s1UeQ43VFsxA+hg+oDTo0nqH9YPss4lJSGS7rleNWqrhx0zrHTsH+R5hy
 ZQFpraMLNy7x86gFUuk3VZHyTjhiczBL70NtyRtrRs5EB4r5hnSVekhNETLfkHZKKwRGRORTPJB
 jejmNG6SpA9Xd1frtaZ9sXsP1ZDL0FB+GoZPmggpMlOLgnuZx3Rwlq5CfbX9mJtFZAuz9c86xKG
 sFmpRdBVBZJuIlAfgmVTlBcVO7UAHkuzHsLwm1Vi/LBGEWzZy+nZ9ZvDEEKlONW7MbbQ/LoFrpl
 5TrcrcR/GyiMyF2w6v/lwM8CVMtbhTceWRwOaA==
X-Received: by 2002:a05:6402:3488:b0:68f:c62d:b36d with SMTP id
 4fb4d7f45d1cf-697dbafa348mr269095a12.27.1782182481524; Mon, 22 Jun 2026
 19:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260619044838.1054677-1-joel@jms.id.au>
 <20260619044838.1054677-9-joel@jms.id.au>
In-Reply-To: <20260619044838.1054677-9-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jun 2026 12:40:55 +1000
X-Gm-Features: AVVi8CcP94QEz5_Nr9m0f-movpmGW36RI8Eoy48VqI01QM2TaV1lh2xBJ8Z5PEU
Message-ID: <CAKmqyKML0szhhJv_pb=+oNZJwZhurn9k1La+FgiAHmBCYYFW+w@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] hw/riscv/atlantis: Provide a simple halting
 payload
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Jun 19, 2026 at 2:52=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> OpenSBI hangs before any console output if the domain init code sees the
> next stage is not in an executable region.
>
> If no kernel payload is provided to QEMU, the next stage address is
> NULL, and the riscv virt machine memory map ends up covering the 0
> address with the catch all S-mode RWX region and so OpenSBI prints
> console messages and does not hang until the next stage boot.
>
> The Tenstorrent Atlantis machine address map has RAM starting at 0 and
> it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
> tripping the early check and hang.

Ok, so I looked at this today and I think this commit message and
approach aren't the way to go.

I do think the commit message is a bit confusing and not entirely
accurate. What about something like this (might need a tidy up, but
you should get the point):

commit aac25688634d1afe6735cb71d8dd1ea652fa90d4 (HEAD -> riscv-to-apply.nex=
t)
Author: Alistair Francis <alistair.francis@wdc.com>
Date:   Tue Jun 23 12:37:47 2026 +1000

   hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr

   When using OpenSBI fw_dynamic on the Atlantis board OpenSBI fails
   to print any output, as it hits an error early on
   in the boot process and gets stuck in `sbi_hart_hang()`.

   The error occurs in the `sanitize_domain()` function inside OpenSBI.
   `sanitize_domain()` is called after a M-Mode OpenSBI Firmware and a gene=
ric
   coverall S-Mode RWX memory region are created. `sanitize_domain()` is
   checking that the next address is executable.

   If no next address is provided (which occurs on QEMU with an empty paylo=
ad),
   then `dom->next_addr` will be 0. On most RISC-V boards address 0 will fa=
ll
   inside the coverall S-Mode RWX memory region and pass this check. On
   Atlantis the OpenSBI firmware is running at address 0, so this address
   falls inside the M-Mode only OpenSBI firmware region and fails the check=
.

   Once the check has failed OpenSBI aborts and the user doesn't see any
   messages. This can be fixed by either supplying a payload, or just
   manually forcing a non-zero address (actually just any address that
   isn't the OpenSBI firmware) for next_addr.

   This patch ensures that if no kernel is loaded we still specify a
   default kernel_entry so that OpenSBI happily boots and jumps to
   the first address in memory.

   Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index b40a893a37..dba56ad6e1 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -444,8 +444,15 @@ static void tt_atlantis_machine_done(Notifier
*notifier, void *data)
    if (machine->kernel_filename) {
        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                          true, NULL);
+        kernel_entry =3D boot_info.image_low_addr;
+    } else {
+        /* If we aren't loading a payload, OpenSBI thinks we are trying to=
 boot
+         * address 0, which fails `sbi_domain_check_addr()` as that is whe=
re
+         * OpenSBI is running. Let's tell OpenSBI to start running at the =
start
+         * of memory so we at least let OpenSBI complete.
+         */
+        kernel_entry =3D kernel_start_addr;
    }
-    kernel_entry =3D boot_info.image_low_addr;

    fdt_load_addr =3D riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
                                           s->memmap[TT_ATL_DDR_LO].size,

