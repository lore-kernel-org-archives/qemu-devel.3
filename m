Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578FBC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62GV-0007hM-9C; Mon, 14 Sep 2026 04:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x62GR-0007aJ-0F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:42:12 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x62GO-0005lP-8u
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:42:10 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so2121697a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 01:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789375324; x=1789980124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wGITBOEYO32+cFmwKLRhC6sFLKrwKfXzxZ93sjA3g20=;
 b=o2t9RdcwnrcJG7mF0MeFfBlULoDB5Zo13LZpIRmoUvbT6/8fclMLWnRwDL6fjEfNoz
 7qPoGbnDfCwGi6xhcKHRWqPL09ByjiswtbE1ev3EZ7sRDndq5fWy35brHGjTeusem/32
 G/FeoQPsQSTUhSbz0elZzru2EdHWf3kd7WzcrjIW6cAg/wlUoDLoFJ7w7wwXn30C/G2c
 OSumbEar9TDrZvPhyX3mqroDqZZ3m1yR+9qPFbcurgaWD4Ifohrt6uBH/C3vHBvya3Kz
 si+w1bGNmXvgw9Vpy8g0RaJsDYFAISKqPnn0FRiRMRPWRTwFfAHjoKVPo+ios3F0C3EA
 qzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789375324; x=1789980124;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wGITBOEYO32+cFmwKLRhC6sFLKrwKfXzxZ93sjA3g20=;
 b=XCtbm2b9NmKA+RGEaARGLPAAsDIVZ0Txt531R981Ht2l13nqkvPNiiZu3LpLNcLjQD
 Le4U6+DImLUNxsTVZ62Yv8eAZGW6raWVxYwA9sjjQTJsSojJs7XiOu5XH933W3tWzNDA
 cWtfzbwZG+iIVfUdGYOn9r40uaBZ628x/QurE23D8nW0yi+u+Q5HsgLsNQNcXroz6y5s
 lROISTrhIcniR/CJkBxmS/8TsIYg0m/Hch89tGUTm9EJjcsdN3Fleql+qIY/aEABXi4Z
 fNIZgeCGt+aSA/paH+sv8hgnn8gfSk5yfS3JS2gMgIgEPihmr+E1DepiLnhNhprninZJ
 NG8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnS/V8vLZiWKLhwj7QmoEpnOhP3JQtKYeIorfzrc4cjIZbZ5/j1GRdYplol/zQTnKuGhcqoQ3yCOas@nongnu.org
X-Gm-Message-State: AFuF++lZx8Ap//086XB4DH7t/OYFB2Ch4JU51s3cpOGKKVLtARfjU0Q4
 8qARvNhUrvOyyVa6eIIRiVmTPbNh9aWI/nsowO1zov4dV4axC2cESRY=
X-Gm-Gg: AYBFou0dlEnvYcYjYt/bEjqlJaVHgEL0B3p1IDztxbK+Zu9qYs+tvfKS4BLIgAg+/uu
 OP7bejed+2w9BYwqMp+jXa4H2fvw/rvcbZJgRnk+uB5UcT7H0f0EZLykz0y1i10FJPY2+YA4nGw
 h3aBIxw96GgL5+UM2aqL/qNYmxXyhQiC5Yf5Dh5JXqssEUJvtySqk2PxBoxkMu0LEZcrR+WDfZx
 d3IvLe14q/RQINT6oUNFd3kt1t2H5q3DoAjd2Homq+381EuCrp7XYeJlS4xeXvIp1AN9bxh5ju+
 pKyCyygCqj4QzTjC/Ad56pGCYaqvQQxzHZQlM+v8DC5I06FCbnDWOJEzKROo9ybfbEnFFkms1n+
 lOHzSeTg3GqyJ0cLmFU8i/1ST9LEhzOxwT3U6v6smd13gAT3K9Vfs2a+hVlmG9SkqjMhsL+r5s/
 YMbTyAX+Y2N+ebG2o+OeKQnyGDbMeg230wqanzrkpEHLFr5ebhnQImxcgaV4G2UyKc7rM8WpvdV
 Ab6KmdwSJowfgFovkGLumzRipjQu0L63yRCTe+C5U1y38GENeWYtTLY+0A4MLdsMA==
X-Received: by 2002:a05:6a20:d80d:b0:3da:e7dd:45d5 with SMTP id
 adf61e73a8af0-3db40568311mr3200003637.20.1789375323817; 
 Mon, 14 Sep 2026 01:42:03 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:b0aa:8f70:be80:3f60?
 ([2408:820c:8ffa:c0f0:b0aa:8f70:be80:3f60])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm26641120eec.24.2026.09.14.01.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:42:03 -0700 (PDT)
Message-ID: <e1c9833b-e534-4b02-831d-a22a25cc2a47@gmail.com>
Date: Mon, 14 Sep 2026 16:41:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
To: "Wang, Yuan1" <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, bosheng.xue@intel.com,
 junjie.cao@intel.com
References: <20260825090435.1492485-1-yuan1.wang@intel.com>
 <c425dffd-ccc6-42b0-b083-51f06562237d@gmail.com>
 <2dde7fa2-de05-4a8b-91d0-22e0fb1df107@gmail.com>
 <22327826-756f-445f-be34-f97b5f983976@intel.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <22327826-756f-445f-be34-f97b5f983976@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-09-11 16:36, Wang, Yuan1 wrote:
> Hi Moeko
>=20
> Thanks for the kind review.
>=20
> On 9/8/2026 5:09 PM, Tomita Moeko wrote:
>> I took a deeper look about the change, this change actually changes
>> vfio_probe_igd_bar0_quirk() to go with the 64-bit emulated BDSM regist=
er
>> path, right? But the problem is, does the BDSM register really exists =
on
>> Meteor/Arrow Lake and later iGPUs?
>>
>> In drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c:xe_ttm_stolen_mgr_init()
>>
>> 	if (IS_SRIOV_VF(xe))
>> 		stolen_size =3D 0;
>> 	else if (IS_DGFX(xe))
>> 		stolen_size =3D detect_bar2_dgfx(xe, mgr);
>> 	else if (GRAPHICS_VERx100(xe) >=3D 1270)  // MTL+
>> 		stolen_size =3D detect_bar2_integrated(xe, mgr);
>> 	else
>> 		stolen_size =3D detect_stolen(xe, mgr);
>>
>> For Meteor Lake and later, detect_bar2_integrated() is called. The DSM=

>> region used is at (BAR2 + 8M).
>>
>> 	/*
>> 	 * Graphics >=3D 1270 uses the offset to the GSMBASE as address in th=
e
>> 	 * PTEs, together with the DM flag being set. Previously there was no=

>> 	 * such flag so the address was the io_base.
>> 	 *
>> 	 * DSMBASE =3D GSMBASE + 8MB
>> 	 */
>> 	mgr->stolen_base =3D SZ_8M;
>> 	mgr->io_base =3D pci_resource_start(pdev, 2) + mgr->stolen_base;
>>
>> drivers/gpu/drm/i915/gem/i915_gem_stolen.c:i915_gem_stolen_lmem_setup(=
)
>> also suggests it is (BAR2 + 8M) on MTL (i915 only supports up to MTL)
>>
>> 	if (HAS_LMEMBAR_SMEM_STOLEN(i915)) {  // Only True for MTL
>> 		/*
>> 		 * MTL dsm size is in GGC register.
>> 		 * Also MTL uses offset to GSMBASE in ptes, so i915
>> 		 * uses dsm_base =3D 8MBs to setup stolen region, since
>> 		 * DSMBASE =3D GSMBASE + 8MB.
>> 		 */
>> 		ret =3D mtl_get_gms_size(uncore);
>> 		if (ret < 0) {
>> 			drm_err(&i915->drm, "invalid MTL GGC register setting\n");
>> 			return ERR_PTR(ret);
>> 		}
>>
>> 		dsm_base =3D SZ_8M;
>> 		dsm_size =3D (resource_size_t)(ret * SZ_1M);
>>
>> 		GEM_BUG_ON(pci_resource_len(pdev, GEN12_LMEM_BAR) !=3D SZ_256M);
>> 		GEM_BUG_ON((dsm_base + dsm_size) > lmem_size);
>> 	} else {
>> 		...
>> 	}
>>
>> 	if (i915_direct_stolen_access(i915)) {
>> 		...
>> 	} else if (pci_resource_len(pdev, GEN12_LMEM_BAR) < lmem_size) {
>> 		...
>> 	} else {  // MTL
>> 		io_start =3D pci_resource_start(pdev, GEN12_LMEM_BAR) + dsm_base;
>> 		io_size =3D dsm_size;
>> 	}
>>
>> In addition, nothing about the BDSM register can be found in MTL datas=
heet vol2,
>> neither 32-bit 0x5C nor 64-bit 0xC0. I believed it is removed since Me=
teor Lake.
>> https://edc.intel.com/content/www/us/en/design/publications/14th-gener=
ation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-regi=
sters/
> Correct. The BDSM register at PCIe config space offsets 0x5C/0xC0 has
> been removed on Meteor Lake and Arrow Lake.

Got it.

>> Since you are probably an intel employee (from your mail address), you=
 may check
>> the GOP driver code to see if the BDSM register (0x5C/0xC0 in config s=
pace and
>> 0x1080C0 in BAR0) is really used or not. Please kindly correct me if I=
 am wrong.
>=20
> For Meteor Lake and Arrow Lake, BDSM is still present and located in th=
e
> MMIO space at offset 0x1080C0 of BAR0.=C2=A0

Just curious, on host side, does the value of 0x1080C0 equals (BAR2 + 8M)=

on Meteor and Arrow Lake?

> The GOP driver continues to read this register to obtain the stolen
> memory base address.
>=20
> And for MTL, there is a WA which there in Linux Gfx driver which cause
> it to read 0x1080c0.
> Please check the following function i915_direct_stolen_access().
>=20
> drivers/gpu/drm/i915/i915_utils.c: i915_direct_stolen_access()
> bool i915_direct_stolen_access(struct drm_i915_private *i915)
> {
> =C2=A0 =C2=A0 /*
> =C2=A0 =C2=A0 =C2=A0* Wa_22018444074
> =C2=A0 =C2=A0 =C2=A0*
> =C2=A0 =C2=A0 =C2=A0* Access via BAR can hang MTL, go directly to GSM/D=
SM,
> =C2=A0 =C2=A0 =C2=A0* except for VM guests which won't have access to i=
t.
> =C2=A0 =C2=A0 =C2=A0*
> =C2=A0 =C2=A0 =C2=A0* Normally this would not work but on MTL the syste=
m firmware
> =C2=A0 =C2=A0 =C2=A0* should have relaxed the access permissions suffic=
iently.
> =C2=A0 =C2=A0 =C2=A0* 0x138914=3D=3D0x1 indicates that the firmware has=
 done its job.
> =C2=A0 =C2=A0 =C2=A0*/
> =C2=A0 =C2=A0 return IS_METEORLAKE(i915) && !i915_run_as_guest() &&
> !IS_SRIOV_VF(i915) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 intel_uncore_read(&i915->uncore, MTL_PCODE_=
STOLEN_ACCESS) =3D=3D
> STOLEN_ACCESS_ALLOWED;
> }
>=20
> Consequently, MTL still needs to read BDSM to obtain the DSM base
> address in i915_gem_stolen_lmem_setup() function.
> As seen in i915_direct_stolen_access(), this bypass logic only applies
> to the bare-metal environment (it falls back for VMs).
> However, the GOP driver does not differentiate between bare-metal and
> virtualized environments, so we still have to provide a valid BDSM valu=
e
> to it in GOP driver.
>=20
>> For the "IgdAssignmentDxe fails validation on the zero BDSM size and a=
borts
>> without programming the ASLS register", having a fix skipping BDSM siz=
e check
>> on Meteor Lake and later ones could make it work? OpRegion is automati=
cally
>> detected and exposed to guest on IGD as I remember.
> The MTL GOP driver always attempts to read from the BDSM register, so a=

> valid BDSM base address and size must be provided.
>=20
> Thanks
>=20
> Yuan


My concern is that if guest driver still uses (BAR2 + 8M) as DSM base, wh=
ile
0x1080C0 pointing to the mocked region, will this bring any inconsistency=
?
Having the register pointing to guest's (BAR2 + 8M) sounds more reasonabl=
e,
but it would require more efforts, monitoring config space writes to BAR2=
 and
changing the emulated value in QEMU.

Possibly an easier way is emulating MTL_PCODE_STOLEN_ACCESS(0x138914) to
disallowed in QEMU, if the GOP driver code checks it, to enforce the acce=
ss
via BAR2 in guest. I'm also not sure if the issue in Wa_22018444074 also
applies to virtualized guests and how ofter it reproduces :(

Best Regards,
Moeko

