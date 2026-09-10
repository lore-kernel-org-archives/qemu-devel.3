Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D01CC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lcX-0007gj-FY; Thu, 10 Sep 2026 16:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4l0b-0006JT-Kr
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4l0P-0004Sx-KD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789070600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/9QGs76Zr22lDoxGVCyVcF2VMfnm6aN2RLaHW4UT2aI=;
 b=Sj03eKD0eXHSlyCJbvFxUv53by1QYRqmt6h5hpgIdqOhBAWiQTEAqTHltfbZ3e1LQrXLDm
 tidQwIHJla/+pCtGGaTtBJoZcv0pdcHgUNwXMDGTJ1IsO6Sz03l5OwYlEI2foRKhaoD3ug
 zPKx/PfKe8IhEX9sBKbBQS9tnCHqYRo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-VMnVvGi7O9WBgZkRZY6kXA-1; Thu, 10 Sep 2026 16:03:19 -0400
X-MC-Unique: VMnVvGi7O9WBgZkRZY6kXA-1
X-Mimecast-MFC-AGG-ID: VMnVvGi7O9WBgZkRZY6kXA_1789070598
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-879b1d03d5fso1471447b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789070598; x=1789675398; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/9QGs76Zr22lDoxGVCyVcF2VMfnm6aN2RLaHW4UT2aI=;
 b=ZbDXuW2yCFg7fueTL8nPaUlCiB/k4dseW2gQ/HW+LZwrrnpZxcX5zVPnpXkpZqzk6+
 0z+ba9gAtcg1L5ZWvOI7z6yAflHzu6e1mwxM1WaKo4An2oBBRBWt7EOp9kaOEM1cln/c
 sEO6YwnCS/WeVufLLt0imJgVGd+SnJ47Vr2OWgEkDZy+cZ7TJPL+DssjydeeD/HxD03o
 x5HSvOlVQ54Bxd1772HB8cyxM5DHDOKlLKeaGsBvS46efFlWbLSKWimnxGs9G4eaQZ4v
 qERsB20kIR35KUSUb1MPZVt2LGR7OQj1wd3MbOtrNL+/1kY07B4jMmvY6OQcglxxYPu+
 5jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070598; x=1789675398;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/9QGs76Zr22lDoxGVCyVcF2VMfnm6aN2RLaHW4UT2aI=;
 b=M32jcufzyy1VNqBPm/9BFrXK666p1wc9bnCt3pVF8YiIg2Nmi9yHEn17AWjYtLtz6D
 9rf575ZgvULpN/yppuJYzMqViAOXBBotJjF1Pa8uvBmvAYvPHtxgH06gItmcI/rmOhxc
 d8S5nqNLVobHvBpVH4cR46h11kAxdOX1o3cQRrx8KhSDQ4cl9xCuM4baM+RsklFA54Di
 n+t1l6+MJ8jszIMAwPAB5Q5gkr6Wnv8kAERhEB77Mv5iN2LhQNNxTxMX9ld/DfekLdA3
 zsdT+2xozI7vgiRTcN0FIiH7MA9xmLNIBcli13Q38HZHA0a3qyaaQXFkzV9ey3bOX6bM
 O1TQ==
X-Gm-Message-State: AFuF++lJamnblobaR5ZqNtjNTUUGbAfU0dxbaxvWxHA6XbbYqz96cQ6J
 mi9mVC4j8HZSEjFZXxn3oJd5Kk8BBIw/aNz4hqsSyr+WiBXCdOSQbWzWy7dpfQe36qU3/yap9RJ
 pgmVmpLh4p1YWW7bZ+94HMHoi9AqXyKEDVoaWFZ0bw8N2tnK1tjjWbs77
X-Gm-Gg: AYBFou2psm3qaG2hdCrCmzZnoUpXi6WrdzYCsYRW8Tdndm82apOSCUoC3Yy7u2WjtS1
 dFb/WnIsek7I8WAP0WzazseFCnkOZmqmx/K23OzoWWtcIajF6tPWB52zpYnyUPcLnBfPEmaFyAx
 qIVsDU3j7OcAvFZk8qavWFCpmXLNVS3i4HoNufe+y8MgUozyCPMblx5Z2MPLTzMgVdbeEYVagdx
 +c8AU2cLBx7RZbV1Te0MkkI8xqLqEZ/BNYyNp3h2g/9msg/w0MNvUSqXogW3Jt5F1D+L5PjKrWR
 79uZAHYVcUupUrdZSxMXnWjwM7xrHs8FcdiANCDSAdyeP4f5KqgMXBIXuAeqsgvyLY2J/pbQ82A
 DxWqGGtM9vxUe7bIA/K8qM2LYRYLuiiz6BnRGXesIIWbEyy4UhfNxn1R5y3U=
X-Received: by 2002:a05:690c:e21b:10b0:81d:a225:ecc0 with SMTP id
 00721157ae682-884ae9ab0famr4400587b3.27.1789070598197; 
 Thu, 10 Sep 2026 13:03:18 -0700 (PDT)
X-Received: by 2002:a05:690c:e21b:10b0:81d:a225:ecc0 with SMTP id
 00721157ae682-884ae9ab0famr4399847b3.27.1789070597466; 
 Thu, 10 Sep 2026 13:03:17 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e809fd0bsm60850285a.33.2026.09.10.13.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:15 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:03:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, isyanfei.xu@gmail.com
Subject: Re: [PATCH v2 3/4] migration/rdma: Allow multiple in-flight writes
 per chunk
Message-ID: <aqMNASWj2baFILy7@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260830012750.1567524-1-yanfei.xu@bytedance.com>
 <20260830012750.1567524-4-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830012750.1567524-4-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sun, Aug 30, 2026 at 09:27:49AM +0800, Yanfei Xu wrote:
> qemu_rdma_write_one() waits for an earlier write that shares the same
> registration chunk, even when the dirty ranges do not overlap.  This
> serializes sparse writes and leaves send queue capacity unused.
> 
> RAM round notifiers now provide the completion barrier before a newer
> page version can be sent, and the obsolete unregister path no longer
> requires per-chunk serialization.  Remove the wait.  The global nb_sent
> count continues to manage CQ and send queue resources.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


