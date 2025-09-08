Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1214CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYws-0008F1-RA; Mon, 08 Sep 2025 06:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYwI-0007Xg-HE
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:35 -0400
Received: from p-east1-cluster2-host12-snip4-10.eps.apple.com ([57.103.88.251]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYw8-0001WW-Ar
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:34 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-5 (Postfix) with ESMTPS id
 639DE180030D; Mon,  8 Sep 2025 10:17:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=uGYOmo+498skMERcsL14ugBAYoqpRDRQSb84jthIb0k=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=tQKYlRFmGnMRTJzgvqsUGjKPDLWRXzoRv1OVWJ2FKEGmsMST28E2xVM85R7Ar5XJ6HYO83KG44wKZcffsjbK0+qOMdPsqi15hMBxN0OLX5bKj8syEoeCYRfgXMq8FpNnIsashIs+llTFAiuwU7ZnOjPyFJlymFE56MzdMea1j0PEw1hnzIdB2Vl4neB/f0Ns9qVIzlYEewN2ijNJjiJKzCQvKVVfRQPZSpmlT9EC5Us+6dzHrGjTRx9nGOkzIquspwHrZ9LQvdo7b6lM498OJNE8OW0KVhL85rE3y624QQNzUqeE5sOGMtMSTep6FnWj9PXnDB92poM8+t5B6YTcKg==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-5 (Postfix) with ESMTPSA id
 126181800319; Mon,  8 Sep 2025 10:17:11 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 02/24] target/arm/hvf: Check hv_vcpus_exit() returned value
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-3-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:17:10 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C3E51EA-8976-4E60-A19D-EE268EBBA463@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-3-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: WZQFN3xiiYpnk6SfCz2Q8kmd2JzNEdiD
X-Proofpoint-ORIG-GUID: WZQFN3xiiYpnk6SfCz2Q8kmd2JzNEdiD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX99/IcTP05Xyg
 FmMTY4Jabbstdv0Bp7zRBUcv8KgrGzDnyCIOE/gUzQpsJfhu+GoEPz34+6GLeew5+ks6/A38yMM
 T0TA2ayBZz7FWN2d4cPOhCOWP1SvqUwZ4x+BYVEJfAL4N6LqZ57UcsKEThoXCs6zwRbz7iMVzdu
 /OLc2KL8KmaJ6yC33qh8TK8EU7n913rYRxFRJHh/W3+9Otb1P74fiw4cM7H1JRZCoTEnyXmB5y0
 5ShWhkoPXk1QgWMhxg62NhvYcO+7mRUS/dQ34fsClYBu9TXfbdaHPqBshRZgLcCWOgmPPwIJM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=784 mlxscore=0
 clxscore=1030 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABv3yZ1jhX5+kc+rlBtNoabz1q06/ZfTuz0y94QqwthxeFnc2u0pHESupwlipByU60MUZGRGGzSa5Rto9jIf4AlbHyFUzeSaPBRi7LJrPoUUMcfCgZd5v9DBr0JVT3bRKqLcezGiqxssgMKoB15Gnq+eOehbYHURmjS4xieiohJw4IZ7LN55FtG1icvGymbvmxB1wdAqfFX/QyLiS/pSVJsCVoa7PxTOnXNK9ara5fsKcJcpddPIGocwPaL+PpzOhNRXCCTUo5Ggop0lIr7syjdqtaeuQ+y5HNf5gP3pILWwfCPznHp33vDYPVcnVg29QcaGqoLg6OyW2AmqrmGYSJsfXItx3wiZjPDSyYY9L5YZiKAg8GZcLEpIqrxWLC4f8CCb+r6jl7clhI4B6XpACoAib+6v/+sx5tXDwlCnCPkr9kYXNkC/C6Es28JppQFjmkdk7/F6O8aMB2pNRCjQXw7fIZFCpAIw9h5HavoPGEsqySFYYYsghgSbq5M232bsyaHZ0fIl5xNoifZ2R4cxE4fES5z0dykR8MTtqWQVTgqZ0U5SWS320GN32UAtjArVVaRstShkRfP+sJW26ZTkTGZmTXHC2khOI1bPAv6m1Jud55vlUFrw/f7C3blyerjSLdzZJuGoR/glUmQTToUgitAk+iAU9E1J40LfoeAEpMN/ofaLNwPtNBPhTOxtw7F3+6nX/uypyd5/Paego9Kr7ZO4rHBykWEPvGSs+Oh1P86w==
Received-SPF: pass client-ip=57.103.88.251; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> hv_vcpus_exit() returns a hv_return_t enum type (defined
> in <Hypervisor/hv_error.h>). Assert we succeeded, as we
> are not ready to handle any error path.
>=20
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c        | 5 ++++-
> target/arm/hvf/trace-events | 1 +
> 2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

