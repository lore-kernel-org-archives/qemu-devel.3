Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E4FEA80E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 06:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5I3K-0001oh-Dv; Wed, 25 Mar 2026 02:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5I3I-0001oP-FI
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 02:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5I3F-0006MO-UL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 02:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774421349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zPb9HXGk/LMb7TltLfeENvfOZo2obQDwZ/uJhoEKA8=;
 b=c1qO2OOnUIuYgUMfKbnLa4zIkk8PxcNv1AyERO4LtnDxS9qUBmzXVGDjBmiPu2U6Ved4c1
 cadEEhwAYQ8sDpHnA1IXuykAjpqrxPFPr+sPXnd0xjLPdJ7Ot5LRuICsNZDKROYuM6uwkn
 j+8UPLTcfXqY1Fm3oDSopoXYhOPmJkI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Q6YbHbwCMUWdpD9GTrgjAA-1; Wed, 25 Mar 2026 02:49:07 -0400
X-MC-Unique: Q6YbHbwCMUWdpD9GTrgjAA-1
X-Mimecast-MFC-AGG-ID: Q6YbHbwCMUWdpD9GTrgjAA_1774421346
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so3302814a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 23:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774421346; cv=none;
 d=google.com; s=arc-20240605;
 b=dHmhtGG38Mhkq9tLyDzdTal9ndzCLhluLbjQEG2ItIkXyKbYc6J/a9mtMYK4DsP9vW
 uQ9kiRlWRL9ObUXVujVNTk7Hi+Zi+5SjXrAerud/pwkBP/D89H35HJijEvBWqZRS4Ovx
 5CchciyieB+KJkkOoypAc5bYVNHD/aO98Yo+sFPMwoKCkEOFHJwDxTANOMgH8aBKX/f/
 1R+JqhOMoSFWdPqCCDrARymyN6RDvj5DAafc9ZYDQ3guRJ0HmL9RL24SK45JT8bPjx2/
 5ejMIIARHah+4EowvazDlCb59xuDPLRlMuhz62ugOxklkr7yOo5dW1dmdAV7uwKyaqlq
 JCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8zPb9HXGk/LMb7TltLfeENvfOZo2obQDwZ/uJhoEKA8=;
 fh=pljgQb51SI5T8fJjT4f89PH4vuf7hUTqYcKOSXi3vR8=;
 b=kjpw3x2wBmM4oTOzHInEDVc7bnyFPGB3PafD9zNTCeQBINxS1wHZTR+Wvkglfbill2
 sHWWGi2GjbNwvkkR/yTOf75R+m58up6Dhu3OBmBA66uGcd20zODByg4AwDO3XXH27K5q
 iaj+8eYYAZKKArA+nQ/5PUFNKqM0BHfnHFAdgYdG0BLwOnCyj2SMYdaPLiCui8WyWNJB
 J6O3HGibYTh4B2tJqTfooLqmGGtw+OviYNV6nJ+5DAX++vbuOZNIoOo5ultCwPfs1ckS
 35HAwHGQhQDp3/WSs7tvhTbSMPUdJsDIrRSifX/SZOoq5KdQRx5SW6HJCN3+wuwlcSHX
 aLrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774421346; x=1775026146; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zPb9HXGk/LMb7TltLfeENvfOZo2obQDwZ/uJhoEKA8=;
 b=DtIlLKy+tpzfKYzUc21ts1BaqK1Rc/+ScWF1yw/qKQXnOeMcXT3mXgCj3jY39kgnNU
 bQ2zOG+ZbClyJjJSJHbZbkAjpyQR4aR7gBXGRZY46wFkzTa9VkuvlTe8/5+BQlp0SZ+T
 bY51+u4PSg+O/l0/FC5Nuksk6HyXc+L8eg6Ah+ZtHMl0XhDygJZEM2vAf6kHF5fC4/mX
 APiUZsVm/10wjt7ad+V8ZngLEPpzE2a+YDeBqomStFvX43MGvRaouUbkvT5TyjG+ehYi
 VCMNbz1Sl92Ps3BrFdYCZ8o0Jek0M542GuINfj7qzI1hDQ+HTonbzahU9RLmhIoaZJ1w
 1jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774421346; x=1775026146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8zPb9HXGk/LMb7TltLfeENvfOZo2obQDwZ/uJhoEKA8=;
 b=iI6H12FEGsN1oyPyo05OtO1G4pMItdZXxe+bpC7aoMBJy37y1n/B4efhjus7bjg4Om
 H/HaLqt37m2J0XHjNJf7TteftBrAZd48oTROJUPWKV/VLiZVkCaTK65gnfA2J+RRRxgA
 QFPdNAQaLflysnVXsxP62Tsz4XDcFO2uy6kn2EIiEFPxASq0vX1s4ssjNdKLKKmnhuzr
 XyqZdzltdE/v4vXPNWuxmNEw2pp9dqRO13iN2JOVoPmQarlfyjQUSLWJq8LFvmXhNFIn
 T8MP9l9M05WJlgD26JMnWA/7/OtBtSXulDF0/UDs2m3Kk8x/tTDLsBKDIPU4zex9VCAf
 TkAQ==
X-Gm-Message-State: AOJu0YylBRVspzJqpusSa1L0kXFEhZDZ3HxsVBgrwmS8W+TgcP/0NjsB
 9HwCspz8WZye8QZif7oDE42bckcVLlnRkaOxcRy6ci97c1FY6gDKr2X8W/7XS6lG7KPyPK4QR0T
 JZvj7pjsvxuuAaanM35gKJX9iRKLWRijOxdPCaR0N+2EHXVNMg9CUsiIv7gOmoW0VIuW+4Seqts
 xUA5m5Mwvvx5vkJWJ8DIwnXE0tmKIgJmg=
X-Gm-Gg: ATEYQzzyoQTTCFnIWCdywFYIPOnMbi6BJgd0ICobbvfFOxzBt2UdVA8eLmbKYVCnU18
 UNE0NZMrjZOOO8vOvkOgj5pV1/dW2TfdWE/kPyU4MG82hPf4We2q9nNxfaLFBNMRWZmesB0DFZR
 QPWm6YcZ+jKYvxhFyFl4pSZ9JOODY6ZsXqVr1N8JmrxncmTiPVtMXu8oLS4QhtxmNAnk+7+DpuW
 VjMcp3qn57cBuJ6jLrVDr/5ddKiUPUeO2RNwkwZC2COSAskzVBvuQE0sg0vmZtFyhB/KzrkbqoH
 foLW0G8OihcjLl7itYK3Xfw=
X-Received: by 2002:a05:6a20:729f:b0:39b:f026:6f8d with SMTP id
 adf61e73a8af0-39c4ada9073mr2580616637.43.1774421346078; 
 Tue, 24 Mar 2026 23:49:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:729f:b0:39b:f026:6f8d with SMTP id
 adf61e73a8af0-39c4ada9073mr2580594637.43.1774421345566; Tue, 24 Mar 2026
 23:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-11-48eb1dcf7b76@redhat.com>
 <878qbgpj31.fsf@pond.sub.org>
In-Reply-To: <878qbgpj31.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 25 Mar 2026 10:48:54 +0400
X-Gm-Features: AaiRm52lP2An-LpLxP6wM9jHcX2Bavx3y-Cs1NFnxdPOp5VwPFHbQjaeWrRgNTU
Message-ID: <CAMxuvayGCvJwyUgrHSGwfLhqAbVC61dEbgbL4Ji_0YQHyv4LJA@mail.gmail.com>
Subject: Re: [PATCH 11/60] ui/console-vc: add UTF-8 input decoding with CP437
 rendering
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

HI

On Wed, Mar 25, 2026 at 9:35=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > The text console receives bytes that may be UTF-8 encoded (e.g. from
> > a guest running a modern distro), but currently treats each byte as a
> > raw character index into the VGA/CP437 font, producing garbled output
> > for any multi-byte sequence.
> >
> > Add a proper UTF-8 decoder using Bjoern Hoehrmann's DFA.
> > The DFA inherently rejects overlong encodings, surrogates, and
> > codepoints above U+10FFFF.  Completed codepoints are then mapped to
> > CP437, unmappable characters are displayed as '?'.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Have you considered the decoder in util/unicode.c?  Do we need two
> decoders, or could we replace one by the other?
>

Oh! I missed it, I should definitely try to use it.

> There's a mad UTF-8 test suite buried in tests/unit/check-qjson.c
> derived from Markus Kuhn's UTF-8 decoder capability and stress test at
> <http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt>.  How does
> this decoder do on these tests?
>

According to the author original article, it should pass
https://bjoern.hoehrmann.de/utf-8/decoder/dfa/


