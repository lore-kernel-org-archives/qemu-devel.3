Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D856C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublQw-0005SE-PE; Tue, 15 Jul 2025 15:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1ubl87-00023w-Ah
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:15:57 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1ubl84-0003VU-Hi
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:15:55 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 8217F3F412
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1752606949;
 bh=4dblcXqKLHTGAGmcqiKTs/evyLcOqwfNiyLtAlOKjRY=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=fbJmJzmfnV6rBbGL8ZJsT1yVh2qaEKVjb4noXNrCryDIUSuo81OG6E7pcsBBo+wCJ
 i6p2a98LuCXvLU8p//sSpEE2lkGt+0Nzd6wodwSBgiq6xH3aexJ33fFw2+NG3EOYWl
 Bpqg+K+BHPB/nZ7EnNHmi8gtXSnOvrIDTwsCq5Ajfr9+Y69/jJfRBl4XPiUT6d+WIu
 J0Tb8Cpw+iOXh1v02ED9sBgC0E20bL+XmnZYI7IX+XXaLHqNeNF9rPJpshLgHGUaWp
 EBvbEIg3r20SifJsh51QHb5EOv86Tc+rfqAv9UIy03iipRdqAEi5ma2NkFsT5fzRvH
 sblJ/UNjoSB+g==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 630CD7E139
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 19:15:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jul 2025 19:06:10 -0000
From: Jiaxun Yang <1926277@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: dvpe evpe mips mt
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: flygoat hansni philmd
X-Launchpad-Bug-Reporter: Hansni Bu (hansni)
X-Launchpad-Bug-Modifier: Jiaxun Yang (flygoat)
References: <161951518027.9817.15696784713381088226.malonedeb@soybean.canonical.com>
 <20210427133343.159718-1-f4bug@amsat.org>
Message-Id: <970fe4bd-e0a0-4488-8db2-a581568bf090@app.fastmail.com>
Subject: [Bug 1926277] Re: [PATCH v2] target/mips: Only update MVPControl.EVP
 bit if executed by master VPE
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2d6e9435c2df831e66deb7fcbe9f03f78dd14743";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 4ce2637f95a22e0a569ca49aa381e6992a92f233
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1926277 <1926277@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

=E5=9C=A82021=E5=B9=B44=E6=9C=8827=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=
=8D=882:33=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> According to the 'MIPS MT Application-Speci=EF=AC=81c Extension' manual:
>
>   If the VPE executing the instruction is not a Master VPE,
>   with the MVP bit of the VPEConf0 register set, the EVP bit
>   is unchanged by the instruction.
>
> Modify the DVPE/EVPE opcodes to only update the MVPControl.EVP bit
> if executed on a master VPE.
>
> Reported-by: Hansni Bu <https://launchpad.net/%7Ehansni/+contactuser>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1926277
> Fixes: f249412c749 ("mips: Add MT halting and waking of VPEs")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Confirmed with uarch behaviour.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks
Jiaxun


> ---
> Supersedes: <20210427103555.112652-1-f4bug@amsat.org>
> v2: Check VPEConf0.MVP bit (hansni)
> ---
>  target/mips/cp0_helper.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index aae2af6eccc..d5f274f5cdf 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -1635,12 +1635,14 @@ target_ulong helper_dvpe(CPUMIPSState *env)
>      CPUState *other_cs =3D first_cpu;
>      target_ulong prev =3D env->mvp->CP0_MVPControl;
>=20
> -    CPU_FOREACH(other_cs) {
> -        MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
> -        /* Turn off all VPEs except the one executing the dvpe.  */
> -        if (&other_cpu->env !=3D env) {
> -            other_cpu->env.mvp->CP0_MVPControl &=3D ~(1 << CP0MVPCo_EVP);
> -            mips_vpe_sleep(other_cpu);
> +    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
> +        CPU_FOREACH(other_cs) {
> +            MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
> +            /* Turn off all VPEs except the one executing the dvpe.  */
> +            if (&other_cpu->env !=3D env) {
> +                other_cpu->env.mvp->CP0_MVPControl &=3D ~(1 << CP0MVPCo_=
EVP);
> +                mips_vpe_sleep(other_cpu);
> +            }
>          }
>      }
>      return prev;
> @@ -1651,15 +1653,17 @@ target_ulong helper_evpe(CPUMIPSState *env)
>      CPUState *other_cs =3D first_cpu;
>      target_ulong prev =3D env->mvp->CP0_MVPControl;
>=20
> -    CPU_FOREACH(other_cs) {
> -        MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
> +    if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
> +        CPU_FOREACH(other_cs) {
> +            MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
>=20
> -        if (&other_cpu->env !=3D env
> -            /* If the VPE is WFI, don't disturb its sleep.  */
> -            && !mips_vpe_is_wfi(other_cpu)) {
> -            /* Enable the VPE.  */
> -            other_cpu->env.mvp->CP0_MVPControl |=3D (1 << CP0MVPCo_EVP);
> -            mips_vpe_wake(other_cpu); /* And wake it up.  */
> +            if (&other_cpu->env !=3D env
> +                /* If the VPE is WFI, don't disturb its sleep.  */
> +                && !mips_vpe_is_wfi(other_cpu)) {
> +                /* Enable the VPE.  */
> +                other_cpu->env.mvp->CP0_MVPControl |=3D (1 << CP0MVPCo_E=
VP);
> +                mips_vpe_wake(other_cpu); /* And wake it up.  */
> +            }
>          }
>      }
>      return prev;
> --=20
> 2.26.3

--=20
- Jiaxun

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1926277

Title:
  MIPS MT dvpe does not regard VPEConf0.MVP

Status in QEMU:
  Invalid

Bug description:
  Hi,

  According to MIPS32=C2=AE Architecture for Programmers VolumeIV-f: The
  MIPS=C2=AE MT Application-Speci=EF=AC=81c Extension to the MIPS32=C2=AE A=
rchitecture,
  for instruction: dvpe, evpe:

  If the VPE executing the instruction is not a Master VPE, with the MVP
  bit of the VPEConf0 register set, the EVP bit is unchanged by the
  instruction.

  The pseudo code is:

  data =E2=86=90  MVPControl
  GPR[rt] =E2=86=90  data
  if(VPEConf0.MVP =3D 1) then
    MVPControl.EVP =E2=86=90  sc
  endif

  However the helper functions of dvpe, evpe does not regard the
  VPEConf0.MVP bit, namely, it does not check if the VPE is a master
  VPE. Code is copied below as:

  target_ulong helper_dvpe(CPUMIPSState *env)
  {
      CPUState *other_cs =3D first_cpu;
      target_ulong prev =3D env->mvp->CP0_MVPControl;

      CPU_FOREACH(other_cs) {
          MIPSCPU *other_cpu =3D MIPS_CPU(other_cs);
          /* Turn off all VPEs except the one executing the dvpe.  */
          if (&other_cpu->env !=3D env) {
              other_cpu->env.mvp->CP0_MVPControl &=3D ~(1 << CP0MVPCo_EVP);
              mips_vpe_sleep(other_cpu);
          }
      }
      return prev;
  }

  Is this a bug?

  QEMU head commit: 0cef06d18762374c94eb4d511717a4735d668a24 is checked.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1926277/+subscriptions


