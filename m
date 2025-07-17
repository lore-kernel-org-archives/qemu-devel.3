Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B562C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucU3f-0007uk-Ir; Thu, 17 Jul 2025 15:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1ucRMn-0001Ui-7c
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:21:54 -0400
Received: from ma-mx03.apple.com ([17.23.4.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1ucRMl-00048s-7l
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:21:52 -0400
Received: from mr55p01nt-mtap02.apple.com
 (mr55p01nt-mtap02.apple.com [10.170.185.211]) by st47p01nt-mxp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPS id <0SZJ1UJDLUFVCH00@st47p01nt-mxp03.apple.com> for
 qemu-devel@nongnu.org; Thu, 17 Jul 2025 15:16:47 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-type : date : from : in-reply-to : message-id : mime-version :
 references : subject : to; s=20180706;
 bh=s8PKokBVoSo6Wu7jQ+sNjKP/SdiuaiW8PiKRNrVCiko=;
 b=fOMEeJTBhT22885iKc+3/xBLp0PutII3gdnh2XtxKiQpzinAeHEE1jlqiUZ8k5p+xI3q
 5kZ7SnjtFAXO0VpBzyw+vYL5qYQNuIpouSRADfTM8t598cJQ/zA6nG5xJE+bpYs7q8Wp
 n10u5CsUc609splF8CIzBkxI6mlC0EyQ+l1fcTbXU39c5hbht0YmQDHr3monFwUEAoYs
 YrM6ekz54pDcrqh/cpBYJtuR5a0v51Ma5HDonJL1IWYmbghvrHZlWvatFDFi8ef00EYA
 Qfgo85v8dELhJH7B8CkzWHji8U/75JI+bzB0KVTls5t1QTqWv5+NG64mOSf8XiBGS2s8 1g==
Received: from mr55p01nt-mmpp04.apple.com
 (mr55p01nt-mmpp04.apple.com [10.170.185.204]) by mr55p01nt-mtap02.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPS id <0SZJ05IDTUFW2YA0@mr55p01nt-mtap02.apple.com>; Thu,
 17 Jul 2025 15:16:44 +0000 (GMT)
Received: from process_milters-daemon.mr55p01nt-mmpp04.apple.com by
 mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) id <0SZJ1GP00U252A00@mr55p01nt-mmpp04.apple.com>; Thu,
 17 Jul 2025 15:16:44 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 7f2fa2d5a24d3666b9cb0a9d40684449
X-Va-E-CD: 28aaa44b059d8724bc96c7c9acdd18d1
X-Va-R-CD: 959c523f5b818a32ab2fcfa542961938
X-Va-ID: 3c0459ad-2256-44a5-88ba-1c6598c27e35
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 7f2fa2d5a24d3666b9cb0a9d40684449
X-V-E-CD: 28aaa44b059d8724bc96c7c9acdd18d1
X-V-R-CD: 959c523f5b818a32ab2fcfa542961938
X-V-ID: e293f20a-f31e-466c-b418-0bab018b8ff3
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
Received: from smtpclient.apple (unknown [17.11.187.249])
 by mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPSA id <0SZJ1GI8VUFTRM00@mr55p01nt-mmpp04.apple.com>; Thu,
 17 Jul 2025 15:16:42 +0000 (GMT)
From: Danny Canter <danny_canter@apple.com>
Message-id: <B08AAF88-3770-478A-8589-ADB407878B19@apple.com>
Content-type: multipart/alternative;
 boundary="Apple-Mail=_A43DA86F-21A7-46C4-B01D-F47B10930586"
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3859.100.2\))
Subject: Re: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
Date: Thu, 17 Jul 2025 08:16:30 -0700
In-reply-to: <87a554z5wp.fsf@draig.linaro.org>
Cc: Joelle van Dyne <j@getutm.app>, Marc Zyngier <maz@kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@csgraf.de>,
 Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <87zfd5zouv.fsf@draig.linaro.org> <86wm898yf4.wl-maz@kernel.org>
 <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
 <03A3BBBF-6A01-4ECB-BE50-8103B9201528@apple.com>
 <87a554z5wp.fsf@draig.linaro.org>
X-Mailer: Apple Mail (2.3859.100.2)
Received-SPF: pass client-ip=17.23.4.21; envelope-from=danny_canter@apple.com;
 helo=ma-mx03.apple.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_A43DA86F-21A7-46C4-B01D-F47B10930586
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> Are you aware of any work that needs doing in the wider QEMU to =
support nested virt or should it just be a case of doing the plumbing =
inaccel/hvf to turn it on?

I=E2=80=99m not the greatest person to chime in unfortunately as I=E2=80=99=
m not an expert on QEMU by any means.

What I can offer that may be of assistance:

- Fundamentally, the APIs expose the EL2 states. The state shadowing is =
managed by Hypervisor.framework directly.
- The new GIC APIs take care of interrupt injection, and would need to =
be used in concert with the EL2 APIs if you need interrupt support =
(highly likely =F0=9F=98=AC). This would
be where I=E2=80=99d investigate on the QEMU end first to see if this =
would fit within the architecture without a bunch of reworks. =
https://developer.apple.com/documentation/hypervisor/hv_gic_create(_:)


> On Jul 16, 2025, at 5:17=E2=80=AFAM, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> wrote:
>=20
> Danny Canter <danny_canter@apple.com <mailto:danny_canter@apple.com>> =
writes:
>=20
>> Joelle is correct, M3 and newer SoCs have support for the EL2 APIs.
>=20
> Thanks for the confirmation. I'm looking at getting a M4 Mini for my
> team so we can help review and test patches for HVF going forward.
>=20
> Are you aware of any work that needs doing in the wider QEMU to =
support
> nested virt or should it just be a case of doing the plumbing in
> accel/hvf to turn it on?
>=20
>>=20
>> -Danny
>>=20
>>> On Jul 15, 2025, at 8:53=E2=80=AFAM, Joelle van Dyne <j@getutm.app> =
wrote:
>>>=20
>>> UTM currently supports NV only with the Apple Virtualization =
backend,
>>> not QEMU HVF. While M2 supports NV, it is not enabled by XNU kernel
>>> and `hv_vm_config_get_el2_supported` returns false. I heard there =
was
>>> some compatibility issue in the hardware. M3 and newer generations
>>> fully support NV in hardware and by XNU.
>>>=20
>>> On Tue, Jul 15, 2025 at 4:51=E2=80=AFAM Marc Zyngier =
<maz@kernel.org> wrote:
>>>>=20
>>>> On Tue, 15 Jul 2025 12:15:52 +0100,
>>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>>>=20
>>>>> - do we know which Apple silicon supports FEAT_NV2?
>>>>=20
>>>> M2 and latter definitely support FEAT_NV2. That's how KVM NV =
support
>>>> has been developed for two years until I was given better HW.
>>>>=20
>>>> Whether Apple supports NV on M2 in HVF, I have no idea. The rumour
>>>> mill says "no", but I don't have a way to check. The M3 I use at =
$WORK
>>>> is definitely able to give me EL2 without VHE with UTM. I haven't
>>>> played with M4, but I have it on the record that it behaves like M3
>>>> with UTM.
>>>>=20
>>>>       M.
>>>>=20
>>>> --
>>>> Without deviation from the norm, progress is not possible.
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro


--Apple-Mail=_A43DA86F-21A7-46C4-B01D-F47B10930586
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><span style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0);">&gt; Are you aware of any work that needs =
doing in the wider QEMU to support nested virt or should it just be a =
case of doing the plumbing inaccel/hvf to turn it on?</span><div =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);"><br></div><div =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">I=E2=80=99m =
not the greatest person to chime in unfortunately as I=E2=80=99m not an =
expert on QEMU by any means.</div><div style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0);"><br></div><div style=3D"caret-color: rgb(0, 0, =
0); color: rgb(0, 0, 0);">What I can offer that may be of =
assistance:</div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, =
0, 0);"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, =
0, 0);">- Fundamentally, the APIs expose the EL2 states. The state =
shadowing is managed by Hypervisor.framework directly.</div><div =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">- The new GIC =
APIs take care of interrupt injection, and would need to be used in =
concert with the EL2 APIs if you need interrupt support (highly likely =
=F0=9F=98=AC). This would</div><div style=3D"caret-color: rgb(0, 0, 0); =
color: rgb(0, 0, 0);">be where I=E2=80=99d investigate on the QEMU end =
first to see if this would fit within the architecture without a bunch =
of reworks.&nbsp;<a =
href=3D"https://developer.apple.com/documentation/hypervisor/hv_gic_create=
(_:)">https://developer.apple.com/documentation/hypervisor/hv_gic_create(_=
:)</a></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);"><br></div><div><br><blockquote type=3D"cite"><div>On Jul 16, 2025, =
at 5:17=E2=80=AFAM, Alex Benn=C3=A9e &lt;alex.bennee@linaro.org&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><meta =
charset=3D"UTF-8"><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">Danny Canter =
&lt;</span><a href=3D"mailto:danny_canter@apple.com" style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">danny_canter@apple.com</a><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">&gt; =
writes:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">Joelle is correct, M3 and newer SoCs have =
support for the EL2 APIs.<br></blockquote><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Thanks =
for the confirmation. I'm looking at getting a M4 Mini for my</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">team so we can help review and test patches =
for HVF going forward.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">Are you =
aware of any work that needs doing in the wider QEMU to =
support</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;"><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;">nested virt or should it =
just be a case of doing the plumbing in</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">accel/hvf to turn it on?</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br>-Danny<br><br><blockquote type=3D"cite">On =
Jul 15, 2025, at 8:53=E2=80=AFAM, Joelle van Dyne &lt;j@getutm.app&gt; =
wrote:<br><br>UTM currently supports NV only with the Apple =
Virtualization backend,<br>not QEMU HVF. While M2 supports NV, it is not =
enabled by XNU kernel<br>and `hv_vm_config_get_el2_supported` returns =
false. I heard there was<br>some compatibility issue in the hardware. M3 =
and newer generations<br>fully support NV in hardware and by =
XNU.<br><br>On Tue, Jul 15, 2025 at 4:51=E2=80=AFAM Marc Zyngier =
&lt;maz@kernel.org&gt; wrote:<br><blockquote type=3D"cite"><br>On Tue, =
15 Jul 2025 12:15:52 +0100,<br>Alex Benn=C3=A9e =
&lt;alex.bennee@linaro.org&gt; wrote:<br><br><blockquote type=3D"cite">- =
do we know which Apple silicon supports FEAT_NV2?<br></blockquote><br>M2 =
and latter definitely support FEAT_NV2. That's how KVM NV support<br>has =
been developed for two years until I was given better HW.<br><br>Whether =
Apple supports NV on M2 in HVF, I have no idea. The rumour<br>mill says =
"no", but I don't have a way to check. The M3 I use at $WORK<br>is =
definitely able to give me EL2 without VHE with UTM. I haven't<br>played =
with M4, but I have it on the record that it behaves like M3<br>with =
UTM.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M.<br><br>--<br>Without =
deviation from the norm, progress is not =
possible.<br></blockquote></blockquote></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Alex Benn=C3=A9e</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Virtualisation Tech Lead @ =
Linaro</span></div></blockquote></div><br></body></html>=

--Apple-Mail=_A43DA86F-21A7-46C4-B01D-F47B10930586--

