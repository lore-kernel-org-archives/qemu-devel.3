Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431E2D6C2AF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 23:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDXuo-0006Tx-E4; Tue, 19 Nov 2024 18:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tDXum-0006Tg-C0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 18:45:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tDXuj-00009f-JU
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 18:45:47 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMTHhw013396;
 Tue, 19 Nov 2024 23:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=knA/0H
 ZZHoL7vQLl4RDg2MrdhxT8/r9TWaBAKu7eWFw=; b=niUAHHI+tlUZjSd6uwCRdh
 lifF4SFjjpzJNHknIIyB45ZVMNAk3nPRC0v2ISF/V9Ym1cpvXGga0K97fQOBc0Cw
 hs363FPC5NqPP7yxSIuCuRhbXmily3ODbaXJWynbl53nMUS3qDp4EJ6QWIxIzoFY
 XbWKd1lwAtrxDesBpOyxMBXSq+0qZ6RKGDzLQ7cP7+n9OkmGDF6e3pr3ed7BEHzE
 5kslx6YBdxCDKScidWjVWq5l1GdHGGrBPqxF9iPg1rS/ovUXU8tW0YRQygMdYu0l
 PfQIEM6ZZqsuCHhX8tevvtB9//gweM8GuydAZ3kwswJ/50Y3hboSPrx24twxA5wQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4313gsg7wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2024 23:45:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJN3UG0024618;
 Tue, 19 Nov 2024 23:45:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y8e1deaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2024 23:45:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AJNjVS627918862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 23:45:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0579658058;
 Tue, 19 Nov 2024 23:45:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1B9A58057;
 Tue, 19 Nov 2024 23:45:30 +0000 (GMT)
Received: from [9.61.105.14] (unknown [9.61.105.14])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 19 Nov 2024 23:45:30 +0000 (GMT)
Message-ID: <0b575e8d-7de7-4493-b7c4-518916443364@linux.ibm.com>
Date: Tue, 19 Nov 2024 18:45:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: fix allocation for s390x loadparm
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
References: <20241119213142.77248-1-pbonzini@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20241119213142.77248-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sJEMhuf-hVzit61BhGAsizG9L2ItNbsc
X-Proofpoint-ORIG-GUID: sJEMhuf-hVzit61BhGAsizG9L2ItNbsc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190172
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


On 11/19/24 4:31 PM, Paolo Bonzini wrote:
> Coverity reports a possible buffer overrun due to a non-NUL-terminated
> string in scsi_property_set_loadparm().  While things are not so easy,
> because qdev_prop_sanitize_s390x_loadparm is designed to operate on a
> buffer that is not NUL-terminated, in this case the string *does* have
> to be NUL-terminated because it is read by scsi_property_get_loadparm
> and s390_build_iplb.
>
> Cc: jrossi@linux.ibm.com
> Cc: thuth@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/scsi-disk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8e553487d50..7f13b0588f2 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3152,7 +3152,7 @@ static void scsi_property_set_loadparm(Object *obj, const char *value,
>           return;
>       }
>   
> -    lp_str = g_malloc0(strlen(value));
> +    lp_str = g_malloc0(strlen(value) + 1);
>       if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
>           g_free(lp_str);
>           return;
Reviewed-by Jared Rossi <jrossi@linux.ibm.com>

