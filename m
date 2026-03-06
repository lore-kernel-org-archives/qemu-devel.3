Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9119CFCB61F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqP-0004Np-Lw; Fri, 06 Mar 2026 11:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXqO-0004N5-Kr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:04 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXqM-0007F0-Az
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:04 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50335b926c2so85293561cf.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772813761; x=1773418561; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ifcWNObdkvyIUOlGXNI8pLJlr+AZ9dTANveDRIZ1kSs=;
 b=OSLqkYW6G4FOCrSE57S2DMs6ZH2pXC4CkX/jOdNwmae9mlitddUnW6MkNtbRkWroAu
 JvrnNjaWvOCx5ycU4y0hwzjSrNaZbkieVIdnDsL9x45kyBkUkxFM8SB5o7tEdxg+SS6r
 Wby0gvfhEFNvrdAXsPTd5+l93Ic+6C0NA2d70v6BGZSHsNo2RdDCyJjgJVaLhU5VVyHN
 d+P8WJ/m1wic+WSwrl+H4e98mCUiuiIn+I8WKGylU5+rvasqkVnFNCjtgeysU6JFicy1
 277WpPFB49zUocAs8AoJ/6q+qvSq4miAzcAASbXWbHw4lgTDxYghRdtiDF9fsz8tJfzr
 iUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813761; x=1773418561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifcWNObdkvyIUOlGXNI8pLJlr+AZ9dTANveDRIZ1kSs=;
 b=oUeNSScgMnq9kKsUA0WpVWeIL1r2/ET3+505CqZ61dHiYEO6lkDQ7QOu+1CA+41aXM
 gd0c9T1JImEhBl3B4QEibwlZQKG7nmvea/c98w4iUP6LdvbbEojhcHb9Bo3udQGPlQMC
 GjHgfhLvFZduinWDeCs1ojIeKTPDN0GtteidGJoeEaWb7SGZS5vmU6P+rn5LlluSFW73
 c3kSDAqTEURUZ6EHG6OvkMqNJvAsk4UCzNP0P9ITbF1qZoT8zMta8mZQzRMX+/w634bK
 zKeec7tkLmAEdwZtkMgFfgvBNhwj+AkxP6t39hJ0D+aHhmCYsM5jEztpVCpDDKrMJEu1
 fqpA==
X-Gm-Message-State: AOJu0YzPvT9NWnWFE9k6eb0GN1lRkPJ01hpsVJZp1olA7PLqU68paGgJ
 YOz1kBtFzrcGuE1gKuo8KnEPcpxl2Af46Z1ttx/1Z1/sA2g4+uJPuS9j7p4Anv3Yg74=
X-Gm-Gg: ATEYQzxdCfof0AA4lRTJIiEQzc1BrQ/QAfrkYrLU+NAeijJB993ZP8/KawygP5NAwpG
 Oystig4ywBXlCGpuCg+dtZn5PbTV5vL33MJ2+JztFBA8EgBvrrMIkqFGEFmdLvtG9W/AxYCpEeR
 a4liJyv4P0UvJeI8vsDoTUbunSxkodk1cOUZHy73/MJi2T09bD6ipQU52f2YfnzAD/L2mrTjl8h
 VwXZaYsTPyaOZ4DAqXjzxHZKZIUAPO7kQwhk6iHVYfWMIhFn7jVRba/c815j6lqqdZuzPDFiyq9
 nfTThzkxspyJttCZVVnrn6fbcr31/GH7btCOpsQ6T0VNcgFyfboC0VW45CzreRFs1x6EqWA5bF9
 oeXigAuuMJWahjUUCnlOosW58HfC27gNynCLwk4WkdqsNNw8CV80Tfpf6naav2QPyT+3pKuEtdX
 BXQRzuMoFv2HSQYop6EAD1oZl4bQnQh5uTsg65ppffxapyhEW+88CcL67LqE5rS0HGKVy+Upd1N
 HjJyFHVWg==
X-Received: by 2002:ac8:5dcd:0:b0:501:453e:bb34 with SMTP id
 d75a77b69052e-508f496e9acmr33052911cf.63.1772813757371; 
 Fri, 06 Mar 2026 08:15:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-508f6697230sm13793391cf.20.2026.03.06.08.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:15:56 -0800 (PST)
Date: Fri, 6 Mar 2026 11:15:55 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, anisa.su887@gmail.com,
 armbru@redhat.com, david@kernel.org, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, mst@redhat.com,
 nifan.cxl@gmail.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com, venkataravis@micron.com, xiaoguangrong.eric@gmail.com
Subject: Re: [PATCH v7 2/3] hw/cxl: Allow cxl_cfmws_find_device() to filter
 on whether interleaved paths are accepted
Message-ID: <aar9u0VJ20bUaHfz@gourry-fedora-PF4VCD3F>
References: <20260306121151.883-1-alireza.sanaee@huawei.com>
 <20260306121151.883-3-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306121151.883-3-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Mar 06, 2026 at 12:11:50PM +0000, Alireza Sanaee wrote:
> Extend cxl_cfmws_find_device() with a parameter that filters on whether the
> address lies in an interleaved range. For now all callers accept
> interleave configurations so no functional changes.
> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>

> ---
> Thanks to Li for the tag.
> 
> Change log:
> v6->v7: No change!
>  hw/cxl/cxl-host.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index a94b893e99..2dc9f77007 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -104,7 +104,7 @@ void cxl_fmws_link_targets(Error **errp)
>  }
>  
>  static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
> -                                uint8_t *target)
> +                                uint8_t *target, bool *interleaved)
>  {
>      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
>      unsigned int hdm_count;
> @@ -138,6 +138,11 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
>          found = true;
>          ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
>          iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +
> +        if (interleaved) {
> +            *interleaved = iw_enc != 0;
> +        }
> +
>          target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
>  
>          if (target_idx < 4) {
> @@ -157,7 +162,8 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
>      return found;
>  }
>  
> -static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
> +static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
> +                                        bool allow_interleave)
>  {
>      CXLComponentState *hb_cstate, *usp_cstate;
>      PCIHostState *hb;
> @@ -165,9 +171,13 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>      int rb_index;
>      uint32_t *cache_mem;
>      uint8_t target;
> -    bool target_found;
> +    bool target_found, interleaved;
>      PCIDevice *rp, *d;
>  
> +    if ((fw->num_targets > 1) && !allow_interleave) {
> +        return NULL;
> +    }
> +
>      rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
>      hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
>      if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
> @@ -187,11 +197,16 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>  
>          cache_mem = hb_cstate->crb.cache_mem_registers;
>  
> -        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
> +        target_found = cxl_hdm_find_target(cache_mem, addr, &target,
> +                                           &interleaved);
>          if (!target_found) {
>              return NULL;
>          }
>  
> +        if (interleaved && !allow_interleave) {
> +            return NULL;
> +        }
> +
>          rp = pcie_find_port_by_pn(hb->bus, target);
>          if (!rp) {
>              return NULL;
> @@ -223,11 +238,15 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>  
>      cache_mem = usp_cstate->crb.cache_mem_registers;
>  
> -    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
> +    target_found = cxl_hdm_find_target(cache_mem, addr, &target, &interleaved);
>      if (!target_found) {
>          return NULL;
>      }
>  
> +    if (interleaved && !allow_interleave) {
> +        return NULL;
> +    }
> +
>      d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
>      if (!d) {
>          return NULL;
> @@ -251,7 +270,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
>      CXLFixedWindow *fw = opaque;
>      PCIDevice *d;
>  
> -    d = cxl_cfmws_find_device(fw, addr + fw->base);
> +    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
>      if (d == NULL) {
>          *data = 0;
>          /* Reads to invalid address return poison */
> @@ -268,7 +287,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
>      CXLFixedWindow *fw = opaque;
>      PCIDevice *d;
>  
> -    d = cxl_cfmws_find_device(fw, addr + fw->base);
> +    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
>      if (d == NULL) {
>          /* Writes to invalid address are silent */
>          return MEMTX_OK;
> -- 
> 2.43.0
> 

