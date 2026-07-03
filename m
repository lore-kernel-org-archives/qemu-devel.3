Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EC6C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVxs-0006ZD-CA; Fri, 03 Jul 2026 00:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVxq-0006Z5-CF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:57:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVxo-00066I-JW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:57:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631KBXP1154150; Fri, 3 Jul 2026 04:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pvXRQF
 qJTx3uV3v+F0jCSZTM4Lq3DCkgRpBonzInjns=; b=N/rvLl4EwRvSfoc/R06x9w
 373E9Gl6AwXMqQt0fmyoP322Bp8OIXWF5fxpUKdjS7f8/qfU5DXsWC2GwZdmMwjq
 Z8PkKktlSIpw5UvQMZAQkAZKnnseM7l4Dujo7tLw09RGuup0Kf/Pj6jt803aS2vP
 aLwOuO6XE8q3i4SPqyxtVElOVaglbzL0VtqRVvt3hQsOgcR/w5o92clQ7UXx76st
 AQUXNEIjCNAhHX6qZ8JDqsqhSZIsdf5rl2Q8ec2h27/JYnMdbhhW8FTFLoTpBTqm
 wLyatz/Hxa5eP+YJfEg++MIZBISt+g0UH7th+P3wsZDlkxQ7ZFHBehV686ksFuPg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk50vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 04:57:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634najk017762;
 Fri, 3 Jul 2026 04:57:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhq6p4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 04:57:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634vHH613697742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 04:57:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D4865804E;
 Fri,  3 Jul 2026 04:57:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 840045803F;
 Fri,  3 Jul 2026 04:57:15 +0000 (GMT)
Received: from [9.39.22.184] (unknown [9.39.22.184])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 04:57:15 +0000 (GMT)
Message-ID: <26a359fb-d9ff-489a-9ee2-d529bbffa06a@linux.ibm.com>
Date: Fri, 3 Jul 2026 10:27:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] ppc queue
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: stefanha@gmail.com, stefanha@redhat.com, qemu-devel@nongnu.org
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0MiBTYWx0ZWRfX2j4SxSOkkcZq
 7hk2yB0fmzGQ2OF2u9eM6USJB9oJHF2k9SIkvDWtwdGDNYlk4pEFchwjJuqRvuRGfpo6uXXmIev
 fcFwfo/bsxa5Vxxr+7u7oDUovAMT7iRYinZAOLKXsFivOI+awtEnGfw1P/8PnP3eiYI8iii/Qh1
 sYoX06WWoI8FowRK5uSfKbjKxtzpr3zpbqc9WgO3jq1Hzg4N03oLEpSeF+X8PukaLb6NFe7tlpr
 QRw/4tAH6A1VQrD+lxvaKVxoHkMIXa/oEHB/bGCtF+TaK8/vwLwGHmPpS1zk8l6KrU+6WQ7VdXm
 UkHbrIpLsv38jtA6T5O2+gDnfQuoWH3fRNPnpmBrARLZOtDSABn/DkF/7fA6arepSO6qyJuHMDK
 jVvMy/pbqUE72Taekbe3GhEnVjm8zGZrXtPEMr/hYXB5dQy5HFWwCDWs0RIEDRWD759K6M+YaBu
 X39mHOgKiTpS75qH0Yw==
X-Proofpoint-GUID: 6qBGfgK8uzdLbDBTYaqdh402nXwaZ3dC
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a47412f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=p0WdMEafAAAA:8 a=-8Pt_qz3z5BCa7tSkTIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0MiBTYWx0ZWRfX9SEAXjcMSIXY
 HP/W+OcZ7H75RjK/cHzwFvyf3wY5T1A4hiRti8NRS2f32iPNHk+YruwmSke+ERieFRp9NVXQrR7
 7sXFJj8prKkJz6SMlelP2pqDOK+NYIk=
X-Proofpoint-ORIG-GUID: 1H855KIWF53q0HbAR0f4UAGHH_EtApU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Stefan,

I had ran the gitlab CI here:
https://gitlab.com/harshpb/qemu/-/pipelines/2646372305

Checkpatch error for line length exceeding can be ignored.
Other failure (migration-compat-aarch64) seems to exist in baseline.

Thanks
Harsh

On 03/07/26 10:13 am, Harsh Prateek Bora wrote:
> The following changes since commit b4bdad7dcef623d2874df4e79e0be01075096c3b:
> 
>    Merge tag 'dump-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-07-02 16:04:08 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.1-misc-20260703
> 
> for you to fetch changes up to f9d05801eb4acd6402d73cb25d498a2419920cf9:
> 
>    ppc/pnv: add test to verify external DTB is honored (2026-07-03 10:07:21 +0530)
> 
> ----------------------------------------------------------------
> PPC queue for 2026-07-03
> * SLOF FW update to 20260627
> * ppc/pnv: external dtb fix and test addition
> * PHB code refactor for better maintainability
> * Revert deprecation of 405 CPUs
> * target/ppc: Expose TB offset of guest in Qemu monitor
> 
> -----BEGIN PGP SIGNATURE-----
> 
> iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmpHPNAACgkQRUTplPnW
> j7tkjQ/9FP3/sTw0MxhGdLItxurrEzu3f4jiDKpnjEIqiJInzYl/2fJKZU611PSp
> gydfdNhkr71TxuJggibAosEblcWRq9KqQXysDpNrJ8rqEIeLj0lv9/JigLTZqU3e
> vsfDmfdCAB7YTtpm6HkTYW81EPD0X8AwQqz4FCNDQ0zeNUBIU8IU/ARP2j80CTnm
> 5xRK42aZb9CMYYIk3p8l4FuZmv6Y0Jf0daXM4WsEdHu9KjGvYr1glTY/lgblNPug
> kWIcjPqQ6x/hloYqxTTcsfJBnKfdaVppuh6LbJbgISsQIBzTqrD2HvEIpNFJRKnS
> 1XGwLj6cMmm4u2tv3BF0yVDJCEff312n2VFskmOrCUJOR+g2UqDzMb4+7JOpufEn
> Fla38+a9H9ThdnUNaak8+KquHDOJzDAOugOdMvsID8KlJ/q3wrTTEUUImj5Bwyqz
> Gc7naNx+3D+BSiahDe4LP71ZFLrQJ/eYCj71for5xZNcZVOQ6IDhymEMUAcRzkt6
> 2qICF6XmkYfuH+1113KMxG65NpKGEvktONQ6UpLWTubQ++BNK1Bt2v8PAWSis/d8
> EYg5M/R7RqhbxufIUDLXJIuxB3xuiVg+e+x/M8X0LffmYhPI1cuZPmth4/75IKL+
> 9Vddgc1hSHX1EUjRyZpoK6WArOTNvUOZMEcAhGr/0NgK5O/1Z10=
> =1TRv
> -----END PGP SIGNATURE-----
> 
> ----------------------------------------------------------------
> Gautam Menghani (1):
>        target/ppc: Expose the TB offset of the guest in QEMU monitor
> 
> Glenn Miles (1):
>        Revert "hw/ppc: Deprecate 405 CPUs"
> 
> Jishnu Warrier (1):
>        hw/pci-host: Split PowerNV PHB5 code from PHB4 files
> 
> Shivang Upadhyay (2):
>        ppc/pnv: avoid regenerating DTB if external DTB is present
>        ppc/pnv: add test to verify external DTB is honored
> 
> Thomas Huth (2):
>        pseries: Update SLOF firmware image to release 20260627
>        docs/system/ppc/pseries: Update the link to the SLOF repository
> 
>   docs/about/deprecated.rst              |   9 ----
>   docs/system/ppc/pseries.rst            |   2 +-
>   target/ppc/cpu.h                       |   1 +
>   hw/pci-host/pnv_phb4.c                 |   6 ---
>   hw/pci-host/pnv_phb4_pec.c             |  58 -------------------------
>   hw/pci-host/pnv_phb5.c                 |  23 ++++++++++
>   hw/pci-host/pnv_phb5_pec.c             |  77 +++++++++++++++++++++++++++++++++
>   hw/ppc/pnv.c                           |  10 +++--
>   hw/ppc/ppc.c                           |   5 +++
>   target/ppc/cpu_init.c                  |   5 ++-
>   hw/pci-host/meson.build                |   2 +
>   pc-bios/README                         |   2 +-
>   pc-bios/slof.bin                       | Bin 994176 -> 997576 bytes
>   roms/SLOF                              |   2 +-
>   tests/functional/ppc64/test_powernv.py |  19 ++++++++
>   15 files changed, 140 insertions(+), 81 deletions(-)
>   create mode 100644 hw/pci-host/pnv_phb5.c
>   create mode 100644 hw/pci-host/pnv_phb5_pec.c
> 


