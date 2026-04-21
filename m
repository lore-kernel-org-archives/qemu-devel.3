Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00230F94CB5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJgV-0005hF-7V; Tue, 21 Apr 2026 18:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1wFJgU-0005go-67; Tue, 21 Apr 2026 18:35:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1wFJgS-0001rF-Fl; Tue, 21 Apr 2026 18:35:09 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIlvZP589988; Tue, 21 Apr 2026 22:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yfrSBK
 LUAzMxxkL+e0JyLet6aWl4YXxQ2/v/i0EIlr8=; b=KKI8h3EaV447A+cOHhAd38
 ctE8XoGuWsb0Ju1Zg5+8AL/peynvJ5iSSMBqy7NfQx/L+9aO4xQueQ13+/7pJYCo
 kW0mbncRE8I6Lw/BfNilV+sQWI8LpfL+Pqx+GrtwfUaXFh923bJBKXLyDLZhTWHU
 BwtzHl3UHzuKvEnxkQGk25BHoNcwA2gUp1DA01CryQYjy+f0zylj0OCIokZrQC9O
 uDbc7eCPY9jPERmerFy/v8IOr554WUhKE/ot7rMiNRKZ5DVvoltcoAEsvcaruMwj
 70m0tHDQvS6nzektyVdw05lhuRnm+fW8Pn65XM0HaPfjyiGT8BAQRpxTw0vqiL8w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu20pue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 22:35:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LMKHov023846;
 Tue, 21 Apr 2026 22:35:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy2c3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 22:35:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LMYwFG52101624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 22:34:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12C2220040;
 Tue, 21 Apr 2026 22:34:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 523872004B;
 Tue, 21 Apr 2026 22:34:57 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.29.83])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 21 Apr 2026 22:34:57 +0000 (GMT)
Date: Wed, 22 Apr 2026 00:34:55 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, cohuck@redhat.com,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] hw/s390x/ccw: Disable legacy virtio-pci by
 default (v11.1+)
Message-ID: <20260422003455.2bf4843c.pasic@linux.ibm.com>
In-Reply-To: <20260420144759.2970726-2-jhkim@linux.ibm.com>
References: <20260420144759.2970726-1-jhkim@linux.ibm.com>
 <20260420144759.2970726-2-jhkim@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lECoZM_kFNmW81io9xdo_ho1V-NEv95Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIyMiBTYWx0ZWRfX5kg6GG4oQHtG
 wb5RQL7wLX+J4e6RKAJ/7L3q/FkCeX2l91eiWtpEQaHZJYD5scrPyH2jkcysioVkZztpHByby8M
 86afbVX0obpAtPVFE/JQCL6Igc8BSKZBBlhmsqbAe/ZVH9swkuOWshIM3UiVdqh7aDRhiZnVBhQ
 2qsLMDOfD8Idephmgd0mrEhMXed/qiw/DdkQTLjxSreeWGmPTtS18KPrnLZpEHTlH8lq+5WLmVi
 K/vSqRIkkpOaCR7YVr0VJEasXVznXyycLJF+5zSf2Cz1c6TGMj11Gh9rOPE1dYSgYNTMwFENxLE
 O4KPEeCuJO6pAmpc/qM8ZXc2f2od9bd+93AqqjzWq6sdCWCxRQtHFfu9SfQXrYBaeOZ9mwLKDqi
 rzjUY8SG/ENPQ7w80OOxsTD/e1tk6oHopc3xEW7UmDDqRSlTCQQfZJVZUJWbhY8nVyUj3mXIYm/
 9PjU4C6AZ3GifLzPyhw==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69e7fb96 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Zmn2g17VIuUsORQIRS0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: lECoZM_kFNmW81io9xdo_ho1V-NEv95Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604210222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 20 Apr 2026 09:47:34 -0500
Jaehoon Kim <jhkim@linux.ibm.com> wrote:

> On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
> zPCI implementation (commit cd24834130ac "s390/pci: base support"),
> making I/O BARs unusable.
> 
> However, when virtio-pci devices operate in transitional mode, QEMU
> unconditionally exposes the legacy interface via BAR0. This results in
> firmware warnings during PCI enumeration, such as:
> 
>   pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
> 
> even though BAR0 is never usable on the s390 kernel.
> 
> Close this gap by disabling legacy virtio-pci support starting from
> machine version 11.1. This effectively makes virtio-pci devices
> non-transitional and prevents the creation of the unusable legacy I/O
> BAR.
> 
> This introduces s390x-specific global compatibility properties that
> set disable-legacy=on as the default for virtio-pci devices. Machine
> versions v11.0 and earlier set disable-legacy=off to maintain their
> original default behavior (legacy support enabled), ensuring VMs
> created with those versions continue to work identically.
> 
> Users can override the default on the command line if needed:
>   - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
>   - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)
> 
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

