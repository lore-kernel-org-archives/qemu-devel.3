Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80EDC3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRPL-0000Tv-UI; Wed, 26 Mar 2025 10:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txRP1-0000SZ-Q2; Wed, 26 Mar 2025 10:06:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1txROy-0004By-8M; Wed, 26 Mar 2025 10:06:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QCS6wl003122;
 Wed, 26 Mar 2025 14:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/yQpyg
 Os6AWD1jeTD78hm87DeFJoU770pWGgDdQlA5M=; b=rmF3kB6V+n4WnR09bpk3nK
 uK4kQnEe7cZaud/jlOzw+dUUrZp6TtjmvUNfFIMOO0zzrK9TmGJsjpa9TW6TcEzl
 ki36u4A/7AqgyukipoUrMUoV8pKwxEflipERBITmqpTuZrUE/QlbI+JvV0wTeV94
 VP80b2dawJkheRkDdt7gzVGlaYzQbsK9tsD3FwEdvx4bpULo+jqnY+a9XHH9UNie
 9snClzKccRPlGsCBsrR3zc6ogNeBtM4/dMyzcFSvNtKeio6XBgfqWHwJnbVlMD9X
 HMc3L9uJuQM+MiB4e0zBHTo8e2BmbgYQfCnohha5jnYj0C1AB8bhLFywFYI8AKIA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mhm3rffu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 14:06:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QE6QoZ023350;
 Wed, 26 Mar 2025 14:06:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mhm3rffq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 14:06:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBUtwp005791;
 Wed, 26 Mar 2025 14:06:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82garx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 14:06:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QE6Oup15991376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 14:06:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 968D55805C;
 Wed, 26 Mar 2025 14:06:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CA0E5805E;
 Wed, 26 Mar 2025 14:06:23 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.118.127]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 14:06:23 +0000 (GMT)
Message-ID: <e0b766517067e8b1ab6179d16fe9e2ac030f2099.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] hw/s390x/ccw: Have CCW machine implement a
 qmp_dump_skeys() callback
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
Date: Wed, 26 Mar 2025 10:06:22 -0400
In-Reply-To: <20250310151414.11550-4-philmd@linaro.org>
References: <20250310151414.11550-1-philmd@linaro.org>
 <20250310151414.11550-4-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1kKQ7R8VdfdHG6bP3F_5M5FZ-wY0OJIX
X-Proofpoint-GUID: 2ZZmE_DNXydI4RoEX2GscBFLuhfPVUZ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=877
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260085
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
> In preparation to make @dump-skeys command generic,
> extract s390_qmp_dump_skeys() out of qmp_dump_skeys().
> Register it as CCW qmp_dump_skeys() callback.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/s390x/storage-keys.h | 1 +
>  hw/s390x/s390-skeys.c           | 7 ++++++-
>  hw/s390x/s390-virtio-ccw.c      | 3 +++
>  3 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

