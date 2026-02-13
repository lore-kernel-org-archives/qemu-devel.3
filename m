Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DC5EF48CB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqkFf-0006le-I1; Thu, 12 Feb 2026 22:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqkFZ-0006jb-RQ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:53:50 -0500
Received: from p-west1-cluster5-host2-snip4-10.eps.apple.com ([57.103.66.191]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqkFX-0007oI-Ek
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:53:48 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-3 (Postfix) with ESMTPS id
 9719E18000AB; Fri, 13 Feb 2026 03:53:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954825; x=1773546825;
 bh=GboI/S1XYpUv2KeLvyi/K/v/bO5DDPyYXp7e2iaoWPU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=J6eN7OzpLM7zyk24Oy4TL14lyr3Wgu0iuE6LTDhK6tyKJxrCuYb8vrhWj41cJcQ4Iuw67FWzOHlpaIB+LosNcHOpHVccL6Qk5SWESCziXK4afgedkmOBHMPsn2A/s89QjalHm/DffxmjOf3rfyPzexeuQ4FFrbKz/BFgvO7IVVNfdX4vsJDYidW9Kuc964gPTCzQKpJYeEvztTtFD8dC3myWK6fgiE3VX6j+Mt3mFo6jSWkG5Si5ApNdX84l3F/gpOHMxNptfEX+HCkPW/8HcXw2bV5uu09RlzBQ7rvnVlLomaT1AXByhw7QsVOCZxVmap7GM+j37IHGO95FiUX0OA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-3 (Postfix) with ESMTPSA id
 EF27718000D5; Fri, 13 Feb 2026 03:53:37 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 01/10] target/i386: emulate, hvf: move x86_mmu to
 common code
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260213034556.13471-2-mohamed@unpredictable.fr>
Date: Fri, 13 Feb 2026 04:53:25 +0100
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6FEEE6E-6950-412B-AE56-BB4CCE980F51@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
 <20260213034556.13471-2-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: b1W3yBjJp6JmckYDoiBRgM3pjstxmiRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNiBTYWx0ZWRfX3Hl572KAN74q
 /tuzcAT4YdTH/AMetzoo16YPo9ue2qME01pdkpudeZYsj+nbJ9OEsXck1oV0IkbIoAO1SmELB0F
 hv/VFmd3m5xV4n+ENJfG1ZC+D1flcn9fYsM0Lg7JD1EP3eXapIytJ3/HoFcHyJsmrZYYsCyI7zW
 2tRO19Ql4Eg9X9PRL+SngtWzMFzNJwaE1UsYUzaSV44sbFUM9NEFu6I47vAOlaCVc5GFhyO24GR
 hZmioK4bV4OSBVW/7cSLFjwAIe3/Dua1X0mIJgL3EDQ/WoKjsmQdtTFOnWiPr0hEBA2Di1K30ye
 v0JORZIHZkcW3w14NZaRse1YoIT6xPi1ZdGdUWrVc5uG91aoCdM0rlFCP8LPVA=
X-Proofpoint-ORIG-GUID: b1W3yBjJp6JmckYDoiBRgM3pjstxmiRx
X-Authority-Info-Out: v=2.4 cv=avK/yCZV c=1 sm=1 tr=0 ts=698ea047
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=aiZIkoKiQC1Q2XNNpuYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=963 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1030 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130026
X-JNJ: AAAAAAABSu1+nBXB28SQ3H4BGV2SP8hpUAHYF+KYgf84yyin0d/UlQ1L7ynxJYw3NERnuZZFwH8lgF/h8lyhAyElwmXBeTa+oyRc/gqCtGqN6DSZxOruJ0iu9S6sltmYvRxD5l7hGD6VJdEM/aKUvTYYpE6B/DCkk3kFrPvQ6S3yWpFru9HFRfPC/RhzXhLHyWucCSGmhXMfqkfRJjK+0Y7T+sCmzJXxZ5SZUqPnK+GvgKw1hfi/TXVCpnC0+vkfZuV3josnS0COEDumhBdueIOBnU+dAk+FWpHH6J+cx1UJ8Dz/D9/EOA0Wwup4v+9ww4X2gc4YvyVeRpskgw3o+mgBmvHb/PC7zC8gh4woRKCHORE8ysZyU48HD7udY8zHPe3KT3ooXqrLKlbm7yJewiZUJCSvyafVm7iIc9uZYxFz67jODrfZRYm5zwWGC9emjNhNDMZlpQdB3Kh2laoBkruU0jZ38RRJDXYXcpDuokzw83MlSjQDRxSM2+k3Xb4ccWUHONde8pR0ekuT/nrMFr4nJ2wrKlHpkd5/Ao4oTEUTVyLMv3yhWvRs9CxTCp+sN4Mu5XDW4TFqx3u3iBV5BeNOT8VqQrrw0ccnnekl9wiOKMxOjjucoAdU4tjY1yeYV5iKtssPSD+EkyWRpv/963LNfAqjx3386plGjwK4tyAjZZ8W9nckWx/XEVYWboDMftcK2uR38KDsz4+zqWkh+cxOvDL3qsWsTdoeyDs+qzX/fIaq3B31UHrT8m7vMJLMuBtjjQ96yP/aCeaQblTY7Rq9Ytfmw7kq1NHetmL4PYzLDQMJbvjjDj2sDancRw==
Received-SPF: pass client-ip=57.103.66.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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



> On 13. Feb 2026, at 04:45, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/i386/emulate/meson.build        |  1 +
> target/i386/{hvf =3D> emulate}/x86_mmu.c | 14 +++++++++-----
> target/i386/{hvf =3D> emulate}/x86_mmu.h |  0
> target/i386/hvf/hvf.c                  |  6 +++++-
> target/i386/hvf/meson.build            |  1 -
> target/i386/hvf/x86.c                  |  2 +-
> target/i386/hvf/x86_task.c             |  2 +-
> 7 files changed, 17 insertions(+), 9 deletions(-)
> rename target/i386/{hvf =3D> emulate}/x86_mmu.c (95%)
> rename target/i386/{hvf =3D> emulate}/x86_mmu.h (100%)
>=20

Oops, forgot this bit:

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 9c5d85453d..0b3674ad33 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -263,6 +263,10 @@ static void hvf_read_mem(CPUState *cpu, void *data, =
target_ulong gva, int bytes)
=20
 static void hvf_write_mem(CPUState *cpu, void *data, target_ulong gva, =
int bytes)
 {
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    CPUX86State *env =3D &x86_cpu->env;
+    env->cr[0] =3D rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
+    env->cr[3] =3D rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
     vmx_write_mem(cpu, gva, data, bytes);
 }

Will include it in the next revision.


