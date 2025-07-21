Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C57C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udnm6-0007mh-54; Mon, 21 Jul 2025 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udnlk-0007ah-Er
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:29:17 -0400
Received: from p-east3-cluster7-host6-snip4-7.eps.apple.com ([57.103.84.188]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udnlg-00084w-TT
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:29:15 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPS id
 9593418000B5; Mon, 21 Jul 2025 10:29:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=8RZpjcC1eC/jKwDyOKt/gEUgNto/QOWjaPA6wa7ix9w=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=CJtwUocB4Yg/Nf/kog0xFEKXB8m2xsxMgYXv4olfHnYSY+ew2TfXJoOBi4YLjbWUA408xGn/Pr49yx0ULt7U+UCQo7Deaqo7JwaFf/SZsLm2NcSExUYhO+ssuiwkpicmU+FXBlIOHnKevqmm7yiq5+UVCVIuzJSF4qVhIkUmryWqo8VkXhbvHKmTeFm68L45qmLEOj9JihyofEuLQ2JaP6WfvKeTyyZt4G4yhtRJcKaysYGW3qt37k2pyxIwBj0M8Su3zm7oiOcdOuwF7F+iI0GaMxdkB7l/8oVqRTzHgDfZpxv0RujsPgXvIB7k+BxBj7FpB58nmkHKbG68xlwnmA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPSA id
 C17F81800172; Mon, 21 Jul 2025 10:29:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3858.100.10\))
Subject: Re: [PATCH v2 1/2] hvf: arm: Add permission check in GIC sysreg
 handlers
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-7bUavf41RS5Ppd4XAibcLVxHnybDyJH0Yc-U8WHSpHg@mail.gmail.com>
Date: Mon, 21 Jul 2025 12:28:55 +0200
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zenghui Yu <zenghui.yu@linux.dev>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, agraf@csgraf.de, mads@ynddal.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F284FB1-C3D1-4759-9A4D-3C0B43B37657@unpredictable.fr>
References: <20250714160139.10404-1-zenghui.yu@linux.dev>
 <20250714160139.10404-2-zenghui.yu@linux.dev>
 <7a34c735-3306-4028-bec9-f34b4271a543@linaro.org>
 <CAFEAcA-7bUavf41RS5Ppd4XAibcLVxHnybDyJH0Yc-U8WHSpHg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3858.100.10)
X-Proofpoint-GUID: M0U4kRbKv-j6bd3wlIdwHMjf3LM40fB-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA5MyBTYWx0ZWRfX+gbNnySLj5Fk
 Bj+eUw+C+RLWj5Dd6tzg6e3EeckIIgzID0ae4VfWHfZG4YJzl/y9d1iqB04aoq2YGr7K77V7C/R
 57jgMRiThgo0yZmCs9wk9GV+1aD0l6LdvIqrPjA8C71IZR85J3hi2ybmfpI9i1ce2onZKsHaFK6
 Yh7i1qjvcV52Lgi2SdNd+VG3a/1zyj61TArY5o9ZWuOdsZ2G4+KCYPXCi6P4BH8tmqzkNAiqL0H
 pC+iHyi8LsV21zEUjDEUOD7KZzz1As1af7ys9x3jZH3bs1zrkqve45DMvKldhfl7BDEX8K/mE=
X-Proofpoint-ORIG-GUID: M0U4kRbKv-j6bd3wlIdwHMjf3LM40fB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1030 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507210093
Received-SPF: pass client-ip=57.103.84.188;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



> On 21. Jul 2025, at 12:19, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Mon, 14 Jul 2025 at 21:04, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>>=20
>> On 14/7/25 18:01, Zenghui Yu wrote:
>>> Quoting Peter Maydell:
>>>=20
>>> " hvf_sysreg_read_cp() and hvf_sysreg_write_cp() do not check the =
.access
>>>   field of the ARMCPRegInfo to ensure that they forbid writes to =
registers
>>>   that are marked with a .access field that says they're read-only =
(and
>>>   ditto reads to write-only registers). "
>>>=20
>>> Before we add more registers in GIC sysreg handlers, let's get it =
correct
>>> by adding the .access checks to hvf_sysreg_read_cp() and
>>> hvf_sysreg_write_cp(). With that, a sysreg access with invalid =
permission
>>> will result in an UNDEFINED exception.
>>>=20
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
>>> ---
>>>=20
>>> I hard-code the @current_el parameter of cp_access_ok() to 1 because
>>>=20
>>> * we only support EL0 and EL1 in HVF, and
>>=20
>> This might change with this work:
>> =
https://lore.kernel.org/qemu-devel/20250620172751.94231-1-philmd@linaro.or=
g/
>> and plan to leverage M3/M4 for EL2 support:
>> =
https://developer.apple.com/documentation/hypervisor/hv_vm_config_set_el2_=
enabled(_:_:)
>=20
> True, but for 10.1 I'm going to take these patches as-is, because
> they do fix a bug, and handling EL2 in hvf with an emulated GIC is
> going to need a more general look at the GIC code anyway.
> (My preference would be to use the GICv3 which hvf provides in
> macos 15 and up when we can in any case.)
Something to note on the vGIC provided by Hypervisor.framework is that =
it provides its serialisable internal state as an opaque structure which =
isn=E2=80=99t guaranteed to not change in the future (with however =
guarantees that it=E2=80=99ll be readable on newer macOS versions than =
the one it was generated from).

And is of course not a documented one.
> Syncing the whole VM state for any call through to the GIC
> emulation would be quite heavyweight. I'm not sure if we exactly
> thought through that the state would not be synced here, though:
> the GIC emulation was never written to assume that some CPU
> registers might not be in sync...
>=20
> thanks
> -- PMM
>=20


