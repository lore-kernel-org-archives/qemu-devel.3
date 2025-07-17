Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1138BC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucK9K-0005TO-HT; Thu, 17 Jul 2025 04:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1ucK91-0005NW-07
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:39:11 -0400
Received: from sg-3-19.ptr.tlmpb.com ([101.45.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1ucK8v-0002wG-Mx
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1752741514;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=d22669XMT1ab14B+MEq6HuiiDOwxiKE/vicVycWFhTs=;
 b=Qs8w56dgP+Tu4J+ooMozKI0WH+s5c0pX1FEVkQ/fQwGXlRAzMT3Y0pHvqKXGTnnW0oZFGd
 SOiTL6D9DV+953aLk4H48GYMhJGaBhh2zQVF5Ltg2YSNgZPN+D7CkHph4MsZ5XtKI6YKVy
 TxnaLx87ziXRbwUG9wZyvrYqp21cy9BzwDGSlx+r1LMqdpj+sN9nrzHgK4+kKRi1+epSlr
 TXQzIn1iFP0a9H2SoxbGR9e8Y7468hi5b8aikkwHN6tusZJsSz5w6fM/lmhfvAoENFvnEb
 IrviKJztZg8zQikr7U6p/lHrHi5jeRrN6m6cvPVy3yfqRFcKnj5mI67xBU2zTw==
Message-Id: <38cc241c40a8ef2775e304d366bcd07df733ecf0.1fff9297.8409.4217.8009.bf7245c8eed9@feishu.cn>
Subject: Re: [PATCH] target/riscv/kvm: Introduce simple handler for VS-file
 allocation failure
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16878b687+f54f7f+nongnu.org+xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jul 2025 16:38:30 +0800
To: "Andrew Jones" <ajones@ventanamicro.com>
Cc: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>, 
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
From: "Bill Xiang" <xiangwencheng@lanxincomputing.com>
References: <20250716074738.1075-1-xiangwencheng@lanxincomputing.com>
 <20250717-f8c5ad3a56fbd7cf24224853@orel>
In-Reply-To: <20250717-f8c5ad3a56fbd7cf24224853@orel>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=101.45.255.19;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=sg-3-19.ptr.tlmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi drew=EF=BC=8CThanks for your reply.

I agree this patch remains insufficient. Regardless, Guest Interrupt Files
represent a new and critical resource type that upper layers currently
lack awareness of, and significant work is still needed to fully integrate =
them.

> From: "Andrew Jones"<ajones@ventanamicro.com>
> Date:=C2=A0 Thu, Jul 17, 2025, 16:02
> Subject:=C2=A0 Re: [PATCH] target/riscv/kvm: Introduce simple handler for=
 VS-file allocation failure
> To: "BillXiang"<xiangwencheng@lanxincomputing.com>
> Cc: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.co=
m>, <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>, <qemu-risc=
v@nongnu.org>, <qemu-devel@nongnu.org>
> On Wed, Jul 16, 2025 at 03:47:37PM +0800, BillXiang wrote:
> > Consider a system with 8 harts, where each hart supports 5
> > Guest Interrupt Files (GIFs), yielding 40 total GIFs.
> > If we launch a QEMU guest with over 5 vCPUs using
> > "-M virt,aia=3D'aplic-imsic' -accel kvm,riscv-aia=3Dhwaccel" =E2=80=93 =
which
> > relies solely on VS-files (not SW-files) for higher performance =E2=80=
=93 the
> > guest requires more than 5 GIFs. However, the current Linux scheduler
> > lacks GIF awareness, potentially scheduling >5 vCPUs to a single hart.
> > This triggers VS-file allocation failure, and since no handler exists
> > for this error, the QEMU guest becomes corrupted.
>=C2=A0
> What do you mean by "become corrupted"? Shouldn't the VM just stop after
> the vcpu dumps register state?
>=C2=A0
> >=C2=A0
> > To address this, we introduce this simple handler by rescheduling vCPU
> > to alternative harts when VS-file allocation fails on the current hart.
> >=C2=A0
> > Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> > ---
> > =C2=A0target/riscv/kvm/kvm-cpu.c | 15 +++++++++++++++
> > =C2=A01 file changed, 15 insertions(+)
> >=C2=A0
> > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > index 5c19062c19..7cf258604f 100644
> > --- a/target/riscv/kvm/kvm-cpu.c
> > +++ b/target/riscv/kvm/kvm-cpu.c
> > @@ -1706,6 +1706,9 @@ static bool kvm_riscv_handle_debug(CPUState *cs)
> > =C2=A0int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
> > + =C2=A0 =C2=A0uint64_t code;
> > + =C2=A0 =C2=A0cpu_set_t set;
> > + =C2=A0 =C2=A0long cpus;
> > =C2=A0 =C2=A0 =C2=A0switch (run->exit_reason) {
> > =C2=A0 =C2=A0 =C2=A0case KVM_EXIT_RISCV_SBI:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kvm_riscv_handle_sbi(cs, run)=
;
> > @@ -1718,6 +1721,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kv=
m_run *run)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EXCP_DEBUG;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > + =C2=A0 =C2=A0case KVM_EXIT_FAIL_ENTRY:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0code =3D run->fail_entry.hardware_entry_fa=
ilure_reason;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (code =3D=3D CSR_HSTATUS) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Schedule vcpu to next har=
t upon VS-file=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// allocation failure on cur=
rent hart.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpus =3D sysconf(_SC_NPROCES=
SORS_ONLN);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU_ZERO(&set);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU_SET((run->fail_entry.cpu=
+1)%cpus, &set);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sched_setaffinity(0,=
 sizeof(set), &set);
>=C2=A0
> If other guests have already consumed all the VS-files on the selected
> hart then this will fail again and the next hart will be tried and if all
> VS-files of the system are already consumed then we'll just go around and
> around.
>=C2=A0
> Other than that problem, this isn't the right approach because QEMU shoul=
d
> not be pinning vcpus - that's a higher level virt management layer's job
> since it's a policy.
>=C2=A0
> A better solution to this is to teach KVM to track free VS-files and then
> migrate (but not pin) vcpus to harts with free VS-files, rather than
> immediately fail.
>=C2=A0
> But, if all guests are configured to only use VS-files, then upper layers
> of the virt stack will still need to be aware that they can never schedul=
e
> more vcpus than supported by the number of total VS-files. And, if upper
> layers are already involved in the scheduling, then pinning is also an
> option to avoid this problem. Indeed pinning is better for the failure
> case of over scheduling, since over scheduling with the KVM vcpu migratio=
n
> approach can result in a VM launched earlier to be killed, whereas with
> the upper layer pinning approach, the last guest launched will fail befor=
e
> it runs.
>=C2=A0
> Thanks,
> drew
>=C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FALLTHRU */
> > =C2=A0 =C2=A0 =C2=A0default:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP, "%s: un-hand=
led exit reason %d\n",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0__func__, run->exit_reason);
> > --=C2=A0
> > 2.46.2.windows.1
> >
>=C2=A0

