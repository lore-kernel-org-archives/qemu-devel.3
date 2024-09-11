Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAF9EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPZx-0000BY-9m; Wed, 11 Sep 2024 11:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1soPZv-0008ME-9S; Wed, 11 Sep 2024 11:48:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1soPZs-0004zG-WA; Wed, 11 Sep 2024 11:48:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B9L3im019671;
 Wed, 11 Sep 2024 13:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=r
 IJMgRl37Fa1bdoPJ4aja9Zl/rby8/g1MowecIoN8u8=; b=kH9rEKqudvMAsSORA
 pKYHW0uiHhj7mM9x1PxG6IM8HAQzEVWrUXKVC6TOPupQ5zmJYNDjmGBhYq5PI7My
 SdcPpENDXFbkmtbll4Ic0yM3OR+p0F9GoAP6a5JsZPDUvc85lYyNo61THHAD9NmQ
 lL8k5hR1ljFzgAeeVEgbpD2qvLcF4WsaLKo/lFAusNO9flKUAHShoZKxAZYtn6No
 rhLcR8WMzX082TmhboWQGaOBKgM0pelfoQTNQB0SFUKu0tPYRsTn6SoniaqoGKKb
 ZDtVap3YwnKor+WT2Z3jJWMjiSKYenvCJeIvDRg3Y1yXiw/iQZt5IqDQpHYaV63i
 t0LhQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebae53y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 13:53:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48BDrRnB021880;
 Wed, 11 Sep 2024 13:53:27 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebae53v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 13:53:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48BDUsTh013449;
 Wed, 11 Sep 2024 13:53:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cm9ngm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 13:53:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48BDrO8t32178782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2024 13:53:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5F1258058;
 Wed, 11 Sep 2024 13:53:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B773358059;
 Wed, 11 Sep 2024 13:53:22 +0000 (GMT)
Received: from [9.61.185.100] (unknown [9.61.185.100])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Sep 2024 13:53:22 +0000 (GMT)
Message-ID: <8dbc553b-c3ae-4f11-accb-6dee10e9758e@linux.ibm.com>
Date: Wed, 11 Sep 2024 09:53:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 04/11] s390x/pci: Check for multifunction
 after device realization
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240823-reuse-v15-4-eddcb960e289@daynix.com>
 <2b5d2fce-8a1e-4f50-a5d2-0c4aaa2880af@redhat.com>
 <eaebda7d-c61e-4ed8-a6b9-98e5f48f26ff@daynix.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <eaebda7d-c61e-4ed8-a6b9-98e5f48f26ff@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2dtbRBJ4-pNDfZbj6oOW9AwuSzR-CVI8
X-Proofpoint-GUID: -IO35izHFxEeRbaogIc6oel1bUmOAg_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=930 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110098
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 9/11/24 6:58 AM, Akihiko Odaki wrote:
> On 2024/09/11 18:38, Cédric Le Goater wrote:
>> +Matthew +Eric
>>
>> Side note for the maintainers :
>>
>> Before this change, the igb device, which is multifunction, was working
>> fine under Linux.
>>
>> Was there a fix in Linux since :
>>
>>    57da367b9ec4 ("s390x/pci: forbid multifunction pci device")
>>    6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
>>
>> ?
The timing of those particular commits predates the linux s390 kernel support of multifunction/SR-IOV.  At that time it was simply not possible on s390.

>>
>> s390 PCI devices do not have extended capabilities, so the igb device
>> does not expose the SRIOV capability and only the PF is accessible but
>> it doesn't seem to be an issue. (Btw, CONFIG_PCI_IOV is set to y in the
>> default Linux config which is unexpected)

The linux config option makes sense because the s390 kernel now supports SR-IOV/multifunction.

> 
> Doesn't s390x really see extended capabilities? hw/s390x/s390-pci-inst.c has a call pci_config_size() and pci_host_config_write_common(), which means it is exposing the whole PCI Express configuration space. Why can't s390x use extended capabilities then?
> 

So, rather than poking around in config space, s390 (and thus the s390 kernel) has an extra layer of 'capabilities' that it generally relies on to determine device functionality called 'CLP'.  Basically, there are pieces of CLP that are not currently generated (or forwarded from the host in the case of passthrough) by QEMU that would be needed by the guest to recognize the SRIOV/multifunction capability of a device, despite what config space has in it.  I suspect this is exactly why only the PF was available to your igb device then (missing CLP info made the device appear to not have multifunction capability as far as the s390 guest is concerned - fwiw adding CLP emulation to enable that is on our todo list).

Sounds like the short-term solution here would be to continue allowing the PF without multifunction being visible to the guest (so as to not regress prior functionality) and then aim for proper support after with the necessary CLP pieces. 

Thanks,
Matt

