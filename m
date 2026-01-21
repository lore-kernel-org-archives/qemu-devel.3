Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEF2C4451C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWtW-0000gv-VN; Wed, 21 Jan 2026 07:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viWse-0000ah-Mr
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:00:20 -0500
Received: from p-west2-cluster3-host2-snip4-1.eps.apple.com ([57.103.69.114]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viWsb-0002vV-9T
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:00:12 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPS id
 A912E180082B; Wed, 21 Jan 2026 12:00:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1768996806; x=1771588806;
 bh=a+lQCKXBAvXTVVuVn+CRKuMTtY68CWZpCiRy2ucwCgc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=NfQpFJ1fYNNjPpJFZJ7Hk7CBptp+IziZyB/k7ehtu0XA0A1cfIGQ4eWoY+IaC1NirRmohywroIGwwa00zDhl4fil46erVB7TrsB3owEiqSKn6WfEyT3f36TmhA4MojqKX5F9KEubZObbD7d2fS4KDrGGK5zT21149vEXEugwNsdzOQ/dr/FUqzDOsVT0rxbOoWp5mW35jDgIOdZBUg1EnqQRO3SwigKAe7m0rHc9CjywyRYMPsYKQlqiyVDsMSPTX0Zbez0eGVmHJRpUb134XlsMWe0aNYioZCEhcSlvjzqIreSfEl1FOv1bqn3Ksd4nrnxu5k+fqTB2aPJcFdFSzw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPSA id
 D502F1800100; Wed, 21 Jan 2026 12:00:02 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-MAsQpaaUx0dJHRHjUJ6bEWwnf58VZN965Npmi7_kHXQ@mail.gmail.com>
Date: Wed, 21 Jan 2026 12:59:50 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: 7bit
Message-Id: <FF6F91A9-9A09-48B1-8857-FF213C9A4644@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
 <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
 <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
 <2FD2C3C6-8FBA-4833-B890-5E81637BE7EE@unpredictable.fr>
 <CAFEAcA-MAsQpaaUx0dJHRHjUJ6bEWwnf58VZN965Npmi7_kHXQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: m18ur5PGwdeXMePaux4aTsboCCzNr80f
X-Authority-Info-Out: v=2.4 cv=adpsXBot c=1 sm=1 tr=0 ts=6970bfc6
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=8tVNtdTugjW4QW2w:21 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=6L9mPoyCFPhPlnlynBcA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: m18ur5PGwdeXMePaux4aTsboCCzNr80f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEwMSBTYWx0ZWRfX01ox9m3gMeAy
 efw4eYeQrWFHSHpKpdmDKVT1z6gAdNt7m96opovST4V/gzy1geUfz016vC4FSMrBOMS4XSFernJ
 zHSeH+NMjV+1NZ6LGut4uKF2z8ZJ0zkd1+JtNPvwgt/+KdE6zZ/UOJGFooj4wBNYVmJkhXCndUv
 2XA7A+sUz65HhbhVTOb8HUpfbncs/7JNpXm//VPW3OH2T1yAHIEYZFDlNuuIZMoMnRv37LkNOeU
 aKFe7OOfjbu5N5mf82l3wYjaqSIfux9ULBopf6XubOUqum3axWuM+4qKGCoyBJqvZ3aDWM6ZTaf
 6A1KpOogxwjJFSRX2xPSBV9s9r62zL2d9/MKRoVtLCP+eAX+JDsLHat5+TzmiM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=954
 phishscore=0 clxscore=1030 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601080000
 definitions=main-2601210101
X-JNJ: AAAAAAABJAbadpVE6Ub8deAr1apzUAKk4YG98kepVOys25alnYwxu6aCM5jz7wYzn7uEO8DORUzNiinHG59vzf6EBA3C+fa1hNLkmZDqTzbzYqOAXjm08ryUA9h4Q2PfL/1jR4Y+Jsi68rBahM7lSXfPSa+p7/VMmaITwER8HN3nPXVtEyHHszOV7EgPNfjVFstoIDEUP8Xs/iN15ISuO3xUepKvcKvDFIdTsRmgzjIwYWeoGbETlSpCkOY/f+bbdTbsls0bLbYy/lCO4JXhm9TsFyro/J7z3xlKf1gHcbG/Z0MMi+EqyH68yh91FBKaw5SlRtKDhI+h1qPJqmp8GulyTXHTymVFmkai5WDhlH5RZzJYBoKK37cME+Gmg0aGWfPwd4w1FEyv0m9Xg/tmhJI1H9GnFLySXVYtJM10aECr83DtHmFx4qZOeSeZkbToEKPKa8VFUEyZYu+vOlFDVKKxw0llH9CcEjV41J78P834jPPLUcvcE8EnkDS60tuXRQ1A2r7F7S3ru2JdchJ7hKzU2Pr5HXb9nNAx/rF0XF/2eEuwq8knNMouQZvq5IgqNYGTDgGZFMx2D4wUL0Wfcwz5YPGCpUqBrQW2pfRSlQgxLx1Sb3Ik2bfbDmTAYSpCqCJEIBXVy79W9LSTbbczhMtv5S/aAZPuuAmQTb5nWNYPvvkskDX8o6UMgSuD+zmnWlg51y3A6n18YEDnBvUIOrYvLtA5XKtIHowsyVL+pAdRwpxdhe/skYU+FcnQmUh/r0bQGB8Nhl1oLhc46XuR39Hg5jDRoGCmthtJ0fk+HVfJbzV2bdzRatEQxtAcWkk=
Received-SPF: pass client-ip=57.103.69.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 21. Jan 2026, at 12:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> which I think means we do need
> the its option to be an on/off/auto one

Hello,

Would this be ok instead?

typedef enum VirtMSIControllerType {
VIRT_MSI_CTRL_NONE,
/* This value is overriden at runtime.*/
VIRT_MSI_CTRL_AUTO,
/* Legacy option: its=off provides a GICv2m when using GICv2.*/
VIRT_MSI_LEGACY_OPT_ITS_OFF,
VIRT_MSI_CTRL_GICV2M,
VIRT_MSI_CTRL_ITS,
} VirtMSIControllerType;

Combined with:

static void finalize_msi_controller(VirtMachineState *vms)
{
if (vms->msi_controller == VIRT_MSI_LEGACY_OPT_ITS_OFF) {
if (vms->gic_version == 2) {
vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
}
else {
vms->msi_controller = VIRT_MSI_CTRL_NONE;
}
}

Thank you,
-Mohamed

