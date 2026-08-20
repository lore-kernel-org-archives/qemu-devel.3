Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAA3C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxCHL-0003NC-5D; Thu, 20 Aug 2026 19:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxCHJ-0003M0-4P
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:34:33 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxCHH-0001sz-Jx
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:34:32 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so349524a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787268870; x=1787873670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8pmz72ukyhktWInfrHaDweaZHLz5vc5IxHyAKQxe2pQ=;
 b=GvYCdkMhu6oMnDIN07feBJB+nV3Gf/3tdfUARMWD05JXFBO0VvsSvs6+P1uKkUX000
 4MN+YM5dMw4h8/lL34LMklgXpu5LSbsun5OJ/NZD1EyVbrYa2r5rdTJWYnQQSd5JZTLP
 yySALyyNs4NKpeLYxORj37psiJ0NSVggoELP+yZo4trtD6sis3JhQ6g0STxvwCS1xLKJ
 aFaW6dexsMrcHqIIAQTMTNIwqQpA/COrEOyBflLVf+nkCugnpsvqSafsv7oUTdLRVqX2
 S/UgMHmsh+Zf+9aPD4FgFUdYQTsyhaxsN8RfqT2WKcBYgJqmsln6uq6RP9VK3gbU9Qx5
 BtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787268870; x=1787873670;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8pmz72ukyhktWInfrHaDweaZHLz5vc5IxHyAKQxe2pQ=;
 b=CDS2PYQ0QwNWZglfWKh/Lmz5XMmwjKfHhIaxNE7X7nZGfjo0v77BnVk7gXwlYPpqoY
 NL2zFUJ35h0KZ1OKXb8iykOofNpwWKXYw8QU+0Zt99JXGqHnp0yktZwTPhJRlCmfCgHC
 0aS6yax/pYKdpmUkFMGAyeEnjbQvo5v2Ib9UD1WuufbXnaWQRbLFsio3PXjDAivXEVQm
 CYm4AtsUL2esCio93Z/As2hvodlccCkiY3wJaYCP/r7/NO5h17ytnQAEfWduFuV4FRek
 RUbBfZClGlrzi+bpAXvHa1q1IyermjkXVgINBkJOsOozH3PxK9NihHIu8m7SpLbPJRUI
 hNVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrntD8CRUh7IrwyO138m2lZKvY1agCiCRB2bYS9kUdtUj+dTDOvC6VoCnFC3stfvrYPpdroLqx4fNS6@nongnu.org
X-Gm-Message-State: AFuF++kjgLCixz5K9DlhGFQlDkAQlhU93bkcN3ezPWoTellkNqcrymge
 92TQgUovq24kT92OaJUgB1gr0XaeLt66XLkkS6be2xRCGmhiyJWfYugo98WkO9WPAck=
X-Gm-Gg: AR+sD131JpZaOiJUCgTdLcY20oJazAE2w/dIvnJ3FQKe1LssDqVSAX7eZE+SnAcd895
 D0MUXIBTzNn4Rmdy29Yqs9pD3bvWopaUucXenB09uxSehx22UHlOhDnpGbhmC/iN9MoJEZopkb8
 ZMDpQQmhNZAX8iVTWf11/0kGvQ4JA8LyWxwLCFJ+KdwTb5jzuCD+5DTdXcF7P8xeZwvxRiXdsz9
 Ffiqm3J21VSLQ+gwtcj7lzFWhR3KWIJEQWkSwnkCHkZIsqri96srnnT1QwXKS1utznNqkZGuZwl
 zCcqjTLv/FZpKuldsh0AxnAPa38mwFpjx/j7q5YPT1PRlk23od2Rbj9EC2vt0HK9qdpHHmgexdA
 jJIITi7vK1c7/2qGKZMSsD9mKyzKtCWhaAFYBwSPX6dUjWANBXzTBmDCOyvWaUVTNpnVX1wGmAE
 W46GPLQj36JkHvTI4u94nTxquYw86NF3xRcfS5nyZJBW9x4mDX3YnlIUhT6ck4dtro2SVbDgocd
 afe
X-Received: by 2002:a17:90a:da87:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-395c3731c29mr3675013a91.12.1787268870070; 
 Thu, 20 Aug 2026 16:34:30 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c467d907sm667809a91.7.2026.08.20.16.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:34:29 -0700 (PDT)
Message-ID: <375ec889-0a10-4456-974a-f46cce634309@linaro.org>
Date: Thu, 20 Aug 2026 16:34:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] tcg: Defer tb_flush when initial thread region
 alloc fails
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: yvyas1991@gmail.com, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260813005031.518387-1-richard.henderson@linaro.org>
 <35d6cbd3-ac16-496d-a8b9-97b5a3adf596@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <35d6cbd3-ac16-496d-a8b9-97b5a3adf596@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/20/26 09:45, Michael Tokarev wrote:
> On 8/13/26 03:50, Richard Henderson wrote:
>> Hi Yogesh,
>>
>> The main problem with your patch is where you've placed the change:
>> tcg_region_initial_alloc__locked is also used by tcg_region_reset_all,
>> used by tb_flush.  Along that path, we really can't have a failure.
>> The path on which we can defer allocation is via tcg_register_thread.
>>
>> The second change I made is to use code_buf_ptr == NULL to signal
>> reallocation is required.  In addition, tcg_tb_alloc doesn't need
>> to immediately fail: in the interim since thread creation, we may
>> well have performed a tb_flush already.
>>
>> Please have a try vs your hotplug test case.
> 
> Hi!
> 
> Is this a qemu-stable material?
> 
> I'm not picking it up, but it feels I should :)
Yes, I think it could be trivially picked up.  I don't think any of this code has changed 
in years.

r~

