Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9459A10AB802
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ppy-0005MX-1L; Thu, 26 Mar 2026 14:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5ppt-0005ML-8e
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:53:41 -0400
Received: from ci-2006e-snip4-5.eps.apple.com ([57.103.90.176]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5ppr-00040c-Gx
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:53:41 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPS id
 0B6391800099; Thu, 26 Mar 2026 18:53:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774551216; x=1777143216;
 bh=hMucaqsoxnjWmfIXBPp5sJZ8oKI6p92JqnmFmJnK0T0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=DoiVxZmLQQlw4S1wao0/wDyF+eMvtz2dcQFJne0Q9OGCaFeioZNyE7/nwIVD4s7kRTgmNWpiVVLEG3seHdIAZoE4dYJfHQWPW85Z2cLunIdrWFEH516CPx1UCCoZ2MqnnEoQ4a3CpvbmkHUcFhymKSCrqBYVo64uSlxf15Qh148vLtfYiIOpHbp2fE0EosEqvIuBGO/Jb6lWns8Ub14CM/S9ede/qyZckOgz4LrDD/2CmoCbHBS9GDwJ9P+RrXh+/uL5teAxy2mkLIp+jSIXsnThVhFPpWPSKP7RhDbx4kBw5Grrmwvnh28TcPVLZHT5IjtKVmqyVYMew1VZztdqlA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPSA id
 505B718001BE; Thu, 26 Mar 2026 18:53:32 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3 2/3] target/i386: emulate: make unmapped GPA warnings a
 trace
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <b1115dab-4f72-4c8a-8d81-3c24b3475faf@linaro.org>
Date: Thu, 26 Mar 2026 19:53:20 +0100
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BB391D1-719D-45C5-B0F3-2CDBA65CC1E1@unpredictable.fr>
References: <20260326183628.79281-1-mohamed@unpredictable.fr>
 <20260326183628.79281-3-mohamed@unpredictable.fr>
 <b1115dab-4f72-4c8a-8d81-3c24b3475faf@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=NLDYOk6g c=1 sm=1 tr=0 ts=69c580ae
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=Q8nlch1YmvYLlkRlNSoA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SvBqs3EVgunZokQvaJxDvpSh3z5_-zc8
X-Proofpoint-GUID: SvBqs3EVgunZokQvaJxDvpSh3z5_-zc8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNSBTYWx0ZWRfX/mmDzFT9iPH5
 sgRZmqVvMdW5cT0nVTMfg3zDhcJvS31F7MmSBQaC1938JUHR9PoKnSCp01K1xLkR59N2J6B4oD2
 bJW0Dki1DwXx7m1eld3juPpKLgX9v+gN60EGPnsgaPcYD9BbhsxlGVvLcp+df14/fGyb9SSy8c2
 d8kVAs/4U7Apj0MH4K3gw0g4ctMT7TySRxmS03HCT68ExcYpZIeFR4T5Ve7Lx8IK14fo89MnEPi
 Sb5WPdq/HTKnalYTsmiOi5DyNY9uDLo4Mm2uYcTdHkB+5FGtzHWgBxi156jFy2V2aYq1N8peGe/
 1Y6VIKFA+P/YVU/usao6OsFqmAFc9oMT0v+SS2NMK+yLi+juo4MOiY4tRPdg1U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1030 phishscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=626 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260135
Received-SPF: pass client-ip=57.103.90.176;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 26. Mar 2026, at 19:46, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 3/26/26 11:36 AM, Mohamed Mediouni wrote:
>> Some guest OSes trigger them way too often.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  meson.build                      | 1 +
>>  target/i386/emulate/trace-events | 2 ++
>>  target/i386/emulate/trace.h      | 2 ++
>>  target/i386/emulate/x86_mmu.c    | 5 +++--
>>  4 files changed, 8 insertions(+), 2 deletions(-)
>>  create mode 100644 target/i386/emulate/trace-events
>>  create mode 100644 target/i386/emulate/trace.h
>=20
> To justify the change, it could help if you could add a better commit =
description explaining:
> - which OSes are concerned (older windows?)
> - analysis why they do such a thing (at least see some QEMU backtraces =
when this happen).
Hello,

Neither Windows or Linux are concerned by this one, but the=20
ReactOS install ISO - among some other more rare OSes - trigger it.

Intriguingly, the ReactOS live ISO doesn=E2=80=99t trigger it.

>=20
> =46rom what I see, this code is triggered either from hvf, or when =
running an ins instruction, so you could explain which scenario you're =
covering.

WHPX has been moved to target/i386/emulate for 11.0, it=E2=80=99s no
longer using winhvemulation.

And that means that it=E2=80=99s a load bearing path through which
load/stores on every MMIO access by an emulated instruction
goes through. And even reading part of the instruction itself
if Hyper-V doesn=E2=80=99t give a complete one.

Thanks,
-Mohamed


