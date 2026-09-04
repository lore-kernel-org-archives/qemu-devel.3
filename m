Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A733C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 21:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2bBr-0004sX-Ku; Fri, 04 Sep 2026 17:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2bBq-0004sG-Bq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 17:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2bBo-0001MC-9e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 17:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788556270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92GwyJ/3KmgySM3uwN6kzIPxQgxqUQIHvgkK3S1RNlM=;
 b=RKkr4IPv4hHRo9g6AEgWrPJwW+m24uQkF95XackVcKlTmSQPoD2kp6s8VDSHinLrCXVnYA
 nWSSA5+ZG2LdI9qtRspu6XwYCOia6zgvk37/lci0AY2kv8C3OTTyzvf2CHwO3wcU3zW4w0
 BK2csc1zJ11V2VX0Kx+DpDbG054KWrA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-nZW8BMr5Md6et_UWzRMuyw-1; Fri, 04 Sep 2026 17:11:08 -0400
X-MC-Unique: nZW8BMr5Md6et_UWzRMuyw-1
X-Mimecast-MFC-AGG-ID: nZW8BMr5Md6et_UWzRMuyw_1788556268
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4839f9edb08so910406f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788556267; x=1789161067; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=92GwyJ/3KmgySM3uwN6kzIPxQgxqUQIHvgkK3S1RNlM=;
 b=piMNvu8wmbASLH7PYLJSP1WtCnnY1q5LelZl1UpzC+vNHEVQLedMbvV1ckyuZihd9E
 sPTCQuqPGe9Br0UHcdbqtxCgT7IToozsXhJhRutxd7BlWu56BKh7+vmz7ng2I+R8KlZY
 4+dMiHudnwZhWHe3AC2AyfAaAatPL5hUEK9SAQ2gpy4fUBMogJhWtwWFqbPOrBqg1cbr
 1fDcdFloCeOZkZGBdQdglJPfdyZ2qK3ogTJD8s0kUM2rfC8CrSx/smW6Xv/dFkuqrbTw
 4+yfTDXT5rljV+yLG0mSRmiU6C3D9/zrgXFifUD1CKcNZziN9ye359FqYmDa/Ks+E0mM
 TRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788556267; x=1789161067;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=92GwyJ/3KmgySM3uwN6kzIPxQgxqUQIHvgkK3S1RNlM=;
 b=N0iTD9TKY3i7IFya1Exzp4+NbhyLrA0l1++GuoMH8pyhVB4b0nlqiwj21hPgV4gEvF
 F8ts5X/XEKoNK5NS1XqAl3erJVfegeoHuCTHQw2xe2ZfoD3wug7smpv17AzoXq8bc1A5
 A5iZ3SWc9mFFeqVncp+67MqrFV33Ib9RNInFc+txUvCAy7ksZNHNvvDshIKYKBBfezYt
 7jlVAcxN9CMPKPSDzC++kFFFHHhyWmy+vGqbhKv4e2wNp+yL4ZZ1tGAxM4Bv0hy7DMHY
 6WwV6oXvIESy7kYIp6sh/E/WzL6RSMwiILSAfRqsrzb8o0YdNd4RIrZJw8fXhs1c+Ijv
 ie6Q==
X-Gm-Message-State: AFuF++kDfe98kSgN7SOWSh1CKPXtn60+z3XCC2gx5UsIDIbYFgWSu9mv
 F8uiSF7MdL2qfszZq1tmqq5OmRVLY650+WwDT3UY4Z0oHVJgRbDKq3Ms1/aJ2HEac4Y6p4HROPM
 t7hehW4juDa/9s/S76II8BkL8ZZC0W6Yq7sOraxoARU9iporGLvWxa1Ve
X-Gm-Gg: AYBFou2oCimMRnxy/a8HZblY4CgEXsEMVcotXQjqnyETg0inq4FdDsHcfGKfxcIIntf
 hNa7VBzp8SVlfGESRAIE+2DNzq2qLKW0jb09Nzzhkae54BKV+PzA6c08YzYTdbe1mgS0otW9Ere
 ItNfEWYQB3WQ0UdU3fkqRSZaqUap1RHlpW4S5FY4OjmVVOa88f2Dda1gIyJymocidPtDH/ErsY2
 a3ORmfQuAczWeYAY/HA0pSL1pPeiOP+cX5s2ba1wIvYcf+ex+bj0GnTF9JtrjbKqzOBA98LccPg
 /cIuLSDpRQBJllA5wcEhY1Aao5rs8Ya0uF9i/4DEMb8bmylHx8LzAAm+5oG+7hFCUuO7lXdIaXR
 0crJj+9fTpSNBhNt4JgUG9G0=
X-Received: by 2002:a5d:5d88:0:b0:485:8c17:9777 with SMTP id
 ffacd0b85a97d-4858c179a73mr6355397f8f.57.1788556267457; 
 Fri, 04 Sep 2026 14:11:07 -0700 (PDT)
X-Received: by 2002:a5d:5d88:0:b0:485:8c17:9777 with SMTP id
 ffacd0b85a97d-4858c179a73mr6355362f8f.57.1788556266951; 
 Fri, 04 Sep 2026 14:11:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b1320sm8801470f8f.27.2026.09.04.14.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 14:11:06 -0700 (PDT)
Date: Fri, 4 Sep 2026 17:11:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] hw/pci: add DVSEC RMEDA capability to PCIe root
 port
Message-ID: <20260904170742-mutt-send-email-mst@kernel.org>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
 <20260904-jmac-rme-da-prep-v2-3-fb461d78bbb2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-jmac-rme-da-prep-v2-3-fb461d78bbb2@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Sep 04, 2026 at 05:05:03PM +0100, Jim MacArthur wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> 
> After this we can see all the capabilities listed for the PCIe bridge:
> 
> 00:05.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port (prog-if 00 [Normal decode])
> 
> 	...
> 
> 	Capabilities: [54] Express (v2) Root Port (Slot+), IntMsgNum 0
> 
> 	...
> 
> 	Capabilities: [48] MSI-X: Enable+ Count=1 Masked-
> 		Vector table: BAR=0 offset=00000000
> 		PBA: BAR=0 offset=00000800
> 	Capabilities: [40] Subsystem: Red Hat, Inc. Device 0000
> 	Capabilities: [100 v2] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
> 			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> 			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
> 			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr+
> 			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
> 			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> 			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr+ HeaderOF+
> 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> 			MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
> 		HeaderLog: 00000000 00000000 00000000 00000000
> 		RootCmd: CERptEn+ NFERptEn+ FERptEn+
> 		RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
> 			 FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
> 		ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
> 	Capabilities: [148 v1] Access Control Services
> 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
> 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
> 	Capabilities: [150 v1] Designated Vendor-Specific: Vendor=13b5 ID=ff01 Rev=0 Len=16 <?>
> 	Capabilities: [164 v1] Integrity & Data Encryption
> 		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM- Alg='AES-GCM-256-96b' TCs=1 TeeLim-
> 		IDECtl: FTEn-
> 		[170]SelectiveIDE#0 Cap: RID#=0
> 		[174]SelectiveIDE#0 Ctl: En- NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0
> 		[178]SelectiveIDE#0 Sta: insecure RecvChkFail-
> 		[17c]SelectiveIDE#0 RID: Valid- Base=0 Limit=0 SegBase=0
> 	Kernel driver in use: pcieport
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 30 ++++++++++++++++++++++++++++++
>  include/hw/pci/pcie_regs.h         |  4 ++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 452ebf69b3..035212508d 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -104,6 +104,36 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>      }
>  
>      uint32_t offset = GEN_PCIE_ROOT_PORT_ACS_END;
> +    /*
> +     * dvsec rme-da
> +     * https://developer.arm.com/documentation/den0129/latest/
> +     * Arm RME System Architecture
> +     * 0x0000 RMEDA_ECH See B3.2.6.2.1 RME-DA Extended Capability Header
> +     * 0x0004 RMEDA_HEAD1 See B3.2.6.2.2 RME-DA DVSEC Header 1
> +     * 0x0008 RMEDA_HEAD2 See B3.2.6.2.3 RME-DA DVSEC Header 2
> +     * 0x000C RMEDA_CTL1 See B3.2.6.2.4 RME-DA Control register 1
> +     * 0x0010 RMEDA_CTL2 See B3.2.6.2.5 RME-DA Control register 2
> +     */
> +    pcie_add_capability(d, PCI_EXT_CAP_ID_DVSEC, PCI_RMEDA_VER, offset,
> +                        PCI_RMEDA_SIZEOF);

don't put declarations after code.

> +    const uint32_t header1 = 0x010013b5;
> +    const uint32_t header2 = 0xFF01;

what are these things?

> +    const uint32_t ctl1 = 0x1; /* support tdisp */
> +    const uint32_t ctl2 = 0x0; /* unlocked */


so why do we need these vars? just open-code.

> +    pci_set_long(d->config + offset + 0x4, header1);
> +    pci_set_long(d->config + offset + 0x8, header2);
> +    pci_set_long(d->config + offset + 0xC, ctl1);
> +    pci_set_long(d->config + offset + 0x10, ctl2);
> +    d->wmask[offset + 0xC] = 0xff;
> +    d->wmask[offset + 0xC + 1] = 0xff;
> +    d->wmask[offset + 0xC + 2] = 0xff;
> +    d->wmask[offset + 0xC + 3] = 0xff;
> +    d->wmask[offset + 0x10] = 0xff;
> +    d->wmask[offset + 0x10 + 1] = 0xff;
> +    d->wmask[offset + 0x10 + 2] = 0xff;
> +    d->wmask[offset + 0x10 + 3] = 0xff;
> +    offset += PCI_RMEDA_SIZEOF;
> +
>      pcie_ide_init(d, offset);
>      offset += PCI_IDE_SIZEOF;

You can't unconditionally change config space, this will break
cross version migration.
You must use a property (beginning with "x-") and compat machinery.


Besides, having all root ports on all arches have this capability
looks very strange. For example not everything supports tdisp.

> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index aa21177411..233378fd79 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -186,4 +186,8 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_IDE_VER                     0x1
>  #define PCI_IDE_SIZEOF                  12
>  
> +/* RME-DA */
> +#define PCI_RMEDA_VER                   0x1
> +#define PCI_RMEDA_SIZEOF                20
> +
>  #endif /* QEMU_PCIE_REGS_H */
> 
> -- 
> 2.43.0


