Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90CFC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEZDE-0004Yu-IA; Mon, 12 May 2025 15:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEZD0-0004Sq-4P
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEZCx-0004gz-U0
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747079581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5UrenP4Agfoh++bF/i+J1wWOORsFOlog6kuTv1ugFF0=;
 b=OVtIiglH++OFQi2SiwBIJymTcW9qjo7KnvMdMyO0Q+1h/o3hJg8zeUKTtv9TMxHJZ1QoCZ
 r5bxq3qfDaFrF8ULnC3v8XXoDwzAcuKBCAl+k3/zbmC29rjzG4yKxgoy3HwecmeukOEV8U
 KoT7D6Pm+ma7mHnHHVi+C0Smv2GjaEY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-CSynEiw6OsKsfJ7NIMz76Q-1; Mon, 12 May 2025 15:52:59 -0400
X-MC-Unique: CSynEiw6OsKsfJ7NIMz76Q-1
X-Mimecast-MFC-AGG-ID: CSynEiw6OsKsfJ7NIMz76Q_1747079578
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a202744565so831038f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747079578; x=1747684378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UrenP4Agfoh++bF/i+J1wWOORsFOlog6kuTv1ugFF0=;
 b=AfFviKti1Rsi472MP3mD1w53oMjQMixha2Qa3+JGu62WFfIq2rI+tg3//kFsN3IruR
 o6cx04NPwXoJrVE6J2XZQgHqIBpRVUaYNCmCFBXgaByiaKqWbWnmEWzpx22X+1T4E/7+
 o3JprwyXutTURMSoCvqWdnSXG4W3JlsEcarNnCcokjvGA5KdOCiKyHScPz1uW0hxHeP8
 C/h7Whjz5lsLTifEW48qnBUTv5y9O+amfFm3gu9L7E1r20w/RYX46a6saNO+l9TW1XJh
 sJzbq8Cp/IXekkyM66x05Vk9A090whIosxDJFroj5kd/vEkTHWKGAQXLgDcPyLq/OiYC
 FucA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+HCIr97OQZuM4YeSQ3JdsDb6nYQ7G6VLjpYnB6nxb1q31C9bENI2JqvtXqHgZyl2K60KqZCRftJx8@nongnu.org
X-Gm-Message-State: AOJu0YwA/VyPkb7aw7PsSZmczSnzBpXpcPAqMTn6+iMdNsHLox/JZ5VB
 /ioXQePDVg2Rizw8zovzVKmAo+7K+o/hSHtKjGI0YFEJaD3DbLXWQoWQcbyWtMfPYdIKBAP5puK
 3rR/IDHF1RBBgAzJxmMVlru9fOTXyho0B8PNy9cX8IAUq9KNTPONE
X-Gm-Gg: ASbGncufIY4bJpIwJg0gUsHO5rGM5RvpWLGXtg342hgJHrVyesFWmhBgMCU0Gg728fM
 Eda18zXX8smJIa5zTzjJIUYxarM4pYPI3DX2Bl2nEu36ugZlshxNuXZp+9+YNxYt2Hy0Y4rG3Vp
 o4esAkrL60FnMVzQzbWo9VN8vnwxaQZ4GdiEOLwfZhJsyV/3xrU/5FxZB6XdkWl91hze7B21kWL
 jUByEQ9ZtKZK59bJF8wzKo4khaDVjWjJOM/fH4MWZqLJwy+RPItIAce6gTyNMiD8qWizDRXv+TO
 +Ddncw==
X-Received: by 2002:a5d:5889:0:b0:3a1:d06c:4e5c with SMTP id
 ffacd0b85a97d-3a340d345a8mr578175f8f.26.1747079577720; 
 Mon, 12 May 2025 12:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpT6x0JFUakUymcWwi7EPVw6dFLEWPv1L/Gwy7V1rhysWPUEONrJFVnG60yoQ6ePdEdfkkJQ==
X-Received: by 2002:a5d:5889:0:b0:3a1:d06c:4e5c with SMTP id
 ffacd0b85a97d-3a340d345a8mr578143f8f.26.1747079577275; 
 Mon, 12 May 2025 12:52:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687bdc0sm135461155e9.39.2025.05.12.12.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:52:56 -0700 (PDT)
Date: Mon, 12 May 2025 15:52:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>,
 Haozhong Zhang <haozhong.zhang@intel.com>
Subject: Re: live-migration performance regression when using pmem
Message-ID: <20250512154715-mutt-send-email-mst@kernel.org>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
> 
> 
> Thank you,
>         Ben Chaney
> 
> 
> 
> 
> 

Was added here:

commit 56eb90af39abf66c0e80588a9f50c31e7df7320b
Author: Junyan He <junyan.he@intel.com>
Date:   Wed Jul 18 15:48:03 2018 +0800

    migration/ram: ensure write persistence on loading all data to PMEM.
    
    Because we need to make sure the pmem kind memory data is synced
    after migration, we choose to call pmem_persist() when the migration
    finish. This will make sure the data of pmem is safe and will not
    lose if power is off.
    
    Signed-off-by: Junyan He <junyan.he@intel.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


it kind of sounded reasonable ... but I don't remember.

Also CC Haozhong Zhang who worked in this area.

> 
> 


