Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB6CAC588
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvaYu-0007dP-3J; Mon, 08 Sep 2025 08:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaY3-0006n2-Nl
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:42 -0400
Received: from p-east1-cluster3-host10-snip4-6.eps.apple.com ([57.103.91.227]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaXj-0008Hq-Js
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:00:32 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 E8DC0180153B; Mon,  8 Sep 2025 12:00:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=RByIFgkV+7TSsQZ7rIbDF5xjiQpxYBm/dZM8vP5KY1E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=qls5McwOvR5c645rfTZhGq0QYUUCRAy1IavNfCKz/9SQ9IDW/28+V3pgeBviGpCgnuYWuZTbkCSBg9EB8wQWP2W4gduQdOK0DR5looJqZiN7YUGRXx1T3FLAfvwvV+qCDJQT9TcJATvCwDAOaaEdp3EUQp6Ro80jAdp8FR+xf3tTIpH7epJTajaPBE6z3HmsQhec5ZtrDl9yXko0p8yx9z4Z3a+VUvN4ytmJPezuMoLYfeuy4uqO+5bL9g8OUnLy0LJy1OVtY7mgHGS0SQi0ia/wTPw8pXU12X3JQSnsYmaDWKVJb5bIJ19MKcSYKZESzC4RC7yUD87xuMDys0TbwA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 429D518041BA; Mon,  8 Sep 2025 12:00:10 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 16/24] target/arm/hvf: Factor hvf_handle_exception() out
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-17-philmd@linaro.org>
Date: Mon, 8 Sep 2025 14:00:08 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <397E7F08-ADC8-469C-BD9F-00E1EDC0FBA0@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-17-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: HqoUyzRa38JuhMOqrzWiDCIUX_Oq63hX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyMCBTYWx0ZWRfX72UdNnjhRKqI
 YbCTIbDWVJDg2BpzT2pr8jwraJyhO3x9igUVJy29SyqXVe3BoV/bCZNpRRXdUs+jg8TyEbXP5lF
 S1CMiC3DSuCqs0Gph8nGQWsBF1sIWhe6b2tfZEelg+VF0Oc5c5AcHcG1B4BwFY62bnzmkryzkm9
 NZcCL7IfizSrJCoCXEWWAy6NyQSZea5mYunzXCTuYFf1Du2ZXncRl5CjHQu9VtEKpk5nkPZutNC
 xeDHld6Qad0mFXHiPi7oDnjzdDcwylgxU5RinQRqMC0gKoBDYi2dCXwctmPTQneMWEakt5mrU=
X-Proofpoint-ORIG-GUID: HqoUyzRa38JuhMOqrzWiDCIUX_Oq63hX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=856 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1030 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080120
X-JNJ: AAAAAAABinsaYkfTY4mvbrtm+QUlgxPYnzYQlzHSDcQytd6NVqgluu3pw/cVQ5UW2h1TlkDiFuKgpKjLIIzIQv4qVqfI64Z0vew0DRkypROc9zrmU6mLv6SF7YgGe+gfacEL27Et86DMXL1tjLYR3n1HC9RA+0JoBNPsL+5xzfjwdWtkvSG+VZecGPIlB2sHCJbb2Bc56xkQHFLTNNKn2bnmfc81QibJPCTyckTPuHLZJ6epQCaDZID35PdQKrCnuAZ6kEEbNUsgvNndGBgge4tx9fUmw45WjjkJWNFNKOg4q/S9Sdvd0ZzIL7OiCsJ5HetYNcTOwc85OYb9z1/+seIuUMJpCAcWUBkQpMPaCD7PHRgfBaPyGxwyA/y7yJsZsTSnItXIQ2xGkQDPmuu5pGFadfn9YBggeqhljmENstabQY3MvMrJdHUUghrfN8UQ9rhOsMK6Vqbas2d+WYB/nRgRaMg0HkF9FoVHipJmF5konzYa01npfjSIEysxUdhsBFEv2pcXdpS5wYPJZ+mIN6bQYfFF+VNTK/y94cDh4jfOTEry9i9yfY8x6i0fxOjBVAEED5XrbWS4j1NCC/7lSAuFiEv1H+MvGonUF2UOO8otJbVbolPWWkMWATV5Bj34eO9NACwd+mvzUJUJtIKSMkLYCASgCb+IjNFy6cb7G9YNX44WqjWCAHJLRsNY0jdWfGKitiRDvy6ef4HxBInE0FWUmIlr
Received-SPF: pass client-ip=57.103.91.227; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Factor hvf_handle_exception() out of hvf_vcpu_exec().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 120 +++++++++++++++++++++++--------------------
> 1 file changed, 64 insertions(+), 56 deletions(-)

Good idea.

With Richard's change to not cast twice:
Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

