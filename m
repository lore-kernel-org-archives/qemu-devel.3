Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819F8C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 12:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSz8z-0006al-PR; Thu, 25 Jan 2024 07:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rSz8u-0006a5-F2; Thu, 25 Jan 2024 07:47:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rSz8q-000845-Ul; Thu, 25 Jan 2024 07:47:38 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PC8LkQ026107; Thu, 25 Jan 2024 12:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zfYw3wkFLsiw7QLz+Hx76oCXPlE6xrY6JtckLbqNMvQ=;
 b=mMF7IjDlWmIobjTDTuHWPE4Gcey5SO2cuKOzdCcifiWcGK90AdU59RqWu0WBH08cJfsh
 9Zzg0X/eHZEWgjCCdj5PKVIWbYts+xE3+VfauoVUaxcpFDUh0ZapI0eamBCO0aNWlO4c
 BTmBH3QOflcSlcDAJk8RVZcGIBmox7WTroTgvmJif2FHMnzyzLEZZhbcA5a/W7vag/JC
 i3HuK0UMQi++app1msJcRwrnmI3mzay1CuIBTZlrpaA35dCtZ9Sjclk8MCnd55XeKEeL
 60pSDarNhQQVhkH4h3tVp/4sBbi3E51IGuIrRHWgi6q4OmhItUMeE5ViRywqRrXOUMho RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vun5vmj8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 12:47:33 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PCR6Af009338;
 Thu, 25 Jan 2024 12:47:33 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vun5vmj8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 12:47:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PA6eka025298; Thu, 25 Jan 2024 12:47:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkm1ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 12:47:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PClUvR39125390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 12:47:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6863120043;
 Thu, 25 Jan 2024 12:47:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EF6F20040;
 Thu, 25 Jan 2024 12:47:30 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 12:47:30 +0000 (GMT)
Message-ID: <79bb25883b250ed5be15ae2b6754e46742975f1a.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] target/s390x: Emulate CVDG
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 25 Jan 2024 13:47:30 +0100
In-Reply-To: <d590988e-faa4-42f2-ba44-45fc08f1851d@redhat.com>
References: <20240115202308.1930675-1-iii@linux.ibm.com>
 <d590988e-faa4-42f2-ba44-45fc08f1851d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hApqkDBEU54FnThCGXVfr95OjIWrjo_w
X-Proofpoint-ORIG-GUID: h6M-AXIcSlfeJQ0EppIOyPWmGP4Tn9fm
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_07,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=450 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

On Thu, 2024-01-18 at 18:28 +0100, Thomas Huth wrote:
> On 15/01/2024 21.21, Ilya Leoshkevich wrote:
> > Hi,
> >=20
> > Ido reported that we are missing the CVDG emulation (which is very
> > similar to the existing CVD emulation). This series adds it along
> > with
> > a test.
>=20
> Just FYI, your patch made me curious which other instructions we
> still might=20
> be missing from chapter 7 in the Principles of Operation... with some
> shell=20
> scripting and manual fiddling, I ended up with this list:
>=20
> 0C	BRANCH AND SAVE AND SET MODE		BASSM
> 0B	BRANCH AND SET MODE			BSM
> B21A	COMPARE AND FORM CODEWORD		CFC
> B257	COMPARE UNTIL SUBSTRING EQUAL		CUSE
> B263	COMPRESSION CALL			CMPSC
> 4F	CONVERT TO BINARY (32)			CVB
> E306	CONVERT TO BINARY (32)			CVBY
> E30E	CONVERT TO BINARY (64)			CVBG
> B24D	COPY ACCESS				CPYA
> EF	LOAD MULTIPLE DISJOINT			LMD
> EE	PERFORM LOCKED OPERATION		PLO
> B9BF	TRANSLATE AND TEST EXTENDED		TRTE
> B9BD	TRANSLATE AND TEST REVERSE EXTENDED	TRTRE
> 0102	UPDATE TREE				UPT
>=20
> There are some additional ones from the "Guarded-Storage Facility"
> and the=20
> "Transactional-Execution Facility", but these are optional AFAIK.
>=20
> Some of these (like UPT) really look like sins from the CISC past, I
> guess=20
> we'll never need them for running Linux guests :-)
>=20
> =C2=A0 Thomas
>=20

Thanks, I'll append this to my TODO list. At least for CVB* there seems
to exist an unfinished patch on the list [1].

[1]
https://lore.kernel.org/qemu-devel/20180821025104.19604-8-pavel.zbitskiy@gm=
ail.com/

