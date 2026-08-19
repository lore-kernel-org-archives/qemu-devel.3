Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A60C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlmh-00083k-B3; Wed, 19 Aug 2026 15:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlmf-00083M-P6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlme-00037Y-AA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787167027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3joE9MERIl0rQf5B4NyuJ6OjcchvFje4XbrLZIaWtY=;
 b=gnUsRIj7LfPJbq7aQgLGibUC1SQ5ajJhroMj8r9oy05f7Hk9ucvcoyU0sUEUz5fj5ZJrQZ
 u4K3bBpo7mW/uXJHduFXa6tFo6LAFs4H+vhQJ36bVv5n9fJfHvQREhjjoSvbJ+UjLF4jU9
 5VF0sFiABfLiGPSWWM3vaVHOLIaPzAQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-WvFImLbHN-uoUvZu2Uf01w-1; Wed, 19 Aug 2026 15:17:00 -0400
X-MC-Unique: WvFImLbHN-uoUvZu2Uf01w-1
X-Mimecast-MFC-AGG-ID: WvFImLbHN-uoUvZu2Uf01w_1787167019
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e8004d60eso262014585a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787167019; x=1787771819; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v3joE9MERIl0rQf5B4NyuJ6OjcchvFje4XbrLZIaWtY=;
 b=pojjXiZNoEUyxn6KRvZDDxnBpvGHVgKcA4dZO6fjZ/3tWADQKvauRZoYJpb0TAwpMp
 b8M070dr0WtPP2IXigBh324mUmOOKhvF0yF/GSg7SdIKeQqDlb/TQQpfvHP2VZqsb5Pw
 QliuqP2JdMLLwgGmSO70UENeEF5PP2kcO4LMyRtDFzw+eiZxhNPBEVeJOel/k2QoAUM4
 sQCyHHwOrG4pvpEnrKjjtCWvMgvQ/99y66zwmO3EFEWgSOvTnQMu3SgDV704i3E3hLd8
 SfBmJaKsW4p85P+fjrqmXM9nnfqF2FBLZdUYio1yZe/+chP3wV1bxCLFTfQgqIKCxvAx
 dX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787167019; x=1787771819;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v3joE9MERIl0rQf5B4NyuJ6OjcchvFje4XbrLZIaWtY=;
 b=QLJ9546qihzA40/j4FOC+iBsu7cYjDtpQFSEg0dmLqdEUwKKBArDC9woX2LBsoe8Nr
 zjP4tWQBmgH7llkMdF0k+hNh3R98Sf/FsHEWdcCVd/yV3TKpnt9ta991Mc84VN/H01wc
 Y7bLROF8f+RKciwPtuigZIl9mSAFvKkQ+wkza3h0xrjeNB93T+ym5Z55n2aSGm0zOrMJ
 bcVzYFiTbaTdsh2IoabvEYEJ48ZkXWpMJ9x14fAC2kDYyYtDUwefNMYbvGgzzRDdNn8K
 /y/Ugh+ShTGtfHEu1e0vxqVvfaQF6xQbwv5UpRH//6l8uoegR3hUpDmKFwl9e2rXqajQ
 +ljg==
X-Gm-Message-State: AOJu0YxN2gUrE80PvN2y+wZ9VNBO0MtSghNw6F5otv6/ZvBBfW6VoxTr
 KoYL1dHuqrWuY6HoMiGgOfg+U9K+eIrvTGXP6g+/uTPdlwrv0E0+LxVaYUrTsV6XSRbIkBObL+k
 ay/VyfFYNAD0Wd+CQz97HLkHbRQr4gg3JSDbhGwTT0qsPFJmIYf+/eN/s
X-Gm-Gg: AR+sD10S50Hs+00Zd2Da7nJ4KSZ0oPtHaVF1aypFdnfZvtlnUb+aXmzpkXfm/tMa0+W
 8uGc+SmL55IuuET3wev4FdcZ7bW8BYWuJ7x2jSrZSUIVtjqlmVg+PwdBnz5Iv2/dp1XEKONBiJ8
 9BtmhecYxSDR7utNUwb+ksts3vU/WFRliHYjeHSfD/mBXsJqO/BN0iLmzUEaq0VnxmzSkQAouOW
 PQ5R35/oCrhhC+2axVGa6Vp7F7m24OlAHp11YnAkUZVXDKSRCIZn1agfADuQcyZV+4cA1TwFzmR
 CklhRXkBxZJhtdoROGFOLnTlVZq4Vw5EtLfbB3tdEtvFBf9XkvcyqaxHHnyyxdGk8N8B
X-Received: by 2002:a05:620a:2616:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-9371e31e4fcmr761460685a.1.1787167019247; 
 Wed, 19 Aug 2026 12:16:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2616:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-9371e31e4fcmr761451785a.1.1787167018456; 
 Wed, 19 Aug 2026 12:16:58 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9372405c33bsm124607085a.29.2026.08.19.12.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:16:57 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:16:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 2/3] migration/rdma: Post initial receive before accepting
Message-ID: <aoYBIaisgpP6lklk@x1.local>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-3-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817105117.3072040-3-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 17, 2026 at 06:51:16PM +0800, Yanfei Xu wrote:
> The source return-path thread can send READY before the destination has
> posted its initial receive.  Since RNR retries default to zero, the send
> can fail and abort migration.
> 
> Post the initial receive before rdma_accept() to close this window.
> 
> Fixes: 55cc1b5937a8 ("migration: create a dedicated connection for rdma return path")
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>

This one looks correct to me,

Reviewed-by: Peter Xu <peterx@redhat.com>

Do you have way to reproduce it, or is this theory (or can be reproduced by
adding delays)?

> ---
>  migration/rdma.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index e17ace62b0..6e8436ccc1 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3263,6 +3263,12 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>          }
>      }
>  
> +    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
> +    if (ret < 0) {
> +        error_report_err(err);
> +        goto err_rdma_dest_wait;
> +    }
> +
>      /* Accept the second connection request for return path */
>      if ((migrate_postcopy() || migrate_return_path())
>          && !rdma->is_return_path) {
> @@ -3295,12 +3301,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>      rdma_ack_cm_event(cm_event);
>      rdma->connected = true;
>  
> -    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
> -    if (ret < 0) {
> -        error_report_err(err);
> -        goto err_rdma_dest_wait;
> -    }
> -
>      qemu_rdma_dump_gid("dest_connect", rdma->cm_id);
>  
>      return 0;
> -- 
> 2.20.1
> 

-- 
Peter Xu


