Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8171C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 19:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbP73-0006i9-2u; Fri, 24 Jan 2025 14:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP72-0006i1-DW
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:04 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbP70-0007ou-HO
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 14:13:04 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so3476121a91.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 11:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737745980; x=1738350780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bGuBtKeysAO8wc8jjeKvdfpWkF8cN+yZwOGAcXA3kBk=;
 b=cvqQZG+eIJtBuaZpokOZ8dC4Z2NjLS5ymCcnFHKgFdc49tJj1nHTWHRvnag2DVYC4w
 OiJIjlZgNLAJL6hQY6UrZEII6XSfJZfTlxDXI9Qq+WgX2//49FXprFNLd/YWwsHxjT8t
 1up8dtyMUZm8XMA2iYBO6MQKCw+sEB+lzoAE997OuGrp8Z0ckYRfCVWKz1MC5G1SHQMm
 45b8D/c7O4sHEptGvL5Zx9aElWcPzXnM/QEJfnwM8nQzEpNMlKiBFJyojIvuP5miFUNN
 yXzpj60fxQ7KuJdSOY9x+qqJVmtEZsxc8Mw11V5KVfa2GpyFf25TNx3nvX+eVMYyMvyq
 MmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745980; x=1738350780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bGuBtKeysAO8wc8jjeKvdfpWkF8cN+yZwOGAcXA3kBk=;
 b=fLCx7KLNbme9EtCeN6XR90J0NAariMISfkgsL1wGUV9Idawpjl1b/idiwnLk90EDeS
 EvKY5+LwWNBKWnMDk6js9TGCBe/FBUFeH7EKmbzAa+/iGiuOjMvll5/pynlAd3j9PAZj
 GN08y6FcUTEiPI0y261FeLARPXCbkBfhvK3q0rfaQLyMaVQNQN9bUvgFSlgFOdAigUWo
 VZl3m8grRkUTj45vMp+pfgRjMgzXFKGKF5PS/QAreQc8ivrsTe4C1lJoWk/lEvRutvjM
 sC/gsHMZiRpICEI8IbtQ6LfFkrhxIDy+pKG39q7u0QiClWstEtqapOBc8Tl+sIchDmCC
 w40g==
X-Gm-Message-State: AOJu0YwaNWn7GUOmXVoXKeelNcrfry74p6OhojjIXNgRTQNWeXSUB4+L
 YmM3Y4SmLysIidGbH7+pDG+Aqzei+QE4QCDM3GRKy1OXceQx214=
X-Gm-Gg: ASbGnctXtP4EWr0/86+Kexz4o3axK0WWdcQVeT++pu+rsnbNvSPxnEW8GZzf+kjl6zW
 tuLCUDZ6pePpAxc2QCnbvLnovYPeN2lNEvnkqdGFDNMC2raMv65HFc5qdZd7arRt4VBZ8Wv490p
 jR0ZiWUXmonI8xeRVnMoXkW5qz8QyASz6mi1TO/mPFNuP0UvkfJCjkyyd54Zl7wCeOZWHecP1q5
 Znw9/4QZijQNFtIrzZrhuxwLyhuuLm8zWplzzvlgWQs6ORFZN6ESPhfyIz+qqnH1RLmsXWoessH
 f0oIotiviSEebpM3aA==
X-Google-Smtp-Source: AGHT+IF5UvHeTndnwO83HvxyxB/csJLzp/OanxEzaihtGmdz/JqEGG2d7DIWDZ1FbrQSrsy8CiaxTg==
X-Received: by 2002:a05:6a00:148d:b0:725:eb85:f802 with SMTP id
 d2e1a72fcca58-72daf930e3cmr44209856b3a.2.1737745979970; 
 Fri, 24 Jan 2025 11:12:59 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69eb75sm2318406b3a.12.2025.01.24.11.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:12:59 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 0/5] vfio/igd: remove incorrect IO BAR4 quirk
Date: Sat, 25 Jan 2025 03:12:40 +0800
Message-ID: <20250124191245.12464-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1044.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Based on experiments and reverse engineering about the mysterious IO
BAR4, it appears that the current quirk implementation is incorrect.
As discussed in a previous mail thread [1], current implementation
believes VBIOS is writing HPA of Data Stolen Memory (DSM) in GTT
entries, so it intercepts and writes (addr - Host BDSM + Guest BDSM)
instead, probably believes the addresses are hardcoded in VBIOS.

With disassembling a VBIOS of Intel Sandy/Ivy Bridge and Haswell [2]
(thankfully there is only a few 32-bit out instructions), VBIOS read
BDSM from pci config space, which is programmed by SeaBIOS [3] in
guest. That is to say, VBIOS actually writes GPA when programming GTT
initial entries, the current quirk is incorrect.

The change was tested on a Kaby Lake HD620 (Gen 9) by comparing GTT
entries read from MMIO BAR0 and IO BAR4.

This patchset also creates a new function vfio_config_quirk_setup()
for the config space quirk previously in vfio_probe_igd_bar4_quirk().
The OpRegion quirk in vfio_realize() is also merged into the config
qurk. Finally all the igd-related codes are moved to igd.c.

[1] https://lore.kernel.org/qemu-devel/b373a030-5ccf-418c-9213-865ddc6748fd@gmail.com/
[2] https://winraid.level1techs.com/t/offer-intel-sandy-ivy-bridge-and-haswell-vbios-modules/30272
[3] https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332

Related VBIOS disassembly:

# read BDSM
6498:	66 53                	push   %ebx
649a:	66 2e 83 3e 94 64 00 	cmpl   $0x0,%cs:0x6494  # BDSM already read?
64a1:	74 07                	je     0x64aa
64a3:	66 2e a1 94 64       	mov    %cs:0x6494,%eax 
64a8:	eb 0f                	jmp    0x64b9
64aa:	b8 5e 10             	mov    $0x105e,%ax      # 5e == 5c + 2, that's why shl 16 later?
                                                    # ((2 << 11) + 0x5e)
64ad:	e8 55 05             	call   0x6a05           # read config space via port cf8/cfc
64b0:	66 c1 e0 10          	shl    $0x10,%eax       # eax << 16
64b4:	66 2e a3 94 64       	mov    %eax,%cs:0x6494  # save BDSM
64b9:	66 5b                	pop    %ebx
64bb:	c3                   	ret
# program single GTT entry, esi: addr, eax: data
6d16:	66 50                	push   %eax
6d18:	52                   	push   %dx
6d19:	2e 8b 16 4a e4       	mov    %cs:-0x1bb6,%dx  # saved MMIO_Index port
6d1e:	66 96                	xchg   %eax,%esi
6d20:	66 ef                	out    %eax,(%dx)       # write MMIO_Index
6d22:	2e 8b 16 4c e4       	mov    %cs:-0x1bb4,%dx  # saved MMIO_Data port
6d27:	66 96                	xchg   %eax,%esi
6d29:	66 83 c8 01          	or     $0x1,%eax        # set valid bit
6d2d:	66 ef                	out    %eax,(%dx)       # write MMIO_Data
6d2f:	5a                   	pop    %dx
6d30:	66 58                	pop    %eax
6d32:	c3                   	ret
# program GTT entries, esi: entry addr, eax: page addr
e929:	51                   	push   %cx
e92a:	e8 6b 7b             	call   0x6498       # read BDSM
e92d:	25 00 e0             	and    $0xe000,%ax
e930:	66 83 c8 01          	or     $0x1,%eax    # valid bit
e934:	66 be 01 00 00 00    	mov    $0x1,%esi    # gtt access bit in addr
e93a:	e8 d9 83             	call   0x6d16       # single entry routine
e93d:	66 83 c6 04          	add    $0x4,%esi    # next entry
e941:	66 05 00 10 00 00    	add    $0x1000,%eax # next page
e947:	e2 f1                	loop   0xe93a
e949:	59                   	pop    %cx
e94a:	c3                   	ret

Observed layout of the undocumented MMIO_Index register:
 31                                                   2   1      0
+-------------------------------------------------------------------+
|                        Offset                        | Rsvd | Sel |
+-------------------------------------------------------------------+
- Offset: Byte offset in specified region, 4-byte aligned.
- Sel: Region selector
       0: MMIO register region (first half of MMIO BAR0)
       1: GTT region (second half of MMIO BAR0). Pre Gen11 only.


Changelog:
v2:
* Move the OpRegion quirk from vfio_realize() to vfio_probe_igd_config_
  quirk(), as proposed in v1, making it reasonable to return bool.
Link: https://lore.kernel.org/qemu-devel/20250122171731.40444-1-tomitamoeko@gmail.com/

Tomita Moeko (5):
  vfio/igd: remove GTT write quirk in IO BAR 4
  vfio/pci: add placeholder for device-specific config space quirks
  vfio/igd: refactor vfio_probe_igd_bar4_quirk() into pci config quirk
  vfio/igd: do not include GTT stolen size in etc/igd-bdsm-size
  vfio/igd: handle x-igd-opregion in vfio_probe_igd_config_quirk()

 hw/vfio/igd.c        | 381 ++++++++++++++-----------------------------
 hw/vfio/pci-quirks.c |  51 +-----
 hw/vfio/pci.c        |  29 +---
 hw/vfio/pci.h        |   7 +-
 4 files changed, 136 insertions(+), 332 deletions(-)

-- 
2.45.2


