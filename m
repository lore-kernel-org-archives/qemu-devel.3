Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B1C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1WX-0005ok-1g; Fri, 31 May 2024 08:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD1WT-0005oC-VW
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD1WR-0001Rs-S8
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717159094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lWWO6k9Jbh8N8IjwlsoDfHE5y1nNrvOBQRaCX+S9d0=;
 b=djZeHEv4XVQgTHpklbE34gr2cZvyeaBkjhAtLr8MBlCQTeEzLQNdgFn+dV+aGA5PecTVxo
 0rCsVa0irnjyW4vxGiDgH7R6mokMcTUBFpukZjD9SMqZN4MvyL3KpKljDtoqxpRgVIEhcL
 3D52UIOq54nks04F0zv0rwDP6F/r8cE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-yzdjfj1VNuSXTcVEO2oM9Q-1; Fri,
 31 May 2024 08:38:11 -0400
X-MC-Unique: yzdjfj1VNuSXTcVEO2oM9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D25A61C0512B;
 Fri, 31 May 2024 12:38:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 039DEC15BB9;
 Fri, 31 May 2024 12:38:07 +0000 (UTC)
Date: Fri, 31 May 2024 14:38:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com,
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v1 1/2] machine/microvm: support for loading EIF image
Message-ID: <ZlnErhIRLGnHfgvU@redhat.com>
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
 <20240518080753.7083-2-dorjoychy111@gmail.com>
 <Zk4QGlUAmre1l74h@redhat.com>
 <CAFfO_h4yLaX9ajTWo+obHYjozJ1NvUouvfFr7AqcrSaCgo8SVg@mail.gmail.com>
 <18cf2f43-9f79-4dd6-b581-ece9e2a02c64@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18cf2f43-9f79-4dd6-b581-ece9e2a02c64@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 31.05.2024 um 09:54 hat Alexander Graf geschrieben:
> 
> On 22.05.24 19:23, Dorjoy Chowdhury wrote:
> > Hi Daniel,
> > Thanks for reviewing.
> > 
> > On Wed, May 22, 2024 at 9:32 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > On Sat, May 18, 2024 at 02:07:52PM +0600, Dorjoy Chowdhury wrote:
> > > > An EIF (Enclave Image Format)[1] image is used to boot an AWS nitro
> > > > enclave[2] virtual machine. The EIF file contains the necessary
> > > > kernel, cmdline, ramdisk(s) sections to boot.
> > > > 
> > > > This commit adds support for loading EIF image using the microvm
> > > > machine code. For microvm to boot from an EIF file, the kernel and
> > > > ramdisk(s) are extracted into a temporary kernel and a temporary
> > > > initrd file which are then hooked into the regular x86 boot mechanism
> > > > along with the extracted cmdline.
> > > I can understand why you did it this way, but I feel its pretty
> > > gross to be loading everything into memory, writing it back to
> > > disk, and then immediately loading it all back into memory.
> > > 
> > > The root problem is the x86_load_linux() method, which directly
> > > accesses the machine properties:
> > > 
> > >      const char *kernel_filename = machine->kernel_filename;
> > >      const char *initrd_filename = machine->initrd_filename;
> > >      const char *dtb_filename = machine->dtb;
> > >      const char *kernel_cmdline = machine->kernel_cmdline;
> > > 
> > > To properly handle this, I'd say we need to introduce an abstraction
> > > for loading the kernel/inittrd/cmdlkine data.
> > > 
> > > ie on the   X86MachineClass object, we should introduce four virtual
> > > methods
> > > 
> > >     uint8_t *(*load_kernel)(X86MachineState *machine);
> > >     uint8_t *(*load_initrd)(X86MachineState *machine);
> > >     uint8_t *(*load_dtb)(X86MachineState *machine);
> > >     uint8_t *(*load_cmdline)(X86MachineState *machine);
> > > 
> > > The default impl of these four methods should just following the
> > > existing logic, of reading and returning the data associated with
> > > the kernel_filename, initrd_filename, dtb and kernel_cmdline
> > > properties.
> > > 
> > > The Nitro machine sub-class, however, can provide an alternative
> > > impl of thse virtual methods which returns data directly from
> > > the EIF file instead.
> > > 
> > Great suggestion! I agree the implementation path you suggested would
> > look much nicer as a whole. Now that I looked a bit into the
> > "x86_load_linux" implementation, it looks like pretty much everything
> > is tied to expecting a filename. For example, after reading the header
> > from the kernel_filename x86_load_linux calls into load_multiboot,
> > load_elf (which in turn calls load_elf64, 32) and they all expect a
> > filename. I think I would need to refactor all of them to instead work
> > with (uint8_t *) buffers instead, right? Also in case of
> > initrd_filename the existing code maps the file using
> > g_mapped_file_new to the X86MachineState member initrd_mapped_file. So
> > that will need to be looked into and refactored. Please correct me if
> > I misunderstood something about the way to implement your suggested
> > approach.
> > 
> > If I am understanding this right, this probably requires a lot of work
> > which will also probably not be straightforward to implement or test.
> > Right now, the way the code is, it's easy to see that the existing
> > code paths are still correct as they are not changed and the new
> > nitro-enclave machine code just hooks into them. As the loading to
> > memory, writing to disk and loading back to memory only is in the
> > execution path of the new nitro-enclave machine type, I think the way
> > the patch is right now, is a good first implementation. What do you
> > think?
> 
> I think the "real" fix here is to move all of the crufty loader logic from
> "file access" to "block layer access". Along with that, create a generic
> helper function (like this[1]) that opens all -kernel/-initrd/-dtb files
> through the block layer and calls a board specific callback to perform the
> load.

Not sure if I would call that a "real fix", it's more like a hack.
Kernel images aren't block devices and their size may not even be
aligned to 512, which is the minimum block size the block layer
supports. So there might be some complications around that area.

That said, even if it's an abuse of the block layer, it might be a
useful abuse that saves you writing quite a bit of FILE * based logic
providing similar functionality, so who I am to stop you...

> With that in place, we would have a reentrant code path for the EIF case:
> EIF could plug into the generic x86 loader and when it detects EIF, create
> internal block devices that reference the existing file plus an offset/limit
> setting to ensure it only accesses the correct range in the target file. It
> can then simply reinvoke the x86 loader with the new block device objects.
> 
> With that in place, we could also finally support -kernel http://.../vmlinuz
> command line invocations which currently only works on block devices.
> 
> However, I do agree that the above is significant effort to get going and
> shouldn't hold back the Nitro Enclave machine model.

Kevin


