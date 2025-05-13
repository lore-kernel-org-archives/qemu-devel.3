Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8998BC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 20:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEwE0-00016Y-6z; Tue, 13 May 2025 16:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEvyg-0008Pz-EH
 for qemu-devel@nongnu.org; Tue, 13 May 2025 16:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEvye-0003BY-Ib
 for qemu-devel@nongnu.org; Tue, 13 May 2025 16:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747167106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpzOlWLo/XwlOo9wUkGTowqRryn5smwGV4BdVDQhFLQ=;
 b=AwjjUsJ9duQ0aSAj32jn5at1uqX0EjzPcrPEObMXmp7XHx1ibrwj9CvSQvARNi9+w0e6G1
 YKwUgg+efaoatw589mXZzebyGafaqNEppH4Bf5JgcoWU63PGj/sqGdUqC2ZdD9PIjlh3hz
 Fbl/mfuKVR485fJwUfVUf+gwHll4tA4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Uk8TjK-6OOGxx9sm5Zzt8Q-1; Tue, 13 May 2025 16:11:45 -0400
X-MC-Unique: Uk8TjK-6OOGxx9sm5Zzt8Q-1
X-Mimecast-MFC-AGG-ID: Uk8TjK-6OOGxx9sm5Zzt8Q_1747167104
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b5d18cb7so2277666f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 13:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747167104; x=1747771904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpzOlWLo/XwlOo9wUkGTowqRryn5smwGV4BdVDQhFLQ=;
 b=KySOioId8QVUyE4uNQxcTNx2SoD2PdMe2CRwHnhqEnPkzQwDTa7XPR2vBNd308kXbG
 5FSd/qAFEFaVsP2dcbOU6LhyjqNL5ZWzTXJicZ9ehf1xn+kFus7MmZuhS0TlvDdD55+S
 Mb0qdCtFrPRcromBRmDFzVska7yXIQ/rN4+mEKVrjIP+GAQSzIfFggOTa1fc2SHCk/ph
 Tth7xpAndSnnwnuJNlZQjuNwjYCJXZJLRSXxt0aGCjYmj4zs4miGdravmXFskECN/dXI
 AmZKnIcmeoDgxINxRmdQ5gxP6jgBLqJ/a2LGq+QcaOy/UDczvJNSsLDMDFKipGvKZIq3
 y7Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYvk18Nygc4nW/P2sV9Mgnzq76Bm6T/Ggt+3l8IT12BRebMPaiGwrpW7HnpzZSuU9ZK7BYt6Y4HRfm@nongnu.org
X-Gm-Message-State: AOJu0YyN0BqIf5lu/DAtdZkhuY34qDw6xW3QqStKS6rKGLc9qLTFx0/s
 lpNih0RBnvFshMBwG2omA/v7MHZsO6fS4Y0fJWA12uIJJdyJog2Tz+ccWNeaDB04dCLbVP1egOW
 gM9oM8hFGINUw71qB/S6Pd5Dw2Pi5r6QarAdlOLNooIq01pzSPl4Z
X-Gm-Gg: ASbGnctY+QMpeB7BIdMLB7IsfYkqtNeL9A7cxYxBZu7Z307OWRLnEKURRiQNGFCsDEH
 JIFHyvsPmivvxxCMSzI9LkLPGTih7leOggedteIEBM0RVFSnXL7fjK3SVIkUTq/Rnm+e1iQJGRI
 PlomB4LXRhUTq/6IBUUcqNq4R1U/DaTGFL1qOQO3HPZVbesvTQPNz8UHXY3f/5T1iMHN3NRhaDj
 l0YvqEHLL4jQkWdCjTp2IWoN4IEbAOZxaN6t6GAQAr2zFrF5dKKzdPbgwkatF69NO0tmO4fN7Od
 COmCNQ==
X-Received: by 2002:a05:6000:3104:b0:3a0:6f92:ef7c with SMTP id
 ffacd0b85a97d-3a3496a4e93mr513310f8f.17.1747167103895; 
 Tue, 13 May 2025 13:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE59X2LlRj9gfI9a2aT0BJZ5rr9DbvpEGhChN2wc/XufyiMfZn2mAGcV53IIhnAPmJJXgCkBQ==
X-Received: by 2002:a05:6000:3104:b0:3a0:6f92:ef7c with SMTP id
 ffacd0b85a97d-3a3496a4e93mr513285f8f.17.1747167103481; 
 Tue, 13 May 2025 13:11:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d96csm17441760f8f.69.2025.05.13.13.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 13:11:42 -0700 (PDT)
Date: Tue, 13 May 2025 16:11:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Chaney, Ben" <bchaney@akamai.com>,
 "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>
Subject: Re: live-migration performance regression when using pmem
Message-ID: <20250513161036-mutt-send-email-mst@kernel.org>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
 <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 13, 2025 at 07:21:36PM +0200, David Hildenbrand wrote:
> On 12.05.25 17:16, Chaney, Ben wrote:
> > Hello,
> > 
> >          When live migrating to a destination host with pmem there is a very long downtime where the guest is paused. In some cases, this can be as high as 5 minutes, compared to less than one second in the good case.
> > 
> > 
> >          Profiling suggests very high activity in this code path:
> > 
> > 
> > ffffffffa2956de6 clean_cache_range+0x26 ([kernel.kallsyms])
> > ffffffffa2359b0f dax_writeback_mapping_range+0x1ef ([kernel.kallsyms])
> > ffffffffc0c6336d ext4_dax_writepages+0x7d ([kernel.kallsyms])
> > ffffffffa2242dac do_writepages+0xbc ([kernel.kallsyms])
> > ffffffffa2235ea6 filemap_fdatawrite_wbc+0x66 ([kernel.kallsyms])
> > ffffffffa223a896 __filemap_fdatawrite_range+0x46 ([kernel.kallsyms])
> > ffffffffa223af73 file_write_and_wait_range+0x43 ([kernel.kallsyms])
> > ffffffffc0c57ecb ext4_sync_file+0xfb ([kernel.kallsyms])
> > ffffffffa228a331 __do_sys_msync+0x1c1 ([kernel.kallsyms])
> > ffffffffa2997fe6 do_syscall_64+0x56 ([kernel.kallsyms])
> > ffffffffa2a00126 entry_SYSCALL_64_after_hwframe+0x6e ([kernel.kallsyms])
> > 11ec5f msync+0x4f (/usr/lib/x86_64-linux-gnu/libc.so.6)
> > 675ada qemu_ram_msync+0x8a (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> > 6873c7 xbzrle_load_cleanup+0x37 (inlined)
> > 6873c7 ram_load_cleanup+0x37 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> > 4ff375 qemu_loadvm_state_cleanup+0x55 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> > 500f0b qemu_loadvm_state+0x15b (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> > 4ecf85 process_incoming_migration_co+0x95 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> > 8b6412 qemu_coroutine_self+0x2 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> > ffffffffffffffff [unknown] ([unknown])
> > 
> > 
> >          I was able to resolve the performance issue by removing the call to qemu_ram_block_writeback in ram_load_cleanup. This causes the performance to return to normal. It looks like this code path was initially added to ensure the memory was synchronized if the persistent memory region is backed by an NVDIMM device. Does it serve any purpose if pmem is instead backed by standard DRAM?
> 
> Are you using a read-only NVDIMM?
> 
> In that case, I assume we would never need msync.
> 
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 94bb3ccbe4..819b8ef829 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -153,7 +153,8 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
>  /* Clear whole block of mem */
>  static inline void qemu_ram_block_writeback(RAMBlock *block)
>  {
> -    qemu_ram_msync(block, 0, block->used_length);
> +    if (!(block->flags & RAM_READONLY))
> +        qemu_ram_msync(block, 0, block->used_length);
>  }
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb

I acked the original change but now I don't understand why is it
critical to preserve memory at a random time that has nothing
to do with guest state.
David, maybe you understand?


