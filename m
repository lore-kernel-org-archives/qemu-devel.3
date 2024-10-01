Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA7CEACCB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdhu-0002Wy-6T; Tue, 01 Oct 2024 10:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svdhH-00027W-Df; Tue, 01 Oct 2024 10:17:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svdhB-0004Tt-FD; Tue, 01 Oct 2024 10:17:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4916L3Sj011286;
 Tue, 1 Oct 2024 09:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=y
 YRw0ZEZHGnHNKUFj2pdyJs7NURv41a/dWw0BQRfgHo=; b=AWv/A11g7my2EMaZk
 fkMLlesCztbM6f9TyPRGfJrMRQ5JZOcVBCuW38jbXtP3TciSB+ECDzwk5AK/eJV8
 4KgRyRMaQ8Fwtb5sjJy7GJrzJ/JAc84R3OxzXEXIgc3HUNByr1sunHXIgFD503vT
 QVRgXVa323NdohfM/foqoJYqkClNfRPT33HLgP2m73CfVbMeyic03qARs33TU9xr
 p5ioQ4ZC3PJjHqnwjiNEGI3l5yFT0i7tWpAAyiIz1XLsLn4wFyVVj22nXiCd1v1z
 ljLZ3AnkBVXTZVJLdPLT5voGnelbLbXyTXZcx3sPMAcV+dcf4o7Mf8zCyAiapa17
 w9ZHg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqs0tms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:15:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4919F7LS028286;
 Tue, 1 Oct 2024 09:15:07 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420bqs0tmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:15:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49171Wh4013007;
 Tue, 1 Oct 2024 09:15:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjb4jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:15:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4919F3CA56951252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 09:15:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4846E20040;
 Tue,  1 Oct 2024 09:15:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F4282004B;
 Tue,  1 Oct 2024 09:15:02 +0000 (GMT)
Received: from [9.171.29.251] (unknown [9.171.29.251])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 09:15:02 +0000 (GMT)
Message-ID: <972044f1-62e4-4ac0-8b24-e0bb78770309@linux.ibm.com>
Date: Tue, 1 Oct 2024 11:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
 <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
 <20240927200525.5a90f172.pasic@linux.ibm.com>
 <10165d22-c3e8-4db1-9874-8b63ca59afe9@linux.ibm.com>
 <20240930145712.526a1c79.pasic@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240930145712.526a1c79.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tyQxdevqOt0WZnULHj9THt91hYjM08i6
X-Proofpoint-ORIG-GUID: -JpZFe8FIDNkGgrqvNzc1WxObwKhPp_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=867
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010058
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 30.09.24 um 14:57 schrieb Halil Pasic:
> On Mon, 30 Sep 2024 13:11:31 +0200
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> We do have kvm_stat counters for 500, not sure if people debugging virtio
>> will care.
> 
> Could end up being confusing, as currently we can assume each and every
> DIAG 500 is a virtio doorbell. But I don't think the chance of this
> causing real headache is big.
> 
>> The only important question for me is, what code is generated by gcc for
>> the switch statement and will any variant slow down the virtio doorbell.
>> diag.c has
>>           if (!vcpu->kvm->arch.css_support ||
>>               (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
>>                   return -EOPNOTSUPP;
>>
>> So 500+4 should probably not cause any harm apart from branch prediction
>> going wrong the first 2 or 3 notifies.
>>
>> 502 will make kvm_s390_handle_diag larger.
> 
> What do you mean by this last paragraph?
> 
> I suppose we are talking about
> int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
> {
>          int code = kvm_s390_get_base_disp_rs(vcpu, NULL) & 0xffff;
>                                                                                  
>          if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>                  return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>                                                                                  
>          trace_kvm_s390_handle_diag(vcpu, code);
>          switch (code) {
>          case 0x10:
>                  return diag_release_pages(vcpu);
>          case 0x44:
>                  return __diag_time_slice_end(vcpu);
>          case 0x9c:
>                  return __diag_time_slice_end_directed(vcpu);
>          case 0x258:
>                  return __diag_page_ref_service(vcpu);
>          case 0x308:
>                  return __diag_ipl_functions(vcpu);
>          case 0x500:
>                  return __diag_virtio_hypercall(vcpu);
>          default:
>                  vcpu->stat.instruction_diagnose_other++;
>                  return -EOPNOTSUPP;
>          }
> }
> 
> and my understanding is that the default branch of the switch
> statement would be already suitable for DIAG 502 as it is today
> for DIAG 502. So I'm quite confused by your statement that
> 502 will make kvm_s390_handle_diag larger (as the only meaning
> of larger I can think of is more code). Can you please clarify?

gcc has logic for switch statements that decide about branch table or
a chained compare+jump. I think due to spectre gcc now avoids indirect
branches as much as possible but still a larger switch statement might
kick the decision from inline compare/jump to a branch table.

I am not worried in this particular case this was more or less a
"what could go wrong".

