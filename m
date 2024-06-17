Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2335C2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 12:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJBZy-0002rj-Ag; Mon, 17 Jun 2024 08:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJBZv-0002qt-Su; Mon, 17 Jun 2024 08:35:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJBZt-0007xg-Jb; Mon, 17 Jun 2024 08:35:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HCWZcD019593;
 Mon, 17 Jun 2024 12:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=/
 Ct1cQrKEyiyHP+Y2c2ID8aqrTMrrCpiC17ZKGz49mo=; b=liH6o56JaxDQPGAe4
 v8XC3gsXOMVGJ7wG4iD/c7ZiGXoSYejUeXGP5YILS9+B8VJdki2Gj7DM5hfhr+2u
 SpXIjpaTvPcWiiMimTXkJmRSDTU/8y4LsPbF89sqqgDD8aR8u448qsTln4rORcDf
 x4P9DXm8k8H1uCA1gv9O842pecjsRUdUu6SZmeGWL/Crg148v/fBawC6s22x0uwk
 C/Th3UfmucV2ZuA5hb1nFbBIdPXtpuIEQtUrCNDmhCqHoyo3J1zH7AkAIEKBA9Yv
 hTRw/LfTeI1UEGNdp2MRD/I4XkqS9JxgrHwvAfQd+AVtbFIocd/Cjpbte5xXJMA7
 JOaYQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytke689nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 12:35:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HCZ9BM023271;
 Mon, 17 Jun 2024 12:35:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytke689na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 12:35:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45HCU8qB009921; Mon, 17 Jun 2024 12:35:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgm9r1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 12:35:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HCZ6Z417891982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 12:35:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EF4D58060;
 Mon, 17 Jun 2024 12:35:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2023E5803F;
 Mon, 17 Jun 2024 12:35:03 +0000 (GMT)
Received: from [9.124.223.158] (unknown [9.124.223.158])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 12:35:02 +0000 (GMT)
Message-ID: <301fccc3-b49b-45f6-92af-9d42a0edfca1@linux.ibm.com>
Date: Mon, 17 Jun 2024 18:05:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/26] hw/ppc: Avoid using Monitor in
 xive_end_queue_pic_print_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
 <20240610062105.49848-7-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240610062105.49848-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3EQZ4ffNr6hw6jyIZOSrgP1lKwmxrb5p
X-Proofpoint-ORIG-GUID: zlG0bS9Mf58UfYuCCnGO-6-OEPlBqWMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_10,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 mlxlogscore=787 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 6/10/24 11:50, Philippe Mathieu-Daudé wrote:
> @@ -1389,8 +1392,10 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon)
>       if (qaddr_base) {
>           monitor_printf(mon, " eq:@%08"PRIx64"% 6d/%5d ^%d",
>                          qaddr_base, qindex, qentries, qgen);
> -        xive_end_queue_pic_print_info(end, 6, mon);
> +        xive_end_queue_pic_print_info(end, 6, buf);
>       }
> +    info = human_readable_text_from_str(buf);
> +    monitor_puts(mon, info->human_readable_text);
>       monitor_printf(mon, "\n");

This monitor_printf could also be folded in buf before info assignment ?

>   }
>   

