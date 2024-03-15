Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A0EC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6dh-0008N9-2x; Fri, 15 Mar 2024 08:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rl6dQ-0008LS-Rb; Fri, 15 Mar 2024 08:26:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rl6dN-0005TV-II; Fri, 15 Mar 2024 08:26:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42FB1Lg1014235; Fri, 15 Mar 2024 12:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=inuPcBOKNpA5aFdaAfhGbBVvv76YoC3NkTIk3n4Dr/c=;
 b=foG2pCEk11DCgw72F27UsE+YJX+339dVkHF4h9IQtW+qmgjMIWVnRM/zNzdvxIcnh1Pa
 ufk/DoD/SGV7o1GppvfOKEtv4O/xRrGHH0vrTEUI85nyCZTVdAKTWd+NfsT2qAgPDONz
 XTJwg7eck2JvG7y2MfJ0TpdyDpvWU9SRJAjpxTzabMwIIDHXI/qgUYvk6P3SrByB78N9
 boEYYKNeopxLzbDimb6VLqkslzWAnKiuHkuaNKVrQZjpC1o9n8Di/KJYxsxYvbLcTHIK
 js3gs7d1GL+RrqajgEzpDPM/m7cape+aMHgOWvHG5SdAhfay5vIu+3Ix9ifDkR4sqrPe pA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvjhyjqv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 12:25:56 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FCPXjT032245;
 Fri, 15 Mar 2024 12:25:56 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvjhyjqv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 12:25:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42FBo2EM013553; Fri, 15 Mar 2024 12:25:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4akuddq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 12:25:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42FCPoKf23462516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 12:25:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 556422004B;
 Fri, 15 Mar 2024 12:25:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37EBB20040;
 Fri, 15 Mar 2024 12:25:50 +0000 (GMT)
Received: from [9.152.224.222] (unknown [9.152.224.222])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Mar 2024 12:25:50 +0000 (GMT)
Message-ID: <8d42a208-f592-49ad-a914-7568a80eee97@linux.ibm.com>
Date: Fri, 15 Mar 2024 13:25:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: improve cpu compatibility check error
 message
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240314190007.19568-1-cfontana@suse.de>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240314190007.19568-1-cfontana@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7p7kLj50tPxmNn-gODPaZjfzFBmALmRS
X-Proofpoint-GUID: MCBzvnX6-iw1A5_NCQRmbS8dY2V0vyx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150100
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 14.03.24 um 20:00 schrieb Claudio Fontana:
> some users were confused by this message showing under TCG:
> 
> Selected CPU generation is too new. Maximum supported model
> in the configuration: 'xyz'
> 
> Try to clarify that the maximum can depend on the accel by
> adding also the current accelerator to the message as such:
> 
> Selected CPU generation is too new. Maximum supported model
> in the accelerator 'tcg' configuration: 'xyz'
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Independent on which message we end up with (see comments
in this mail thread), I agree that improving the
error message is helpful.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   target/s390x/cpu_models.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 1a1c096122..0d6d8fc727 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -508,14 +508,14 @@ static void check_compatibility(const S390CPUModel *max_model,
>   
>       if (model->def->gen > max_model->def->gen) {
>           error_setg(errp, "Selected CPU generation is too new. Maximum "
> -                   "supported model in the configuration: \'%s\'",
> -                   max_model->def->name);
> +                   "supported model in the accelerator \'%s\' configuration: \'%s\'",
> +                   current_accel_name(), max_model->def->name);
>           return;
>       } else if (model->def->gen == max_model->def->gen &&
>                  model->def->ec_ga > max_model->def->ec_ga) {
>           error_setg(errp, "Selected CPU GA level is too new. Maximum "
> -                   "supported model in the configuration: \'%s\'",
> -                   max_model->def->name);
> +                   "supported model in the accelerator \'%s\' configuration: \'%s\'",
> +                   current_accel_name(), max_model->def->name);
>           return;
>       }
>   
> @@ -537,7 +537,8 @@ static void check_compatibility(const S390CPUModel *max_model,
>       error_setg(errp, " ");
>       s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat);
>       error_prepend(errp, "Some features requested in the CPU model are not "
> -                  "available in the configuration: ");
> +                  "available in the accelerator \'%s\' configuration: ",
> +                  current_accel_name());
>   }
>   
>   S390CPUModel *get_max_cpu_model(Error **errp)

