Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515DCC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKwO-0004lJ-58; Fri, 24 Jan 2025 09:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tbKwH-0004k8-1f; Fri, 24 Jan 2025 09:45:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tbKwE-0005qK-QN; Fri, 24 Jan 2025 09:45:40 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O9S4aF019260;
 Fri, 24 Jan 2025 14:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zkbow9
 9NUPCYchBjx/qBICoz6TclBNW+VIB/w3HPkQU=; b=SxXo1iiQfW3T/XNOUNLS8u
 8iIjOC4ZC2YtRpEoHjZUIKz/iJunPjCZ1ATJ1A2FFxsCzqBhlz0Vn5jbLgmemHaR
 Ogray+rOlu+bgL0ZxOUltZrFy07AR88AD7E1eD4m1JBkG5BrKfDIP3MK94fZt6wi
 gvnHd9xzLhOw8IWn5rx3aTRDfnzgoJcCj33PqQA/YV/8p8MR6Cs6iyF+xVPsMxrk
 eQmP+aH05Zphj0/vQMAG3+p13vPTp7qsXH6aOxBZrO9wU+1qCr7uLxpkMTJPhGnS
 cTgI4M5C6ZZ2fAheZMzPtfYsZIykg9uK65IDAKvs/TCVgI8UmPgV/y9a2G+t45lg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x94anq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 14:45:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OBdXmq019266;
 Fri, 24 Jan 2025 14:45:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsv11m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 14:45:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50OEjXDH21299958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 14:45:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 134FC58045;
 Fri, 24 Jan 2025 14:45:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B4D758056;
 Fri, 24 Jan 2025 14:45:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.67.174.5]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2025 14:45:30 +0000 (GMT)
Message-ID: <3aa2a2bc0312f577d7773b9eeb07d71cb557b4ed.camel@linux.ibm.com>
Subject: Re: [PATCH v1 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Rorie Reyes
 <rreyes@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
Date: Fri, 24 Jan 2025 09:45:30 -0500
In-Reply-To: <f8ce74c9-e4f9-40fa-8d58-c96f68aaed84@redhat.com>
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-2-rreyes@linux.ibm.com>
 <f0213486-c0f5-4415-869a-99a851c8a4cb@redhat.com>
 <dd1b07c4-1b72-4051-acbb-d679d0a0f534@linux.ibm.com>
 <52b7868e00271d49baddd64432332859c8314d1d.camel@linux.ibm.com>
 <f8ce74c9-e4f9-40fa-8d58-c96f68aaed84@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2_xN4cDeWK1-qjhckTcctd5VnufFfBcx
X-Proofpoint-ORIG-GUID: 2_xN4cDeWK1-qjhckTcctd5VnufFfBcx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 2025-01-24 at 09:49 +0100, C=C3=A9dric Le Goater wrote:
> On 1/14/25 20:55, Eric Farman wrote:
> > On Tue, 2025-01-14 at 13:51 -0500, Rorie Reyes wrote:
> > > On 1/8/25 2:29 AM, C=C3=A9dric Le Goater wrote:
> > > > Hello Rorie,
> > > >=20
> > > > On 1/7/25 19:43, Rorie Reyes wrote:
> > > > > This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to
> > > > > specify
> > > > > an IRQ index for signaling that a change has been made to the gue=
st's AP
> > > > > configuration. This is a placeholder for QEMU patches that use th=
is
> > > > > value
> > > > > since it is a linux-headers update which includes changes that ar=
en't
> > > > > merged into the kernel.
> > > >=20
> > > > Is there an upstream proposal for this change that we could look at=
 ?
> > > > It is nice to mention related series in the cover letter.
> > > >=20
> > > > Thanks,
> > > >=20
> > > > C.
> > > >=20
> > > >=20
> > > Hey Cedric,
> > >=20
> > > There is no upstream proposal for this. It is an s390 internal line i=
tem.
> >=20
> > Rorie,
> >=20
> > I think Cedric was looking for the matching kernel code you proposed, w=
hich this QEMU series depends
> > on:
> >=20
> > https://lore.kernel.org/r/20250107183645.90082-1-rreyes@linux.ibm.com/
>=20
> There is a v2 in the works, right? is that 6.14 material ?

Yes, but will probably miss the current merge window. :(

Thanks,
Eric

