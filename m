Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A39FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcWJ-0006Te-Jz; Fri, 04 Jul 2025 05:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcWH-0006Se-Tj
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:15:45 -0400
Received: from p-east3-cluster6-host7-snip4-1.eps.apple.com ([57.103.85.192]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcWB-0001nJ-Tm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=Kjv69prOm8o+3r+NqxkFDhjMCJxoTAlRl95Ze5nfxEA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=xS2goS7WwTuKPCViMH0migXPvotSjFTOMJX4WC0myqeknuiudpPLpXVjjaPz8TfbG
 4jZ5Q3HdXfudLhiiDVKU/ZoIkH0tRRGG1mZxxWlLjXQ3mJjHlU7f9sHbeWoQ28gQWu
 9zOY1LH+5lDvA0il/64Nuf455dokswvcb1NBJlvg5W3TS3qnjl9BFIV3ytE/dXbDp/
 7eARKqxG23myt22CRu9kgHKlkB5Fqwy2DsGg1h2RJ25f43ZIptPZPrPlQ3gJtDFxEh
 WLFttmK9kFM9Dax6r7+hR4xH0K1V1+GCt8Ec2GEmEBP2Km2FjfJj3nxnaljhM++V6b
 LbEIlaGpoJCcw==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 4B5291807C1F;
 Fri,  4 Jul 2025 09:15:35 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 6B5D81800367;
 Fri,  4 Jul 2025 09:15:34 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 51/65] accel/kvm: Convert to
 AccelOpsClass::cpu_thread_routine
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-52-philmd@linaro.org>
Date: Fri, 4 Jul 2025 11:15:22 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6FE1389-E113-4794-9700-0D7F206C2704@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-52-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: zgdamnS0sfl3rAgKV2PMHfZnYsVWOPsv
X-Proofpoint-ORIG-GUID: zgdamnS0sfl3rAgKV2PMHfZnYsVWOPsv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA3MSBTYWx0ZWRfX8f4Kk4QdcsHq
 iuqkwrfRcCsFTockm9f4Gd1uhET6aMtPDjIxk2/Rdvz64WLQsoivDlHxmvy3VxKPaPfjmdFVqRK
 2dzyM8aUToEiFy+ltDmB4zK3dP7GfLlFrU+EO0TB4UjjE2Oe4IwPsNITB07ycP8e0ClpUN439hn
 OAzjYINiE47597ZxO7WVrBZ2s7xMcBd8XlD3NRPGIQcJFTZ+T3D4XpnErCFFbAg83mi4AdBpDcn
 //8gGA8ko0rdqqU8+TWuviVbzwVRyIiCHZgxuWkumOZe7Wa/TOeKUexPY359KF0ivbQlhmdzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 bulkscore=0 mlxlogscore=865
 adultscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040071
Received-SPF: pass client-ip=57.103.85.192; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 2 Jul 2025, at 20.53, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> By converting to AccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> accel/kvm/kvm-accel-ops.c | 12 +-----------
> 1 file changed, 1 insertion(+), 11 deletions(-)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>


