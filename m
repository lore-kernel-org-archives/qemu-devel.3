Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FDC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhck-0006C5-HH; Wed, 19 Aug 2026 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwhcP-00064K-Vd
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwhcN-0007ZW-W0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787151012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LFoaQxqM9R1B9ARb/MoD0TEeUjL4HFJwz/pCOypZ4F8=;
 b=CY4v7UnrAqwynN7Rxj/RtMsevRMTayOaJh4Z9LXPqlIy6gBkBnOSnWN0GF5uD09W5GUjYH
 Ccxzx3Wd5Dp0sHVxZqhQe+alFzJRdXFbKPYyHRwsLRTAXTbRx0WsX1yHXgENSF3NKSda9B
 2ek0HsJKBKIGKu1PPXWom9Vbjn+dEbU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-s5gFIgJKNdC4I85CV3_IJA-1; Wed, 19 Aug 2026 10:50:09 -0400
X-MC-Unique: s5gFIgJKNdC4I85CV3_IJA-1
X-Mimecast-MFC-AGG-ID: s5gFIgJKNdC4I85CV3_IJA_1787151009
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49808ea1b64so11134445e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787151008; x=1787755808; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LFoaQxqM9R1B9ARb/MoD0TEeUjL4HFJwz/pCOypZ4F8=;
 b=RhvNQ/jG9kQBpHqtEFYm+veYlX6Y8Ua167ec2za/h4furWFjSNlNpIAECsuj16Mg1V
 /gkXTZm9c4g9hxgp42P1gOMA76AvAI2yMY4iRmXzO+f6t0t9UNTf37dvji5E4ANJJ3qC
 LRCqN29cQbAWcU6c8F74XlCtQsgp3A9FTJpzxP21+Zeq+j/8aNDe7ktryRUupwullvDE
 12UCsaaETrBD8jZWfHMM/zszdkD+pLqq9plrTR7SIR8ILeg3cKGkeX2bFZMhAdzfx0pV
 g5W1zlzHX/e492uGlYy3D3cnsVEW862521yU+MAy/EKRcPFhT7AXRUuV2Z+4m0FpeD8p
 6BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151008; x=1787755808;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LFoaQxqM9R1B9ARb/MoD0TEeUjL4HFJwz/pCOypZ4F8=;
 b=Rtp2b7EmLurP8CS88D0hyhtxesuw0pevKiCv9JwYjQJomIq4eVHPHmuiNIfFndyOz+
 acsZfL/uZk70ccq1StHrzpP9Z12dBxge652kuJZPBb3BCIy8NOx+Jm8QqJOAeEuFj+XF
 WPjA5cPHCHLX710L4lz37R7Azbm96fetwfgGyuA6h6a5fPPYT44RCb5CHf6cmUGbHjdd
 qB1qzgyFx1kr4dbE90gyzXiY1zu7L/yCQ6tivJHGqnNsdMzCeVWfJ/kK/rnAXJpJKJEx
 1dTypZT8M0BlUamwqNxNGYdwdmIlBuI9pj6aIezOmrPsOVw9Umzrvx5cZnpcaVT/VCYK
 sIGQ==
X-Gm-Message-State: AOJu0Yzm2pqZv/yUSj0g3pk2DUG/6rwBiKRxZN79Aoq2/+d9w8ChoMZY
 LaHL2YJAYeKgDxpegCyr7E6Gc1HG5QhLvf1d40oUgLi1tHIblfOI8CCRDUnizV4TlB3dcF4aty3
 VyYQIaNmDPjdzhIJiXPaH66jIWN/qAYilLf1kZMneniuJVeIKGVijBDjq
X-Gm-Gg: AR+sD10yFYWP3jyzNYBKVAc/9GXLNyVqZjLE4o0Vm4+xVtnQxsRbKUVNt9lietg2OQm
 SG+43lnu7UFLotJKlCNpjrXW+8+6bVcdbpVPDuMjjY1sKNmXLs+Vq1zLLkRPIH2yRyig2HUJu0f
 HXRMHfte1A8TODi8mmenCbMjpBvMEDC+pt87zyse+caRBTo36o9daD9bAF49JMINSBDoI5nWzJF
 N50ckwluSVU/CiEQyXhQk9xJx+D6LAOCKD3KtSnH5mhYxDaATA/oXd7hmRsst00eEMavHfJofwk
 HG7EjiZn7rmKTgoLamtyF3VhbZ8+mdID/nemeH2ZZdT4AglEC/wPw5pPSDSLVFIySIZE
X-Received: by 2002:a05:600c:3b2a:b0:499:90d0:4906 with SMTP id
 5b1f17b1804b1-499aa0f27b8mr76683015e9.5.1787151008718; 
 Wed, 19 Aug 2026 07:50:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:499:90d0:4906 with SMTP id
 5b1f17b1804b1-499aa0f27b8mr76682075e9.5.1787151008246; 
 Wed, 19 Aug 2026 07:50:08 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9dff4c1sm46404185e9.3.2026.08.19.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:50:07 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:49:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH 04/10] migration/rdma: Drop RDMALocalBlock.is_ram_block
Message-ID: <aoXCkpNA0w8i-Hmj@x1.local>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-5-peterx@redhat.com>
 <CAMGffE=uzpHKCo+s36jmW3GVU3ELnprB2nSNOTrsBN742r9VsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMGffE=uzpHKCo+s36jmW3GVU3ELnprB2nSNOTrsBN742r9VsQ@mail.gmail.com>
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

On Wed, Aug 19, 2026 at 02:43:47PM +0200, Jinpu Wang wrote:
> > @@ -585,8 +582,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
> >      bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
> >      block->remote_keys = g_new0(uint32_t, block->nb_chunks);
> >
> > -    block->is_ram_block = local->init ? false : true;
> this local->init is only used here, can be removed too.

Yes, will do.

-- 
Peter Xu


