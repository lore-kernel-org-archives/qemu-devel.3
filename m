Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B6EC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4laP-0007DC-EG; Thu, 10 Sep 2026 16:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kzx-0006Au-2w
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kzq-0004Uu-Iv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789070608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWeFI26qjMCROMRcRbwQ0ONsbOjUeQUfKduvVYHqPSc=;
 b=ZNHP5owUU2USYfnj5TFV/he33R51fQAGJtGZtdI2kUPpcMd82mQYKYcmhjx9KqkwjHDTrk
 5fshDvnMJ6CF+zu3VeMtP9fwzTEf5thzyDaTukFhVw8FFf+emQ7c0Hd5FH9GvJcVcTEdx/
 CWPTE/jOQ0rWZwOZEIxiaL8n3onAv5Q=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-yyEScfd5PtSWbE-PRYawWQ-1; Thu, 10 Sep 2026 16:03:27 -0400
X-MC-Unique: yyEScfd5PtSWbE-PRYawWQ-1
X-Mimecast-MFC-AGG-ID: yyEScfd5PtSWbE-PRYawWQ_1789070607
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66faff68c0bso236752d50.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789070607; x=1789675407; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aWeFI26qjMCROMRcRbwQ0ONsbOjUeQUfKduvVYHqPSc=;
 b=HeHLvFSd3kUDpRebYjKMyRWzL7OmugwM1LhiHLG8pAp4tmqFTqAP9qIq7ut46zWaLC
 a7IpoMJ44gJSpxj80OXucc1UwHUtFMa//NjutYmL3zVwIvxHaly9KPCwnw8VUWvBEwmp
 CeuQVZC99XhDAnIy2+8WZflJOmVDBTUGpjdLOaimqqT23T4vEOoQbzcLsgqCJsl+4N7T
 WCJNbiF0Ll03zgFVd7D2/wSJj+V3UxN/xcDndx7ECKuaWGo8UmSnSKJWKRWmHRy6I0qW
 JaZ7gbTBAxYkhymIsO5/njRSG7s5p3tSBHzApd1ZRETjJP+Ql7k4tqBCPByuyk+re3Ba
 BX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070607; x=1789675407;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aWeFI26qjMCROMRcRbwQ0ONsbOjUeQUfKduvVYHqPSc=;
 b=oH8p4mgv0ciUWdXJSg/gAXWgj3+WZ09Ax9vXKQixRXIUs2cNsR+Ganb9FVu+P8l5ji
 01kBRiYRwROnv5hM/7cTe/LC2z7tqcHdxbUG2Y/nrBainBtZiSKgyVFLJOybvIFDjC8V
 7YA8w0AgUMtQJzzSVpIOaz3SlhUGFxvzZCK+8gaxLsN00lM/w161DCA8pC8y4VGYcbRt
 RxzEjBLu1of1e9D958K/kPddTd4hOk2U/KzAIUDQiUozpvMpp7mr/DbuZWsDo4OHjoXK
 JlSuSGOCJ1hcrAzIDNslhXeFP780C2aT8gpNLNQYiZSmFi+zPRj2yscCmRFZSwRwWP0P
 1hew==
X-Gm-Message-State: AFuF++kUlnVzwq6qWLmzM35ycW5E5LuxRfodgyzmPsafzOd3bdJlxGvP
 bSHJougHE7DcLNtPDBjSWMO9uq6RFJ+MC77BmhOQhJ94ye9G22U8GmEwVJsIR04I/Q9paG01UZD
 bDe033twyoCigZZJ+YJXPBpW1K9bc2YHRWG1wxnzp0a3ITUK6XoXJP44A
X-Gm-Gg: AYBFou3lxTQnGVHrq37dzuBr/Ed7E6rArp8L0ETltAAPWIy4A+/bksdOMNT4GH/SFfF
 +AzA5+t3IAoY9nMVlC59Jwe2z8c3lbqS9sgXaQfSoEofk9H+EzDFfdzl0jgFqiGomn2vCVkS4fu
 G3Af1WoBFuNe7Lyl3mbxFpQp1BBBV1BPqA6Vv6QCzH39g8BjL6fB86PdkVsXq7n/bqR0P04Cvhp
 UPl8mV4h+pzB2VCgflQVlFYx8NnDioYhrhjsb6k8cyukmufz1gbfWfsMgR87QaqiZuZSqLAzWtA
 BJLz4geqkaxoIalCcTHHBH/DU2Dw+jfWcvN9PTnGTY4VoVYKynzm6Oj5Fq3Z6BTTAjO7l5FenEM
 xWQcVsMMjywoZR4NVY8a/1QUa5DYl5zWqcuRf3gvX7onDVoVK8vluuM8lT9E=
X-Received: by 2002:a05:690e:138d:b0:66f:c1be:a649 with SMTP id
 956f58d0204a3-671246c2833mr465870d50.59.1789070606729; 
 Thu, 10 Sep 2026 13:03:26 -0700 (PDT)
X-Received: by 2002:a05:690e:138d:b0:66f:c1be:a649 with SMTP id
 956f58d0204a3-671246c2833mr465814d50.59.1789070606046; 
 Thu, 10 Sep 2026 13:03:26 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f47a239sm3894186d6.26.2026.09.10.13.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:25 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:03:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, isyanfei.xu@gmail.com
Subject: Re: [PATCH v2 4/4] migration/rdma: Remove unused transit bitmap
Message-ID: <aqMNDDpowk_5yVmI@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260830012750.1567524-1-yanfei.xu@bytedance.com>
 <20260830012750.1567524-5-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830012750.1567524-5-yanfei.xu@bytedance.com>
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

On Sun, Aug 30, 2026 at 09:27:50AM +0800, Yanfei Xu wrote:
> After the per-chunk write wait is removed, transit_bitmap is no longer
> read.  The remaining set and clear operations only maintain unused
> state.
> 
> Remove the bitmap and simplify the block lifecycle tracepoints.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


