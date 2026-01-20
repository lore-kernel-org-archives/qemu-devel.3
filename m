Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B1FD262A2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJ9p-0004Bw-PV; Tue, 20 Jan 2026 16:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1viJ9n-0004AV-Di; Tue, 20 Jan 2026 16:20:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1viJ9l-0006Fw-U8; Tue, 20 Jan 2026 16:20:59 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEkpqf019939;
 Tue, 20 Jan 2026 21:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/xCHB6
 yj29TUDGz5bw/0QBYmarxN9XBpn5J025iIROQ=; b=cTBLPvCbUnRJd1l05rJpdr
 kX9f7nS8j50S8mfUU84ycvAhTYJJWM500+OnT91gmRxqVFrskJJyd/dTPIDHXyKK
 Kcqx/kolhQclpatPkEYEYiWoFS3Us9YCn2bILo1wXBGAevLFhDiLCqPkZPF2IKXV
 3VkxBQCcYAvrkWH8jWwzJEG5Sf2USZ6Bt8UQxKCvvu94ORYaY8JgDwxxaJl2yUXV
 zEndslWDf+N2cILfk4om0agFU773EFtkkg1SDkuguuTOklxuWv98+tf60bg7T64E
 DZhjSUL8vnZohIyciqf1Mw/3yfvAJr3t502WcYuC6n4nSVGnMrmzANdOG1T+bVMA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br2560hk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 21:20:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KK975A016611;
 Tue, 20 Jan 2026 21:20:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4y03j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 21:20:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60KLKoMU31457934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jan 2026 21:20:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C01958053;
 Tue, 20 Jan 2026 21:20:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FDC758043;
 Tue, 20 Jan 2026 21:20:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.131.235]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jan 2026 21:20:48 +0000 (GMT)
Message-ID: <8de79fa47598b2d1257cfce0a2301213f16857c4.camel@linux.ibm.com>
Subject: Re: [PATCH v4 08/23] virtio: move common part of
 _set_guest_notifier to generic code
From: Eric Farman <farman@linux.ibm.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, Cornelia Huck	
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson	
 <richard.henderson@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>, Christian
 Borntraeger	 <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>
Date: Tue, 20 Jan 2026 16:20:47 -0500
In-Reply-To: <20260119185228.203296-9-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-9-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE3OCBTYWx0ZWRfX/mvWXzP1SE8z
 mfSwWHfvX3w3scvJ4RWdGR9h/ZmSTFS5uHzN2zzqb6nonxVdee7M8DJsVJeeRMCbeRn16JSDRED
 pgn75VS+Rw6N/k/ZhL2C6Fpd0+YTPa4/aNjHiu2NC6TkzsfKsRJhH27SY/zySyIIyRP3Ji9nxi8
 PgTPeMwlketQW+yr8TU9ampCw0p+dt3tioL/ZqwZJS8dpNreRhiPany15+Y/IxXegBP+Yqboj0W
 GZUURngaqHS4cgpsGkl62ZIO3+xdwrQ51NCPiaCg1xWKMXtmj3uUYNdR+chKw9ajYciXCl3cmMf
 pVPgeIIWgnYs7c4FwLwBzcCv8JH3SddZ0vdJ0WlY6uI92R66QXV/VHtUWf8xKPSoAoilce8JFzu
 PGzvg+sz56MiqDcDVUEatH5gddrnDdiYjtiUETjE9lSW1DL1pr8muasL3rd0M2YJ+bc2tu6ybnX
 z41xps6fHLBqxk0+VBg==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696ff1b5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=T1sg2oPVfj6KPagXb30A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: 1dg7toHsVrn2Sn2e9Q2MS1ooHEFaLOAh
X-Proofpoint-ORIG-GUID: 1dg7toHsVrn2Sn2e9Q2MS1ooHEFaLOAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2026-01-19 at 21:52 +0300, Vladimir Sementsov-Ogievskiy wrote:
> virtio-pci, virtio-mmio and virtio-ccw handle config notifier equally
> but with different code (mmio adds a separate function, when pci use
> common function). Let's chose the more compact way (pci) and reuse it
> for mmio.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/s390x/virtio-ccw.c          | 35 ++++++++++++-------------
>  hw/virtio/virtio-mmio.c        | 41 +++++------------------------
>  hw/virtio/virtio-pci.c         | 34 +++---------------------
>  hw/virtio/virtio.c             | 48 +++++++++++++++++++++++++++++++---
>  include/hw/virtio/virtio-pci.h |  3 ---
>  include/hw/virtio/virtio.h     | 16 +++++++++---
>  6 files changed, 84 insertions(+), 93 deletions(-)

Acked-by: Eric Farman <farman@linux.ibm.com>  # s390

