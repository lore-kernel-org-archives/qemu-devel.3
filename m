Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED899C982D1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yqh-000842-AZ; Wed, 16 Sep 2026 19:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqU-00081g-PZ; Wed, 16 Sep 2026 19:15:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yqS-0002cH-SM; Wed, 16 Sep 2026 19:15:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1oqj2330705; Wed, 16 Sep 2026 23:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nr7tnt
 AE1KquHCbmzrOq9HqRb1LMfn9GjF9o7pJHLSk=; b=hEQoV4n+S2PVTW94B98NJS
 dWGKZzy5QRXwWQh7cdJ1BivCdHE0aIFZ2dn7zp1fVBFZBxWsOauq7fDMzd3xuHql
 GZCF39gbgu6QmOHWkDcN30LkziQ8Xur9XhPpMF3QPXGzRxx5D+dqelSUXQW4H6U1
 m1p9IpnJn+Le1LOqO6gyBQwh1sXfTsf50ORRpuOPQ1EmGpbvdF67Djbn5rmUOOZI
 UzNlpBoqB1be7E1eoBwobjZiw19UVidGGEFcvwSVh9FSzMPDGkfKZSMgshRRp+XM
 Ze0v9QWVqwEMSTkmWQxSU3fvO/a8z+lcZFORNdMhtGQkf0/1wPdN0JthwR+wsRXQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqfdrm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GN2TLA1625747; Wed, 16 Sep 2026 23:15:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsgwqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:15:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNFBnj30474948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:15:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE6A558045;
 Wed, 16 Sep 2026 23:15:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16EC958050;
 Wed, 16 Sep 2026 23:15:11 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:15:10 +0000 (GMT)
Message-ID: <bdec4140-8d65-4480-9723-9c04595431d1@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:15:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] virtio-ccw: Limit ISC to MAX_ISC
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-2-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfX80uQ7Ao60Lty
 r2PL1uf77QCcHX1YUsJ1QtRdncwxUmvxhTo6pQNFrxQWBVZAek7ftEF1ZsbWpU3LStirI2ahdXl
 cL3shQpfrVGOPrujPShlCueCgB53dxD6pawUeh81QeDCNz94d/RQlJbiMFvHnaw33GFDdujpKTG
 TRy4IaQv6tqKBrPTI3sBVJLeepdNbgOI+z4cbkoaXxHHXOjtJAzZxdog+83zPQmRNG25VT0QX/x
 wxcPIgQ1WPpb4k6oGj67O4gJtI+ckNbO9UnCfcXHvsmip8a64G04m4aL5kwhvq+HYdFOaio4OJG
 Eo1bCEL37Saw7HIeej/OTmmSckWtRdatCRxpXw8Jfq6A7iYuydLcabZZI+RBQBUX0WFu2sU4mfv
 1CAp6Ltko9s6KXz7zlSUXuQFEBZPOV1b2xdt1b0eZImL/8Y7JTZSPNh0EuqCEqNQYCL3MVMVfeS
 XQSsbedvLfQZU3bg0fg==
X-Proofpoint-GUID: V0ZPR19-XzN3L-WMm0D2y6MuJ1tdwd0h
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab2301 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=h4Cnfs4T8kmjjV0gIG8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V0ZPR19-XzN3L-WMm0D2y6MuJ1tdwd0h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXyqNadFaCPyvL
 /UWGK36wZhXOwLZtEFjxZBpCOthrHkCh47P+JDAgs0cmMjP1RzjQE3PrcCOE2CpduswPgxAGicL
 qDJIiHwv59MVg3kPoowEbN8y8WtVZOs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> The interrupt subclass is often defined as a uint8, though in practice
> it will be within the range of just 0-7. Ensure that a guest-supplied
> subclass does not extend beyond its expected range, especially when
> used as an array index.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/s390x/css.c        | 7 ++++++-
>  hw/s390x/virtio-ccw.c | 6 ++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 76dbca3bb9..9da9128d88 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -654,8 +654,13 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>      S390FLICState *fs = s390_get_flic();
>      S390FLICStateClass *fsc = s390_get_flic_class(fs);
>      uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
> -    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];

I think this deserve a fixes/cc stable.  This would have been an
out-of-range access before this patch.

The initial support didn't have the concept of MAX_ISC, it showed up in

dde522bbc5 ("s390x: register I/O adapters per ISC during init")

Frankly I think at that point we should have started fencing
registration > MAX_ISC already, but that patch DID locally fence its new
array indexes against MAX_ISC.  It wasn't until

25a08b8ded ("s390x/css: update css_adapter_interrupt")

when the above array index was added without the fence that you are now
adding.  So I think 25a08b8ded is really the culprit.

> +    IoAdapter *adapter;
> +
> +    if (type >= CSS_IO_ADAPTER_TYPE_NUMS || isc > MAX_ISC) {
> +        return;
> +    }
>  
> +    adapter = channel_subsys.io_adapters[type][isc];
>      if (!adapter) {
>          return;
>      }
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 30fb2c0681..eb6378ea4c 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -46,6 +46,10 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
>      CcwDevice *ccw_dev = CCW_DEVICE(dev);
>      CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
>  
> +    if (dev->thinint_isc > MAX_ISC) {
> +        return -EINVAL;
> +    }

Is this safe to check before thinint_active?

I guess if we get here before an ISC was ever set it would just be
zero-initialized so it wouldn't erroneously trigger this check.

Assuming your reasoning matches mine:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> +
>      ccw_dev->sch->driver_data = dev;
>      if (ccw_dev->sch->thinint_active) {
>          dev->routes.adapter.adapter_id = css_get_adapter_id(
> @@ -659,6 +663,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>          } else {
>              if (ccw_dstream_read(&sch->cds, thinint)) {
>                  ret = -EFAULT;
> +            } else if (thinint.isc > MAX_ISC) {
> +                ret = -ENOSYS;
>              } else {
>                  thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
>                  thinint.summary_indicator =


