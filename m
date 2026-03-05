Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDE9EFCE53
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 02:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxyca-0001Gc-EP; Wed, 04 Mar 2026 21:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxycS-0001Fc-G9; Wed, 04 Mar 2026 21:39:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxycR-0002b5-2b; Wed, 04 Mar 2026 21:39:20 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624DIHIA2125663; Thu, 5 Mar 2026 02:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WH795i
 sc8bkYTvS5s9OPmox39ayaHb2S5Dyo0VSCfw0=; b=ZMHNEGIKGYre1h5Qjlbboy
 QoV2hF7h5DTUbfLlV91K0pnmdH9vGr7Qodpkb1kdPd7hYaY6lJEgDraW1aRTx2ui
 i9yk9nS2szU7PztmrhgjjUSeri7tuQXeoTPhGTbzYfFBGfrjwnL/EswHHcPiFxlx
 fACsDh1n1gIFHgKVmQwHl/0tQ2DSuMtwzgXIUlBkSSGSXDRlVl4GqmpWk85Bz2t+
 sQKFfoA+NSU38lFDTboQ0W3K/3SOuFLtJaqJu2VRaqZU/j8wvk3PpawkD0a2pbAt
 2oVmoe5rGA8A1SwjcE67xSFSH/rbZuMOR0mRhtlPG9ofVjJ/j4AYaBcPYXeN3lPA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc1fu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 02:39:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6251BEjt027713;
 Thu, 5 Mar 2026 02:39:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjh2hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 02:39:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6252d6Sm30474754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 02:39:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7337058052;
 Thu,  5 Mar 2026 02:39:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 444ED58056;
 Thu,  5 Mar 2026 02:39:03 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.133.56]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 02:39:03 +0000 (GMT)
Message-ID: <8f8fe4eb19463264ada68f50715f21f514baf352.camel@linux.ibm.com>
Subject: Re: [PATCH v3 17/18] migration: drop VMStateField.err_hint
From: Eric Farman <farman@linux.ibm.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin"	 <mst@redhat.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini	 <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gautam Menghani	
 <gautam@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Stefan
 Weil	 <sw@weilnetz.de>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger	 <borntraeger@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Matthew Rosato	 <mjrosato@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Thomas Huth
 <thuth@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>, "open list:Floppy"
 <qemu-block@nongnu.org>, "open list:XIVE" <qemu-ppc@nongnu.org>, "open
 list:S390 channel subs..."	 <qemu-s390x@nongnu.org>
Date: Wed, 04 Mar 2026 21:39:02 -0500
In-Reply-To: <20260304212303.667141-18-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-18-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hvPaDpiN6Qsua-43U9BMxN_NLnZaMgCg
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a8ecce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=6R7veym_AAAA:8
 a=VnNF1IyMAAAA:8 a=GN4Jp0a-f4mWprhMvXEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAyMCBTYWx0ZWRfX0wuxhnHy2m3A
 54V5VrWhRr8STVnADSbEky31DI9JHI4ZKFBsRHpD3TGzFHB2j+WPDI5KbijJFk6ynVDWXkztXwM
 WhbGhi9lD7G4ptC0TcOJI3yFZrgaOO0dIT9TZUDy65TE1v+3s4xFjtNEaYrQ/7qT2S92rJGO7Qs
 4CE0LW/2jYjTVY8RwQz0sZxBYm0Pwp5bTTan0fRZ8fJVrwjElBBP5x2500vnnpeU2gaM81VMtiu
 YuH5uMh5n5MK+7MA2z+4iKWjtxCV5CmUkOIdnEYLwRPvj+ci2J/pe4lT+K+EbZ3Zk0r71AV0SK9
 rSejpN5ULugHLU2eJBCZ8LXAzVHA2NkXK/tYGamhRQp3Mj7ae2rzkO7FAG63B+1rOaAEumP1qjh
 rGRpW+FXLKNyXuVK1RhcUgbbBRfZbcRaNA1+UWceLDba84/zjrjyRX4sG0rjsyu/llCMg2j6JVo
 1zJyZgEusGeN502P1QA==
X-Proofpoint-GUID: ZX0pSE7uEv7b5Tn0pZm3wZEJD0mQ8GaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 2026-03-05 at 00:23 +0300, Vladimir Sementsov-Ogievskiy wrote:
> The field is unused, all users of VMSTATE_*_EQUAL pass _err_hint=3DNULL.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/block/fdc.c              |  2 +-
>  hw/display/qxl.c            |  4 ++--
>  hw/display/vga.c            |  2 +-
>  hw/display/virtio-gpu.c     |  2 +-
>  hw/display/vmware_vga.c     |  2 +-
>  hw/i386/vmmouse.c           |  2 +-
>  hw/ide/ahci.c               |  2 +-
>  hw/intc/openpic.c           |  2 +-
>  hw/intc/spapr_xive.c        |  2 +-
>  hw/intc/xics.c              |  2 +-
>  hw/intc/xive.c              |  2 +-
>  hw/nvram/eeprom93xx.c       |  2 +-
>  hw/pci/pci.c                |  2 +-
>  hw/pci/pcie_aer.c           |  2 +-
>  hw/ppc/spapr_iommu.c        |  2 +-
>  hw/ppc/spapr_pci.c          |  4 ++--
>  hw/ppc/spapr_vio.c          |  4 ++--
>  hw/s390x/css.c              |  6 +++---
>  hw/usb/hcd-uhci.c           |  2 +-
>  include/migration/vmstate.h | 36 +++++++++++++++++-------------------
>  migration/vmstate-types.c   | 15 ---------------
>  target/ppc/machine.c        |  6 +++---
>  22 files changed, 44 insertions(+), 61 deletions(-)

Acked-by: Eric Farman <farman@linux.ibm.com>  # s390

