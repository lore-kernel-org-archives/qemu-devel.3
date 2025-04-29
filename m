Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596ADC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rwv-00022F-4m; Tue, 29 Apr 2025 16:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9rwt-00021y-Ql
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:53:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9rwq-0001KY-R4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:53:02 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TFYhkf026962;
 Tue, 29 Apr 2025 20:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L0Ja3x
 Sdi8HL/ASOxlhPREkTKAUmHQZx6m1eMURuXPE=; b=hT1HDzKqJyTHJwbbBTdDpX
 sEQFVpQeGhln7aiP+GROoDLqxAOduVBi7iOfkfAL97bAkpCKFGcgbsZCDUSxNz5r
 V+q0RZku6XiOf7SKLXHN0DlRWCoB/K3yDyeN1utQirQOU5IOkbWORP2lD+b8Mv33
 8jFP8xFzOFRQr2slWIMhqjFEgH4hvziG3VU/dHatdHGb0CtfWLSQM17IqpJvNv01
 iHzK7APq2BHhkv2ibS9csLA3J5OkKiaHREzNaueqecfTiae0NNYyDdujkjNLlsCC
 2+RDjaevydp0u7Wfn9CnutqgF6S8ItpVV5wVO4wmeJlxx3ArFL91vLJucuMHNOTg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahtwn7c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:52:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TIMPsv001803;
 Tue, 29 Apr 2025 20:52:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bammy36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:52:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53TKqsdq27918858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 20:52:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DD0D58054;
 Tue, 29 Apr 2025 20:52:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F377F5805A;
 Tue, 29 Apr 2025 20:52:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 20:52:56 +0000 (GMT)
Message-ID: <b2222ede-4d4f-409c-ba25-0b58cfececfd@linux.ibm.com>
Date: Tue, 29 Apr 2025 16:52:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] qdev: make release_drive() idempotent
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-3-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250429140306.190384-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1MiBTYWx0ZWRfX5WvldHUBd06x
 8M7KuApOi9pfubNgTy1smhzMa+YzWTIoQQXNU4DQpDw120WOFTXFCjwYEe+8pF0bU2GWjG0VHAA
 IRjRjUtGn2JBA+9lX22+IDjsW3T54u7DaTqXEqQCokXX74S4FO2l075A501XDo44lrVQrZ5o+iW
 1OW/xDnz1cSvwv7VVgkIO6sdyOKO5vmBT+x9ibPn2gVwbvsaNVJ5f51rTRDR9FuO/YOhm2qt5Pm
 9QvqE0qC//aXaTfNlQa9k46Zz6STOBdYpbspae3p7ZpU38rEKoZXibffLeIhGKSoY3D2v3SUajI
 bNQA8ReTr1g0s4ewTpVhUrKUYcWcuAoVzP3PNHSnVp1VAtyQ7i+OEetmfFHymStCavUPMohaXJs
 +ufDz36gNtwp09+qPGp//x5OX6Y7v7zwFAX5fmi6z4OggChiE8xqTw6AUWCrnvJbkwAXeDe8
X-Proofpoint-GUID: 4LhkKZSV8qLk1zlEad2Q0SY3guQNH3dk
X-Authority-Analysis: v=2.4 cv=KtxN2XWN c=1 sm=1 tr=0 ts=68113c2a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=m7fl6o8Nl9rBM92gsO0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4LhkKZSV8qLk1zlEad2Q0SY3guQNH3dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/29/25 10:03 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> So it can eventually be called multiple times safely.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/qdev-properties-system.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 8e11e6388b..b10835185c 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -231,6 +231,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
>       if (*ptr) {
>           blockdev_auto_del(*ptr);
>           blk_detach_dev(*ptr, dev);
> +        *ptr = NULL;
>       }
>   }
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


