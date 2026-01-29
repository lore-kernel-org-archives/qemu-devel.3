Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD20D6B07A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUqN-0000tZ-Mk; Thu, 29 Jan 2026 11:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlUqL-0000rH-AK
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:26:05 -0500
Received: from p-west2-cluster6-host4-snip4-10.eps.apple.com ([57.103.70.23]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlUqH-0001Ym-1W
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:26:04 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 AC2F21802865; Thu, 29 Jan 2026 16:25:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769703958; x=1772295958;
 bh=u7JR/QEHfBc0afNOBZpHjuOgKsOQYt/dW6wfv1v0bBU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=O9R0TUpkyVPEpO11VvqGmhHk5SwINbJmGqGvipHPldJ+wloAffnLmu8kpseLWZAurswLyWdgWPYrA1TPP7Gvj/Q46gdLuPlkjHUecEGU4RnRdxKExliYv6XSdTEz+VvohAJ8aQIYyrahIplMhwlWbvvdQb/Nt57QKumJZm0TCrgTcASH4sy1wSBUMMcTfBMqhVSTWMd2XKjK6X4l48Mok1swNFZVmMhtoDnQX2t6Z5vZqs/AEKV/Iw9ZOusY+a+8bgSa044EJ4oUVI+hhvzi72CzBTlU5WyezXxCsDsfh9NHxVmfuIjateUZaiY01sQ8xk5PiJZU5JKZWurFHLkiLg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 2616C1800104; Thu, 29 Jan 2026 16:25:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v18 20/22] target/arm: whpx: instantiate GIC early
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9TwmftmcnxbWMoeAfuV6LD9pPv1hVXiAOr56UKUD+z+A@mail.gmail.com>
Date: Thu, 29 Jan 2026 17:25:40 +0100
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <87D4EF8E-4F4C-42B2-947F-FCF474C4B4BD@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-21-mohamed@unpredictable.fr>
 <CAFEAcA9TwmftmcnxbWMoeAfuV6LD9pPv1hVXiAOr56UKUD+z+A@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info-Out: v=2.4 cv=GJkF0+NK c=1 sm=1 tr=0 ts=697b8a16
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=nuPN9-Hf8ev9G2Z7EDEA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExNSBTYWx0ZWRfX606TjfPenkpm
 /0d5Y/7U08J3pX2Mwl+nr8xpveCJNTacPQUrGoVpd8dftHR26UZgSoaLkWwJVkqKB+0BVPgnmtd
 94E6S1NB/BRCpKq7V2MCKBixYmZLviPq7MpBOqw2b+IAWUPFme07Qbtg0uzPuQo02/hGM1B/h8Z
 gAbBVs2iC6Kt+6QNXBrBI+Ps30B8ICcwL8y47cQYl1IVNXdit0hLbjnPfk1df1ZlAycDdHS/rSf
 v/DT5Sksv6T3pDyu2ODdJH7lT3ijdkgRjpiQvDjaQyd9u6AQsWYZLBD5dAf4NsL8v5lK0iu5IOQ
 u+kQlJIFbAKSiIwOfaYxWXPb2smBu4/fphaj+eys4Gel1K8kueATlRNeRkJsto=
X-Proofpoint-GUID: 0lzokR_w8rWbuivC2niLBbjucmGFeQqU
X-Proofpoint-ORIG-GUID: 0lzokR_w8rWbuivC2niLBbjucmGFeQqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=841
 bulkscore=0 mlxscore=0 clxscore=1030 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290115
X-JNJ: AAAAAAAB5ydCaMsz0wwLZdQI515UjmpKLlSEOqAdvrOpVivlGpB7INi4V32WZLpOUVxU4SSulFFMm9I9Gtb8+OW/66whKMlO0OiW2HFXM3OXBbtaYfWd7WF1tWH27rW0nzbfbsUVirW0b1B6FS2PzxPyZCh/hAYX2MwroNtBeQeYVlxyiZjtACdDrq7EJniNb/OTfDBW8NpmQKQdVnTn5/QVt3TwpTygguckp1mGysdei2DLadGfWubc3FynkRNdpQ/YOSXUSwDuZrqmUfTh6/bQm17Z8lieDluWAcD0gUBRcOzVkGCXOQ8eioNahQmXIaNbilNdTht2YoEzMJoYI1BD7bkxKpCb1TEQ0A1iNmuEbL8dTYhq4dJPXD/shkjF+076ul2xB5d116GtK0Rj058sUgSqgdBSWCkF/1OJimOF+C094qtpg9aWd6IxqJ5BvhMMm0XhS40rWy7PYVqjrEdQnGF8ILWSQLCx+bdi0gPksONfc3yUOsZcC/Vtyt8h9vpe2iphVZtlrA6mFLBkkCuQOjlErzM2zEiKK7bRYvFtjqN/LWfYkr07PhjD2+ZKNTvpcVSxz1OQONjqXayAz8M+buDP5HoRyC03Km0OBBjYM2tGABlR7hHMz1h0aDdAjq/ILEcA6XHiuPWhl0WoNk6QpaE+1k6sIgRKvqfO529CwlqSTGLkriU/pJ68hlisfvLFleYBaZyeiX5ZkOIIm6HpLEeikTIDPlS6DLQYLAfQKsHsJcKEDpvGjCpbLJANBkWb1ZHgKDvqXw+rcFAxeQ1Xf7hGlEYT02nQxGsD2teOdHihZ8wWIdU+xQNc5XW/1ag7rbqJxmxqXZjy3axu3+3NLQj2rLPw4R+SgSfuViHvYuUJOA+fyOhch5eSZuDTQyZ24g6tZSgZLVc8sA/x9Bm16j0=
Received-SPF: pass client-ip=57.103.70.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 29. Jan 2026, at 16:31, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> So what happens if the user asked for a GICv2 ?
>=20
Hi,

If the user asked for a GICv2 then they=E2=80=99re going to get an error =
in
finalize_gic_version_do (in hw/arm/virt.c), with it being enforced =
there.

> Can we have a comment to explain the ordering requirement
> mentioned in the commit message that is forcing this to be
> here rather than in the GIC code ?
Will add in the next revision.=

