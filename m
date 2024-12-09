Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7BBE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 15:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKfhe-0004IO-5O; Mon, 09 Dec 2024 10:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tKfha-0004I3-M9; Mon, 09 Dec 2024 10:29:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tKfhY-00056q-Tv; Mon, 09 Dec 2024 10:29:38 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FGIBo008475;
 Mon, 9 Dec 2024 15:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=VVVnpB89IMbeTxeo0JaKXNnLOl0Xa4
 mmXMHxI96R0LU=; b=tG6Ef9s63ym0M9fh4HRTutfMPuAQ3Irmercre6d6qX8SlX
 HJc+TcwkPwTA/Mm4w841RjCxmWbkSt3+gm/fYTXHrGOO2ym3BP/D1/h9u1yATraE
 n9qyOR+wf5QZN8Sfjq4DznU1zpI/Yhh/eTdh/Zp6Y7/zSP4D3eteyMAODoOja5/K
 keXahLaE+FNEcuH1OS7gb0wWoFCM4JDNjHFFIY6sK3FDtwDWZPD3//2ZnHraWMs4
 5zIJHg4OC/OslMKcPG0tbmOB2B8HJCOBGkQ4j8ubmUCYX6ID9z6OmXGmkoKqoSw7
 i9KUlI7rCXeqf8VkDBdjJXOJBhdYARCpwHlsqcmQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38j3te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 15:29:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9F2pqH018608;
 Mon, 9 Dec 2024 15:29:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k75vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 15:29:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9FTTcD18416080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 15:29:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76C1C20043;
 Mon,  9 Dec 2024 15:29:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE3820040;
 Mon,  9 Dec 2024 15:29:29 +0000 (GMT)
Received: from vela (unknown [9.171.25.246])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  9 Dec 2024 15:29:29 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.98)
 (envelope-from <brueckner@linux.ibm.com>) id 1tKfhQ-000000006S4-0QgU;
 Mon, 09 Dec 2024 16:29:28 +0100
Date: Mon, 9 Dec 2024 16:29:27 +0100
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com, nsg@linux.ibm.com,
 mimu@linux.ibm.com, borntraeger@linux.ibm.com
Subject: Re: [RFC PATCH v2 02/15] s390x/cpumodel: add msa11 subfunctions
Message-ID: <Z1cM1y84HNdJnvon@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
 <20241206122751.189721-3-brueckner@linux.ibm.com>
 <b9425123-d388-4a60-975c-98e14743ae9d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9425123-d388-4a60-975c-98e14743ae9d@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LJ40Izxa8yrqEnCDDKtG2qKWagHFa-CD
X-Proofpoint-ORIG-GUID: LJ40Izxa8yrqEnCDDKtG2qKWagHFa-CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=656
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Dec 09, 2024 at 04:04:19PM +0100, Janosch Frank wrote:
> On 12/6/24 1:27 PM, Hendrik Brueckner wrote:
> > MSA11 introduces new HMAC subfunctions.
> > 
> > Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> > Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> > ---
> >   target/s390x/cpu_features.c         |  2 ++
> >   target/s390x/cpu_features_def.h.inc | 10 ++++++++++
> >   target/s390x/cpu_models.c           |  8 ++++++++
> >   target/s390x/gen-features.c         | 24 ++++++++++++++++++++++++
> >   4 files changed, 44 insertions(+)
> [...]
> >   /* Features exposed via the KMC instruction. */
> >   DEF_FEAT(KMC_DEA, "kmc-dea", KMC, 1, "KMC DEA")
> > @@ -275,6 +283,8 @@ DEF_FEAT(PCKMO_ECC_P384, "pckmo-ecc-p384", PCKMO, 33, "PCKMO Encrypt-ECC-P384-Ke
> >   DEF_FEAT(PCKMO_ECC_P521, "pckmo-ecc-p521", PCKMO, 34, "PCKMO Encrypt-ECC-P521-Key")
> >   DEF_FEAT(PCKMO_ECC_ED25519, "pckmo-ecc-ed25519", PCKMO, 40 , "PCKMO Encrypt-ECC-Ed25519-Key")
> >   DEF_FEAT(PCKMO_ECC_ED448, "pckmo-ecc-ed448", PCKMO, 41 , "PCKMO Encrypt-ECC-Ed448-Key")
> > +DEF_FEAT(PCKMO_HMAC_512, "pckmo-hmac-512", PCKMO, 118, "PCKMO Encrypt-HMAC-512-Key")
> > +DEF_FEAT(PCKMO_HMAC_1024, "pckmo-hmac-1024", PCKMO, 122, "PCKMO Encrypt-HMAC-1024-Key")
> 
> It seems like we never did MSAx prereq checks for PCKMO like we do for the
> other instructions. Don't we need to check for MSA3 for these features too?
> 
> I see no code that puts EXT_11 and EXT_11_PCKMO in a group where we could
> piggyback on the EXT_11 check for MSA3. What am I missing?

Similar to my other comment. EXT_11 does not have an STFLE bit and, hence,
no feature definition. That's why each introduced subfunc requires MSA3
(for which there is STFLE bit).

The check_consistencies functions works on feature definitions, not on the
feature group definitions.

Hope this helps.


