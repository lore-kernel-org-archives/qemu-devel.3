Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D04CA0FE4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0FK-0007XX-MO; Fri, 30 Aug 2024 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sk0FI-0007Ql-NQ; Fri, 30 Aug 2024 07:56:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sk0FH-0002sh-0L; Fri, 30 Aug 2024 07:56:52 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7xUgl030906;
 Fri, 30 Aug 2024 11:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:mime-version:content-transfer-encoding:in-reply-to
 :references:subject:from:cc:to:date:message-id; s=pp1; bh=OHXrE6
 VkGJVhdFDQmF/1P+woeiOIsikQSFj9k+E5l4o=; b=Yz6AOkzjeUBpdzdrZkheVi
 IRh7siMnNdPGK8FWO19R4VPrBsvaiaKEE78hitQo4janbec4VC2uag11TFU1aYg/
 8N2quPK7FQTBl1+C8henjj0yu68LVbYXrsc7LFmZHeNrzcxUJfBX2DZg3lcWRyG7
 SpvAosDglwyjxjLuYeeTfgzpOm2js8LLspbZDWp6xTCSLBwy+jAMIOwszZl9Ajkm
 G/OrIO+SL9Zw5ZziQNyFvtO1v3SrX1im1EYJ7epexZKPXAG4VH1PQ4vcw2DQSLv9
 zzVR9KWzsiifwQ/7fTITb4tgLCkbRtDcjIr8l0GiBU4zEd0pi8cICjj6dpclNgTw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r6sp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2024 11:56:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47UBuhnd004684;
 Fri, 30 Aug 2024 11:56:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r6snk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2024 11:56:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47UBtDkU027960;
 Fri, 30 Aug 2024 11:56:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubnkesa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2024 11:56:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47UBugxn31916628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 11:56:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AFC220043;
 Fri, 30 Aug 2024 11:56:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61E6120040;
 Fri, 30 Aug 2024 11:56:42 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.43.233])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Aug 2024 11:56:42 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA8nTAPi9wr5h_V_GZkVV9f-YDV19mi9yybry0wxMyh6Eg@mail.gmail.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA9c1pAE7gttju5ib470ZhEMjd1=UMjLuhS+gXohnLs=Xw@mail.gmail.com>
 <172499689329.6066.495009881329074086@t14-nrb.local>
 <CAFEAcA8nTAPi9wr5h_V_GZkVV9f-YDV19mi9yybry0wxMyh6Eg@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw,
 cpu to three-phase reset, and followup cleanup
From: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 13:56:41 +0200
Message-ID: <172501900133.6066.3071687086903215470@t14-nrb.local>
User-Agent: alot/0.10
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PU3U0OAHD4G08-KIpeEZCKTZeTrHtFmU
X-Proofpoint-ORIG-GUID: 4Gum7Aw40PL4FbMq5PR0BP9VVih72-WF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300087
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

Quoting Peter Maydell (2024-08-30 12:01:47)
> On Fri, 30 Aug 2024 at 06:48, Nico Boehr <nrb@linux.ibm.com> wrote:
> >
> > Quoting Peter Maydell (2024-08-29 17:53:02)
> > > I repro'd *something*, but it wasn't quite this. I got:
> > >
> > >
> > > [    4.691853] clk: Disabling unused clocks
> > > [    4.695419] Freeing unused kernel image (initmem) memory: 6520K
> > > [    4.695430] Write protected read-only-after-init data: 144k
> > > [    4.695834] Checked W+X mappings: passed, no unexpected W+X pages =
found
> > > [    4.695849] Run /init as init process
> > > /init: error while loading shared libraries: libgcc_s.so.1: cannot
> > > open shared object file: No such file or directory
> > > [    4.697009] Kernel panic - not syncing: Attempted to kill init!
> > > exitcode=3D0x00007f00
> > > [    4.697030] CPU: 0 PID: 1 Comm: init Not tainted 6.8.5-301.fc40.s3=
90x #1
> > > [    4.697035] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
> > > [    4.697040] Call Trace:
> > > [    4.697047]  [<000000007ab6ae36>] dump_stack_lvl+0x66/0x88
> > > [    4.697081]  [<0000000079e17c2a>] panic+0x312/0x328
> > > [    4.697096]  [<0000000079e1de84>] do_exit+0x8a4/0xae8
> > > [    4.697101]  [<0000000079e1e2e0>] do_group_exit+0x40/0xb8
> > > [    4.697103]  [<0000000079e1e386>] __s390x_sys_exit_group+0x2e/0x30
> > > [    4.697105]  [<000000007ab9526a>] __do_syscall+0x252/0x2c0
> > > [    4.697113]  [<000000007aba8840>] system_call+0x70/0x98
> > >
> > > Which I guess could be caused by a different corruption
> > > of the initramfs ?
> >
> > I think that is the problem, just a different symptom. I also got this
> > sometimes (in random libraries all over the place).
>=20
> I ran overnight with none of the patchset applied, and it never
> failed (as expected). Running with just the first virtio-ccw
> patch does fall over fairly quickly. So something's up with
> that patch, which is curious because that's the one I thought
> was a straightforward conversion without any complications :-)
>=20
> I'll investigate further today, I have the beginnings of a
> theory about what might be happening...

Thanks for taking the time, Peter! Let me know when you have insights.

