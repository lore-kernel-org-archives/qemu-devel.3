Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC6FC54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqPW-0006Ci-F9; Thu, 14 Mar 2024 15:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rkqPS-0006CC-Ek; Thu, 14 Mar 2024 15:06:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1rkqPO-0002CK-5q; Thu, 14 Mar 2024 15:06:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EIYW3D029436; Thu, 14 Mar 2024 19:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ER5Dd0iTU3dhpwOqQJ/8pG4gI0Xs/7WsT2vSEThz0hY=;
 b=epWZoGl06fNIvEpVFK3vdBpJY0aXViu2oKSDEgO3C9TQqbhe9BVxmbkaIE6nmuOycDym
 P7dDFLXk8K1GjskNMqatN9zAfhPqLtT+ilNF2AiJ3XgQSPuO9Y8oOuLveJN/7THmmcmP
 6Yu0ra4TIyqSZfXA97B/3J1m1yWFN0oUZ2Iawshm90U7BXQvjLrhcCc145zmSbCncHi3
 giy1AWfLEp5Zxx36uefGW6M6ySxX8X/PRthbHQ4H7TdT0rXO4F+SeC65fs2dhDIrCoeW
 5luly8P4Dk8VHS3DBKaVwbE6bxiCPXedD9cPJLVsLcDZ1ZZw4zSKlkXTk8tLJ4h0+KJ+ TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv68010vc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 19:06:26 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42EIv9Lp019968;
 Thu, 14 Mar 2024 19:06:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wv68010v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 19:06:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42EHPOMN018552; Thu, 14 Mar 2024 19:06:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t2ef5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 19:06:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42EJ6LdL35127724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 19:06:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B59C22004F;
 Thu, 14 Mar 2024 19:06:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61AB92004D;
 Thu, 14 Mar 2024 19:06:21 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.31.78]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2024 19:06:21 +0000 (GMT)
Message-ID: <e892a83206380c9342f57e92562d3db4e4a125e8.camel@linux.ibm.com>
Subject: Re: [PATCH] docs/s390: clarify even more that cpu-topology is KVM-only
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 14 Mar 2024 20:06:21 +0100
In-Reply-To: <20240314172218.16478-1-cfontana@suse.de>
References: <20240314172218.16478-1-cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zvVqsXEzwkSh6VPOkHLSE0ukOgvCHMPG
X-Proofpoint-GUID: fJUm2WgpcG3VspAG51xKaWaRvDz99Tl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140147
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

On Thu, 2024-03-14 at 18:22 +0100, Claudio Fontana wrote:
> At least for now cpu-topology is implemented only for KVM.
>=20
> We already say this, but this tries to be more explicit,
> and also show it in the examples.
>=20
> This adds a new reference in the introduction that we can point to,
> whenever we need to reference accelerators and how to select them.
>=20
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Tested-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
(meaning I ran make html)

> ---
>  docs/system/introduction.rst       |  2 ++
>  docs/system/s390x/cpu-topology.rst | 14 ++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
> index 51ac132d6c..746707eb00 100644
> --- a/docs/system/introduction.rst
> +++ b/docs/system/introduction.rst
> @@ -1,6 +1,8 @@
>  Introduction
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +.. _Accelerators:
> +
>  Virtualisation Accelerators
>  ---------------------------
> =20
> diff --git a/docs/system/s390x/cpu-topology.rst b/docs/system/s390x/cpu-t=
opology.rst
> index 5133fdc362..ca344e273c 100644
> --- a/docs/system/s390x/cpu-topology.rst
> +++ b/docs/system/s390x/cpu-topology.rst
> @@ -25,17 +25,19 @@ monitor polarization changes, see ``docs/devel/s390-c=
pu-topology.rst``.
>  Prerequisites
>  -------------
> =20
> -To use the CPU topology, you need to run with KVM on a s390x host that
> -uses the Linux kernel v6.0 or newer (which provide the so-called
> +To use the CPU topology, you currently need to choose the KVM accelerato=
r.
> +See :ref:`Accelerators` for more details about accelerators and how to s=
elect them.
> +
> +The s390x host needs to use a Linux kernel v6.0 or newer (which provides=
 the so-called
>  ``KVM_CAP_S390_CPU_TOPOLOGY`` capability that allows QEMU to signal the
>  CPU topology facility via the so-called STFLE bit 11 to the VM).
> =20
>  Enabling CPU topology
>  ---------------------
> =20
> -Currently, CPU topology is only enabled in the host model by default.
> +Currently, CPU topology is enabled by default only in the "host" cpu mod=
el.
> =20
> -Enabling CPU topology in a CPU model is done by setting the CPU flag
> +Enabling CPU topology in another CPU model is done by setting the CPU fl=
ag
>  ``ctop`` to ``on`` as in:
> =20
>  .. code-block:: bash
> @@ -132,7 +134,7 @@ In the following machine we define 8 sockets with 4 c=
ores each.
> =20
>  .. code-block:: bash
> =20
> -  $ qemu-system-s390x -m 2G \
> +  $ qemu-system-s390x -accel kvm -m 2G \
>      -cpu gen16b,ctop=3Don \
>      -smp cpus=3D5,sockets=3D8,cores=3D4,maxcpus=3D32 \
>      -device host-s390x-cpu,core-id=3D14 \
> @@ -227,7 +229,7 @@ with vertical high entitlement.
> =20
>  .. code-block:: bash
> =20
> -  $ qemu-system-s390x -m 2G \
> +  $ qemu-system-s390x -accel kvm -m 2G \
>      -cpu gen16b,ctop=3Don \
>      -smp cpus=3D1,sockets=3D8,cores=3D4,maxcpus=3D32 \
>      \


