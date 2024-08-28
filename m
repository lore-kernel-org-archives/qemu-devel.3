Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A493C5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 08:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjDoU-0005UC-1O; Wed, 28 Aug 2024 04:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sjDoS-0005St-N8; Wed, 28 Aug 2024 04:13:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sjDoQ-0007tt-CV; Wed, 28 Aug 2024 04:13:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RM3BZe015468;
 Wed, 28 Aug 2024 08:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:mime-version:content-transfer-encoding:in-reply-to
 :references:subject:from:cc:to:date:message-id; s=pp1; bh=rgXg5F
 cN8H2xISESNhPmRk1dppp215brJ5LQqkEvcoY=; b=YQt1zK74P4SP3K2LCYchna
 BDNrQo1p0ApkEJpeZ4+OMV+Fq8fqlVLN7v58EbFHFyKK3MTnoR26573eCzSdlzcz
 ont4oPkuzcm/kx5VGbXGO5VZhKTX3cMRzhUOiUe3fV4zuHDixDc+spiLfNlFyZdd
 47tHfV7B8vsL1tRZCS9C9x5WH4yXvvEr5VPNHxBJ7250GSWsjEYaWTSmatS1EqdD
 A07zuJLgGv+VkrZBLsr7qlFE2P7DMU+sUhiel5Vm9tAnfjXys8okh8pjljXqdWkU
 ZNDv5nrJJd244WB9GZBBZaBmFk+xKDx0yDOkmWhV8ipTymu1G05OYn5bKE6VdLzg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8q1qx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Aug 2024 08:13:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47S8Dn3h021097;
 Wed, 28 Aug 2024 08:13:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8q1qwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Aug 2024 08:13:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47S6MjZn027950;
 Wed, 28 Aug 2024 08:13:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubn6gpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Aug 2024 08:13:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47S8Djgx49807860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2024 08:13:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3303D20065;
 Wed, 28 Aug 2024 08:13:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14BF220040;
 Wed, 28 Aug 2024 08:13:45 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.80.251])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Aug 2024 08:13:45 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <172467410002.31767.12365606864399178508@t14-nrb.local>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw,
 cpu to three-phase reset, and followup cleanup
From: Nico Boehr <nrb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2024 10:13:43 +0200
Message-ID: <172483282308.162301.11735420619446380771@t14-nrb.local>
User-Agent: alot/0.10
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aJDjJ2vp8jOyR29Z_7BBxJWXTXDkokbY
X-Proofpoint-ORIG-GUID: ZDLVOL5AD39Y3nInuRebjYj0eZN_1p8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280057
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nrb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Quoting Nico Boehr (2024-08-26 14:08:20)
> There was a little hickup without the fixup to patch 2, but after Nina
> pushed the fixup, we did not observe any failures related to your
> changes in our CI. Thanks!

Peter, after a few CI runs, we unfortunately did find some issues with your
patch :-(

Rebooting a guest in a loop sometimes fails. Michael was able to bisect it
to your series.

The problem is intermittent. The guest is unable to load its initramfs:

  [    0.560674] rootfs image is not initramfs (no cpio magic); looks like =
an initrd
  [    0.588605] Freeing initrd memory: 95680K
  [    0.593143] md: Waiting for all devices to be available before autodet=
ect
  [    0.593144] md: If you don't use raid, use raid=3Dnoautodetect
  [    0.593145] md: Autodetecting RAID arrays.
  [    0.593146] md: autorun ...
  [    0.593147] md: ... autorun DONE.
  [    0.593156] RAMDISK: gzip image found at block 0
  [    0.609110] RAMDISK: incomplete write (29120 !=3D 32768)
  [    0.609113] write error

...and then a panic because the kernel doesn't find a rootfs.

It seems like the compressed initramfs is corrupted somehow, since "rootfs
image is not initramfs" doesn't appear on a successful boot.

initramfs and kernel are loaded via direct kernel boot. Running under KVM.

Some vhost error messages do appear before the guest panics, but it is not
entirely clear to me whether they are related:

  [...]
  2024-08-28T06:56:29.765324Z qemu-system-s390x: vhost vring error in virtq=
ueue 0: Invalid argument (22)
  2024-08-28T06:56:32.210982Z qemu-system-s390x: vhost vring error in virtq=
ueue 0: Invalid argument (22)
  2024-08-28 06:56:35.430+0000: panic s390: core=3D'0' psw-mask=3D'0x000200=
0180000000' psw-addr=3D'0x00000387b028c67e' reason=3D'disabled-wait'

Any idea?

