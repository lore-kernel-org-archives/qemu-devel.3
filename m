Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD8BC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZNN-0002zz-QO; Thu, 27 Aug 2026 08:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1wzZNJ-0002zU-RR; Thu, 27 Aug 2026 08:38:34 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1wzZNH-0006dw-Cs; Thu, 27 Aug 2026 08:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1787834311; x=1819370311;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+zNOMXJD5XtvBS1QGG2L/uqrzl5jpIUasRZpOO3HbiQ=;
 b=ZG/n5VUZEW3VkTbBvRQ86dvN2MTWrCjPeDkRRkad+tj5vJDXUWwZ4Nor
 1W0LJGOD3sZOU6fRObMAFvGJp79XXu3PMtIUypxLDh6BPv+R3NjeiWwh2
 NjBuXYVhAaWirgObzr0HUJAeg/HVrU5wcEmj43D5D77MEllR+60cHZZ4+
 UET9CdOGr3i3X5OjbhywtJgAMxypPdZjKj0R1UMsA5yJdeI4vqtwxaVUg
 DEY7AhgdptDs2qGjyIHLfFpAz4sJGGfFY8ZOcvMWeL21dJv6aETL2Q6ny
 sAopp0/kAnYgGNCvid/4JX0D20M7g7czSP39CLOZLwbL5MK2DRZ8pZ1aU g==;
X-CSE-ConnectionGUID: rJ2xhWS9Q0SQyQYQFK29Ow==
X-CSE-MsgGUID: OQfJjkL1Sg6YbaD7eVXmHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="252822217"
X-IronPort-AV: E=Sophos;i="6.25,246,1779116400"; d="scan'208";a="252822217"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 21:38:25 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 4A79610000E9;
 Thu, 27 Aug 2026 12:38:25 +0000 (UTC)
Received: from az2nlsmom2.o.css.fujitsu.com (unknown [10.150.26.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 019C71004169;
 Thu, 27 Aug 2026 12:38:25 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.202.6])
 by az2nlsmom2.o.css.fujitsu.com (Postfix) with SMTP id 729FC180219D;
 Thu, 27 Aug 2026 12:38:19 +0000 (UTC)
Date: Thu, 27 Aug 2026 21:38:17 +0900
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, 
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v2 00/24] Add Realm support to QEMU-VMM
Message-ID: <apAs7L1-QBOTUNtH@FCCLS0092175.localdomain>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain> <ao4Eetq7oAAsipo4@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ao4Eetq7oAAsipo4@p14s>
Received-SPF: pass client-ip=207.54.90.49; envelope-from=enju.kohei@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Kohei Enju <enju.kohei@fujitsu.com>
From:  Kohei Enju via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/25 15:09, Mathieu Poirier wrote:
> Hi Kohei - apologies for the delayed reply.
> 
> On Thu, Jul 30, 2026 at 02:11:57PM +0900, Kohei Enju wrote:
> > On 07/28 13:26, Mathieu Poirier wrote:
> > > This patchset provides minimal functionality to start a Realm VM
> > > from an Arm RME capable host using the following command line:
> > > 
> > > qemu-system-aarch64 \
> > >  -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
> > >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > > 
> > > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > > back.  It is compatible with Steven Price's v14 revision [1] of his work adding
> > > CCA support to KVM.
> > > 
> > > * We are currently working on rebasing the work to v15.
> > > 
> > > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > > here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
> > > machine (compatible with Steven's v14 patchset).
> > > 
> > > Instructions to compile and run the entire stack can be found here [6].
> > > 
> > > Device Assignment is not included.
> > > 
> > > Thanks,
> > > Mathieu
> > 
> > Hi Mathieu, thank you for your work on upstreaming CCA support. I've
> > tested this series in QEMU-TCG(x-rme=on) environments and confirmed
> > that the basic functionality works well.
> > 
> > I have a question about a QMP command for querying CCA capabilities.
> > 
> > Jean's tree contains the following commit adding such a QMP command. Was
> > this functionality intentionally omitted from this series?
> > https://git.codelinaro.org/linaro/dcap/qemu/-/commit/41f7852cc8590a38c47299a35a7238da09ff9a12
> >
> 
> git.codelinaro.org is no longer accessible to me.  Please see if you can point
> me to the same patch in this repository:
> 
> https://gitlab.com/Linaro/cca-public/qemu/-/commits/cca/2025-09-12?ref_type=heads

Hi, thank you for taking a look.

I checked the repository, but could not find the corresponding patch
there. If you agree, I would be happy to share a version of that patch,
updated as needed and rebased onto the latest v3 series.

Thanks,
Kohei

> 
>  
> > We are interested in adding this functionality because we are also
> > planning to upstream CCA support for libvirt, which will need a QMP
> > interface to query the CCA capabilities exposed by QEMU.
> > 
> > Since the Linux kernel dropped some configuration parameters such as the
> > hash algorithm, I need to rework the implementation of that QMP command
> > a bit. If it's okay with you, I'd be happy to send out the reworked
> > patch based on this series.
> > 
> > Thanks,
> > Kohei
> > 

