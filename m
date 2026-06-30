Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FA9C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 18:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weda0-0006zs-P3; Tue, 30 Jun 2026 14:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wedZw-0006zQ-N4; Tue, 30 Jun 2026 14:53:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wedZv-0000iX-7N; Tue, 30 Jun 2026 14:53:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIt8C2171482; Tue, 30 Jun 2026 18:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=SZxcmJ8sVqxXE92EroQt9nhh8FFQ8a
 lMun/haz5ohjM=; b=D39M5k71f6uckP9Id0FqQ6YlCB0lj4K1y/S4vkg8jV7W/u
 xYwr0duaY9M668PdNUyPMs3V+vQNBMtm8KTfDuqASn9LQVcLbPM9boJw3WKaJQxS
 lTIwLxittj18+VgSlFIMKw7MequTiBmaKvjvLCdAyLqPWYayY/WsLzRTMcIN7Xen
 AmAaNOIQp7Yr9Wa7NxWRg6fJy9mUZcDKKB3fgZc8UAtu1DhMdB1qSobZwrU8lEn1
 HuS0Kd6ZEoc1tjWDYVtcfh9edveoSltqS+aEgtofTY1TEmFwUd9rsioxj2USkzeW
 lTXDrTo4XfU9yWuZAphHmSqjSn0XiZyEJruFgfuw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf09us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:53:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UIneH2010612;
 Tue, 30 Jun 2026 18:52:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhybhgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:52:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UIqtnP38142296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 18:52:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB98820043;
 Tue, 30 Jun 2026 18:52:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F375320040;
 Tue, 30 Jun 2026 18:52:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.35]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jun 2026 18:52:47 +0000 (GMT)
Date: Wed, 1 Jul 2026 00:22:45 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Message-ID: <akQOQaFAKIMwJr2j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-3-adityag@linux.ibm.com>
 <db95d79a-a6bd-40a1-bc08-f572cebe1641@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db95d79a-a6bd-40a1-bc08-f572cebe1641@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a44108c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=2MyuuRbPs5obn9458OoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: CkvIOczE3un40AxUjJ2xS8ze1tU40Sg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfX3TKcsHkV9d3n
 MknEInP/HmTP2N+l7VTMB7Y9mKcmKLIYAv6sbvooh4k+iyCwqginO53w4MOHYCGs9GaGwMb86ao
 yDtXa9i8oX/tBDnanAj5BEqkSboTnKl89M4QtK8Pb1Pg0kt8/crHhGwLn56dbrWYzttuN8LtBfb
 f2krkHBBSkPm5a47RaWgUyGtJdTcnEIHoQGxmWSOMIIpZLo9BE5tEMgJKEd/NAOsaqNUaGUgqk8
 qOvpXQTKM7JhPRUhqDcQr7nE7UcWMlyCqnPX3WPbkLoJen0t9lbdedy4QSMxZnBZm9Rnsn/eeWf
 +FkeqJGnIZ5udJJLMi5v5CO9TIEQno1LXRWCPT1oqf1A3Fa3M6+mnWyt1b5v+DVz37tXRpq65xK
 2A+R2ipUMSuIdzmwgfDXk1OsM7dMitfKINJf/BJKHZFmwU6FrmJqiGjK4153lG9acQWlKUheE/Q
 rLDbLgfb4uoozLQZtgw==
X-Proofpoint-GUID: yt7xSrIawKoZgu4mUJvn-pkHIzdoOinh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfX/ZauVjHOsoSB
 Ay+S0e70r5tEO0y7XQKAVc3bX2xncK2An3OjOA/c4YrykFDV/uhIp1/k6yBJpksVwn/Naw5LD/9
 9Ptv15f+LNTgfhkp7g9hXkQOfdkDy/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300181
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 26/06/30 09:55AM, Nikhil Kumar Singh wrote:
> Hi Aditya,
> 
> One comment below.
> 
> On 23/06/26 19:49, Aditya Gupta wrote:
> > @@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
> >       const PnvChip *chip = data;
> >       QTestState *qts = NULL;
> >       g_autofree char *tmp_path = NULL;
> > +    const char *machine = "powernv10";
> Would it make sense to introduce `pnv_get_machine_type()` in patch 2
> instead of patch 3? That would avoid hardcoding `"powernv10"` here and
> allow this patch to use the helper directly.

Could be done, but i will prefer to keep it in current state, as of this
patch, power11 wasn't added to this test, and the test only runs for
powernv10, later as powern11 gets added in next patch this is changed to
use pnv_get_machine_type.

If pnv_get_machine_type gets introduced in this patch, it makes sense to
modify all other tests also to use it, which is more than what this
patch intends to do (just remove hardcoded index in spi test).
To me, it seems okay to keep it as is, what do you say ?

> 
> Otherwise, the patch looks good to me.

Thanks for reviewing, Nikhil !

- Aditya G

> 
> Thanks,
> Nikhil

