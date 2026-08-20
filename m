Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34767C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8vf-0006lt-P9; Thu, 20 Aug 2026 15:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8vd-0006lV-Jw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8vc-0003O8-1N
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787255994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y73ZYF2W2qTue1E6SF/XNNzZOZzwvUGUESGABRLjhz0=;
 b=d5w9nezczEU97lBLhpVRirNMDLbSG1dwu4luyPE0LeQL5PvFAG74in6sVReritT2EUbuvx
 gq1ycFN3WZVDLpkpoP+T6VpbsJi+zj0ZgtnBgI5Pv0fZ8y6v48pgLbwpPGxEre31/qvlrz
 V8BYjSCMAOy3I2zqrEupym4z4Whr0y8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-XkWti88HOByXF5Q3jG5Oew-1; Thu, 20 Aug 2026 15:59:53 -0400
X-MC-Unique: XkWti88HOByXF5Q3jG5Oew-1
X-Mimecast-MFC-AGG-ID: XkWti88HOByXF5Q3jG5Oew_1787255993
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52827090cc5so2772171cf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787255993; x=1787860793; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y73ZYF2W2qTue1E6SF/XNNzZOZzwvUGUESGABRLjhz0=;
 b=NVAply25pBED2PzWD7pJ8TdQnl8ehEmuGWZOk8K/ni/6of562lGcZnPlRGaR31u0Gl
 pU8C0t3VK1L6rZiE22nknJeMN6y6txf5c2oOe2+pZ6GzQazf+Hnm2P+aKDDxhngse+bq
 Y4lp4LdPloSGWU52oSv5ZMCXj7XwaRXTB6JhXpTVrpLgkhH+A/hELhJRBZ6Spd8czkpM
 YQUgwPf0QqFohVzgTgPG/307TDJEOhB9PbWA10BtU3xQfag7EatuxubWi+kiE6Nh/CFW
 Njiqt0DxkCeS6pRDZM8ZCQiCgXY46JbTnIJUs4criq52hRtBTe6AMJkKfsdx6tw2/Wtf
 Abhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787255993; x=1787860793;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y73ZYF2W2qTue1E6SF/XNNzZOZzwvUGUESGABRLjhz0=;
 b=dM2QW/IoGdOKaDe+i9b3rtK+H3p6Ki1Jbvrn9DVKkw/dqQivzyV0jMt3uqRBJKABnd
 +F6c/WYKG+k5WO0GJkraGCkwOb4zFqXnc5Ujl19r9aJ/wkIB+szFbx5I64K6i3W92HjA
 zjwVFDiqbVFI3iF3HpjxsZLTxNqt7Omga3LoHDHtkoJL7MXWNV9RkIo0fxX5EefxpaDO
 i1qenTQYvoLlAyMbzXSiiwmqokUVP4rdtf7v5WDhkgHBuiFJz+HldzwMe9TKSknWe3+7
 SYy9F+O80WKNyYjosIzjMrqpOLhtMZimUBhJmtPCb+0ftc6sebu0zgYlF/ThDfOxwJi0
 R9TQ==
X-Gm-Message-State: AOJu0YxDifjwrhKFmSdNdXIXG1pz2ZWsbZqeuNUslV5K1ZG0hs7wGNXd
 MhvZp4iOtFfoLiaOyBfVkDZf2Er93P/FvP4Mww0vSUat3pPCSWdj21DgXkyNabJDrfP60NkzKyg
 IzdgGnBxnewqisZYrFvoK41KGzIcBLWQp0b53DphAQaTDQkRBfM9iopBG
X-Gm-Gg: AR+sD13bpgKa3ir7L49k0CwrYXo07MPm695N3QeVu+ECJjTkb5TswuX8TUIR6grQUzT
 RxDhpLimIVSHrui9xRgtPo6MpKdefHGZ0WBYaVDWJ6vXfK4VkwePSCEu+lJ04TslsGEB1Fs+VLG
 Nld6TgUCxNiBy6XFnipDQkDkCQKsuY9RMiN5AIL9hdo45sXaERaE4lST4pnWK7Jo6vGLHD/CMT3
 +mdMFPMokEf++BXBSQ9J+hTDhpqRCowzEtI6EssIoHRuDRsrcIZQELgxJXNU0jKxDryn9F/bcTG
 8vlAGUlCLTcJj69Bkw1UF6P0c3vvhwg+r9AgfQN2jXKvunG8iho1K1q+VUswFWolDKgm
X-Received: by 2002:a05:622a:1baa:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52de36e5e5cmr81955371cf.22.1787255992800; 
 Thu, 20 Aug 2026 12:59:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1baa:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52de36e5e5cmr81954791cf.22.1787255992237; 
 Thu, 20 Aug 2026 12:59:52 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52dd86f43c8sm36827801cf.15.2026.08.20.12.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 12:59:51 -0700 (PDT)
Date: Thu, 20 Aug 2026 15:59:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 isyanfei.xu@gmail.com, jinpu.wang@cloud.ionos.com
Subject: Re: [RFC PATCH v1 0/2] migration/rdma: Allow multiple writes per chunk
Message-ID: <aodcq-LRjtFacLdc@x1.local>
References: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

On Thu, Aug 20, 2026 at 08:58:31PM +0800, Yanfei Xu wrote:
> My understanding is that within each iteration round, the HVAs carried by
> different WRs never overlap, so serializing WRs within the same chunk isn't
> necessary. This patchset builds on that assumption — please correct me if
> I've missed or misunderstood anything.
> 
> This series improves RDMA migration throughput during the iteration phase
> and iterable stop-copy phase by allowing multiple writes to the same
> registration chunk.
> 
> RDMA tracks RAM in registration chunks.  During the final iterable
> transfer, workloads always leave many scattered 4 KiB dirty pages, with
> several pages falling into the same chunk.  The current code waits for
> an earlier write to a chunk to complete before posting the next one.
> These serial completion waits can leave send queue capacity unused and
> limit RDMA bandwidth, increasing downtime.
> 
> The first patch replaces the per-chunk transit bitmap with reference
> counts.  The second patch removes the per-chunk wait.
> 
> rdma_registration_start/stop functions called in each round synchronously
> drain all in-flight WRs with cq, which can serve as a barrier between
> rounds.
> 
> The test configuration is:
> 
>   RDMA chunk size:    32 MiB
>   Guest:              32 vCPUs, 128 GiB RAM
>   Test runs:          10
>   Max HCA bandwidth:  100 Gbs
>   Workload:           idle
> 
> Average results:              Before       After
>   pin-all is true
>   Downtime                    396.7 ms     345.7 ms        ~12.9% improve
>   Final iterable bandwidth    9952.0 MiB/s 11639.10 MiB/s  ~17.0% improve
> 
> 
> Average results:              Before       After
>   pin-all is false
>   Downtime                    248.7 ms     191.1 ms        ~23.2% improve
>   Final iterable bandwidth    5605.1 MiB/s 9826.0 MiB/s    ~75.3% improve
> 
> Note: Final iterable bandwidth actually means the bandwidth during
> qemu_savevm_state_complete_precopy_iterable(). non-iterable data doesn't
> use RDMA Write.

So I left some comment in patch 2, but maybe I should just comment directly
here.. please check that first.

If you would agree with what I said there (and you should have noticed
another patch I sent days ago removing UNREGISTER path), I think what we
really need might be:

- Move RDMA draining from ram_save_iterate()/complete() into each time we
  finish scanning a round

- Remove transit_bitmap completely (if you see after applying your this
  series, the UNREGISTER should be the only user..), because with the
  correct draining IIUC we don't need this anymore

Thanks,

-- 
Peter Xu


