Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A743CF64B1
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFy0-0007Ao-8F; Mon, 30 Sep 2024 08:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1svFxw-00076I-U0; Mon, 30 Sep 2024 08:57:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1svFxt-0006rc-R1; Mon, 30 Sep 2024 08:57:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U5EFGC024730;
 Mon, 30 Sep 2024 12:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 pt3JDjSc8/SaggM9rTbWMDMOM44uxTukwctz3UQB1UE=; b=BmlX991DdlgFmJcB
 ntfpZNA2CWHtahTiZN4S0AkmeZ487XXFM2bVsUHNgTSgwnBddhhebomQLgSLQOk4
 ZYCh6RfX+QydgwBzMGBbuHC1fWTWD4uCBJunlAcUE+pdmq3VWMwEZRyV+wOhLJyx
 9/+LicqUTdjJPUkYXsDYKGFgu6dxshxn+8DKtC5gQePsX1kikOWo6pZQmpVa9VQl
 NHhm2bnX1bN3nYG4nAZe47oJmcxJL94pKXDMgL2jnSjDA+VxSQLPUJG+BWG85IPc
 Jz8SEWcMRLwcgFVn9bkT8NbmeWDN6jm7ViT0SvyR2YV2hWkkVt4UMU85mjbTnJ8E
 D1VAuw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap9yf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 12:57:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UCjdlD022484;
 Mon, 30 Sep 2024 12:57:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap9yex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 12:57:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBAcr2013975;
 Mon, 30 Sep 2024 12:57:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmjxgnj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 12:57:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UCvFEQ56557986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 12:57:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C45120043;
 Mon, 30 Sep 2024 12:57:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F71620040;
 Mon, 30 Sep 2024 12:57:14 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.8.58])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 30 Sep 2024 12:57:14 +0000 (GMT)
Date: Mon, 30 Sep 2024 14:57:12 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
Message-ID: <20240930145712.526a1c79.pasic@linux.ibm.com>
In-Reply-To: <10165d22-c3e8-4db1-9874-8b63ca59afe9@linux.ibm.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
 <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
 <20240927200525.5a90f172.pasic@linux.ibm.com>
 <10165d22-c3e8-4db1-9874-8b63ca59afe9@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLU-o_WXle-1RBnIJyeeE9a8rLkKiPUj
X-Proofpoint-GUID: jb5ETNHKHNrJp2_sthaOKTxnBEeRmkJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=629 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300091
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 30 Sep 2024 13:11:31 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> We do have kvm_stat counters for 500, not sure if people debugging virtio
> will care.

Could end up being confusing, as currently we can assume each and every
DIAG 500 is a virtio doorbell. But I don't think the chance of this
causing real headache is big.

> The only important question for me is, what code is generated by gcc for
> the switch statement and will any variant slow down the virtio doorbell.
> diag.c has
>          if (!vcpu->kvm->arch.css_support ||
>              (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
>                  return -EOPNOTSUPP;
> 
> So 500+4 should probably not cause any harm apart from branch prediction
> going wrong the first 2 or 3 notifies.
> 
> 502 will make kvm_s390_handle_diag larger.

What do you mean by this last paragraph?

I suppose we are talking about
int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)                                 
{                                                                               
        int code = kvm_s390_get_base_disp_rs(vcpu, NULL) & 0xffff;              
                                                                                
        if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)                  
                return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);    
                                                                                
        trace_kvm_s390_handle_diag(vcpu, code);                                 
        switch (code) {                                                         
        case 0x10:                                                              
                return diag_release_pages(vcpu);                                
        case 0x44:                                                              
                return __diag_time_slice_end(vcpu);                             
        case 0x9c:                                                              
                return __diag_time_slice_end_directed(vcpu);                    
        case 0x258:                                                             
                return __diag_page_ref_service(vcpu);                           
        case 0x308:                                                             
                return __diag_ipl_functions(vcpu);                              
        case 0x500:                                                             
                return __diag_virtio_hypercall(vcpu);                           
        default:                                                                
                vcpu->stat.instruction_diagnose_other++;                        
                return -EOPNOTSUPP;                                             
        }                                                                       
}

and my understanding is that the default branch of the switch 
statement would be already suitable for DIAG 502 as it is today
for DIAG 502. So I'm quite confused by your statement that
502 will make kvm_s390_handle_diag larger (as the only meaning
of larger I can think of is more code). Can you please clarify?

Regards,
Halil

