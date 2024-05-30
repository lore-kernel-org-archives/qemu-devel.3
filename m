Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54ECC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 08:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCb5G-00065Y-SE; Thu, 30 May 2024 04:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sCb5E-000655-9Q; Thu, 30 May 2024 04:24:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sCb5B-0002Lt-GB; Thu, 30 May 2024 04:24:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U8GQsZ004674; Thu, 30 May 2024 08:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=Qp7tZQjOP0Ww27yQSBp+kDB/mFWY/v+7txYF8oBGDIg=;
 b=RQBw8mWU0BtwnmqHM1AV6PtSN2ItrlDMxOb38sCpJvIb1dqOH4C0cX5giEq5FYVhlZqC
 /VuXtatMUhzfgb78f38/yWXSIRu77H4QxRXB39W4SRo272NoECNMQL6PJ8mqcRd5mPLf
 8jKXnq91D9+bAMEsyGjHlyuWmoxEuA2BPsl0CGBlL7I2OrDnd9jKSEFR8QZoIZcaZISa
 /NR4o3qUcZAW6hB3DDjZ/Q+gwjs9bPV3CgwpjSV6L9hlGr62T2qK1fu/7nopPijBn57L
 0rozOUX0S6ZTLqyN3+I4jv2dgedDWq5en3N7mhoArXMnePrmaemOSUhmUpKaRTbLOqad pA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yencj8335-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 08:24:04 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U8O4Gs018930;
 Thu, 30 May 2024 08:24:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yencj8334-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 08:24:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U8JwhQ028984; Thu, 30 May 2024 08:24:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpayrva2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 08:24:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44U8O0rN61079954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 08:24:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C90EC58055;
 Thu, 30 May 2024 08:24:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B697B58043;
 Thu, 30 May 2024 08:23:55 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 May 2024 08:23:55 +0000 (GMT)
Message-ID: <eab97e90-de43-4253-8198-32ea5c4285ac@linux.ibm.com>
Date: Thu, 30 May 2024 13:53:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/acpi: Remove the deprecated QAPI MEM_UNPLUG_ERROR
 event
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Greg Kurz <groug@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240530071548.20074-1-philmd@linaro.org>
 <20240530071548.20074-2-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240530071548.20074-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gOGNIkn2jiur6jFvKHMmSARMEKRFTkVq
X-Proofpoint-ORIG-GUID: H2ebZ4cohcG2YBAIIb7-nbqjBn23jB5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=734
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 5/30/24 12:45, Philippe Mathieu-Daudé wrote:
> The MEM_UNPLUG_ERROR event is deprecated since commit d43f1670c7
> ("qapi/qdev.json: add DEVICE_UNPLUG_GUEST_ERROR QAPI event"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       |  5 -----
>   docs/about/removed-features.rst |  9 +++++++++
>   qapi/machine.json               | 28 ----------------------------
>   hw/acpi/memory_hotplug.c        |  8 --------
>   hw/ppc/spapr.c                  | 11 +----------
>   5 files changed, 10 insertions(+), 51 deletions(-)
> 

For spapr:
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 40585ca7d5..4a61894db6 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -151,11 +151,6 @@ property types.
>   QEMU Machine Protocol (QMP) events
>   ----------------------------------
>   
> -``MEM_UNPLUG_ERROR`` (since 6.2)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -Use the more generic event ``DEVICE_UNPLUG_GUEST_ERROR`` instead.
> -
>   ``vcpu`` trace events (since 8.1)
>   '''''''''''''''''''''''''''''''''
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index fba0cfb0b0..f1e70263e2 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -671,6 +671,15 @@ Use ``multifd-channels`` instead.
>   
>   Use ``multifd-compression`` instead.
>   
> +QEMU Machine Protocol (QMP) events
> +----------------------------------
> +
> +``MEM_UNPLUG_ERROR`` (removed in 9.1)
> +'''''''''''''''''''''''''''''''''''''
> +
> +MEM_UNPLUG_ERROR has been replaced by the more generic ``DEVICE_UNPLUG_GUEST_ERROR`` event.
> +
> +
>   Human Monitor Protocol (HMP) commands
>   -------------------------------------
>   
> diff --git a/qapi/machine.json b/qapi/machine.json
> index bce6e1bbc4..453feb9347 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1607,34 +1607,6 @@
>   { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
>     'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }
>   
> -##
> -# @MEM_UNPLUG_ERROR:
> -#
> -# Emitted when memory hot unplug error occurs.
> -#
> -# @device: device name
> -#
> -# @msg: Informative message
> -#
> -# Features:
> -#
> -# @deprecated: This event is deprecated.  Use
> -#     @DEVICE_UNPLUG_GUEST_ERROR instead.
> -#
> -# Since: 2.4
> -#
> -# Example:
> -#
> -#     <- { "event": "MEM_UNPLUG_ERROR",
> -#          "data": { "device": "dimm1",
> -#                    "msg": "acpi: device unplug for unsupported device"
> -#          },
> -#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
> -##
> -{ 'event': 'MEM_UNPLUG_ERROR',
> -  'data': { 'device': 'str', 'msg': 'str' },
> -  'features': ['deprecated'] }
> -
>   ##
>   # @BootConfiguration:
>   #
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index de6f974ebb..9b974b7274 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -178,14 +178,6 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
>               hotplug_handler_unplug(hotplug_ctrl, dev, &local_err);
>               if (local_err) {
>                   trace_mhp_acpi_pc_dimm_delete_failed(mem_st->selector);
> -
> -                /*
> -                 * Send both MEM_UNPLUG_ERROR and DEVICE_UNPLUG_GUEST_ERROR
> -                 * while the deprecation of MEM_UNPLUG_ERROR is
> -                 * pending.
> -                 */
> -                qapi_event_send_mem_unplug_error(dev->id ? : "",
> -                                                 error_get_pretty(local_err));
>                   qapi_event_send_device_unplug_guest_error(dev->id,
>                                                             dev->canonical_path);
>                   error_free(local_err);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4345764bce..81a187f126 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3786,7 +3786,6 @@ void spapr_memory_unplug_rollback(SpaprMachineState *spapr, DeviceState *dev)
>       SpaprDrc *drc;
>       uint32_t nr_lmbs;
>       uint64_t size, addr_start, addr;
> -    g_autofree char *qapi_error = NULL;
>       int i;
>   
>       if (!dev) {
> @@ -3823,16 +3822,8 @@ void spapr_memory_unplug_rollback(SpaprMachineState *spapr, DeviceState *dev)
>   
>       /*
>        * Tell QAPI that something happened and the memory
> -     * hotunplug wasn't successful. Keep sending
> -     * MEM_UNPLUG_ERROR even while sending
> -     * DEVICE_UNPLUG_GUEST_ERROR until the deprecation of
> -     * MEM_UNPLUG_ERROR is due.
> +     * hotunplug wasn't successful.
>        */
> -    qapi_error = g_strdup_printf("Memory hotunplug rejected by the guest "
> -                                 "for device %s", dev->id);
> -
> -    qapi_event_send_mem_unplug_error(dev->id ? : "", qapi_error);
> -
>       qapi_event_send_device_unplug_guest_error(dev->id,
>                                                 dev->canonical_path);
>   }

