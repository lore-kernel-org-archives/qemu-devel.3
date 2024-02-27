Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD227C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0Ka-00029V-Oa; Tue, 27 Feb 2024 11:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rf0KX-00027H-0w; Tue, 27 Feb 2024 11:29:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rf0KV-0007hr-2J; Tue, 27 Feb 2024 11:29:20 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RGSXdO026255; Tue, 27 Feb 2024 16:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WHEvdZKvJ4HugGes3sEMiTtt3PPYLAWy5SPYKUERGaQ=;
 b=kaMF0vO/+6yi/msB6/vizqFQI8vbYVpdZ6gsxcmc7uokh8gQo/JWYKWpx6g1+V8Xqb88
 BZHya1PVVe0+xasHvd/Au/Ej7doN3zOKaWju7VPS0NXJOz2hZqwNzmG+OzzmCLHKAMXv
 iCENKO+rnSyCY6eKZiwVw0jJoxiHsKMGN2SEIs5KBRLcJvNLe6fS53pse2FzVGeNNJYu
 v8dcfMqfUHkilU6Cm9cliwVfUiuAveZGybh7yhx/olbJd0ZkZ671oc1O+i+IZNVaH3HA
 2RWOAKVaaGKFASIKAp4LpnuxGAlNXHH6qrl5RdUZHZJB56yPEeQWjYs9Ez1Gwybsggws wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whjx2grby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 16:29:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RGSfXK027278;
 Tue, 27 Feb 2024 16:29:15 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whjx2grbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 16:29:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RF53i0008798; Tue, 27 Feb 2024 16:29:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftsth2js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Feb 2024 16:29:14 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41RGTB1118809400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 16:29:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A837F58067;
 Tue, 27 Feb 2024 16:29:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 565DF5805C;
 Tue, 27 Feb 2024 16:29:11 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Feb 2024 16:29:11 +0000 (GMT)
Message-ID: <af7922a11d56827c097cadd9ba9a40a0f4fb62aa.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] target/ppc: BHRB avoid using host pointer in translated
 code
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Date: Tue, 27 Feb 2024 10:29:11 -0600
In-Reply-To: <CZ9HHCWQR3MT.1U5CJ7CBIR1EH@wheely>
References: <20240215171512.800892-1-npiggin@gmail.com>
 <CAFEAcA_m=xZEh0gS8ttfPiuRGWJrow7A303GiLG44W4LQZ10xw@mail.gmail.com>
 <CZ9HHCWQR3MT.1U5CJ7CBIR1EH@wheely>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -x2vHgxOhaBHBafim48IfVTmJAowNWu0
X-Proofpoint-GUID: AOxm-HeMc8dZIamWxe0s8f0xLqpv7hbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270127
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Tue, 2024-02-20 at 10:35 +1000, Nicholas Piggin wrote:
> On Fri Feb 16, 2024 at 3:50 AM AEST, Peter Maydell wrote:
> > On Thu, 15 Feb 2024 at 17:16, Nicholas Piggin <npiggin@gmail.com>
> > wrote:
> > > Calculate the BHRB base from arithmetic on the tcg_env target
> > > ptr.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > > Hi Glenn,
> > > 
> > > I think I have to squash this into the BHRB series. 32-bit host
> > > compile shows up a size mismatch warning... I think it's not
> > > quite
> > > right to be using host pointer directly in target code. The
> > > change
> > > of offset and mask to 32-bit is needed due to to seemingly
> > > missing
> > > tl->ptr conversion helpers, but 32-bit is okay for those anyway.
> > 
> > There's nothing inherently wrong with it (depending on what the
> > pointer is pointing to!), but you need to use the right type.
> 
> Ah okay, thanks for the correction.
> 
> > target_ulong and the _tl suffix are for the type which
> > depends on the size of the target's 'long'. The TCG type which is
> > "size of a host pointer" is TCG_TYPE_PTR, and you want the _ptr
> > suffix functions and to pass it around with TCGv_ptr.
> 
> In that case, original approach may be better with small fixes
> for 32-bit host.
> 
> Thanks,
> Nick

Peter/Nick, thanks for looking into this.  I'll work on submitting
a v4 of the original BHRB series adding Peter's suggestions (and
probably a rebase) as soon as I have a chance.  Unfortunately, I have
some higher priority items to work on at the moment, so it could take
a week or two before I can get to it.

Thanks,
Glenn


