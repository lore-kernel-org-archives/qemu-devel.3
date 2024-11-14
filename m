Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727F1D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 15:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcCb-0003U4-QG; Thu, 14 Nov 2024 10:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBcCY-0003TA-51; Thu, 14 Nov 2024 10:56:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBcCU-00013l-ER; Thu, 14 Nov 2024 10:56:09 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEZwwG003090;
 Thu, 14 Nov 2024 15:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ifyYhI
 RhR2TDFaNyyOJTNxXnwJCAH4TF7bvt0S4CQYA=; b=BPnYwokjcxRWvuamLgNK07
 ewn4kusVD/fXL/gsMY3F7Kdd1spnpI5kTLTqGjQNlUKFa7nTzc2IaOQ8nqi+GfYg
 gIKFYpJp6n3Cs0zE7HssdHezaug7bS+18VGU053eGCVwO5zIBASuGtIPqRUFNRDg
 OnYMrpdp2BONQ7JPRJo4MgIUZTEuWud9f+p2y+8vGFToNcsPzeu1zTWsSnQCosl+
 id7Ck+gWEFnGNecI5xEpi4MOsYhcoQqvnxWwNzHa64yK949USpErkG+uHt/VDY4/
 tyQqfyaBgH7zPaXO6h+/Tb8vsPZpLk34xgj/Bs7FnkcdIaBwHWv2+akU1IRr6R1Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wjqrgf7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 15:55:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEBdTNm006603;
 Thu, 14 Nov 2024 15:55:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jgfma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2024 15:55:57 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AEFttCq47645090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 15:55:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CE4158056;
 Thu, 14 Nov 2024 15:55:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88E2F58060;
 Thu, 14 Nov 2024 15:55:54 +0000 (GMT)
Received: from [9.61.167.191] (unknown [9.61.167.191])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 14 Nov 2024 15:55:54 +0000 (GMT)
Message-ID: <9e7cb217-a33e-48aa-b030-efb991ca33f3@linux.ibm.com>
Date: Thu, 14 Nov 2024 10:55:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
References: <20241114122919.973930-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20241114122919.973930-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O5As_Hzbr3XFcHqSM8zj2VlIxe5TTwtE
X-Proofpoint-GUID: O5As_Hzbr3XFcHqSM8zj2VlIxe5TTwtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 11/14/24 7:29 AM, Thomas Huth wrote:
> While adding the new flexible boot order feature on s390x recently,
> we missed to add the "loadparm" property to the scsi-hd and scsi-cd
> devices. This property is required on s390x to pass the information
> to the boot loader about which kernel should be started or whether
> the boot menu should be shown. But even more serious: The missing
> property is now causing trouble with the corresponding libvirt patches
> that assume that the "loadparm" property is either settable for all
> bootable devices (when the "boot order" feature is implemented in
> QEMU), or none (meaning the behaviour of older QEMUs that only allowed
> one "loadparm" at the machine level). To fix this broken situation,
> let's implement the "loadparm" property for the SCSI devices, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   NB: Unlike the ccw_device_set_loadparm() logic that we use for CCW
>       devices, I've decided to use a string property for the "loadparm"
>       in the SCSI devices to avoid spoiling the common code with too much
>       s390x logic. So the check for valid characters is now done after the
>       property has been set, i.e. we only print out an error instead of
>       forbidding the setting (like we do it with the CCW devices), which
>       is IMHO still perfectly acceptable. Or are there other opinions?

I wasn't able to think of a way to abuse passing invalid characters, but 
I did
find two additional differences about the string approach:

a) it is not possible to override the machine loadparm by assigning an empty
  string (loadparm="") to the device

b) it is possible to assign a loadparm value to a non-boot device

I don't think that the inability to pass the empty string is a significant
problem because passing a single space will have the same effect.

Assigning a loadparm to a non-boot device generally does nothing, but in the
case of device probing (i.e. no boot devices assigned at all), the 
device with
the loadparm assigned could be selected for IPL, but it will not use the
assigned loadparm (because no IPLB was generated for the device). This 
check is
normally handled by ccw_device_set_loadparm(), but I'm not sure if there 
is a
way to do the validation without having a setter function for the property.

When both a bootindex and a loadparm are assigned it seems to work 
correctly.

I would like to get other's opinions on if the two issues I pointed out
are actually significant enough to justify a more robust implementation, 
since
I think it would require more s390x specific modifications to the common 
code.

>
>   hw/s390x/ipl.c      | 22 +++++++++++++++++++---
>   hw/scsi/scsi-disk.c |  2 ++
>   2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index dc02b0fdda..c902b562cb 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -416,12 +416,10 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>       return chain_addr;
>   }
>   
> -void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
> +static void s390_sanitize_loadparm(uint8_t *loadparm, char *str, Error **errp)
>   {
>       int i;
>   
> -    /* Initialize the loadparm with spaces */
> -    memset(loadparm, ' ', LOADPARM_LEN);
>       for (i = 0; i < LOADPARM_LEN && str[i]; i++) {
>           uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
>   
> @@ -435,6 +433,13 @@ void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
>       }
>   }
>   
> +void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
> +{
> +    /* Initialize the loadparm with spaces */
> +    memset(loadparm, ' ', LOADPARM_LEN);
> +    s390_sanitize_loadparm(loadparm, str, errp);
> +}
> +
>   void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>   {
>       int i;
> @@ -452,6 +457,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>       SCSIDevice *sd;
>       int devtype;
>       uint8_t *lp;
> +    g_autofree void *scsi_lp = NULL;
>   
>       /*
>        * Currently allow IPL only from CCW devices.
> @@ -463,6 +469,16 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           switch (devtype) {
>           case CCW_DEVTYPE_SCSI:
>               sd = SCSI_DEVICE(dev_st);
> +            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
> +            if (scsi_lp && strlen(scsi_lp) > 0) {
> +                Error *errp = NULL;
> +                s390_sanitize_loadparm(scsi_lp, scsi_lp, &errp);
> +                if (errp) {
> +                    error_report_err(errp);
> +                } else {
> +                    lp = scsi_lp;
> +                }
> +            }
>               iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>               iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index cb222da7a5..c1fa02883d 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -111,6 +111,7 @@ struct SCSIDiskState {
>       char *vendor;
>       char *product;
>       char *device_id;
> +    char *loadparm;
>       bool tray_open;
>       bool tray_locked;
>       /*
> @@ -3165,6 +3166,7 @@ static const TypeInfo scsi_disk_base_info = {
>       DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),                \
>       DEFINE_PROP_STRING("product", SCSIDiskState, product),              \
>       DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id),          \
> +    DEFINE_PROP_STRING("loadparm", SCSIDiskState, loadparm),            \
>       DEFINE_PROP_BOOL("migrate-emulated-scsi-request", SCSIDiskState, migrate_emulated_scsi_request, true)
>   
>   

