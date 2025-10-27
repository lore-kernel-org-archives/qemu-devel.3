Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8D6CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDO9M-0006Wf-4Z; Mon, 27 Oct 2025 10:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vDO9G-0006Vn-PO
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:24:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vDO96-0005Qw-HA
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:24:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBQr6D024605;
 Mon, 27 Oct 2025 14:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6mV/T0
 MC4zYdgc6mgouc7Cu6HhwepLM7957bliLIUm8=; b=fKMb0iSQS4n8c0Q+NfViH/
 wtFx18QNntYebaybQoNi1dvbObvy0rRQAz+KTfUh/JAjyZQHsMzJsj6q2PgGKdXT
 BjVZc2RYAUkBHv5PcV3XN8WKM3MIeklUf9t8whlWa4rs58HRcsr+iMTiOKYxt4oD
 Jh5hoQqecC/rPkMmA4AwbQjHFCtYtFRQJxFQ32s7OB3f7cy1suw4OcOls4PQCmcY
 0ObTvATjtMXA1yud1OY/mMrP12C+QqpaukwfeQTLLt4niE41ysE6K1ff4icljRLB
 h1t4sO3MHcBIYu+d/iyL9puyrHWclAS2jqrlp/UwTtv6sGZdc7b9FDrQK5OcsnMg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p71y3v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 14:24:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCfaHA006764;
 Mon, 27 Oct 2025 14:24:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk0wp03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 14:24:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59REOJ8v51839406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Oct 2025 14:24:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8165F58057;
 Mon, 27 Oct 2025 14:24:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1139E58059;
 Mon, 27 Oct 2025 14:24:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Oct 2025 14:24:18 +0000 (GMT)
Message-ID: <2637d814-fef0-44af-8359-5df02c3bc8c6@linux.ibm.com>
Date: Mon, 27 Oct 2025 10:24:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] migration: vmstate_save_state_v(): fix error path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251025202649.1122420-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w78nSFWz927WIWYoI_yO1fjR6UWqhCj-
X-Proofpoint-ORIG-GUID: w78nSFWz927WIWYoI_yO1fjR6UWqhCj-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXzMhjbLPpexbz
 0efcPhhQcs9m8jSALqm7HKODaUeY72Rc8c2Bx06229fibYN54boJ1cfe8rKkFdqcZlW0PzTOzHS
 rJZ6lNxgd52G1qrx5LEBPETPZDEAJky7yjke0zx05y+Y28kX3IyCbbxFjZUQ3luaMJVdNFtXJzb
 FRJ3oS5yTto2B9TX6NNabDK7O2YYXdr4k926flb68qQPBAHIZixYfiD4AdKm7dfjBpKn/o9VD5o
 H6aOC3vZADZDbD2yWNIcgQd8PxGeW6E4lCsqsJE2O6M/+t39ZlXzckOsZO/FVq/kA57L9xU/87n
 q0nU1hvYYIE0rIX1VRIJyBlfgYvehoXWwsUhA0NDQZwivFE0Bd8MaCxnpjtmt5oqKnN/5ohsIdO
 Eq+qT6jMXq351Gyhjn2/C0uNTSBxSA==
X-Authority-Analysis: v=2.4 cv=G/gR0tk5 c=1 sm=1 tr=0 ts=68ff8095 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=pL1Hf9dkiE2374NjMCAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024
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



On 10/25/25 4:26 PM, Vladimir Sementsov-Ogievskiy wrote:
> In case of pre_save_errp, on error, we continue processing fields,
> unlike case of pre_save, where we return immediately. Behavior
> for pre_save_errp case is wrong, we must return here, like for
> pre_save.
> 
> Fixes: 40de712a89
>   "migration: Add error-parameterized function variants in VMSD struct"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   migration/vmstate.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 81eadde553..fd066f910e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -443,6 +443,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>           if (ret < 0) {
>               error_prepend(errp, "pre-save for %s failed, ret: %d: ",
>                             vmsd->name, ret);
> +            return ret;
>           }
>       } else if (vmsd->pre_save) {
>           ret = vmsd->pre_save(opaque);


