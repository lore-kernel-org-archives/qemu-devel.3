Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0A4C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNFo-0005kv-E1; Sat, 02 Aug 2025 21:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiNDb-0004TH-1V
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:08:55 -0400
Received: from p-east3-cluster6-host11-snip4-10.eps.apple.com ([57.103.85.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiNDZ-0000My-Kv
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:08:54 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 B97B61800180; Sun,  3 Aug 2025 01:08:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=bGPKORR6E3W3h+2QBjrdChWhc4IiLsJb1zgA8dx4RXQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=SG6ysmyo5aQVkoI0YJ9YzsB58PEb73BD5eL9b4so1yvrtQqWE+3Qox4KmDRB5BTb3BTraFcofdHxS90sgelKuVFIjZB/chsman5sTLF3p36U1vR/MqOyhqsH3lNez3aTqPwhtt7CHXhP+nwKZSY6SpjosFBUqLTIl7wdCHv2nKutru8wLSZPZmvZ99LTk+okPy2+SvlCisgHR0yPRNBvH6704GDvxU6svARvMIpoGC4xQKDwZ3q11tZVhb2SsMvKc5e8jrmssyTcAgNJ7onThhO+woselX4s4hl/xD7PRaguJ1AaRrZr7q3z3YgPqYw7Lam0GAHYKSnQvIX8nmK8Nw==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 6E250180011E; Sun,  3 Aug 2025 01:08:49 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v3 04/14] whpx: ifdef out some x86-only code paths
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <9904edf1-9419-4dd7-ae82-1c4668a3a98e@linaro.org>
Date: Sun, 3 Aug 2025 03:08:37 +0200
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1652BD3B-0721-49F8-93A0-F5DEEAFD52AE@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-5-mohamed@unpredictable.fr>
 <712da351-3bf6-4a31-92e6-b198d5dc21ff@linaro.org>
 <533A5BF2-9CD5-4FE1-99A7-6E9FB212CCBC@unpredictable.fr>
 <9904edf1-9419-4dd7-ae82-1c4668a3a98e@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: Eocg3wejG4NxCemFYhh8AVwAFGWNRlkM
X-Proofpoint-ORIG-GUID: Eocg3wejG4NxCemFYhh8AVwAFGWNRlkM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDAwNSBTYWx0ZWRfX0aFDWw7h8IMZ
 O48GMS+s/Pl5VlZp8jQaR+oivLbIpz6gYSn58UJIflK1cvxktJV7KY3yz2Wv28U4TMCtZYD9nVH
 BtvPHTuNDFpbALxtG7jf+zKNzvxU40DW/iAbYF/dXZsbDyFPC40WloeHcKB7+XqYDbUuwv6fWrc
 z50vaK36FsCvuvoCs+5JkeER57mjyjkySdorrQO6NfB8JJM9ggNEFZ2+GoCjivwfz0u+OyR45B3
 8D6BqbW8VPVqTMpHharb0euRzBV1drnksEeFvRW2ImCPIN326vr7Ir5hdgzITwsID+AtA4J0A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-02_01,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1030 adultscore=0
 malwarescore=0 mlxlogscore=432 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508030005
Received-SPF: pass client-ip=57.103.85.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 3. Aug 2025, at 03:03, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 8/3/25 10:55, Mohamed Mediouni wrote:
>> Arm WHPX has no specific functionality for debugging today, but we =
could support kernel mode breakpoints via replacing them by an unhandled =
hvc #2, stubbing might be the right route to go...
>=20
> Surely the debug registers are usable?  In the meantime, stub =
functions which do nothing are better than ifdefs wherever possible.
The debug exception goes to EL1 if we do so instead of the hypervisor =
because there aren't exit bitmaps/a debug trap API on arm64 WHP to make =
the HV vmexit in that case
> r~


