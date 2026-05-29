Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228B4CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT50s-0002hC-39; Fri, 29 May 2026 17:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wT50p-0002gh-WC; Fri, 29 May 2026 17:45:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wT50o-0005mc-BF; Fri, 29 May 2026 17:45:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIjPZ31672541; Fri, 29 May 2026 21:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AAYWdj
 nt7IpHHiApOW081dYizbpUFLtxLnIaxv7D980=; b=fEpeYPWxQ320Qn6qNq6q4Z
 3JOPFjPK+EBrig0LsEb9ZG+u/sl96egAyd2MsTjUH+x2ziQa3AwUPauDzCJiIV+W
 z4l0+lk+ScSrw5mgXR4qsbmEKl37PVwWq7FrI/aYBmKXtUHpLtTrPUo/JDZxfyAW
 x32qSGTUAS56TOakVrxi4RW0HkrZd25I/O92qVEjDtpCX4xDGdsfELU9DJt47v61
 rMrtDBTYkMzjydL0iMZy786XGZkiQYVb/qBihuKZ8Mcwny4XpGlDx3mh4DAHi8Y2
 eeHHN6y/LGNPtakyFD68L5EWKd7ceKOlmFd9hvhCwBHBygnjyiSZMO93zPLgLSuA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886rqas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2026 21:44:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TLd8gX014600;
 Fri, 29 May 2026 21:44:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbjnf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2026 21:44:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64TLitQq32965216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2026 21:44:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 386185805A;
 Fri, 29 May 2026 21:44:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A8A658051;
 Fri, 29 May 2026 21:44:53 +0000 (GMT)
Received: from [9.67.138.50] (unknown [9.67.138.50])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 29 May 2026 21:44:53 +0000 (GMT)
Message-ID: <86c66ee1-37a3-466b-bc34-ea32803d9fa6@linux.ibm.com>
Date: Fri, 29 May 2026 17:44:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 25/32] Add secure-boot to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-26-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260505201905.997996-26-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aqIhnClJ5m4HeK8jHfWYupLFtx2aI2LQ
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a1a08da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=7Z7TNXnwCHPPKsl8XtEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxNSBTYWx0ZWRfXyDKHSJsBzGTL
 jzEEO7s7zdT7FHuogsDZtsGl/vytXXUfsl/dbaTBYW1aAZQ3KenVaJ7i89nFT5K3NGI9njkwyJt
 vwF/PetLfvjtgjg+VrAhL7lcxNHRdF/ssBiiLfcaeW+2miMvpprfbvsYoUGELfOToZ8Cy0b/Rxz
 3FRvbge4IychrQuCisMvWBYDJI8yTiiC4DeI8qWfUF1GaQVVxgX3UxIo6NKTYIgNBMTgjbJAUt8
 MzzRA12yRmqJCTE00hKFwsTHy4XLOHRDxTG8+WKidSK5O9HSKwW8Cjs2IzQFuSBMqcPwS3FrSnj
 OB/VPJNKAddWvP64QZQLLioYXMEMvWhJt5gfoK4rWCskKcbjj3Dl8ZES4es1fWhI8fINelmaSaB
 PNyz0wG7Yawm+jOetfNoBWgQZVdXiEqZ7mpXNPnyA7cbOZvfEo2X8MyT1o+/M+CiGfHjcXN7asT
 Pi8mCMMEY43lcX/zlyQ==
X-Proofpoint-ORIG-GUID: aqIhnClJ5m4HeK8jHfWYupLFtx2aI2LQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290215
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Collin Walling <walling@linux.ibm.com>

