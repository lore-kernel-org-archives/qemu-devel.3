Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99953D1356B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 03:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5G87-0003vC-2F; Sun, 27 Oct 2024 23:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1t5G84-0003ug-DI; Sun, 27 Oct 2024 23:09:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1t5G82-0004to-IJ; Sun, 27 Oct 2024 23:09:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RKtdPT018534;
 Mon, 28 Oct 2024 03:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7bFrF9
 gKIieUhdsqnr20xbKFX+L8hxaUoKZhLAzSUU8=; b=A3xoYPi5lgGQizAOHjUyXk
 +yrcUzK+/Mk2lWFbjvd4L+9Mhb5jxaIJO4rINhm5uXoxmh0keJjZp6qWrQ85S8S5
 zfeUs57imjAMIUeUrpyaPsYyjLIOy9PjHtr0hAD6PwPKmGCGQdUAuvNUOL4m4RjP
 Z/jtKh//qFozgNTYcoudgr7Gy121KeUDu27MDJ17iH76o7D1eWZqodVNnYDpbdnQ
 7XBl45zdT9pr9752FdTXHHJ8HT5jfeSPk+KrLraCBkJDRvnnrpjpsOrgp2Ti/s3N
 iwLj57GQHWr8bXhdjuhJhNs22ef8mumD6KTEfYiN3u65q3eCOPzNzq6H/sBnXuTQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grwaxwc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Oct 2024 03:09:00 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49S390Ah010853;
 Mon, 28 Oct 2024 03:09:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grwaxwby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Oct 2024 03:09:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49S2BMwB017386;
 Mon, 28 Oct 2024 03:08:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hars4hgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Oct 2024 03:08:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49S38tFC22872378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Oct 2024 03:08:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E61520043;
 Mon, 28 Oct 2024 03:08:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF0EA20040;
 Mon, 28 Oct 2024 03:08:51 +0000 (GMT)
Received: from [9.124.208.76] (unknown [9.124.208.76])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Oct 2024 03:08:51 +0000 (GMT)
Message-ID: <50194bd5-cef8-484c-b8c3-bd616414f280@linux.ibm.com>
Date: Mon, 28 Oct 2024 08:38:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/14] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
 <20241022-reuse-v17-2-bd7c133237e4@daynix.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20241022-reuse-v17-2-bd7c133237e4@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 28yY9JMasl_lSJLl6x0WBkyyUiakbFB0
X-Proofpoint-ORIG-GUID: bpzg_EWBO5w7FdIqhL5ngyT0vgPjOO9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


On 10/22/24 2:06 PM, Akihiko Odaki wrote:
> Disabled means it is a disabled SR-IOV VF and hidden from the guest.
> Do not create DT when starting the system and also keep the disabled PCI
> device not linked to DRC, which generates DT in case of hotplug.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/ppc/spapr_pci.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5c0024bef9c4..679a22fe4e79 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1291,8 +1291,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
>       PciWalkFdt *p = opaque;
>       int err;
>   
> -    if (p->err) {
> -        /* Something's already broken, don't keep going */
> +    if (p->err || !pdev->enabled) {
>           return;
>       }
>   
> @@ -1592,10 +1591,10 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
>       uint32_t slotnr = PCI_SLOT(pdev->devfn);
>   
>       /*
> -     * If DR is disabled we don't need to do anything in the case of
> -     * hotplug or coldplug callbacks.
> +     * If DR or the PCI device is disabled we don't need to do anything
> +     * in the case of hotplug or coldplug callbacks.
>        */
> -    if (!phb->dr_enabled) {
> +    if (!phb->dr_enabled || !pdev->enabled) {
>           return;
>       }

Thank you. This is the right place to be called from the hotplug handler

instead of the spapr_pci_dt_populate() unlike I mentioned before..


>   
> @@ -1680,6 +1679,11 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>       }
>   
>       g_assert(drc);
> +
> +    if (!drc->dev) {
> +        return;

I agree with the change here, but were you able to get to this path? I 
don't see

  this if condition being entered with,

qemu-system-ppc64 -nographic  -serial none -device 
spapr-pci-host-bridge,index=4,id=pci.1  -device igb,id=igb0 <<< 
'device_del igb0'


Regards,

Shivaprasad

> +    }
> +
>       g_assert(drc->dev == plugged_dev);
>   
>       if (!spapr_drc_unplug_requested(drc)) {
>

