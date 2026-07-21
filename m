Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87FDC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 05:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm3BL-0007Iz-Pe; Tue, 21 Jul 2026 01:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wm3BF-0007Hz-BD
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 01:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wm3BA-0004S3-BA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 01:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784612286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDQgbWjPhObyv4PmR2GPuEBf2QWmtRpPo5OKrp5L04Y=;
 b=Almw+mhOi3MSZk2tRlY7km1JPnODxCeTzSvZHb9v1fN50uknwKm9soumUlYs7Xy/hoN9eW
 /4nSUGfp2oLOpl4cBNb5iWYvuisJyrdDgQupDF0KF5yNaX74l5VSQ6YJrPxZo8Czcz1/Uv
 AajJIpMznO3P7ys8tOz0i4jy7kXzEno=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-qlbVc7bOP32ixTNYtMY4lQ-1; Tue, 21 Jul 2026 01:38:04 -0400
X-MC-Unique: qlbVc7bOP32ixTNYtMY4lQ-1
X-Mimecast-MFC-AGG-ID: qlbVc7bOP32ixTNYtMY4lQ_1784612284
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cca3673560so192100225ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784612283; x=1785217083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RDQgbWjPhObyv4PmR2GPuEBf2QWmtRpPo5OKrp5L04Y=;
 b=gT5tH6LPY5++JJ3/9snn+s4ROGevaJipOP/gSfX2RmeO6Qec9dbPwAhWOBXEkzwpT3
 READZhjwgU+aeY3wLNmYIFU2D813avKsvaOFWnYOKRI3fVcXPNq70sjYVbWMZfufa1h4
 UjZUOvyqTEjZIOUT+HGmIm/D+wYXdcqHbsTM9kiJYZfLNNeNd0ix8HaYfBKPwz3Qznwn
 PjpeOS9Vsf1pY89KvfdO8rpQUkCKG7IX69uD081rqjnIHmk+rk/VsEke9H3uQ1EqF/Ih
 vyR+XO0ak8NIu8QKCtyhBmTBTcTYEQl/rZ/V+WOrlw+BUlFZVnZSBXKRNq3UBAdtZ66Y
 29NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784612283; x=1785217083;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RDQgbWjPhObyv4PmR2GPuEBf2QWmtRpPo5OKrp5L04Y=;
 b=IG/7rI/13rH7EeNVCVIyJTm7ocgIKVojwc7oAWWmgE8Q4HcMF4RC0sOzgq6FzH1SBS
 gI01j5DFJvjCw7yUpbixH0yETyM0LdC1jqTPedgFv0CD3M+WceCsQIaDNLdFcbkgeDIs
 zH1p+7SFqJ0xvXd0+DjvulABiPWH0Oo9aXhDDVHoi5QAoHgGAZf4WcPrLD8LsUxgUd+b
 NMDieiH20yBaEe5vhniARDo+RHgDwcfE9HnbLhWHw9nJvhB5846rShmEaVScuZ6NzstW
 ii+j4KYDwQ9p9io2m4mSFqdWB+FPlUkNoHz68fPJ1ZSXp1wj92k2wiZFUReW4CCFyg6g
 yL8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrazqcV5coK0jxKdaCBGNvDUVG2HLYWf+QmWGcH9wl2TvxCxbRdbVHPosOuwnA3pLWOHR8BqESGJ204@nongnu.org
X-Gm-Message-State: AOJu0YzTBhVDgFJcB6jeSG93L95Nkd+pXWP5sIkgYYEitB1grmpD6sin
 UXCXOV6rdz5fcELMTgOKXvdTloF+B36TR4OWSY2MrHMdcE0vyzpniA+M1e4WBqm90aRcuqZfWx2
 XASgRU1pzj4JsAUVouM5jFwd5tFksNJjVcEaTcBCe+EmvycZfOMGMOcRq
X-Gm-Gg: AR+sD11MYEBU7Eo/7H50icrklJkhboP4Qaoid6wxl4tGOYp0CPcy1e7L5JXrvJCCXGR
 K4O1Q06yAJRt+gXH8zjqCb8rTFaCyQu6DxGlQEBsuoyPO4vftmeQt2+bDPO4mSuY9B7lQE+EaXE
 L/peXGdaWWISW80jaanFMM+8O/CHf9dpdfgvIgbE8tPxbnCxjuh63KtZALrxE46nhgVTR3fQrOJ
 Szau9eb18+yMgkZV/fkIlKbJ+27muZ8mKeNh+ZS/f2I3yu2Io8dVIjanGx3G1kJFz0cI+VfdHwf
 9gb0qRM+1Ln8K0VO+SxBQ+gw55BKmjZJTZ9G+9HWqMH6fjKnFc0/dHixSAXvDMK7eCaqU18Y3LW
 Zw2ecJjKJ1ovPltM2z02tmE/HxzfjB3Ky7QdsaGZURGM=
X-Received: by 2002:a17:903:2c47:b0:2c9:cf41:adf9 with SMTP id
 d9443c01a7336-2cf34a822c8mr181831335ad.47.1784612283549; 
 Mon, 20 Jul 2026 22:38:03 -0700 (PDT)
X-Received: by 2002:a17:903:2c47:b0:2c9:cf41:adf9 with SMTP id
 d9443c01a7336-2cf34a822c8mr181831065ad.47.1784612283062; 
 Mon, 20 Jul 2026 22:38:03 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf345111d5sm68144975ad.37.2026.07.20.22.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 22:38:02 -0700 (PDT)
Message-ID: <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
Date: Tue, 21 Jul 2026 15:37:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
 <20260625101817-mutt-send-email-mst@kernel.org>
 <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
 <20260625123119-mutt-send-email-mst@kernel.org>
 <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
 <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
 <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
 <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
 <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/20/26 7:12 PM, Philippe Mathieu-Daudé wrote:
> On 17/7/26 15:55, Michael S. Tsirkin wrote:
>> On Fri, Jul 17, 2026 at 02:49:53PM +0100, Peter Maydell wrote:
>>> On Fri, 17 Jul 2026 at 14:24, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>> On Thu, Jul 09, 2026 at 07:52:12PM +1000, Gavin Shan wrote:
>>>>> Could you help to confirm if the conclusion is to have unified qemu_ram_{copy, move}()
>>>>> for all architectures? In qemu_ram_{copy, move}(), the fixed sized accesses like
>>>>> 1/2/4/8 bytes are handled by __builtin_{memcpy, memmove}() and fall back to
>>>>> memcpy/memmove() for other sized accesses. It's basically what was proposed by
>>>>> Michael :-)
>>>>
>>>> No. __builtin_ and  memcpy/memmove are same on modern linuxes.
>>>>
>>>> I'd say as a 1st step, on x86 hosts we can do a fixed size
>>>> memmove for 1/2/4/8, on other hosts
>>>> *aligned* 1/2/4/8 bytes can do
>>>>   __atomic_store ... __ATOMIC_RELAXED
>>>> and the rest can hobble along on memmove
>>>> and hope for the best.
>>>
>>> I don't think we should be doing something that's x86-host specific,
>>> as I've mentioned previously.
>>>
>>> -- PMM
>>
>> Shrug. Of course we already have arch specific code in asm.
>> But we can make the unaligned 1/2/4/8 for x86 host a separate
>> optimization on top. They are unlikely to be common.
> 
> Note we have include/qemu/host-pci-mmio.h with s390x specific
> optimizations in util/s390x_pci_mmio.c ...
> 

Philippe, Thanks for pointing it out that s390x already had private PCI
MMIO accessors.

If Peter is fine with two variants for x86 and non-x86 architectures.
I can post (v4) for further review. That will be something like below
and let me know if there are any other improvements are needed.

----- include/system/memory.h

+/**
+ * qemu_ram_copy: copy data to ramblock
+ *
+ * @dst: destination where the data is copied to
+ * @src: source where the data is copied from
+ * @n: length of data to be copied
+ *
+ * Copy @n bytes from @src to @dst with the assumption that @src and @dst
+ * do not overlap. For x86, the fixed sized accesses like 1/2/4/8 bytes are
+ * handled by __builtin_memcpy() no matter whether @src or @dst is aligned
+ * to the access size, and fall back to memcpy() for other access sizes. For
+ * other architectures, data is copied from @src to @dst in units of 1/2/4/8
+ * bytes, ensuring proper alignment in each unit and order among the units.
+ */
+void qemu_ram_copy(void *dest, const void *src, size_t n);
+
+/**
+ * qemu_ram_move: move data to ramblock
+ *
+ * @dst: destination where the data is moved to
+ * @src: source where the data is moved from
+ * @n: length of data to be moved
+ *
+ * Move @n bytes from @src to @dst with the assumption that @src and @dst
+ * can overlap. For x86, the fixed sized accesses like 1/2/4/8 bytes are
+ * handled by __builtin_memmove() no matter whether @src or @dst is aligned
+ * to the access size, and fall back to memmove() for other access sizes.
+ * For other architectures, data is moved from @src to @dst in units of
+ * 1/2/4/8 bytes, ensuring proper alignment in each unit and order among
+ * the units.
+ */
+void qemu_ram_move(void *dest, const void *src, size_t n);
+

----- system/physmem.c

+static void qemu_ram_unsafe_copy(void *dst, const void *src, size_t n)
+{
+    switch (n) {
+    case 1:
+        __builtin_memcpy(dst, src, 1);
+        break;
+    case 2:
+        __builtin_memcpy(dst, src, 2);
+        break;
+    case 4:
+        __builtin_memcpy(dst, src, 4);
+        break;
+    case 8:
+        __builtin_memcpy(dst, src, 8);
+        break;
+    default:
+        memcpy(dst, src, n);
+    }
+}
+
+static void qemu_ram_unsafe_move(void *dst, const void *src, size_t n)
+{
+    switch (n) {
+    case 1:
+        __builtin_memmove(dst, src, 1);
+        break;
+    case 2:
+        __builtin_memmove(dst, src, 2);
+        break;
+    case 4:
+        __builtin_memmove(dst, src, 4);
+        break;
+    case 8:
+        __builtin_memmove(dst, src, 8);
+        break;
+    default:
+        memmove(dst, src, n);
+    }
+}
+
+static void qemu_ram_safe_copy(void *dst, const void *src,
+                               size_t n, size_t max_step)
+{
+    uintptr_t test, step;
+
+    /* Aligned maximal step */
+    max_step = pow2floor(max_step);
+
+    while (n) {
+        test = (uintptr_t)src | (uintptr_t)dst | n | max_step;
+        step = test & -test;
+
+        switch (step) {
+        case 1:
+            qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
+            src += 1;
+            dst += 1;
+            n -= 1;
+            break;
+        case 2:
+            qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
+            src += 2;
+            dst += 2;
+            n -= 2;
+            break;
+        case 4:
+            qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
+            src += 4;
+            dst += 4;
+            n -= 4;
+            break;
+        case 8:
+        default:
+            qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
+            src += 8;
+            dst += 8;
+            n -= 8;
+        }
+    }
+}
+
+static void qemu_ram_safe_copy_backwards(void *dst, const void *src,
+                                         size_t n, size_t max_step)
+{
+    uintptr_t test, step;
+
+    /* Aligned maximal step */
+    max_step = pow2floor(max_step);
+
+    /* End of the blocks */
+    src += n;
+    dst += n;
+
+    while (n) {
+        test = (uintptr_t)src | (uintptr_t)dst | n | max_step;
+        step = test & -test;
+
+        switch (step) {
+        case 1:
+            src -= 1;
+            dst -= 1;
+            n -= 1;
+            qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
+            break;
+        case 2:
+            src -= 2;
+            dst -= 2;
+            n -= 2;
+            qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
+            break;
+        case 4:
+            src -= 4;
+            dst -= 4;
+            n -= 4;
+            qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
+            break;
+        case 8:
+        default:
+            src -= 8;
+            dst -= 8;
+            n -= 8;
+            qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
+        }
+    }
+}
+
+/* x86 should work with __builtin_{memcpy, memmove}() for IO access */
+#if defined(__i386__) || defined(__x86_64__)
+#define HOST_UNALIGNED_VECTOR_MMIO_OK 1
+#else
+#define HOST_UNALIGNED_VECTOR_MMIO_OK 0
+#endif
+
+void qemu_ram_copy(void *dst, const void *src, size_t n)
+{
+    if (src == dst || n == 0) {
+        return;
+    }
+
+    if (HOST_UNALIGNED_VECTOR_MMIO_OK) {
+        qemu_ram_unsafe_copy(dst, src, n);
+    } else {
+        qemu_ram_safe_copy(dst, src, n, 8);
+    }
+}
+void qemu_ram_move(void *dst, const void *src, size_t n)
+{
+    if (src == dst || n == 0) {
+        return;
+    }
+
+    if (HOST_UNALIGNED_VECTOR_MMIO_OK) {
+        qemu_ram_unsafe_move(dst, src, n);
+    } else if (dst < src) {
+        qemu_ram_safe_copy(dst, src, n, src - dst);
+    } else {
+        qemu_ram_safe_copy_backwards(dst, src, n, dst - src);
+    }
+}


Thanks,
Gavin




