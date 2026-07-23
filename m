Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF668C531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmtBA-0004VS-0T; Thu, 23 Jul 2026 09:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wmtB6-0004Up-SN
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:09:34 -0400
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wmtB4-0005U6-Dq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:09:32 -0400
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-38dcd98e5easo317017a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784812169; x=1785416969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P53LU1z00TsQ0rdICiDq5utAVkvnHaR3/n8SoYgZC9s=;
 b=UdHL2pIpEcL4DlHrxMxYODXQHhlg4Z1rTRrxpS5Hpc5xBGC1x8H8dUR9TvnXLXaKEx
 A/l96z3tqjC298wfW6knNtQdhZyG2D+aumhoZvUDWQw0NrQLPEIuGnMdezo30k5nC/1J
 9grq2zQgPLrE4kugiQAQoa1jBiS6lOySsFMfdqz9g8egi1hgrTUjs48o/E5pCusBmjA6
 jpojAEKdH9E18qDVEMMZaBxvZu1p+4FMX9ISCKfY+k94vFchWar1/YDfoRZeCErq8rcd
 ppJJWv+X+61zzPLOL457lKFupW3erP/c9hb4UxHKtkir71AVEBfDX/Uw0Zqee/nRXk0N
 DHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784812169; x=1785416969;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P53LU1z00TsQ0rdICiDq5utAVkvnHaR3/n8SoYgZC9s=;
 b=naipjRuWRFPXTt9z+aa0UWDV71dcorN+o9RdOHZQRtRVNswERBOK62QeZ04J41v/7c
 nFFdn8l+geI1gwfMZkMSlMl6rHaZu6QIzYEoGWG+6gf06w39CbNGr/GmaATaxuu9PPwu
 Bs53SsCP/SEWwXchxo2+8yA7zteGosjatUBbHZZU7UbcBYQ+FsnmwpFxnZ/nSs9a9lto
 jqozibem6xLF6MGWMwvfgJVUcBVkQkCqzLEaSz4i6/65zy5xNmps5QvpiZo6/KW3ew+p
 d1+BP2H0a2TMYRwYJTBzGilXitit1hNWaUGpDT3h3IRPvGB5a3/QMYRHEoVsvI4h+wNP
 9LsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAqFbmu4D+9KGSNuECiZWtj2Zg72LvwhAmp8+raewJ+gDLtz0VOPEm47xF8657Ub3sfYRJscFJoztI@nongnu.org
X-Gm-Message-State: AOJu0YzPdJhTbOGIVWtjmygfxGO/iBaeX60by7ghnYqqgoW8ylO744xv
 RXWYkiiZHw9m0gHgWaVrPxSLjrIsnTFRxCgnSflZmocZHER85+f06Q8=
X-Gm-Gg: AR+sD13P+d94aRrIIHKiFTpcrRnOJ0vDnd1prVjXoiHJAZJFHyOuihRKRAdNSAn7sst
 GKf41Y/uPSPHZSeYYD3hw9mkhSfg3wSCXD5drcHlcrGUGyN7PRUhJG2xE02ppV/0l3dwoT21cQV
 CrByX7fxxSi3JLAm9q/6xSBeeZVWdfZG1qMTbEOmCCpIu90edk9ehUWPR0QrXjbtTtwQPWnCSbf
 WCPFzn3s3m/mw5RUYm//sxZAd25ltZSjAq9/sidkQPxbiyOKevktjOwyC8oeNjjDzX5hgUrMent
 5Ho/vhiopuBBhW2hzzsirHOm5KrsSZsvBdDqWv2tdSr6KJuZ9jMAKD3JKGMb/Uv96QwxHdkKBcy
 SndjdDfK7fHjp8KK2XQB2iQhjCF4R7PGSpCPy2R52fkBWaYaBEtYKTiEmNA8ERxJvUFp7limTLn
 Jb3zRLAZmUPBDufKJR/27Cg7Trn6jqQGvVd3/3mZIvqNCp4xzVexhTzAUCdg==
X-Received: by 2002:a05:6300:614e:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3c44afaac10mr3303939637.10.1784812168685; 
 Thu, 23 Jul 2026 06:09:28 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a?
 ([2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1ca3efsm24631825eec.30.2026.07.23.06.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 06:09:28 -0700 (PDT)
Message-ID: <5cb8d286-f013-4400-aef4-baddaa775995@gmail.com>
Date: Thu, 23 Jul 2026 21:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] xen/igd: get PCH info from host sysfs
To: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20260709183517.25866-1-brchuckz@aol.com>
 <20260709183517.25866-2-brchuckz@aol.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260709183517.25866-2-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::7;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x07.google.com
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

Sorry I am not the maintainer/reviewer of Xen IGD passthrough, just out
of my personal interest

On 2026-07-10 02:35, Chuck Zmudzinski wrote:
> The igd_combo_id_infos[] data is more than 10 years
> out of date with many Intel IGD devices missing from
> igd_combo_id_infos[]. This means that many devices
> that could be supported will not work with the
> current implementation.
> 
> For newer devices not listed in igd_combo_id_infos[],
> get infos from the host sysfs to enable support for the
> newer devices not listed in igd_combo_id_infos[].
> 
> Introduce the helper function xen_pt_get_host_pch_info
> to facilitate getting the necessary information from
> sysfs.
> 
> Also, use errp in xen_igd_passthrough_isa_bridge_create
> to set errors from xen_pt_get_host_pch_info.
> 
> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
> ---
> Changes in v2:
>   - call error_setg* after closing files instead of before closing
>     files
>   - in last line of commit message change "to propagate errors" to
>     "to set errors"
>   - add stable to Cc list
> 
> Changes in v3:
>   - whitespace fix at line 380 of xen_pt_graphics.c
>   - fix Cc address for qemu-stable
> 
>  hw/xen/xen_pt.c          |  2 +-
>  hw/xen/xen_pt_graphics.c | 82 ++++++++++++++++++++++++++++++++++++++--
>  include/hw/xen/xen_igd.h |  3 +-
>  3 files changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 0fe9c0a..474606e 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -867,7 +867,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
>          }
>  
>          /* Register ISA bridge for passthrough GFX. */
> -        xen_igd_passthrough_isa_bridge_create(s, &s->real_device);
> +        xen_igd_passthrough_isa_bridge_create(s, &s->real_device, errp);

The `errp` need to be handled here if any error occurs.

>      }
>  
>      /* Handle real device's MMIO/PIO BARs */
> diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
> index 7df9344..2ef941e 100644
> --- a/hw/xen/xen_pt_graphics.c
> +++ b/hw/xen/xen_pt_graphics.c
> @@ -376,8 +376,75 @@ static void pt_graphics_register_types(void)
>  }
>  type_init(pt_graphics_register_types)
>  
> +static void xen_pt_get_host_pch_info(PCIDevice *dev, uint16_t *pch_dev_id,
> +                                     uint8_t *pch_rev_id, Error **errp)
> +{
> +    FILE *fp1, *fp2;
> +    char *endptr;
> +    char device_id[7], rev[5];
> +    size_t len;
> +    const char *device = "/sys/bus/pci/devices/0000:00:1f.0/device";
> +    const char *revision = "/sys/bus/pci/devices/0000:00:1f.0/revision";
> +    unsigned long val;
> +
> +    fp1 = fopen(device, "r");
> +    if (fp1 == NULL) {
> +        error_setg_errno(errp, errno, "Cannot open %s", device);
> +        return;
> +    }
> +    fp2 = fopen(revision, "r");
> +    if (fp2 == NULL) {
> +        fclose(fp1);
> +        error_setg_errno(errp, errno, "Cannot open %s", revision);
> +        return;
> +    }
> +
> +    len = fread(device_id, 1, 7, fp1);
> +    if (!len) {
> +        fclose(fp1);
> +        fclose(fp2);
> +        error_setg(errp, "Cannot read %s", device);
> +        return;
> +    }
> +    len = fread(rev, 1, 5, fp2);
> +    if (!len) {
> +        fclose(fp1);
> +        fclose(fp2);
> +        error_setg(errp, "Cannot read %s", revision);
> +        return;
> +    }
> +    fclose(fp1);
> +    fclose(fp2);
> +
> +    val = strtoul(device_id, &endptr, 16);
> +    if (val > 0xffff) {
> +        error_setg(errp, "PCH device id is out of range: 0x%lx", val);
> +        return;
> +    }
> +    if ((endptr > device_id) && (errno != ERANGE) &&
> +        (errno != EINVAL)) {
> +        *pch_dev_id = (uint16_t)val;
> +    } else {
> +        error_setg_errno(errp, errno, "device id strtoul "
> +                                      "conversion failed");
> +        return;
> +    }
> +    val = strtoul(rev, &endptr, 16);
> +    if (val > 0xff) {
> +        error_setg(errp, "PCH revision is out of range: 0x%lx", val);
> +        return;
> +    }
> +    if ((endptr > rev) && (errno != ERANGE) && (errno != EINVAL)) {
> +        *pch_rev_id = (uint8_t)val;
> +    } else {
> +        error_setg_errno(errp, errno, "revision strtoul "
> +                                      "conversion failed");
> +    }
> +}
> +

It would be better to reuse existing xen_host_pci_device_get() to read host
LPC bridge ids instead of parsing it on our own here.

>  void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
> -                                           XenHostPCIDevice *dev)
> +                                           XenHostPCIDevice *dev,
> +                                           Error **errp)
>  {
>      PCIBus *bus = pci_get_bus(&s->dev);
>      struct PCIDevice *bridge_dev;
> @@ -394,7 +461,16 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
>          }
>      }
>  
> -    if (pch_dev_id == 0xffff) {
> +    /* Newer devices get PCH infos from host sysfs */
> +    if ((pch_dev_id == 0xffff) || !pch_rev_id) {
> +        xen_pt_get_host_pch_info(&s->dev, &pch_dev_id, &pch_rev_id, errp);
> +    }
> +
> +    XEN_PT_LOG(&s->dev, "PCH device id: 0x%x\n", pch_dev_id);
> +    XEN_PT_LOG(&s->dev, "PCH revision: 0x%x\n", pch_rev_id);
> +
> +    if ((pch_dev_id == 0xffff) || !pch_rev_id) {
> +        error_setg(errp, "failed to get PCH device id or revision");
>          return;
>      }
>  
> @@ -406,7 +482,7 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
>       * Note that vendor id is always PCI_VENDOR_ID_INTEL.
>       */
>      if (!bridge_dev) {
> -        fprintf(stderr, "set igd-passthrough-isa-bridge failed!\n");
> +        error_setg(errp, "set igd-passthrough-isa-bridge failed!");
>          return;
>      }
>      pci_config_set_device_id(bridge_dev->config, pch_dev_id);
> diff --git a/include/hw/xen/xen_igd.h b/include/hw/xen/xen_igd.h
> index 7ffca06..da51f09 100644
> --- a/include/hw/xen/xen_igd.h
> +++ b/include/hw/xen/xen_igd.h
> @@ -22,7 +22,8 @@ uint32_t igd_read_opregion(XenPCIPassthroughState *s);
>  void xen_igd_reserve_slot(PCIBus *pci_bus);
>  void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val);
>  void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
> -                                           XenHostPCIDevice *dev);
> +                                           XenHostPCIDevice *dev,
> +                                           Error **errp);
>  
>  static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
>  {


