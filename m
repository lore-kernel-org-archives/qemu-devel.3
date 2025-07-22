Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC39C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 11:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueB03-0001VI-76; Tue, 22 Jul 2025 07:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ueAzd-0001Mo-5B
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:17:10 -0400
Received: from p-east3-cluster4-host7-snip4-1.eps.apple.com ([57.103.84.64]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ueAza-0004Cz-Qm
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:17:08 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 5DA5E18000AF; Tue, 22 Jul 2025 11:17:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=dIrAHmdsSj6Aucz92NWF11M9gZkNlDgy0Srlz8h06uo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=f9azhxgpWU3kGFWTzDwkN9xzgQzH4cjoLvImx5brqdTMn8y09oqv+6I6xsFsaGcM2OGqq5u7o2UeaWGhd9P9Dwql1mgach3UrHiUBvoqZ/cpRzPKWsS26GtjlbtvqgBuQAOJjiCxUV3P0gwnMTAO4Lwlb0RhniP/KT2Kd2VYvcBhQKZH6Y6CF0wuiWej47/FkN3DOclXX42Vs2XhqZUA/S5fkIrDgE1YbN2TQiJHRjob4la/surDr7S2y7kO/bohzoyhztatdrdQmuawLVJ85hFDACyqIcqj/+HPZfTgE2xHcQB4U/Ic0G8ITd6AtlSVXMwoh/zhaFR81OF5ks8JwA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 BDF2D180061D; Tue, 22 Jul 2025 11:17:00 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3858.100.10\))
Subject: Re: [PATCH] i386/kvm: Disable hypercall patching quirk by default
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <0a700950-45b8-4f38-afe2-a1a261110d78@intel.com>
Date: Tue, 22 Jul 2025 13:16:48 +0200
Cc: Mathias Krause <minipli@grsecurity.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3A41A4F-598B-406C-8F4C-0F561CA689A3@unpredictable.fr>
References: <20250619194204.1089048-1-minipli@grsecurity.net>
 <41a5767e-42d7-4877-9bc8-aa8eca6dd3e3@intel.com>
 <b8336828-ce72-4567-82df-b91d3670e26c@grsecurity.net>
 <3f58125c-183f-49e0-813e-d4cb1be724e8@intel.com>
 <317D3308-0401-4A36-A6B0-D2575869748D@unpredictable.fr>
 <0a700950-45b8-4f38-afe2-a1a261110d78@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: Apple Mail (2.3858.100.10)
X-Proofpoint-GUID: 1WL3OfT56U_gm4EMzw3rPAMB9UFuxxXD
X-Proofpoint-ORIG-GUID: 1WL3OfT56U_gm4EMzw3rPAMB9UFuxxXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MiBTYWx0ZWRfX7AyVgDdoNq41
 95NwJikRMbli1fJmC2zevSpqGrz8GoxC9gzK1jtCZ9eu7ojjph2wVpfbOBuMxf++qPShwoy+ISR
 wlbyO1keby6Y5wWsb6n/4wpqfrgg4xm5DYudew4fRQQ1JEK18SqG7gR5fpKvmC18Y8chCCoRgUY
 Qt07DYdPXeIlngaYS9oO4dVEZCl/C1UJG45lHuQk6O0v0nCASxVVOHn4sEIfRsN0Oam8EiqGmXG
 ZMaP8bPl4k6lTd1A40v3aBYtzqijP0/1urr24Uuoc8eIDyXFqlbbB/eBwnpl5hISBje8EKMrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507220092
Received-SPF: pass client-ip=57.103.84.64;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 22. Jul 2025, at 13:06, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> On 7/22/2025 6:35 PM, Mohamed Mediouni wrote:
>>> On 22. Jul 2025, at 12:27, Xiaoyao Li<xiaoyao.li@intel.com> wrote:
>>>=20
>>> On 7/22/2025 5:21 PM, Mathias Krause wrote:
>>>> On 22.07.25 05:45, Xiaoyao Li wrote:
>>>>> On 6/20/2025 3:42 AM, Mathias Krause wrote:
>>>>>> KVM has a weird behaviour when a guest executes VMCALL on an AMD =
system
>>>>>> or VMMCALL on an Intel CPU. Both naturally generate an invalid =
opcode
>>>>>> exception (#UD) as they are just the wrong instruction for the =
CPU
>>>>>> given. But instead of forwarding the exception to the guest, KVM =
tries
>>>>>> to patch the guest instruction to match the host's actual =
hypercall
>>>>>> instruction. That is doomed to fail as read-only code is rather =
the
>>>>>> standard these days. But, instead of letting go the patching =
attempt and
>>>>>> falling back to #UD injection, KVM injects the page fault =
instead.
>>>>>>=20
>>>>>> That's wrong on multiple levels. Not only isn't that a valid =
exception
>>>>>> to be generated by these instructions, confusing attempts to =
handle
>>>>>> them. It also destroys guest state by doing so, namely the value =
of CR2.
>>>>>>=20
>>>>>> Sean attempted to fix that in KVM[1] but the patch was never =
applied.
>>>>>>=20
>>>>>> Later, Oliver added a quirk bit in [2] so the behaviour can, at =
least,
>>>>>> conceptually be disabled. Paolo even called out to add this very
>>>>>> functionality to disable the quirk in QEMU[3]. So lets just do =
it.
>>>>>>=20
>>>>>> A new property 'hypercall-patching=3Don|off' is added, for the =
very
>>>>>> unlikely case that there are setups that really need the =
patching.
>>>>>> However, these would be vulnerable to memory corruption attacks =
freely
>>>>>> overwriting code as they please. So, my guess is, there are =
exactly 0
>>>>>> systems out there requiring this quirk.
>>>>> The default behavior is patching the hypercall for many years.
>>>>>=20
>>>>> If you desire to change the default behavior, please at least keep =
it
>>>>> unchanged for old machine version. i.e., introduce =
compat_property,
>>>>> which sets KVMState->hypercall_patching_enabled to true.
>>>> Well, the thing is, KVM's patching is done with the effective
>>>> permissions of the guest which means, if the code in question isn't
>>>> writable from the guest's point of view, KVM's attempt to modify it =
will
>>>> fail. This failure isn't transparent for the guest as it sees a #PF
>>>> instead of a #UD, and that's what I'm trying to fix by disabling =
the quirk.
>>>> The hypercall patching was introduced in Linux commit 7aa81cc04781
>>>> ("KVM: Refactor hypercall infrastructure (v3)") in v2.6.25. Until =
then
>>>> it was based on a dedicated hypercall page that was handled by KVM =
to
>>>> use the proper instruction of the KVM module in use (VMX or SVM).
>>>> Patching code was fine back then, but the introduction of =
DEBUG_RO_DATA
>>>> made the patching attempts fail and, ultimately, lead to Paolo =
handle
>>>> this with commit c1118b3602c2 ("x86: kvm: use alternatives for =
VMCALL
>>>> vs. VMMCALL if kernel text is read-only").
>>>> However, his change still doesn't account for the cross-vendor live
>>>> migration case (Intel<->AMD), which will still be broken, causing =
the
>>>> before mentioned bogus #PF, which will just lead to misleading Oops
>>>> reports, confusing the poor souls, trying to make sense of it.
>>>> IMHO, there is no valid reason for still having the patching in =
place as
>>>> the .text of non-ancient kernel's  will be write-protected, making
>>>> patching attempts fail. And, as they fail with a #PF instead of =
#UD, the
>>>> guest cannot even handle them appropriately, as there was no memory
>>>> write attempt from its point of view. Therefore the default should =
be to
>>>> disable it, IMO. This won't prevent guests making use of the wrong
>>>> instruction from trapping, but, at least, now they'll get the =
correct
>>>> exception vector and can handle it appropriately.
>>> But you don't accout for the case that guest kernel is built without =
CONFIG_STRICT_KERNEL_RWX enabled, or without CONFIG_DEBUG_RO_DATA, or =
for whatever reason the guest's text is not readonly, and the VM needs =
to be migrated among different vendors (Intel <-> AMD).
>>>=20
>>> Before this patch, the above usecase works well. But with this =
patch, the guest will gets #UD after migrated to different vendors.
>>>=20
>>> I heard from some small CSPs that they do want to the ability to =
live migrate VMs among Intel and AMD host.
>>>=20
>> Is there a particular reason to not handle that #UD as a hypercall to =
support that scenario?
>=20
> do you mean KVM handles the first hardware #UD due to the wrong opcode =
of hypercall by directly emulate the hypercall instead of going to =
emulator to patch the guest memory with modifying the guest memory?
>=20
> If so, I agree with it. I thought the same solution and had no =
bandwidth and motivation to raise the idea to KVM community.
>=20
Yes, I think that=E2=80=99d be the best way to go in this case=E2=80=A6

-Mohamed
>> Especially with some guest OS kernels having kernel patch protection =
with periodic scrubbing of r/o memory (ie Windows), doesn=E2=80=99t =
sound great to override anything in a way the guest OS kernel can =
notice=E2=80=A6
>=20
>=20


