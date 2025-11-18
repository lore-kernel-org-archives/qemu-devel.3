Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B8CCEDDB0
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNVW-0007na-3m; Tue, 18 Nov 2025 10:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vLNVJ-0007ir-0h; Tue, 18 Nov 2025 10:20:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vLNVA-0006BF-5o; Tue, 18 Nov 2025 10:20:21 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI4ijVW016207;
 Tue, 18 Nov 2025 15:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EMuUZg
 O4CdoaRvgWgiT1y/gzp8Nhc5iQwo2cyNCMSIc=; b=q7rvW7vVYxWFFom2tl2RCe
 5ivkMaNDMzdWsjyXHa2vS867yYoRT2HyOtkjo4FuIaKtH8yhpT4hLsgTMKsqodR9
 QcKqalkHP+3WlQB0wUWbBa1hkdkgXr+ca4/xB22/AknZB8eKFrgLyiWjhTx7MiXX
 /BHLuaQj1w3ZUQSidHB9PZa/SB937VF2cUD2EKE7cT6H2lAHndSsutpaQ8FJjCdO
 i9j3/ZN/SYmjffesV5MmqlgCEAtokXavNxnhqLBW6eaWTd4cbqo4/+39t5aFCHbX
 baKMTwHh52aTywphYWI5p8s1x/CEl1JNww5732r04rQvnkXzpBZejSdgXBxvR2xw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk9ufqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 15:20:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AICIntg006954;
 Tue, 18 Nov 2025 15:19:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62jbhnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 15:19:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AIFJwo426477164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Nov 2025 15:19:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E6D758062;
 Tue, 18 Nov 2025 15:19:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2820C58054;
 Tue, 18 Nov 2025 15:19:57 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.147.101]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Nov 2025 15:19:57 +0000 (GMT)
Message-ID: <8f90d4d7ea1c4ee8e088f5afb483587181278ebf.camel@linux.ibm.com>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
From: Eric Farman <farman@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater	 <clg@kaod.org>, Cornelia Huck
 <cohuck@redhat.com>
Date: Tue, 18 Nov 2025 10:19:56 -0500
In-Reply-To: <20251118130218.30d3da33.pasic@linux.ibm.com>
References: <20251118093945.35062-1-thuth@redhat.com>
 <20251118130218.30d3da33.pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y6wgdPIoF_o7SwLVQWu8WbWikFf6Zwrt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6RS2bWI3gyqj
 Ej/Y5qnWTs/PfFXh0BC4TIRBrBPmjKwx3VZlJySh6IJqQdJegYUtsFchq3cuw7dBZOtFnOapxq9
 1/Q5dm2lF11nDKsM2meCI2k33nfg8N+/tkXBoNmBDSonZoCeTcPEX/BVaX5aiAOXz58vVaiFON+
 fAWGMv0S25kwira+u7PfQY/Odmt7KSoQaGF/75uM3+nEWX/pV5iQqE4cvl3coA4imGo890ZXoS5
 J+FV6I1ToFlznbJPA1C5bgypgFVz617UPyrUYgviKnbgL+QmxSoKqRLjQHnEIKXcQLJpuf1Ztd5
 4OSMfavYznnVygl+uB/0IhFZ5WUfHV95hd11rQKQyvLH9jAMVJtSK/bMqLl6Ru813Rr+m15Eirt
 +/NIATZQPVoZ41pZVND5BP6NT4YY1w==
X-Proofpoint-ORIG-GUID: y6wgdPIoF_o7SwLVQWu8WbWikFf6Zwrt
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691c8ea0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=xpWrT8z_KIiLtBJzAikA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
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

On Tue, 2025-11-18 at 13:02 +0100, Halil Pasic wrote:
> On Tue, 18 Nov 2025 10:39:45 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > Consider the following nested setup: An L1 host uses some virtio device
> > (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
> > device through to the L3 guest. Since the L3 guest sees a virtio device=
,
> > it might send virtio notifications to the QEMU in L2 for that device.
>=20
> Hm, but conceptually the notification is sent to the virtio device,
> regardless of hypervisors, right? But because for virtio-ccw the
> notification is an DIAG 500, we have the usual cascade of intercept
> handling. And because we have never considered this scenario up till now
> the intercept handler in L2 QEMU gets called, because it is usually the
> responsibility of L2 QEMU to emulate instructions for an L3 guest.
>=20
> I think vfio-ccw pass through was supposed to be only about DASD.=20
>=20
> > But since the QEMU in L2 defined this device as vfio-ccw, the function
> > handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> > virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevic=
e,
> > but since "sch" belongs to a vfio-ccw device, that driver_data rather
> > points to a CcwDevice instead. So as soon as QEMU tries to use some
> > VirtioCcwDevice specific data from that device, we've lost.
> >=20
> > We must not take virtio notifications for such devices. Thus fix the
> > issue by adding a check to the handle_virtio_ccw_notify() handler to
> > refuse all devices that are not our own virtio devices.

I agree here. I like Cornelia's suggestion in the other thread of providing=
 the subchannel
identifiers in the message so there's a hint of -where- the (presumed) typo=
 came from.

>=20
> I'm on board with this patch! Virtio notifications are only supported
> for virtio devices and if a guest for what ever reason attempts
> to do a virtio notification on a non-virtio device, that should be
> handled accordingly. Which would be some sort of a program exception
> I guess. Maybe you could add what kind of exception do we end up
> with to the commit message. I would guess specification exception.
>=20
> But I would argue that the L3 guest didn't do anything wrong.
> Pass-through of virtio-ccw devices is simply not implemented yet
> properly. And even  if we were to swallow that notification silently,
> it would be effectively loss of initiative I guess.
>=20
> So I think it would really make sense to prevent passing through
> virtio-ccw devices with vfio-ccw. Eric what is your take?

It's true that the only -supported- use case is passthrough DASD, and we al=
low other device types to
be passed through. The only ones we fence off are what we know aren't going=
 to work, like FCPs. IIRC
we'd talked a few years ago about a plan for a more detailed allow-list of =
passthrough devices and
configurations, but that fell off the back of the todo list. Short of dusti=
ng all that off, I don't
know that blocking virtio-ccw from vfio is going to buy us anything that Th=
omas' patch doesn't
already provide.

