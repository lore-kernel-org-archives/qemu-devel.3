Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2835C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoCP-0001dI-PV; Thu, 14 Mar 2024 12:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rkoCN-0001cL-Tw; Thu, 14 Mar 2024 12:44:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rkoCM-00013h-8S; Thu, 14 Mar 2024 12:44:55 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EGRAcX022213; Thu, 14 Mar 2024 16:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hEcSkYqUy+PMeLwJ5V7PNly5EGrw+rdDCNFLvBDY/dg=;
 b=Yy6uJYxa0cdqXFGcEJUkuVLxtmLEZrRZ+IMS+QY9FnB1IvLRTxd7351vCI0g6e7ebA/I
 g38PzLUIKzUy/H9CGqM/5BJburOHWTorTqEc6ph4kFD0LXlb6aWaPtVAK/AgaCPx353W
 3rUBn8okO3ztXqDuYsI9PJ8FO9Dz5Irxc0fNC+WusU028EdGiexJpW0psYAZtL4GILMw
 9F0lH9zX01NREd2s2wfS6WEywRvDK+Fn/WPQ20uIR6qT0gi00QEzyBLCPy+zYpYxsWds
 bd0l1mmY4PNGIuepK5krOUXvXXxUGN9UoHX30yzuU+bcMt3FksagHLVJiLpT9SUF78Ow WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv4s2g8bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 16:44:50 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42EGdAQE019626;
 Thu, 14 Mar 2024 16:44:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv4s2g8bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 16:44:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EFxfAC014855; Thu, 14 Mar 2024 16:44:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33p66ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 16:44:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42EGijxs34079100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 16:44:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 126FE2004E;
 Thu, 14 Mar 2024 16:44:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC2752005A;
 Thu, 14 Mar 2024 16:44:44 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.31.78]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2024 16:44:44 +0000 (GMT)
Message-ID: <93131e9b6b6292c42657ba338aa134f15a88081f.camel@linux.ibm.com>
Subject: Re: question on s390x topology: KVM only, or also TCG?
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Date: Thu, 14 Mar 2024 17:44:44 +0100
In-Reply-To: <f0d5ec8d-02fe-4660-afcf-ad7b0af1dc13@redhat.com>
References: <c2aa273a-6f49-2a02-fd4d-a3ddd37db388@suse.de>
 <f0d5ec8d-02fe-4660-afcf-ad7b0af1dc13@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P42dUWxtlPI2Iqj-yZfyXJrbI0Onyqzi
X-Proofpoint-ORIG-GUID: EiajyMb8QiDNbVQZZ_il_MU33kd7T4_G
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1011 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 2024-03-14 at 16:54 +0100, Thomas Huth wrote:
> On 14/03/2024 16.49, Claudio Fontana wrote:
> > Hello Pierre, Ilya,
> >=20
> > I have a question on the s390x "topology" feature and examples.
> >=20
> > Mainly, is this feature supposed to be KVM accelerator-only, or also av=
ailable when using the TCG accelerator?
>=20
>   Hi Claudio!
>=20
> Pierre left IBM, please CC: Nina with regards to s390x topology instead.
>=20
> But with regards to your question, I think I can answer that, too: The=20
> topology feature is currently working with KVM only, yes. It hasn't been=
=20
> implemented for TCG yet.
>=20
> > (docs/devel/s390-cpu-topology.rst vs https://www.qemu.org/docs/master/s=
ystem/s390x/cpu-topology.html)
> >=20
> > I see stsi-topology.c in target/s390x/kvm/ , so that part is clearly KV=
M-specific,
> >=20
> > but in hw/s390x/cpu-topology.c I read:
> >=20
> > "
> >   * - The first part in this file is taking care of all common functions
> >   *   used by KVM and TCG to create and modify the topology.

What Thomas said. Read this as the code in file being independent with resp=
ect to the accelerator,
it's just that TCG support is missing.
=20
[...]
> >=20
> > So I would assume this is KVM-only, but then in the "Examples" section =
below I see the example:
> >=20
> > "
> > $ qemu-system-s390x -m 2G \
> >    -cpu gen16b,ctop=3Don \

TCG doesn't support this cpu ^ and so will refuse to run.

> >    -smp cpus=3D5,sockets=3D8,cores=3D4,maxcpus=3D32 \

When running with TCG, drawers & books are supported by -smp also, but well=
, you cannot do anything
with that.

[...]
>=20


