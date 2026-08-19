Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959FAC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwloE-0000Z3-Uu; Wed, 19 Aug 2026 15:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwloD-0000Yp-7B
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlo6-0003MK-L9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787167117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sPcTbZ65WkG/dqMr1Ux8ILlrr7IYoWE94/qNhTfkuU=;
 b=STWVoPC5dJybCQeYqJxgk1lmr2YYluGCr87ZUD3PwKgpQCuhjE8y7w57GF2E/Q3SiPHAOO
 GgfouHv5eSN1t3gEsmrXAo4ops8E2njjxdrfmjsRBvk6Wj+OMM1HFsTAANSfG1D8UyDCA1
 fKVkaYNmBpOwBCwrcFB0HLVd6f3Y75A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-XWNCxDL8Pnq5fgRN8Z8RjQ-1; Wed, 19 Aug 2026 15:18:36 -0400
X-MC-Unique: XWNCxDL8Pnq5fgRN8Z8RjQ-1
X-Mimecast-MFC-AGG-ID: XWNCxDL8Pnq5fgRN8Z8RjQ_1787167116
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936e393061dso135547185a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787167116; x=1787771916; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5sPcTbZ65WkG/dqMr1Ux8ILlrr7IYoWE94/qNhTfkuU=;
 b=prmkHONo9iKIsts+zibZAupSPwsMigPLqkyTM25muXfFZ6+mAJcNVCe7en0fKhUA6M
 npSSHMIXVl+I99ujvXksAb2u2P/tVX3gByxiqGHEhjoHIwQYZtyY2Y4cpFVFPQZnC4cd
 LYJE6rvWx0jqoo+84Ve1wb6Sj7idX+zOOKrAaskKojl1eu38LLb6f4w2obTTIP8XCTkH
 Vcoon84VhI/R1JjoG9rZIdsw2KaOkN/8rX6rH4WIK0g+GjlvN1IZph7MH5IIO9FVAENW
 qkU8pMvF+jAp3RA3ebUgGtFoWQPAntzpzNCCQp5WvEvFwJQHcXg2NP5s1m6PXXJJ7Xki
 UDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167116; x=1787771916;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5sPcTbZ65WkG/dqMr1Ux8ILlrr7IYoWE94/qNhTfkuU=;
 b=TuAGdfqUB4c8Iv0xaH/oKulU8bR9CtPCsPVsapUurnEzxCxbIZOU6uTRwBH+qI/iJA
 DoW3Fyn6ac5QEmDJccNtUQ8T4g8f3ZTppw95vhujBmKOg3COPjImZSUwRKMtZFCwxjkY
 JRiQe5yqFdnLla7NQ/2VaUuOYxAOmTSaM3A/YNsmz3kByZUtwAePTl8U+LAHa1tb7kks
 YTpXKAF7cNJn5y540zfywd8pIkH4whSxnpxZBPwYFrKlta7qOkRluq7NLYIQOm69tryS
 GckD2jhPTh1lSnRUd6IKmG1Wy3dwY8Gre0TGmnaisDHn1/mA77f6EMJOPJjtBieqmWN2
 mDDQ==
X-Gm-Message-State: AOJu0YxCcX4KGmJPKAiyL7cEytjMBCmgLLaAiDGYGDR2sK5AAtiCYvPP
 RKprFGEQ80Nw/Ktg3SsXvuxAMt2Po/ZW1SQsxip767FrFGthGRr10r/PSqTnwUHet8aqk0GEqdf
 KQBjNfVSGo9RVbALXmAvDbD/19uqqhCXE8xtzhoBK0qHJoulPRP/mNKAk
X-Gm-Gg: AR+sD130YPsDP+LI+FFEYtAxssT/Dl9CL3WAOl8hJXlA/vCoA+TGO7KLj2SGkUfle8+
 +4hnzJM2JeVE4S8sVEBl04bOLgWy8zj69q2MGt3AZP+2ggkV56x0dLUwx+Yo178jsRZUHFCNxvk
 Zeex4LhY1Ma3j6RZ8Q/kdeGDBaTtL1Z1ReukhXq48nyS3Or/eoBHN2WGIep+2eUTnHZyjZv2zUZ
 sh6Jn/hKfaAfcZQaJiJmEMOqCdhmA9PUPReoBcbqFus0nfgdWu2XJaqyMAMRK0drxbbVJTL87VD
 F04Kob/V7rDdM9gzlRNICwkZBvrV79dFYRaeyRj/PGMiuQC5oZBQ02ob3jQp5tkLnMoz
X-Received: by 2002:a05:620a:600a:b0:930:b4f9:f327 with SMTP id
 af79cd13be357-9371e316b8bmr704995985a.33.1787167115588; 
 Wed, 19 Aug 2026 12:18:35 -0700 (PDT)
X-Received: by 2002:a05:620a:600a:b0:930:b4f9:f327 with SMTP id
 af79cd13be357-9371e316b8bmr704989585a.33.1787167114915; 
 Wed, 19 Aug 2026 12:18:34 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720493f1dsm200528885a.7.2026.08.19.12.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:18:33 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:18:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 3/3] migration/rdma: Retry control sends on full queue
Message-ID: <aoYBhxpSL5w5gQcX@x1.local>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-4-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817105117.3072040-4-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 17, 2026 at 06:51:17PM +0800, Yanfei Xu wrote:
> RAM writes and control messages share the send queue.  If
> outstanding writes fill it, RDMA writes drain a completion and retry,
> but control sends fail the migration.
> 
> Drain one outstanding write and retry the control send on ENOMEM.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>  migration/rdma.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 6e8436ccc1..d1f44a5f55 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -1572,9 +1572,19 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
>          memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
>      }
>  
> -
> +retry:
>      ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
>  
> +    if (ret == ENOMEM && rdma->nb_sent) {
> +        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
> +        if (ret < 0) {
> +            error_setg(errp, "rdma migration: failed to make room for "
> +                       "control send");
> +            return -1;
> +        }
> +        goto retry;
> +    }

Looks also correct, but two questions:

- Should we provide a helper instead of duplicating the WRITE op handling?
  I believe only WRITE wrids can be on the fly.

- Could ENOMEM be returned when nb_sent==0?  If that check applies to WRITE
  path too?

Thanks,

> +
>      if (ret > 0) {
>          error_setg(errp, "Failed to use post IB SEND for control");
>          return -1;
> -- 
> 2.20.1
> 

-- 
Peter Xu


