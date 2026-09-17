Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED9AC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Din-0001tp-Fo; Thu, 17 Sep 2026 11:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x7Dih-0001tU-6x; Thu, 17 Sep 2026 11:08:15 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x7Dif-0008Oh-4c; Thu, 17 Sep 2026 11:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=xeY90yYXCyV+tfZgTInv2vgxn0qcluL7JSw3wAYZHPE=; b=w8qCGbkaatCIFb3
 al4sEproQ91gcUoCx8wI6pzmXgcM4lbqI89jlUiF0vQG4OS5Mk+r0CLuae3KRWM0VGJ3TmJLUtOAP
 tjpGFTf1OyzB0xW/XIe55iUFJDjCbiJdVzdwU6+gG6bLCZ+NxanVhpiciL24RecMjEXcGxB6/82V+
 C4=;
Date: Thu, 17 Sep 2026 17:13:36 +0200
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
Subject: Re: [PATCH v4 09/12] hw: Add availfn arg to DEFINE_MACHINE_EXTENDED()
Message-ID: <aqwDX2AySxBGf7VE@hive.localdomain>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-9-babc367b60f5@rev.ng>
 <22c1ad3a-c5ed-4ab0-be1f-c5b043bd67e5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22c1ad3a-c5ed-4ab0-be1f-c5b043bd67e5@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/09/26, Pierrick Bouvier wrote:
> On 9/16/2026 2:19 AM, Anton Johansson wrote:
> > Allows specifying is_available when defining machines using convenience
> > macros.  Also introduces DEFINE_MACHINE_WITH_GUARD() replacing
> > DEFINE_MACHINE() for machines that need to specify is_available.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >  include/hw/core/boards.h | 11 ++++++++---
> >  hw/arm/bananapi_m2u.c    |  2 +-
> >  hw/arm/cubieboard.c      |  2 +-
> >  hw/arm/imx8mm-evk.c      |  2 +-
> >  hw/arm/integratorcp.c    |  2 +-
> >  hw/arm/mcimx7d-sabre.c   |  2 +-
> >  hw/arm/orangepi.c        |  2 +-
> >  hw/ppc/pegasos.c         |  3 ++-
> >  8 files changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> > index dba465efc2..8c35516622 100644
> > --- a/include/hw/core/boards.h
> > +++ b/include/hw/core/boards.h
> > @@ -514,7 +514,7 @@ struct MachineState {
> >   */
> >  
> >  #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
> > -                                machine_initfn, ABSTRACT, ifaces...) \
> > +                                machine_initfn, ABSTRACT, availfn, ifaces...) \
> >      static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
> >      { \
> >          MachineClass *mc = MACHINE_CLASS(oc); \
> > @@ -526,6 +526,7 @@ struct MachineState {
> >          .class_init = machine_initfn##_class_init, \
> >          .instance_size = sizeof(InstanceName), \
> >          .abstract = ABSTRACT, \
> > +        .is_available = availfn, \
> >          .interfaces = ifaces, \
> >      }; \
> >      static void machine_initfn##_register_types(void) \
> > @@ -536,11 +537,15 @@ struct MachineState {
> >  
> >  #define DEFINE_MACHINE(namestr, machine_initfn) \
> >      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> > -                            false, NULL)
> > +                            false, NULL, NULL)
> > +
> > +#define DEFINE_MACHINE_WITH_GUARD(namestr, machine_initfn, availfn) \
> > +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> > +                            false, availfn, NULL)
> >  
> >  #define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\
> >      DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> > -                            false, ifaces)
> > +                            false, NULL, ifaces)
> >  
> >  #define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
> >      DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
> > diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> > index 8f59111fd4..7b86986efb 100644
> > --- a/hw/arm/bananapi_m2u.c
> > +++ b/hw/arm/bananapi_m2u.c
> > @@ -153,4 +153,4 @@ static void bpim2u_machine_init(MachineClass *mc)
> >  }
> >  
> >  DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
> > -                        bpim2u_machine_init, false, NULL)
> > +                        bpim2u_machine_init, false, NULL, NULL)
> > diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> > index ae27056938..da45bb2be5 100644
> > --- a/hw/arm/cubieboard.c
> > +++ b/hw/arm/cubieboard.c
> > @@ -134,4 +134,4 @@ static void cubieboard_machine_init(MachineClass *mc)
> >  
> >  DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
> >                          cubieboard_machine_init, false,
> > -                        NULL)
> > +                        NULL, NULL)
> > diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
> > index 8a5737502f..68526c0e43 100644
> > --- a/hw/arm/imx8mm-evk.c
> > +++ b/hw/arm/imx8mm-evk.c
> > @@ -135,4 +135,4 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
> >  
> >  DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
> >                          imx8mm_evk_machine_init, false,
> > -                        NULL)
> > +                        NULL, NULL)
> > diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> > index 382ea7850d..6314bbb6c1 100644
> > --- a/hw/arm/integratorcp.c
> > +++ b/hw/arm/integratorcp.c
> > @@ -705,7 +705,7 @@ static void integratorcp_machine_init(MachineClass *mc)
> >  
> >  DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
> >                          integratorcp_machine_init, false,
> > -                        NULL)
> > +                        NULL, NULL)
> >  
> >  static const Property core_properties[] = {
> >      DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
> > diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
> > index db8a62e5f6..2c884b5c78 100644
> > --- a/hw/arm/mcimx7d-sabre.c
> > +++ b/hw/arm/mcimx7d-sabre.c
> > @@ -87,4 +87,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
> >  
> >  DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
> >                          mcimx7d_sabre_machine_init, false,
> > -                        NULL)
> > +                        NULL, NULL)
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > index 7a19732f5d..87ed2ef4b6 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -134,4 +134,4 @@ static void orangepi_machine_init(MachineClass *mc)
> >  
> >  DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
> >                          orangepi_machine_init, false,
> > -                        NULL)
> > +                        NULL, NULL)
> > diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
> > index 9d7e279123..cbff8bb59d 100644
> > --- a/hw/ppc/pegasos.c
> > +++ b/hw/ppc/pegasos.c
> > @@ -788,7 +788,8 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
> >  }
> >  
> >  DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
> > -                        pegasos_machine_init, true, (const InterfaceInfo[]) {
> > +                        pegasos_machine_init, true, NULL,
> > +                        (const InterfaceInfo[]) {
> >                          { TYPE_PPC_VIRTUAL_HYPERVISOR },
> >                          { TYPE_VOF_MACHINE_IF }, { } })
> >  
> > 
> 
> Since full filtering concept was dropped for now, and since
> there are not so many usage of DEFINE_MACHINE in the codebase, maybe we
> can simply do a full declaration when a guard need to be set.
> 
> In current series, only one occurence would need this: boston-aia.
> 
> Regards,
> Pierrick

Good point I'll drop this patch then and just expand fully for
boston-aia then, similar to other targets, thanks!:)

-- 
Anton Johansson
rev.ng Labs Srl.

