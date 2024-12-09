Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC96FE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKlZg-0002YG-GU; Mon, 09 Dec 2024 16:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKlZf-0002Y1-52; Mon, 09 Dec 2024 16:45:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKlZd-0002em-A2; Mon, 09 Dec 2024 16:45:50 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FXpu1026458;
 Mon, 9 Dec 2024 21:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ga+9vE
 t43GxvFKlEkTSgLDqUWitn8wOC6yZmFOUtjxM=; b=b329uJUFfzTF3h7eYioICD
 qdRCBoT3sw8ZwHsMQm6uIq2T4g/aZn70VZ6Pel92VW01TmI6GTbOzroVB6NjR+bM
 JIKvD9u+bjeiCzd5PPD7gzdHTuLcL6UgrNSOhPXY6Ey2CNMMrjbZ23Fp4jHV7Oji
 bYzgoG4FhWVnP2bOSwj7Wfhce1Pe+Z5DSrB9XNgq75gGfqFHzqqv/0yqTpYj0XCU
 igXT1B3O4IvhNbqd1FgqQelFBnVJVOfipDM0vJC+c/9oRM+JGQs4AuVds11JFYkq
 3jwlRuaWiRWEa67M4FepZyIQs2u0QoDtLY4+ZXINIzkShu0OwtVho27zvgAv98ag
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8kr8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 21:45:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KMDZW017381;
 Mon, 9 Dec 2024 21:45:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1g6f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 21:45:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9LjhAr25494108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 21:45:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D47958055;
 Mon,  9 Dec 2024 21:45:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F3BD5805B;
 Mon,  9 Dec 2024 21:45:42 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2024 21:45:41 +0000 (GMT)
Message-ID: <31b6b62b-4656-4ca0-a8ac-99fe4293de45@linux.ibm.com>
Date: Mon, 9 Dec 2024 16:45:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
 <f7451934-bf20-4c50-8780-4d5ebf932096@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <f7451934-bf20-4c50-8780-4d5ebf932096@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZPYJ-lgreZWDu4G76357_8EXAJ5mbugq
X-Proofpoint-ORIG-GUID: ZPYJ-lgreZWDu4G76357_8EXAJ5mbugq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090167
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 12/9/24 4:01 PM, David Hildenbrand wrote:
> On 09.12.24 20:29, Matthew Rosato wrote:
> 
> Hi,
> 
> Trying to wrap my head around that ... you mention that "pin the entirety of guest memory".
> 
> Do you mean that we will actually end up longterm pinning all guest RAM in the kernel, similar to what vfio ends up doing?

Yes.  Actually, the usecase here is specifically PCI passthrough via vfio-pci on s390.  Unlike other platforms, the default s390 approach only pins on-demand and doesn't longterm pin all guest RAM, which is nice from a memory footprint perspective but pays a price via all those guest-2 RPCIT instructions.  The goal here is now provide the optional alternative to longterm pin like other platforms. 

> 
> In that case, it would be incompatible with virtio-balloon (and without modifications with upcoming virtio-mem). Is there already a mechanism in place to handle that -- a call  to ram_block_discard_disable() -- or even a way to support coordinated discarding of RAM (e.g., virtio-mem + vfio)?

Good point, should be calling add ram_block_discard_disable(true) when set register + a corresponding (false) during deregister...  Will add for v2.

As for supporting coordinated discard, I was hoping to subsequently look at virtio-mem for this.

Thanks,
Matt

