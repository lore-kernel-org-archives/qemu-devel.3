Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF4CD3420
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 06:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skeG8-0005ga-A2; Sun, 01 Sep 2024 02:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1skeG7-0005fc-2F; Sun, 01 Sep 2024 02:40:23 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1skeG4-0003Ij-5d; Sun, 01 Sep 2024 02:40:22 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id F19B6A40B3D;
 Sun,  1 Sep 2024 06:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6867FC4CEC3;
 Sun,  1 Sep 2024 06:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725172809;
 bh=tmjR4zaDQqO7YRVjV6+NxBxXp7jCIOzTqAf/ZYvJSWg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ldjtfvUatoq9YBC87fc5MdxjbiEcER9AURhuULLUaCOs071PXg1Dl+BfXWACnwyu/
 PBQLg33aUl579Oda2tTd4R1NGJw1EWpEUBHSds9n0YlfHEO7DA5874CJ1a5LoYG3Yt
 ZLPUP9Cp1JHRmHzjQGBCHDMwYpvqK0Q7fcE2m3GsawMWKCee+4s8a844L/OdzGLIuS
 18rliCCCPbBuoet2xQBgRNJpGPSfHaGzhVx8bS3CsPig3sH5UUJDhsO5AB8gECihDe
 QmC3QlDrl4CPl9LWHiCnhPsxGYcn03VR8ZyyE9LL9mQbL8kEFfHE7VsW2Ic6ylgLzr
 lbmjatXIuz6tA==
Date: Sun, 1 Sep 2024 08:40:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 11/12] target/arm: add an experimental mpidr arm cpu
 property object
Message-ID: <20240901084004.166a3c96@sal.lan>
In-Reply-To: <CAFEAcA-wD6U+onh3y4Y-LDTFuYoeWbGShkRPx7emi1ZPfKJP0w@mail.gmail.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <b88fe895e6f71711387ca153f4f1b3fbb0aa2176.1724556967.git.mchehab+huawei@kernel.org>
 <CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com>
 <20240826035324.6b1edcc7@sal.lan>
 <CAFEAcA-wD6U+onh3y4Y-LDTFuYoeWbGShkRPx7emi1ZPfKJP0w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Em Fri, 30 Aug 2024 17:27:27 +0100
Peter Maydell <peter.maydell@linaro.org> escreveu:

> On Mon, 26 Aug 2024 at 04:12, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Sun, 25 Aug 2024 12:34:14 +0100
> > Peter Maydell <peter.maydell@linaro.org> escreveu:
> >  
> > > On Sun, 25 Aug 2024 at 04:46, Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote:  
> > > >
> > > > Accurately injecting an ARM Processor error ACPI/APEI GHES
> > > > error record requires the value of the ARM Multiprocessor
> > > > Affinity Register (mpidr).
> > > >
> > > > While ARM implements it, this is currently not visible.
> > > >
> > > > Add a field at CPU storing it, and place it at arm_cpu_properties
> > > > as experimental, thus allowing it to be queried via QMP using
> > > > qom-get function.  
> > >  
> > > >  static Property arm_cpu_properties[] = {
> > > >      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> > > > +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
> > > >      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> > > >                          mp_affinity, ARM64_AFFINITY_INVALID),
> > > >      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),  
> > >
> > > Why do we need this?  
> >
> > The ACPI HEST tables, in particular when using GHESv2 provide
> > several kinds of errors. Among them, we have ARM Processor Error,
> > as defined at UEFI 2.10 spec (and earlier versions), the Common
> > Platform Error Record (CPER) is defined as:
> >
> >    https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html?highlight=ghes#arm-processor-error-section
> >
> > There are two fields that are part of the CPER record. One of them is
> > mandatory (MIDR); the other one is optional, but needed to decode another
> > field.
> >
> > So, basically those errors need them.  
> 
> OK, but why do scripts outside of QEMU need the information,
> as opposed to telling QEMU "hey, generate an error" and
> QEMU knowing the format to use? Do we have any other
> QMP APIs where something external provides raw ACPI
> data like this?

This was discussed during the review of this patch series. 

See, the ACPI Platform Error Interfaces (APEI) code currently in QEMU
implements limited support for ACPI HEST - Hardware Error Source Table [1].

[1] https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source

HEST consists of, currently, 9 error types (plus 3 obsoleted ones). Among 
them, there is support for generic errors via GHES and GHESv2 types. 
While not officially obsoleted, GHES is superseded by GHESv2.

GHESv2 (and GHES) has a section type field to identify which error type it
is [2]. Currently, there are +10 defined UUIDs for the section type. 

[2] https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#section-descriptor

The current code on ghes.c implements GHESv2 support for a single
type (memory error), received from the host OS via SIGBUS.

Testing such code and injecting such error is not easy, as the host OS needs
to send a SIGBUS to the guest, this reflecting an error at the main OS.
Such code also has several limitations.

-

At the first three versions of this patch set, the code was just doing
like what you said: it was adding an error injection for a HEST GHESv2 
ARM Processor Error. So the error record (CPER) were produced in QEMU using 
some optional parameters passed via QMP to change fields when needed. 
With such approach, QEMU could use directly the value from MIDR and MPIDR.

The main disadvantage is that, to make full support of HEST, a lot
of code will be needed to add support for every GHESv2 type and for
every GHESv2 section type. So, the feedback we had were to re-implement
it into a generic way.

The generic CPER error inject approach (since v4 of this series), has
soma advantages:

- it is easy to do fuzz testing, as the entire CPER is built via a python
  script;
- no need to modify QEMU to support other GHESv2 types of record and
  to support other types of processors;
- GHESv2 fields can also be dynamically generated;
- It shouldn't be hard to change the code to support other types of
  HEST table (currently, only GHESv2 is supported).

The disadvantage is that queries are needed to pick configuration and
register values from the current emulation to do error injection. For
ARM Processor Error, it means that MPIDR and MIDR, are needed. Other 
processors and other error types will also require to query other data
from QEMU, either using already-existing QMP code or by adding new ones.

Yet, the amount of code for such queries seem to be smaller than the
amount of code to be added for every single GHESv2/HEST type.

-

Worth saying that QEMU may still require internal HEST/GHES errors to be 
able to reflect at the guests hardware problems detected at the host OS. 

So, for instance, if a host OS memory is poisoned due to hardware errors,
QEMU and guests need to know, in order to kill processes affected
by a bad memory. 

Regards,
Mauro

