Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A482D2F34B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfi7u-0000fE-G3; Tue, 13 Jan 2026 12:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfi7m-0000XL-2R
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:24:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfi7k-0000Gu-BD
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768325046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vU5T2lph0Yn2HPeiVquBdQ09HdZWt0B/c6yMKdHSyvg=;
 b=FkvupiZQFx8gAVV+l5AgFFjXh/X8P5VsDk00S91HvuJcrBM1e5GanFpzlmz9IcB5EOfoS7
 +sFiGndnICn0N/TFIpmVNTKv4RLHuJRBbam9ZzTDarPgo8qkgSRb9U/3Vl2Nz65r2D4Hrh
 5yrkayoHvQvLKNhykgfW1z6JIktdnnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-LHvco2FRM_ebYNpAOhCvzQ-1; Tue, 13 Jan 2026 12:24:05 -0500
X-MC-Unique: LHvco2FRM_ebYNpAOhCvzQ-1
X-Mimecast-MFC-AGG-ID: LHvco2FRM_ebYNpAOhCvzQ_1768325044
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso4801228f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 09:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768325044; x=1768929844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vU5T2lph0Yn2HPeiVquBdQ09HdZWt0B/c6yMKdHSyvg=;
 b=D8yDmLwaP+cmsouDtrUU/S141RcQKfXrSc1WVcLDwrKTx6yIyB2RsCd01p/lIP634O
 mPTY7Rt3QQ703YUfEUpYmWAXscwtFrmW7/LfRRNhVyUEOf/J+HjphQxE264QVjgIShHH
 ahz3KHlkt4h94gaXK7NMdM7cJSGTWZ2uGsBYXHr5S2XMO6BcOpqbtYIIbDM7GTNhKHqR
 RdF9UAjZtrZk595ateodPT/fCWT9E+MFdJhj+cLymvvuVjzhHulDOZDQMq7zghhL20+e
 IcXPnfiY7ydxjsCBnsmyqy7nlk52gb1ZjfvICsPxwYXHt4RbBAm9d6rXVS0xeETfN7k9
 X+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768325044; x=1768929844;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vU5T2lph0Yn2HPeiVquBdQ09HdZWt0B/c6yMKdHSyvg=;
 b=YDXmTzOKkgcjTk53m06LEgcp1rvexXkSCv3mVvrDkllLsMy0P7DuF8B1UajkgaIkz0
 z4zZDGWzRzYXqoRbIZQipJIYknxZZDzJ3rECzREOjFrKkccIh4cZB8J+mmo67FQthW5j
 tn3xD8hHfcIfnBmJRGiD4BFgxCQNiuExO/TsHU8/qX2XjiP2UPmOf+NUd3Bg650Pk8V6
 Qdgo6Gn27/D7XAd/joM95AYAcbctbTJ/pGsojNXJCgDhVY/nt1TTGUHEQyb3blH1xiWg
 NLyGp4sev9e4sS/6Vk1zKPZRZzhrjvxateeT48E69j5HbAET62dQfX3V5AaE1ltFeoBB
 vSSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc0UkuZ4SNYoG194HtIl0CTv6cq2BpJgAGbhP49ZlNCSRaZ2jCbjQSVOfSTVrGr25mjstd9MSqqMQY@nongnu.org
X-Gm-Message-State: AOJu0Yzv4dtRbAkqYKvST3yKpMDU+zesQSYMqqRHPUfT4BARQfTYakMQ
 B8pT+sn1zCa4UnEE9NC5f6cBCmchipg4hlRUfsq9gHrPIsCy28I4ftQw6t6l0DRzE42Y/WAIoEn
 Dv9UjWaeJ7I56YD808TZ00ltAATuh6YfbxO1x5BT3zNjSxsiuiJCdcK7B
X-Gm-Gg: AY/fxX6GZSgKW2wAxiKrUbbKE/GFyINKu/LiJ6xZhxSrZTByjgeqHO131tZFz3v0gDR
 9p5lfSypmsE6kQCbuVSQC/8OJGii+e632uVXvXCRGHiqbK43qsAfZlH5qCFwkS9lmk2InzVXWgW
 JZQARedWXwfH8ikBS70IxLORt37Cv1kHiQl3PTI8jkS8nhV19enOwaaMo+xcoQZyyerz27+DnEJ
 kGlVzH6Mg6l1CLfKUNHDni8t88jbJtbmkF5BzKm3vzGIvCkyJ7O/fEC0qhhSccpuPQTeOzovHCR
 MVYt83TQALJng+QURHQBj1tBz5BSfURE5vJfY16hefuAE5aoY20fvM1uSwx4tT8N88i8uxS+KPi
 +CsBgMKQ8JJBQjYNUMkLZOhXXxkTBg2GtziZYA+ZbqqEXIHNv5SH3wwbMxNFJStGFb5w4s3jxr1
 lrjQ3Hgx5vEWoS8w==
X-Received: by 2002:a05:6000:26c6:b0:434:24e2:bed7 with SMTP id
 ffacd0b85a97d-43424e2bf85mr4001404f8f.13.1768325043766; 
 Tue, 13 Jan 2026 09:24:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX9IXsYd2sLD2dCevKWzzxIjwLO5L1PiO/aC/ToqylRmqgmVeYMkYhqFusqCy3RhJgwEjgjg==
X-Received: by 2002:a05:6000:26c6:b0:434:24e2:bed7 with SMTP id
 ffacd0b85a97d-43424e2bf85mr4001381f8f.13.1768325043376; 
 Tue, 13 Jan 2026 09:24:03 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm45005700f8f.33.2026.01.13.09.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 09:24:02 -0800 (PST)
Message-ID: <b302b2d9-16aa-4f79-83b3-ea749696af0c@redhat.com>
Date: Tue, 13 Jan 2026 18:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/mshv: Remove remap overlapping mappings code
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260113153708.448968-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 1/13/26 16:37, Magnus Kulke wrote:
> This change removes userland code that worked around a restriction
> in the mshv driver in the 6.18 kernel: regions from userland
> couldn't be mapped to multiple regions in the kernel. We maintained a
> shadow mapping table in qemu and used a heuristic to swap in a requested
> region in case of UNMAPPED_GPA exits.
> 
> However, this heuristic wasn't reliable in all cases, since HyperV
> behaviour is not 100% reliable across versions. HyperV itself doesn't
> prohibit to map regions at multiple places into the guest, so the
> restriction has been removed in the mshv driver.
> 
> Hence we can remove the remapping code. Effectively this will mandate a
> 6.19 kernel, if the workload attempt to map e.g. BIOS to multiple
> reagions. I still think it's the right call to remove this logic:
> 
> - The workaround only seems to work reliably with a certain revision
>    of HyperV as a nested hypervisor.
> - We expect Direct Virtualization (L1VH) to be the main platform for
>    the mshv accelerator, which also requires a 6.19 kernel

What other changes are needed?

I'll leave the code in for a while until 6.19 is released.

Paolo


