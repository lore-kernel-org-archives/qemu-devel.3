Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BD2109448A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 17:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w406F-0000sH-8R; Sat, 21 Mar 2026 13:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w406D-0000rh-Og
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 13:26:57 -0400
Received: from p-east2-cluster3-host4-snip4-10.eps.apple.com ([57.103.77.171]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w406B-0004Si-O7
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 13:26:57 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-1 (Postfix) with ESMTPS id
 85D811802B05; Sat, 21 Mar 2026 17:26:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774114011; x=1776706011;
 bh=uCFF1LzOTZhxXNHo0ochpKbLIDcQRh74h3CZgLutBfA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fS6riC0VpOn2Q+hhcV1KR8OaXtPhYLotjhCyM4FSXma0R8SMrwlRXL1eI5JF73kaLO6aqRH2kw5MgcqhlalODVls/IRhjOQWXomqDq5FMfzTOY3Hm4cvMKgGyMxQYapyz+6QneCYzM4DywNrffA0/tuFuie94RhBqzb93QBjGx3DC/afIFCZ1Ot9Y7HQueCnaLQkwYkqPH2POA7Ey0p0x8DLCvkrYJ0C0dsQM+58vEyma2msmw69r6yMgRW2yZaNJDuMxvOiCFNL4XEv9WBylCD6ygJx9fSb2UQqViTFS4g2oolqsNM5iYjyLZRixDl4XqdnBVSG6IW0ak6tHN3s7g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-1 (Postfix) with ESMTPSA id
 99F7A18000B4; Sat, 21 Mar 2026 17:26:46 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH rfc] hvf: arm: Inject SEA when executing insn in invalid
 memory range
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <7c4ce7f4-7a50-40e3-b80f-e776eaac4984@linux.dev>
Date: Sat, 21 Mar 2026 18:26:34 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, agraf@csgraf.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D0BCB24-BB1B-40EF-A361-0F79D65600AE@unpredictable.fr>
References: <20260315163840.30741-1-zenghui.yu@linux.dev>
 <CAFEAcA_kj1eRpjMYDF4b6hD1_P0+PazzdHFfTJFj=Hn231DBGA@mail.gmail.com>
 <7c4ce7f4-7a50-40e3-b80f-e776eaac4984@linux.dev>
To: Zenghui Yu <zenghui.yu@linux.dev>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: y241oavrPmJZyPPGNz4kZmT9vPXRPMOp
X-Proofpoint-GUID: y241oavrPmJZyPPGNz4kZmT9vPXRPMOp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0OCBTYWx0ZWRfX1DUnNlxlX6Az
 XgJpNkd8aeGpmhH4M4hOPuVvuoaoxmVSHBHtafryvt0jI2kQGQSn1LrsX6n8vOgkA0QHCP8qXaU
 65C+V/1s8dTUO2zSQaLaF+0ULoWY4orQEmAZTIgeAjkevULmhcn7LmYXbFRS/Iw6ICPYWapuAct
 n9uh/oBpUZjBm3SQwOeHlS0tP95lmjjOWbCzuTFKxQa3ce6BIHPpxB7rxlBtS1QDZA7zwrnNSCv
 AuGi1BKKzKzeD9EihdDAkn+6GlDgu+1cWsY/GB5nxxR0t0Ynd4EquqT1EsuzgD9r5l6OkASYSC+
 zP01kT/WwSbcBjlTtizZ69pkWG6lmFl4VmStMlmrDlyBEF3lfRPAYBjhcBR1Qs=
X-Authority-Info-Out: v=2.4 cv=LrSfC3dc c=1 sm=1 tr=0 ts=69bed4d9
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1rQMODKajjR8nbb65PIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1030 mlxlogscore=329
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603210148
Received-SPF: pass client-ip=57.103.77.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


> On 21. Mar 2026, at 18:09, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>=20
> After hacking KUT to let the guest map a VA to IPA 0x1000000000 (an =
IPA
> right after 64GB) and execute an insn on that VA, the guest receives =
an
> insn abort with IFSC equals to 0x03 (Hello, AddressSize fault!). We =
can
> _infer_ from that that the AddressSize fault is injected internally by
> hvf.

Hello,

As far as I tell:

If the translation fails at stage-1, the fault is routed by hardware=20
to the guest directly instead of going to the hypervisor.

In the case where it=E2=80=99s not a valid IPA in the first place - =
instead
of an unmapped one - the hardware triggers a fault to the guest instead
of going to the hypervisor.

If the stage-1 translation is successful but the IPA is valid and not
mapped, _then_ it gets trapped to the hypervisor, and gets routed to=20
user-space for VMM handling.

The EC_DATAABORT case happens on MMIO faults but the EC_INSNABORT=20
case is=E2=80=A6 more speculative for QEMU today.

I can see cases for doing it for on-demand page mappings in user-space
though=E2=80=A6 where you=E2=80=99d map the page and then resume from =
the same PC.

With the current model QEMU uses I=E2=80=99d expect not handling =
EC_INSNABORT
at all to not result in a functionality gap.=20=

