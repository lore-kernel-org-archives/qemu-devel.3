Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6EBC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tivKS-00014I-32; Fri, 14 Feb 2025 08:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tivKD-0000yA-Us
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:01:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tivKC-0001Xv-AC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:01:45 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAIioc000384;
 Fri, 14 Feb 2025 13:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cnDJBZ
 kt1OgwRdtqSho/h486x+OgccAlYywIGndsaqk=; b=hw0/5NMYeSA3+4NQ9vw31K
 hJyoQOORvhkA7e1VxMR4ndvXenED8ml7XFFJ3PvJtJATtF6IlGVXp4WqYDHu75W0
 LVKoMnCuDrDPRh30EVVRvm5Ywm/TXtCwK1WPtXuNzVaYx5TK9BW88QIq8hRJ571S
 CuR2ihfHkGR+k/XFk8amjF7OTQOvsXIGYEFnx7OT890z2KymmPxyVLvPSWFLKhoo
 j1hsUEJORtsbmPECgahby+kYCzGP2nIzPoA7BTgO+w2s5lF9tjx+8jsog6j6yZ8M
 Kq7eymxLba34T3wrntny4RPEgqvDyManVckF/wN59Gl6O7LlxahFKQqnX0St1aOA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvabae3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Feb 2025 13:01:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ECxnMr001002;
 Fri, 14 Feb 2025 13:01:39 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssvabadv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Feb 2025 13:01:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EB0Arv021722;
 Fri, 14 Feb 2025 13:01:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phkt3t2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Feb 2025 13:01:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51ED1c8Q53805406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 13:01:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 227F85805E;
 Fri, 14 Feb 2025 13:01:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6F395805A;
 Fri, 14 Feb 2025 13:01:37 +0000 (GMT)
Received: from [9.61.244.246] (unknown [9.61.244.246])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2025 13:01:37 +0000 (GMT)
Message-ID: <e276c7a4-a96e-43a3-aedc-2ac3be6581f0@linux.ibm.com>
Date: Fri, 14 Feb 2025 07:01:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
Content-Language: en-US
To: Lei Yang <leiyang@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com,
 Eugenio Perez Martin <eperezma@redhat.com>, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, Sahil <icegambit91@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
 <CAJaqyWeHB_+ATn3cvtVrpiFp4NjNLoKpPP1ijs4C7eyRL7gpKQ@mail.gmail.com>
 <CAPpAL=w-0kgngVYiep2+K_WEGnuv1T_mTFTUbz9JPmH93HHzBg@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CAPpAL=w-0kgngVYiep2+K_WEGnuv1T_mTFTUbz9JPmH93HHzBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X7EjSj82HeZsS8R4t8_5HhxVATc5b3k-
X-Proofpoint-ORIG-GUID: qkLp3uufpLq0C0VSehoJBhm8vbVSX09g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=425 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140096
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 2/13/2025 20:24, Lei Yang wrote:
> vdpa's regression tests


