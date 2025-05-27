Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E608AC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJwLT-0003rT-ME; Tue, 27 May 2025 11:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonmkohler@icloud.com>)
 id 1uJw8S-0007as-Do
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:22:36 -0400
Received: from p-west3-cluster6-host1-snip4-2.eps.apple.com ([57.103.75.65]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonmkohler@icloud.com>)
 id 1uJw8L-0000Xj-Ib
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; bh=qpWNtoHpHDvcf7sMaFf0EMW/jeoBO90YBaJzoFKooAs=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=rcEtGqvTtzwsHj8owtLFiUrWNKFNbo8odUblv7G56UbqAlk/Q2QkrO+cEP/3gmXS9
 i/morm79L5ByVqgxYCsvY5BeBGLSFyzF0qyjaREUT9Ym45hlyLhgySVnuXnkTv3ySy
 EOaaGLJoLYm5gOlHCXK2B4UVD7uPzA7nfhz+HqpfHmZBxNo7sx7rV1bqzQGssWRm+e
 zhw1EZkCyg4Pt/sQ4x4YJ+52zcUJ0wMIoBRW3JmTyrWlmBO6lA6WSPza+j0lC13aov
 fCSrsTAa13exJkGPTQwJOj/Ttp9znPBh8CyJS9U/etU6cbcVE0JyR15k36a1iASqT8
 2lAb3KhMO3WBQ==
Received: from outbound.ms.icloud.com (localhost [127.0.0.1])
 by outbound.ms.icloud.com (Postfix) with ESMTPS id 1EA5C180028F;
 Tue, 27 May 2025 15:22:22 +0000 (UTC)
Received: from smtpclient.apple (unknown [17.57.154.37])
 by outbound.ms.icloud.com (Postfix) with ESMTPSA id 4A91418002B8;
 Tue, 27 May 2025 15:22:21 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 0/6] target/i386: Update EPYC CPU models for Cache
 property, RAS, SVM feature and add EPYC-Turin CPU model
From: Jon Kohler <jonmkohler@icloud.com>
In-Reply-To: <cover.1746734284.git.babu.moger@amd.com>
Date: Tue, 27 May 2025 11:22:08 -0400
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, davydov-max@yandex-team.ru
Content-Transfer-Encoding: quoted-printable
Message-Id: <75B808AB-38DC-4B5B-9A7D-F4D0AD3225CB@icloud.com>
References: <cover.1746734284.git.babu.moger@amd.com>
To: Babu Moger <babu.moger@amd.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-ORIG-GUID: eqgXYJnvJmEg47ijZppIX0S4nFlJs1Mm
X-Proofpoint-GUID: eqgXYJnvJmEg47ijZppIX0S4nFlJs1Mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505270127
Received-SPF: pass client-ip=57.103.75.65; envelope-from=jonmkohler@icloud.com;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 May 2025 11:36:00 -0400
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



> On May 8, 2025, at 3:57=E2=80=AFPM, Babu Moger <babu.moger@amd.com> =
wrote:
>=20
> Following changes are implemented in this series.
>=20
> 1. Fixed the cache(L2,L3) property details in all the EPYC models.
> 2. Add RAS feature bits (SUCCOR, McaOverflowRecov) on all EPYC models
> 3. Add missing SVM feature bits required for nested guests on all EPYC =
models
> 4. Add the missing feature bit fs-gs-base-ns(WRMSR to =
{FS,GS,KERNEL_G}S_BASE is
>   non-serializing). This bit is added in EPYC-Genoa and EPYC-Turin =
models.
> 5. Add RAS, SVM, fs-gs-base-ns and perfmon-v2 on EPYC-Genoa and =
EPYC-Turin models.
> 6. Add support for EPYC-Turin.=20
>   (Add all the above feature bits and few additional bits movdiri, =
movdir64b,
>    avx512-vp2intersect, avx-vnni, prefetchi, sbpb, ibpb-brtype, =
srso-user-kernel-no).
>=20
> Link: =
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/progr=
ammer-references/57238.zip
> Link: =
https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-=
return-stack-overflow-whitepaper.pdf
> ---
> v7: Rebased on top latest 57b6f8d07f14 (upstream/master) Merge tag =
'pull-target-arm-20250506'
>    Added new feature bit PREFETCHI. KVM support for the bit is added =
recently.
>    https://github.com/kvm-x86/linux/commit/d88bb2ded2ef
>    Paolo, These patches have been pending for a while. Please consider =
merging when you get a chance.
>=20
> v6: Initialized the boolean feature bits to true where applicable.
>    Added Reviewed-by tag from Zhao.
>=20
> v5: Add EPYC-Turin CPU model
>    Dropped ERAPS and RAPSIZE bits from EPYC-Turin models as kernel =
support for
>    these bits are not done yet. Users can still use the options =
+eraps,+rapsize
>    to test these featers.
>    Add Reviewed-by tag from Maksim for the patches already reviewed.
>=20
> v4: Some of the patches in v3 are already merged. Posting the rest of =
the patches.
>    Dropped EPYC-Turin model for now. Will post them later.
>    Added SVM feature bit as discussed in
>    =
https://lore.kernel.org/kvm/b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.co=
m/
>    Fixed the cache property details as discussed in
>    =
https://lore.kernel.org/kvm/20230504205313.225073-8-babu.moger@amd.com/
>    Thanks to Maksim and Paolo for their feedback.
>=20
> v3: Added SBPB, IBPB_BRTYPE, SRSO_USER_KERNEL_NO, ERAPS and RAPSIZE =
bits
>    to EPYC-Turin.
>    Added new patch(1) to fix a minor typo.
>=20
> v2: Fixed couple of typos.
>    Added Reviewed-by tag from Zhao.
>    Rebased on top of 6d00c6f98256 ("Merge tag 'for-upstream' of =
https://repo.or.cz/qemu/kevin into staging")
>=20
> Previous revisions:
> v6: =
https://lore.kernel.org/kvm/cover.1740766026.git.babu.moger@amd.com/
> v5: =
https://lore.kernel.org/kvm/cover.1738869208.git.babu.moger@amd.com/
> v4: =
https://lore.kernel.org/kvm/cover.1731616198.git.babu.moger@amd.com/
> v3: =
https://lore.kernel.org/kvm/cover.1729807947.git.babu.moger@amd.com/
> v2: =
https://lore.kernel.org/kvm/cover.1723068946.git.babu.moger@amd.com/
> v1: =
https://lore.kernel.org/qemu-devel/cover.1718218999.git.babu.moger@amd.com=
/
>=20
> Babu Moger (6):
>  target/i386: Update EPYC CPU model for Cache property, RAS, SVM
>    feature bits
>  target/i386: Update EPYC-Rome CPU model for Cache property, RAS, SVM
>    feature bits
>  target/i386: Update EPYC-Milan CPU model for Cache property, RAS, SVM
>    feature bits
>  target/i386: Add couple of feature bits in CPUID_Fn80000021_EAX
>  target/i386: Update EPYC-Genoa for Cache property, perfmon-v2, RAS =
and
>    SVM feature bits
>  target/i386: Add support for EPYC-Turin model
>=20
> target/i386/cpu.c | 439 +++++++++++++++++++++++++++++++++++++++++++++-
> target/i386/cpu.h |   4 +
> 2 files changed, 441 insertions(+), 2 deletions(-)

Hey Babu and Paolo,
Is there anything outstanding on this series? I didn=E2=80=99t see any
further comments.=20

Anyhow, I did step thru this patch by patch, LGTM:

Reviewed-By: Jon Kohler <jon@nutanix.com <mailto:jon@nutanix.com>>


