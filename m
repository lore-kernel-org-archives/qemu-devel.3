Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTklZ-0002C1-KX; Tue, 16 Jul 2024 12:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@samjakob.com>) id 1sTklU-0001zL-Em
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:10:56 -0400
Received: from qs51p00im-qukt01071701.me.com ([17.57.155.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@samjakob.com>) id 1sTklS-0002wc-Gn
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samjakob.com;
 s=sig1; t=1721146250;
 bh=KjtVo/OCWQ0RNtoc5VyV2ztYRA6Jh4iaDgpmRDZu1JU=;
 h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
 b=q4/Q+C4uORALVY4z5Knema+XWUBSyoJgswV/fnr0z3ljmoU9fzCmBF+HX1e9MEK9l
 0d65XXt/1uhl/wyVjuyLmAS0hrNlE3AoAXQ12/3auPrBBd40wO/TM2GTA83ywAMwNI
 SEIJzTT22fO4dTBmCWQ9K0a/sNV/j2lk/S7tgj9H0ALiG8lO5wzvEGg3vFNS4Djlx0
 MKQRe3xImAwsfdB/EGKC8dO3lEWxYpEulRfKr6VgW7HLiTNgVWZxtkNvP27IOX4Pfl
 TMIFYXsjIgSFGBaIdIyx5buYF3MgUWVCyBGh+sm9hRpPP0xWLf2Xa99UjugYbp3qu/
 pQXwe7uDLGyBA==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01071701.me.com (Postfix) with ESMTPSA id 0BA474D003C5;
 Tue, 16 Jul 2024 16:10:47 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: "Sam M." <me@samjakob.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] hw/display/bcm2835_fb: fix fb_use_offsets condition
Date: Tue, 16 Jul 2024 17:10:35 +0100
Message-Id: <2CF81837-4459-4C1D-9CFA-3E689A9F7AB6@samjakob.com>
References: <CAFEAcA_jA9BnBRYZK8b15ibp7SFw0PNKb7H=-xs4p=ttOesahg@mail.gmail.com>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
In-Reply-To: <CAFEAcA_jA9BnBRYZK8b15ibp7SFw0PNKb7H=-xs4p=ttOesahg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: iPhone Mail (21F90)
X-Proofpoint-ORIG-GUID: K5L0EAUgy5I-1nrINYMwqh3PZaFa305y
X-Proofpoint-GUID: K5L0EAUgy5I-1nrINYMwqh3PZaFa305y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 clxscore=1030 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407160119
Received-SPF: pass client-ip=17.57.155.6; envelope-from=me@samjakob.com;
 helo=qs51p00im-qukt01071701.me.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Thank you!

My apologies for the duplicates and alignment - it=E2=80=99s my first time u=
sing a mailing list!

> On Jul 16, 2024, at 3:44=E2=80=AFPM, Peter Maydell <peter.maydell@linaro.o=
rg> wrote:
>=20
> =EF=BB=BFOn Tue, 16 Jul 2024 at 15:37, Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org> wrote:
>>=20
>>> On 16/7/24 12:35, Peter Maydell wrote:
>>> On Sat, 13 Jul 2024 at 17:04, SamJakob <me@samjakob.com> wrote:
>>>>=20
>>>>         It is common practice when implementing double-buffering
>>>>         on VideoCore to do so by multiplying the height of the
>>>>         virtual buffer by the number of virtual screens desired
>>>>         (i.e., two - in the case of double-bufferring).
>>>>=20
>>>>         At present, this won't work in QEMU because the logic in
>>>>         fb_use_offsets require that both the virtual width and
>>>>         height exceed their physical counterparts.
>>>>=20
>>>>         This appears to be unintentional/a typo and indeed the
>>>>         comment states; "Experimentally, the hardware seems to
>>>>         do this only if the viewport size is larger than the
>>>>         physical screen". The viewport/virtual size would be
>>>>         larger than the physical size if either virtual dimension
>>>>         were larger than their physical counterparts and not
>>>>         necessarily both.
>>>>=20
>>>> Signed-off-by: SamJakob <me@samjakob.com>
>>>=20
>>> Thanks for this bugfix; I've applied it to my target-arm.next
>>> queue and it should get upstream within a week or so.
>>=20
>> Since I'm seeing 2 times the same patch, adding R-b again on
>> this one:
>>=20
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>=20
>> (BTW Peter the commit description is mis-aligned, if you
>> don't mind, correcting it while applying would be appreciated!)
>=20
> Yep, I already picked up your r-by and rewrapped the commit
> message.
>=20
> -- PMM

