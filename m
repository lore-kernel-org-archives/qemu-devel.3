Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A024E69E88
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPzc-0005Zh-TB; Tue, 03 Dec 2024 05:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPzb-0005Z5-01
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPzZ-0000kB-7T
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733221132;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/1OQ6rBEEENfqwci5OkpXizbfAzw/AqbxUkjO5NjuI=;
 b=Eu4Vv6h5laz16x94dbNbsvWOHhiBzwqHuCrrh+ilRdFZzwySATfAGAV2vRYe/y/S8oDQsQ
 O80GC3Hfeo3SchqsFHm6+wuDSO1WD3us6C/ezQCikQq5YkRdBEHU5rkEqIho53EW7uTiP1
 KC+05guV+W70q4O6TuLVr4LYWAf5+ps=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-ae6wQhEGPzOoNNd0iJ8QJg-1; Tue,
 03 Dec 2024 05:18:49 -0500
X-MC-Unique: ae6wQhEGPzOoNNd0iJ8QJg-1
X-Mimecast-MFC-AGG-ID: ae6wQhEGPzOoNNd0iJ8QJg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C4D71956095; Tue,  3 Dec 2024 10:18:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 809221956052; Tue,  3 Dec 2024 10:18:42 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:18:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv <qemu-riscv@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 David Abdurachmanov <davidlt@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Corbin <mark@dibsco.co.uk>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,64} part of the same
 family
Message-ID: <Z07a_kYh4duwWKWw@redhat.com>
References: <20241203094702.124748-1-abologna@redhat.com>
 <cb079b65-e5fc-4667-aa63-9ff347666b6e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb079b65-e5fc-4667-aa63-9ff347666b6e@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Tue, Dec 03, 2024 at 10:59:24AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Andrea,
> 
> On 3/12/24 10:47, Andrea Bolognani wrote:
> > Currently the script won't generate a configuration file that
> > sets up qemu-user-riscv32 on riscv64, likely under the
> > assumption that 64-bit RISC-V machines can natively run 32-bit
> 
> I'm confused by the "machines" description used for user emulation.

It is referring to the host machines, being able (or not) to
run 32-bit usermode code on 64-bit host kernel.

> 
> > RISC-V code.
> > 
> > However this functionality, while theoretically possible, in
> > practice is missing from most commonly available RISC-V hardware
> > and not enabled at the distro level. So qemu-user-riscv32 really
> > is the only option to run riscv32 binaries on riscv64.
> 
> We have definitions such ELF_ARCH/ELF_PLATFORM/ELF_MACHINE to
> parse ELF header and select the best CPU / flags. Maybe RISC-V
> lacks them?

Is that relevant, as we're not runing QEMU code at all in
the problematic scenario ?

Currently the script below will skip generating a binfmt
rule for riscv32, when on a riscv64 host. Thus qemu-riscv32
will never get called, and the kernel will try & fail to
run riscv32 binaries natively.

This change would make us generate riscv32 binfmt rules
and thus use qemu-riscv32 on riscv64 hosts for linux-user.


Separatley this from patch, we should also consider whether
it is time to do the same for aarch64/arm7.

If I look at this page:

  https://gpages.juszkiewicz.com.pl/arm-socs-table/arm-socs.html

and sort by 'announced' to see msot recent CPUs first, then
almost all of them have "NO" in the "aarch32 support" column.

IOW, on modern aarch64 CPUs, qemu-arm is the only viable way
to run 32-bit usermode binaries AFAICT, and suggests we ought
to be creating a binfmt rule for that on aarch64 hosts.

> BTW we should expose that for linux-user as target_arch_elf.h,
> like bsd-user does, that would reduce all these #ifdef'ry in
> linux-user/elfload.c...
> 
> > 
> > Make riscv32 and riscv64 each its own family, so that the
> > configuration file we need to make 32-on-64 userspace emulation
> > work gets generated.
> 
> Does this patch aim for 9.2? Otherwise FYI  I'm working on unifying
> 32/64-bit targets, maybe for 10.0...

Well in Fedora we'll backport it to 9.2 at least, and from that
POV I'd consider it stable-9.2 material if accepted here.

> > Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> > Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> > Thanks: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> > ---
> >   scripts/qemu-binfmt-conf.sh | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> > 
> > diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> > index 6ef9f118d9..e38b767c24 100755
> > --- a/scripts/qemu-binfmt-conf.sh
> > +++ b/scripts/qemu-binfmt-conf.sh
> > @@ -110,11 +110,11 @@ hppa_family=hppa
> >   riscv32_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
> >   riscv32_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> > -riscv32_family=riscv
> > +riscv32_family=riscv32
> >   riscv64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00'
> >   riscv64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> > -riscv64_family=riscv
> > +riscv64_family=riscv64
> >   xtensa_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x5e\x00'
> >   xtensa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> > @@ -168,9 +168,6 @@ qemu_get_family() {
> >       sparc*)
> >           echo "sparc"
> >           ;;
> > -    riscv*)
> > -        echo "riscv"
> > -        ;;
> >       loongarch*)
> >           echo "loongarch"
> >           ;;
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


