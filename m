Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E4BCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRRB-0004WY-Dy; Mon, 11 May 2026 10:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMRQK-00042x-JM; Mon, 11 May 2026 10:15:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wMRQI-0001SJ-Gr; Mon, 11 May 2026 10:15:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BDKwJn3470197; Mon, 11 May 2026 14:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3N4Us7
 tfXloL9/VCLpLRk07P9XnF03ChVcQo30+Kpgs=; b=fa9QRelkwvVaR+XQjughJM
 TEvV9i4sMgShFAGiq3HB7IFnuK+APTcMcSSsVHPfUEvuPfNX8VqgMwp2Dx1xfGGS
 OzHcUAPGU/YjB7ymWp4HbaOn9VSNRtvmS9m8B7xdFBwc5hdCkH7WjuBZi2Zaosp0
 orcYVqESPrzPCPVFglf1XVcak2N9AJTQS0ZXA9P5Sf6JxZXj8A6x0ZAlyHSFQbCp
 O+JlckLV3++bqRMiV+yZ1fiwFWNoo3vVc/t9upTKTjTZ+CzzqCiGMF/6zFMg9X8k
 fcZMKb3aVJ1yBAjJ0C04oPMbYxr4wk5/D5eaIxB8w86JLk3nk7x8B4Z5jXWeaiIA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqrmff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:15:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BE9X8C022212;
 Mon, 11 May 2026 14:15:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5dvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:15:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BEFjZb62521740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 14:15:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EB615805C;
 Mon, 11 May 2026 14:15:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CBA658058;
 Mon, 11 May 2026 14:15:44 +0000 (GMT)
Received: from [9.61.44.159] (unknown [9.61.44.159])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 14:15:44 +0000 (GMT)
Message-ID: <f776d88f-e5a5-4e14-846c-c313cb8ab9a4@linux.ibm.com>
Date: Mon, 11 May 2026 10:15:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] vfio: propagate IRQ notifier registration failure
To: zhaoguohan@kylinos.cn, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NiBTYWx0ZWRfX2xBPInuIbuUi
 eLYf+x1vERVetZLIHSZSQt2liDF6WkNDkkjLIcx4avU+Qx7MBlX0IaJdUKN7hO3ye4K+sbCbZt/
 jitMI39sj3LMRAshg6t7oILdJ9ioeDYREK5AGuyfvxAAgyhHzYLEfsqwxtON61G+qtBbc+M3u3U
 5SqCFmGPM2ipLId9hRJw8Z+hgKsSJAUW1fhBk0pkMqpwGotveNnk+EhW3kcTkUpoNHVJrbblZ2w
 DFypuwd4TkHGeuDVar6/JRPw9SBj6/7dc5k4u59+LJTg5oNAmupNXZ+9gHQ3JFcd9LtLeFV3His
 jxXuxMKGifkoBxPODaqEr1QN0Wv+4oe0IXhiM01j4oGXxJCNgu6Z21dkaS03STUO1YaDEY3gLGS
 O4xE8rQ/fnVqkA64gzTcsECPX6kFTnfnaIA9K5FpmkqNMUvCBG4JQWR1lu/MNfiMw6uoKoJLilM
 aM/gN/xbBETkarUpw3w==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a01e493 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=8M64wXIwSogFT7ZN38IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x51vs-20vB4L9Pt2Rm0jutKlIW428FBS
X-Proofpoint-GUID: x51vs-20vB4L9Pt2Rm0jutKlIW428FBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110156
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

On 5/10/26 4:43 AM, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> vfio_ap_register_irq_notifier() and vfio_ccw_register_irq_notifier() clean
> up the fd handler and EventNotifier when vfio_device_irq_set_signaling()
> fails, but still return true to their callers.
> 
> Return false after cleanup so callers can handle the failed registration
> path instead of treating it as a successful notifier setup.
> 
> Please ignore the previous version.
> 
> GuoHan Zhao (2):
>   vfio/ap: Return false when IRQ notifier setup fails
>   vfio/ccw: Return false when IRQ notifier setup fails
> 
>  hw/vfio/ap.c  | 1 +
>  hw/vfio/ccw.c | 1 +
>  2 files changed, 2 insertions(+)
> 

For the series:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

