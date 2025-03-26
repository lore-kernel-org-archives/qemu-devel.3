Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C52BC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQgt-0008Vs-Mi; Wed, 26 Mar 2025 09:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txQgr-0008VR-TG; Wed, 26 Mar 2025 09:21:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txQgp-00072H-JA; Wed, 26 Mar 2025 09:21:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q8ulbV026778;
 Wed, 26 Mar 2025 13:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VcYwVk
 cgT+FWgak1lo4CkKbO8+FtIslc8/IRn9qcWO0=; b=bCJ1WErKCq3zhW7gdQp1iB
 fX3mNeR+mr10N4JhpSyUzF1e7idBHCO2yG75gnfyG0qKtel3WkUyiQSEiQdlh7aJ
 Pe1c24CXPHeaY55l6BCR2sLz+uI5zwZfI7kv+TvdIcge/M5ENWEak1GGyOh1PF5k
 xzOYSRwJ/NX1flF59x9JEcUEEcIFjb/ZAsXdky4QRzQhYl/V6lWEuTF2wBM0D7fc
 mmwSN2JEUi4pWk47clk+JToWl879/kCVqhRiZ0SaUR9gSpqKf6LGugdhumwKFno5
 5tccGl5lgLETH+ozatWzFeJFTsb3XSafb12TFSGHTdtADOVXDP0Fny2MTES5dxSQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqe79n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:20:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QCvPA6006558;
 Wed, 26 Mar 2025 13:20:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqe79j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:20:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBdmah009694;
 Wed, 26 Mar 2025 13:20:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkr8uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:20:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QDKmu724838814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 13:20:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 334995805B;
 Wed, 26 Mar 2025 13:20:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 185B15804B;
 Wed, 26 Mar 2025 13:20:46 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.118.127]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 13:20:45 +0000 (GMT)
Message-ID: <817578197d91a73a1de564e2826d0ec88736d5ab.camel@linux.ibm.com>
Subject: Re: [PATCH v3 6/7] target/s390x: Register CPUClass:list_cpus
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Daniel Henrique
 Barboza <danielhb413@gmail.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger	 <borntraeger@linux.ibm.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost
 <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>, Richard
 Henderson	 <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, Nicholas
 Piggin	 <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Mark
 Cave-Ayland	 <mark.cave-ayland@ilande.co.uk>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Date: Wed, 26 Mar 2025 09:20:45 -0400
In-Reply-To: <20250324185837.46506-7-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-7-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mWoxuQ4VHY03-b16HmWewOZQ2SdZucD_
X-Proofpoint-ORIG-GUID: C3WWam4pgKEYuHFGW4GkAohQRYBDAfoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=863 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260079
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Mon, 2025-03-24 at 19:58 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Register s390_cpu_list() as CPUClass:list_cpus callback
> and remove the cpu_list definition.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/s390x/cpu.h | 3 ---
>  target/s390x/cpu.c | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)

Fine squashed with patch 5 or not...

Reviewed-by: Eric Farman <farman@linux.ibm.com>

