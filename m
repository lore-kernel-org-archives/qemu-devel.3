Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDE2C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 12:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJBoc-0001Fh-7y; Mon, 17 Jun 2024 08:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJBoZ-0001F8-UD; Mon, 17 Jun 2024 08:50:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJBoX-00023e-Td; Mon, 17 Jun 2024 08:50:27 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HCTLUr004914;
 Mon, 17 Jun 2024 12:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=r
 Stl0isjzwhaQIUwKSOmgi2iLDvwA8fUamHtlkH1gxk=; b=m2U2zKwRHUPxE6Zgw
 eiRghTr2Rb+QwJ9gSPBbEl1uoPGIxDapJXahQqwU9vk+PSxLNg0PDzrEdWCOXnC6
 b42IbcfCaSo0cdCQfEULT5iNeO4l7S7dmyc/yTTaZYUSgegGQf8NN7pByfg44U6g
 hcv/RLafeUKwfWmpSZfPFUmVgCgsPpH2O0q4fjSsnOPlj6GWebe0LKK8h/7aDwoq
 I5vgv/bUwiyQGnJNczZntoJwLwTvOSqUS2zMAjvWQQll0d3ePob2If5OtmgaC6i2
 igEMgtx1zMsKN5B7/bjhEsbwkcxw4ruAzlbOgnjwFlk4IUVOfvcn4b8dORpxvVsf
 vERnQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytn6j81hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 12:50:19 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HCoIBI005224;
 Mon, 17 Jun 2024 12:50:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytn6j81hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 12:50:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45HCDP1l009422; Mon, 17 Jun 2024 12:50:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgm9tr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 12:50:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HCoFoF48955818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 12:50:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC67A58076;
 Mon, 17 Jun 2024 12:50:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C680258070;
 Mon, 17 Jun 2024 12:50:11 +0000 (GMT)
Received: from [9.124.223.158] (unknown [9.124.223.158])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 12:50:10 +0000 (GMT)
Message-ID: <9be09448-5740-41a6-b3ff-d1b5b10e13b1@linux.ibm.com>
Date: Mon, 17 Jun 2024 18:20:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/26] hw/ppc: Avoid using Monitor in
 spapr_xive_pic_print_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
 <20240610062105.49848-9-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240610062105.49848-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 33lA1Mqcrhk2Wbz0m1WDJy1_SFWyDVoT
X-Proofpoint-ORIG-GUID: kzVL9ahH3lorlbMiklhgYGDo_CuW8ZnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_10,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 mlxlogscore=968 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> @@ -203,10 +201,8 @@ static void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
>                   spapr_xive_end_pic_print_info(xive, end, buf);
>               }
>   
> -            info = human_readable_text_from_str(buf);
> -            monitor_puts(mon, info->human_readable_text);
>           }
> -        monitor_printf(mon, "\n");
> +        g_string_append_c(buf, '\n');

Ok, I see caller specific changes are done in separate patches.
Ideally one call flow could be squashed into a single patch, which would
help avoid addition, followed by removal of common logic like above.
However, assuming that would be increasing the patch size, I understand
smaller patches are easier to review.

Thanks
Harsh

>       }
>   }

