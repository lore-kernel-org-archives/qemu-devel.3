Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5C7CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5P-0006OZ-6I; Wed, 07 Oct 2026 04:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEHpT-0006yR-3X; Tue, 06 Oct 2026 22:56:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEHp3-0005W7-As; Tue, 06 Oct 2026 22:56:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696I6P8i240501; Tue, 6 Oct 2026 20:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=K0mzXZ
 2tgtuR3Qvjnj/daBe5/8Orl0oacQtyICZ0wIk=; b=eRoQhxrbumk4O3B1XXQYlT
 VK1IjjzPSIEHKdvrA0H9W3uSzWSb48RUtF6smTjutvYNCguKtXmZZ5wv0EvT75Wh
 dmbFL0WapLtkd+xLdkzxm+sB2LGo4CRM2UGKDxW/X2ZrPj/t6SZuNHZuM9zIGNQh
 eHux/WXUjIGmF0pJo1f86KBjJIUZgzCMUMITllN/5RBgsxFXOsuHtbMGbyAUWxbW
 1cm9vJXW+fGy9Mrxo9zPva046/WJX2P/rkm88eVWn6K9Cv24MRiRsxyLH9v5J+6A
 VJZf165XdPe/sIWp9TP5DQfhKM39cyl/1QqKUkA8SbPCgHvnTX+QBSECMjk1AZrw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv978q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 20:35:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696HlWAe690425; Tue, 6 Oct 2026 20:35:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgun74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 20:35:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696KZqCU1377256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 20:35:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CE3E5804B;
 Tue,  6 Oct 2026 20:35:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5830458066;
 Tue,  6 Oct 2026 20:35:51 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 20:35:50 +0000 (GMT)
Message-ID: <964ad056-b8ee-4734-9403-91264a75c84f@linux.ibm.com>
Date: Tue, 6 Oct 2026 16:35:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/17] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20261006001643.420929-1-kshk@linux.ibm.com>
 <20261006001643.420929-17-kshk@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261006001643.420929-17-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4RJ7TXt0uPfQWMY_JHr8DKDOkpaP7qE4
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac55baa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=x-B4hQBy79GTlnKUhDoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4RJ7TXt0uPfQWMY_JHr8DKDOkpaP7qE4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA4MiBTYWx0ZWRfX5VxW+ACPTCLw
 nMyrhnMd6+wtl4/sREuS/kJ7y7rGy35TyH4BrtPFKyS/pHvK+/4nIGlR7jqEvNRvg58s9SYPNh3
 bTtBkBne0380xoFbjkag9skzk5KP1F8wUP7ANNxgfnINHHs4I28P+fpAW0f5oTdSAIoxYz6vwUQ
 JGHeK0pgvwTndS4F0mJcS+TgTfoI80GIBQ+HsyIxZdcbpBCgmpLBRwfXYlGHgXSs4PVJO+UcI40
 cCeuw4ysPBrx/z1O4AGK94qaq/Eow/fv+sSm1+So9NhLU8LPVS7nJtj33Qy8ye5d040iq9Hfxo+
 wRYb7IxB1+j3g6BOc4gS4a1e23W7JIjEHK5mBoMW6TerTs/PhQVxNmKzUaaX/UJAQJPtVcmDL5n
 HdBBsq/5wH//DfsuflFxqLMgLwgALqoqjuBRCLGTiObfxChV+4sFAmFz7QUSI+IXuPD4TuXwGWv
 07Z8ThEBz3b8NoAwpBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA4MiBTYWx0ZWRfX257Rjud9Hdrs
 nEtE08swxRET+Y7VXOCtMjXztsvYOw54rgIAx6DlD2D898mSoh06OEECMKQ7JtdtIKLmpcbuhTq
 98pY/RRVUaSxgxd1G2yWwOE7dmpIVHA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060082
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 10/5/26 8:16 PM, Konstantin Shkolnyy wrote:
> Implement zPCI device state migration, consequently enabling migration
> of VMs that have emulated PCI devices, whether virtio or not.
> Migration is allowed for devices whose function handle has the
> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
> state of its zPCI emulator.
> 
> This will enable emulated PCI migration starting with s390-ccw-virtio-11.2.
> 
> Passthrough devices will continue to block migration.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



