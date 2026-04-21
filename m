Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA25F8FA86
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFCBj-0001wC-JQ; Tue, 21 Apr 2026 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wFCBY-0001vU-B7; Tue, 21 Apr 2026 10:34:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wFCBW-0002Lo-GI; Tue, 21 Apr 2026 10:34:44 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LD2LOl1536016; Tue, 21 Apr 2026 14:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XArjLV
 7gjT1cjedCwgeHPOEiwvhHApj3QnA5kZF+Ja0=; b=Il1Y71ors9LOTACjnq+jkF
 TbZXD0necyNiG3DrN+un3jy/4aIU4YHKxA0WR0ib4UT0wRTg7/lNFnh6OvwSPhM9
 X0z7H7j687J8D/GEz4VcK6X+NM4E5m2uFothFlXSBXiurWrLCVWMBpr9jXe6XHdo
 5ATTve5YQDONJ/D9oDxLJYoH2nVYGgocCdR2gpAXqO7H6YByJtmvf/b0JAZIGq+Z
 dgdzfr2XhLIPzT5n3Ps+2Xjb7jIOfuK2CMcCWbzVtIS3Xj9jpV6HWyPvPbjx6FDD
 gZzGFOLHYHgv+zpNt1/4otjUlzix0ZMIMRN0vzirJCtGnHPij3Fy8vUCukzRRkTg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6m10p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 14:34:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LE5REr029078;
 Tue, 21 Apr 2026 14:34:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsh105k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 14:34:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LEYXMf29295172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 14:34:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BD2858053;
 Tue, 21 Apr 2026 14:34:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D65B15805F;
 Tue, 21 Apr 2026 14:34:32 +0000 (GMT)
Received: from [9.61.242.89] (unknown [9.61.242.89])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 14:34:32 +0000 (GMT)
Message-ID: <20d42d8e-ecfa-4423-a7b0-cd6a5a73c82f@linux.ibm.com>
Date: Tue, 21 Apr 2026 09:34:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] improve aio-polling efficiency
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de,
 mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260412215011.326196-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260412215011.326196-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e78afb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ISBhqxNU6I523Yclo0sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0MyBTYWx0ZWRfX5I2gVeiIm//q
 Kme1CawMelCTVRV4YF2tuXOs3pOzVckt9E4rf89otYq2k2HtSy80Ob29WWW0+xOmRpd//RR/Zu1
 g4lWGpvKRQJtsBdi2Hh23kgfH0xy6nyU4uB9NRogfl6Lp9fj3/TP1Jvc0woBEuw1axP26/i6Pbr
 GNl+jXx5HGOJptGNUujLOT98xU5mOaL/5iud+2Ip3rUuFVWIybLMWxRRW3r7HozMbYyVf2dM8Yh
 zke4QgJyLvpX+rkL2N9SKIHecY/5akWJFQqLT6aapPFybI4yshAhQvsUK92DxSXjGCzL0UMmPvw
 9sLh4nJ+dL4SPdZueeC4eQt6O1GS+TJytIz5mJhJV2QRKgEG4/cGN9gKm849AqWKvHj54AeXYPB
 vlO+YLFOt/SOjh6VoiiKDkaVVOln4BtPIoElo95b/2jWU4Xq6MlYCCPl0ijPfUQKdX3K2lvLaWl
 CltaLsAScT4O4xtfgUw==
X-Proofpoint-GUID: C24OPu2yoSuKGIIfHBOS_OccUJIu2SW_
X-Proofpoint-ORIG-GUID: C24OPu2yoSuKGIIfHBOS_OccUJIu2SW_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210143
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Dear all,

Just a follow-up on this v4 series. I've updated the patches to address 
previous review feedback,particularly in Patch 2.
Please let me know if you have any further comments or concerns.

Thanks,
Jaehoon


On 4/12/2026 4:50 PM, Jaehoon Kim wrote:
> Dear all,
>
> This is v4 of the patch series to refine aio_poll adaptive polling
> logic for better CPU efficiency.
>
> v1: https://lore.kernel.org/qemu-devel/20260113174824.464720-1-jhkim@linux.ibm.com/
> v2: https://lore.kernel.org/qemu-devel/20260323135451.579655-1-jhkim@linux.ibm.com/
> v3: https://lore.kernel.org/qemu-devel/20260405200735.3075407-1-jhkim@linux.ibm.com/
>
> Changes in v4:
> - Patch 2/3: Added detailed validation tables showing poll.ns statistics
>    across different poll_weight values (1-5) for SSD randread/randwrite
>    workloads to demonstrate algorithm behavior and justify poll_weight=3
>    as the optimal default.
>
> - Patch 3/3: Fixed commit message to correctly reference
>    adjust_polling_time() instead of the removed grow_polling_time()
>    and shrink_polling_time() functions from v2.
>
> Changes in v3:
> - Patch 1/3: Removed timeout check in aio_poll() as suggested by
>    Stefan Hajnoczi.
>
> - Patch 2/3: Major refactoring based on review feedback:
>    * Removed has_event and renamed poll_idle_timeout to
>      last_dispatch_timestamp from AioHandler structure to identify
>      active handlers.
>    * Merged grow_polling_time() and shrink_polling_time() into single
>      adjust_polling_time() function to simplify code review, with no
>      functional changes.
>    * Renamed adjust_block_ns() to update_handler_poll_times()
>    * Modified remove_idle_poll_handlers() to use last_dispatch_timestamp
>      directly instead of checking poll_idle_timeout
>    * Updated commit message
>
> - Patch 3/3: Enhanced parameter handling:
>    * Moved IOTHREAD_POLL_*_DEFAULT constants to iothread.h header
>    * Added validation for poll-weight range [0, 63] in iothread.c
>    * Added the divide-by-0 protection in aio_context_set_poll_params()
>    * Updated QAPI version from 10.2 to 11.1
>    * Enhanced qom.json documentation for poll-weight values
>
> This series reduces CPU usage in aio_poll adaptive polling by ~10%
> with minimal throughput impact (~2%). Tested on s390x with various
> workloads.
>
> Testing details:
>
> Initial testing (Fedora 42, 16 virtio-blk devices, FCP multipath):
>   - Throughput: -3% to -8% (1 iothread), -2% to -5% (2 iothreads)
>   - CPU usage: -10% to -25% (1 iothread), -7% to -12% (2 iothreads)
>
> Additional validation (RHEL 10.1 + QEMU 10.0.0, FCP/FICON, 1-8 iothreads):
>   - Throughput: -2.2% (weight=3), -2.4% (weight=2)
>   - CPU usage: -9.4% (weight=3), -10.9% (weight=2)
>
> Weight=3 selected for slightly better throughput while maintaining
> substantial CPU savings.
>
> Best regards,
> Jaehoon Kim
>
> Jaehoon Kim (3):
>    aio-poll: avoid unnecessary polling time computation
>    aio-poll: refine iothread polling using weighted handler intervals
>    qapi/iothread: introduce poll-weight parameter for aio-poll
>
>   include/qemu/aio.h                |   7 +-
>   include/system/iothread.h         |  18 ++++
>   iothread.c                        |  47 +++++++---
>   monitor/hmp-cmds.c                |   1 +
>   qapi/misc.json                    |   7 ++
>   qapi/qom.json                     |  10 +-
>   qemu-options.hx                   |   7 +-
>   tests/unit/test-nested-aio-poll.c |   2 +-
>   util/aio-posix.c                  | 148 ++++++++++++++++++------------
>   util/aio-posix.h                  |   2 +-
>   util/aio-win32.c                  |   3 +-
>   util/async.c                      |   2 +
>   12 files changed, 176 insertions(+), 78 deletions(-)
>


