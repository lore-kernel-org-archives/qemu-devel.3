Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C43CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 15:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v14sz-0005A6-Mg; Tue, 23 Sep 2025 11:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v14sp-00058x-E2
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v14sm-0002KG-V4
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758641082;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLyrTcqqNuaEFEFXx9yMKuhx535TvJEYGetYtD/el3E=;
 b=fu6LzHk/5oiP60uvfA5rFbFlTX8j7Cy9VgQFmumOTjzsJDwYRhpRVcFKNL1SyNweTLj8io
 IUbf3ihSgzcscOM58Bw/aE4F2sdxusEYgNmC8oMWDfTy6bKwxCGLllL3wyb//QJtYGGR/d
 EVS6rUtR/ndMR5lUTS+VSi0gq0h135U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-TmdH3AufPCa6olN31-22GQ-1; Tue,
 23 Sep 2025 11:24:40 -0400
X-MC-Unique: TmdH3AufPCa6olN31-22GQ-1
X-Mimecast-MFC-AGG-ID: TmdH3AufPCa6olN31-22GQ_1758641080
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC59318002C8
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 15:24:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5A4819560BB; Tue, 23 Sep 2025 15:24:37 +0000 (UTC)
Date: Tue, 23 Sep 2025 16:24:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] x86: ich9: fix default value of 'No Reboot' bit in GCS
Message-ID: <aNK7suE2t735nV3u@redhat.com>
References: <20250922132600.562193-1-imammedo@redhat.com>
 <aNFcCQL7Ad_nnxMM@redhat.com> <20250923104051.1b71d6ea@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923104051.1b71d6ea@fedora>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 23, 2025 at 10:40:51AM +0200, Igor Mammedov wrote:
> On Mon, 22 Sep 2025 15:24:09 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Mon, Sep 22, 2025 at 03:26:00PM +0200, Igor Mammedov wrote:
> > > [2] initialized 'No Reboot' bit to 1 by default. And due to quirk it happened
> > > to work with linux iTCO_wdt driver (which clears it on module load).
> > > 
> > > However spec [1] states:
> > > "
> > > R/W. This bit is set when the “No Reboot” strap (SPKR pin on
> > > ICH9) is sampled high on PWROK.
> > > "
> > > 
> > > So it should be set only when  '-global ICH9-LPC.noreboot=true' and cleared
> > > when it's false (which should be default).
> > > 
> > > Fix it to behave according to spec and set 'No Reboot' bit only when
> > > '-global ICH9-LPC.noreboot=true'.  
> > 
> > Is there a real-world problem you hit that is being solved by
> > this change, or is it just a theoretical spec compliance fix ?
> 
> I've stumbled upon it when implementing ACPI watchdog POC
> 
> https://gitlab.com/imammedo/qemu/-/commits/wadt_poc
> I'm not sure that watchdog table belongs to QEMU,
> but the ICH fix definitely is.

I've tested this as follows [1]

 $ make-tiny-image.py --kmod lpc_ich --kmod iTCO_wdt  --kmod i2c_i801
 $ qemu-system-x86_64 \
     -kernel /lib/modules/6.15.9-201.fc42.x86_64/vmlinuz \
     -initrd tiny-initrd.img \
     -append 'console=ttyS0 quiet' \
     -m 1000 \
     -display none \
     -serial stdio \
     -accel kvm \
     -M q35 \
     -global ICH9-LPC.noreboot=false \
     -watchdog-action poweroff \
     -trace ich9* -trace tco*
ich9_cc_read addr=0x3410 val=0x0 len=4
ich9_cc_write addr=0x3410 val=0x0 len=4
ich9_cc_read addr=0x3410 val=0x0 len=4
tco_io_write addr=0x4 val=0x8
tco_io_write addr=0x6 val=0x2
tco_io_write addr=0x6 val=0x4
tco_io_read addr=0x8 val=0x0
tco_io_read addr=0x12 val=0x4
tco_io_write addr=0x12 val=0x32
tco_io_read addr=0x12 val=0x32
tco_io_write addr=0x0 val=0x1
tco_timer_reload ticks=50 (30000 ms)
~ # mknod /dev/watchdog0 c 10 130
~ # cat /dev/watchdog0
tco_io_write addr=0x0 val=0x1
tco_timer_reload ticks=50 (30000 ms)
cat: read error: Invalid argument
[    5.646147] watchdog: watchdog0: watchdog did not stop!
tco_io_write addr=0x0 val=0x1
tco_timer_reload ticks=50 (30000 ms)
~ # tco_timer_expired timeouts_no=0 no_reboot=0/0
tco_timer_reload ticks=50 (30000 ms)
tco_timer_expired timeouts_no=1 no_reboot=0/0

And the same, but with ICH9-LPC.noreboot=true.

I see no functional change from Linux guest POV in either
scenario before/after this patch, so

  Tested-by: Daniel P. Berrangé <berrange@redhat.com>
  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel

[1] https://gitlab.com/berrange/tiny-vm-tools/-/blob/master/make-tiny-image.py
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


