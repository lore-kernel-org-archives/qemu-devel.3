Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F70EC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6qQ-0001Hc-LA; Thu, 05 Jun 2025 05:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN6qO-0001GQ-Nh
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN6qM-0002yO-Mn
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749115501;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYYdHaMD8JlnohS7vTjzTBteCTeF4nQYM+W3dSTNICs=;
 b=W+PUj94mX4fQ4MR5gNYd2rEV3zWg/F6o0r6IerEYkjP7n3D40GdBB604Nx4VeGN+xVRoKO
 zk2N7/izk49BtvwvbNAsJPFcYPtX8cRisTISHY+ACP9+/D2ckuSl3Sioe2v++mZFeD230E
 t4Eyoj6fR0GyuU8phTtp/rpaNzEtstI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-CUwECXBIM_Sm9YA9G6TGsA-1; Thu,
 05 Jun 2025 05:24:58 -0400
X-MC-Unique: CUwECXBIM_Sm9YA9G6TGsA-1
X-Mimecast-MFC-AGG-ID: CUwECXBIM_Sm9YA9G6TGsA_1749115496
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 126F11800773; Thu,  5 Jun 2025 09:24:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B58A918002A5; Thu,  5 Jun 2025 09:24:39 +0000 (UTC)
Date: Thu, 5 Jun 2025 10:24:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
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
Message-ID: <aEFiUp9xD-UIhuGq@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
 <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
 <aDad5elq0bgZ/tvp@intel.com>
 <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Tue, Jun 03, 2025 at 05:02:38PM +0200, Igor Mammedov wrote:
> On Wed, 28 May 2025 13:23:49 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > On Wed, May 28, 2025 at 10:09:56AM +0800, Xiaoyao Li wrote:
> > > Date: Wed, 28 May 2025 10:09:56 +0800
> > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid
> > >  field
> > > 
> > > On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:  
> > > > The X86CPU::check_cpuid boolean was only set in the
> > > > pc_compat_2_4[] array, via the 'check=off' property.
> > > > We removed all machines using that array, lets remove
> > > > that CPU property and simplify x86_cpu_realizefn().  
> > > 
> > > No.
> > > 
> > > We cannot do this. Because it changes the behavior of QEMU.
> > > 
> > > 'check_cpuid' is true by default while 'enforce_cpuid' is false. So that
> > > QEMU emits warnings in x86_cpu_filter_features() by default when user
> > > requests unsupported CPU features. If remove "check" property and the
> > > internal 'check_cpuid', QEMU will not do it unless user sets enforce_cpuid
> > > explicitly.  
> > 
> > One option would be to have x86_cpu_filter_features() unconditionally
> > turn on verbose and print warnings, but some people might want to turn
> > off these warning prints, I don't know if anyone would, but it would be
> > possible.
> > 
> > The other option is still to keep the “check” property.
> > 
> > IMO, the latter option is the better way to reduce Philippe's burden.
> 
> we essentially loose warnings by default when some features aren't available,
> qemu still continues to run though.
> 
> Given that Daniel acked it from libvirt side, libvirt doesn't care about warnings
> (it does its has its own cpu model calculation). Likely other mgmt do not care
> about it either, and if they do they probably doing something wrong and
> should use QMP to get that data.

Acking it was a mistake on my part - I mis-interpreted the patch and so
didn't notice we were loosing the verbose printing of missing features
by default.

I'm actually curious why we made the 'check' feature tied to machine
types at all. If it doesn't affect guest ABI, just causes verbose
info on stderr, it feels like something we could have just had on
all machine types new & old. Git history brings us back to

  commit 3e68482224129c3ddc061af7c9d438b882ecfdd1
  Author: Eduardo Habkost <ehabkost@redhat.com>
  Date:   Tue Nov 3 17:18:50 2015 -0200

    target-i386: Set "check=off" by default on pc-*-2.4 and older
    
    The default CPU model (qemu64) have some issues today: it enables some
    features (ABM and SSE4a) that are not present in many host CPUs. That
    means many hosts (but not all of them) had those features silently
    disabled in the default configuration in QEMU 2.4 and older.
    
    With the new "check=on" default, this causes warnings to be printed in
    the default configuration, because of the lack of SSE4A on all Intel
    hosts, and the lack of ABM on Sandy Bridge and older hosts:
    
      $ qemu-system-x86_64 -machine pc,accel=kvm
      warning: host doesn't support requested feature: CPUID.80000001H:ECX.abm [bit 5]
      warning: host doesn't support requested feature: CPUID.80000001H:ECX.sse4a [bit 6]
    
    Those issues will be fixed in pc-*-2.5 and newer. But as we can't change
    the guest ABI in pc-*-2.4, disable "check" mode by default in pc-*-2.4
    and older so we don't print spurious warnings.

IOW, we wanted to have 'check' unconditionally on by default, but
had to do a temp hack to avoid spamming all configurations with
the broken 'qemu64' CPU model design.

> That leaves us with human users, for that case I'd say one should use
> enforce_cpuid if feature availability matters.

IMHO even with mgmt apps, it is worth having 'check=on' by default
as the log message has value in debugging scenarios. It could have
the potential to highlight situations where an mgmt app has
unwittingly done something wrong with CPU config. At the very least
though its a warning to humans debugging that they should not trust
the QEMU command line as a expressing the full CPU featureset.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


