Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1FDC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 19:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMteK-0005wE-Ga; Wed, 04 Jun 2025 15:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMteI-0005v3-PD
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 15:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMteG-0005be-Mx
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 15:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749064778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oUtFymwOBl1v1lVcFvy8YpSJaKa5a8E2Q7YW1HX7ouw=;
 b=D3r/EOm0yr318IH/19cIZUIAkekfTCo4KE8t/YLFEfcSGTlcofM8h3ylEe8zXMWKQf/Zi1
 S/6tESVHjeMCpFfp7YCgI21AMShmeo4Ek5p2DewfGbtOryRz7inV7yR23RaNP5mvvG1BaL
 CuDooUD9bR5H6MrQTn/BXcIdbvoeAQc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-Ow-kWY3SPxS5zwPMptkXUQ-1; Wed, 04 Jun 2025 15:19:37 -0400
X-MC-Unique: Ow-kWY3SPxS5zwPMptkXUQ-1
X-Mimecast-MFC-AGG-ID: Ow-kWY3SPxS5zwPMptkXUQ_1749064776
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso109844f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 12:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749064776; x=1749669576;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUtFymwOBl1v1lVcFvy8YpSJaKa5a8E2Q7YW1HX7ouw=;
 b=IJqQHy3s3ZjOBvt7bQUDJ3xesp9k7sDXhGxcX8lOMUF+W7WJohs5pmY816WvS+VrFB
 hKFcEaTDq7s5o7VisWlYRnUhQxA12u89NFIKO2Q4/KHc/bjcFc6vsA1TopH/2bn6RbgF
 0V/+purOnfuOTSR0+pN/e3aHkhtUJCRG4nq+mo2C9/YzhYYMGLqYqsd/JmIE2FsAmrsb
 giUuOSQMPIrciuhqR2x79Mzst2AW1XeigoOIXhELccpjqOMKoMWAOeZc7TVOCrLEUEEN
 V+Xueo0PNUlEL4DSbBROGs7zobqYaKihRMaSDnuBEy4GK4T+jCB6uHDA74WaqIemfd10
 y0eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW351ZXQeO1NdAAS0Ma6m38pzkPIpKlXWK5jn2k52LfaE0hdzwx5MHCU5C2wM0HZWLCyQ35Fh7f0d+E@nongnu.org
X-Gm-Message-State: AOJu0YxUoo5spL1ytUzffhGLcveR7IklUACvjFOdG4yMaVhMHxdratr4
 h5VlvTXexQrwkFZAEvGMX4EmvdZnEfUKTz3qz9tIr642FTcRejwXTf5roainyVHuYYxq+ANHxB4
 7sRv4t5gwfinfjNrtIvmtk1G0wsXCa1tPl5Hrg9NhyClO6OWWO5D+fPoJ
X-Gm-Gg: ASbGnctUfIw8a3KjDZnrwsz5iZvFs17c2Bgoijpt7ax5DqkSFDROFDH4VCbKUzZH26a
 uIeO+ajICyV6OfFNCAHhQXO80lsqHb4Xbzo4T1g6C5kbXYsxWKbfP405LDP8dC55mNOPhI5u6TM
 8Re6T+33W+bIBRTDs7RTl3X24XoOXw9rYq4Ry248SXtAVSxkeOO4R+s4ud2Odx6qYZuih747CBJ
 aSzbQfbLQJ16LvGmQFWgJeo7Te++ZPBnzyyx4hA9TtILyfAxQ0i68cvay++3wF06Mt5ZQbrxBZp
 K783DrCaAwrABw==
X-Received: by 2002:a05:6000:2f88:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3a51d8f5ad7mr3279439f8f.7.1749064775913; 
 Wed, 04 Jun 2025 12:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv5qEgzMcNadqQrks8XNMvsUVD2PBC46PMEpFfhK0a2SpNDL7foBM89bL9ZHxUkR+LRbZGeQ==
X-Received: by 2002:a05:6000:2f88:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3a51d8f5ad7mr3279429f8f.7.1749064775501; 
 Wed, 04 Jun 2025 12:19:35 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00971fasm22236655f8f.77.2025.06.04.12.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 12:19:34 -0700 (PDT)
Message-ID: <97b16175-8d2f-41f9-b305-a532acbad095@redhat.com>
Date: Wed, 4 Jun 2025 21:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com> <877c1uffj3.fsf@pond.sub.org>
 <aD7AbxghCc5VYDhu@intel.com> <8734ch5d5c.fsf@pond.sub.org>
 <2b7be73c-d91f-4820-a8ad-6964a8331150@redhat.com>
 <871ps02j8u.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <871ps02j8u.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/4/25 07:01, Markus Armbruster wrote:
> This is what your FOO_or_propagate() functions are for.
> 
> The rule glosses over a subtle detail: the difference between
> error_setg() and error_propagate() isn't just create a new error vs. use
> an existing one, namely error_setg() makes the precondition violation
> mentioned above a programming error, whereas error_propagate() does not,
> it instead *ignores* the error it's supposed to propagate.
> 
> I consider this difference a design mistake.  Note that GError avoids
> this mistake: g_error_propagate() requieres the destination to NULL or
> point to NULL.  We deviated from GError, because we thought we were
> smarter.  We weren't.
> 
> Mostly harmless in practice, as behavior is identical for callers that
> satisfy the preconditions.
> 
> [...]
> 
> So here's the bottom line.  We want a Rust function to use C Error
> according to its written rules.  Due to a design mistake, C functions
> can behave in two different ways when their caller violates a certain
> precondition, depending on how the function transmits the error to the
> caller.  For Rust functions, we can
> 
> * Always behave the more common way, i.e. like a C function using
>    error_setg() to transmit.
> 
> * Always behave the less common way, i.e. like a C function using
>    error_propagate() to transmit.
> 
> * Sometimes one way, sometimes the other way.
> 
> This is actually in order of decreasing personal preference.  But what
> do *you* think?
I agree that there are arguments for both.  The reason to use 
error_setg() is that, even though these functions "propagate" a 
qemu_api::Error into a C Error**, the error is born in the Rust callback 
and therefore there is no error_setg() anywhere that could check for 
non-NULL abort().  There is a bigger risk of triggering 
error_propagate()'s weird behavior.

The reason to use error_propagate() is that these functions do look a 
lot more like error_propagate() than error_setg().  I'm undecided.  I 
think I'll keep the error_setg() semantics, which is essentially

     assert_eq!(unsafe { *errp }, ptr::null_mut());

followed by calling bindings::error_propagate().

Paolo


