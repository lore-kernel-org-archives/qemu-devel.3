Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22404C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6uX-0004xC-Er; Thu, 05 Jun 2025 05:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN6uV-0004wZ-Sl
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN6uS-0003Rr-R1
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749115756;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9zL5LEaPjqUFLxaOIp/iNAL+6a3rEtz4Spc2ERE/gM=;
 b=MvZ4zPhvkJQ2/txnW2Aah3djfRT8E5+tckKEmuZPAD8TP+y1+ohDMR7N81QnE/1d0gAcsM
 LGzB9c8Fi1eHf2AHGdLPJo8xSX10/xwNB3OkryWn+CILoP8OvCgnPIQpQ/sDIxqP0p0uBD
 a9FpJ8IickRdrGnLkS0owy800mubPLk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-v6KE27B6P3S0jakUIlTpWw-1; Thu,
 05 Jun 2025 05:29:12 -0400
X-MC-Unique: v6KE27B6P3S0jakUIlTpWw-1
X-Mimecast-MFC-AGG-ID: v6KE27B6P3S0jakUIlTpWw_1749115751
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B71319560BD; Thu,  5 Jun 2025 09:29:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 392411954B3C; Thu,  5 Jun 2025 09:28:55 +0000 (UTC)
Date: Thu, 5 Jun 2025 10:28:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Message-ID: <aEFjUWoK8mVqxOmU@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
 <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
 <aDad5elq0bgZ/tvp@intel.com>
 <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
 <973e1fb8-e138-44bd-be73-9d53d9bed75c@intel.com>
 <20250605110930.7659fa39@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605110930.7659fa39@imammedo.users.ipa.redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 05, 2025 at 11:09:30AM +0200, Igor Mammedov wrote:
> On Tue, 3 Jun 2025 23:54:19 +0800
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
> > On 6/3/2025 11:02 PM, Igor Mammedov wrote:
> > > On Wed, 28 May 2025 13:23:49 +0800
> > > Zhao Liu <zhao1.liu@intel.com> wrote:
> > >   
> > >> On Wed, May 28, 2025 at 10:09:56AM +0800, Xiaoyao Li wrote:  
> > >>> Date: Wed, 28 May 2025 10:09:56 +0800
> > >>> From: Xiaoyao Li <xiaoyao.li@intel.com>
> > >>> Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid
> > >>>   field
> > >>>
> > >>> On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:  
> > >>>> The X86CPU::check_cpuid boolean was only set in the
> > >>>> pc_compat_2_4[] array, via the 'check=off' property.
> > >>>> We removed all machines using that array, lets remove
> > >>>> that CPU property and simplify x86_cpu_realizefn().  
> > >>>
> > >>> No.
> > >>>
> > >>> We cannot do this. Because it changes the behavior of QEMU.
> > >>>
> > >>> 'check_cpuid' is true by default while 'enforce_cpuid' is false. So that
> > >>> QEMU emits warnings in x86_cpu_filter_features() by default when user
> > >>> requests unsupported CPU features. If remove "check" property and the
> > >>> internal 'check_cpuid', QEMU will not do it unless user sets enforce_cpuid
> > >>> explicitly.  
> > >>
> > >> One option would be to have x86_cpu_filter_features() unconditionally
> > >> turn on verbose and print warnings, but some people might want to turn
> > >> off these warning prints, I don't know if anyone would, but it would be
> > >> possible.
> > >>
> > >> The other option is still to keep the “check” property.
> > >>
> > >> IMO, the latter option is the better way to reduce Philippe's burden.  
> > > 
> > > we essentially loose warnings by default when some features aren't available,
> > > qemu still continues to run though.
> > > 
> > > Given that Daniel acked it from libvirt side, libvirt doesn't care about warnings
> > > (it does its has its own cpu model calculation). Likely other mgmt do not care
> > > about it either, and if they do they probably doing something wrong and
> > > should use QMP to get that data.
> > > That leaves us with human users, for that case I'd say one should use
> > > enforce_cpuid if feature availability matters.  
> > 
> > But with "check", it allows the VM to continue running with the 
> > unsupported bits cleared and warnings to inform users. This is really 
> > friendly.
> 
> it's friendly for human users (mostly developers), but for upper layers
> is doesn't make a difference, since it's noise in logs nobody reads until
> qemu somehow works.

The latter statement is accurate. In the libvirt case, this info ends up
in the per-VM logfile, which is one of the key files humans look at first
when triaging any QEMU related bug reports.

> 
> the 1st category can and should use enforce flag instead to get what they ask for
> if they care about it.
> If missing feature bits do not matter then it warnings shouldn't matter either.

I don't think that's correct. The mgmt app can decide the missing features
don't matter, but at the same time someone looking at the QEMU command line
doesn't know the mgmt apps' intent and it is easy to overlook that QEMU will
silently drop features. So the precense of the warnings in the log alerts the
person debugging that the actual QEMU guest visible CPU is subtly different
from what's on the command line, and that's useful IMHO for troubleshooting.

> What I'm advocating for is being more strict/deterministic on QEMU side,
>   1. you get what you asked for with enforce or fix you CLI explicitly
>      to be clear on what you are missing out.
>   2. you don't care if some features are missing, but then you don't really care
>      about warnings either. (I'd still get missing features filtered out though,
>      just silently). If one cares about missing features, one can use #1
> 
> I admit, It's a tiny bit of code but removing it, cleans up code a little bit
> and helps readability/in reviews. Doing such small cleanups here and there
> have a cumulative effect on the codebase.
> 
> Anyways it's not something I'd fight for, so if you insist on keeping it
> it's ok as well.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


