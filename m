Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A872CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBypH-0000WP-9S; Thu, 23 Oct 2025 13:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vBypG-0000W9-Fj
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vBypD-0007BV-R0
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761239405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sIho/DDzaUGECoEpXxSYe8QzakIm7oukB+I/Bz1nx2A=;
 b=ioLBWxy3PdV+XV51+1tWgQdZsPC24gDy5I4n9HLjEaIODmhNM5bcXWJj9MImkRoIqao0J9
 QKBsroeB/SiSh3IekpExLNdCVGzIxVHGPsUdRLsBWlRTlUfsJti1jo7BvJxF2IkXssCE2+
 LIInIzma3IznX8Kr8SOK5hbHqjl9nxk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-vGtIvjLGNvSDA7srlXXhVQ-1; Thu, 23 Oct 2025 13:10:03 -0400
X-MC-Unique: vGtIvjLGNvSDA7srlXXhVQ-1
X-Mimecast-MFC-AGG-ID: vGtIvjLGNvSDA7srlXXhVQ_1761239402
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4283bf5b764so794598f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 10:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761239402; x=1761844202;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sIho/DDzaUGECoEpXxSYe8QzakIm7oukB+I/Bz1nx2A=;
 b=LJVyoRxmOHWtb73Bct1DYLYwD3Ml4Fai39mq5VahFIiGt6icTL5h9A3bPUbrartekm
 x6vV9vcqAUAeOBwwsFFndcwqMRpz4QyDJobufLTOST5vsBpMAWUrGDgMSX60qzzWPE9g
 SINFOmV8pharDEvp9Rq0K0mGbO6RlsAja/cUQGlSYu8jk0bKsbI1+SQuhdUQkKj6tBm/
 zXVgDQdAck6GSqIMLcHNQtYaSdZBQ2Q3O4BLVGbEQaxk71s0avD810TBtNP/lkhJ+/5u
 6m/jJzeNkxgbAI2fQIFm2DhS8002CHBVlD1X72U1qvupUHXfElK5bkLLsRamzG02qp/k
 iUFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbR7cpCtCXUvBCFsKxbqKDca6utS9KBi0vcAstWarQtESEuRf2rKxXcrqpY749wpo/R+ht7Yy5mp41@nongnu.org
X-Gm-Message-State: AOJu0Yx3LR6ioufO9M89GJMUAZ+EkGN0JOKM9aH8qcGyJ/1Kpdbs9O93
 BRsKGCcwuol4p3lzIssR147Bo8u6SKL1srK31Co2AoAuyhyNa+mxSMr+OdC/5CwRaUpuKYFEHte
 W2WOqZYUL3GjE3OnQZvtX8NrSFufmrRoEhtUE2jm+j1CsY7273iBbB3Ws
X-Gm-Gg: ASbGncvx/ZZQMKxH53baFb1oV5Igyvj++MIpk8udH0xBo052lI9Ty0bCd8DRWhqq4n5
 7X8lfWlF8i15RK4+HtO0lhdKDW71MxErp5vk8n9b3ZvrM3AycCxKIsCFIyVIWY7+wwBXvG/K+Nb
 fsx4yJ9/croZDEiGOT0uHXm761hFVwYt8iGXre5YnM56QFhstzXfL6b+8bYL1ztSRdy95x2gglV
 JBZBlJmzhI1rqDrywNRvKMNtCkwLZiX+tsL54YmEm2G1OFubrqRegpLwALLxGJVSuN8CWBWEz1e
 A6uW/82hMo0kVvfPpTQSerl9+fgTyFRoR+hDmfxLuqsnbhiHwpFEBoaPDicCK1qtMJ2dKznoHAs
 iE9aJRVA1zzo96V7J8vryLd3JdUJWqsZpGQ3yf46/OWZ1vbwsND6zWsM0Rn+qXcm6uRoBMN/+g+
 PDwA==
X-Received: by 2002:a05:6000:2dc3:b0:426:d54d:224d with SMTP id
 ffacd0b85a97d-42704d7ebbamr21063042f8f.27.1761239401983; 
 Thu, 23 Oct 2025 10:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeBhshgveus83Fujm4tgQ2AjCJ8NaeUFWeh9Yb6sABVsAFvyZkwYO71LXFd/b8AbLwDNMtzw==
X-Received: by 2002:a05:6000:2dc3:b0:426:d54d:224d with SMTP id
 ffacd0b85a97d-42704d7ebbamr21063025f8f.27.1761239401614; 
 Thu, 23 Oct 2025 10:10:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-429897e763csm4959502f8f.6.2025.10.23.10.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 10:10:01 -0700 (PDT)
Message-ID: <8901c04b-6fb8-4964-a8dc-5a871d026a70@redhat.com>
Date: Thu, 23 Oct 2025 19:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM Planes with SVSM on Linux v6.17
To: Christoph Hellwig <hch@infradead.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>
Cc: coconut-svsm@lists.linux.dev, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Sean Christopherson <seanjc@google.com>, Thomas.Lendacky@amd.com,
 huibo.wang@amd.com, pankaj.gupta@amd.com
References: <wmymrx6xyc55p6dpa7yhfbxgcslqgucdjmyr7ep3mfesx4ssgq@qz5kskcrnnsg>
 <aPpE8emZ9n4N7S-T@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aPpE8emZ9n4N7S-T@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/25 17:08, Christoph Hellwig wrote:
> On Wed, Oct 22, 2025 at 10:35:28AM +0200, Jörg Rödel wrote:
>> Hi all,
>>
>> This morning I pushed out my current Linux and QEMU branches which support
>> running COCONUT-SVSM on AMD SEV-SNP based on kernel v6.17 and the original KVM
>> Planes patch-set from Paolo.
> 
> Can you explain what this alphabet-soup even means?

With pleasure :)

- SEV-SNP: virtualization feature to encrypt VM memory (SEV) and also 
protect from attacks from the hypervisor (SNP), by matching the 
hypervisor's page tables against a reverse page mapping (from host 
physical to guest physical address) maintained by processor firmware in 
collaboration with the guest

- VMPL (bonus): SNP feature to create privilege levels within a single 
VM, for example to manage persistent secrets.  The firmware at VMPL0 can 
hold secrets that even the guest OS at VMPL1+ cannot access.

- KVM planes: KVM feature to  create privilege levels within a single 
VM, including VMPLs

- SVSM (Secure VM Service Module): privileged firmware running at VMPL0

- COCONUT-SVSM: one implementation of SVSM

Paolo


