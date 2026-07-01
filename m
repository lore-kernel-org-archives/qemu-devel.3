Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEB5C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wer7n-0006RU-Mr; Wed, 01 Jul 2026 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <syadav@linux.ibm.com>)
 id 1wenEh-0001m4-GK; Wed, 01 Jul 2026 01:11:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <syadav@linux.ibm.com>)
 id 1wenEf-0003C4-R9; Wed, 01 Jul 2026 01:11:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6613ICZx4061322; Wed, 1 Jul 2026 05:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7qmi50
 UoS8q9wmo3tmp2mRMrA1cWrFujuLb1+Yu6YMY=; b=a3u7lJGPTgOjbiZJ7s6uTR
 lOw7+6GHXeCyTkoQ1Hqbv4hvJbYVynRJPyY0fhiLMGmWsIJaVgpa/6v+0K1P4jH8
 +YlhQ4yzfgjTvBW0OrFKdLik7WxykY5MBLDchBJUnHANqjVwCUB1ZpOvYRf1Vayl
 sSk7bC7lAYe2ixeOd51mVDx6qH3tRWCTBsRPjmKx6Yto7psqCEXCGcxXHpUltgkd
 cgRBFckQuE707UsoiwkFva/AWNq+VW037ltOnCpCge92QMk8YZA4NGBu3Y2ZK649
 tac5Nfk6N8J6S00f2+WmFiOfvfoxe/ytR2FbnOgcRgJjsw+xCnUjL2t3oS+l1xkg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg2k4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 05:11:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66154Z1m004823;
 Wed, 1 Jul 2026 05:11:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhdnq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 05:11:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6615BbTD20578770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 05:11:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30B2120043;
 Wed,  1 Jul 2026 05:11:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EC3820040;
 Wed,  1 Jul 2026 05:11:36 +0000 (GMT)
Received: from ltcblue9yr-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 05:11:35 +0000 (GMT)
From: Sneh Shikha Yadav <syadav@linux.ibm.com>
To: gautam@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sneh Shikha Yadav <syadav@linux.ibm.com>
Subject: Re: [PATCH v2] target/ppc: Expose the TB offset of the guest in QEMU
 monitor
Date: Wed,  1 Jul 2026 07:11:20 +0200
Message-ID: <20260701051122.939440-1-syadav@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626093554.69966-1-gautam@linux.ibm.com>
References: <20260626093554.69966-1-gautam@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a44a18e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=foYxvERbx4e-ZuiC3n4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX0Q4Zm3wx6Ppq
 EhilFPuWuDSNmbFAdLWB4yw2SVoveZL1Fuefwsfq925aAdQRBJf4prEBMEV5zSr8VggUll7aO1q
 rY1NcfsFS8IjWTyJksnjb7tiGSr3RU0=
X-Proofpoint-GUID: 7a_piHurJG90NqvZOkfUCOxVS3lMw70g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX5v10vAmH3Qt+
 NZJUhP8TqFuw6p1RBwUAWR9bekfdjDiabwMiDIxTu9xQVuPsRPV8+iC8uB80B/HxXnJUoO7rJ1d
 3xrSvTIbq/24YJOpUnH82/0pLbwdhZ9GcDSr56DJdbsxe+Bq86+If3+KFuY1ytfWfEJv8UBmdax
 jTAiEu4Z7b8hhXvbcjcCsH5ZKfg+p1pQeacZ3cvkEf1xJjj8HDBZdMuKUdf2Ud17YptTJ6je7CC
 pMzzGyIU9FbsXPpzeXFiB8q+MFPkQAbdmbbKxi5fYpLmKK9MmyR6lsr5folyrz99MCIuvUCOQmM
 QqontxP6q3M4goi0dHRTQsoJW4QMn/773/w7+imJeN8v2crfvIc9xV/ILaKxBTHTqfZ9xlrqdC9
 DBpMUVF5E3UcRojxEo9xaNLIcDiLmea1kZqaK9WspyxndKNeg42WFyp6fg1Zqi48ggH51Q39Ji4
 PDRuHC46Tyb6MCP/fig==
X-Proofpoint-ORIG-GUID: 7a_piHurJG90NqvZOkfUCOxVS3lMw70g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010046
Received-SPF: pass client-ip=148.163.156.1; envelope-from=syadav@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2026 05:20:49 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Host: SLES 16.1 (ppc64le, Power11)
- Kernel: 6.12.0-160099.38-default
- QEMU: built from latest master (commit b3ea565608)
- Guest: avocado-vt-vm1 (ppc64 KVM guest)

—logs— 

 TB offset visible in QEMU monitor: 
# virsh qemu-monitor-command avocado-vt-vm1 --hmp "info registers" | grep TB_OFFSET
TB 00000000 00000000 DECR 0 TB_OFFSET -916489431416832 

On Host :
qemu # trace-cmd record -e kvm_hv:kvm_guest_enter -e kvm_hv:kvm_guest_exit 
Hit Ctrl^C to stop recording
^CCPU0 data recorded at offset=0x140000
    2728 bytes in size (65536 uncompressed)
CPU1 data recorded at offset=0x150000
    187 bytes in size (65536 uncompressed)
CPU2 data recorded at offset=0x160000
    7084 bytes in size (65536 uncompressed)
CPU3 data recorded at offset=0x170000
    0 bytes in size (0 uncompressed)
.
.
.
CPU14 data recorded at offset=0x1e0000
    0 bytes in size (0 uncompressed)
CPU15 data recorded at offset=0x1e0000
    42586 bytes in size (524288 uncompressed)

On Guest :
# trace-cmd record -e powerpc:hcall_entry -e powerpc:hcall_exit -C ppc-tb     --ts-offset 916489431416832 -o trace_guest.dat
Hit Ctrl^C to stop recording
^CCPU0 data recorded at offset=0x130000
    186 bytes in size (65536 uncompressed)
CPU1 data recorded at offset=0x140000
    522 bytes in size (65536 uncompressed)
CPU2 data recorded at offset=0x150000
    95 bytes in size (65536 uncompressed)
CPU3 data recorded at offset=0x160000
    111 bytes in size (65536 uncompressed)


qemu #  head  -10 /root/combined_log
 trace_host.dat: cpus=16
trace_guest.dat: cpus=4
 trace_host.dat:        CPU 1/KVM-596247 [000] d..1.916674455351586: kvm_guest_enter:      VCPU 1: pc=0xc0000000001b60e8 pexcp=0x8000 ceded=0
 trace_host.dat:        CPU 1/KVM-596247 [000] .....916674455369430: kvm_guest_exit:       VCPU 1: trap=H_DATA_STORAGE pc=0xc008000001c6070c msr=0x800000000280a033, ceded=0
 trace_host.dat:        CPU 1/KVM-596247 [000] d..1.916674455373152: kvm_guest_enter:      VCPU 1: pc=0xc008000001c60710 pexcp=0x0 ceded=0
 trace_host.dat:        CPU 1/KVM-596247 [000] .....916674455378631: kvm_guest_exit:       VCPU 1: trap=H_DATA_STORAGE pc=0xc008000001c6070c msr=0x800000000280a033, ceded=0
 trace_host.dat:        CPU 1/KVM-596247 [000] d..1.916674455380902: kvm_guest_enter:      VCPU 1: pc=0xc008000001c60710 pexcp=0x0 ceded=0
 trace_host.dat:        CPU 1/KVM-596247 [000] .....916674455386279: kvm_guest_exit:       VCPU 1: trap=H_DATA_STORAGE pc=0xc008000001c6070c msr=0x800000000280a033, ceded=0
 trace_host.dat:        CPU 1/KVM-596247 [000] d..1.916674455388450: kvm_guest_enter:      VCPU 1: pc=0xc008000001c60710 pexcp=0x0 ceded=0
 trace_host.dat:        CPU 1/KVM-596247 [000] .....916674455393602: kvm_guest_exit:       VCPU 1: trap=H_DATA_STORAGE pc=0xc008000001c60f4c msr=0x800000000280a033, ceded=0

Tested-by: Sneh Shikha Yadav <syadav@linux.ibm.com>

