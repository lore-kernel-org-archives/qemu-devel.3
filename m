Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E240C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtKQ-0000Cj-0y; Tue, 13 May 2025 13:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEtK5-0008UB-8N
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uEtK3-0001XD-CU
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747156901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q75e6ckgUjOKEpLf04x+Cc4VbqN2hQhimV49MO1e1dM=;
 b=I6YZlVDf83LxiL9tcWnt42DUTbGel0nCLlDjtRogqlOuATkUy+YKShjoQpzawPMOg8M93V
 rSPwjfy8FjP3M5KkmWntqfDM4CgpR4YpzNYP15UR/TJJhgA4kd2eIUO86UIeGefDvteMSS
 VpQu8HEpgSmYo1HuriE9kCCghbmR+wk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-RLoB6SM1NFuwA8xCgQ_txA-1; Tue, 13 May 2025 13:21:40 -0400
X-MC-Unique: RLoB6SM1NFuwA8xCgQ_txA-1
X-Mimecast-MFC-AGG-ID: RLoB6SM1NFuwA8xCgQ_txA_1747156899
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso20185445e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747156899; x=1747761699;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q75e6ckgUjOKEpLf04x+Cc4VbqN2hQhimV49MO1e1dM=;
 b=xRnTr7gIQE29Yyq58yF6NcXgNS+eqBznfXmz+jITsClxyAvo7cNhXjXdBmxwscE2cz
 bM+HZQcWs5N8x45x1ztkwpaMzrzhs+9DvZyC7hfEVitLJrgTDFMD2JbjdkxdDl8C3/z2
 /i+z23uhVhPiAP8t7toPdJY96CHqdAZfB4fbJo6LmYsCaieYZWLIfCXsWzBUD8Hx/uNB
 W68HVsVDSLO7Xdkaep0C6u3m2nJjeBSqHHRJ6ZqrhgjsaUCJU/LSG0Q5u+vZkSInFa0c
 7AOcwvgRjN4c2El7fs7s3cFnaRmt6BhBmg8n4e8myoILNmTvtvBCt2tgWvcN1p/3+FWN
 Oknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlTsSDvHedE/dffRazM8ohFx9NE/28Zk4XWANgD2gxTae2yr4Rb3Rdv2uGkpNNyIuxru7GKMnprEhK@nongnu.org
X-Gm-Message-State: AOJu0Yyi1zxQMH/ChkIusDnaOJcq1ah7QN2Pd667xaafWgAmH6E2SI+z
 4qruqQ+8T5N+UORBxEQ1vVMMDvk/zNh/ECO39PpD43NIMgpYipVCrSwjV/F7J4f7BzNdbxZNJxi
 8n6ZIh6JIEZ2Vy70lEdxPZniIFIBHD7pYIzvRThaLKMYQGbnpeyoAEZOZ1jv2cTs=
X-Gm-Gg: ASbGnct1KeekVSsmwDHuQXYJlmwaIRb4oOJH5o8YDrqcq+JhjCXkFyz/oIzg5C9/X3O
 FDNfH3shBDySeLY/n4paP7eXbg/8jf646HQDjiOW0wSqZBGkKBkM3MrRICc0cBMUYFFEkLkMMAy
 JCU7GM2mXMO9Cz0dRVvpEcL1Ao1xvW4VNko2czyXoAax3U9DyMTx3DZi5sZb8aM6dS49/HasxYr
 PkNkXW1f/GsKiVBVc7+SEOra4BtagsNQmzWIpKuewVAmqfxD32hbDBgMpanzhgt2Zq/6aBbMxLJ
 SDwtPCqLvG/UxEzcrQTsMCE+h2mim1nBEfK3LsdRF/dgjc16XV+o9XMsUPBJeka640wQb7WDSGr
 Nebz240t66oZcThJPot636EICdMrNZ96dEarz6hs=
X-Received: by 2002:a05:600c:a08:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-442f2179d90mr1049535e9.29.1747156899101; 
 Tue, 13 May 2025 10:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrR+6wtTE2KEwk86cif+AyyWNAGqniI2Dv2ja9iOfxA3jKXlJeP/YZ0MuoUVz0AQcGVGmALA==
X-Received: by 2002:a05:600c:a08:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-442f2179d90mr1049315e9.29.1747156898708; 
 Tue, 13 May 2025 10:21:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34?
 (p200300d82f4d1a004fdf53e21a36ba34.dip0.t-ipconnect.de.
 [2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7d2bsm220852205e9.36.2025.05.13.10.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 10:21:38 -0700 (PDT)
Message-ID: <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
Date: Tue, 13 May 2025 19:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: live-migration performance regression when using pmem
To: "Chaney, Ben" <bchaney@akamai.com>,
 "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>
Cc: "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua"
 <johunt@akamai.com>, "Glasgall, Anna" <aglasgal@akamai.com>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 12.05.25 17:16, Chaney, Ben wrote:
> Hello,
> 
>          When live migrating to a destination host with pmem there is a very long downtime where the guest is paused. In some cases, this can be as high as 5 minutes, compared to less than one second in the good case.
> 
> 
>          Profiling suggests very high activity in this code path:
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
>          I was able to resolve the performance issue by removing the call to qemu_ram_block_writeback in ram_load_cleanup. This causes the performance to return to normal. It looks like this code path was initially added to ensure the memory was synchronized if the persistent memory region is backed by an NVDIMM device. Does it serve any purpose if pmem is instead backed by standard DRAM?

Are you using a read-only NVDIMM?

In that case, I assume we would never need msync.


diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 94bb3ccbe4..819b8ef829 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -153,7 +153,8 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
  /* Clear whole block of mem */
  static inline void qemu_ram_block_writeback(RAMBlock *block)
  {
-    qemu_ram_msync(block, 0, block->used_length);
+    if (!(block->flags & RAM_READONLY))
+        qemu_ram_msync(block, 0, block->used_length);
  }


-- 
Cheers,

David / dhildenb


