Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC2ECCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 19:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v979E-0002VE-5B; Wed, 15 Oct 2025 15:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1v9798-0002Rl-Vm
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:26:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1v9790-0001rh-Of
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:26:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDhPol021824;
 Wed, 15 Oct 2025 19:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SPX9oJ
 JYXJpQZcL5QgHi8cAyL7RCNOItsywXKQJuURM=; b=V2T782JuKrbFEYXDLfLHff
 atlguuAA5MZLRgBh99vtipa97LyJkJJ3psHKHG1Hm65K7ZKVHvW1x+OSjwPlWfbQ
 NWDNCUevNjmLYOlAmsNkbsWK2zvc0lvf7s1CyD8S06S187buOuW6xPMPtgv0I9kN
 nzuxOpZHS6gCX6RwZ6YOlpdKYH6USrUOW+Aa5/6MBCLMlhL1BWtkWICx1Oa1Xl2Z
 jNVPgNBwxN/4P4vvyhRacx2Ijh1EdMLveVbqattUaEmD8Mg5bQgLf0dL3gF+GkEf
 bdQauJBxmG5FNHTFij5xgR9mvg0ba/2osBIMDNozU6xD90rm0FvJ2uBvlRCQcrjA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew05jya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 19:26:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FIXIJv015466;
 Wed, 15 Oct 2025 19:26:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjhtwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 19:26:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59FJQUHY61931954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 19:26:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8265758056;
 Wed, 15 Oct 2025 19:26:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38A2F5803F;
 Wed, 15 Oct 2025 19:26:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Oct 2025 19:26:30 +0000 (GMT)
Message-ID: <53a3a23d-4400-4d8d-9a7c-6c6f4996c249@linux.ibm.com>
Date: Wed, 15 Oct 2025 15:26:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] qapi/tpm.json: reflow docs to width=70 and two
 spaces between sentences
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
 <20251011135754.294521-52-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251011135754.294521-52-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zLhM4qH9-j3mNUExbQ1QhbMGOhobt6kz
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68eff568 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=ulAjQa-lHqORs4cp4asA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX0i44CpNWQhnO
 8nR8H6Dc4AzPuWA8zydmJfVBqRX1nhDOcbasZD7Z2Txb9DxvX2AFExHo7KAYgn5rrnd5idm3Bih
 TAXB9xyZVAVEXkhhryZcnGYyERN5Jbcoi6pASXqHckN21gVEuDCnkpBsGZ4WEJsVeoYH0ysiK6c
 tNzA6l/MzipCw9Y6YkW6fVuQJhEMNXmte8pd4hB5F1DBvRE3g0wFk/SExdZQ3f5UCXlmYremSfF
 dxE3CgERENyWfN3Fi6x5IVfv84tWUIxeY21Y4XMKXiFodfRm0nmwWR7afHAle/HwA2pweWoVVDj
 1GOyH0UTFH52z49wJwLOMeJhnLYx1ZG1xtXL+Yq5KoRhdUao328qMXeObkPWPwk35jW9vZYc5ot
 7Sh3lFDMn+V1JKVbj7e/uHtwNgCAKw==
X-Proofpoint-GUID: zLhM4qH9-j3mNUExbQ1QhbMGOhobt6kz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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


On 10/11/25 9:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by; Stefan Berger <stefanb@linux.ibm.com>

> ---
>   qapi/tpm.json | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 3f2850a573..efa7addd78 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -175,7 +175,8 @@
>   #              "options":
>   #                { "type": "passthrough",
>   #                  "data":
> -#                    { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
> +#                    { "cancel-path":
> +#                        "/sys/class/misc/tpm0/device/cancel",
>   #                      "path": "/dev/tpm0"
>   #                    }
>   #                },


