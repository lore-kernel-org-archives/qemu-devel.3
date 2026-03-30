Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D01061B13
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7FKz-0001cx-H5; Mon, 30 Mar 2026 12:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7FKo-0001We-Pm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:19:32 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7FKm-00072V-Hu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:19:25 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9b1df1a6b3so518366166b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 09:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774887562; cv=none;
 d=google.com; s=arc-20240605;
 b=haIlc6hpojWLMwVOiSaYqBHx+VJcJL3AmxzwcXMhBMOPi0Q1loxWYC9to4W8LpMMse
 xwVs61EI1mFQBRl4ktoSf9CTFc531d3Axv3R21sy6fLerUpcQvKWO9lI6K8rLshYmGto
 Ed1RYgssqDun3N1uE3kSIQrf0gudQhbkV6ggEd1xAZxyWjLKxZjkhGFSLEw+OCwtZIH5
 n0bQHuyQYKFTYakcW5TIJsfbYWz/7eAlaNux2zjvmxxERY94ovd1CtTEaRSRcFIlVovf
 q2caK9x4o9Y2/zu0s8JqQ7oshsRIe1BQ050XIxQDuQb0+NPL2KLP4UGeQPBjNvjMEqwa
 fZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d9QTIX7fkdRtZYpLBJvDBCCt+E5LADp5ZRGifVdQxG4=;
 fh=b62PLUGYA18jZCaEBIpju//H7uYFGdo9qPDp3sjywoA=;
 b=hVEp4YLdmqLHTpIs592ireOocs/Mrr6+Hqkvq6lKvG5974YIMK+s9V50V7WiVPIIG1
 +t9CRtcFtJg0/yc89bQC81oQz4ziFoCVTwG0rp6MVzh/CzxaktO3cyfssMHFCNA5iRTJ
 bhTqQcJlYZlSAEe6MFp6J7O8IzlEO6lrQbozgX/x9nF5ol5jW8726syaRUR1zsPRRSeD
 W29GvgY2pakAP1EtDKa5q2bC1D4VxyGn3qwqK2gMyBTDpXHwpsF+pPyx1CdrQVXJuvpK
 q0zkyQ+RFJQ1Ji6DudhyTQP3TB76m36QOBWW37nz3m5w07ypM4X+XxvQNHMBRZfvOhTO
 dMtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774887562; x=1775492362; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d9QTIX7fkdRtZYpLBJvDBCCt+E5LADp5ZRGifVdQxG4=;
 b=Y7R4BfKY9jyjDl+jHFrbGg/X/aR36sWuEI41w4vYURtB06N5sMAXFCFhJorGeDXjQg
 GQ/YGfWVqUt3gF7d/P+08hIRuUIlEFRViYHkXRqBolTOzBAvRph+Xajb4Y/mK+FsvSCq
 QfVU2EKFfLDv2lGLntnhDvPOy/pjj+6jwBQxYwnKSrB0siXWJ11NWQLlWXF1sJVAdVOV
 rvEFtGPLiKrlHRSKgkbNSXBN3A0+pJt6XiAQKkGYU2j/pBeLOpX249uAIm7Gh9Qzt8rj
 kmAEQ5CZaYzrqLQfFguoTT2mfEOR91EoDwvE9kTe1XQLNhLFtdbVsm4WSxu89NX/8ULr
 6iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774887562; x=1775492362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9QTIX7fkdRtZYpLBJvDBCCt+E5LADp5ZRGifVdQxG4=;
 b=pzoQHZeBrMZ7RytFcuhU9DuK+EjweFfHcOgtWarBHUmCz4NQZOpmabAiOj2J6+o8e5
 3RgBL9s4O1QkbtGNFb5tDQmZwjbIQYU18wDOnzWw4o0w2qfBfcJSVvv/qUQjpI3uYQ+K
 B/eU9YoZ2sv5KmWDMnp+Qdh7NyKVmoDYsNG/WbIHk0pGstdxAJ239XRLEfFoIccZFTcz
 JYxTyREWSQpDOGIp+naZYJWRSmVUoRXr54gxO1L/Geg4ut2z1VMZ2eMNWnbtVF9jqu/l
 Tiha1cohkMpLlbBg1o4JRwfiiM8QnFryAv7AVm/meg+gA2jRUlLqKY2ESwO67bpGPN1Q
 kjag==
X-Gm-Message-State: AOJu0YyHw52SwEQ27h+rTPjmUa00c5wuS6uvMrEOEIe6P6v/zC9r7HGp
 gUd6mOMsOGFzEunmp3sYpru9IpLzUKCNzRvUFWhe8TtG15+nJqMsayghCn3t8j5SCvTtLA0ZiSl
 qWG4YpkB3SVrpGL6W01CrJXvrwxzeUvM=
X-Gm-Gg: ATEYQzyxSbI7gg/wUXM+v9pXwPrWu5DzlGJxAX9LZT8Q90RdnSsgI3ICwgCUuH1nATF
 cH6x2aMYyXpO6jwKiFRafSMC6/JIJzM+9eZbSDRAP6nsU0ws70WcPeuijkLrbf6bG90WQobAaLr
 eDVo67WUABOYfQwYzUzfi9CjEhEIf3ZAt7SpzMHE6UmR0cMOw78z/Wo/ECnRJil9zephUO11gIQ
 wKJL7oNwsP7f4EU6EQxUrjmcBrlnAXTdWwHL4NKwYJSldJ6NeZYAQP3moL3gJsM9+GrHnDZKbns
 /MHFVsEBY1aW+kICbTGLfZkwsumtsw1lDnb89Vg=
X-Received: by 2002:a17:907:944b:b0:b9b:3a4f:ee86 with SMTP id
 a640c23a62f3a-b9b507a4c11mr791115566b.26.1774887562043; Mon, 30 Mar 2026
 09:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <CADFiAc+uCn1diKbpHGJ9yBUJbzaCEwSdmd3mF-42_SeZngqRVQ@mail.gmail.com>
 <20260327164705.1990226-1-hayatake396@gmail.com> <87se9hh019.fsf@suse.de>
In-Reply-To: <87se9hh019.fsf@suse.de>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Tue, 31 Mar 2026 01:19:11 +0900
X-Gm-Features: AQROBzCsy1vpRha9hRL53bcFs84oyVIhsfMMCKoVQI5Ox9hZWospB8N8xvbuVSE
Message-ID: <CADFiAcLuOCT83-OjPQyUmF2wiZW9ZOtz3_66ihj4KtTk1r7h+Q@mail.gmail.com>
Subject: Re: [PATCH v2] tests/qtest/migration: Add mapped-ram/postcopy
 validation test
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, 
 peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=hayatake396@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi, Fabiano,

> Let me just point out that is customary to not send patches in reply to
> the previous thread. So this v2 should have been its own thread
> completely independent of the first version. This helps the community
> keep track of the various series on the list without patches getting
> lost deep inside mail threads.

Understood. I will send future revisions as a new thread.

> This will leave the "src_serial" file behind in the test directory and
> will cause cleanup of the tests to fail. However, I see that using
> migrate_end() here would cause an access to the not-initialized "to"
> pointer. I actually misremembered the code we have in master when I
> suggested to use only_source for this, I have a patch making
> migrate_end() accept NULL that has not been merged yet.

Thanks for pointing this out. I understand the cleanup issue with
src_serial, as well as the current limitation around migrate_end() and
only_source.

> As a temporary solution, we could just unlink() the src_serial file here
> directly. I'll do that myself when applying the patch, you don't need to
> send a new version.

That sounds good to me. Thank you for taking care of that when
applying the patch. I will not send a new version and will leave it as
is.

Thanks again for the review.

Best regards,
Takeru

