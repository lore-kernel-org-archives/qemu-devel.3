Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B859CF34B2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLikL-0000Wo-Cz; Wed, 19 Nov 2025 09:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vLikJ-0000OH-2a; Wed, 19 Nov 2025 09:01:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vLikG-0006FJ-Ee; Wed, 19 Nov 2025 09:01:18 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ40VMt014162;
 Wed, 19 Nov 2025 14:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4gqlMW
 nkBOJXqOu3AxvpWE2hOBlYH6otz5slXWkIUKc=; b=WzupwgVh0Qjo5ltXoHXWNk
 0P5frtWsOXygW3epzPgBBQyC+BB510RUYE9brLFZGDy3qTUJeRD3QiBotTjw1D0o
 7KT2QzYxvPJ1QrFIdoQ3irm9J7Qz/7MevDgx5Gcsqp8TWIYpqXIH0POQ6QuKD3YX
 VdineHXvT7Ed8RbiPEn54jBxIvIqfDT08VDn0nOZzrYvQHCPH94uLi/Au4ap+bkM
 /gvevUQmgw9kGeaYvsSqZKdeIwXca3xAmgHS8518bg/3hoB4aqojFeIY/U1LENB9
 xratzJqSp6jDU5GI6d4x/jVYtQ2/5H4MA1dx4/rOC7uICBZUHf6g1WQB3L+3Uo3w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejka0r8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 14:01:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBOAxW005231;
 Wed, 19 Nov 2025 14:01:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bk8xk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 14:01:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AJE12Oc31392460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Nov 2025 14:01:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1837258056;
 Wed, 19 Nov 2025 14:01:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6875658052;
 Wed, 19 Nov 2025 14:01:01 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.147.101]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Nov 2025 14:01:01 +0000 (GMT)
Message-ID: <dcea76416ffe30278bad0cec5c4a009d63cabf3b.camel@linux.ibm.com>
Subject: Re: [PATCH v3] hw/s390x: Fix a possible crash with passed-through
 virtio devices
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato	 <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>
Date: Wed, 19 Nov 2025 09:01:01 -0500
In-Reply-To: <e399cffc-155c-4846-9c68-5f449ab9a6f4@redhat.com>
References: <20251118174047.73103-1-thuth@redhat.com>
 <8fd35be2f4d424f0093110a050c7e29830561012.camel@linux.ibm.com>
 <e399cffc-155c-4846-9c68-5f449ab9a6f4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1OFyaIcCCTz9tBuronckv-mOOgq3rKiQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0tcsbmDB0J2z
 ybQuz0+uSioL/YFQcCbel/Wpkelyp8RFbR8qBXnTofOeQuOKEIw2yFrFOIo5sybL28/1BEZlZIP
 p/R8Bv+AsHmzsQYrCLDcfZovTkg7NRH2gBg15+VxNTePonhlPBCFz+Z5hZBiz73WXluxlhuHPgM
 xn/wQpJZ1CVtUxvkblRO7XGc6M/6GciP4RxE2FTco98XCyVikObLko0y1fHlS9toM2l8eNuvVnL
 0PlgSPZecDsLkQ4NqO9qwEg3f7tWZ6nNzKpScmErPhdtO8U3tIsSO2l7x/ztwW4qQnYxb7KCCGH
 +80Di6fGfAAe8p4knoo6j//B9LbRs2xYZcyb3QUGlaCFvsDA8IsTpd7U5nRDAArJGUDIOt+L6gz
 60v6JEaaeUzL/i8+Ju//sSTi+8S38g==
X-Proofpoint-ORIG-GUID: 1OFyaIcCCTz9tBuronckv-mOOgq3rKiQ
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691dcda0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Pjb7V9Cc-weC0biJHUsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
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

On Wed, 2025-11-19 at 08:33 +0100, Thomas Huth wrote:
> On 18/11/2025 22.45, Eric Farman wrote:
> > On Tue, 2025-11-18 at 18:40 +0100, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > >=20
> > > Consider the following nested setup: An L1 host uses some virtio devi=
ce
> > > (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes thi=
s
> > > device through to the L3 guest. Since the L3 guest sees a virtio devi=
ce,
> > > it might send virtio notifications to the QEMU in L2 for that device.
> > > But since the QEMU in L2 defined this device as vfio-ccw, the functio=
n
> > > handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> > > virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDev=
ice,
> > > but since "sch" belongs to a vfio-ccw device, that driver_data rather
> > > points to a CcwDevice instead. So as soon as QEMU tries to use some
> > > VirtioCcwDevice specific data from that device, we've lost.
> > >=20
> > > We must not take virtio notifications for such devices. Thus fix the
> > > issue by adding a check to the handle_virtio_ccw_notify() handler to
> > > refuse all devices that are not our own virtio devices. Like in the
> > > other branches that detect wrong settings, we return -EINVAL from the
> > > function, which will later be placed in GPR2 to inform the guest abou=
t
> > > the error.
> >=20
> > I still think this is a good idea, but of course "let's try it" got me =
into the weeds. I
> > reconstructed a configuration (dasd->virtio-blk-ccw->vfio-ccw->virtio-b=
lk-ccw) that crashes the
> > nested guest upon startup with today's master. Applying this patch gene=
rates that message to point
> > out where it's broken (yay!), but the nested guest hangs during boot. N=
eed to ponder this more
> > tomorrow.
>=20
> FWIW, we only tried to passthrough a virtio-input device to the L3 guest,=
 we=20
> did not try a virtio-blk device here ... so that might be the reason why =
I=20
> did not see any further hangs after applying my fix.

Ah, that could be. Well, as you and Halil discussed in v2, there's more tha=
t can be done on top but
since this solves the guest crashes:

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>

>=20
>   Thomas

