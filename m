Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DECCA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 18:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo4oh-0006iw-Jj; Mon, 18 Aug 2025 14:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1uo4od-0006iN-IB
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 14:42:43 -0400
Received: from ma-mx03.apple.com ([17.23.4.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1uo4oa-0001Gt-VH
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 14:42:43 -0400
Received: from mr55p01nt-mtap01.apple.com
 (mr55p01nt-mtap01.apple.com [10.170.185.217]) by st47p01nt-mxp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPS id <0T171PILQD2NG000@st47p01nt-mxp03.apple.com> for
 qemu-devel@nongnu.org; Mon, 18 Aug 2025 18:37:36 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-type : date : from : in-reply-to : message-id : mime-version :
 references : subject : to; s=20180706;
 bh=TbOT6QbePF1QL/NVtq+GDEAVcqHRvu0D0omtbxre1W0=;
 b=bLTQIbfXmaXGT/c7RjWT69zLuSaSX0aRIuXiutfSYHX9jK0vXIWUQ+vy+sg3yfR6FohZ
 eZ65Ptg+Ch1+u4OY8/frwyjcELH8nF/oFg/AIeRqJavIvfP4QDOwyAqJmxpA4F34rAlK
 O5GTMbciaU+hymGP6D1d28WomuhWoJD27IZxXr51y0+fuKpNPjBBwXWS8oHz2OEwPFlJ
 TM1pnXgPih1euhh6m+z1zUx34iVgH/QmBooP68WhGEurb4pRthxMNUsrq+D0/i4dnoL9
 A/cG838cB3dbtg+rfKpvM9+ee5hEerlU3Y2+MUMnf4vi5t/40s/AzlzcSC4SNVV/ce40 Xg==
Received: from mr55p01nt-mmpp07.apple.com
 (mr55p01nt-mmpp07.apple.com [10.170.185.196]) by mr55p01nt-mtap01.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPS id <0T171Y301D2NQZK0@mr55p01nt-mtap01.apple.com>; Mon,
 18 Aug 2025 18:37:35 +0000 (GMT)
Received: from process_milters-daemon.mr55p01nt-mmpp07.apple.com by
 mr55p01nt-mmpp07.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) id <0T1716A00CQT2R00@mr55p01nt-mmpp07.apple.com>; Mon,
 18 Aug 2025 18:37:35 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: c44a9cfa28000692834f9157fcd48a55
X-Va-E-CD: abe6248b455a2058582786f87b6ed178
X-Va-R-CD: 47b02566b5ccdbc2976f7a5dffd4806f
X-Va-ID: a4c45a1e-0701-4b97-a77e-a8f00c2cbe89
X-Va-CD: 0
X-V-A: 
X-V-T-CD: c44a9cfa28000692834f9157fcd48a55
X-V-E-CD: abe6248b455a2058582786f87b6ed178
X-V-R-CD: 47b02566b5ccdbc2976f7a5dffd4806f
X-V-ID: da8bb949-a177-4f0c-b389-93595ab11778
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
Received: from smtpclient.apple (unknown [17.11.180.195])
 by mr55p01nt-mmpp07.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPSA id <0T1716E49D2MMZ00@mr55p01nt-mmpp07.apple.com>; Mon,
 18 Aug 2025 18:37:34 +0000 (GMT)
From: Danny Canter <danny_canter@apple.com>
Message-id: <BCCED674-EAEF-4755-9BE1-116FB36FB5C9@apple.com>
Content-type: multipart/alternative;
 boundary="Apple-Mail=_60D27284-DEB7-4226-BAA3-8D54ECE19A96"
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3859.100.2\))
Subject: Re: [PATCH 4/7] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
Date: Mon, 18 Aug 2025 11:37:23 -0700
In-reply-to: <a4a4c7a8-df35-4bd3-9de1-b22ca7bcca22@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Akihiko Odaki <akihiko.odaki@gmail.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-5-richard.henderson@linaro.org>
 <4312974c-9b7e-48c2-a190-071ea72da33f@linaro.org>
 <5b9e5f5a-b434-479c-8840-dbb4cda1365c@linaro.org>
 <a4a4c7a8-df35-4bd3-9de1-b22ca7bcca22@linaro.org>
X-Mailer: Apple Mail (2.3859.100.2)
Received-SPF: pass client-ip=17.23.4.21; envelope-from=danny_canter@apple.com;
 helo=ma-mx03.apple.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--Apple-Mail=_60D27284-DEB7-4226-BAA3-8D54ECE19A96
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Howdy,

On macOS versions/SDKs before 26 you are correct, we had an invalid enum =
value for HV_SYS_REG_MDCR_EL2 in the API, but the =
hv_vcpu_get/set_sys_reg APIs work with this value even though the
encoding is incorrect. The enum value has been remedied in 26+ (0xe089 =
as you pointed out) and has been done in a backwards compatible way =
internally in the framework.


> On Aug 18, 2025, at 8:46=E2=80=AFAM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Cc'ing Apple folks hoping they can forward or directly help :)
>=20
> On 18/8/25 15:21, Richard Henderson wrote:
>> On 8/18/25 22:41, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Rebasing Mohamed's work I'm getting:
>>>=20
>>> In file included from ../../target/arm/hvf/hvf.c:413:
>>> ../../target/arm/hvf/sysreg.c.inc:156:1: error: static assertion =
failed due to requirement '!(HV_SYS_REG_MDCR_EL2 !=3D (((((1 << 28) | =
(19 << 16) | ((3) << 14) | ((4) << 11) | ((1) << 7) | ((1) << 3) | ((1) =
<< 0)) | 13510798882111488ULL)) & 65535))': not expecting: =
HV_SYS_REG_MDCR_EL2 !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(1, 1, 3, 4, =
1))
>>>    156 | DEF_SYSREG(HV_SYS_REG_MDCR_EL2, 1, 1, 3, 4, 1)
>>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>      HV_SYS_REG_MDCR_EL2 =3D 0xe019,   <----
>> How odd.  It should be e089, if it were encoded like all the others.
>> I wonder if this is a manual typo that's now baked into the api, or =
if it's an OS bug.
>> r~
>=20


--Apple-Mail=_60D27284-DEB7-4226-BAA3-8D54ECE19A96
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div style=3D"orphans: 2; widows: =
2;"><font color=3D"#37383a" face=3D"Slack-Lato, Slack-Fractions, =
appleLogo, sans-serif"><span style=3D"caret-color: rgb(55, 56, 58); =
font-size: 15px; background-color: rgb(255, 255, =
255);">Howdy,</span></font></div><div style=3D"orphans: 2; widows: =
2;"><font color=3D"#37383a" face=3D"Slack-Lato, Slack-Fractions, =
appleLogo, sans-serif"><span style=3D"caret-color: rgb(55, 56, 58); =
font-size: 15px; background-color: rgb(255, 255, =
255);"><br></span></font></div><div style=3D"orphans: 2; widows: =
2;"><span style=3D"caret-color: rgb(55, 56, 58); color: rgb(55, 56, 58); =
font-family: Slack-Lato, Slack-Fractions, appleLogo, sans-serif; =
font-size: 15px; background-color: rgb(255, 255, 255);">On macOS =
versions/SDKs before 26 you are correct, we had an invalid enum value =
for HV_SYS_REG_MDCR_EL2 in the API, but the hv_vcpu_get/set_sys_reg APIs =
work with this value even though the</span></div><div style=3D"orphans: =
2; widows: 2;"><span style=3D"caret-color: rgb(55, 56, 58); color: =
rgb(55, 56, 58); font-family: Slack-Lato, Slack-Fractions, appleLogo, =
sans-serif; font-size: 15px; background-color: rgb(255, 255, =
255);">encoding is incorrect. The enum value has been remedied in 26+ =
(0xe089 as you pointed out) and has been done in a backwards compatible =
way internally in the framework.</span></div><div style=3D"orphans: 2; =
widows: 2;"><br></div><div><br><blockquote type=3D"cite"><div>On Aug 18, =
2025, at 8:46=E2=80=AFAM, Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>Cc'ing Apple folks hoping =
they can forward or directly help :)<br><br>On 18/8/25 15:21, Richard =
Henderson wrote:<br><blockquote type=3D"cite">On 8/18/25 22:41, Philippe =
Mathieu-Daud=C3=A9 wrote:<br><blockquote type=3D"cite">Rebasing =
Mohamed's work I'm getting:<br><br>In file included from =
../../target/arm/hvf/hvf.c:413:<br>../../target/arm/hvf/sysreg.c.inc:156:1=
: error: static assertion failed due to requirement =
'!(HV_SYS_REG_MDCR_EL2 !=3D (((((1 &lt;&lt; 28) | (19 &lt;&lt; 16) | =
((3) &lt;&lt; 14) | ((4) &lt;&lt; 11) | ((1) &lt;&lt; 7) | ((1) &lt;&lt; =
3) | ((1) &lt;&lt; 0)) | 13510798882111488ULL)) &amp; 65535))': not =
expecting: HV_SYS_REG_MDCR_EL2 !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(1, =
1, 3, 4, 1))<br>&nbsp;&nbsp; 156 | DEF_SYSREG(HV_SYS_REG_MDCR_EL2, 1, 1, =
3, 4, 1)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br></blockquote><blockquote=
 type=3D"cite">&nbsp;&nbsp;&nbsp;&nbsp; HV_SYS_REG_MDCR_EL2 =3D =
0xe019,&nbsp;&nbsp; &lt;----<br></blockquote>How odd.&nbsp; It should be =
e089, if it were encoded like all the others.<br>I wonder if this is a =
manual typo that's now baked into the api, or if it's an OS =
bug.<br>r~<br></blockquote><br></div></div></blockquote></div><br></body><=
/html>=

--Apple-Mail=_60D27284-DEB7-4226-BAA3-8D54ECE19A96--

