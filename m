Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ED2C5B555
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkld-0002OR-EI; Wed, 04 Jun 2025 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMklW-0002Nq-OS
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMklU-0001Qq-Hb
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749030630;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrHW8kxqMu3A/P4nC9PQo3w1CCJz0duGC9DID5ovn7c=;
 b=gGZa+XXMdNVcUeg0+baiSpvyQT94xFXyNPc16LDEZnkbeeefCcBYn+pDyP7GSkg6cWUeNS
 XxICxqki5ulbnXyRt1nZUOsQ0il5SvkUlt+w/++acp1iKgbmdIeqHc/DU2NhFSZxzlf+ML
 rpS5LyNdvqXK2n5KJnhl7L/bLyvJ3m8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-zw94tq26PHycbAAftSgumw-1; Wed,
 04 Jun 2025 05:50:26 -0400
X-MC-Unique: zw94tq26PHycbAAftSgumw-1
X-Mimecast-MFC-AGG-ID: zw94tq26PHycbAAftSgumw_1749030625
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66F89195608F; Wed,  4 Jun 2025 09:50:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50EC318003FC; Wed,  4 Jun 2025 09:50:20 +0000 (UTC)
Date: Wed, 4 Jun 2025 10:50:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
Message-ID: <aEAW2E5zH3X4ZsbC@redhat.com>
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
 <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
 <102e2e67-4c4d-4912-a892-20f5136f241a@ventanamicro.com>
 <47327da2-be3c-4aaa-ab3d-36e8d0c25185@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47327da2-be3c-4aaa-ab3d-36e8d0c25185@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 04, 2025 at 09:32:21AM +0200, Philippe Mathieu-Daudé wrote:
> On 3/6/25 20:04, Daniel Henrique Barboza wrote:
> > 
> > 
> > On 6/3/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> > > Hi Daniel,
> > > 
> > > (now merged as commit a6b53378f537)
> > > 
> > > On 25/4/24 17:50, Daniel Henrique Barboza wrote:
> > > > SBI defines a Debug Console extension "DBCN" that will, in time, replace
> > > > the legacy console putchar and getchar SBI extensions.
> > > > 
> > > > The appeal of the DBCN extension is that it allows multiple bytes to be
> > > > read/written in the SBI console in a single SBI call.
> > > > 
> > > > As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
> > > > module to userspace. But this will only happens if the KVM module
> > > > actually supports this SBI extension and we activate it.
> > > > 
> > > > We'll check for DBCN support during init time, checking if get-reg-list
> > > > is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
> > > > kvm_set_one_reg() during kvm_arch_init_vcpu().
> > > > 
> > > > Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
> > > > SBI_EXT_DBCN, reading and writing as required.
> > > > 
> > > > A simple KVM guest with 'earlycon=sbi', running in an emulated RISC-V
> > > > host, takes around 20 seconds to boot without using DBCN. With this
> > > > patch we're taking around 14 seconds to boot due to the speed-up in the
> > > > terminal output.  There's no change in boot time if the guest isn't
> > > > using earlycon.
> > > > 
> > > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > > ---
> > > >   target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++++++++++
> > > >   target/riscv/sbi_ecall_interface.h |  17 +++++
> > > >   2 files changed, 128 insertions(+)
> > > 
> > > 
> > > > +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct
> > > > kvm_run *run)
> > > > +{
> > > > +    g_autofree uint8_t *buf = NULL;
> > > > +    RISCVCPU *cpu = RISCV_CPU(cs);
> > > > +    target_ulong num_bytes;
> > > > +    uint64_t addr;
> > > > +    unsigned char ch;
> > > > +    int ret;
> > > > +
> > > > +    switch (run->riscv_sbi.function_id) {
> > > > +    case SBI_EXT_DBCN_CONSOLE_READ:
> > > > +    case SBI_EXT_DBCN_CONSOLE_WRITE:
> > > > +        num_bytes = run->riscv_sbi.args[0];
> > > > +
> > > > +        if (num_bytes == 0) {
> > > > +            run->riscv_sbi.ret[0] = SBI_SUCCESS;
> > > > +            run->riscv_sbi.ret[1] = 0;
> > > > +            break;
> > > > +        }
> > > > +
> > > > +        addr = run->riscv_sbi.args[1];
> > > > +
> > > > +        /*
> > > > +         * Handle the case where a 32 bit CPU is running in a
> > > > +         * 64 bit addressing env.
> > > > +         */
> > > > +        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
> > > > +            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
> > > > +        }
> > > > +
> > > > +        buf = g_malloc0(num_bytes);
> > > > +
> > > > +        if (run->riscv_sbi.function_id == SBI_EXT_DBCN_CONSOLE_READ) {
> > > > +            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf,
> > > > num_bytes);
> > > > +            if (ret < 0) {
> > > > +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error when "
> > > > +                             "reading chardev");
> > > > +                exit(1);
> > > > +            }
> > > > +
> > > > +            cpu_physical_memory_write(addr, buf, ret);
> > > > +        } else {
> > > > +            cpu_physical_memory_read(addr, buf, num_bytes);
> > > > +
> > > > +            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf,
> > > > num_bytes);
> > > > +            if (ret < 0) {
> > > > +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error when "
> > > > +                             "writing chardev");
> > > > +                exit(1);
> > > > +            }
> > > > +        }
> > > > +
> > > > +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
> > > > +        run->riscv_sbi.ret[1] = ret;
> > > > +        break;
> > > > +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
> > > > +        ch = run->riscv_sbi.args[0];
> > > > +        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
> > > > +
> > > > +        if (ret < 0) {
> > > > +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
> > > > +                         "writing chardev");
> > > > +            exit(1);
> > > > +        }
> > > 
> > > We are ignoring partial writes (non-blocking call returning 0 byte
> > > written), is that expected? If so, is it OK to add a comment we can
> > > safely discard not-yet-written DBCN_CONSOLE_WRITE_BYTE?
> > 
> > Not sure what you meant. IIUC qemu_chr_fe_write() returns the number
> > of bytes consumed, 0 if no chardev is found, and -1 on error.
> 
> I'm trying to address an issue Peter reported with qemu_chr_fe_write():
> https://lore.kernel.org/qemu-devel/CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/
> 
> Basically upon introduction in commit cd18720a294 in 2013
> ("char: introduce a blocking version of qemu_chr_fe_write") the API
> contract was "Returns: the number of bytes consumed" which could be 0,
> so some frontends return 0 for "wrote no bytes".
> 
> Later in 2016 in commit fa394ed6257 ("char: make some qemu_chr_fe
> skip if no driver") the API documentation was changed:
> 
> - * Returns: the number of bytes consumed
> + * Returns: the number of bytes consumed (0 if no assicated CharDriver)

IMHO those semantics are broken for the write methods.

0 for a write() attempt indicates that the caller must be prepared to
retry again later.

0 for a write_all() attempt should not be permitted - write_all()
must always write everythnig, or return an error.

When no CharDriver is present, these semantics falls down. We need to
be returning "len" when no driver is present, ie no associated CharDriver
should be like writing to /dev/null, nor /dev/full - everything should be
reported as consumed, but discarded internally.

> After this commit, some frontends started to handle '<=0' as error,
> while 0 is not an error.

Yep, that's wrong.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


