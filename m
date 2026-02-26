Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ED5FCE08C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvc6d-0000b8-CU; Thu, 26 Feb 2026 09:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvc6P-0000Np-4v
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvc6N-0008GU-Dz
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772115145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMdmJhn6ajjCgiilfFe8zLD7EDRXhtkginMPJZv1sdM=;
 b=MuWddf4fn01ArUnfWBRMemA7znhnH0XO4kU9uWwXBex/R1gMimvl+Z+KZ3m7GgogxBumCi
 6F9jZucOz+RDlf6OLiUcypkY1Ok8pEmxVV5kXrMbILc2fGh2Xxe9JJjIyTE+8Gky2cwMH0
 bBa6lt9gyHDVknH2/HOMR1ECoMpuVrg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-DHVzeVyKO6Wiv9Nxjo-AvQ-1; Thu, 26 Feb 2026 09:12:23 -0500
X-MC-Unique: DHVzeVyKO6Wiv9Nxjo-AvQ-1
X-Mimecast-MFC-AGG-ID: DHVzeVyKO6Wiv9Nxjo-AvQ_1772115143
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8fa5744b82so92723366b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 06:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772115142; x=1772719942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZMdmJhn6ajjCgiilfFe8zLD7EDRXhtkginMPJZv1sdM=;
 b=pvjVxs1Rz+HvVdqTGGIVwxIGp6ogzQfp4jXfH+0pQW4/GH2qCfwqj2BSv4AmiviQFx
 pOsEqZ9QsSCCH1+Eh99oNxr46tnUfh+e1G2xuGANWSJUh4xvT1y4FuRvIVfFVQVsZL/c
 gjcTBCDWRv+kXWyonKiIu5bkRb+bOFluiqhPrG1NDWiQ8xbAq5c/v0njxn7qYRSwwo7+
 ScHCM9TK7ghu3nyW4qEOeGyORN08wu0PZlsyUuUlobF+XUT+XnAH2QYaRUg+d7IkvWdm
 nIf4yFmuhY2ynv3CKWB4m8T34OL3xyfb0Gyt90+S2lRmQ/9B4PWKe5I9eU7bbhQ51m/M
 UqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772115142; x=1772719942;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMdmJhn6ajjCgiilfFe8zLD7EDRXhtkginMPJZv1sdM=;
 b=vlrmyvXe0qMA6hE3rpYv698MGgloV+n/btH3MwTE7MTxnYpKkU5D2VMD0rP7A04NaY
 VcV/8a4f31yAUscp0S73FRP/s4Ve4taiOJpYXLNHKzdbseWVyJ/bloGOb5sZ8JFtnP6t
 dCputzzytzEe79BBq55MUvqUpzxcIea8kaGQIeZl13L2oAOCsZxK6gkDr+z26YGfeR8D
 r+QCH3/pdHIYnjEXoyUQmQoJKMsLrObMU+SC4w1mTxKdEdEDZFmUaTBTNpEK+rYukNvU
 y0ZrFb/Ij8ogszcL9ZdyJSkE7Y5MH9JAjQYkyfd3VNK8qrXIYfV0Wipojh5OKeeeT5C0
 gyYg==
X-Gm-Message-State: AOJu0Ywu3TIhMd/p/Y5J+ECYXP5LPlaDJC6Z1JP9zwgVwt3jmmueARxM
 nrbQbR+/anit8aDwAejtYHlBIWnQM3l2uqwcJ5gz3EoBsFvVs88caLhwbsZIsIft8g24+16c/RI
 Y2Rjvpu0s6iwEVPQww77ydWHdVhl5tkgp4nfNPbig/64baySpGCnhcvhs
X-Gm-Gg: ATEYQzwC7cISK64tIFH+fR48UX6+/sI0KC+jWM0g7xP4UfaZnOlnOBPsUYtPzNJA29Y
 8/TvkZQLyM0Qe81diq7issAsdq9xPz5GaZTRukfs/h2tH/Jawqfy3BA+4dnKtU2gEhZHHOBQX50
 zsDvvxMTRnOsDq9TkDxf6Wp5Y2KUhDw0dvvwpH86B3VOZKyuFRX2TfyYC3QW3KA4+5jzsjONl8M
 lcgN+IsfKvunWShMx/3Xz72NmV8o0ou6irOeID3m+211c3XQD1HltQl6gQ5znVwxnu6K8XIfzU0
 BJLQZhC/shtj5lm8fLUPkWCXC+fXhmr02nO+DhrI94wnoB7JduXeVvPhc892VKXeAwTYAkV9dwi
 NopbqknYturyfXYwZWmFqJYZZpt6mEqlfgw/cf+XGOnYIzwOPZ0dcn5J/fu+pXBAaQGPd+bVgN4
 ctmE/UkQyCriQv4vkaU5EZcw38C90=
X-Received: by 2002:a17:907:3fa5:b0:b8f:b3c4:1e2 with SMTP id
 a640c23a62f3a-b9351723e7cmr261607766b.39.1772115142526; 
 Thu, 26 Feb 2026 06:12:22 -0800 (PST)
X-Received: by 2002:a17:907:3fa5:b0:b8f:b3c4:1e2 with SMTP id
 a640c23a62f3a-b9351723e7cmr261606366b.39.1772115142075; 
 Thu, 26 Feb 2026 06:12:22 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b935ab13558sm65381366b.5.2026.02.26.06.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 06:12:21 -0800 (PST)
Message-ID: <2f9d77b5-7724-4c8d-9f6d-ce82815b8501@redhat.com>
Date: Thu, 26 Feb 2026 15:12:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] scripts/qapi: add QAPISchemaType.is_predefined
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-11-pbonzini@redhat.com> <87bjhdxooi.fsf@pond.sub.org>
 <21b5e0ec-d03d-4e39-a3bf-deada48243b7@redhat.com>
 <87ldghw6tn.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87ldghw6tn.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/25/26 09:44, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 2/25/26 08:33, Markus Armbruster wrote:
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> It is impossible to call is_implicit on an enum type from the visitor, because
>>>> the QAPISchemaEnumType has already been exploded into its costituent fields.
>>>
>>> constituent
>>>
>>> Passing selected attributes instead of the entire object to its visitor
>>> method limits what the visitor can do.  This is both good and bad.
>>> We've run into "bad" a couple of times.  It's never been bad enough to
>>> change the interface, though.
>>>
>>> Thoughts?
>>
>> I think that applies here, is_predefined() is a reasonable addition.
>>
>>>> The Rust backend is also not modular (yet?) so it is not possible to filter
>>>> out the builtin module;
>>>
>>> Really?
>>>
>>> The visitors are all based on QAPISchemaVisitor.  Protocol:
>>>
>>>       .visit_begin()
>>>       for all modules:
>>>           .visit_module()
>>>           for all entities:
>>>               if .visit_needed():
>>>                   .visit_FOO()
>>>       .visit_end()
>>>
>>> QAPISchemaModularCVisitor implements .visit_module() to generate code
>>> per module.  Its .write() skips builtin modules unless opt_builtins.
>>
>> ... because its .write() already builds multiple QAPIGen{C,H,Trace}, one
>> per module.  Here instead there is just one QAPIGenRs.
>>
>> Using multiple QAPIGenRs instances, one per module, would be hackish.
> 
> I was thinking of having .visit_module() save .is_builtin_module(name)
> in self.in_builtin_module, then use that to recognize built-ins.
> 
>> I'd rather just go modular instead of that.  I can take a look, since
>> this series will be (early) 11.1 material anyway.
> 
> Modular C code generation reduces incremental build time massively.
> Before, we suffered from "touch the schema, recompile the world".  If
> Rust would similarly profit, then I'm all for going modular.

Rust compiles by crate rather than file (crate == toplevel module), so 
it would need some benchmarking but yeah I expect that to help.  That 
would mean something like

     use qapi_block::*;

Paolo


