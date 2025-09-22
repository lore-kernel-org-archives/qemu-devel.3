Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49491CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0h2d-0006yY-EM; Mon, 22 Sep 2025 09:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0h2a-0006xq-OM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0h2K-0002qs-Vi
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758549416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BA6uiut+DFxCaY1uUaHuRZhAnV2iUq2if9IRYp9e6VE=;
 b=PCcJ/Rf9ZzNbUbODFwT0FRBK8ReDP40/LB6dE1HJ6oFOUug9jHA/eujp5FSiXq2Tyca1Ht
 pRsraUNkzfcNvQd/gXmrDf9V+iface/jVTko3WCsyzrBpha5VBaxtC58xJU4NAl6hwobsR
 UG/8fDrykdbGDGUvd534T8WXpQqKsUA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-dr0gw-oDO-CrUheer_Fh2A-1; Mon, 22 Sep 2025 09:56:55 -0400
X-MC-Unique: dr0gw-oDO-CrUheer_Fh2A-1
X-Mimecast-MFC-AGG-ID: dr0gw-oDO-CrUheer_Fh2A_1758549414
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46d46692831so5206855e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758549414; x=1759154214;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BA6uiut+DFxCaY1uUaHuRZhAnV2iUq2if9IRYp9e6VE=;
 b=GedKZhGglYZbuw+nI9dMXdLtnHGThvg4Fmd8XSE18oaKtXxfIdffBwvQwXkeRE+KHV
 /Sdp5lO93AV0eL+89VLgNw3ZX7E04+BNm/EH9EW1pporNZZjQ9Tlz3Fz8FtLqeF/ixNz
 aU4/+z3n6yEm07KXvZj0hZfw3JhIQlG/upRVlBhSoCgcycXbL3TMOwD7HA1NqI9ZyN1e
 KR/7gRJFqpGd9QTJNB2Vl3TZQiM4IWjuRiU07LUIXYzdYFAEnr4DuMGOwWROosiDXOw0
 ZD9VbXVzH/BQB5ppPk8wAOb+t0smacrhoENN+lpKLmqaVnc3i3b1mAAJaEoUXghuomW0
 /Gkg==
X-Gm-Message-State: AOJu0YxZzaSYAc7gHWwXaZ2g2o8TijMaEwvozrBf/cV114jxnex/Qsnn
 2Ri2mDty8FMiQhI2+fBexgU1EiNFXlYtUi6An5dGg/K6HS+HHQ+XZIoUWgY3Goq/chhq0eacvov
 nboQhBQgQ++zIpgdpOJa6YCXfQJ66R4jvjmugiDaVyxzEUHvDr6JLVsfo
X-Gm-Gg: ASbGncuy9SDVAIrFvoeSpOtgw2rXGspTlHk5UUsMHRj41vJfwkXXuQNJWDPmKWXYZfn
 Ld5I6jENLfG0XYAyaYQJsRRhlMBvU/TnkGiIkF3vpQJZxPpETqg4oC/aHgNbrfYYl2mApuF8FhD
 USLMtE9t4FuYtr9NP/fJPKt+nJGKiee88d7f1dcUbVVi9fgEKHTMb2ucs8za2Ph0XpaKaBsSywv
 tXN28yu+20UXQiEYQHb5YJ9xFZlDWkxK3AHKwVAsdiyQq+G4+rYVTASheIlegLwlXyoI0QGM4e4
 uFb8W6jP0mjHqyqb6aLJNqVT4VYdAf1ZsaQEk+grZo73c79q/erVHwS+ppMbassPaOCJ0sKe9jF
 PWYHB0LFou/1cYWfEFBZZjPjuO4X5LsESFDV5MZCGeHc=
X-Received: by 2002:a05:600c:8a0c:10b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46e1b897b12mr2613445e9.9.1758549413595; 
 Mon, 22 Sep 2025 06:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZQW+6aLBCYzQXKV/cQT3TOQFVrkQoHMnIGHWD3WrVNX2WenTfB3TI6XligdarelBWJkgasA==
X-Received: by 2002:a05:600c:8a0c:10b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46e1b897b12mr2613215e9.9.1758549413123; 
 Mon, 22 Sep 2025 06:56:53 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-464eadd7e11sm214507365e9.0.2025.09.22.06.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 06:56:52 -0700 (PDT)
Message-ID: <d130989e-3883-410f-b96b-cead1be382ad@redhat.com>
Date: Mon, 22 Sep 2025 15:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] docs/code-provenance: make the exception process
 more prominent
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-3-pbonzini@redhat.com> <aNFOFq_H8KjWM-oy@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNFOFq_H8KjWM-oy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/22/25 15:24, Daniel P. Berrangé wrote:
> FWIW, I considered that the "exception process" would end up
> being something like...
> 
>   * someone wants to use a particular tool for something they
>     believe is compelling
>   * they complain on qemu-devel that our policy blocks their
>     valid use
>   * we debate it

I guess we're here, except for hiding the complaint behind a patch. :)

>   * if agreed, we add a note to this code-proveance.rst doc to
>     allow it
> 
> 
> I would imagine that exceptions might fall into two buckets
> 
>   * Descriptions of techniques/scenarios for using tools
>     that limit the licensing risk
>   * Details of specific tools (or more likely models) that
>     are judged to have limited licensing risk
>
> it is hard to predict the future though, so this might be
> too simplistic. Time will tell when someone starts the
> debate...

Yeah, I'm afraid it is; allowing specific tools might not be feasible, 
as the scope of "allow Claude Code" or "allow cut and paste for ChatGPT 
chats" is obviously way too large.  Allowing some usage scenarios seems 
more feasible (as done in patch 4).

>> What is missing: do we want a formal way to identify commits for which an
>> exception to the AI policy was granted?  The common way to do so seems to
>> be "Generated-by" or "Assisted-by" but I don't want to turn commit message
>> into an ad space.  I would lean more towards something like
>>
>>    AI-exception-granted-by: Mary Maintainer <mary.maintainer@mycorp.test>
> 
> IMHO the code-provenance.rst doc is what grants the exception, not
> any individual person, nor any individual commit.
> 
> Whether we want to reference that a given commit is relying on an
> exception or not is hard to say at this point as we don't know what
> any exception would be like.
> 
> Ideally the applicability of an exception could be self-evident
> from the commit. Realiyt might be more fuzzy. So if self-evident,
> then it likely warrants a sentence two of english text in the
> commit to justify its applicability.
> IOW, a tag like AI-exception-granted-by doesn't feel like it is
> particularly useful.

I meant it as more of an audit trail, especially for the case where a 
new submaintainer would prefer to ask someone else, or for the case of a 
maintainer contributing AI-generated code.  If we can keep it simple and 
avoid this, that's fine (it's not even in the policy, only in the commit 
message).

What I do *not* want is Generated-by or Assisted-by.  The exact model or 
tool should matter in deciding whether a contribution fits the 
exception.  Companies tell their employees "you can use this model 
because we have an indemnification contract in place", but I don't think 
we should care about what contracts they have---we have no way to check 
if it's true or if the indemnification extends to QEMU, for example.

>>     **Current QEMU project policy is to DECLINE any contributions which are
>>     believed to include or derive from AI generated content. This includes
>> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
>> +  ChatGPT, Claude, Copilot, Llama and similar tools.  Exceptions may be
>> +  requested on a case-by-case basis.**
> 
> I'm not sure what you mean by 'case-by-case basis' ? I certainly don't
> think we should entertain debating use of AI in individual patch series,
> as that'll be a never ending burden on reviewer/maintainer resources.
> 
> Exceptions should be things that can be applied somewhat generically to
> tools, or models or usage scenarios IMHO.

I meant that at some point a human will have to agree that it fits the 
exception, but yeah it is not the right place to say that.

> I would suggest only this last paragraph be changed
> 
> 
>    This policy may evolve as AI tools mature and the legal situation is
>    clarifed.
> 
>    Exceptions
>    ----------
> 
>    The QEMU project welcomes discussion on any exceptions to this policy,
>    or more general revisions. This can be done by contacting the qemu-devel
>    mailing list with details of a proposed tool / model / usage scenario /
>    etc that is beneficial to QEMU, while still mitigating the legal risks
>    to the project.
> 
>    After discussion, any exceptions that can be relied upon in contributions
>    will be listed below. The listing of an exception does not remove the
>    need for contributors to comply with all other pre-existing contribution
>    requirements, including DCO signoff.

This sounds good (I'd like to keep the requirement that maintainers ask 
for a second opinion when contributing AI-generated code, but that can 
be weaved into your proposal).  Another benefit is that this phrasing is 
independent of the existence of any exceptions.

I'll split the first three patches into its own non-RFC series, and we 
can keep discussing the "refactoring scenario" in this thread.

Paolo


