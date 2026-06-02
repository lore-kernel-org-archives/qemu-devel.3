Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDA7C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKx7-0005q6-6J; Tue, 02 Jun 2026 04:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wUKx5-0005pv-3g
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wUKx3-0008Rv-G7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780390697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hUJUKeqFI2ACtrQxSA71ULOMN3IMziD0tUnHV6iLoY=;
 b=c68e1uE+A1KGd7gUPpU1vn5+/WeOzDYVFJRxySET80O8KIAo417a5fOC2JAu3lh0Xar/7+
 6oYxf7XcdL4jJbv1OX3yjanH69YXclUyAVB6eTZRHcsxD3hga7EFwbcsSTQ15GG+8uEQ95
 MSjK7CVq4eECO2wc8I3Xpu0QR1h80wo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-cxI_wm3NNiOrXbFTLeX-9Q-1; Tue, 02 Jun 2026 04:58:16 -0400
X-MC-Unique: cxI_wm3NNiOrXbFTLeX-9Q-1
X-Mimecast-MFC-AGG-ID: cxI_wm3NNiOrXbFTLeX-9Q_1780390695
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490ae4d89e2so12285185e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 01:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780390695; cv=none;
 d=google.com; s=arc-20240605;
 b=C6KCbjlTrJeSxEgTbD7S9AEWTBWfntwfB0MhpBzJvwzegt9139y/3RTEWdCBa+SWqy
 v4ftGOapnzdW/v3YzIfxeKdinaA82tGYIO4OvTybOyHG9KRbG6p28TQhrvEBveddVO/x
 mv+i5hSihf3ACNF37tjkdk+7L+6OvdQGwpOM6hXm7CYykVXhjZiq/RxJlhKjkZlHYZ4P
 n7CAiKVbseFpHbvCKVv8y3fbch/fd4+yGuCBGceZKPiIpVFO/0N1LzZGmzE8QU/aApnu
 +dZeP9c/9542XdFpA4fdSZxIPsXLDtSx56h/uvE6LoBMvtHnJtFFlI3P0srblDKWcXqJ
 007g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0hUJUKeqFI2ACtrQxSA71ULOMN3IMziD0tUnHV6iLoY=;
 fh=OWGw2x5ZTX48WOT0zJPwlkeTaspGK1XwEA2F0cGP0Us=;
 b=TNijfxREUX2aRHXiGxfvZIv/dwR+qvWAuGhFqwW1IKYlZK76TdK/ITpC6w2Ks5OQwj
 JtO8lbOiqmpZ0GXxMdYfyKd5sewYTqiAgHnE34SJWcQWG24Ohqm86hvEHuzoZ8yBa5gc
 KpDFqdjjYQhiKYxV0wk4rnsXPMzyfD1biXOGEg47zb9ZD86m1FKEfijMEX8Lgjp5NL5P
 XDPoqqBXaJ1fIprwdoAardfJ5CWEazSVbepo6Cu6Uhr7NeL+vRqVUnp10QxkkTONe5ug
 SKF4AmT/wXdn+PNPSLKMqAgvzbEi0u1wZrIR8YbPi473mz54bl4zB67oCZrSCCtTGYSz
 2HXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780390695; x=1780995495; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hUJUKeqFI2ACtrQxSA71ULOMN3IMziD0tUnHV6iLoY=;
 b=HawlZb9jnAVxeWjalU4BVv7NIMwZdCmtYJp1mXFecZNMC3e+E1Ayu7OupiovFTWm4j
 //Euv89tyT6uDy3x1547gEUL6dUFmlhinXfPPvvcV7ovqsMTomDSo9ofgBhwKoA2gSoe
 PSbj9Cud9zrCVZoUBGW8QZJxH6HJvDt0oV4ToPQpElAoW4gXb/btlJ6OkJz53qahbV80
 nPD00aKsi3O7HZ2Tzb2fVqpYrRcAHfWc35yI+/U1zH6a1H5zLux0ZdSFUTB9jTH7i4O/
 r3ubkTGdoqzc68Cl8iE+FquDK1SMnF9V+b8N/wHjQBqi1f1b6tcXTcupGrQZSsLlI5++
 sSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780390695; x=1780995495;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hUJUKeqFI2ACtrQxSA71ULOMN3IMziD0tUnHV6iLoY=;
 b=Ej1u96Z7dT4N+F4otry8br5Vzdb66P8CtQ8SCchHcu4aqK6JHnRyBTAMU2tCYf52DO
 5EAiP/ns2smPWxzGhED62Ltu70PGPijDhxGT605igDlS+wVFqZAmJjqyjqUy7wzy945o
 wlBHorzJw8JhPqIWUDYkqZGGGGy0ECRKegvWtAIF7EjSs74Hit1IkgHzlxxfayz2obXM
 fWPkZCNG7GtHX66yGL+1ppgxEXhrWAowOizt3zeLS5DnqVQCZkGe0L3raRllfLDEaJOh
 J8WbUhl3ijTq9VXR27QWBz1PtCOc7fod2FPfsa6ht/EwwN1DqkVW2hqPBT/V/jWm2AUq
 qiWQ==
X-Gm-Message-State: AOJu0YyrwzExW27aYWmhTel+nw6yXJGxhI3SGlQJCjDGrIytO4UTjJAE
 BFIeHef8ltU94i2a7trzhO0ygPNVxZyYntEgfBihJS2hL1LCia4WYTLBb9bkpmhWTIYvayTPDLE
 cCLO/rjhwKtUim3KTuxupDexdHMEpvgWi7J7d6KE2Xsf4vOqfOsLzG5Gvish+xEPo0689hlad18
 isOPtGPkZJV9s1Spdfvej9u9v8h/qxLDRTwd4gtH4=
X-Gm-Gg: Acq92OFAe5uApMSi7ub+aan9WblZWb+Lxlipstm8RZd2spcAGYMJ14LjFuO3DYl8iyC
 nO73kPt+eG9Q64FGCKq3nSgcn0hhNVutJ25jFnTdC2fueZa4/3b8fDBk8mesX4l4vhI3uKArNU5
 cOKxmy+hn47/EDbhGkFGwmXgqObZSlhXxeyifh8MFCxr5RKf+OzYQosEP7ebViCq81zGgjdb91t
 bVBHbpdFX/b+M6yKfP99U+u2TSyzUFtE4NWt4xU+XwAL/JD8QRCKKJfsSQAAIZC6IWX4FTfGk3F
 8cyNAQbCMs3gPMC4/Q==
X-Received: by 2002:a05:600c:630e:b0:490:a2fd:e1e5 with SMTP id
 5b1f17b1804b1-490a2fde21dmr266558785e9.17.1780390695213; 
 Tue, 02 Jun 2026 01:58:15 -0700 (PDT)
X-Received: by 2002:a05:600c:630e:b0:490:a2fd:e1e5 with SMTP id
 5b1f17b1804b1-490a2fde21dmr266558195e9.17.1780390694781; Tue, 02 Jun 2026
 01:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260525150503.393743-1-pbonzini@redhat.com>
In-Reply-To: <20260525150503.393743-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 2 Jun 2026 10:58:02 +0200
X-Gm-Features: AVHnY4Kdqdj8YWh6Dk_5r779ajLlTN1dzhoyA0ALhUI_cLFlEHvJQ9Cbsl0Yf7c
Message-ID: <CABgObfbUo0D2M_t9ki2bCywFGv2rdGPn6fiB7tijeSD5-P-jMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] qobject: switch JSON parser to push
To: qemu-devel@nongnu.org, "Armbruster, Markus" <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just a heads up that I'm planning to include this in a pull request
around mid June.

Paolo

On Mon, May 25, 2026 at 5:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> This rewrites the json-parser to use a push parser aka state machine.
> While push parsers are inherently more complex than recursive descent,
> the grammar for JSON is simple enough that the parser remains readable.
> There is therefore no need to use e.g. QEMU coroutines.
>
> Unlike the suggestion in commit 62815d85aed ("json: Redesign the callback
> to consume JSON values", 2018-08-24), I kept the json-streamer concept.
> It helps in handling input limits, it performs error recovery, and it
> converts the token-at-a-time push interface to callbacks---all things
> that are more easily done in a separate layer to keep the parser clean.
> However, there is no need anymore for it to store partial JSON objects
> in tokenized form, because the current state is stored in the push
> parser's stack.
>
> Another benefit is that QEMU can report the first parsing error
> immediately, without waiting for parentheses to be balanced or for a
> lexing error.  Error recovery then proceeds as before (i.e., the next
> parse still starts after balanced parentheses or a lexing error).
>
> On top of the benefits intrinsic in the push architecture, it so happens
> that it's really easy to add a location to JSON parsing errors now, so
> do that as well.
>
> The diffstat is unfavorable, but most of the new lines delta is really
> new comments explaining the grammar and state machines.
>
> Paolo
>
> v2->v3:
> - accept interpolation for the key of a dictionary
>
> v1->v2:
> - remove part of the patch to pass around the lookahead token,
>   it was hard to review and added little value
> - separate patch to reuse the JSONParser
> - separate patch to make brace/bracket count unsigned
> - add comment with the structure of the stack
> - add big comment with the grammar
> - split long lines
> - remove QObject **value argument to pop_entry()
> - add assertions about the type of the top-of-stack
> - change error to "key is not a string in object"
> - split out json_parser_reset() already in the first patch
> - rename json_parser_parse_token() to parse_token()
> - do not use single quotes in commit messages
> - move initialization of JSONToken close to usage
>
>
> Paolo Bonzini (7):
>   json-parser: constify JSONToken
>   json-parser: replace with a push parser
>   json-streamer: reuse parser
>   json-streamer: make brace/bracket count unsigned
>   json-streamer: remove token queue
>   json-streamer: do not heap-allocate JSONToken
>   json-parser: add location to JSON parsing errors
>
>  include/qobject/json-parser.h |  16 +-
>  qobject/json-parser-int.h     |  13 +-
>  qobject/json-lexer.c          |  11 +-
>  qobject/json-parser.c         | 580 +++++++++++++++++++---------------
>  qobject/json-streamer.c       | 120 +++----
>  5 files changed, 415 insertions(+), 325 deletions(-)
>
> --
> 2.54.0


