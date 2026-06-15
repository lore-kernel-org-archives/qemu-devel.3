Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9112CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCvI-0006p8-PS; Mon, 15 Jun 2026 15:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZCvG-0006oq-JU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZCvC-0006Tg-JD
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781551470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZzpTXpiVODTokgT66ACZhUP75ufDlkECia3bOTZQeI=;
 b=I/Z8gdETwXVpk1fWJh90uKweEqc+WwCtpInbKAYu790R/XSuyEEMiJ7KHpOFI2WW7cdiEc
 WpNJzZXnIT6o+hFGPY7XKGkR69mhps4graJZb0ASlW6fnbbz2pKvf57nTzDDsD0r0eMi26
 6pQDsS3+qLmuIITdtxynH2SxWMf6y0g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-B10phi03ODyfx2EiVd2LGA-1; Mon, 15 Jun 2026 15:24:26 -0400
X-MC-Unique: B10phi03ODyfx2EiVd2LGA-1
X-Mimecast-MFC-AGG-ID: B10phi03ODyfx2EiVd2LGA_1781551466
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so2831743a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781551466; x=1782156266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AZzpTXpiVODTokgT66ACZhUP75ufDlkECia3bOTZQeI=;
 b=GdG4gB09VrJiQsAmSIWnzZ4ymQyMEtXH6/mOQ3LUIpGZ9FHr31t0/mm0dfXKf3CHjb
 4WW33Z0P/iNq217qH55+tQd6C/tPH6J1GCgVNxnebSj+X8t9njZw2OQ5nB0kaqIWsW3k
 CSlQLDa+G+7AlKnbeTlutzAHg+cn8R78ybvYGWXC9V3DWar1EMOSy0UAI/eUTfOndTOj
 9Z0wlQqo9jWUrvDwam9T6/Igb+2spwF9orDFRoOIpFshwD3CxNSvp+BbmYfLFcRJLZkK
 C5yYUkfJEZyvInHuUESZu3/mMN+/APS3nLdvsukal3NQztJNKPiKz+JOAk3kegj59d7K
 zYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551466; x=1782156266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZzpTXpiVODTokgT66ACZhUP75ufDlkECia3bOTZQeI=;
 b=YBfsJIJwiVSzxhoxQItgl7jQ2Ob6TcSYb5rmowLpPfhWD7deRtoUol1JY3YTtNt8uy
 sDCA3YEjrsA0DcYV6AyuPEGIudFa6FOfMeAIrzyaJhHS3bom+5s0akuJd5BFqtJdl2t9
 0zwQsh7tSt8esmptkiPJGAXdj4pLa4JSLfs56PUtCKxWf2EEZITgQFEwWfE+5OCsZ69v
 niK14WR536dfFtsqv8taHBxlT0MpkEc45xbqWUvO4+Vm07luS3+mYY6VPY4QAMhh0sgc
 jRQBgrOq0x8eQW8nAblvcyb646HWoPLcHUWgODxOd5Norskl3dNFvfNu0h91RmJO/FVc
 E5KA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oo6yRrEJGKGyTEge4yOxhhu4ZURLTpsK76dHx+fIYZ57MmezT0CE+zs/BAuLAIwXODwcUNc7h45+T@nongnu.org
X-Gm-Message-State: AOJu0YzenqMM7k1+TfYEbyRwOIqOyBsTzyAOzvpPgfhfKrcnj9HXsEZx
 g5ft/5UqGwKC4csZIUzSchjj1aOx8Kf5cQ6dCyx210Kj/auNCtgqJp3KzYwPiAqWiRX+3p6cVCQ
 dNGLrnReunOy2Sk4dFrjYcLlXXMTNBH+aCM5T3KYgQU/PZSpFMSDmNY3M
X-Gm-Gg: Acq92OFLECeVH8l/Q5mibfZ0c15V9FH4VAK9WLUfB+XmzeCqSnnEI6ZfVNyzTS2vjxZ
 zqOvvNEvzbQ/MZjqpD6PWK4r/YxIxaiGED8dtG8BgnFrnGeUb4j6C1bp5BJKsQxeFEcn+40fcbf
 xRbnZVbbJPHxcNnsKM/E0dDHUR3pGqELyNPBUm26y4C1vkxTsFk6pdTEK9IWofJce8SByvRZkkn
 rDoSIOzLvrYQJdGGyI+Q6w9O/Q0kYeJL2RQHx8kGftTmD8RYOPmZoyG4y0Q2lci7XooUY1lA2NV
 8L0g87i1uQj4VOJ2gyp88uwjjeL9t1CfizsKtb+hc/9IK4A5Xb8unLgKBfpuHH3S4Fo2aAVCtI1
 vFwaa+sH9pGBiUIMfBNUDaX5r2lP11Is9XtGbwZh374yY9KsWADXUfizdhD2ogmt9
X-Received: by 2002:a17:90b:134c:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-37c5291649cmr595501a91.20.1781551465645; 
 Mon, 15 Jun 2026 12:24:25 -0700 (PDT)
X-Received: by 2002:a17:90b:134c:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-37c5291649cmr595474a91.20.1781551465154; 
 Mon, 15 Jun 2026 12:24:25 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5228eb67sm382824a91.9.2026.06.15.12.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 12:24:24 -0700 (PDT)
Message-ID: <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
Date: Tue, 16 Jun 2026 05:24:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Peter and Michael,

On 6/16/26 1:12 AM, Peter Maydell wrote:
> On Mon, 15 Jun 2026 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
>>> On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
>>>>
>>>> All ram device regions were turned to be indirectly accessible by commit
>>>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>>>> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
>>>> guest is started by the following command lines, with GH100 GPU card passed
>>>> from the host.
>>>
>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>> index 1417132f6d..5878727d09 100644
>>>> --- a/include/system/memory.h
>>>> +++ b/include/system/memory.h
>>>> @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
>>>>   void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>>>>
>>>>   /* Internal functions, part of the implementation of address_space_read.  */
>>>> +void qemu_ram_copy(void *dest, const void *src, size_t n);
>>>> +void qemu_ram_move(void *dest, const void *src, size_t n);
>>>
>>> New function prototypes in include headers need documentation comments.
>>>
>>> In particular for these, it's really important that we clearly say
>>> what semantics we are attempting to provide with them, so that
>>> (a) when we're reviewing or later updating the implementation we
>>> know what we are trying to provide
>>> (b) when we're looking at the callsites we know what the function
>>> is guaranteeing to us and what it is not, and thus whether it's
>>> OK to use it or we need something els.
>>>
>>>> +#if defined(__i386__) || defined(__x86_64__)
>>>> +#define HOST_UNALIGNED_MMIO_OK 1
>>>> +#else
>>>> +#define HOST_UNALIGNED_MMIO_OK 0
>>>> +#endif
>>>
>>> We need to do something better than this. We can't
>>> just say "oh, we trust that on x86 this works": it is
>>> neither actually true that the compiler guarantees it
>>
>> sorry guarantee what?
> 
> Well, that's part of my point about "we need a doc comment":
> what exactly are we trying to guarantee ? But whatever it is,
> "hardcoded ifdef that privileges x86" is definitely the wrong
> answer.
> 

Could you please check the following comments (documentation context) for the
added functions look good to you? Please let me know if there are anything
can be improved.

+
+/**
+ * qemu_ram_copy: copy data to a RAMBlock
+ *
+ * @dest: destination where the data is copied to. It's the pointer returned
+ *        by ramblock_ptr() and its variants.
+ * @src: source where the data is copied from. It can be a regular memory block
+ *       or a pointer returned by ramblock_ptr() and its variants.
+ * @n: length of data to be copied
+ *
+ * The destination is always a pointer to data area of a RAMBlock which can
+ * be for a regular memory block or a MMIO region. The source can be a pointer
+ * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
+ * memcpy() to copy data between those MMIO regions as we do in this function.
+ * Besides, unaligned accesses are well handled on all architectures except
+ * i386 and x86_64 where the unaligned accesses are supported by the CPUs.
+ *
+ * The ensured atomicity and alignment consideration, which aren't needed
+ * by data copy between two regular memory blocks. So performance penalty
+ * is introduced by this function in such circumstance.
+ */
+void qemu_ram_copy(void *dest, const void *src, size_t n);
+
+/**
+ * qemu_ram_move: move data to a RAMBlock
+ *
+ * @dest: destination where the data is moved to. It's the pointer returned
+ *        by ramblock_ptr() and its variants.
+ * @src: source where the data is moved from. It can be a regular memory block
+ *       or a pointer returned by ramblock_ptr() and its variants.
+ * @n: length of data to be moved
+ *
+ * The destination is always a pointer to data area of a RAMBlock which can
+ * be for a regular memory block or a MMIO region. The source can be a pointer
+ * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
+ * memmove() to move data from or to those MMIO regions as we do in this
+ * function. Besides, unaligned accesses are well handled on all architectures
+ * except i386 and x86_64 where the unaligned accesses are supported by the
+ * CPUs.
+ *
+ * The ensured atomicity and alignment consideration, which aren't needed
+ * by data movement between two regular memory blocks. So performance penalty
+ * is introduced by this function in such circumstance.
+ */
+void qemu_ram_move(void *dest, const void *src, size_t n);
+

> -- PMM
> 

Thanks,
Gavin


