Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE101CED617
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKrq-0001Yk-8j; Tue, 18 Nov 2025 07:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vLKrj-0001Xl-TS
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vLKri-0006iX-7U
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763469080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoeyg8fcjbOiKJDcscOU2D+OfGqbj8Jwb656PRkl3eY=;
 b=FQoSTRQVq+teHziwyBH3HoU9PVoxqCSQwPZqKYp5H6ESmZLrlgf7NZMvyH7Xu335oCWRrC
 memYAxTt5UnSfjgMxd+Go4rr7YixTcDzOojWYXwocqd1l5mBR21yQaPHHP3vJfq5UHT5NJ
 Fn5wiCePyMuHPxp8iB5xVP4C18iCF5w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-c4QMgtWYMeeAtXiSi5TTJA-1; Tue,
 18 Nov 2025 07:31:19 -0500
X-MC-Unique: c4QMgtWYMeeAtXiSi5TTJA-1
X-Mimecast-MFC-AGG-ID: c4QMgtWYMeeAtXiSi5TTJA_1763469077
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A675B1801230; Tue, 18 Nov 2025 12:31:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0517180047F; Tue, 18 Nov 2025 12:31:14 +0000 (UTC)
Date: Tue, 18 Nov 2025 12:31:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 1/2] hw/arm/imx8mp-evk: Add KVM support
Message-ID: <aRxnDwwaww8tjMqh@redhat.com>
References: <20251101120130.236721-1-shentey@gmail.com>
 <20251101120130.236721-2-shentey@gmail.com>
 <87v7j8r399.fsf@redhat.com>
 <CAFEAcA_XORdwONC2YbVKPois6BLPEr0dFt_QjTHE=UWmiCiv-g@mail.gmail.com>
 <2EAC1B70-89DE-4694-A4E8-350DC6F9C343@gmail.com>
 <8a86dfaf-eba5-4348-8885-58c520355e47@linaro.org>
 <6e77db29-fb0a-7beb-3cb6-5ab14b3a86cf@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e77db29-fb0a-7beb-3cb6-5ab14b3a86cf@eik.bme.hu>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 18, 2025 at 01:25:23PM +0100, BALATON Zoltan wrote:
> On Tue, 18 Nov 2025, Philippe Mathieu-Daudé wrote:
> > On 18/11/25 10:49, Bernhard Beschow wrote:
> > > Am 17. November 2025 17:38:03 UTC schrieb Peter Maydell
> > > <peter.maydell@linaro.org>:
> > > > On Mon, 17 Nov 2025 at 17:13, Cornelia Huck <cohuck@redhat.com> wrote:
> > > > > Running current master (resp. with this patch applied), I'm getting make
> > > > > check failures on an aarch64 (Mt. Snow) host ("qemu-system-aarch64:
> > > > > unknown type 'arm-gicv3'" while using this machine); going back right
> > > > > before this patch, everything works fine. Haven't tried to debug this
> > > > > yet (maybe I'm the one with the weird config again...)
> > > > 
> > > > Is this a KVM-only config (no TCG) ?
> > > > 
> > > > I think this happens because the KConfig now says
> > > > +    depends on TCG || KVM
> > > > 
> > > > but because the machine by default doesn't use KVM then
> > > > trying to run the machine with no extra arguments falls
> > > > over if TCG isn't present.
> > > > 
> > > > This thing we put in to handle "creation of the SoC object
> > > > via device introspection means it doesn't have an ms->cpu_type
> > > > to look at":
> > > > 
> > > > +    const char *cpu_type = ms->cpu_type ?:
> > > > ARM_CPU_TYPE_NAME("cortex-a53");
> > > > 
> > > > also probably won't do anything useful under a KVM-only config.
> > > > 
> > > > I think the simplest thing here is to put the KConfig back to:
> > > > 
> > > >   depends on TCG && AARCH64
> > > > 
> > > > People building a KVM-only config almost certainly do not
> > > > want this machine type and its devices, because the main
> > > > reason to build KVM-only is because you're in the
> > > > "virtualization use case" and want to not build in a
> > > > load of not-security-supported machine types.
> > > 
> > > Do we need this treatment for further machines, e.g. isapc, e500,
> > > mips? Or shall the CPU type handling in the SoC consider
> > > kvm_enabled()?
> > 
> > Good point. My understanding is only virt x86/arm/ppc64/s390x are
> > "security covered", but there is no explicit mention of that in
> > our doc. (btw why not include isapc? as it is a subset of other
> > covered x86 machines?)
> 
> Maybe because you can't run isapc with KVM because it's limited to Pentium
> but 32bit host support is removed? Or should we keep the ability to run it
> with newer CPUs for KVM?

32-bit host support removal is irrelevant. We still fully support 32-bit
guests, and they can use KVM. It is upto the user to disable the LM CPU
flag if they wish to, though it shouldn't matter because if the OS running
on isapc is that old it'll not even look for the "LM" flag to begin with,
and so the CPU will never get switchd into 64-bit mode. 

Note, a run of ./configure' with TCG disabled only is NOT claiming to be
providing a minimal virtualization build. It is simply discarding TCG.

If people want a minimal build, they're expected to customize the
KConfig files to suit their needs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


