Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6D6C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 14:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtpq-0007Dh-DM; Tue, 13 Feb 2024 09:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1rZoVh-0006W2-Ml
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:51:25 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1rZoVc-0007lU-6X
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:51:24 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240213085110epoutp049a53f8dd0913dc37de5c7798c5daa3a5~zYAfQWxfJ2734227342epoutp04a
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240213085110epoutp049a53f8dd0913dc37de5c7798c5daa3a5~zYAfQWxfJ2734227342epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1707814270;
 bh=vTDlUID+ylMURWDXEr2PkKAHbiTjjbGicX8quns1Bdc=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=t7KvqwLl/+QMUC5D32WFuOROMtapkPGaYpCEw9gPjrQ2nRIuqvsCb3UlSCptSUyce
 uLhmejC6/OPWRqtr4ey8d1sdq4AUs+45Xc/Hh+LTlYuuNDeusbaCwt7F9AA35LIr3x
 Wa91QUVesY4sFqe83/x14aiCIr4j9j12gUtuIt+U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240213085109epcas2p4dac67a8db1fc2ccdfef463c19d078505~zYAecMN4J1781017810epcas2p4y;
 Tue, 13 Feb 2024 08:51:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4TYw646rPQz4x9Q3; Tue, 13 Feb
 2024 08:51:08 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-78-65cb2d7cde66
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 55.2F.10006.C7D2BC56; Tue, 13 Feb 2024 17:51:08 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 6/7] pcie_sriov: Reuse SR-IOV VF device instances
From: Minwoo Im <minwoo.im@samsung.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Sriram
 Yagnaraman <sriram.yagnaraman@est.tech>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Minwoo Im
 <minwoo.im@samsung.com>, "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240212-reuse-v3-6-8017b689ce7f@daynix.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240213085108epcms2p86672b5f11b0b4a22244256b85c66721c@epcms2p8>
Date: Tue, 13 Feb 2024 17:51:08 +0900
X-CMS-MailID: 20240213085108epcms2p86672b5f11b0b4a22244256b85c66721c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmqW6N7ulUg/2zTCw+n1rLbvHtfw+b
 xZs3a5gs5v1Zy2rxfOpSJov9B7+xWiy79JnJYtKha4wWL9tPMFv86uS2eHb6ALPF/1+vWC32
 b/vHarFmhbDFrHftbBbHe3ewWPRuesHkIOhx4u1BVo8Lj84xe+ycdZfdo+PCMSaPczvOs3ts
 WtXJ5nHn2h42jyfXNjN5vN93lc2jb8sqxgCuqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
 A0NdQ0sLcyWFvMTcVFslF58AXbfMHKCHlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
 KTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGQuajzIVXBKueL/xOFsD41ehLkZODgkBE4ne
 w22MXYxcHEICOxglNu28yN7FyMHBKyAo8XeHMEiNsICHxMO+LywgYSEBeYkfrwwgwpoS73af
 YQWx2QTUJRqmvmIBGSMisIVVYuGEY2BjmAXSJBq3sECs4pWY0f4UypaW2L58KyOIzSlgJfFy
 YhcTRFxD4seyXmYIW1Ti5uq37DD2+2PzGSFsEYnWe2ehagQlHvzcDRWXktg/fy6UXS3RcPwZ
 1MwKiV/vH0DVm0v8vr8b7GZeAV+Jx983s4HYLAKqEpN2T2ICOVlCwEXi5Wp+kDCzgLbEsoWv
 mSE+0ZRYv0sfokJZ4sgtFogKPomOw3/ZYR7cMe8J1FJliY+HDkEtlZRYfuk1G4TtIbGhczfL
 BEbFWYhQnoVk1yyEXQsYmVcxiqUWFOempxYbFRjCIzY5P3cTIzhda7nuYJz89oPeIUYmDsZD
 jBIczEoivJdmnEgV4k1JrKxKLcqPLyrNSS0+xGgK9OREZinR5HxgxsgriTc0sTQwMTMzNDcy
 NTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoHJ08PESLz57N4Yz/DrgZrmFh8nucvEXFty
 ZGqUjrjx00/md4R8GCzP8J5dpGch7nlQ2PThtJu1ek8er3Cs1rKTkRPOzg+2vnzOdTVbe4rw
 frvn3+I33rIurJH8fcDFd5GUqkPwgksyh3SMJp/99aA0+qu8fbjK6vycG8meBruyuV+1X7+f
 3vCbwW/qB5vrs264TP5WdeT1RGOpOeerv05QTKy8Onnmw1JXmXvbfDgckzum3fVapPR6/tIZ
 bfsyJtw58PG9u3zd/M7wry6V4R9vcH47f/KI4x6+j30XP92ao7Cb78LjKKaeb5nHb9Q8vPZy
 zpZHvIFHf7lybE57ENcQ0m+eujdeaavU94YbvG+PKbEUZyQaajEXFScCAJh6JT5gBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240212102210epcas2p4346c0dfc475ecee9f359d634eba46783
References: <20240212-reuse-v3-6-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <CGME20240212102210epcas2p4346c0dfc475ecee9f359d634eba46783@epcms2p8>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=minwoo.im@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Feb 2024 09:32:28 -0500
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
Reply-To: minwoo.im@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> -----Original Message-----
> From: qemu-block-bounces+minwoo.im.dev=3Dgmail.com=40nongnu.org <qemu-blo=
ck-
> bounces+minwoo.im.dev=3Dgmail.com=40nongnu.org> On Behalf Of Akihiko Odak=
i
> Sent: Monday, February 12, 2024 7:21 PM
> To: Philippe Mathieu-Daud=C3=A9=20<philmd=40linaro.org>;=20Michael=20S.=
=20Tsirkin=0D=0A>=20<mst=40redhat.com>;=20Marcel=20Apfelbaum=20<marcel.apfe=
lbaum=40gmail.com>;=20Alex=0D=0A>=20Williamson=20<alex.williamson=40redhat.=
com>;=20C=C3=A9dric=20Le=20Goater=20<clg=40redhat.com>;=0D=0A>=20Paolo=20Bo=
nzini=20<pbonzini=40redhat.com>;=20Daniel=20P.=20Berrang=C3=A9=20<berrange=
=40redhat.com>;=0D=0A>=20Eduardo=20Habkost=20<eduardo=40habkost.net>;=20Sri=
ram=20Yagnaraman=0D=0A>=20<sriram.yagnaraman=40est.tech>;=20Jason=20Wang=20=
<jasowang=40redhat.com>;=20Keith=20Busch=0D=0A>=20<kbusch=40kernel.org>;=20=
Klaus=20Jensen=20<its=40irrelevant.dk>=0D=0A>=20Cc:=20qemu-devel=40nongnu.o=
rg;=20qemu-block=40nongnu.org;=20Akihiko=20Odaki=0D=0A>=20<akihiko.odaki=40=
daynix.com>=0D=0A>=20Subject:=20=5BPATCH=20v3=206/7=5D=20pcie_sriov:=20Reus=
e=20SR-IOV=20VF=20device=20instances=0D=0A>=0D=0A>=20Disable=20SR-IOV=20VF=
=20devices=20by=20reusing=20code=20to=20power=20down=20PCI=20devices=0D=0A>=
=20instead=20of=20removing=20them=20when=20the=20guest=20requests=20to=20di=
sable=20VFs.=20This=0D=0A>=20allows=20to=20realize=20devices=20and=20report=
=20VF=20realization=20errors=20at=20PF=0D=0A>=20realization=20time.=0D=0A>=
=0D=0A>=20Signed-off-by:=20Akihiko=20Odaki=20<akihiko.odaki=40daynix.com>=
=0D=0A=0D=0AHello=20Akihiko,=0D=0A=0D=0AI=20think=20this=20patch=20fixes=20=
the=20issue=20reported=20in=20=5B1=5D.=20=20The=20latest=20master=20branch=
=0D=0Aalso=20causes=20an=20object-related=20assertion=20error=20when=20we=
=20enable=20VF(s)=20and=20disable=0D=0Athrough=20sysfs=20over=20and=20over=
=20again=20(at=20least=20twice).=20=20But=20this=20issue=20is=20also=0D=0Af=
ixed=20with=20your=20patch.=0D=0A=0D=0A**=0D=0AERROR:../qom/object.c:753:ob=
ject_finalize:=20assertion=20failed:=20(obj->parent=20=3D=3D=20NULL)=0D=0AB=
ail=20out=21=20ERROR:../qom/object.c:753:object_finalize:=20assertion=20fai=
led:=20(obj->parent=20=3D=3D=20NULL)=0D=0A=0D=0AKlaus,=0D=0A=0D=0AIf=20this=
=20patchset=20is=20applied,=20I=20think=20=5B1=5D=20can=20be=20dropped.=20=
=20What=20do=20you=20think?=0D=0A=0D=0AThanks,=0D=0A=0D=0A=5B1=5D=20https:/=
/lore.kernel.org/qemu-devel/20240109022953epcms2p54550dcfc9f831a515206513ae=
98e7511=40epcms2p5/=0D=0A

