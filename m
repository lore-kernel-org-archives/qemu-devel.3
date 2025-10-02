Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AEFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4K05-0008To-OP; Thu, 02 Oct 2025 10:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4Jzv-0008LT-7t; Thu, 02 Oct 2025 10:09:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4Jzl-0007Lr-LE; Thu, 02 Oct 2025 10:09:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DcqA9018505;
 Thu, 2 Oct 2025 14:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IvLoj8
 f/uaT6vb3usKUYhawAOTd750whQ4Az1PbiH24=; b=rk6T7knnIq2lEBmbBAJw2c
 9ck6wOX6+dSAZ1mz/eTDesKeIKXTvI5A6X016FABrEMYVM5AzO82QHkOJIB1tVn4
 hJDhNp2mmsWPF7Dz4PpyWjaZ37aaxztfrVgKY3BgC8NN0UExGZLzoxc3Zw+Bxhrt
 0T5woftfwoqzR/8O44JKDVltvwY0KvgnWiPDvLp8jv5vgGL9A149BkPScFQCrXS6
 5fpNhluH7QuUN9KaEhV6d+IouTBBQYoMhcTpqsNpmf/w+B063B5qLUeqpos8EpRJ
 Iezb8bpcSR7MkaUmfyRVZ+eXjJQxMs3U4UNAH3ThezmBZM4EbGZ0jlP/6tu+8IHA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhvx26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 14:09:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5929m9CD007292;
 Thu, 2 Oct 2025 14:09:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk66sx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 14:09:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 592E97FB23855854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Oct 2025 14:09:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A14AC58053;
 Thu,  2 Oct 2025 14:09:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1371158043;
 Thu,  2 Oct 2025 14:09:06 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.134.141]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Oct 2025 14:09:05 +0000 (GMT)
Message-ID: <00c873bc92ebbc13413c8f236ed3eaa0bd7c98bb.camel@linux.ibm.com>
Subject: Re: [PATCH v4 07/17] hw/s390x/sclp: Replace [cpu_physical_memory ->
 address_space]_r/w()
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thomas Huth <thuth@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Halil Pasic	
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, David Hildenbrand	 <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>
Date: Thu, 02 Oct 2025 10:09:05 -0400
In-Reply-To: <20251002084203.63899-8-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
 <20251002084203.63899-8-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68de8785 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=nq8n1J83xunWhl9p0hoA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX39RhvSZB/gEw
 fSRHuBwOdxuPFd7OlaeTzHF/Nb+cKAR9udZB/zGx2iD4cQnpJQcXJQBQWGuia/xZvDJ9pxgerqG
 eFJ03+dNfvdgD9SrzbhneaThs1kybjmf2X8pvLccB2gqCFj2cpNn50xzs3YcTVZ53mzFMycFi13
 w3f5l8sQ4vGjMxiA3tDur41+reA/5qbD/wQL86ZGeofjlyUfva9IUPjwNJajtg+S3A4Nesa1VrV
 iTeVKLL6/U42HyhWqMDLEfwyMbB2H0MG00wwNQ3T8oiwnQjHyax8s5d6P1hHCA5X1RksMgmbbBF
 F6EpivV6k015dMg+arrtgZwFW9b100QiL5fZh1C2vswTWV5ABQfH1uBbkK4ySENU+94O9KAHACJ
 m9XEmZTAubBVaAVQJAhB1GgJrWI+mA==
X-Proofpoint-GUID: uZbYcs5fD30pLPjF7MCuOSROuWpRsdRB
X-Proofpoint-ORIG-GUID: uZbYcs5fD30pLPjF7MCuOSROuWpRsdRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 2025-10-02 at 10:41 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> cpu_physical_memory_read() and cpu_physical_memory_write() are
> legacy (see commit b7ecba0f6f6), replace by address_space_read()
> and address_space_write().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/s390x/sclp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

