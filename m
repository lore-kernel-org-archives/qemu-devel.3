Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA07CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 12:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoLau-0001Pa-8q; Tue, 19 Aug 2025 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uoLap-0001Oc-Dy
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:37:35 -0400
Received: from p-east1-cluster6-host12-snip4-1.eps.apple.com ([57.103.90.242]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uoLan-0000Kw-Il
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 08:37:35 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-6 (Postfix) with ESMTPS id
 258601801A55; Tue, 19 Aug 2025 12:37:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=hPFQz71XvwNHF2n1A9mBn3vtBW+PVAo3vbGwbvYnjf4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=maLT5LbdhOE0AKMAikB6NSiTOBMiGhf1ZW9OhSVPm+Ha64uOOcOEnF4yVE+PGD6sbYvCkDdsTpB7+f5QPHNn61+0I5xD8wxXDoV70W1K7nvALlP44hDYIEsEyNFP328tAq0bQ2mFDgztpweWf1tPoKmWf8supEun0X+tCTkASVNKaZnOI9IFplxnZ9wI9lB5Qnc7cp+feYDtAEc4wvPROyR72stoXony9XicM/hXLdGFiyz88ehXB8SWekpKjkfzslQia7/BwsAbY8SFcfl8iO1B14sRlrllFYiVzYkgX7gA8Xhc33xqm1VCRiz5NCQro9xLfgygqTFNBaghiASAPw==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-6 (Postfix) with ESMTPSA id
 9F2771800670; Tue, 19 Aug 2025 12:37:26 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 09/13] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250808070137.48716-10-mohamed@unpredictable.fr>
Date: Tue, 19 Aug 2025 14:37:15 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DBF9B14F-707B-4CB0-8393-3150DC046E0F@ynddal.dk>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-10-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: jkvz-53Bo77bzOjYH3Qcp2aVnL0mKnF2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDExOSBTYWx0ZWRfX7g7sLZVCvF3t
 C1MRHduKX0/323lu+FIH7VRhIfpD7QRPy7hMtv3Kj2a14ykDNkGWlWM4dpFjv34Ol3w2i+T2h8P
 YBFFR98Omjax14V/baF49BKgS1p4lqODKaFR1glO/O6XCsJiHhkmtkCM/MkYNoQFv/UKWUiC0uP
 QE2gGi/7u5bimFm9g7+Uoym6ul9jFbgtrKlrYaVVaecGnes8qGGJMaN9bj2H++7whIRNGBDBGLU
 lPwUF+93nKmceP4cO6oR298QBShRfb6UU/nwgyEjmmvmS5tmgwO0exMAjitrtQVLtRZmoeR1E=
X-Proofpoint-ORIG-GUID: jkvz-53Bo77bzOjYH3Qcp2aVnL0mKnF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1030 mlxscore=0
 mlxlogscore=932 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508190119
X-JNJ: AAAAAAABAmb7W6LoSzDePUPDSqkt9dMZL2qPv0ySZvFSGepdgBTOCgNxGfrF042sY7x8qnJKlfZ8JYf/AjkkR5Xsng/sjuzYuFyqfFdmZGQcXZquUaxWPj6DXIZ+Be5gAzfJQD+cvw61SwnaNssSWhA57n1r6Rr67uWSEzEkPhwEIFHO/Upvlxa8bewJvfwrfldhdjDoZBRI9DLqKaNWZpGdfVia0B6f74c4TSDnRl+7hgtRw1Yt21fU36E8dLoctrTCUkEEJNpaR9I3aVfEFl5/dNVgZ331svE2MrgCBXZi9665pjqKz6SfcfYB6JRtCJE38taPOv7SXNgCjP5PvpIm0838roKUAyg7eOmLZJ+2XeiDtHqgAYVw8GxTnNR68Pac0jeu0TCZLBOiCYAtr/H1JUFM32WR6B3zQ03joYUJRq12GW4ZmJTFjlIYevy4Voeu3LqYT4+aJ1AzUgqfBNrjiycgLdyrJxpv4UjHDixWxopcuLovKXukzk2ZwQOHlvEl8o8uYa32QM/Qn8IEpvujI7O+tgYpHIQ/7hQWJ3SVlrq0wB7tsIbNEz17OutUqkPoVJHvon5rM8XdPrIPRgrLTvSijxSu+g==
Received-SPF: pass client-ip=57.103.90.242; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 8 Aug 2025, at 09.01, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> When running with the Apple vGIC, the EL1 vtimer is handled by the =
platform.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/hvf/hvf.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

