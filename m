Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA1BC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 06:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2jdA-0005ZA-TC; Sat, 05 Sep 2026 02:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1x2jd9-0005Yo-5S
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 02:11:59 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1x2jd7-000403-ET
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 02:11:58 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso2016190a91.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788588716; x=1789193516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+1/d3kD0E/jOB18xNpBAi6YRLu7VMIYAiNTe9XZa+lg=;
 b=Huf5qgFqtJDGhFRaaWwHcfmluqeTyH6H7SETVFUA+OWsVw7L0SIoqYJtnfI5EdtdfX
 VmtVDYQwVv2vy9/vlJzy6XvJTgSoSw7e9chsjznYVk+7vYP7DAv3ew9V0pUZ1XV0sGJf
 PqzvSPYOpUxKOnj0X7ypGl9nrEHZW3WbUltENxy7jI1NkJ69Cg6SWhfAjFdNljg3R8o3
 57LxZ6fbA2EbSMdrbAG6ZpNATssadKp52RHo/IXZLvoD7Iu9Pn/LdgpN17D7Fg1iUnNw
 daPCWBRM998dh6g+k9OGb7JXowHOdFE6lTHpqy2Mif1SRhLnHh8QgwvlNp6HK+o2QzcC
 4TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788588716; x=1789193516;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+1/d3kD0E/jOB18xNpBAi6YRLu7VMIYAiNTe9XZa+lg=;
 b=nc9OnUnBl8SyLp5MNdWcRTFkPBbxBXtY+5+J+mxBo2g+FdJWzc50kMtLDNukijS40V
 wv2IGYxlLtzssbbNC3V9w0Dl6wapt/4Fwkup5mS8Tit1bQdxue/3vEt8KS44QFHP1hSI
 99VOy12IQ1ilUzd+BkSjXiMSOZ9XJakytNNdtLM3+3PtHZBEyUB0Pfakaoa1ZczJY3Bk
 8jagDuwJFGTVkpkzK5yMcoqaGEw9xps0bCpBudtlZ94CePx0X3W9IQDWgO9jx/BApAp5
 pi1A769oi2zeSPjUWsfG676W6URxXmlxquSRsDks+GzJrA/VToff/NXxBQ76udyDdCX8
 RlRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybC08mJw7wD0a1zQtUIemBM8Gybe10pVTI5WoUTO2FvATZIA1neRYA6iotVMZ0jSnq5YTnn+G/dv+Q@nongnu.org
X-Gm-Message-State: AFuF++kEPlvFuD6oZ6uLwhsvpOzXL1qYVG9fKICwoJtS8r+wmc5HCLhF
 8g1uUqGl6QuB7Vr817K5jXFnoer7RqvPpkNk7Sw8dmk0CQtXPLMNuK7i
X-Gm-Gg: AYBFou1hmE/r7MAKgInPX9eC9/z0ClBLsMOds7ZB4Hwg7g7LZF3KCrsAqFoQ7EPXN1Z
 Xz8fhspFKoWjE6laVhrdt6qWXtWgUFWcB8Rof+R/o2bgm2SK7+7mY4qAeXYfPgSs0JMdO1Xg0+v
 TY5s/VJmjQoJ8XQvSjNqbbDL4JAxDpr6DOHH2byTccjTh8sHy5vw7GYPmxAk/GFwFGuUo0hJ4u1
 fvm6nNFbfAPHbat8+yli+tLBQ9T1McIkhh85LbS1ekZB9wCSs6qIesSramgResPE7YJz7h4qkPT
 PLXHZzFuP7ux9SG7ATlnwcBq4+i9Z+VSklhv0hLpCpSK3xd7sNt0/lqfwvpkQ+GyFLc9c0LpYVY
 2ZNxzR3M42+7+N0FIxdb5HKgnWRK06h5L6GmqsqkVNlAhEfguilzNhoTWq9MwokB61VwGQlseR8
 6kE6ZYhQnIjaEFWkwF/Mg5bXVnz9KC+z2gx2eVoNHP9gDNF1lOK+3dfQIASybxmEMM3aKusnls5
 acLm80=
X-Received: by 2002:a17:90b:4ad1:b0:396:635a:9b10 with SMTP id
 98e67ed59e1d1-39b2616ef8amr14297944a91.11.1788588715542; 
 Fri, 04 Sep 2026 23:11:55 -0700 (PDT)
Received: from [10.254.177.78] ([139.177.225.238])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143243767e1sm9731652c88.6.2026.09.04.23.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 23:11:55 -0700 (PDT)
Message-ID: <b3eb97b7-f6a8-4cd6-9ae7-de98fe854f5a@gmail.com>
Date: Sat, 5 Sep 2026 14:11:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration/rdma: send small control messages inline
To: Jack Wang <jinpu.wang@ionos.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, yanfei.xu@bytedance.com,
 Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20260901160333.29859-1-jinpu.wang@ionos.com>
 <20260901160333.29859-2-jinpu.wang@ionos.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <20260901160333.29859-2-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pj1-x102e.google.com
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


On 2026/9/1 23:51, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> Control-channel sends (registration requests, ram block replies, etc.)
> are tiny, but the HCA still does a separate memory read to fetch them
> before sending. Ask the QP for a little inline send space at creation
> time, and use it whenever a message is small enough to fit, so the
> HCA can just copy the bytes straight out of the work request instead.
>
> Falls back to the old path if the provider grants less inline room
> than we asked for, or none at all. No wire protocol change.
>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>   migration/rdma.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index e976739fad3c..08f3b901be4a 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -66,6 +66,14 @@ static inline uint64_t rdma_merge_max(void)
>   #define RDMA_CONTROL_MAX_BUFFER (512 * 1024)
>   #define RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE 4096
>   
> +/*
> + * Requested max_inline_data for the QP: enough for a control header
> + * plus the largest fixed-size control payload, so small control
> + * messages can be sent inline instead of via a separate HCA-side
> + * memory read.
> + */
> +#define RDMA_CONTROL_MAX_INLINE_DATA 512
> +
>   #define RDMA_CONTROL_VERSION_CURRENT 1
>   /*
>    * Capabilities for negotiation.
> @@ -329,6 +337,7 @@ typedef struct RDMAContext {
>       struct ibv_context          *verbs;
>       struct rdma_event_channel   *channel;
>       struct ibv_qp *qp;                      /* queue pair */
> +    uint32_t max_inline_data;               /* max size for inline sends */
>       struct ibv_comp_channel *recv_comp_channel;  /* recv completion channel */
>       struct ibv_comp_channel *send_comp_channel;  /* send completion channel */
>       struct ibv_pd *pd;                      /* protection domain */
> @@ -936,6 +945,14 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
>       attr.cap.max_recv_wr = 3;
>       attr.cap.max_send_sge = 1;
>       attr.cap.max_recv_sge = 1;
> +    /*
> +     * Ask for enough inline data to cover a control header plus the
> +     * largest fixed-size control payload (RDMARegister/RDMACompress),
> +     * so those sends can skip a local memory read on the HCA.  The
> +     * provider may grant less (or none); qemu_rdma_post_send_control()

Seems it's actually opposite? From my understanding, QP allocation will 
failed if
the required size is greater than provider's max inline cap.

Then just sharing some my findings after learning about the inline 
feature: I
found that requesting 512 bytes of inline data isn't free. Providers 
generally
size the SQ for the worst-case WQE, so allowing a 512-byte inline 
payload may
significantly increase both the maximum WQE size and the total SQ memory
footprint.

Regards,
Yanfei

> +     * checks the actual granted size before using IBV_SEND_INLINE.
> +     */
> +    attr.cap.max_inline_data = RDMA_CONTROL_MAX_INLINE_DATA;
>       attr.send_cq = rdma->send_cq;
>       attr.recv_cq = rdma->recv_cq;
>       attr.qp_type = IBV_QPT_RC;
> @@ -945,6 +962,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
>       }
>   
>       rdma->qp = rdma->cm_id->qp;
> +    rdma->max_inline_data = attr.cap.max_inline_data;
>       return 0;
>   }
>   
> @@ -1447,6 +1465,10 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
>                                      .num_sge = 1,
>                                   };
>   
> +    if (sge.length <= rdma->max_inline_data) {
> +        send_wr.send_flags |= IBV_SEND_INLINE;
> +    }
> +
>       trace_rdma_post_send_control(control_desc(head->type));
>   
>       /*

