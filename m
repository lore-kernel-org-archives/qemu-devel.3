Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB76BFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0BL5-0005rR-EY; Wed, 11 Mar 2026 00:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0BL4-0005qm-45
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:38:30 -0400
Received: from p-west3-cluster3-host6-snip4-8.eps.apple.com ([57.103.72.149]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0BL1-00009g-TI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:38:29 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPS id
 126CE1800115; Wed, 11 Mar 2026 04:38:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773203905; x=1775795905;
 bh=MRhTMLbckXL3VipTVa6PZJi3AQtBnnu+OOBo3XYWzYo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=QKl2nVW+0W9S/LhY4GXF54Z6sJU/RxP1b0rk+D1yUJp1Kjx0vhWIeswfJR6I9KHuW/8ayY0hew/ffbtyAILbtgDbepa+9p+P1mTxH0rk2Oc1gS1qYyks95S//VIubnK5xu0aGmS5FgmcJKOgabAPgjl/DPMN6z17bL5vL4hYIb61JDgV5xGNimrObG9RPGrz+DryTAv1GzhCPa7QZ4Eh47ZeNqK848jgQ25sTKCtJuEsXt8czMM7iOmklfME6/SBVMbaNp1k0v0cCml0QZp2wtJ/KYejTrXIV69wDoty0+OlCIFUwy21pSUtmaJQA/PE8RvhpI33Ex5jtUFPMPqItg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPSA id
 4D52C18000B2; Wed, 11 Mar 2026 04:38:21 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 1/2] accel/hvf: introduce map granule abstraction and
 IPA property
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311022732.64141-2-lucaaamaral@gmail.com>
Date: Wed, 11 Mar 2026 05:38:09 +0100
Cc: qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <14FFE8F2-761A-4311-8723-D080FBD0AE91@unpredictable.fr>
References: <20260309214906.92578-1-lucaaamaral@gmail.com>
 <20260311022732.64141-1-lucaaamaral@gmail.com>
 <20260311022732.64141-2-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=Xqn3+FF9 c=1 sm=1 tr=0 ts=69b0f1bf
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=W6c9j4fWfPrNKXKlBuAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _rHirSdGNqjlB-tyq13PVxxFY0eD05xQ
X-Proofpoint-ORIG-GUID: _rHirSdGNqjlB-tyq13PVxxFY0eD05xQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzNiBTYWx0ZWRfX4pqProDahTfF
 yV32Dt5YHUh9jm0wCBtiNglQNaB+4tLzVXWvcx3ynhUsaoGutzShu+QuVGcVv9Fgk5Z3Lyw8VZL
 xkBiX1wAcx02nmv1yq4n87n+yaWcGYJMlV8FwYWq7KIesxk016eSEYnbycsMjyVsohwyC9Ll/3G
 P1axIdKdK/JL6DS4TrWZr0zNk3f4pdEh0E0Td2HVSmgg4LWo/E5hBeuvx24hmGNDQtDN+kD30ZZ
 GLxb1Bi2h0X0C+ShSTy2KTKoSl7MKK/1oOb7hxM310MTJSWG18xiDshyLw3lirnz0RJhhzhgN0b
 tYt5yVMT3LSh3LRj2Zi2drev8udNvVbdebl6znfyrs1o8ezO0yTvy5ZW1xbToc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1030 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603110036
X-JNJ: AAAAAAABfZ14g5adwcwab973LSuocN0zE5me5QHve3ueY25jcVk+EJiOiKgFfzjcdHZF5fdaVIeD7PIticIlweUz5UyAWxwNYuzVsVAcepwPQEMsk/GajgRThUFThDpSdRJEMsW47y4EbIMcLPtoqZ2TsGw8YN3BAEEw3qGwsVE3vAsNf5YIByjEc292zEUMZbmq+T3JfLuQTtl5UqlP6VAX8pJ3gGn686I/+lkavwg4gSSNJHKN7qGIALDTbyKtfbmKJ214Yx2lIExUfSufQy9vrPZi0uZsbWdpgv5fzFgq0BT2qLTG6dgjQq502J+R1Mlg4dkYgmGnf2jkCeINClC+HOD9c1PVd4PmVH8b6+Ux3ZvFtKVIEapEojRcOHl9wwTPvaSyC/nVc6A/xLIaEo3PnYHlG7cnP32cFWM6BnfhH2bW1UNZR3dDEHNxphxACLY3alAPLJKZ1SpS1aHxPOi2Se89WaVFhvSjJYooaGovu/qlHWM98+8JMXV/ssMHIlKvTXZkNQ5ugpx5oxnqrUnD4LoKK6B8Vi+d7zDVEJeDmLhd2XpzNuEdv/70tm6/gNJKiYJxr1gld3o0wsf5AtHUbDC7hQFZ0QkUgd5To8+Wp7Rf9orYD5PM6Xs7CkVxdq/O2GFY9iROM9++zVUYzekkxuE0Clq+5bQmnjo=
Received-SPF: pass client-ip=57.103.72.149;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 11. Mar 2026, at 03:27, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> Replace hardcoded qemu_real_host_page_size() in HVF memory mapping
> with a configurable map granule.  Non-aligned regions now return
> early instead of proceeding with add=3Dfalse.
>=20
> Add an 'ipa-granule' property (auto, 4k, 16k) on the HVF accelerator
> object for aarch64, allowing the user to select the IPA page granule
> for HVF stage-2 address translation:
>=20
>  -accel hvf,ipa-granule=3D4k
>=20
> 'auto' (the default) resolves to the host page size (16KB on macOS
> ARM64).  The actual HVF configuration is handled by the arch-specific
> hvf_arch_vm_create() in a subsequent patch.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> accel/hvf/hvf-all.c      | 67 ++++++++++++++++++++++++++++++++++++++--
> include/system/hvf.h     | 15 +++++++++
> include/system/hvf_int.h |  1 +
> 3 files changed, 80 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 033c677..d94926b 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -10,6 +10,8 @@
>=20
> #include "qemu/osdep.h"
> #include "qemu/error-report.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> #include "accel/accel-ops.h"
> #include "exec/cpu-common.h"
> #include "system/address-spaces.h"
> @@ -23,6 +25,21 @@
>=20
> bool hvf_allowed;
>=20
> +static uint64_t hvf_map_granule;
> +
> +void hvf_set_map_granule(uint64_t size)
> +{
> +    hvf_map_granule =3D size;
> +}
> +
> +uint64_t hvf_get_map_granule(void)
> +{
> +    if (!hvf_map_granule) {
> +        return qemu_real_host_page_size();
> +    }
> +    return hvf_map_granule;
> +}
> +
> const char *hvf_return_string(hv_return_t ret)
> {
>     switch (ret) {
> @@ -54,7 +71,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char =
*file, unsigned int line,
> static void do_hv_vm_protect(hwaddr start, size_t size,
>                              hv_memory_flags_t flags)
> {
> -    intptr_t page_mask =3D qemu_real_host_page_mask();
> +    intptr_t page_mask =3D -(intptr_t)hvf_get_map_granule();
>     hv_return_t ret;
>=20
>     trace_hvf_vm_protect(start, size, flags,
> @@ -84,7 +101,7 @@ static void hvf_set_phys_mem(MemoryRegionSection =
*section, bool add)
>     MemoryRegion *area =3D section->mr;
>     bool writable =3D !area->readonly && !area->rom_device;
>     hv_memory_flags_t flags;
> -    uint64_t page_size =3D qemu_real_host_page_size();
> +    uint64_t page_size =3D hvf_get_map_granule();
>     uint64_t gpa =3D section->offset_within_address_space;
>     uint64_t size =3D int128_get64(section->size);
>     hv_return_t ret;
> @@ -105,7 +122,7 @@ static void hvf_set_phys_mem(MemoryRegionSection =
*section, bool add)
>     if (!QEMU_IS_ALIGNED(size, page_size) ||
>         !QEMU_IS_ALIGNED(gpa, page_size)) {
>         /* Not page aligned, so we can not map as RAM */
> -        add =3D false;
> +        return;
>     }
>=20
>     if (!add) {
> @@ -187,6 +204,11 @@ static int hvf_accel_init(AccelState *as, =
MachineState *ms)
>     int pa_range =3D 36;
>     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>=20
> +    /* Resolve ipa-granule=3Dauto =E2=86=92 host page size */
> +    if (!s->ipa_granule) {
> +        s->ipa_granule =3D qemu_real_host_page_size();
> +    }
> +    hvf_set_map_granule(s->ipa_granule);
>=20
>     if (mc->get_physical_address_range) {
>         pa_range =3D mc->get_physical_address_range(ms,
> @@ -217,6 +239,37 @@ static int hvf_gdbstub_sstep_flags(AccelState =
*as)
>     return SSTEP_ENABLE | SSTEP_NOIRQ;
> }
>=20
> +#ifdef __aarch64__
Hello,

checkpatch will warn on this, maybe this should be in a separate =
potential hvf_arch_accel_init?

> +static char *hvf_get_ipa_granule(Object *obj, Error **errp)
> +{
> +    HVFState *s =3D HVF_STATE(obj);
> +
> +    if (s->ipa_granule =3D=3D 4 * KiB) {
> +        return g_strdup("4k");
> +    }
> +    if (s->ipa_granule =3D=3D 16 * KiB) {
> +        return g_strdup("16k");
> +    }
> +    return g_strdup("auto");
> +}
> +
> +static void hvf_set_ipa_granule(Object *obj, const char *value, Error =
**errp)
> +{
> +    HVFState *s =3D HVF_STATE(obj);
> +
> +    if (!strcmp(value, "auto")) {
> +        s->ipa_granule =3D 0;
> +    } else if (!strcmp(value, "4k")) {
> +        s->ipa_granule =3D 4 * KiB;
> +    } else if (!strcmp(value, "16k")) {
> +        s->ipa_granule =3D 16 * KiB;
> +    } else {
> +        error_setg(errp, "invalid ipa-granule: '%s' (use auto, 4k, =
16k)",
> +                   value);
> +    }
> +}
> +#endif /* __aarch64__ */
> +
> static void hvf_accel_class_init(ObjectClass *oc, const void *data)
> {
>     AccelClass *ac =3D ACCEL_CLASS(oc);
> @@ -224,6 +277,14 @@ static void hvf_accel_class_init(ObjectClass *oc, =
const void *data)
>     ac->init_machine =3D hvf_accel_init;
>     ac->allowed =3D &hvf_allowed;
>     ac->gdbstub_supported_sstep_flags =3D hvf_gdbstub_sstep_flags;
> +
> +#ifdef __aarch64__
> +    object_class_property_add_str(oc, "ipa-granule",
> +                                  hvf_get_ipa_granule,
> +                                  hvf_set_ipa_granule);
> +    object_class_property_set_description(oc, "ipa-granule",
> +        "IPA granule for HVF stage-2 translation (auto, 4k, 16k)");
> +#endif
> }
>=20
> static const TypeInfo hvf_accel_type =3D {
> diff --git a/include/system/hvf.h b/include/system/hvf.h
> index d3dcf08..d1b702b 100644
> --- a/include/system/hvf.h
> +++ b/include/system/hvf.h
> @@ -36,4 +36,19 @@ typedef struct HVFState HVFState;
> DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
>                          TYPE_HVF_ACCEL)
>=20
> +#ifdef CONFIG_HVF_IS_POSSIBLE
> +/*
> + * Minimum alignment for hv_vm_map(). Returns host page size (16KB on
> + * macOS ARM64), or 4KB when HVF 4KB IPA granule is configured (macOS =
26+).
> + */
> +void hvf_set_map_granule(uint64_t size);
> +uint64_t hvf_get_map_granule(void);
> +#else
> +static inline void hvf_set_map_granule(uint64_t size) {}
> +static inline uint64_t hvf_get_map_granule(void)
> +{
> +    return qemu_real_host_page_size();
> +}
> +#endif
> +
> #endif
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 2621164..4c1caba 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -38,6 +38,7 @@ struct HVFState {
>=20
>     hvf_vcpu_caps *hvf_caps;
>     uint64_t vtimer_offset;
> +    uint32_t ipa_granule;
>     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
> };
> extern HVFState *hvf_state;
> --=20
> 2.52.0
>=20
>=20


