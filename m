Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84336CEDD86
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 11:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syUyk-0003mi-W5; Wed, 09 Oct 2024 07:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syUyi-0003hl-QG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syUyf-0005M2-Nk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728473735;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EZtQjOBbOrnR4gX4Fi3E7vZosSLGFmcS8MahuTPEqlU=;
 b=VSvzIgQ0x0itluOoVqBLuYnAxDtGOSrpdhvo6mJ7pWI2PzEMgIddnYa3LbYPjEWn0wjnbv
 5Pf9ep/tXzEDafklzULsOmimwRbqu1d+Q4o42oQLorv6VAkur9IWdxDmYZ5oghhajIuGjp
 WTItfdJL9yYr22ujh1WaqsL83kCrEdI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-uasPVkghOCCVkOqzIQRrFw-1; Wed,
 09 Oct 2024 07:35:34 -0400
X-MC-Unique: uasPVkghOCCVkOqzIQRrFw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 993061953951; Wed,  9 Oct 2024 11:35:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D5B11956086; Wed,  9 Oct 2024 11:35:30 +0000 (UTC)
Date: Wed, 9 Oct 2024 12:35:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: x86 CPU properties "family", "model", "stepping", "tsc-freq"
Message-ID: <ZwZqfniI9UlHHXVG@redhat.com>
References: <87wmihr14b.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmihr14b.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 09, 2024 at 01:01:40PM +0200, Markus Armbruster wrote:
> QOM properties serve several purposes: initial configuration (external
> interface), run time control and monitoring (external interface), and
> internal purposes like versioning.  Which purpose(s) a property serves
> is often unclear.
> 
> The x86 CPU properties "family", "model", and "stepping" are used
> internally; see target/i386/cpu.c and hw/i386/pc.c.  I figure changing
> them at run time makes no sense.  What about configuration?  Can the
> user set arbitrary CPU properties?  If yes, are these properties meant
> to be set by the user?

The named CPU models have associated family/model/stepping (FMS),
and the string "model-i"' info defined against them, that match
the some arbitrary choice of silicon.

QEMU doesn't support all possible values though. For example,
we've seen real Skylake-Server CPUs with stepping in the range
0-4, but QEMU always reports 4 for stepping, so altering that
is potentially interesting if wanting to check guest behaviour
with a very specific FMS value.

More generally QEMU doesn't support every possible CPU model
that exists.

You can invent entirely new CPUs by turning on/off individual
CPUID feature flags, along with setting the FMS and the model-id
string.

 $ ./make-tiny-image.py --run  "cat /proc/cpuinfo"
  6.9.9-200.fc40.x86_64

 $ qemu-system-x86_64  -nodefaults -display none -serial stdio -accel kvm -m 1024 -kernel /lib/modules/6.10.8-200.fc40.x86_64/vmlinuz -initrd tiny-initrd.img  -append 'console=ttyS0 quiet' -cpu Skylake-Server | grep -E '(model|family|stepping)'
cpu family	: 6
model		: 85
model name	: Intel Xeon Processor (Skylake)
stepping	: 4

Invent my own CPU...

 $ qemu-system-x86_64  -nodefaults -display none -serial stdio -accel kvm -m 1024 -kernel /lib/modules/6.10.8-200.fc40.x86_64/vmlinuz -initrd tiny-initrd.img  -append 'console=ttyS0 quiet' -cpu Skylake-Server,family=13,model=42,model-id="Fish Food",stepping=3 | grep -E '(model|family|stepping)'
 cpu family	: 13
 model		: 42
 model name	: Fish Food
 stepping	: 1

Whether or not the requested FMS & model-id choices actually make
conceptual sense is upto the user to figure out :-)

Setting these values is certainly niche, but still valid IMHO.

> Property "tsc-freq" seems not to be used internally.  I figure changing
> it at run time makes no sense.  Looks like it is be meant to be set by
> the user: x86_cpu_parse_featurestr() seems to parse it from the argument
> of -cpu.  Correct?  Note that -cpu help doesn't mention it.

"tsc-freq" is a back compat alias for 'tsc-frequency' AFAICT, and
we need the latter if you want to guarantee fixed TSC freq across
migration. eg commit 561dbb41b1d752098249128d8462aaadc56fd15d

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


