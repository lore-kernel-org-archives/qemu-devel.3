Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2950AD6DDD2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 05:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBoVN-0003ev-Bs; Fri, 15 Nov 2024 00:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBoVJ-0003eY-9v; Fri, 15 Nov 2024 00:04:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBoVH-0005om-53; Fri, 15 Nov 2024 00:04:20 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0jpsa000685;
 Fri, 15 Nov 2024 05:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kc2ZRv
 eXoKLxZdhET8xG7q1o6vYUC5qE1INPXTV12+M=; b=tn5vqlmvpA2ZtIRgKGxeok
 XwHgMDyU1tn7cAeGGIQow3fnt2aYIRH/Ng7Ic21+UGun3ZTrS8FFLxd4W1x/BAey
 cIszCjeGhg80l63j26uCsKUMdDrpfr2Z5SVnbcdrkeLTAwiEI/Lxq9sj1HjgwJkD
 WzfyDgvpmkxZv548llRABVQr5Ip8VDMq5HiZgimswA/F1AfwTIwJoiPJoiTKteOS
 /aEXys5+5yl3UcI80LfmYrymCVCHjfTb+qrq53Berv1PGq6bJQhe9LzBAggBEkud
 gRMcX3p3fLloCRVJFEul5XRxS4hN5m2rZH9j8tnmU5URB1b6IQMjXLEdENZHiVMg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wren1psk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Nov 2024 05:04:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF3ZDEO029721;
 Fri, 15 Nov 2024 05:03:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmpgt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Nov 2024 05:03:47 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AF53jIu41157110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2024 05:03:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCD9F58059;
 Fri, 15 Nov 2024 05:03:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC4DE58058;
 Fri, 15 Nov 2024 05:03:44 +0000 (GMT)
Received: from [9.61.112.252] (unknown [9.61.112.252])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 15 Nov 2024 05:03:44 +0000 (GMT)
Message-ID: <49ccaeee-b811-4daf-99e7-4245303d611b@linux.ibm.com>
Date: Fri, 15 Nov 2024 00:03:43 -0500
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
X-Proofpoint-GUID: ai-XUDE0FshGaha7M3WQ8PtxVzN2KoEJ
X-Proofpoint-ORIG-GUID: ai-XUDE0FshGaha7M3WQ8PtxVzN2KoEJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150041
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

With documentation of per-device loadparm behavior during device probing
similar to suggestion here:
  https://lore.kernel.org/qemu-devel/20241115002742.3576842-1-jrossi@linux.ibm.com/

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

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


