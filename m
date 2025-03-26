Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F22C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txR2q-0001OJ-T6; Wed, 26 Mar 2025 09:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txR2p-0001O0-7R; Wed, 26 Mar 2025 09:43:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txR2n-0001FJ-AZ; Wed, 26 Mar 2025 09:43:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QCKktr027081;
 Wed, 26 Mar 2025 13:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PyDjeI
 y6J3eXb3aSQDGucQa7hgox2LZTtEMSYgjEIV4=; b=ohG0tWa3K9ZFDxtVHueJfg
 XbeKveFcimx8LwUN3EonJEsgiRA/sNH3VM03GHUV1Q2H7eBRs12WdN0W9d+9s4Jq
 cngneDF6MdN17fS8YCv+GLW7nCEf4f0buYhMMCl1YUzWQQVCyR/e5HVA0fKG22TA
 XdewIsfiiGVJ1ABnkUMiBlV/ivMu909xmVepcZkdzdKhLW8pto7a1LyAKanPjRoF
 YXyRGgoj890E9EqRk+fkVUCmijT3qOLTHRfvss3MWGtRX0xKc33Yhbp/pWgkiwTd
 zQrTE534Ii0+Zu2+zrFnHWpDm2UIery/nb9iSrygwVIbWDl71wjwD6I6LxHKuUUA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqeb2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:43:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QDdcw1012817;
 Wed, 26 Mar 2025 13:43:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqeb2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:43:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QAC80N020101;
 Wed, 26 Mar 2025 13:43:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp0hm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:43:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QDhUHT64291162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 13:43:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E15C75803F;
 Wed, 26 Mar 2025 13:43:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7433858063;
 Wed, 26 Mar 2025 13:43:28 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.118.127]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 13:43:28 +0000 (GMT)
Message-ID: <ebdcb882ad1e12bcc347fe2e031fddf10980abce.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] hw/s390x/skeys: Declare QOM types using
 DEFINE_TYPES() macro
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Anton Johansson <anjo@rev.ng>, "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao
 Liu	 <zhao1.liu@intel.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich	 <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang	
 <wangyanan55@huawei.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?ISO-8859-1?Q?Benn=E9e?=	 <alex.bennee@linaro.org>, Eric Blake
 <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, Halil
 Pasic <pasic@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
Date: Wed, 26 Mar 2025 09:43:28 -0400
In-Reply-To: <20250310151414.11550-2-philmd@linaro.org>
References: <20250310151414.11550-1-philmd@linaro.org>
 <20250310151414.11550-2-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uVFBUfWmuBtW_zq33A8wFcAj7hB8JpIq
X-Proofpoint-ORIG-GUID: 4NqS0uxG8BYcyMO2o5IFKH-RnmbXWRAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=856 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260082
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

On Mon, 2025-03-10 at 16:14 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In

s/the the/the/

> particular because type array declared with such macro
> are easier to review.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/s390x/s390-skeys.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

