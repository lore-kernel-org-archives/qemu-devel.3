Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F27C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfeFx-00049J-9e; Wed, 05 Feb 2025 07:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tfeFv-000496-B6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:11:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tfeFt-0005vX-EH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:11:47 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51520im2009847;
 Wed, 5 Feb 2025 12:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NuhGNY
 dMONqOwqYKo3vfCVo9SfcoKQ3C6fbZFF4BY3Q=; b=TscvjANtPe8o75h4yM9s4G
 8G5Vlyh8r5ISI/gTPhExiUYpSKG0a0cLO1pBboRaRILf8CV/Yc+YH0/Vj222fFit
 MViG4ysA0Aety+vgYrFZG7+MiFh5XlCKE9EdnW9ws+qF1KGie6RlL/T8cMYsbtDM
 CKAqtBw4DVLN0VEUJdUzeam/0rd6qixZ3PbTauokFHCRWH7bSjE2/sFLczbiZnhe
 EGshQWdABf/ADmXMcmIpeK1mzizZtNo1PhAZZ9eYWP+905Yt1A96B3FUQWIh8Zbi
 /6h7g3Z3rAM9HR2Bph5JE319ld0bTVePPDOv2eiEQNIG9VYzYZ+4MxWVrn/qNwVA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kxtyjd4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2025 12:11:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5158t282006578;
 Wed, 5 Feb 2025 12:11:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekgjfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2025 12:11:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 515CBV6V32899622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2025 12:11:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ECDA20043;
 Wed,  5 Feb 2025 12:11:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A32D620040;
 Wed,  5 Feb 2025 12:11:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Feb 2025 12:11:30 +0000 (GMT)
Message-ID: <ef44b64dfe2b49646e0f4958bfeea9baa6276e0d.camel@linux.ibm.com>
Subject: Re: [PULL v2 42/61] physmem: Add helper function to destroy CPU
 AddressSpace
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Salil Mehta
 <salil.mehta@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Date: Wed, 05 Feb 2025 13:11:30 +0100
In-Reply-To: <CAFEAcA8gR4mmyPBxKUzrExobWjQb95ez4j4pb4pvkK5FyVCs4A@mail.gmail.com>
References: <cover.1721731723.git.mst@redhat.com>
 <24bec42f3d6eae035d5df48c057157f83b260e17.1721731723.git.mst@redhat.com>
 <CAFEAcA8gR4mmyPBxKUzrExobWjQb95ez4j4pb4pvkK5FyVCs4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m1xf1jeR2CF-a1NnB5NKBZYFtQ9ifufg
X-Proofpoint-ORIG-GUID: m1xf1jeR2CF-a1NnB5NKBZYFtQ9ifufg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 2024-08-19 at 16:22 +0100, Peter Maydell wrote:
> On Tue, 23 Jul 2024 at 11:59, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >=20
> > From: Salil Mehta <salil.mehta@huawei.com>
> >=20
> > Virtual CPU Hot-unplug leads to unrealization of a CPU object. This
> > also
> > involves destruction of the CPU AddressSpace. Add common function
> > to help
> > destroy the CPU AddressSpace.
>=20
> Based on some testing I've been doing that tries to use
> (a variation of) this function to do the cleanup of the
> CPU address spaces, I think there's a problem with it.
> (This doesn't matter for 9.1 because nothing calls this
> function as yet.)
>=20
> > +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> > +{
> > +=C2=A0=C2=A0=C2=A0 CPUAddressSpace *cpuas;
> > +
> > +=C2=A0=C2=A0=C2=A0 assert(cpu->cpu_ases);
> > +=C2=A0=C2=A0=C2=A0 assert(asidx >=3D 0 && asidx < cpu->num_ases);
> > +=C2=A0=C2=A0=C2=A0 /* KVM cannot currently support multiple address sp=
aces. */
> > +=C2=A0=C2=A0=C2=A0 assert(asidx =3D=3D 0 || !kvm_enabled());
> > +
> > +=C2=A0=C2=A0=C2=A0 cpuas =3D &cpu->cpu_ases[asidx];
> > +=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_listener_unregister(=
&cpuas->tcg_as_listener);
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 address_space_destroy(cpuas->as);
> > +=C2=A0=C2=A0=C2=A0 g_free_rcu(cpuas->as, rcu);
>=20
> RCU doesn't guarantee the order in which it executes the
> rcu reclaim hooks, so we can run the g_free() of cpuas-as
> *before* the do_address_space_destroy hook that
> address_space_destroy() sets up. This means we free the
> RCU node that the latter hook is using, and then
> do_address_space_destroy is never called (and I think also
> I was seeing the RCU callback thread get stalled entirely,
> because the list node it wanted to traverse was garbage.)
>=20
> However, I don't understand how to fix this -- how is a
> caller of address_space_destroy() supposed to know when it
> can free the memory containing the AddressSpace ?
> Paolo: do you understand how this should work? We seem
> to already use address_space_destroy() in various places
> usually for an AS that's embedded in a device struct --
> how do we ensure that the destroy has finished before we
> free the device memory ?
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0 if (asidx =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* reset the convenience al=
ias for address space 0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->as =3D NULL;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 if (--cpu->cpu_ases_count =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(cpu->cpu_ases);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->cpu_ases =3D NULL;
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
>=20
> thanks
> -- PMM

I tried using this function, and there are indeed a couple problems
with it. First of all, with TCG, there is a use-after-free:

    Thread 1:
   =20
        cpu_address_space_destroy()
          memory_listener_unregister()
            listener_del_address_space()
              tcg_commit()  # via listener->commit()
                async_run_on_cpu(tcg_commit_cpu, cpuas)
          g_free(cpu->cpu_ases)  # frees cpuas
   =20
    Thread 2:
   =20
        mttcg_cpu_thread_fn()
          process_queued_cpu_work()
            tcg_commit_cpu()
              cpuas->as  # cpuas is freed

This can be fixed by passing asidx instead of cpuas to
tcg_commit_cpu() and checking if it's still available.

Second, g_free_rcu() enqueues the same node as
address_space_destroy() -> call_rcu(do_address_space_destroy),
preventing do_address_space_destroy() from running altogether.
Coupled with the ordering concern, I think the right way to fix
this is to introduce address_space_destroy_and_free() that runs both
actions in the correct order.

