Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941FCD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUU4T-0006pP-Gp; Tue, 02 Jun 2026 14:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wUU4O-0006oJ-Jg; Tue, 02 Jun 2026 14:42:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wUU4M-0007oR-8g; Tue, 02 Jun 2026 14:42:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652H8aMQ2252299; Tue, 2 Jun 2026 18:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Wj6Weh
 /53kFi0T/XFw6etrP8rZkC/EZszQofIgGlWqI=; b=WMxXnALN3Ocd52oFBtJq/x
 Y86U9j4eSiwoP8r35AkFDupmVLnGS3kI2dVDwDPeQp7Av6uSOoxn6DCPdDd7Qxma
 EKjpOu0bQEqHcO9UO4te/sp4NBAynWC0X3ok3bPOfyjfL8oGGy42XysVBK10oraH
 wINEVI+Y0ZSAG9dXyFJmitTem/bqzyzhENsyniV+rEjM65YLa12EDCAj5lE1H7+/
 qNpa3jhtHPFlG5efETSX/9a3j9LMQdXbLB+mxWga42gJQttJQKn7e2tQtxQcaO4g
 +qaNY0eZGmmScqN9dJZCB9owUfg5iktmKXUdFuKYIZuk4FIDx/PltPVwjooAhqkA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae72mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 18:41:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652Id7Ul021827;
 Tue, 2 Jun 2026 18:41:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegme64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 18:41:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 652If39N45810034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2026 18:41:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCCA22004B;
 Tue,  2 Jun 2026 18:41:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D30AB20043;
 Tue,  2 Jun 2026 18:40:55 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.222.72])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  2 Jun 2026 18:40:55 +0000 (GMT)
Date: Wed, 3 Jun 2026 00:10:51 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anton Johansson <anjo@rev.ng>,
 Claudio Fontana <cfontana@suse.de>, Eric Farman <farman@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 00/17] accel: Remove need for AccelCPUClass
Message-ID: <20260603000919.aa8ef782-b8-amachhiw@linux.ibm.com>
Mail-Followup-To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, 
 qemu-s390x@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, 
 David Hildenbrand <david@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, 
 Paolo Bonzini <pbonzini@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Anton Johansson <anjo@rev.ng>, 
 Claudio Fontana <cfontana@suse.de>, Eric Farman <farman@linux.ibm.com>, 
 Alexander Graf <agraf@csgraf.de>, Chinmay Rath <rathc@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1f23c5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CnG8uNZVtDK0WMHvXWgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: t3RPffKaiVGON4-YzFWFOayKjCz6GcCw
X-Proofpoint-ORIG-GUID: G9YjEl62xL52NkuhT-iK6qev1GebvKkQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4MCBTYWx0ZWRfXzMtNX4PwSFiV
 UGnQgKwkvjnJNb+DJ6JMnMzvyc10SO420fS3vESI13Cmbxjthix2mGSfCIEsxM/FqXkqkKUnsdT
 EQ6/bF8VHNOMV9CUYV8gex45qhzpEl+2FhvKPb05qbgZHcqt5a/Txnk930WlJUfL7Yl9vAJ7rbL
 ETjrpLjhw/uigqB0b0P+3M8Vrh91oY9K/88oL8RSq2W/AWlzjSU7sT/gq96OP0eS8h2S2kxca4y
 I7geJS/c+yVY0V4xzRDuD6asPxkOhnGFH0+IJCYUg72n6v6V/QGBuDvpYcRvSu8UfAHHMC0u5CW
 ZI5E0d4dxFidQ1YxdEyT1KlFi2/hjgi3qt69Qc/PWaliZ5L4pLj1SQDnIPR7PqfqUtqfWjwzY/f
 /pxoI1EaPrz3ZTMFHV77RyK2j1hvSbMN3po6Z+Jd4Zrk7VSONL59wTW3AUcRBR9fNs6xnbjEqwh
 9iIG9CxMiLLvgcD5DXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020180
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 2026/05/29 09:49 PM, Philippe Mathieu-Daudé wrote:
> Could get re-review: 4 & 5
> 
> Move cpu_init/realize hooks from AccelCPUClass to
> AccelOpsClass. Specialize them for TCG in TCGCPUOps.
> 
>
snip

> 
> Philippe Mathieu-Daudé (17):
>   target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
>   accel: Remove AccelCPUClass::cpu_class_init()
>   accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
>   accel/hvf: Remove need for AccelCPUClass::cpu_realize
>   accel/kvm: Remove need for AccelCPUClass::cpu_realize
>   accel: Introduce AccelOpsClass::cpu_instance_init handler
>   accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/kvm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
>   accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_instance_init
>   accel: Remove AccelCPUClass::cpu_instance_init()
>   accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize
>   accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize
>   accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize
>   accel: Remove AccelCPUClass::cpu_target_realize()
>   accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'

The changes LGTM. For the series:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

