Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D33CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBe1Y-0000Zb-7g; Wed, 22 Oct 2025 14:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBe1V-0000ZP-8X; Wed, 22 Oct 2025 14:57:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBe1R-0005OT-CF; Wed, 22 Oct 2025 14:57:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBUhT1002476;
 Wed, 22 Oct 2025 18:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7s098h
 T4cF5qy+Q+JlitlQN/87EM12eIWaKEZ6yYKrA=; b=G7e0thPRR1gfl8iBE2nknA
 0AOtpeNgjqMd74EB18rc0XuMlPZA0Xwp0uBJMkosfb/vurcKMPwIkCRWWPdF3Ujc
 y6DaONrBScbf80/spmQ7qmtqtFRS9J4bCACuhOe9fKVz3/NVwmnvjDg00qFpLuXQ
 n8NYz9O4/8STgBOPnyhUiSbu5WQQpRhBSjFM3KqKqKGNvEFc57Wty7pj8C8zt4PI
 ZG1Q6FU1cuu+G3zzoqbhIm32jgpUfESef5nogIYIXtG5rkK5biekLUo2NwAaPkTM
 JKp+ZNTGQNEu8VZeGL1pj1zx6tjIZgX0LnSSieN/7TvyOlSFonpaWyK/lpM5t9yQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vw2sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 18:57:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MGxx8M014676;
 Wed, 22 Oct 2025 18:57:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sa7kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 18:57:13 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MIvCCj22741754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 18:57:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B4CB58059;
 Wed, 22 Oct 2025 18:57:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFD5958062;
 Wed, 22 Oct 2025 18:57:11 +0000 (GMT)
Received: from [9.61.130.101] (unknown [9.61.130.101])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Oct 2025 18:57:11 +0000 (GMT)
Message-ID: <dfdbb980-93b6-4356-a407-e4c5d155c964@linux.ibm.com>
Date: Wed, 22 Oct 2025 14:57:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-6-jrossi@linux.ibm.com>
 <bb66b492-38e5-419d-ba9c-6fe017460bb0@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <bb66b492-38e5-419d-ba9c-6fe017460bb0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JuVxVwthhS19W8bjUbnMgOWwu6_vwm9J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXygOsLVrv7XQ0
 C9azO5ZVlWNyIjUtkzw0KddQkrb+j00Hyz/lXS4CtdI1KaM3ZmcPMn2dKkfmQBoQx++nZvrZrGI
 O/r35MmReZ8Kx85GMr4Z0BlA7ZTuogFEkPgulD1PJPKt0s9e/5yQzODAH7ERcutybXG4cwbVZdx
 fIr1HZwGY0OEBVJCtWykrD/D2ad+ik5VHnqFhJRjVa4ke7bDiTm81/oYEg9qpD7b4OAHrSTJQ0q
 xTIjBXzRNOVjlOxTrSSCPWQwgz5Vhk4h/G/o/aa0jUmRVyGTRycRGkV5V84leHHal+CDqqfJzFM
 j+AJFH/74Rvee6qEjbO/hKKjUB9Jk77HLhqqLardqfP6De+LTz7oEyK6qZFcMNUWiojjDDy9+js
 FRMVenf+JHpmIilBkXj/bcHggVIjKQ==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f9290a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zyrXiSxKzjXuiyie_RIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JuVxVwthhS19W8bjUbnMgOWwu6_vwm9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 10/22/25 12:40 PM, Zhuoying Cai wrote:
> [snip...]
>
> +/*
> + * Read PCI configuration space to find the offset of the Common, Device, and
> + * Notification memory regions within the modern memory space.
> + * Returns 0 if success, 1 if a capability could not be located, or a
> + * negative RC if the configuration read failed.
> + */
> +static int virtio_pci_read_pci_cap_config(VDev *vdev)
> +{
> +    uint8_t pos;
> +    uint64_t data;
> +
> +    /* Common cabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_COMMON_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI common configuration");
> +        return 1;
> +    }
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
> +        return -EIO;
> +    }
> +    common_offset = bswap32(data);
> +
> +    /* Device cabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_DEVICE_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI device configuration");
> +        return 1;
> +    }
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
> +        return -EIO;
> +    }
> +    device_offset = bswap32(data);
> +
> +    /* Notification cabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_NOTIFY_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI notification configuration");
> +        return 1;
> +    }
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
> +        return -EIO;
> +    }
> +    notify_offset = bswap32(data);
> +
> +    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_NOTIFY_CAP_MULT, 15, &data, 4)) {
> +        return -EIO;
> +    }
> Could you please explain why we use
> pci_read(vdev->pci_fh, pos + VIRTIO_PCI_NOTIFY_CAP_MULT, 15, &data, 4)
> instead of
> pci_read(vdev->pci_fh, notify_offset + VIRTIO_PCI_NOTIFY_CAP_MULT, 4,
> &data, 4) here?
The notification capability in particular has an extra field at the end, 
which is what we are looking for.  We are still in PCI configuration 
space (BAR 15), we just want to read some different bytes in the 
notification capability configuration.
>> +    notify_mult = bswap32(data);
>> +
>> +    if (pci_read(vdev->pci_fh, device_offset + VPCI_C_OFFSET_Q_NOFF, 4, &data, 2)) {
>> +        return -EIO;
>> +    }
> Should queue_notify_off be read using pci_read(vdev->pci_fh,
> common_offset + VPCI_C_OFFSET_Q_NOFF, 4, &data, 2)?
> (Virtio specs v-1.3 section 4.1.4.3 Common configuration structure layout)
I think you are correct.  This is a mistake.  The queue notification 
offset is in the common configuration, not the device configuration.  I 
suspect it didn't cause a problem here because virtio-blk uses only one 
queue.

>
>> +long virtio_pci_notify(uint32_t fhandle, int vq_id)
>> +{
>> +    uint64_t notice = 1;
>> +    uint32_t offset = notify_offset + vq_id * q_notify_offset;
> Shoud the offset be calculated as notify_offset + q_notify_offset *
> notify_mult?
> (Virtio specs v-1.3 section 4.1.4.4 Notification structure layout)
I'll double check this, but you are probably right.  As with the 
previous instance it didn't cause a problem due to there only being one 
queue for virtio-blk, so the offset is always just the base 
notify_offset and, luckily, the incorrect parts get multiplied by zero.

>
>> +
>> +    return pci_write(fhandle, offset, notice, 4);
> Please correct me if I'm wrong - instead of always writing notice = 1,
> should we write vq_id to vq_index of the Queue Notify address.
> (Virtio specs v-1.3 section 4.1.5.2 Available Buffer Notifications)
I'll double and triple check the queue offset/notification calculations 
since it seems there are multiple errors on my part and I just got lucky 
that virtio-blk wasn't affected.  Thanks for catching these mistakes.

Regards,
Jared Rossi


