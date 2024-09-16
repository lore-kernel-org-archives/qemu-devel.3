Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A379C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 10:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq91T-0006s7-MC; Mon, 16 Sep 2024 06:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sq91O-0006Wl-J7; Mon, 16 Sep 2024 06:31:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sq91M-0006LQ-IL; Mon, 16 Sep 2024 06:31:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G70Ajm003643;
 Mon, 16 Sep 2024 10:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 5VDAgmHX5aUkJQBwDdlOZHEsUiGLEkmfJ+bg+4Rcla8=; b=jiGUS406efDmO8of
 UBzfnEIK1F76LqPOAd819eG+8LBNV691xE0MfJpv3ccdwHxBiPZr7yEAP1Lfuk8q
 XO9tEzf5ak/2LgvpRyua93zp6v82YGNaGMyqtQNc37AREFGb9kGzKbAFVP2/KtQ9
 AkdwQ4wNsq2/VOnFQ0lYRMsT5G5ys6ADXU6424Gg+DS7x+2KGFYeuAS1tgIhOouo
 cdO/FdRrGuYNK8l1eIt4uTsZZK0kS+zEXF6axunxgFShyTmVWTkqGjnWHpFjUgVx
 lfcfKqHj/BB7++EKvpvQ4h5B8cPNRF8u+Vfk7o3ywz0bLXFVxPCYX4YbB0R8VCm/
 2hb7rQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ud16vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 10:31:30 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48GAVUIq004687;
 Mon, 16 Sep 2024 10:31:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ud16v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 10:31:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48G99TqQ030656;
 Mon, 16 Sep 2024 10:31:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npamxjbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 10:31:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48GAVQtL19005948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2024 10:31:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D316F20040;
 Mon, 16 Sep 2024 10:31:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DE792004B;
 Mon, 16 Sep 2024 10:31:25 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Sep 2024 10:31:25 +0000 (GMT)
Message-ID: <db82c695dceee743331f2c8cd5177ecc46679110.camel@linux.ibm.com>
Subject: Re: [PATCH v2 12/18] tests/tcg: ensure s390x-softmmu output redirected
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, David
 Hildenbrand <david@redhat.com>, devel@lists.libvirt.org, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Date: Mon, 16 Sep 2024 12:31:25 +0200
In-Reply-To: <20240916085400.1046925-13-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
 <20240916085400.1046925-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T-QkSLHJADMOgQZEinMvYpuJo3Egm9FV
X-Proofpoint-ORIG-GUID: G6AbMQNjLI7o_2lYrnPFhOMeVTWjomry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Mon, 2024-09-16 at 09:53 +0100, Alex Benn=C3=A9e wrote:
> The multiarch system tests output serial data which should be
> redirected to the "output" chardev rather than echoed to the console.
>=20
> Comment the use of EXTFLAGS variable while we are at it.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

