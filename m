Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E418DECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snejZ-000496-2p; Mon, 09 Sep 2024 09:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1snejY-000481-0I; Mon, 09 Sep 2024 09:47:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1snejV-0008Ty-OQ; Mon, 09 Sep 2024 09:47:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899roPY009441;
 Mon, 9 Sep 2024 13:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 UX5LxD75F5V6f+mThubcVR13u+fc7BXAvExsBS4dra0=; b=NtvKuTmk/l7oUa8g
 nzg4cyhde3szPIkeRQ8DmCido7Ns6iKtpb9swvcW3DoxKsfQY9Y9rKZkKCToFP5Y
 Xy6VCtH4v0ZRPEoe92ul130gkE2PJDggGz/DEhcz7HQDx32Cn0g4gRUqpWpqNZeb
 wK7ukIw9yD0rEprWBvCJTvILKlQhh/hMh9x/f4LaOI0I6bCO2paUPB6if/jsL1G4
 RqkNuU2e3UHinDeRKzcQ9O+/q4t00PF1KVMsUcXsip8g+7ySRyyysYaiLRIP73jj
 jwp1SmlXLSrBRrZsPLet2lFpzbsZi7vdkn4BMMaazMlZj/RrMWwRopgDf8FSxYT4
 c11gTw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geba24eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 13:47:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489Dl4HW031606;
 Mon, 9 Sep 2024 13:47:04 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geba24ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 13:47:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489Ce5gB013458;
 Mon, 9 Sep 2024 13:47:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3ckxcbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 13:47:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 489Dl01u42795374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 13:47:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5A7520043;
 Mon,  9 Sep 2024 13:46:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 917B020040;
 Mon,  9 Sep 2024 13:46:59 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 13:46:59 +0000 (GMT)
Message-ID: <a5f652ee4c6563cc10daf650fdaff34d738f2da1.camel@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] s390: Convert virtio-ccw, cpu to three-phase
 reset, and followup cleanup
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>
Date: Mon, 09 Sep 2024 15:47:01 +0200
In-Reply-To: <CAFEAcA_pHTRTDwH0dG3QAKx3x9xdJgG5xtrwo5diV6QgBqf+8Q@mail.gmail.com>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
 <CAFEAcA_pHTRTDwH0dG3QAKx3x9xdJgG5xtrwo5diV6QgBqf+8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D8SBDzhJmhCtQo-oAbzuFB_dToNGECdq
X-Proofpoint-GUID: O7FRnRloHwR952wnnsPk2SkCf637EqA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=876 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 2024-09-06 at 15:38 +0100, Peter Maydell wrote:
> On Fri, 30 Aug 2024 at 15:58, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >=20
> > The main aim of this patchseries is to remove the two remaining uses
> > of device_class_set_parent_reset() in the tree, which are virtio-ccw
> > and the s390 CPU class. Doing that lets us do some followup cleanup.
> > (The diffstat looks alarming but is almost all coccinelle automated
> > changes.)
> >=20
> > Changes v1->v2:
> >  * new patch 1 to convert hw/s390/ccw-device
> >    (fixes bug discovered via s390 CI testing in v1)
> >  * a couple of patches are already upstream
> >  * in the target/s390 cpu patch, fix sigp_cpu_reset() to use
> >    RESET_TYPE_S390_CPU_NORMAL
> >  * new patches 10, 11 which take advantage of the new function
> >    device_class_set_legacy_reset() to allow us to replace the
> >    generic Resettable transitional_function machinery with a
> >    simple wrapper that adapts from the API of the hold method
> >    to the one used by the legacy reset method
> >=20
> > Patches 1, 10, 11 need review. I believe that patch 1 should have
> > fixed the intermittent s390 issue we found with v1 of the patchset,
> > but if you could run these through the s390 CI again I'd
> > appreciate it.
>=20
> I'm going to apply this series to my target-arm.next queue.
>=20
> Let me know if you need more time to CI/test/whatever it on
> the s390 side before it goes upstream.

CI looks good.
>=20
> thanks
> -- PMM


