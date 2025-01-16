Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFC0C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQdb-0002Dr-RA; Thu, 16 Jan 2025 09:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQdZ-0002Cu-E5; Thu, 16 Jan 2025 09:14:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tYQdX-0003oO-GJ; Thu, 16 Jan 2025 09:14:21 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GAa6CV028324;
 Thu, 16 Jan 2025 14:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2IolMO
 trlYuXWD04sphpmlAcLZ+/qBhRDlHhfKArkSs=; b=XILYdy6TVzYhiFIx2h2b/u
 HPnaB/PD7o+lXowMGhf59RkUs28opHchay8Ky0p0DYKK/PJEfgkT5UpML+lRUrUt
 bhODGCDS4H0SNfyp8lqKzGTC1nEkEHSysUZGhW3s9K6TRjzIs3exHmhtcigEk/vx
 UAZQ8zP2t1nbp80JqX1E3lDQR79fYRr3coLcW9G2OgDwInUhFHCgHNuuNgJrtyG6
 IFralFR5kIjCUQu40P6yOpt/cpcxqpfjt1Nls9Yax9Pr+PMohlnCPGEmlhasoqKz
 wz6Rxig+oS129rtWk5sG35YCK0I7KGPqUnZpna0Bq0J0R26be8VYLAJVZqCXa0yA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446q5huhh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:14:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDU7iR007364;
 Thu, 16 Jan 2025 14:14:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yne5kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jan 2025 14:14:15 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50GEEE8718416184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 14:14:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E772A5803F;
 Thu, 16 Jan 2025 14:14:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D74258064;
 Thu, 16 Jan 2025 14:14:13 +0000 (GMT)
Received: from [9.61.78.171] (unknown [9.61.78.171])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jan 2025 14:14:13 +0000 (GMT)
Message-ID: <2d1b0e63-9f7f-479a-99d9-e4ac009a4be3@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:14:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pc-bios/s390-ccw: Fix boot problem with virtio-net
 devices
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>
References: <20250116115826.192047-1-thuth@redhat.com>
 <20250116115826.192047-3-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250116115826.192047-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -xK1q6v2YdRBYKPYzjEkstvXxkVrdJ23
X-Proofpoint-GUID: -xK1q6v2YdRBYKPYzjEkstvXxkVrdJ23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160106
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> When we are trying to boot from virtio-net devices, the
> s390-ccw bios currently leaves the virtio-net device enabled
> after using it. That means that the receiving virt queues will
> continue to happily write incoming network packets into memory.
> This can corrupt data of the following boot process. For example,
> if you set up a second guest on a virtual network and create a
> lot of broadcast traffic there, e.g. with:
>
>   ping -i 0.02 -s 1400  -b 192.168.1.255
>
> and then you try to boot a guest with two boot devices, a network
> device first (which should not be bootable) and e.g. a bootable SCSI
> CD second, then this guest will fail to load the kernel from the CD
> image:
>
>   $ qemu-system-s390x -m 2G -nographic -device virtio-scsi-ccw \
>      -netdev tap,id=net0 -device virtio-net-ccw,netdev=net0,bootindex=1 \
>      -drive if=none,file=test.iso,format=raw,id=cd1 \
>      -device scsi-cd,drive=cd1,bootindex=2
>   LOADPARM=[        ]
>
>   Network boot device detected
>   Network boot starting...
>     Using MAC address: 52:54:00:12:34:56
>     Requesting information via DHCP: done
>     Using IPv4 address: 192.168.1.76
>     Using TFTP server: 192.168.1.1
>   Trying pxelinux.cfg files...
>     TFTP error: ICMP ERROR "port unreachable"
>     Receiving data:  0 KBytes
>   Repeating TFTP read request...
>     TFTP error: ICMP ERROR "port unreachable"
>   Failed to load OS from network.
>   Failed to IPL from this network!
>   LOADPARM=[        ]
>
>   Using virtio-scsi.
>
>   ! virtio-scsi:setup:inquiry: response VS RESP=ff !
>   ERROR: No suitable device for IPL. Halting...
>
> We really have to shut up the virtio-net devices after we're not
> using it anymore. The easiest way to do this is to simply reset
> the device, so let's do that now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/virtio.h     |  1 +
>   pc-bios/s390-ccw/netmain.c    | 33 +++++++++++++++++++++++----------
>   pc-bios/s390-ccw/virtio-net.c |  5 +++++
>   3 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index f13fa6f5fe..5c5e808a50 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -278,5 +278,6 @@ int virtio_reset(VDev *vdev);
>   int virtio_setup_ccw(VDev *vdev);
>   
>   int virtio_net_init(void *mac_addr);
> +void virtio_net_deinit(void);
>   
>   #endif /* VIRTIO_H */
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index e46e470db4..335ea9b63e 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -153,19 +153,10 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
>       return rc;
>   }
>   
> -static int net_init(filename_ip_t *fn_ip)
> +static int net_init_ip(filename_ip_t *fn_ip)
>   {
>       int rc;
>   
> -    memset(fn_ip, 0, sizeof(filename_ip_t));
> -
> -    rc = virtio_net_init(mac);
> -    if (rc < 0) {
> -        puts("Could not initialize network device");
> -        return -101;
> -    }
> -    fn_ip->fd = rc;
> -
>       printf("  Using MAC address: %02x:%02x:%02x:%02x:%02x:%02x\n",
>              mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
>   
> @@ -221,11 +212,33 @@ static int net_init(filename_ip_t *fn_ip)
>       return rc;
>   }
>   
> +static int net_init(filename_ip_t *fn_ip)
> +{
> +    int rc;
> +
> +    memset(fn_ip, 0, sizeof(filename_ip_t));
> +
> +    rc = virtio_net_init(mac);
> +    if (rc < 0) {
> +        puts("Could not initialize network device");
> +        return -101;
> +    }
> +    fn_ip->fd = rc;
> +
> +    rc = net_init_ip(fn_ip);
> +    if (rc < 0) {
> +        virtio_net_deinit();
> +    }
> +
> +    return rc;
> +}
> +
>   static void net_release(filename_ip_t *fn_ip)
>   {
>       if (fn_ip->ip_version == 4) {
>           dhcp_send_release(fn_ip->fd);
>       }
> +    virtio_net_deinit();
>   }
>   
>   /**
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index 578c89d0c5..301445bf97 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -140,3 +140,8 @@ int recv(int fd, void *buf, int maxlen, int flags)
>   
>       return len;
>   }
> +
> +void virtio_net_deinit(void)
> +{
> +    virtio_reset(virtio_get_device());
> +}


