Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A33C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 08:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubxYv-0004Uo-29; Wed, 16 Jul 2025 04:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1ubxYq-0004Si-9h
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 04:32:20 -0400
Received: from ma-mx02.apple.com ([17.23.4.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1ubxYo-0005Xb-7V
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 04:32:20 -0400
Received: from mr55p01nt-mtap01.apple.com
 (mr55p01nt-mtap01.apple.com [10.170.185.217]) by st47p01nt-mxp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPS id <0SZH17CPQE1AZ620@st47p01nt-mxp02.apple.com> for
 qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:27:15 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=8vl5Of5/yCNYlEpL8nhCBoDvh+ovojhlvhAJAMlBfyM=;
 b=A3qHSBkPOriOZ+H/UjcDRuEVXca6A2XiUdTwpVW0tIBX4m8PQHTSWt6wE/IZ+3oVURXs
 VBRUYsuCep/3U47kHl9xpY/Pa40ED/fwSldLnP4Xnc6060/bhrLD4PGiTzpsoo8kGpo5
 NZ9dz1XkinMtp70Q90+dM6Z0tKALjVY819ciqldzcpxTIC8JOAUtJJu1Jbi/CQLFHuj9
 PVp0ozUb0p0HCd7jI5ZlGs/Fa384O7zzHZqkLfUI25WiS8kltQdcxg0V7Uflv2QTmB+9
 +j4Xs56bYzzAkBwDK8Sb36tPWOAEQh0NCXjJr7YvnCeLAslPc7UW/0cdminfpssNuMUQ Yw==
Received: from mr55p01nt-mmpp01.apple.com
 (mr55p01nt-mmpp01.apple.com [10.170.185.219]) by mr55p01nt-mtap01.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPS id <0SZH2354DE1BYB30@mr55p01nt-mtap01.apple.com>; Wed,
 16 Jul 2025 07:27:12 +0000 (GMT)
Received: from process_milters-daemon.mr55p01nt-mmpp01.apple.com by
 mr55p01nt-mmpp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) id <0SZH12C00DJQK600@mr55p01nt-mmpp01.apple.com>; Wed,
 16 Jul 2025 07:27:11 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 874eb03d5c71380729cfc7a4af7a316f
X-Va-E-CD: 28aaa44b059d8724bc96c7c9acdd18d1
X-Va-R-CD: 959c523f5b818a32ab2fcfa542961938
X-Va-ID: 2f9424b5-1e5b-4741-9935-736f8bacdc7e
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 874eb03d5c71380729cfc7a4af7a316f
X-V-E-CD: 28aaa44b059d8724bc96c7c9acdd18d1
X-V-R-CD: 959c523f5b818a32ab2fcfa542961938
X-V-ID: cedc2b9b-b29a-4035-899f-4fa9bf3bb3d9
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
Received: from smtpclient.apple (unknown [17.11.213.254])
 by mr55p01nt-mmpp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.27.20250130 64bit (built Jan 30
 2025)) with ESMTPSA id <0SZH12Q1KE1AZS00@mr55p01nt-mmpp01.apple.com>; Wed,
 16 Jul 2025 07:27:11 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3859.100.2\))
Subject: Re: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
From: Danny Canter <danny_canter@apple.com>
In-reply-to: <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
Date: Wed, 16 Jul 2025 00:27:00 -0700
Cc: Marc Zyngier <maz@kernel.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@csgraf.de>,
 Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Content-transfer-encoding: quoted-printable
Message-id: <03A3BBBF-6A01-4ECB-BE50-8103B9201528@apple.com>
References: <87zfd5zouv.fsf@draig.linaro.org> <86wm898yf4.wl-maz@kernel.org>
 <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
To: Joelle van Dyne <j@getutm.app>
X-Mailer: Apple Mail (2.3859.100.2)
Received-SPF: pass client-ip=17.23.4.17; envelope-from=danny_canter@apple.com;
 helo=ma-mx02.apple.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Joelle is correct, M3 and newer SoCs have support for the EL2 APIs.

-Danny

> On Jul 15, 2025, at 8:53=E2=80=AFAM, Joelle van Dyne <j@getutm.app> =
wrote:
>=20
> UTM currently supports NV only with the Apple Virtualization backend,
> not QEMU HVF. While M2 supports NV, it is not enabled by XNU kernel
> and `hv_vm_config_get_el2_supported` returns false. I heard there was
> some compatibility issue in the hardware. M3 and newer generations
> fully support NV in hardware and by XNU.
>=20
> On Tue, Jul 15, 2025 at 4:51=E2=80=AFAM Marc Zyngier <maz@kernel.org> =
wrote:
>>=20
>> On Tue, 15 Jul 2025 12:15:52 +0100,
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>=20
>>>  - do we know which Apple silicon supports FEAT_NV2?
>>=20
>> M2 and latter definitely support FEAT_NV2. That's how KVM NV support
>> has been developed for two years until I was given better HW.
>>=20
>> Whether Apple supports NV on M2 in HVF, I have no idea. The rumour
>> mill says "no", but I don't have a way to check. The M3 I use at =
$WORK
>> is definitely able to give me EL2 without VHE with UTM. I haven't
>> played with M4, but I have it on the record that it behaves like M3
>> with UTM.
>>=20
>>        M.
>>=20
>> --
>> Without deviation from the norm, progress is not possible.


