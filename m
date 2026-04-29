Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F67FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEb2-0002Mg-Rh; Wed, 29 Apr 2026 19:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIEb0-0002Li-V7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:45:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIEay-0004Ww-No
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:45:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbQmS2855975
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b2fowIUt5HOOMZ9RhqWp3MrstsKjcNsXOw+9fKWH3LA=; b=m2a0UHvl62SJ/cJ8
 PzR7czHVC7JlEZugLpJsRi6Z8M+OlutmoWB+zBAs91X2RVpkEPwG5yjja/mB4QGt
 5CAIXxJpWV+xA4bzZi9XClJ1j4Jb9kXXk/aA19/zRkTdfRCTNUHxN2GAH0Zm0ss3
 Li3ukGRanw6FgnOsfrtIX93jQfGWGdwJZkOkEAfKAW5+stta5mdYAePovuWAvwR+
 rMVXsI+ZCq9zn7Kd41J+YiysyICZk8Vj37lrxjdgjUX4JP94N1AqedRE0cwWrw21
 rWRwfym5lRqWkcibTveobkdygk94/EH/qhUca1tNBeKMujKFDHreCxve4KcnObMs
 mEmoPQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dukrp1xfu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:45:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dece274b1so61723c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777506330; x=1778111130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b2fowIUt5HOOMZ9RhqWp3MrstsKjcNsXOw+9fKWH3LA=;
 b=OuB7IywWZxGLUr3QSiZGbU+m6mVk7V5ocqKQu6SKWv7tFrCIy0OwbjmZfGo96WOndX
 fOrVqcKC5b8zmZ07TDs+TGZnBEk0k9KHcSPL0xJPgthAcgjr50SbQnkRGuvcyH8ROl8m
 bEr0uGLYyLrpivUqVsAgqhCEveG8i0sculEx4nE+i2WLDzikO5Bud8W7KG0Z8P05sfgB
 2pgG7O9ru8BUAyHx+1wUIJ93lotT/0jaC2Q3i6FDx6g1l/f+8OeUx+QnpflAqBvwVVW1
 sBoHvOhDKz2IGR+CLDNgdBllWPN7t6HkpCuC6uLoHhjFx/huV4QPPmgKlT689o+kjpAO
 nWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506330; x=1778111130;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b2fowIUt5HOOMZ9RhqWp3MrstsKjcNsXOw+9fKWH3LA=;
 b=L3YZUg2rYQhgaaBUbXz8fe2t8P+w03EBwdiKqsQET+nxrFbUidtphDwxxCzmuzo/Jz
 Ig+z39Fwp3HJHfKRBdwLY9Vko64iAIIetACmbLTQ00oebdtozBloQwQK1DJgmzMDQDfw
 LM3xrZ9chfDerFIFf31n29bIkFUnkg2rugQElKYGl/RWpsCrwE73KeIKmTGd8laffLIv
 Zj7lGcyNmtbsC3MERDNYDis5sOM1maXkwFhlM4qUvCWMHoazMo6bcOT4KJGqKpyMXi1J
 g/hldwY25/zz7MBWAtrTG2ra1ScyJ8s5RvKr+1fpst00IZRd8um1+PtdW7XGJGg7BqOs
 CIkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jF5Tq5dWzhU+EHu1Qdn4xNZdmF/rLOD9d1n75PGlzVVxOsEBJaeoHgKG+6dri1DpcxCq5QSPkKHsU@nongnu.org
X-Gm-Message-State: AOJu0YxJNAkDTdzgHO8foBXugOt2wddoAS3FlpY3dMR+ssJT3aPVJYCW
 a9mrs9DUj8EgrSllrnDYzb4D3623mKUgsKWQ1AlxSrTJojYoXI95oxlCQDDdBEMtXo3CAyAu5fg
 mHgPyVKRoU/bfsYAQfVGfuUpcfb+8LRqLWwhYFtoLsj+N04d3zGW+PVg6fA==
X-Gm-Gg: AeBDiets2tjTn7gYwyGBTNi/rxyvGQ9Oa1NHZ301wzaVWfOpFc7+6NOdzifTQhtnP8D
 LyvYNZerRUNdL/RAenrPcQ9Bto4VIFyZ8NBBW/enJ+igscrV2WXgE4reodWnI1k7rrquzWp1J89
 Iceel696tBvIt3qrzawxWH2RkTATYCYDIM3YF2XHYzQK2QbXdRzHk7BOjru6jPYHUI++6OKgv7f
 iMv4n9+4DzFFGiAajTQgJ4z6ikNpcVG00xcRnt6QOt6cOLJjQeH1GjjZB81h2bfHnFgRewttwcr
 76HoxlEnY1+qLEEzzzfeKs8prKjN8ITQFB+WmXO/vEUxV6vwAIw48I+sGrrfK2vTLuvUJHC/WT4
 ipAkLzSqcqI/ETWeUeJLwtLC6OrP/KgYzAeiJfG8FytyDzFZh2G0sxgCNwpiew5fqchpLSlCAN6
 XCFw1ekfhDjP9Tf2RMKwqseQfZ
X-Received: by 2002:a05:7022:4185:b0:12c:5e48:4bcc with SMTP id
 a92af1059eb24-12deac57cd6mr324116c88.14.1777506330148; 
 Wed, 29 Apr 2026 16:45:30 -0700 (PDT)
X-Received: by 2002:a05:7022:4185:b0:12c:5e48:4bcc with SMTP id
 a92af1059eb24-12deac57cd6mr324086c88.14.1777506329577; 
 Wed, 29 Apr 2026 16:45:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm6200642c88.5.2026.04.29.16.45.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:45:29 -0700 (PDT)
Message-ID: <59621b88-d6d6-438f-820b-79cd6ec42e2b@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:45:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Defer the IOMMU translation and support access_type
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421162912.3295598-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mckM27G6A8w3NLovKe42kOLtgvDrK-3I
X-Proofpoint-GUID: mckM27G6A8w3NLovKe42kOLtgvDrK-3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzOCBTYWx0ZWRfX3gl55Lcsz7/y
 1ZFIYsnwihrjwlvjsz9LuGcmEj2FOLPqijBQQeOBb10UkTb3kR+CmZPRFSNX1sGCEyWnv1XIqir
 PnfhuePLHN9wFSiYqZf5Nbbt9v4e77qvYmMM7CnLoKBGRNAzCB/v+fteo/Ngwa2qE6ykGwlEyL7
 gJkv0j/3EnoJxqbckmpFYIdrqcgDpvuaP1/825kK1+aweCAcmAaofREm2llieBdUh0MfkpbY7ng
 fstmgY2Z2e4we/7Bxa2Lb++C3f5u4yD621brFj+X3bO3uIZLyMUSNjdMTGtFSzEspmYI1o82HW8
 e6fZHOezdFjZg32a9+fL3I7vn5XfUmVhXEgmkXHkBj0miSDt1L60UwvGRId6syWeNhjSIKQnyea
 gk85yeZK3RnjHJpvbH1+JGVk1NrZRvjmGo7BoanT1FWEmXY+Ze5jyzmKPvGyvhJUAY7I9ncw9zF
 HdZHiWAgLs5VbbF/Tng==
X-Authority-Analysis: v=2.4 cv=WoQb99fv c=1 sm=1 tr=0 ts=69f2981b cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=GaQpPoNlAAAA:8 a=pFyQfRViAAAA:8 a=ZT-azI6cAAAA:8 a=aWiQaqnJvEPcc7PUmSQA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=xF5q_uoM5gZT5J3czcBi:22
 a=oJz5jJLG1JtSoe7EL652:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290238
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Adding Peter, who might have a good opinion on it since he worked on MPC
implementation.

On 4/21/2026 9:29 AM, Jim Shu wrote:
> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion"
> 
> Incoming security protection devices feature more complex IOMMUMemoryRegion
> implementation in the CPU path than ARM MPC device. For example,
> RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
> Consequently, the IOMMUMemoryRegion could return different sections for
> read & write access.
> 
> To support such IOMMUMemoryRegion behavior in the CPU path, the design
> of IOMMU translation must be updated:
> 
> 1. address_space_translate*() must now pass the access_type to
>    IOMMUMemoryRegion.
> 2. Since IOMMU translation results are too complex to be fully stored
>    in the CPU TLB. we will defer the translation until the actual access
>    occurs. Also, TLB is allowed to store the untranslated IOMMU region.
> 
> To implement deferred IOMMU translation, this patchset introduces the
> following changes:
> 
> 1. tlb_set_page_full() no longer translates the IOMMU region
>    immediately. Instead, it stores the untranslated region directly in
>    the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
>    access into the slow path when a region has not yet been translated
>    in the TLB entry.
> 
> 2. When the CPU utilizes a TLB entry in the slow path, it should perform
>    the lazy IOMMU translation of the access_type first. The resulting
>    translated region and access type are stored in CPUTLBEntryFull.
>    Since the slow path always performs lazy translation first, we can
>    switch the CPUTLBEntryFull content to the correct access type before
>    use.
> 
> 3. To accelerate memory access in the fast path, lazy translation can
>    update the addend of the CPUTLBEntry when translating the region to a
>    host memory region. We restrict the IOMMU region to have a single
>    non-zero 'addend' across all permissions. If a second 'addend' is
>    present for a CPUTLBEntry, QEMU will trigger an assertion. This
>    limitation is sufficient for security devices, as their "secondary"
>    region is typically an IO region used to emulate device error
>    handling when access is rejected.
> 
> 4. To support non-slow TLB flags, lazy translation can update the TLB
>    flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
>    updates the flags for the permissions specified in @prot. This
>    ensures that each access_type of a translated region to maintains
>    independent TLB flags. For example, TLB_DIRTY of memory region will
>    not be "polluted" from other permission that translated to different
>    region.
> 
> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
> feature.
> 
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> [2] RISC-V IOPMP:
> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
> 
> Changed since v1:
> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
>   translation until actual access in the CPU path. Provide a IOMMU
>   lazy translation function with the special handling of 'addend'
>   and 'addr_idx' fields of CPUTLBEntry.
> - Fix the checkpatch warning.
> 
> 
> Jim Shu (5):
>   accel/tcg: Pass access_type as an argument of tlb_set_page*()
>   accel/tcg: address_space_translate*() will pass the correct
>     iommu_flags
>   accel/tcg: Provide early AS translate function
>   accel/tcg: Add IOMMU lazy translation function
>   accel/tcg: Support IOMMU lazy translation in CPU TLB
> 
>  accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
>  include/accel/tcg/iommu.h            |  17 +-
>  include/exec/cputlb.h                |  11 +-
>  include/exec/tlb-flags.h             |   4 +-
>  include/hw/core/cpu.h                |  15 ++
>  system/physmem.c                     |  60 ++++++-
>  target/alpha/helper.c                |   2 +-
>  target/avr/helper.c                  |   3 +-
>  target/hppa/mem_helper.c             |   1 -
>  target/i386/tcg/system/excp_helper.c |   3 +-
>  target/loongarch/tcg/tlb_helper.c    |   2 +-
>  target/m68k/helper.c                 |  10 +-
>  target/microblaze/helper.c           |   8 +-
>  target/mips/tcg/system/tlb_helper.c  |   4 +-
>  target/or1k/mmu.c                    |   2 +-
>  target/ppc/mmu_helper.c              |   2 +-
>  target/riscv/cpu_helper.c            |   2 +-
>  target/rx/cpu.c                      |   3 +-
>  target/s390x/tcg/excp_helper.c       |   2 +-
>  target/sh4/helper.c                  |   3 +-
>  target/sparc/mmu_helper.c            |   6 +-
>  target/tricore/helper.c              |   2 +-
>  target/xtensa/helper.c               |   3 +-
>  23 files changed, 354 insertions(+), 58 deletions(-)
> 


