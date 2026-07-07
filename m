Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B59C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgucd-00064I-NE; Mon, 06 Jul 2026 21:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wgucb-00063O-Rt; Mon, 06 Jul 2026 21:29:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wguca-0004Zk-53; Mon, 06 Jul 2026 21:29:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KINqs1636945; Tue, 7 Jul 2026 01:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vvqKx1
 HiSmBUOYN8mrT8MTLGIBrmNj/ApDqsd1P0XXU=; b=bBj6zuJjv7Xj9kxcKOn/cx
 +IpFrlo1XddeQQpmccelNFLR8ktHQP2RGZ1xPW8uE4bDwDAz38sIc1+MU9wncYOO
 fg61SLvcyiErl2wlvH64c0q6bi6NC5e+GuI6XgKRhenpIIedbsJ4axvJjcSQ3cUs
 YSM+GDbqWuAVlCyd1Zm/v5cl8zy5y4cluFwu2l3zJ3cNq2ucqq90+ZmxGeHlpD0V
 fvKCl19KFED2BEhsJkR4MN25c4AYRYEOsrYnbXE3kkphLN8ugX2UnMFWgPvehgm3
 z9DCPhf8JBHerPA28o6VN3GaLeYGzYiGdsnzjKas4DxP6H5T9IVOpd0nvqnSsSOQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqm6g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 01:29:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6671Jd4L019859;
 Tue, 7 Jul 2026 01:29:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk04jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 01:29:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6671T0hc29557324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 01:29:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B29355805C;
 Tue,  7 Jul 2026 01:29:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82A2A58058;
 Tue,  7 Jul 2026 01:28:59 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.133.144]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 01:28:59 +0000 (GMT)
Message-ID: <40b8290dd08f61e96169991f016770d83dab6669.camel@linux.ibm.com>
Subject: Re: [PATCH 1/5] s390x/sclp: reject invalid write event data headers
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne	 <jjherne@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Ilya Leoshkevich	 <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org, Hendrik
 Brueckner <brueckner@linux.ibm.com>
Date: Mon, 06 Jul 2026 21:28:59 -0400
In-Reply-To: <20260706091909.864405-2-borntraeger@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAxMCBTYWx0ZWRfX8yNKfPaaFvhR
 kZ7XTwRReSw0gDgenYsiZWzmhLgGxeBP/AUM6x47Swcc+kJBOE8/naBwLQV4DExM5mVyMo4ZFM9
 mOyAkPyYRr3s6pD8E5ErRHCfu6MbdVw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAxMCBTYWx0ZWRfX0yCb+T9Xlq+Y
 uvZcWNoeX5XJDM95Tx/LttTwecLwy+8o09BnYzkoTMJ9RUbkHEgUp5V+48y4yILtYfqUXubTQoX
 CzWZlnAqqIeWIGge86IptvsgrezhKU7UNCmm5IJ3VS5BUi9/FFpeLDo86AZATqi1e7WQDC8LLSa
 7EFvGgwh7Q2CQYK5mVGVWzinIuMxQ7XMB8o2bJQzfX7LuRGjmERylE3UMiFja5RZDPomiBkjY25
 +zbzBDFyYip66CE6fi366AY3cg9D0Ef32dvnwS8N9YDrd3H4Yz0lDMusWVQkRNRbwQAqt3B4697
 1ZkBGZaFefHLqOvp13JCRY2yHfSJk7k3jOpmItuQ44cMVtg9j9+lMSWie73Xliesp2tG1h5SxWS
 YZA0scFcy36bhfy/5DsiTvrfqm3TPpWR031RBo8A+OOksKRfHuER9mBETSD2psBrw+/l6FR48JD
 aA7kHUmMY76jhVUHKcg==
X-Proofpoint-GUID: 0bl_CZdd-Lc19Mos54FWibun2a-i3P0A
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4c565f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=tESqfjWgzHjUGcFlV_sA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 0bl_CZdd-Lc19Mos54FWibun2a-i3P0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070010
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2026-07-06 at 11:19 +0200, Christian Borntraeger wrote:
> If a guest submits an sccb with a tiny header length but a large number
> of event mask entries, the write_event_mask handler will
> 1. return the wrong RC (ok instead of error)
> 2. write to memory after the allocated sccb in qemu host memory.
>=20
> Add the necessary checks.
>=20
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  hw/s390x/event-facility.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

