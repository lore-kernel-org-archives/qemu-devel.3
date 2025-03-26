Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D927C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txR7A-0002Tg-Pe; Wed, 26 Mar 2025 09:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txR75-0002TP-DW; Wed, 26 Mar 2025 09:48:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txR73-0001gl-JU; Wed, 26 Mar 2025 09:48:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBtwtP026130;
 Wed, 26 Mar 2025 13:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UDkwNe
 c/tAHRSWwkr/tMoWJkSYNzDuK5KjULm+90H3w=; b=IZm+MuVFmxgImXN09H7goN
 /7ifrOQY3oLbURQxY/TMcONmEn0CYtD/6QD6gU3xORDp+31FoyzoQvKaOsmq4ykW
 qf3HwLsGJJY4NYw4e7NE7c7lz5trASGW+DCSOjgE9Yd8y77ZS3po6rpN9eAwE3tQ
 IglwFu5rqm81TGR0x+hAWX4ZYbu6oxB6q773s4lBKYyek/Jw1+dXOxtZXHmazOAS
 v9IsVAcOzoPUnn5gZBgaAmqQJuHYyYBaxgyoXguMHruhZqKHdbnI6+ltsElHTRnM
 WwCadZMYeqRVDtVfg0XE5zxz74lyi7mC/1Rdb//jKamkXJcMUWEhlCvQwNiISgjA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqebpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:47:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QDEfVh016248;
 Wed, 26 Mar 2025 13:47:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqebpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QADtje020082;
 Wed, 26 Mar 2025 13:47:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp0hyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 13:47:51 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QDlmW330999094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 13:47:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55B0A5805C;
 Wed, 26 Mar 2025 13:47:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFB8A58051;
 Wed, 26 Mar 2025 13:47:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.118.127]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 13:47:48 +0000 (GMT)
Message-ID: <0a88b9e599a4ea8e7437f8ab645987f24dbae605.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] hw/s390x/skeys: Introduce TYPE_DUMP_SKEYS_INTERFACE
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
Date: Wed, 26 Mar 2025 09:47:48 -0400
In-Reply-To: <20250310151414.11550-3-philmd@linaro.org>
References: <20250310151414.11550-1-philmd@linaro.org>
 <20250310151414.11550-3-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KWbdq15bS85XSBON01BW85hR0Bs-Bdy6
X-Proofpoint-ORIG-GUID: vh2S9y38_r3TR6IhIkRoTawbD8qQNfwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=779 spamscore=0 lowpriorityscore=0
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
> The storage keys are part of the machine memory.
>=20
> Introduce the TYPE_DUMP_SKEYS_INTERFACE type,
> allowing machine using storage keys to dump them
> when a DumpSKeysInterface::qmp_dump_skeys() callback
> is provided.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/s390x/storage-keys.h | 15 +++++++++++++++
>  hw/s390x/s390-skeys.c           |  5 +++++
>  2 files changed, 20 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

