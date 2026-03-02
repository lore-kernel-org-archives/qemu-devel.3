Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A0EB3624
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 19:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx8lt-0006Og-8w; Mon, 02 Mar 2026 14:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vx8lp-0006O1-99
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 14:17:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vx8ll-0008I1-5o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 14:17:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48371d2f661so6065e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772479047; x=1773083847; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kG4DoBl3q2S3uQk2+ozjEvZOu8XfICBczmD/KNgBYw4=;
 b=4gg8kFQzGdf/Ap3oz0dnA8rdzrMXz+I2HiDyhFWpnmz+pylKbrRjP2JPQGQC+zcK3O
 ykgRVQAgzxzDggznlaHa3ISW7taw7MliygXUZSDh1+RHBhQsBQBhT8K3pIgQ1AlJ6uED
 zgbkHztLv4MpVfmx8mbP9qT7QC995suokUZ1h3W9bwXiLa0nlmsN/g8D7+WBYr1MZDrr
 tf3/iW2bxs993gkhGT6jkuSwqseFHqkcwoEcV4XMHeIxrOzVVs+ioN6DKXzlJYyspNuq
 fv3I9CthMRHJPF5qGTGI0Kg7wjGQC3d0EkXJ1R5+Ws1AqhnW5L/jJ6h2XS1Wm5dSScDU
 ycvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772479047; x=1773083847;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kG4DoBl3q2S3uQk2+ozjEvZOu8XfICBczmD/KNgBYw4=;
 b=qObBdt7Bi1tPIyLdk2fqy56zMhssmdssloZ8UDm/dqYTkxg+I7bcdWhq7sbFPqMxMK
 uv4HISUeNTsNR7vqyZMvtEzWbrb0sRvKvLWFIoAvatBZ/7DFnYhLHoHp1FaqxVYyYTH+
 6eoQni3nOJYGzDOek9+k8usvc4KTVa+eBl2aPTRX3X4PTngpdUvadmicGYKBB196uIso
 oQg+SCNd6I27T4lP+mnzvg7mj72liPLVp6IYxWdG9egLiXoK8QEm3jqHBPfuqlYG6eS9
 huTMJuVsWpoCzK1WNMy2XV6NSA7aXv0bHyCm3K9hp3dUV5h5fuY1INZBwtVao9Blu5du
 1NhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXboe9q3cITErFY4mDIuF7Kxjki2vkvSB0AzmVbT5OIXEtibAT16mEih91VKiEqne9s4fbBZNH9hnPp@nongnu.org
X-Gm-Message-State: AOJu0Ywb6iln+7KGi1AbfT7tjv58V0wwBUaGxqXL3yLBgjmCLDX6U14D
 9lVJZqD+GhcAjndALRmxXEkSuj7/Ja8bxpfv79OPpw/X01k132o25DKV28iENqGv2CO/zKRs1Xb
 fSjlW2g==
X-Gm-Gg: ATEYQzxPYyXko/8vxT9QXjzpsmpkZlm7Iii0q0nTRoSCI6m/c5DVW+1TD/sBrqSavzx
 GdNWwjybmVNGMg1Hvr5ZKBfaXvXQ0O4em4co5ZdFgbd8wMpYiUdOnK2jEeVL2IIZEwFxMDfjYML
 Hw1xqhng/NmKB9suZfGNv+U705IEXQibX7pbrLj+nLzFURspWnCgfM3GJDnO4qc/jnG6f24/Kcj
 jiNKJKHzFRClxOFG/1sQ12GEq/bBX0XQjAY+khjBv9XCCz9V87tOa/qJf1gvHXYLAxScObh0m63
 2aE9fX69S6zuxJX2+iQgpNVoF0B3AtP5mf8Bgou5WWP23nvhJ6LVfaUMqdAzzx43ZDTon21eARQ
 khPozjzz11MtLfSK7O1IqjRWzr+7m6SO0PpsGNEYzkRgILol1py10TsKeFYMLUUmPZ2QdBMFlI5
 OKb1brdAz0EB7Jo8qoskOgmj86WwUePmT8LDreKDLs8z4kDXgzxNTv0Kc4zwb9NQv+
X-Received: by 2002:a05:600c:654c:b0:480:4a7b:228 with SMTP id
 5b1f17b1804b1-483d060c72cmr1900015e9.1.1772479046928; 
 Mon, 02 Mar 2026 11:17:26 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b6d540b2sm9763731f8f.36.2026.03.02.11.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 11:17:26 -0800 (PST)
Date: Mon, 2 Mar 2026 19:17:23 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Tao Tang <tangtao1634@phytium.com.cn>,
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
Message-ID: <aaXiQ84t1vxTH-EE@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101706.2994213-1-tangtao1634@phytium.com.cn>
 <aaGumxmrKRelouE7@google.com>
 <6a6144fe-3db3-4ce8-8a8c-c1391d7aa550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a6144fe-3db3-4ce8-8a8c-c1391d7aa550@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=smostafa@google.com; helo=mail-wm1-x333.google.com
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

On Mon, Mar 02, 2026 at 07:26:10PM +0100, Eric Auger wrote:
> 
> 
> On 2/27/26 3:47 PM, Mostafa Saleh wrote:
> > On Sat, Feb 21, 2026 at 06:17:06PM +0800, Tao Tang wrote:
> >> Extend IOMMU notifier functions to be SEC_SID-aware, ensuring that
> >> invalidation notifications are dispatched to the correct security-aware
> >> address space.
> >>
> >> This ensures IOMMU notifier events (e.g., to VFIO) are correctly routed
> >> to the appropriate security world's address space, maintaining isolation
> >> between secure and non-secure DMA operations.
> > I don’t think that VFIO cares about secure regime, my guess is to
> > keep the functions as this and don’t call them for secure invalidations.
> 
> So do we want to prevent VFIO devices from working in secure mode along
> with the SMMU?

Yes, my impression was that VFIO only works with NS devices, for example
I see vfio_iommu_map_notify() only deals with system memory:

    if (iotlb->target_as != &address_space_memory) {
        error_setg(&local_err,
                   "Wrong target AS \"%s\", only system memory is allowed",


Otherwise, the callback needs to be enlighted by different address
spaces, I am not sure how (and what uses cases?) will that be done, does
QEMU emulate TZ in that case? (and present some devices as secure?)

Thanks,
Mostafa

> 
> Eric
> >
> > Thanks,
> > Mostafa
> >
> >> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> >> ---
> >>  hw/arm/smmuv3.c | 18 +++++++++++-------
> >>  1 file changed, 11 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> >> index 4a4de719a7c..e33a7babd1c 100644
> >> --- a/hw/arm/smmuv3.c
> >> +++ b/hw/arm/smmuv3.c
> >> @@ -1195,15 +1195,16 @@ epilogue:
> >>   * @tg: translation granule (if communicated through range invalidation)
> >>   * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
> >>   * @stage: Which stage(1 or 2) is used
> >> + * @sec_sid: StreamID Security state
> >>   */
> >>  static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >>                                 IOMMUNotifier *n,
> >>                                 int asid, int vmid,
> >>                                 dma_addr_t iova, uint8_t tg,
> >> -                               uint64_t num_pages, int stage)
> >> +                               uint64_t num_pages, int stage,
> >> +                               SMMUSecSID sec_sid)
> >>  {
> >>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
> >> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> >>      SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
> >>                                 .inval_ste_allowed = true};
> >>      SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
> >> @@ -1251,7 +1252,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >>      }
> >>  
> >>      event.type = IOMMU_NOTIFIER_UNMAP;
> >> -    event.entry.target_as = &address_space_memory;
> >> +    event.entry.target_as = smmu_get_address_space(sdev->smmu, sec_sid);
> >> +    g_assert(event.entry.target_as);
> >>      event.entry.iova = iova;
> >>      event.entry.addr_mask = num_pages * (1 << granule) - 1;
> >>      event.entry.perm = IOMMU_NONE;
> >> @@ -1262,7 +1264,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
> >>  /* invalidate an asid/vmid/iova range tuple in all mr's */
> >>  static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
> >>                                        dma_addr_t iova, uint8_t tg,
> >> -                                      uint64_t num_pages, int stage)
> >> +                                      uint64_t num_pages, int stage,
> >> +                                      SMMUSecSID sec_sid)
> >>  {
> >>      SMMUDevice *sdev;
> >>  
> >> @@ -1274,7 +1277,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
> >>                                          iova, tg, num_pages, stage);
> >>  
> >>          IOMMU_NOTIFIER_FOREACH(n, mr) {
> >> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
> >> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
> >> +                               num_pages, stage, sec_sid);
> >>          }
> >>      }
> >>  }
> >> @@ -1307,7 +1311,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
> >>      if (!tg) {
> >>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
> >>                                   tg, 1, ttl, leaf, stage);
> >> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
> >> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, sec_sid);
> >>          if (stage == SMMU_STAGE_1) {
> >>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
> >>          } else {
> >> @@ -1331,7 +1335,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
> >>          trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
> >>                                   num_pages, ttl, leaf, stage);
> >>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
> >> -                                  num_pages, stage);
> >> +                                  num_pages, stage, sec_sid);
> >>          if (stage == SMMU_STAGE_1) {
> >>              smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
> >>                                  num_pages, ttl, sec_sid);
> >> -- 
> >> 2.34.1
> >>
> 

