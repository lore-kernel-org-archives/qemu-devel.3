Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F93E10F6FD6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xvr-0003PX-Vp; Wed, 01 Apr 2026 11:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7xvR-00039C-2Z
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7xvO-0005WD-QV
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775058969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvv12KyvL+3Pjq8wbNzvu259nrXA5ZQxdXUowBvAGiY=;
 b=Nh/ONwXV5yvOp9fiC+9DPjnv15mpa+Aam/JqNcQyFL7jS1MpBoMuWjTmEt5WqbSYPhZeVj
 v8hdve0l0vxfB2DpgBvbSer91RabZ+Mb9cd8z7568zKz04uNWG18TWbAG+byhLVlv2X8Vb
 If/tlF1QrkJi0nEmypNe25PxCjOQoME=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-zDscJbtpOsqf2PfvIqDbUQ-1; Wed, 01 Apr 2026 11:56:07 -0400
X-MC-Unique: zDscJbtpOsqf2PfvIqDbUQ-1
X-Mimecast-MFC-AGG-ID: zDscJbtpOsqf2PfvIqDbUQ_1775058967
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89502dfd7b4so152892646d6.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775058967; x=1775663767; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vvv12KyvL+3Pjq8wbNzvu259nrXA5ZQxdXUowBvAGiY=;
 b=UCIkfOgBQ+O2r0DmWLi2tHvgY7WV31q0BXNY0ezkhorn/+1lfucIT1iDmgF+eUgZ0e
 LSoHAQpzxACwY5qTfuwtiBapEVc14vqc7uvB68XgfqdKAE8h9KW1v0Tm8/Us4kg9fG0E
 4Agjo7YNdIVWfUE/Ju0Zx/xmOO5QRe1mbNqnAnbwTJ5ppmKSEELvY7qA+eFjGb+4vaYI
 AF8572uN06xYkfSSXCDWHS4fveu/OCW+4iHZa5Ddhbs0Ko2Cq6KOFSwN5GedCbf/4Rdq
 mohGb6s7WIkLBcKX5VstI5Q704yBmK4k/NsxlBvo67V6RcBlz0Ao2XOGJpxJFybUkPXu
 e8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058967; x=1775663767;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vvv12KyvL+3Pjq8wbNzvu259nrXA5ZQxdXUowBvAGiY=;
 b=qZSQvshORPuajux0FVW1M7QLlle2knxp6+bL7Dq91d2Tr+h5wiumX0JdTC4eEVpTOp
 c+mqdCXBEbnlE77qkWoUXhSGF5r0jUgSDBqcEV/QfzpUkhNAmQmzbjhsrvTyyx6sgXJ3
 c7Nf8poYdXdAPbYLxc1QIBy25RYjzjU/pmQHOcvLgJ6LmTKnkBIoZYVXNvoFBgwxz25+
 BGOzjUT0M65Q6utl84tzeSGP0DZCJUfOJHW4jPnB3asGH6ydSKvTxAxNrlER5xgQ7Qiq
 tTwen/7/0YWFgmgOUSxJiHa6olBMtpBROSpvhCAuUByRjDLlPFfZo6k3uW5vgfWCrZh1
 mT4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAPC0Dtgchya5+l0fSkEN6vIMpk8BB6Fu3x/pXRL4FVvshRJy4aRi7uDlZM2Ft+/CNkaq/nfcai6n7@nongnu.org
X-Gm-Message-State: AOJu0YxGVPLURrXbCIs/+PTtWwHgzZYd1KlSfuUg/6pX8i30eyltSL0a
 rBNZ4+h0FJMnwWW7hJk7Gywb5iCkfNcSf+e+btYoRsbqV2eY2A7OE+pDRC3LzLLZ+ndW6UQGPv7
 lfm4aWbwAiN5qi9yHI20YwnIJsh4cgukIZx95Ot5kndgpl8yyTgPZIsvG
X-Gm-Gg: ATEYQzzO7u05yWU4FnkQugerA75165QdBm03OLTYU8yVyLEzeNrm20t6g8k1FOyhAw9
 w60V8Zi4RVzqbhJp+X6/r6Dj90YWu+MwidD0+vpom0NAyASeak0HNVWgiBclO2O/JAGGkOh3AVR
 ptbhFHW5VPdQsSwlZBQeN4WZCkX0AmCrFfA9RM3Z0oWSfZqFWoSMij8xH8+8tjKwnWV/HCf/up3
 M5JoBTlmP4stIatya9phDgmoZ5Vx+s1Qgrooikip7+4tpZzlL88X8rtmMNOSdm20q3Uq6+kiaPN
 jkLyLQ2pJkqa4wFXPeQH570ykngJpY8Vw2UBan1oaQMsNs8UnvuHwVCzLWgckKw8N5uKm+Ttjfg
 yhxpXOYGd+RtpYgeBnRiLakRUtnGhSdR1Ej519pGqET9mFw==
X-Received: by 2002:ad4:4eef:0:b0:8a1:6509:9cbe with SMTP id
 6a1803df08f44-8a43a559ab1mr65302576d6.55.1775058967197; 
 Wed, 01 Apr 2026 08:56:07 -0700 (PDT)
X-Received: by 2002:ad4:4eef:0:b0:8a1:6509:9cbe with SMTP id
 6a1803df08f44-8a43a559ab1mr65301686d6.55.1775058966519; 
 Wed, 01 Apr 2026 08:56:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a5900d6db0sm1224566d6.0.2026.04.01.08.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:56:05 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:56:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "Emily.Deng@amd.com" <Emily.Deng@amd.com>,
 "Victor.Zhao@amd.com" <Victor.Zhao@amd.com>,
 "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>,
 "Qing.Ma@amd.com" <Qing.Ma@amd.com>
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <ac1AE4vrAlKmawlb@x1.local>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <acqgZShXRkqzBU1C@x1.local>
 <e3b261a3-25fa-42f9-a926-306e5a19cf75@fujitsu.com>
 <02a44178-eebc-4fef-a8fb-802dac76c11f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02a44178-eebc-4fef-a8fb-802dac76c11f@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 31, 2026 at 06:33:23PM +0800, Zhang, GuoQing (Sam) wrote:
> 
> On 2026/3/31 11:30, Zhijian Li (Fujitsu) wrote:
> > [Some people who received this message don't often get email from lizhijian@fujitsu.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On 31/03/2026 00:10, Peter Xu wrote:
> > > Hi, Samuel,
> > > 
> > > On Fri, Mar 27, 2026 at 02:50:06PM +0800, Samuel Zhang wrote:
> > > > The default 1MB RDMA chunk size causes slow live migration because
> > > > each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> > > > 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
> > > > 
> > > > Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
> > > > faster migration.
> > > > Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
> > > > 
> > > > Performance with RDMA live migration of 8GB RAM VM:
> > > > 
> > > > | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
> > > > |-----------------------|----------|-------------------|
> > > > | 1M (default)          | 37.915   |  1,007            |
> > > This is the default. It surprised me a bit knowing it can only reach 1GB/s
> > > throughput with the current code base.  Do you know why?  I thought RDMA
> > > should be much faster than this on throughput with whatever hardware setup.
> > 
> > Regarding the baseline performance, Samuel's numbers look reasonable. I checked
> > some of my old test data on a ConnectX-4 Lx card years ago, and the throughput
> > was around 10 Gbps (~1.25 GB/s), which is consistent with the 1 GB/s he reported.
> > 
> > > > | 32M                   | 17.880   |  2,260            |
> > > > | 1024M                 |  4.368   | 17,529            |
> > My guess for the dramatic performance improvement is that a larger chunk size
> > allows qemu_rdma_write() to batch more *contiguous dirty pages* into a single,
> > more efficient RDMA send operation.
> 
> The `throughput` data is collected from `info migrate` qemu monitor command
> after live-migration.
> 
> Yes, Zhijian is right. As each chunk triggers a write_flush and each flush
> involves posting an RDMA WRITE and WAITING for completion, there's software
> overhead here.
> 
> For 8GB RAM VM migration, 1MB chunk size produces ~15000 flushes. The
> software overhead adds up and prevents the RDMA hardware from sustaining
> high throughput.
> 
> When chunk size is 1GB, there are ~3700 flushes. Reduced flush count means
> reduced software overhead and improved overall throughput.
> 

OK, thanks both.

> 
> > 
> > Is there any workloads running on the guest during the migration, or just an idle guest? @Samuel
> 
> 
> The guest is idle when I test the migration and collect the data.
> 
> 
> > 
> > Given the significant benefit and the fact that the patch itself is straightforward,
> > I think it's a worthwhile addition.
> > 
> > Acked-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> 
> Thank you for the ack, Zhijian!
> 
> 
> > 
> > 
> > 
> > > > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> > > One thing to mention is RDMA migration is in odd-fixes stage, actually it
> > > doesn't have a real maintainer so it is kind of "orphaned".  In this case,
> > > I actually won't suggest we add any new knobs for performance reasons.
> > > 
> > > Do you have a strong reason to propose this patch to land upstream?  Is it
> > > used in production systems and it solves some real problems for you?
> 
> 
> We have VMs with large RAM and find TCP live-migration is not fast enough
> and expect RDMA migration can be faster.
> 
> But we found the rdma mode migration speed is slower than tcp mode. See
> following data.
> 
> 
> 8GB RAM idle VM live-migration performance:
> | transport mode       | time (s) | throughput (MB/s) |
> |----------------------|----------|-------------------|
> | TCP                  | 36.89    |  1,081            |

What is the NIC setup?  Did you try to enable multifd to offload zeropage
detections?  Or is that not feasible due to some reason?

> | RDMA, 1MB chunk size | 37.915   |  1,007            |
> | RDMA, 1GB chunk size |  4.368   | 17,529            |
> 
> This patch allows us to use larger chunk size for faster RDMA migration.

Sure, Zhijian's point is reasonable.  If he's fine, I'm OK.

Thanks,

> 
> 
> Regards
> Sam
> 
> 
> > > 
> > > I also wonder what Zhijian would say on this.
> > > 
> > > Thanks,
> > > 
> 

-- 
Peter Xu


