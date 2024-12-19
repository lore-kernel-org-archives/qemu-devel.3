Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564C3E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGT-0002rN-5i; Thu, 19 Dec 2024 11:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOFoa-0001oS-MB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOFoY-0005MV-O8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734611977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=59r7XP/SJhf6pxvDvtuLjCTjfOfzk08RQUnBdj1cK5M=;
 b=d2H4L2fbHsWZIqldIYNp1L+v/NekEQhJYH8u07KGVBL9defouk8mvmr38aNH8oItMm5OM5
 GaGBR70XjGKkOWMUlbEXKTpkni0zSdjuCPg6Evjt+8+0bYQeFi+8BS7bhA/34u2yiLuuAp
 QoJ5b128WAWSzqLRQKOzRicLw/xqy+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-x_hygihiMAy1lbgq12goCA-1; Thu, 19 Dec 2024 07:39:36 -0500
X-MC-Unique: x_hygihiMAy1lbgq12goCA-1
X-Mimecast-MFC-AGG-ID: x_hygihiMAy1lbgq12goCA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso6222335e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734611975; x=1735216775;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59r7XP/SJhf6pxvDvtuLjCTjfOfzk08RQUnBdj1cK5M=;
 b=bV5TX6BgXo3wbB++ML4PURk5/WGA4pkJRPpNBWnK6wCGjKJLOjKCzpjUU1r195qBrC
 V41yez0hGTkI5lqYS2IEeovz1OZoBHXZwXwB6ssRup5tmzZPz6+qLVmYocNMlZtlsgdF
 9/+drhbp9xencxX2e9TS0XmWjkV8gKhtsrUrjqfkzHFYOCpYZIEHZnrrhYsv/DP3VKHQ
 UJAZIfenfqbil8+A/Dl2UK1XG+Dda+f5WnVII6sp4NLF2c6X568R/nx65lp7bgFFcf4J
 ZE2PPh5+lmee6/XE48Y+5QlExGybJgnk6Mi+O73xPmeXI56ZcCIzQhM2oY7SmBGSLDtw
 lm7g==
X-Gm-Message-State: AOJu0YyBHh4EsBavrPTt2kFYKDhI9ouRaSh/JobpLRWNz0CewuD4kwIf
 PN5EOd2iptNoekCaKcCsb9M03zsMYD6AND7OhWGjeTiGXVMQD92seIP5K50Xr3QcdMdnUEuZl9z
 3CeKxxq1OA4r3lfVbh18xlU3DBuGQTUjYuVYjUnE4GVNQ+lfQlB9e
X-Gm-Gg: ASbGncsAPlXlWGLqjDVM3tfO8Ms03PvcMBJayM84Bc6jp4MF0oRnlazEoCgScxmXuH0
 D13FVo8MotHfhRwxrZMsQwmtw4Grp1InGZdQS2OXdvtNrOS0T7s39043jDG7boKtvWQT27LLL92
 t4fWe8v7QHxiIpkt2w/EJ1O/d6Dzyr6vahm0XwuWcAvOeAazO1sCQhf7SRyNzATXAsdwpZ1tEpW
 q9L/ANNYJRy/BCakexP4T6oI1F57ohMZ6zan0wc2FDyFpxFcOKJ9OAu2Zx3hxfBGOAqN6hq3oJE
 d4OHvdXsuj4UZi38NTd16Q0gOZdD/afyxLSnWYNg9UH/kYqyIrdZIlbIMrme4Ehtmc//KXkBEUS
 f3ZmWxg==
X-Received: by 2002:a05:600c:450a:b0:434:f4f9:8104 with SMTP id
 5b1f17b1804b1-43655428a0bmr54449055e9.33.1734611975108; 
 Thu, 19 Dec 2024 04:39:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjQJH2Xu8yfM5YNoZfem/fUqjGeAXTA67E2WjrxjFkCYRPk2orACbPTn5ngY2GfmGQ/NFyCg==
X-Received: by 2002:a05:600c:450a:b0:434:f4f9:8104 with SMTP id
 5b1f17b1804b1-43655428a0bmr54448805e9.33.1734611974724; 
 Thu, 19 Dec 2024 04:39:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686?
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119b6sm52376225e9.22.2024.12.19.04.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 04:39:33 -0800 (PST)
Message-ID: <97e89fe6-d2f9-4e48-b284-4593d07bcd68@redhat.com>
Date: Thu, 19 Dec 2024 13:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Host Memory Backends and Memory devices queue
 2024-12-18
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
 <CAJSP0QUoerckBWX=0PD_82jFwVbmtvftWf5QqSWxpK0Ttc+uvQ@mail.gmail.com>
 <2e6400d9-6fee-41ed-a317-329f275912c6@redhat.com>
 <d19ab3d3-737d-4faa-a7d7-639b4ea3b172@redhat.com>
 <ed949070-bb79-4357-b379-9374c40433bc@linux.ibm.com>
 <728b07ae-17aa-49ca-967f-a35d62f8cc32@redhat.com>
 <ed0d71d2-8ea0-4d3d-8458-774f7fcb479f@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ed0d71d2-8ea0-4d3d-8458-774f7fcb479f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 19.12.24 13:20, Thomas Huth wrote:
> On 19/12/2024 12.57, David Hildenbrand wrote:
>> On 19.12.24 12:43, Christian Borntraeger wrote:
>>> Am 19.12.24 um 12:18 schrieb David Hildenbrand:
>>>> The following on top seems to make everything happy. I wish the
>>>> CONFIG_S390_CCW_VIRTIO stuff would't have to be so complicated, just to
>>>> handle odd configs that don't really make sense.
>>>
>>> WOuld it be possible to rid of this config?
>>
>> I was asking myself the same: when does it make sense to build for s390x
>> system without CONFIG_S390_CCW_VIRTIO. But other archs that also have a
>> single machine seem to be doing the same thing.
>>
>> We wouldn't want to have the option to disable it, but "bool" gives you the
>> option to do that.
> 
> Since a while, (almost) all targets can be compiled without any machine
> except for the "none" machine, so I think we should not diverge in the s390x
> just for the sake of it.

Well, okay, although such a qemu-system-s390x is of questionable use. :)

At least hypercalls/skeys/stattrib only applies to the CONFIG_S390_CCW_VIRTIO
machine, so maybe more files can be moved under CONFIG_S390_CCW_VIRTIO later.

Anyhow, sounds like a bigger cleanup. The following on top seems to
make gitlab CI happy, without messing with config options:


diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 094435cd3b..3bbebfd817 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -12,7 +12,6 @@ s390x_ss.add(files(
    's390-pci-inst.c',
    's390-skeys.c',
    's390-stattrib.c',
-  's390-hypercall.c',
    'sclp.c',
    'sclpcpu.c',
    'sclpquiesce.c',
@@ -28,7 +27,10 @@ s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
  s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
    'tod-tcg.c',
  ))
-s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
+s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
+  's390-virtio-ccw.c',
+  's390-hypercall.c',
+))
  s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
  s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
  
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 248566f8dc..097ec78826 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -127,7 +127,7 @@ static void subsystem_reset(void)
  static void s390_set_memory_limit(S390CcwMachineState *s390ms,
                                    uint64_t new_limit)
  {
-    uint64_t hw_limit;
+    uint64_t hw_limit = 0;
      int ret = 0;
  
      assert(!s390ms->memory_limit && new_limit);
@@ -145,13 +145,6 @@ static void s390_set_memory_limit(S390CcwMachineState *s390ms,
      s390ms->memory_limit = new_limit;
  }
  
-uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
-{
-    /* We expect to be called only after the limit was set. */
-    assert(s390ms->memory_limit);
-    return s390ms->memory_limit;
-}
-
  static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
                                    uint64_t pagesize)
  {
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 5a730f5d07..599740a998 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -35,7 +35,12 @@ struct S390CcwMachineState {
      SCLPDevice *sclp;
  };
  
-uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms);
+static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
+{
+    /* We expect to be called only after the limit was set. */
+    assert(s390ms->memory_limit);
+    return s390ms->memory_limit;
+}
  
  #define S390_PTF_REASON_NONE (0x00 << 8)
  #define S390_PTF_REASON_DONE (0x01 << 8)
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 3732d79185..8002b1e2d0 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -43,6 +43,7 @@
  #include "hw/s390x/s390-pci-inst.h"
  #include "hw/boards.h"
  #include "hw/s390x/tod.h"
+#include CONFIG_DEVICES
  #endif
  
  /* #define DEBUG_HELPER */
@@ -117,12 +118,14 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
  
      switch (num) {
+#ifdef CONFIG_S390_CCW_VIRTIO
      case 0x500:
          /* QEMU/KVM hypercall */
          bql_lock();
          handle_diag_500(env_archcpu(env), GETPC());
          bql_unlock();
          r = 0;
          break;
+#endif /* CONFIG_S390_CCW_VIRTIO */
      case 0x44:
          /* yield */
          r = 0;

-- 
Cheers,

David / dhildenb


