Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D27BC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQdS-00029s-FB; Thu, 16 Jan 2025 09:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQdQ-00028p-D8; Thu, 16 Jan 2025 09:14:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQdO-0003lf-M6; Thu, 16 Jan 2025 09:14:11 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GCIBRE022756;
 Thu, 16 Jan 2025 14:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=H+goR5
 RH/4u3GVtdJbRhjTnnwTfIWnaLlYbpQOriQCM=; b=sPTEguYExKWrd8YPUb0hKv
 AbebpAfbh48ngPKVbVaPEx1PHa/9Z2n13s27x0g1wt9hls/mPVsAiC5yOOI5hNVS
 H5sp740Bpn+6tMFdbVy/Kd3fMkH/TRdK7eHi+j1KZrYctyCJZ/jiXw3YkNDLrnGR
 pdsmPNPeOaOOLPU+dvgOin+0IwMiP7pmy/OxaHiiXUjyiT+U7W/jkVLmCuG5rE77
 ONF62jp/8ixaA8665TU4eQIxA3dEk9i5a4NqnhyNFrn1MFwgiu1pFRoiJdczxxSZ
 +FEXJgA3aWEOMhEEvHGOKffP4rYsNxwDNFYCBNJV2HhZl12RmVoM50vV+5vV3sxg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub3ffr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:14:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GCVGcK004543;
 Thu, 16 Jan 2025 14:14:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442ysxayv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:14:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GEE51J24052262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 14:14:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 796D758056;
 Thu, 16 Jan 2025 14:14:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2147C5803F;
 Thu, 16 Jan 2025 14:14:05 +0000 (GMT)
Received: from [9.61.78.171] (unknown [9.61.78.171])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 14:14:05 +0000 (GMT)
Message-ID: <fb25c563-7fdb-432e-9075-ff21be9a151b@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:14:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] pc-bios/s390-ccw/virtio: Add a function to reset a
 virtio device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>
References: <20250116115826.192047-1-thuth@redhat.com>
 <20250116115826.192047-2-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250116115826.192047-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wbZhetTofme2ac5OExWD6n59Ia3ccRYd
X-Proofpoint-ORIG-GUID: wbZhetTofme2ac5OExWD6n59Ia3ccRYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=953 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

On 1/16/25 6:58 AM, Thomas Huth wrote:
> To be able to properly silence a virtio device after using it,
> we need a global function to reset the device.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/virtio.h | 1 +
>   pc-bios/s390-ccw/virtio.c | 7 ++++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 9faf3986b1..f13fa6f5fe 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -274,6 +274,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags);
>   int vr_poll(VRing *vr);
>   int vring_wait_reply(void);
>   int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
> +int virtio_reset(VDev *vdev);
>   int virtio_setup_ccw(VDev *vdev);
>   
>   int virtio_net_init(void *mac_addr);
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 8b5a370bb3..cd6c99c7e3 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -217,6 +217,11 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
>       return 0;
>   }
>   
> +int virtio_reset(VDev *vdev)
> +{
> +    return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
> +}
> +
>   int virtio_setup_ccw(VDev *vdev)
>   {
>       int i, cfg_size = 0;
> @@ -235,7 +240,7 @@ int virtio_setup_ccw(VDev *vdev)
>       vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
>       vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>   
> -    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
> +    virtio_reset(vdev);
>   
>       status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
>       if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {


