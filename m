Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0290ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITFc-0004CV-SR; Mon, 10 Nov 2025 09:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vITFQ-0003p2-3q
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:52:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vITFO-00008A-2m
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:51:59 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD5FAD029737;
 Mon, 10 Nov 2025 14:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9oRD42
 8bu6yi4OqNBjqObEQvF9xkL8ympHHTLttR5ME=; b=nSreJzjSqRTMvgZfvTPVPX
 oxLWPpF/qR77BxqpGE7fERMCxAhT+HjxNhkiRGeKK88pEgOgUpAUCz2sWJXLpcLr
 1q5/N6UlaC//1H37B9fLtX1n35fOTGrfi/tw0+w4Jr6Qy64Q09Dpdibb3p3Te2fw
 1CRDGUC9rDv0gjif93ZPhDp+P9mpojKqlDD2pxSboIOGliwbAVkfs/93yYSJS+j2
 3DjAx+YCm++qC8sQQ8/r2M5f0IrkbQlPArtnVvFoA4NBsPKBO0hh4yPsW3Z/7M8x
 SPD/GMDJWcc3eXWq5nZ1vTgs1yb+5DFCStW0gFoxurQdA45DLtuTX0kebsnVqb0g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk80pnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 14:51:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD7uCr007298;
 Mon, 10 Nov 2025 14:51:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdj5vr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 14:51:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AAEprRE20710014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Nov 2025 14:51:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40E8A5805F;
 Mon, 10 Nov 2025 14:51:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 989B258054;
 Mon, 10 Nov 2025 14:51:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Nov 2025 14:51:52 +0000 (GMT)
Message-ID: <332e3480-d86f-4782-8694-65b1e459eb58@linux.ibm.com>
Date: Mon, 10 Nov 2025 09:51:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tpm_emulator: drop direct use of errno variable
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
 <20251106194126.569037-3-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251106194126.569037-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX0B4WRM55JsUk
 0TJ6zgaiYm/Q7SFa8Ii09LOSsdS1xGoqbKKnO93Xr4avcX55xs71cOm3qfZq3lfuvZiZGLpOHcJ
 og1IHXZmgZu+4rJr2T2vR6OJDYOKdVfVLYF23i/ijPK+fSFXcn/Hv8KVlGaynstosrPhJuIsHwF
 /DIU+CiCk6CLU0Bmyu4BF2apeVply9hc8gBdT8J1X0L3ydohqS54AwBrvL0jPBLxLNqNFs4JU3E
 FgJL9p5Rv7eO+cfsrhEF8jqZUXwbpYh+QJQ6uBEIkzqZ1rXSkhpQw8sbof9aqAQTkLwQgzr0DLQ
 iBcrfXhLWIY/DwB5EeNfpXBUQcjTlulmaFgRaLbqcLUlvr3KSXRt52mXtTs+gJ6gGTMihI2fzqe
 YQNq7r02wZVBrSz254ur6p8PLloGMw==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6911fc0a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=KdQi6C3LDGTg7i8PK7gA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-ORIG-GUID: 54gtTjYfshzp4iyTgYS-dB6FxxuELq41
X-Proofpoint-GUID: 54gtTjYfshzp4iyTgYS-dB6FxxuELq41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 11/6/25 2:41 PM, Vladimir Sementsov-Ogievskiy wrote:
> The code tends to include errno into error messages after
> tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.
> 
> Both has error paths, where errno is not set, examples:
> 
> tpm_emulator_ctrlcmd()
>    qemu_chr_fe_write_all()
>      qemu_chr_write()
>        replay_char_write_event_load()
>          ...
>          *res = replay_get_dword();
>          ...
> 
> tpm_util_test_tpmdev()
>    tpm_util_test()
>      tpm_util_request()
>        ...
>        if (n != requestlen) {
>            return -EFAULT;
>        }
>        ...
> 
> Both doesn't document that they set errno.
> 
> Let's drop these explicit usage of errno. If we need this information,
> it should be added to errp deeper in the stack.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

