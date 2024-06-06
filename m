Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CDCC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBof-0003CL-R2; Thu, 06 Jun 2024 08:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sFBob-0003Bv-Ju; Thu, 06 Jun 2024 08:01:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sFBoT-0003TV-NE; Thu, 06 Jun 2024 08:01:57 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 456Bc0d4014091; Thu, 6 Jun 2024 12:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=5M9f1B+4t3FkFGYcFjuimcXCdHJPfmiABt8QZ+JP3eI=;
 b=o/muBcDcJFOihSD7my+wfJr+5Jr0iCOyXRvfbnXhqGbrG5zIa4adZBmej4l/1p/XpHZr
 H/JvbDfGDEHnAoB/beoOwRhVdGOA5WrFeqFAkHJjPd8roqfi6pbA0MY8VAEv1Dr5AdlW
 omMGYl2uqN7rXu/YaaCpsFKfR1SHhOm+QbVCjPdtwTxG4m35ug9QWnVcfzkBVOM52Wi/
 c7/INbXgQL+u5X9CBarX4c5bM1oJ3F7z7Awruy0HwaZuXSjZl2s8/sEiNVuFVsTVsm6I
 f8Noy4018oUQhbbuM/iGGRffSSg8Kbf04ve5g67iDM6RzpWYUluMxDUuCxBRhy/54KPc 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcdgr1sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:01:39 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456C1cMm017079;
 Thu, 6 Jun 2024 12:01:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykcdgr1s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:01:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4568wUIe031142; Thu, 6 Jun 2024 12:01:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygeyptc8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:01:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 456C1XYC28836346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2024 12:01:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA78D20073;
 Thu,  6 Jun 2024 12:01:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8A7520040;
 Thu,  6 Jun 2024 12:01:33 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2024 12:01:33 +0000 (GMT)
Message-ID: <f0057918bc94f680a0b28a0bb573f25a6e8ae259.camel@linux.ibm.com>
Subject: Re: [PATCH] target/s390x: Fix tracing header path in TCG mem_helper.c
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi
 <stefanha@redhat.com>
Date: Thu, 06 Jun 2024 14:01:33 +0200
In-Reply-To: <20240606103026.78448-1-philmd@linaro.org>
References: <20240606103026.78448-1-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lOBWoNpUAnhyVVruq_4xL1G2H1MFoPUa
X-Proofpoint-ORIG-GUID: a3sKbCVGIOTG1UarECNs721Fzopr-ytw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 mlxlogscore=730 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2406060088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Thu, 2024-06-06 at 12:30 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit c9274b6bf0 ("target/s390x: start moving TCG-only code
> to tcg/") moved mem_helper.c, but the trace-events file is
> still in the parent directory, so is the generated trace.h.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Ideally we should only use trace events from current directory.
> ---
> =C2=A0target/s390x/tcg/mem_helper.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

