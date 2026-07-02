Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6439BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6r1-0000sK-B5; Wed, 01 Jul 2026 22:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6qv-0000s1-MN; Wed, 01 Jul 2026 22:08:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6qs-0003aR-2a; Wed, 01 Jul 2026 22:08:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KDq42646296; Thu, 2 Jul 2026 02:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zFfo5W
 NnS/Wb8k4LcM8YKVQ8t35i2ITu6YsDFvQnOI4=; b=Ov5drtb5jUDWdBk52fjddP
 0WtuU7slxAOzjUaQhKpX/JOBSe4OnRQ8KtVlNQfXseCyB4NE8zuAEMkedcq3okMs
 wAq9R7BN8pEcGarPtM19PxTz76V0on9gkNl8Xeyl4Mk5sjrm2IkE+NnmPYo4DRsD
 Pu//JUZOSJ7t4E5e0xBcA+2Gymb2FrXASfX8GBulbOuTqbMDFI5nFmhlL8LF9j1L
 IBH4P90gF2y7EQDkNaWFTd0sIJqwAcRmQW/D/T3CdmBg81MB1HMuRLKyZCjRtyb4
 uFYFgBrhop/M2dlBtrFtWpC3Z8P0QTDaHQah7g0NDSNJlp+5enWiK8zTKS7zGHmA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg7krr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:08:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66224jKS000403;
 Thu, 2 Jul 2026 02:08:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyhs33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:08:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66228PH0983864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:08:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18FA058053;
 Thu,  2 Jul 2026 02:08:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C75658059;
 Thu,  2 Jul 2026 02:08:24 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 02:08:23 +0000 (GMT)
Message-ID: <600890ad-c962-464e-8414-159110ceb8f5@linux.ibm.com>
Date: Wed, 1 Jul 2026 22:08:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] s390x: Enable boot menu for virtio pci device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, nrb@linux.ibm.com
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
 <20260630141917.673995-7-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260630141917.673995-7-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a45c81b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=sE9LAG50w_MMDgMmH7gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfXzZabu52Zz2BK
 5+jHRDYLyXeEFErLxD2gxyp6sWnRdepEBP2DJUj7LfwNTn0nNqWFAyta2RPWq2mneD5vtudM9Ii
 7ROYeWPDHDGzMOH6Hfx+f6QAPSLF6BA=
X-Proofpoint-GUID: 09BaeW3u21Vrhq9buBkwC1UWgY6cJn9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX0g2i3/TDeaN0
 xc2Wnx0g3C0u4jr8erbktDMCQmrvmINsIoRIgJSXAVkVUuJYmur3PX7upY5quA7xU0sgBwiI7+B
 2khXMlCF0lV9lBIgfjEiaQZJHvNStI2ioY+yze25CATJn6cCO0QcR1+RdYhOkN2oSR9rgnk/vK9
 51leEhrhv20pKfsIfMyB0bI0stOF8BhSpa2m9ZpPyFyzPGKrpHPQNMS1Mjm1VXkOizD7v7Pux2j
 mtFOeIgDS8XDHm1g93SULPvBk1aoNNWydObb1qTZ5/dLfKksHubYxY0v2hBQJ2S2Y/ftcefGxU1
 5nPiGSIQaKB1R7vd8AByFI3Eyz6jbjrnHfMRwCG8Tc42F37zCZgWOj3opvBu3OUxGjyd95JWxSJ
 0cGUMbA0zbcE1tMY4GZSsGd2gjgRCudcimFFZ+ianwqqK5EJQUR80bFbUmqjWH4Im46Y7ZulfsI
 /tYha5tf14hk5JiKI9A==
X-Proofpoint-ORIG-GUID: 09BaeW3u21Vrhq9buBkwC1UWgY6cJn9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020016
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 6/30/26 10:19 AM, jrossi@linux.ibm.com wrote:
> From: Zhuoying Cai <zycai@linux.ibm.com>
> 
> Add S390_IPL_TYPE_PCI to the boot menu handling logic to enable
> interactive boot menu support for virtio PCI devices on s390x.

Thanks, that message was bugging me!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



