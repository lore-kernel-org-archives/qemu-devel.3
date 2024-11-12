Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A21D32D8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAoAr-0001BN-10; Tue, 12 Nov 2024 05:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAoAp-0001B7-C5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAoAn-0001d8-PR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731407459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ItVKEJ6DNsbBA6WbgZmKyzQ0BM3t6s9BpGdURucTWAo=;
 b=GxNWNdVY6mr/ueGesbHVrbe/PMvJUdUAIHv151/L6XLo5sf0+irGoQr37oi+0vQNiv7VEO
 PC1OBVUg03kOsmHVG3Z1H+6ltqmxMEcgtyzXR2MSYhTMFgP7J9sIzkmyyn8IkAf0p5pimx
 B0yiTCVA7j78VO4sqOF8T/UeHR51YX8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-fphplv8FNbOhrXHxFLgWVQ-1; Tue, 12 Nov 2024 05:30:58 -0500
X-MC-Unique: fphplv8FNbOhrXHxFLgWVQ-1
X-Mimecast-MFC-AGG-ID: fphplv8FNbOhrXHxFLgWVQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d52ca258eso2853126f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 02:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731407457; x=1732012257;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ItVKEJ6DNsbBA6WbgZmKyzQ0BM3t6s9BpGdURucTWAo=;
 b=F0g7X8/A8ZXBWZ5anvgqY6smMYx0mXMMpqqQiuVDfvW0FJ81cQHSLFz3pFz/drYQkq
 2h3dPX4MD5nl3i4xGYl+DR7utvJfF4TBC0SbF8mX2+lturt8IDCz/uVZDHxd8tsLZkga
 +ozJ2OJh4YUnW3Y7B4L7Sd/zcW1nQkWXzIFIsTsbGG6OVMnlt6ARiT8toTEQ5lmA0mxu
 yjldyZAExFzQsMudz6kAnfoC4ZFGidCNqkTEjWqTzCwYRxkeKkBMtxmsbbmoscqx3av2
 EIcZxlQA/QmFIWESZmQf//mEzdtvh7/xpgzjv3CH3a4bgeScxCtQBoVjkIXY2W8y5d3J
 Iqpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoxoIeuELBSdXrh8Wc3woWWhlJ/kdG1+rQBlMZTcFhmPBoYaNxIAAg+OxN2J5KQF3sZjAH1Yss0xz0@nongnu.org
X-Gm-Message-State: AOJu0YySN9aFVktNvQ+cPwXLafh5OyNdNyex5JXEEIlErdrbYCl6uXwN
 TJPgD9OMljL/44FBfgqBxsfHeceF78QGz8mz9LGhQPml8FfA3uVEPseRGrpKJb+QcbESpwWQssy
 CShHXkslytW6/RyFd2aHmyIiA2ouOtNGz2yJ6prnLPO3zbsAoR3Dy
X-Received: by 2002:a05:6000:1567:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-3820810fdb5mr1653824f8f.14.1731407457288; 
 Tue, 12 Nov 2024 02:30:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt1xRF/ibbpecaA1gwnFRj6b3tKGiBxGA4KZNfn1ZqgVumzajk6B9GSuWFD3uJ1Yl0od7U4w==
X-Received: by 2002:a05:6000:1567:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-3820810fdb5mr1653787f8f.14.1731407456887; 
 Tue, 12 Nov 2024 02:30:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d?
 (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de.
 [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed987d33sm15293874f8f.43.2024.11.12.02.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 02:30:56 -0800 (PST)
Message-ID: <b4f07c74-4240-4b07-a8ce-7cd765d954e9@redhat.com>
Date: Tue, 12 Nov 2024 11:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] accel/kvm: Keep track of the HWPoisonPage page_size
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
 <20241107102126.2183152-1-william.roche@oracle.com>
 <20241107102126.2183152-2-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241107102126.2183152-2-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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

On 07.11.24 11:21, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> When a memory page is added to the hwpoison_page_list, include
> the page size information.  This size is the backend real page
> size. To better deal with hugepages, we create a single entry
> for the entire page.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
>   accel/kvm/kvm-all.c       |  8 +++++++-
>   include/exec/cpu-common.h |  1 +
>   system/physmem.c          | 13 +++++++++++++
>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 801cff16a5..6dd06f5edf 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1266,6 +1266,7 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
>    */
>   typedef struct HWPoisonPage {
>       ram_addr_t ram_addr;
> +    size_t     page_size;
>       QLIST_ENTRY(HWPoisonPage) list;
>   } HWPoisonPage;
>   
> @@ -1278,7 +1279,7 @@ static void kvm_unpoison_all(void *param)
>   
>       QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
>           QLIST_REMOVE(page, list);
> -        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
> +        qemu_ram_remap(page->ram_addr, page->page_size);
>           g_free(page);

I'm curious, can't we simply drop the size parameter from qemu_ram_remap()
completely and determine the page size internally from the RAMBlock that
we are looking up already?

This way, we avoid yet another lookup in qemu_ram_pagesize_from_addr(),
and can just handle it completely in qemu_ram_remap().

In particular, to be future proof, we should also align the offset down to
the pagesize.

I'm thinking about something like this:

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5..8a47aa7258 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1278,7 +1278,7 @@ static void kvm_unpoison_all(void *param)
  
      QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
          QLIST_REMOVE(page, list);
-        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
+        qemu_ram_remap(page->ram_addr);
          g_free(page);
      }
  }
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5..50a829d31f 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -67,7 +67,7 @@ typedef uintptr_t ram_addr_t;
  
  /* memory API */
  
-void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
+void qemu_ram_remap(ram_addr_t addr);
  /* This should not be used by devices.  */
  ram_addr_t qemu_ram_addr_from_host(void *ptr);
  ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr);
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..5f19bec089 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2167,10 +2167,10 @@ void qemu_ram_free(RAMBlock *block)
  }
  
  #ifndef _WIN32
-void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
+void qemu_ram_remap(ram_addr_t addr)
  {
      RAMBlock *block;
-    ram_addr_t offset;
+    ram_addr_t offset, length;
      int flags;
      void *area, *vaddr;
      int prot;
@@ -2178,6 +2178,10 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
      RAMBLOCK_FOREACH(block) {
          offset = addr - block->offset;
          if (offset < block->max_length) {
+            /* Respect the pagesize of our RAMBlock. */
+            offset = QEMU_ALIGN_DOWN(offset, qemu_ram_pagesize(block));
+            length = qemu_ram_pagesize(block);
+
              vaddr = ramblock_ptr(block, offset);
              if (block->flags & RAM_PREALLOC) {
                  ;
@@ -2206,6 +2210,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                  memory_try_enable_merging(vaddr, length);
                  qemu_ram_setup_dump(vaddr, length);
              }
+
+            break;
          }
      }
  }


-- 
Cheers,

David / dhildenb


