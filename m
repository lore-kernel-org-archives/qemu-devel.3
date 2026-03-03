Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F297EDEBF9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXuS-0000yV-Sa; Tue, 03 Mar 2026 17:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxXuO-0000vo-28; Tue, 03 Mar 2026 17:08:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxXuM-0006vV-Ks; Tue, 03 Mar 2026 17:08:03 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623IWAFJ2434588; Tue, 3 Mar 2026 22:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SAs0CO
 qSavUV37XFe7rT6j8eD2Qs9Z2i1rLvc+hOO4o=; b=csDGMsY9tNUL0WYcnee6X6
 TeHtBj4qFZvjLFcdjzd292f4OXv6H2rcSVJGygpwnYauiJe8+UwkrGe6ssBsE69Y
 YA4rqVW8ojGhFU4YqrE5RpFIfpFCWVLDxxIu/HPx6bMxcQnC0GGHgHXd738uSa1b
 Q1nzCrvMNIWEdua75CRtdH+fijuoI4AiC3iC1KZZvELr9QQTrPY7NQiWpyUCMjr8
 f0I+YuR1sGaM88Tzhjfr7FmF69jh+ImuhiFn/39Gogu4VupiF4+4o56ZYhto1tan
 6zFOLHBbMFi0YIawiEfwQfcLGXWCh+eCRbJ7SeIJhOVHx7kfnq4k81R98hzkd3nw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj52r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 22:07:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623IkQi4010335;
 Tue, 3 Mar 2026 22:07:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k45p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 22:07:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623M7tvb32113202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 22:07:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 150BE58050;
 Tue,  3 Mar 2026 22:07:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4813D58045;
 Tue,  3 Mar 2026 22:07:53 +0000 (GMT)
Received: from [9.61.253.239] (unknown [9.61.253.239])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2026 22:07:53 +0000 (GMT)
Message-ID: <e1817c77-6b4e-4c3a-8b9a-d721063a78e3@linux.ibm.com>
Date: Tue, 3 Mar 2026 14:07:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-21-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260212204352.1044699-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a75bbd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=gSotS5IQ57q7EN8DGNQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3OCBTYWx0ZWRfX+ZKDkUc68cin
 WSxQxnkj3xag8tIK9cnDi1GNf5PJBoSCK+dFWF0PQo1NikGOnYfgpdh0YHpc3eg5avQ+lHFrt23
 Nh3faQYlXwgm/DS+L5iQP2S+FbPuxwDoEwphg4DVbRJ521Lv1Zgco7RTkq7uYhrea3qCCvW7HdT
 VBX59X5p9+OJwfwITQkXJ/syicUj2bMXTgraiTpqvF7109r0T163FRuFfNHt/37WwIazH2mrMFl
 5NGItf7xXCpt7+XX5PN3ET9ShxHxlH/DaRI3gJIG/xKh+g1VA1EUZdqk261I/3fYjZQPQv2/iR5
 hPnRLGUw/tYBRnEPFoP0mTCOcq/Cah0NPy0FGf+EfFZ4yR1MERCbvaKN5gNXAPdxRxdMDtvzwRa
 gGkuMMHSUX968ju6sqlmE1KIT4vwG2wIr3XblDJEPMqi6lnI5/z1+aZ8J5qReX/JXkwlS0lVenp
 sjwAmmANn2G+QbbL+JA==
X-Proofpoint-GUID: cAsUgdbWafdS6Ne4JRtZiUZ5zGyKQg5_
X-Proofpoint-ORIG-GUID: cAsUgdbWafdS6Ne4JRtZiUZ5zGyKQg5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 2/12/2026 12:43 PM, Zhuoying Cai wrote:
> +static bool is_comp_overlap(SecureIplCompAddrRange *comp_addr_range,
> +                            int addr_range_index,
> +                            uint64_t start_addr, uint64_t end_addr)
> +{
> +    /* neither a signed nor an unsigned component can overlap with a signed component */
> +    for (int i = 0; i < addr_range_index; i++) {
> +        if ((comp_addr_range[i].start_addr < end_addr &&
> +            start_addr < comp_addr_range[i].end_addr) &&
> +            comp_addr_range[i].is_signed) {
> +            return true;
> +       }
> +    }
> +
> +    return false;
> +}
> +

Shouldn't we use <= and >= checks? For example if 
comp_addr_range[i].start_addr == end_addr, wouldn't that be an overlap? 
and similar for start_addr?

Thanks

Farhan



