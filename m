Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25D7C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYEb-0006W5-Cl; Mon, 12 May 2025 14:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEYEW-0006UK-2o
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEYET-0005gx-OS
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747075832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeTk78Wp8AcLGm4/sFoTTRqM6sYibG6xtGJ3pHH9hZ8=;
 b=E5LmyTpckMDEwl9NIhj7pTDMRco76RaEMoDV73zERM8oWUzoKE2CPVGN+pIayxbb5xuvR6
 BVfvOxDPqBYs9kQdjkVKURuEs8dVErsmtDzbPn7InQJdzsOF0IJvKbUf2EgJQISz5qY4hI
 EL1/A0v9TIk1OVgqLjz8IG1UsNGjnGY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-7elVIV5pOHiKlD4W6ZjdGw-1; Mon, 12 May 2025 14:50:30 -0400
X-MC-Unique: 7elVIV5pOHiKlD4W6ZjdGw-1
X-Mimecast-MFC-AGG-ID: 7elVIV5pOHiKlD4W6ZjdGw_1747075830
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5c9abdbd3so469672185a.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747075830; x=1747680630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeTk78Wp8AcLGm4/sFoTTRqM6sYibG6xtGJ3pHH9hZ8=;
 b=nE/PVUiVNwUpFCBDQv8TCLQSSfzWPpKhR7VvDDnetRWbjD26rgHI8a6tVknIXqI9a3
 QRVqn3k4r8XXpsHPNKFYkc6k3gdUtbCWwcJtkuzoAFDqtRcwBX5ij+Rc/XPdGsuOePki
 Kshfe+d77aFUrp3Tl7fSVj368nbRBbL3mTgLzBTj9NoJPWe/d8UQfwiH8gb+xunjbqav
 XN1xlP/+rt3tl3+Hyy9iCqVTHvEoUmv6VXKUgzVZ+gQ/20ecJ9rUlnOSgdhxlln5OEIm
 zDb2Cdk3m6bPUyr7KHQ6wEJ5XPTdZEGrse6imtVRMc2+EcCsa8rmNImijWLZQGM8jwdf
 SERg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9I5vSDrvs0ZSPcif9bdFBU8nAktqMPtWawR1eUPSNwF7Y5jUaZcERA/uXN3KIilqyxaLnHXToRKO7@nongnu.org
X-Gm-Message-State: AOJu0Ywdd5+NKp+Hpdf6PYUI0/xax+8CPPdlFTs0qTeVgi/xnk6BCIFs
 pdZahnALRwOsSjVCgSDiyAZbN2gL8CeBsOnWUJ7T76nCAsN+3xjSSLhUVrPzSDIRZuaE9v2Cqvm
 f/9Ra7sHqgbgX213hd9AIZJ/+I9DcQu0wKW1Bbgw+lCVB1eKPSgy3
X-Gm-Gg: ASbGncuQyxnKFWtzSmVD24pgEKxXQai9+4U+52ANQ+HC+oM7B8IdhI02WFDIqV3mAnR
 jqwjoedaCeLu5+davfSGUu/9vPdYDzKOHMLT/fTMWqMeTTz7isCnQ1i5FCCYbdxLNLQDnPeHXDT
 HMpYSgooSFO2LU6XaMlo5ZAZ/ouWlW4B907PNOY2jMrl90Gz4N0gHrlX9VFHqv5GMBiBiWn0AbS
 7+Ry3e5IqpH/osa4adlvggTbT/E81DDTEsbCWmsCEMpsYocpGiSJk9ajCXCtajsKgaChy+au1iJ
 1AI=
X-Received: by 2002:a05:620a:d8b:b0:7c5:5670:bd77 with SMTP id
 af79cd13be357-7cd0114fb3cmr2257646085a.55.1747075830318; 
 Mon, 12 May 2025 11:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrcS40/zmYROZHS7Rahg+cgXJ0BqUHP+i1jBISTg75HALp1wW8i5S/2OCYjRJEBNlZIgeJ3A==
X-Received: by 2002:a05:620a:d8b:b0:7c5:5670:bd77 with SMTP id
 af79cd13be357-7cd0114fb3cmr2257642985a.55.1747075829965; 
 Mon, 12 May 2025 11:50:29 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd1accf328sm99775585a.0.2025.05.12.11.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:50:29 -0700 (PDT)
Date: Mon, 12 May 2025 14:50:25 -0400
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>
Subject: Re: live-migration performance regression when using pmem
Message-ID: <aCJC8U_TJXcQcPmk@x1.local>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 12, 2025 at 03:16:34PM +0000, Chaney, Ben wrote:
> Hello,
> 
>         When live migrating to a destination host with pmem there is a very long downtime where the guest is paused. In some cases, this can be as high as 5 minutes, compared to less than one second in the good case.
> 
> 
>         Profiling suggests very high activity in this code path:
> 
> 
> ffffffffa2956de6 clean_cache_range+0x26 ([kernel.kallsyms])
> ffffffffa2359b0f dax_writeback_mapping_range+0x1ef ([kernel.kallsyms])
> ffffffffc0c6336d ext4_dax_writepages+0x7d ([kernel.kallsyms])
> ffffffffa2242dac do_writepages+0xbc ([kernel.kallsyms])
> ffffffffa2235ea6 filemap_fdatawrite_wbc+0x66 ([kernel.kallsyms])
> ffffffffa223a896 __filemap_fdatawrite_range+0x46 ([kernel.kallsyms])
> ffffffffa223af73 file_write_and_wait_range+0x43 ([kernel.kallsyms])
> ffffffffc0c57ecb ext4_sync_file+0xfb ([kernel.kallsyms])
> ffffffffa228a331 __do_sys_msync+0x1c1 ([kernel.kallsyms])
> ffffffffa2997fe6 do_syscall_64+0x56 ([kernel.kallsyms])
> ffffffffa2a00126 entry_SYSCALL_64_after_hwframe+0x6e ([kernel.kallsyms])
> 11ec5f msync+0x4f (/usr/lib/x86_64-linux-gnu/libc.so.6)
> 675ada qemu_ram_msync+0x8a (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> 6873c7 xbzrle_load_cleanup+0x37 (inlined)
> 6873c7 ram_load_cleanup+0x37 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> 4ff375 qemu_loadvm_state_cleanup+0x55 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> 500f0b qemu_loadvm_state+0x15b (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> 4ecf85 process_incoming_migration_co+0x95 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> 8b6412 qemu_coroutine_self+0x2 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
> ffffffffffffffff [unknown] ([unknown])
> 
> 
>         I was able to resolve the performance issue by removing the call to qemu_ram_block_writeback in ram_load_cleanup. This causes the performance to return to normal. It looks like this code path was initially added to ensure the memory was synchronized if the persistent memory region is backed by an NVDIMM device. Does it serve any purpose if pmem is instead backed by standard DRAM?
> 
> 
>         I'm also curious about the intended use of this code path in NVDIMM case. It seems like it would run into a few issues. This on its own seems insufficient to restore the VM state if the host crashes after a live migration. The memory region being synced is only the guest memory. It doesn't save the driver state on the host side. Also, once the migration completes, the guest can redirty the pages. If the host crashes after that point, the guest memory will still be in an inconsistent state unless the crash is exceptionally well timed. Does anyone have any insight into why this sync operation was introduced?

What you said makes sense to me, but I'm neither pmem user nor
expert. Let's wait to see whether others would like to chime in.

What's the first bad commit of the regression?  Is it since v10.0 release?

So I remember there's something changed in some relevant path last release,
which happened in the VFIO work:

https://lore.kernel.org/qemu-devel/21bb5ca337b1d5a802e697f553f37faf296b5ff4.1741193259.git.maciej.szmigiero@oracle.com/

But that doesn't look like to matter for precopy, and since you mentioned
nothing I would expect you're using precopy not postcopy.

In general, if it's a regression, having the 1st bad commit would always be
helpful.

Thanks,

-- 
Peter Xu


