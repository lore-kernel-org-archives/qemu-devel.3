Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E52CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTj4-0000FY-0B; Mon, 25 Aug 2025 05:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqTj2-0000Cg-Bv
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqTix-0000q8-M6
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756114964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RTYtsZvYaRhTq5kr1CWa1/AdJGC/r4KAGqVQ31HafRI=;
 b=GXWU8U813HF3y0L4qf3i38zMPGWFWDN4wZR2jLyHWTEbK0285MPG02/+Z7sVK6WnnLr0fR
 AJ2de5fwYO/KEZanhNQgeQyXPGUruQx0e+Y+jwBI2WAfjGRJ4DJcxwg6xb6e2YLP3bkmGu
 FCJ/cuBr9iciExpBMjk/aM+75r9pcqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-_WT3dv7SPiGI1olunYIxiA-1; Mon, 25 Aug 2025 05:42:42 -0400
X-MC-Unique: _WT3dv7SPiGI1olunYIxiA-1
X-Mimecast-MFC-AGG-ID: _WT3dv7SPiGI1olunYIxiA_1756114961
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0b2b5cso30744175e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756114961; x=1756719761;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTYtsZvYaRhTq5kr1CWa1/AdJGC/r4KAGqVQ31HafRI=;
 b=MMGSZWs9dHZgMPYgtMtjv/RceOOlpebkEv4DgKe6+PgunEbPR4Z1ZymOffiH6+r2/t
 iclwcPq40UYwfNd32wNulx2ZZnve+GW3XitPCj8iuKIriW3EGRtMM/nLGMzhqApPubgb
 Zn7yf1XiGddz+BLW1GMbWe4CsOQ5snv8N8zS1TSsFwg9VV0ungwi253Cpohro5Uk7Ynd
 nEKSw8Vy02v4BGnNerQlzGrZ8PLjbzMa2SYIzrUYQwJhtETL7TUuyZeo7YYpnolMaSwV
 rtVV0gpT5C0OVwAw1zSmUmm8uYlep4+wXtIcYwPNfQXjy8cP9Fcty9kgFfX3r+dvRVlM
 GOAQ==
X-Gm-Message-State: AOJu0Yx2lMvpbV17e3BQQ/5LJFhZe0nqgmA1sGOjH6jUoqdcK974d0Ww
 QEHUhpg8oq5Lp5xnouQQkc1Pv+cmcgtcm1rfEZQiyQ/0mhtWYG6k8O64k9qX8qLUZdZKDbMW85+
 P0s4lwmTu+1kCvqjPu1+s6zgXqSseIq40cWxku5HwSmP99sVuAnAOQieU
X-Gm-Gg: ASbGncuRsYYQTXcQzpiqaCLXtAtpNufK023N2xe30J6BDJUAM9DhEiS2/jkOCEJUf1L
 vWi6KRbWlCzZt5IYRr41Y+XZ6euWeCHcV+kUiPXRzelIGzGmknpWKp6s0n8HdoLWubEDNyImLWs
 B6in30E6VkfaduHR5RslIrUpK52L31241JTZEzYQypKHJLJXDFTt+PTkkMCAgAM+Y2R+/WUT4c2
 yEzIh6Wy50dJEXaiSejEUvvLkfrBILP8bXpZeWEuWLS8g+xUKaBDhTrXS4pI7ngUkVpyN+d4Qar
 w8c9Sl3WQgYxx/sm7XubtPj5YI+ssf4ghV+eUoCeEM0CI/kmT6feIW6fpPHcA3hG+5HBERUu1Mi
 FDq2yvERtrEpdQKlwL64k4zW25Kge4+AOsFKH5l+7flLUiQ==
X-Received: by 2002:a05:600c:c48e:b0:45b:5f3d:aa3d with SMTP id
 5b1f17b1804b1-45b5f6bde93mr22595845e9.21.1756114961330; 
 Mon, 25 Aug 2025 02:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW5IwuoFi/r339ZDpucwpiFsPMnRQMOXQEV0oTD6f8Md9okDkEW4IclVuKQ/hDjwue+1zGkw==
X-Received: by 2002:a05:600c:c48e:b0:45b:5f3d:aa3d with SMTP id
 5b1f17b1804b1-45b5f6bde93mr22595585e9.21.1756114960879; 
 Mon, 25 Aug 2025 02:42:40 -0700 (PDT)
Received: from [10.168.118.169] ([131.175.147.17])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b5748e743sm103820375e9.17.2025.08.25.02.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:42:40 -0700 (PDT)
Message-ID: <c7ee800a-a1e3-4c73-a157-501f872d3311@redhat.com>
Date: Mon, 25 Aug 2025 11:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] tracetool: Add Rust format support
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 berrange@redhat.com, mads@ynddal.dk
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-7-pbonzini@redhat.com>
 <CAAjaMXb=HseHy3vW+5W+f2uVR01c0NV9QKmOhQuB7BkW0Topkg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXb=HseHy3vW+5W+f2uVR01c0NV9QKmOhQuB7BkW0Topkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/25/25 09:03, Manos Pitsidianakis wrote:
>> +def expand_format_string(c_fmt, prefix=""):
> 
> (Pedantic comment) let's put type annotations in function signatures
> when possible, these seem to handle `str` mostly so this should be
> simple. This should catch basic errors like passing/returning `str |
> None` or wrong types altogether.

Not pedantic, I have a full conversion of tracetool to add mypy 
annotations... but it's on top of these patches. :)

I can reorder them and post the conversion first, depending on what the 
maintainers prefer.

>> @@ -0,0 +1,76 @@
>> +# -*- coding: utf-8 -*-
> 
> This was probably copied verbatim from other tracetool files, but IIUC
> it's not needed, utf-8 is the default encoding if there's no `coding`
> declaration.
> 
> Also, missing SPDX header as a new file

Ok I can do that for all files, too.

>> +        if "tcg-exec" in e.properties:
>> +            # a single define for the two "sub-events"
>> +            out('const _TRACE_%(name)s_ENABLED: bool = %(enabled)s;',
>> +                name=e.original.name.upper(),
> 
> What's the difference between e.original.name and e.name?

Good point---anything to do with e.original is dead code.  I'll add a 
patch in front to drop it.

Paolo


