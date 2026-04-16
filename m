Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382F8F8A16F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDM4t-0004PA-I1; Thu, 16 Apr 2026 08:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDM4n-0004On-1P; Thu, 16 Apr 2026 08:44:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDM4l-00085W-E5; Thu, 16 Apr 2026 08:44:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9fmn01804477; Thu, 16 Apr 2026 12:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VcxYGq
 8ZIJJAvcqNJddCJpFtun7OVNLZZM6iKvs50lI=; b=pp6XvNCcL3ZwxJkMXGzTcP
 BZDQ5ys7/cLDmBSBxZ96070h6QxLdBJRq1NkRYSN6fDhvUP9amhf5hYUzCO80+Gw
 KujSEmACecoKuKht+pHSjil6jfJLMlMNiMz3i5epkm0vXI5OgC5Jm0K/Tfc1Zvin
 teZ4+wI98f7XyiYfoBT/qDSQiAzkw2VPwTvUkngz1Uc5oW02TcA6AnJy0YvbD9/t
 nPVfC4o8GxdNTtsSrTU4tv1L7kinzu2BlOFJCdJoSHy/6chJ6aDOgFXwAaZXlztS
 UoOl3uSlxKVhMWnaGZS3L80CF4lpCk7GeG2d0+cuf8HA9LTYGZPgCR1QOD2hlZrw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kch76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:44:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCSPij003305;
 Thu, 16 Apr 2026 12:43:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh94f36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:43:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GChwkM32899710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 12:43:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2053058045;
 Thu, 16 Apr 2026 12:43:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B1C558050;
 Thu, 16 Apr 2026 12:43:56 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.88.215]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 12:43:56 +0000 (GMT)
Message-ID: <5c02764fb4164a9ae6e0420b05fb69502275310a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 08/27] hw/s390x: Reduce 'monitor/monitor.h' inclusions
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Markus Armbruster	
 <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr.
 David Alan Gilbert"	 <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Cornelia Huck	 <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger	 <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand	 <david@kernel.org>, qemu-s390x@nongnu.org
Date: Thu, 16 Apr 2026 08:43:56 -0400
In-Reply-To: <20260414003001.97571-9-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-9-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UK0G8vnKUw49jmKEWdSbK71WHVvefiHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExNyBTYWx0ZWRfXw9T7aRodnC/S
 1NJnJjaeK7IucSlC8w1RNDOpjV64DL6CihAepd3teNAzJf7pY4JGjrzyu4eynCGR0QHZoahaOg9
 FZ6NXxtD/85hiZ2+XEX65w3OEUFAfQ79qxeWUftJf94KPpXsq0TEZgFHsrAPun6ajAxgsLBFYEn
 NqziELJHjlFTaH2bi6uew+NYMMAICwcIIx6UCrTCbF/JlxV6/sfamNeQTalg9Mb+S+0KhJWBAqq
 mz8EyXA4KLKdUzW5iQMseSfRS3o16r2L9tAnqnvwmLyFc/Jm+CEBT2rOF/TYMYsbblbMD+35les
 qWNBxbTLRQgtgB0j0XDWs7wPx4Rzz7YHqELU3h6QLxT1NqKRxCQtxUxdxNt8h/8M7b1sG1GTzG8
 WxheWg8b2kI9ijOiC5e2gIPY67356czCD4iLdSsTRVJ3lGTLD1Vj4zn0B3GWUzVCaKzjWCG3zxX
 mx9XfL2++HrpKJWYVNw==
X-Proofpoint-ORIG-GUID: UK0G8vnKUw49jmKEWdSbK71WHVvefiHB
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e0d990 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=oNFF6uGEv09ksA5f1voA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2026-04-14 at 02:29 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> We want to make the HMP commands available for all targets,
> move the declarations to "monitor/hmp.h" where all other
> are, and only include the monitor headers in the source files.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/s390x/storage-attributes.h | 4 ----
>  include/hw/s390x/storage-keys.h       | 3 ---
>  include/monitor/hmp.h                 | 5 +++++
>  hw/s390x/s390-skeys.c                 | 2 ++
>  hw/s390x/s390-stattrib.c              | 2 ++
>  5 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

