Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A93FD3B9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxrG-0005iU-Lo; Tue, 26 Nov 2024 10:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFxrD-0005iH-94
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tFxrA-0004Zv-PL
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732636323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3TSy9SAAhn/qbEK9idN7sqIwc7DNNwBC1JL+kwsdmrI=;
 b=Ywsr+Dv1V7CFdykusZd0lpnF0GTdolDsLPcGgHXdb2VhbzcJIwV1ieAM6JqxJ/SKSU145K
 lKh0BYx3XehpFsCAiPm/xnbFxiJG7zJOBPDp75zZYlbZDjdmxmHqmCTQs3YOCQ5j86PoH8
 4Nez1ejDgAiAcjJzcRnBPmBK4nMvgXM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-RBUH1kcCOMOWCud6lmobWw-1; Tue, 26 Nov 2024 10:52:00 -0500
X-MC-Unique: RBUH1kcCOMOWCud6lmobWw-1
X-Mimecast-MFC-AGG-ID: RBUH1kcCOMOWCud6lmobWw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43499c1342aso21705345e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 07:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732636319; x=1733241119;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3TSy9SAAhn/qbEK9idN7sqIwc7DNNwBC1JL+kwsdmrI=;
 b=ClQHcm9qa7oC97/wq1JfhcgxvteqgWKViUictdhUSDugInllyxqwmmXYD3ovg+azUz
 HQ7yzKsoAp/HKLRXMfWroKxrk20PLBVuqu4FL2SOQ+kqVXC+lQHv+JXpu6/FYxm4pBDK
 FlvWxr1hF3kzUHNCH/s+xcC11afdiJGAWMXdH/Xzg4jGYcr+WBY4uTiLbF86wfbfga4m
 Nb6/FmvLHnqQCeb/6eV5I6chqOxdW7jioSSLes9SF/uIdr83dbmlZw6etvr7wkkiUM91
 IAB1dEBY65bLNKAyCFauUuF5P+lRntti7v8tbv1ia7X7hY7QUCJSLgI0ttjd5Q+hd3TC
 j1VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0RhJFrJJ8PbK8wcDG5W4r9sRRb+nw5rT8Ym+SiDxWDVyd2SC8H0xI8m8JklQrsQWz222fsMm2P4c2@nongnu.org
X-Gm-Message-State: AOJu0Ywe4QDk0SocWwe2P74EuN1ETbM7GEs5yn+3VSBTMmNO85urNyDL
 G0AL0gQYt3FB9R5nIuOZ9FtQ+4hrh1iiZ9JbePXd6meHdGdtcMFde8PIDcuTRyTVIItEOiyxb7c
 hMiCWf7Hl9gdda5eRjO2qmcxTqGgjIl851zyq1IfWIN/0CfYtmiG6
X-Gm-Gg: ASbGncu2l+POG9yzxhh8bnxEIXYlvxWQQYD/QS84dpI28aWMRdZfel5LxH57CKaT9Gg
 dTE6Q7GOOVGR3HugInHBChn1QseTrnisxml8Og6w3aJXWTPaMHutfRRnc14cMxpjRYS1CeLnFa/
 hEcQUzeYX9ncWuyMqN+lCnkHi+tywEJ3mdPOQTr9KHp8h7sggqnPmBl50IBS9xAnqsg2+XW73t9
 aq0fPD6dQlIkZhdjqfbuzGUiJEX7lzUWzu8/eMYpD+Vrwld0pvugiIp8dpaqrLeG30dYIgkJ62O
 zOY=
X-Received: by 2002:a5d:6d03:0:b0:382:4d54:2cde with SMTP id
 ffacd0b85a97d-38260bcb33emr14601637f8f.37.1732636318906; 
 Tue, 26 Nov 2024 07:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/ongt6JLjNkDTGPCyoNkiSZmqLr3Y0SRfi0ahtu4NXjn37zuSsL/0inAA1RhUiRzYYRhytg==
X-Received: by 2002:a5d:6d03:0:b0:382:4d54:2cde with SMTP id
 ffacd0b85a97d-38260bcb33emr14601623f8f.37.1732636318581; 
 Tue, 26 Nov 2024 07:51:58 -0800 (PST)
Received: from [192.168.3.141] (p4ff23d2a.dip0.t-ipconnect.de. [79.242.61.42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6441sm13993003f8f.4.2024.11.26.07.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 07:51:57 -0800 (PST)
Message-ID: <9eafe8fa-de09-40e3-9687-573255ce37de@redhat.com>
Date: Tue, 26 Nov 2024 16:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: Wei Chen <weichenforschung@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Zhi Zhang <zzhangphd@gmail.com>
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
 <93616a1e-3614-49ca-9515-697f1c9205b6@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <93616a1e-3614-49ca-9515-697f1c9205b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26.11.24 16:31, Wei Chen wrote:
>   > How can you be sure (IOW trigger) that the system will store
>   > "important data" like EPTs?
> 
> We cannot, but we have designed the attack (see below) to improve the
> possibility.
> 
>   > So is one magic bit really that for your experiments, one needs a
>   > viommu?
> 
> Admittedly the way we accomplish a VM escape is a bit arcane.

That's what I imagined :)

> 
> We require device passthrough because it pins the VM's memory down and
> converts them to MIGRATE_UNMOVABLE. 

Interesting, that's news to me. Can you share where GUP in the kernel 
would do that?

> Hotplugged memory will also be
> converted to MIGRATE_UNMOVABLE. 

But that's in the VM? Because we don't hotplug memory in the hypervisor.

That way when we give memory back to the
> hypervisor, they stay UNMOVABLE. Otherwise we will have to convert the
> pages to UNMOVABLE or exhaust ALL MIGRATE_MOVALE pages, both of which
> cannot be easily accomplished.
> 
> Then we require vIOMMU because vIOMMU mappings, much like EPTEs, use
> MIGRATE_UNMOVABLE pages as well. By spawning lots of meaningless vIOMMU
> entries, we exhaust UNMOVABLE page blocks of lower orders (<9). Next
> time KVM tries to allocate pages to store EPTEs, the kernel has to split
> an order-9 page block, which is exactly the size of a 2MB sub-block.
> 

Ah, so you also need a THP in the hypervisor I assume.

>   > Out of curiosity, are newer CPUs no longer affected?
> 
> When qemu pins down the VM's memory, it also establishes every possible
> mapping to the VM's memory in the EPT.
> 
> To spawn new EPTEs, we exploit KVM's fix to the iTLB multihit bug.
> Basically, we execute a bunch of no-op functions, and KVM will have to
> split hugepages into 4KB pages. This process creates a large number of
> EPTEs.
> 
> The iTLB multihit bug roughly speaking is only present on non-Atom Intel
> CPUs manufactured before 2020.

Interesting, thanks!

> 
>   > So it won't be sufficient to have a single sub-block plugged and then
>   > trigger VIRTIO_MEM_REQ_UNPLUG_ALL?
> 
> Could work in theory, but if the newly plugged sub-block does not
> contain vulnerable pages, there is no promise that the attacker would
> get a sub-block containing a different set of pages next time.

Right.

-- 
Cheers,

David / dhildenb


