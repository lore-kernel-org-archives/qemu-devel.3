Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0525C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 20:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZdN7-0000Oo-4w; Mon, 12 Feb 2024 15:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1rZdN3-0000Ki-LH
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:57:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1rZdMt-0004jQ-38
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:57:45 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CKMKpH016729; Mon, 12 Feb 2024 20:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=pzzQv3Ms/AddfaASJ+Dplzdqi2mDYGvGgehqslb1b8c=;
 b=TYcQwm/sx7ZkgIKLXxmKWKPiRyrHrXPJMitdN0kk45pzCUKqlYB+uYzeFX+PctBUe2w8
 LTNhDx+/f8eYGJnAfufPf0GoSB2mQBsttWnS0wKrnOm44ePsZzE3Byj6X+RaRyBEMPwD
 iT28lvM7rizsjkezqGxsqzOsTD05wTlw6fTHmd9xfq1LLRdOZBjj3aqSsHGKPVRwZG1r
 KEqEp6RjSzFlTfd/sCReBjeiRtoNzSwkVuieaZ7FQl4oWdFgyD/Pc0cprJgyjfiFjcRT
 jr8FPXQaib7UCWfL+kuLtub09gBgry4aCv9qOXrnot4mz1BiCxC7kO+iyPX7KXOL7i8d 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7ta9gp8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:57:18 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CKfcui017893;
 Mon, 12 Feb 2024 20:57:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7ta9gp7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:57:17 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CIitpW004258; Mon, 12 Feb 2024 20:57:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv03akd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:57:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41CKvC5G7144082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 20:57:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6CBB58057;
 Mon, 12 Feb 2024 20:57:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DD9558062;
 Mon, 12 Feb 2024 20:57:08 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.141.181])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 20:57:08 +0000 (GMT)
Message-ID: <f845a5689475d4698cbb16efa942a53636cd4385.camel@linux.ibm.com>
Subject: Re: RFC i386/sev: kernel-hashes, reference measurements and event logs
From: James Bottomley <jejb@linux.ibm.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>, "Li, Xiaoyao"
 <xiaoyao.li@intel.com>
Cc: npiggin@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, "Draper, Andrew"
 <andrew.draper@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg
 Roedel <jroedel@suse.de>,
 Chong Cai <chongc@google.com>, qemu-devel@nongnu.org, clg@kaod.org,
 danielhb413@gmail.com, harshpb@linux.ibm.com,
 david@gibson.dropbear.id.au, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, iii@linux.ibm.com,
 thuth@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Date: Mon, 12 Feb 2024 15:57:07 -0500
In-Reply-To: <CAAH4kHY+JHSznw_t52rwBckfcZpzvX28b9Cu3eyXLMShnj3NBg@mail.gmail.com>
References: <CAAH4kHY+JHSznw_t52rwBckfcZpzvX28b9Cu3eyXLMShnj3NBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G67v5_OlteSLxEIm6I-U797UTo-tVEKL
X-Proofpoint-GUID: c0Y47RzKD2gIlFR-vZn6WbpC1vDLG_BA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120162
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jejb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: jejb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2024-02-12 at 12:16 -0800, Dionna Amalie Glaze wrote:
> This is not a patch but it felt inappropriate to derail a recent
> patch that's just refactoring the kernel-hashes object_class_property
> definition. Apologies if this has been discussed before, as I'm not
> particularly active here.

I haven't seen that patch, but I presume it's not relevant?

> Regarding kernel-hashes, how is that load-time information passed
> along to the guest beyond, say, OVMF? Can we require that these
> hashes
> are also present in fw_cfg so they can be read from the kernel? In
> Linux it'd be nice to have /sys/firmware/qemu_fw_cfg/sev_kernel_hash,
> /sys/firmware/qemu_fw_cfg/sev_cmdline_hash,
> /sys/firmware/qemu_fw_cfg/sev_initrd_hash

Are you referring to measured direct boot?  In that case, there's no
point having hashes in the fw_cfg, because OVMF in the guest needs to
hash the kernel itself and then compare to a trusted source (which the
fw_cfg file wouldn't be because it's under the control of the
hypervisor).  For SEV, the trusted source is a table in the launch
measured ROM, but I'm sure TDX does something similar.

> I'm working on how to use standard document formats for providing
> reference measurements of the Google Compute Engine virtual firmware
> for remote attestation, and these hashes have an impact not just on
> the measurement but on the entire model that the IETF RATS working
> group is considering for authorizing attestation measurements.
> 
> If you're assembling a VM launch configuration with firmware provided
> by a trusted vendor (say Google), and your hashes are passed in from
> an API, there's no easy rendezvous to state that the combination
> produces the expected hardware measurement. This makes adding
> kernel-hashes support unappetizing, since it makes the hardware
> attestation report's measurement have no meaning, or at least, it
> makes life difficult for people trying to assign it meaning.

Well, no, since firmware tends to update on a longer timeframe than the
kernel and the cmdline and initrd tend to have quicker update cycles
than the kernel.  Thus there's no one golden reference.  Instead you
give a tool (say the virtee sev_snp_measure tool

https://github.com/virtee/sev-snp-measure

) the hashes of the firmware, kernel, command line and initrd and it
caclulates the expected launch measure

> The measurement is the product of two different entities as assembled
> by the VMM given a trusted firmware and the kernel hashes. It's a bit
> of a sandwich of (GCE) core firmware, (User) SEV hashes, (GCE) BSP
> VMSA, AP VMSA*.
> 
> When you collect "evidence" to verify locally or pass along to a
> verification service, you need more than just the hardware
> attestation report to make sense of the combined bits. You have a PCR
> situation like with TPM, so you need an event log for these different
> aspects of the ultimate measurement. There is no event log for this
> -kernel-hashes construction.

That's because it's a pre-launch measure.  The TCG log is only for post
launch.  The idea being those values are needed for you to approve
something in pre-launch, like key release, before the TPM starts
running.

That's not to say we shouldn't have log entries for pre-launch, but
that's a generic problem and not specific to measured direct boot.

> We can use the TCG TPM event log to post EV_NO_ACTION events about
> the PlatformRIM, specifically, to point at a UEFI variable that we
> populate to store our signed document about the expected measurements
> with the Qemu-SEV-SNP-boot-protocol, but I don't see how we might
> collect the kernel-hashes values as extra evidence to combine and
> derive the attestation report's MEASUREMENT field to accept
> "evidence" objects for the core firmware component and the kernel
> hashes component.

This sounds like a first measurement thing.  In many ways, the pre-
launch measurement is equivalent to the SRTM of a physical system which
is collected in the EV_S_CRTM_* events.  But for that to happen, I
think the TCG would have to bless it in some form.

James

> So my question is if this feature is to be a long term feature, how
> do you expect to collect the SEV hashes as a separate evidence object
> to play nicely with IETF RATS?
> 
> Is this a long term feature, or are we expecting it to be deprecated
> by SVSM?
> 
> I've tagged in people in CC that I could imagine would have something
> to say about this.
> 
> Thanks y'all
> 
> --
> -Dionna Glaze, PhD (she/her)


