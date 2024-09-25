Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0C8C369A4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 07:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stMgo-0005tS-6g; Wed, 25 Sep 2024 03:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1stMgk-0005sL-JY
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:43:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1stMgg-0001hz-6M
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:43:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1WfJO018831;
 Wed, 25 Sep 2024 07:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 pXrC7f+t+lMB5Sq5gbY789Nr1jHVCSaxJnljDWU1jvk=; b=WduWZc9s5OIbi0+2
 Q5mRljiHeb9aFQrBG93/6X8mqou91JVRo7/vj8llDAN9cspUNLcKsVy32mwk6qqE
 tnQkrnXV3fTJ4YlZdkqE5HQA9+guu/jISwXqIg3OlItp3F/V3PYi7cmd4Foh8gHH
 odrHvPY7OhwkKK2wLsqZLwr7o9a9+QpN3pF+labij3Uj7T2GILsFNDPqjZTYjX+N
 dUAURKH/OVi/PVsS9i1C2B2gZm+36Dq46XLI8VN76l+7W0FZbVIwjgBCLNe3KQ6g
 eDeFYeO2WP7LuKeHmpt5B6XuzvIpzwcqrVViY6DPZGq5ey4qycVVY/pYJC+VknIJ
 b1VD8w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrpjs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2024 07:43:45 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48P7hjlJ015250;
 Wed, 25 Sep 2024 07:43:45 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrpjs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2024 07:43:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48P716ed005810;
 Wed, 25 Sep 2024 07:43:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tapmg0gk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2024 07:43:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48P7hgqo56164722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Sep 2024 07:43:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B15B32004E;
 Wed, 25 Sep 2024 07:43:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 454CE20043;
 Wed, 25 Sep 2024 07:43:42 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Sep 2024 07:43:42 +0000 (GMT)
Message-ID: <7164df57c9c3eae2e6f27be7f6c890081740b2cc.camel@linux.ibm.com>
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Date: Wed, 25 Sep 2024 09:43:41 +0200
In-Reply-To: <8c7ed3d0-15c2-426b-baf5-304a984d2559@linaro.org>
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <8c7ed3d0-15c2-426b-baf5-304a984d2559@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d1n06rUN4v3cvs8UobQsh3WK5kjq60X6
X-Proofpoint-ORIG-GUID: _A8D7WAOvZX6LdVS78eyZHc6rEChyEKr
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=463 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409250053
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On Tue, 2024-09-24 at 13:46 +0200, Richard Henderson wrote:
> On 9/23/24 18:12, Ilya Leoshkevich wrote:
> > Hi,
> >=20
> > On reporting a breakpoint in a non-non-stop mode, GDB remotes must
> > stop
> > all threads. Currently qemu-user doesn't do that, breaking the
> > debugging session for at least two reasons: concurrent access to
> > the
> > GDB socket, and an assertion within GDB [1].
> >=20
> > This series fixes this by importing pause_all_vcpus() from qemu-
> > system.
> > This in turn requires introducing BQL and a few stubs to qemu-user.
>=20
> I would have expected you to reuse (some portion of) start_exclusive,
> which is already=20
> part of qemu-user.=C2=A0 Is there a reason you chose a solution which
> requires...
>=20
> > =C2=A0=C2=A0 replay: Add replay_mutex_{lock,unlock}() stubs for qemu-us=
er
> > =C2=A0=C2=A0 qemu-timer: Provide qemu_clock_enable() stub for qemu-user
> > =C2=A0=C2=A0 cpu: Use BQL in qemu-user
>=20
> all sorts of other infrastructure?
>=20
>=20
> r~

I don't think start_exclusive() would protect the gdb socket from
concurrent accesses (e.g., if two threads are simultaneously stopped).

I have a patch [1] that introduces a big gdbstub lock for that, but it
looks more complex than just extending BQL to qemu-user. Also, the
BQL-based pause/resume code already works for the system mode and is
well tested.

[1]
https://gitlab.com/iii-i/qemu/-/commit/0944716218820f8bdfdcf80acc6c39a48b91=
670c

