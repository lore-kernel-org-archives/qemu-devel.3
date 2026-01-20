Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63896D2628A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGiA-00072i-Eq; Tue, 20 Jan 2026 13:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viGi8-0006wr-8F
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:44:16 -0500
Received: from ci-2001j-snip4-7.eps.apple.com ([57.103.91.100]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viGi5-00072v-Pg
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:44:16 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 7F8D91807433; Tue, 20 Jan 2026 18:44:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1768934652; x=1771526652;
 bh=6woRe8jTuj6yZ/WBDzOGbJo3INWTQfSFKjPkUVscoE4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Zv6r54Sjr75Cybh6N88WQNvXdoFkIy9gUvZg56lGIS6+xdtGMgX6BmkpkZ2Dy8wEAoBKK3TH/t7RmyS/Ig0EWZXakc5HvzbuxE9FYF3zLWi8SNUxQ8A6iVXWKhG5+oM9X/PuwPQzM+Tkx46bQpfQOCAfSKeDvDaRIZqlsLX8hC7tkYqp2lc5LlMn4D9rFbiimiLvd9KrF2+oHvHa+khnCmxTyLqZNkYiZd1Rop7bO0OgiWqgGjK0q8/YP6ub7iSo031mwqBIH2MMThobnS1bYm5jgfSx/n7UY+Mhl6eDEuADuBhku8cq/QqSY/CJFL9A6n3WU/1fGabQrw4qt1gnTw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 ED33618170B4; Tue, 20 Jan 2026 18:31:33 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
Date: Tue, 20 Jan 2026 19:31:22 +0100
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: IQMB32Rzn7WyiNvAqKg-8hszxKdXZ2zs
X-Proofpoint-ORIG-GUID: IQMB32Rzn7WyiNvAqKg-8hszxKdXZ2zs
X-Authority-Info: v=2.4 cv=DZ4aa/tW c=1 sm=1 tr=0 ts=696fccf9
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=8tVNtdTugjW4QW2w:21 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=RnglCoYQ5a6lEa2ZeEsA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE1NyBTYWx0ZWRfX19cT9fUl5GnM
 bM56+yNnsT2x2pttkhPYJBQQRLPqHV1yoKRIse+/FzwMeF1vb2Oan460sZF1RfywIXmm/c5rWgY
 pJpdoisEVVM1amvuzbEyLNkDf2cB3RKK0+TfB/IUV6sRU7uspRQnlNGV7ZdjpaZm5ugYqW+Y9Xx
 5X9Fn+6yImVOc7UtScYZW6iITbwS76smq3vjdBczmd8Wb7Tq76KyCVkt+n03IdJHwexG/fpspf6
 g9Yf5ZL6ORDYrXvW6lUJ9j+sPJrgNh8zvOrJxdNb+gBx+/FBvKpyoLUBGrMg/mGZcmlgBG/QrNw
 7LnDxR+/hNYf6OfCwf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601200157
X-JNJ: AAAAAAAB7r40ZohuCB8s6D8P9BknfoGPXb1Z1SSqaXS1L86OEOuZYV4O/8xRfKD+HuLXcM+TUi4KC57fhg3a8hgKa6+HsyHwtuzD+TbndrCnwYmsrGD1NBG39rUsDygOQfKtWGLVtKPImxDJqHg9gqsUCjnqaoYcmg8UgQqk1TAxcw1zAS9gjdPMgTWwXT0IWYXIyy30Gc3RBoJEezDjkUL38zmFRw43Tf+7m3WNZ8DcYKmumEVckXxund37GSuVbdGJ3cqE7QWLXvdi0WeRI16gCIuN7OGBj+2tfAgXwlUKulw5bpmNC8L0lY6AfiFJk1fw8wn2pw3pYpOHgKr1zcQXq611DBw5s1w3/luxowlTcG3u5xNtHLHgKCyG+DJ/+dMKm64OeY4svZMBcrTLE8kHHPZ9KBDKdbPXyXv787TB2ZDVZHAB4s6mZZ9h9xvzGU3NC7L3IwmmzU/iORobEPeVg9hth3NMduAjkHFdA5VLFPfjOrtIzVVzUEcOCFbCCFl9FqFM8as92ccKFdNE4mecTq7Ub8N0Y3QFQjPjX/UvdkUWWaXxaWjV4xQbslydeQqX+NdNS/uC2Ec+40tF2302Re9h4QQ9csxRdd0R13QLuJDFnwHpPutG3Zj2V6TyRZsXk6I12ABXJNy5oQrSaceQgDeomeG6R1+wvFpt93FNta7AA5u+JVe/1oGV8Bf2VHwEhIOy9Y/QH88K6vY7EXhL7OkaWfe6Bl1D8wz53cz8NHblkddtn4EXkbs3/WB4F9blahejXZut7cy1dgHKasv1YZ3oE7yS1gmckx0tPHEVZJf9WEe+FQA1AmY=
Received-SPF: pass client-ip=57.103.91.100;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



> On 20. Jan 2026, at 19:02, Peter Maydell <peter.maydell@linaro.org> =
wrote:


> The MSI controller selection logic is already pretty confusing,
> and this is making it more complicated. I don't think we should
> need this machine back compatibility, because currently there
> is no setup where you can have a GICv3 that doesn't also have
> either an ITS or no MSI controller.
>=20
Hello,

This was to replicate the =E2=80=9Cno_tcg_its=E2=80=9D where this was =
done when introducing TCG.
And for the purpose of VM save/restore on HVF with the older machine =
type continuing to work as expected.

Also worth noting that for HVF specifically GICv3 + ITS works today when =
using kernel-irqchip=3Doff
and that only kernel-irqchip=3Don to leverage the hardware vGIC =
doesn=E2=80=99t support it.

> I think also that we can make the code cleaner if we:
> (1) clean the existing "pick an MSI controller" logic up
> so that we do it up front, the same way we do "pick a GIC
> version"
> (2) add the new "msi" property and deprecate the old "its" one
> (3) then add the gicv3-with-gicv2m-on-hvf logic to that
>=20
> I see this series adds an "msi" property, but it also
> makes the old "its" property an OnOffAuto -- do we really
> need both ?
The =E2=80=9Crework MSI-X configuration=E2=80=9D patch in the series =
flips the =E2=80=9Cits=E2=80=9D property
back to a bool.

Would it be better to reorder that earlier in the series or keep it as =
is?
Squashing the =E2=80=9Chw/arm: virt: cleanly fail on attempt to use the =
platform vGIC together with ITS=E2=80=9D commit
with =E2=80=9Crework MSI-X configuration=E2=80=9D is an option too.

Thank you,
-Mohamed
=20
> I wrote some code for this this afternoon before I realised
> that you'd done the "msi" property in that series (so the
> duplication with your work is my fault). I'll send them
> out as an RFC to give an idea of what I have in mind.


