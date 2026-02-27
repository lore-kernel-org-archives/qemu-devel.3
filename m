Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24503FEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvz8Z-0007Ug-AI; Fri, 27 Feb 2026 09:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz8Q-0007PZ-Lx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:48:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz8M-0000RS-0M
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:48:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48371d2f661so55835e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772203680; x=1772808480; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kq2sTxoBAMy/N4S6C9stR5oWuXQX8kO/FBbO6KZLDw0=;
 b=3WHJdK6T3XNNlkN2RtLsojea4MZbjjrU4m9H0w+a5a+mAdFT8syqKC3a8dX7CaO3ky
 CA6uQwx7aPW534bhkB9NfgQgFw6hmdcsBi2xfZma3uL0WE2rxnRDFCpc53Hhr6ILB/NJ
 t/HBHkcYCGe0pwpuy3t92/mXiQ+Blumt+sWuO6/Ph4WTH7s8ygH6emwO6qohU0dCIS2c
 CkfB26kZiR4x3v7N6bUUGaxIqcIChVZ1Buo12sChezJNx476Gv6yz1Ydia/1TXoh7vXp
 T0oBV3V5op6vEb+3coy4Q+Q4bOh6tZs2L0+0gZ0JPtCTB2N/PTKO6mqr8bIhTXGBwlSV
 oZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772203680; x=1772808480;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kq2sTxoBAMy/N4S6C9stR5oWuXQX8kO/FBbO6KZLDw0=;
 b=Mk+V2Od3RAD3bGdtoiTYxoCHOQMoDa+fGdSIYG4tpQofJAPff5xCSVT8IoUqeoFmmu
 Zndo2CAWL0nWBbo4uruVcCpmkEEN4eBxnChUjhqftcr/mPqCPi7WiPClEdJdkAKSA5Se
 NX5bC3oCmDtVMPnFk5+B39gZ62ZwW+iH8WAg0KZO/YdF9tp2V0g9lGBeToMY60xGlAZl
 +ISXxd692oP9lHDy9O6BkR+hk6gHrbaA/xewKjYZu5n/WQY4IA7kp6fRDkTpaHg69NMK
 4+NOXprlAjDHNblyJ7rw7WY47325Bdclieyy6bjOY3MAJZp5qmCtxCu3ePNCqGOPSvQy
 wuug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv23kHt+H+290BiNIV/y8s+ZYJUzpf9v+gz0ifhcJaHAjFUswd++4jwNPy9eMwsn0OJrjqo8bbnSfR@nongnu.org
X-Gm-Message-State: AOJu0Yzu+yLShKwTw39QJq5f5BGFKVbcnozKDTiDNDngIOsEgIDAtEFD
 4E2i5/NY+Ge0kSt1E7FItOSTQY1eaC/yVywwgNEiJLtzeD6oF5IoTa8pmcAtVsjqhA==
X-Gm-Gg: ATEYQzx4AMLh749s6WQKs9mRjiNW0GZ2YUTDMrT8TDHN9xgw6ptLotR737yK2ehm2y/
 dxWkjIIZ3w4LXIDUv/zraYPlNubjCxKifC0rnQCyr+0OhlcjN4rJU86vz1jkWYvuFnWhrJ6T4S2
 qK6qec5h1kvX21KzW/TSqxgoaZCAG6WKBH4SXHFPAAdKFK2umsiERDdNIF0dwpjgdJNcIwjp5QH
 9N12G3ayfJtvOcsOqZZ3/jhEoWGdnMDoXhzRdrp3jjkvvQ/OjnZxaGhPWKfraf8hNUWTMoNti+y
 atctLv51glZ8q1vdGh+z5Qf2m6ZjB+Se5kO2+1UADM/+PEcI1T+Irrm/DR5J4MLBOrqeYQF8Obm
 gXJxbKoCPEZRXs3XesKdkwVvZ6PSMwK4/4kBjxZ4CGOiJZsjsEHzXkN1/mcNdZeSE/4COxDcTvv
 CKPPXFL6WaYPZVQqE8hIU113GRJ8vhPYPmPgHF4NvOyFdnvOFLcRyDzIVunxO85kbT
X-Received: by 2002:a05:600c:6d8d:b0:47e:de3a:a929 with SMTP id
 5b1f17b1804b1-483c3188a3cmr1854505e9.12.1772203679471; 
 Fri, 27 Feb 2026 06:47:59 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c35910f1sm99790985e9.2.2026.02.27.06.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:47:58 -0800 (PST)
Date: Fri, 27 Feb 2026 14:47:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 16/31] hw/arm/smmuv3: Plumb SEC_SID through IOMMU
 notifier path
Message-ID: <aaGumxmrKRelouE7@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101706.2994213-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221101706.2994213-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Sat, Feb 21, 2026 at 06:17:06PM +0800, Tao Tang wrote:
> Extend IOMMU notifier functions to be SEC_SID-aware, ensuring that
> invalidation notifications are dispatched to the correct security-aware
> address space.
> 
> This ensures IOMMU notifier events (e.g., to VFIO) are correctly routed
> to the appropriate security world's address space, maintaining isolation
> between secure and non-secure DMA operations.

I don’t think that VFIO cares about secure regime, my guess is to
keep the functions as this and don’t call them for secure invalidations.

Thanks,
Mostafa

> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 4a4de719a7c..e33a7babd1c 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1195,15 +1195,16 @@ epilogue:
>   * @tg: translation granule (if communicated through range invalidation)
>   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
>   * @stage: Which stage(1 or 2) is used
> + * @sec_sid: StreamID Security state
>   */
>  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>                                 IOMMUNotifier *n,
>                                 int asid, int vmid,
>                                 dma_addr_t iova, uint8_t tg,
> -                               uint64_t num_pages, int stage)
> +                               uint64_t num_pages, int stage,
> +                               SMMUSecSID sec_sid)
>  {
>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>                                 .inval_ste_allowed = true};
>      SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
> @@ -1251,7 +1252,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>      }
>  
>      event.type = IOMMU_NOTIFIER_UNMAP;
> -    event.entry.target_as = &address_space_memory;
> +    event.entry.target_as = smmu_get_address_space(sdev->smmu, sec_sid);
> +    g_assert(event.entry.target_as);
>      event.entry.iova = iova;
>      event.entry.addr_mask = num_pages * (1 << granule) - 1;
>      event.entry.perm = IOMMU_NONE;
> @@ -1262,7 +1264,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>  /* invalidate an asid/vmid/iova range tuple in all mr's */
>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                        dma_addr_t iova, uint8_t tg,
> -                                      uint64_t num_pages, int stage)
> +                                      uint64_t num_pages, int stage,
> +                                      SMMUSecSID sec_sid)
>  {
>      SMMUDevice *sdev;
>  
> @@ -1274,7 +1277,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>                                          iova, tg, num_pages, stage);
>  
>          IOMMU_NOTIFIER_FOREACH(n, mr) {
> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
> +                               num_pages, stage, sec_sid);
>          }
>      }
>  }
> @@ -1307,7 +1311,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>      if (!tg) {
>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
>                                   tg, 1, ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, sec_sid);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
>          } else {
> @@ -1331,7 +1335,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
>                                   num_pages, ttl, leaf, stage);
>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
> -                                  num_pages, stage);
> +                                  num_pages, stage, sec_sid);
>          if (stage == SMMU_STAGE_1) {
>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
>                                  num_pages, ttl, sec_sid);
> -- 
> 2.34.1
> 

