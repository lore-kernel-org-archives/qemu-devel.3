Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA936D778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 23:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjQEk-0008Mc-UE; Fri, 23 Jan 2026 18:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vjQEi-0008LI-UM; Fri, 23 Jan 2026 18:06:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vjQEh-000634-49; Fri, 23 Jan 2026 18:06:40 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NDlpUS028523;
 Fri, 23 Jan 2026 23:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3A3ApC
 7PGO87cPJ12Ggi8C6pHUyTTZ+fHnYm4GAcAuI=; b=b58cQeRwZhqkQKNV8wOhTF
 8v/OVad2gUVFdvaTa2IzgmJaun/N3Mlb5OZzRajPZm25SPPkx6mvoAL0xA3B1IQd
 ePzY92ZfFx+FCDYSAm0P+TnSU3RiNONxw5YGPWHaHcW5reoBLy4yry6YnOyv50di
 j5q2shTTY04cYKiDuEu9LEvpN3HUoe+Ob5cxbCi1Nxysl06NKK20tn1NZAjJjmRe
 WvNGHBYb8ZNdFz0UJA2uRsJpNVlFBMvjJ+i1a7tQXDO96bnDS1TIiltv46Tv9cAU
 pootL7vmxb0VRWmmCqQ/kG9PtWOW+XQUrkvjtsB7om9B+jJpEjfSo0Pz5PPSGWbg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f6ern-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 23:06:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NK2gfh027233;
 Fri, 23 Jan 2026 23:06:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnknak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 23:06:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NN6RA541746726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 23:06:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40C3E20043;
 Fri, 23 Jan 2026 23:06:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D53F20040;
 Fri, 23 Jan 2026 23:06:26 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.3.233])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 23 Jan 2026 23:06:26 +0000 (GMT)
Date: Sat, 24 Jan 2026 00:06:24 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Thomas Huth
 <thuth@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org (open
 list:virtio-ccw), Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 08/23] virtio: move common part of
 _set_guest_notifier to generic code
Message-ID: <20260124000624.1bd7c9c1.pasic@linux.ibm.com>
In-Reply-To: <20260119185228.203296-9-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-9-vsementsov@yandex-team.ru>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=6973fef8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=49PAtOYawd9SfLlgKsUA:9 a=CjuIK1q_8ugA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: 1juvDvL5_fkgi0lblD-mdpr27E5vvBtw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE3NyBTYWx0ZWRfX1sCKxMIGmXVC
 gMjo4RcQ322b1yjRMQDn4oX69/OqWZ3j9n6qIR0XrVad8dvkWj90C7J9DFr52WQQNAl6gCDkfqT
 uKAiG9WxH4Utkzoq0fBLxmMqNtmEgI+0AqCI8w/2LW6yVcw1rm6aBbsAehZxCwWbAA3QPSooy6K
 NVcp2zYd9dzK/VtZimdVj9NeRFNawIkcx3Mx4ctbjVMYEroC9J1KeADRbFmzSQlYG0kDVmN+rXL
 krMuk3ypHdOgQhonP4PWCXsnx06TZWYUNH7C5jHrfeWFeVePLYCPT5ZfTiJyHtvC7DQl48h+ryJ
 wuyErMAAi6+riwTPCTwf8zk34nGK0osnC5Zz1OguRFMckQvpR0UY3NhQqq4bYMq9TZNqijk9FiG
 lEq+B8Sc9K/k+itNf/jwCBAzyLNw2JwzbI+tP8Ku6g/3Omiy6yYzbmDWkwtk2WBBED0OiKlV0HM
 jT8aZAMHREgbvCuA3nw==
X-Proofpoint-ORIG-GUID: 1juvDvL5_fkgi0lblD-mdpr27E5vvBtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 19 Jan 2026 21:52:12 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:

> virtio-pci, virtio-mmio and virtio-ccw handle config notifier equally
> but with different code (mmio adds a separate function, when pci use
> common function). Let's chose the more compact way (pci) and reuse it
> for mmio.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Ultimately is up to Michael to decide, but I'm not sure patch makes
things cleaner. I would even say, its current form, it does not.

I do like the idea of getting rid of duplicated logic though.


> ---
>  hw/s390x/virtio-ccw.c          | 35 ++++++++++++-------------
>  hw/virtio/virtio-mmio.c        | 41 +++++------------------------
>  hw/virtio/virtio-pci.c         | 34 +++---------------------
>  hw/virtio/virtio.c             | 48 +++++++++++++++++++++++++++++++---
>  include/hw/virtio/virtio-pci.h |  3 ---
>  include/hw/virtio/virtio.h     | 16 +++++++++---
>  6 files changed, 84 insertions(+), 93 deletions(-)
[..]
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 3dc9423eae..ea43ea620c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
[..]
> +static void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev,

Function name says 'pci' but it actually is not PCI specific.

> +                                                     VirtQueue *vq,
> +                                                     int n, bool assign,
> +                                                     bool with_irqfd)
> +{
> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
> +        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
> +    } else {
> +        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
> +    }
> +}
> +
[..]
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 27cd98d2fe..25ef7c9dff 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -420,8 +420,6 @@ void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
>  VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
>  uint16_t virtio_get_queue_index(VirtQueue *vq);
>  EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
> -void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
> -                                                bool with_irqfd);
>  int virtio_device_start_ioeventfd(VirtIODevice *vdev);
>  int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
>  void virtio_device_release_ioeventfd(VirtIODevice *vdev);
> @@ -435,8 +433,18 @@ void virtio_queue_aio_detach_host_notifier(VirtQueue *vq, AioContext *ctx);
>  VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
>  VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
>  EventNotifier *virtio_config_get_guest_notifier(VirtIODevice *vdev);
> -void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
> -                                                 bool assign, bool with_irqfd);
> +
> +/**
> + * virtio_queue_set_guest_notifier - set/unset queue or config guest
> + *     notifier
> + *
> + * @vdev: the VirtIO device
> + * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notifer

Semantically are mixing queue numbers and interrupt indexes here.

> + * @assign: true to set notifier, false to unset
> + * @with_irqfd: irqfd enabled
> + */
> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
> +                                    bool with_irqfd);

The name says 'queue' but it is not always queue any more.

Regards,
Halil

