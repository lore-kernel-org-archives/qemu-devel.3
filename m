Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CD1C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQBN-0005WD-T2; Fri, 21 Aug 2026 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wxQBM-0005Vx-EG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wxQBK-0004W0-Pp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787322317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1L3K1UAUfG7A0hvRy+KjbeO1kmST/XBunuGKSkgBfj0=;
 b=AgzOB3SPuTZeB9f8rQSomV9kJo2Wa+g2E06lOiLr+0SNos7IJqjn7xy/0qZ/RJ/tC78Wha
 zof9b5Y3ybUeZuqph8Bvhj/vCetEn7OV6bxqcToDceNjRcgGsAKw2hcUiQbTcbx73lTfYR
 CqaTlTdj1TsPyXBz+oPCZSwPQWT0ZeI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-973L0EYpNTWqmFzju9MevA-1; Fri, 21 Aug 2026 10:25:15 -0400
X-MC-Unique: 973L0EYpNTWqmFzju9MevA-1
X-Mimecast-MFC-AGG-ID: 973L0EYpNTWqmFzju9MevA_1787322315
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b19ce23e5cso1104736b6e.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787322315; x=1787927115; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1L3K1UAUfG7A0hvRy+KjbeO1kmST/XBunuGKSkgBfj0=;
 b=t5cJVlFYZypthYL7OMV0FOiFvas2WXaiC8b8Fa61ov6ZXO3RuNZ0tVqmOH45eNujBE
 kWBqmFSUSE7aQnqyXbO85mVL2WOczVHN0DnPmuWkaKGG3N8AnRiqw92FR7ggxIMEszNI
 br/GWkY6SUvC1ZpEYTJEmbi295Gc3L7aU5MsnVblB4qC6eMwxFQPqUtUo/NCBBDVKYJA
 eHoqbH8R2+4beK9MXPLJquqvYOkPUW94fjd+VLG3/7ygV6sW94IqxGES72LD7MayE24Z
 vPjKOMhlg+pZZKSmvFR1ml46S5HENTaNxeX+oxOVenBzp5IIBvHsh3CIcQ/jiT4LEzv4
 VeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787322315; x=1787927115;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1L3K1UAUfG7A0hvRy+KjbeO1kmST/XBunuGKSkgBfj0=;
 b=ZAa4eR/ewhPZ5LiljKVfuVR+/DqMF5+8l++ZlM5mRY5iDrWJa1wYcaqPlt7wwYwX44
 6wPSFQXmPbFD39m+gavYSCrfeV75+yXMNm3PAk1u4HaUEKuRkt1dKyik8j6J1CYvs8JT
 bnxdwoFOcHTKWjJmNdeSqsFNgUD/aMaL3YjiGquBv/H7gvIEOL7KNX4dqmXotsGDc/Ii
 +zD+WqdeIQDXvXfkSJsci1y+rcQo6dPjJuixvbzlm4s9XznuYzoFcUKsm1FXIWwXK5/l
 RSKOlLgN+8E4xOwVUibsLInGTWobDBS4V2PVpvAIhS/EQpLWxRvKP1D9MKZG9AN3Kd/4
 93xw==
X-Gm-Message-State: AOJu0YzpoAaYgyQo/9iaYKcU+5jbRXeLDtSCPnrtu0gVWxL5DOQQXKYC
 HEyW3ODbubitL5crwJtz6hsmVmHK/cIzxGowv5h+3DoyfB1NsxuycsF4X9UXyifZSDCVzY7SaaR
 XCBGtoZ7s48iDhml1CxdahcKZ7opnlnJ43QyudnRjch/HP+T5f9gsY6Xy
X-Gm-Gg: AR+sD11s4eoHhv4GGkMik0gDG4lYBxHcSl1Dx3up2belxbDoeyEXC6rw9qq3Qp2eKfE
 D/iNN3ZkLPSDy5wIx/RtxuiaU47UdHpexNsV0jyinhLsKZ1YVLTebg4A8VGy7jfPCVUpt9uhrGK
 qlJnRa0ZgOb5A/zgjvNEQVXjYyAoqyX5QOIF489VUYHkXSHxiNHMHNaPhtOciiv3TMmQ7nVp6wV
 kWhezfbrfl8RFVYhVe37nCljDpMGi9ivyM9CV5uQw1rHBxa9HwSFYq19UOXlzVDN5tP3Gug8WLi
 ttQncFpZaJR5Vdim2ZDXDC+mI3GyYi6AIDK4UJRK3pETjaV1tzuS8FAKrFwvUXQZpZy/gL3+
X-Received: by 2002:a05:6808:5087:b0:496:e0:a46b with SMTP id
 5614622812f47-4b2ef25c540mr6511758b6e.3.1787322315019; 
 Fri, 21 Aug 2026 07:25:15 -0700 (PDT)
X-Received: by 2002:a05:6808:5087:b0:496:e0:a46b with SMTP id
 5614622812f47-4b2ef25c540mr6511712b6e.3.1787322314524; 
 Fri, 21 Aug 2026 07:25:14 -0700 (PDT)
Received: from x1.local ([2605:8d80:6d68:fe45:30f9:c4fc:ce4b:4f74])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d6d74145sm4704281b6e.15.2026.08.21.07.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:25:12 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:25:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, isyanfei.xu@gmail.com
Subject: Re: [PATCH v2 3/3] migration/rdma: Retry control sends on full queue
Message-ID: <aohfxvS-msX0NWmt@x1.local>
References: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
 <20260821133559.3815727-4-yanfei.xu@bytedance.com>
 <aohcYFgiDXpCWAlg@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aohcYFgiDXpCWAlg@x1.local>
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

On Fri, Aug 21, 2026 at 10:10:40AM -0400, Peter Xu wrote:
> > +    switch (wr_id) {
> > +    case RDMA_WRID_RDMA_WRITE:
> > +        wr_desc = "RDMA write";
> > +        break;
> > +    case RDMA_WRID_SEND_CONTROL:
> > +        wr_desc = "control send";
> > +        break;
> > +    default:
> > +        wr_desc = "send work request";
> > +        break;
> 
> Do we have other possibility?  I thought it should be either WRITE or SEND,
> if so, we could g_assert_not_reached().

Some side discussion..

Since we're talking about the wrids, IIUC the whole RDMA wrid space is a
bit messy. E.g. RDMA_WRID_SEND_CONTROL is used without having
RDMA_WRID_CONTROL (2000, rather than 2022) for SEND control messages.

IIUC the two-layered wrid name space is confusing, maybe we can rewrite the
wrid allocation to only use one namespace with very limited wrid
possibilities, selecting rdma->wr_data[] index based on the few
possibilities.  My gut feeling is that's much easier to read.

In all cases, this will be a separate discussion, not relevant to this
series alone, but I want to see if I'm the only one got confused by these
two-layered RDMA_WRID_*.

Thanks,

-- 
Peter Xu


