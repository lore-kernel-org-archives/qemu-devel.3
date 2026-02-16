Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ABFE81A40
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 16:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs1UQ-0004YN-P5; Mon, 16 Feb 2026 11:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vs1UM-0004X1-3P; Mon, 16 Feb 2026 11:30:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vs1UJ-0004l2-Ev; Mon, 16 Feb 2026 11:30:21 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fF7XX2nHqzHnGkN;
 Tue, 17 Feb 2026 00:29:48 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id D226B40539;
 Tue, 17 Feb 2026 00:30:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 16 Feb
 2026 16:30:11 +0000
Date: Mon, 16 Feb 2026 16:30:10 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v6 4/5] hw/arm/smmuv3: Introduce a helper function for
 event propagation
Message-ID: <20260216163010.00007797@huawei.com>
In-Reply-To: <20260213103942.142823-5-skolothumtho@nvidia.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <20260213103942.142823-5-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Feb 2026 10:39:41 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Factor out the code that propagates event records to the guest into a
> helper function. The accelerated SMMUv3 path can use this to propagate
> host events in a subsequent patch.
> 
> Since this helper may be called from outside the SMMUv3 core, take the
> mutex before accessing the Event Queue.

Totally trivial but it might be worth stating that / why it is harmless
(or indeed necessary?) to take the lock in existing paths. I was kind
of expecting to see locked helper wrapping an unlocked version that was
used to replace the original code.  So guess I'm missing something.

> 
> No functional change intended.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-internal.h |  4 ++++
>  hw/arm/smmuv3.c          | 21 +++++++++++++++------
>  hw/arm/trace-events      |  2 +-
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index a6464425ec..b666109ad9 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -352,7 +352,11 @@ typedef struct SMMUEventInfo {
>              (x)->word[6] = (uint32_t)(addr & 0xffffffff); \
>      } while (0)
>  
> +#define EVT_GET_TYPE(x)  extract32((x)->word[0], 0, 8)
> +#define EVT_GET_SID(x)   ((x)->word[1])
> +
>  void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
> +void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
>  int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
>  
>  static inline int oas2bits(int oas_field)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index f804d3af25..bcb9176c51 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -168,10 +168,23 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>      return MEMTX_OK;
>  }
>  
> +void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
> +{
> +    MemTxResult r;
> +
> +    trace_smmuv3_propagate_event(smmu_event_string(EVT_GET_TYPE(evt)),
> +                                 EVT_GET_SID(evt));
> +    qemu_mutex_lock(&s->mutex);

Could use 
    QEMU_LOCK_GUARD(&s->mutex);

though gain is minor so feel free to not do so.

> +    r = smmuv3_write_eventq(s, evt);
> +    if (r != MEMTX_OK) {
> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
> +    }
> +    qemu_mutex_unlock(&s->mutex);
> +}



