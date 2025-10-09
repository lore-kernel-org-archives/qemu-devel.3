Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D4ACCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tqE-0003Nz-7G; Thu, 09 Oct 2025 12:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v6tqB-0003KD-El
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:50:07 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v6tq7-00054Z-Ry
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:50:07 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo234865966b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028595; x=1760633395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHR4Astf0JroyyZ/x3REtpgfEQ1dvBkAA1KgBwwcXRc=;
 b=Fn3W28F1pHRd/glkRCqwNAXXkAIWDTH2fbJwVNgATXgkghnKtYbrPGdikPrWiAFY28
 RCyvfhL5KhCSBU/pZSjD6bmwzhQexS8RznMm5ZjHDqQlgO6m2P8TyCIPSYNkzkiaoe+1
 7EIsTgEFimwQk3Kui0WS+RM7fBGXq+Pk8NdlVJfECkJPs7rOsKHIjUYlTC7JWBup/Eex
 wGyDAs+TJOZq9nGV5FP8fcVIIjhaiWGHl1YUjKF3RmopzfYBCLeMs+E6VRn4ZPhDZRNW
 BR4XoTor2B9+x6YZEeLh8tnjcPkXdBWMfuoZJfxRHD80bq4niIjwRnl6P34Yy/VVAjxn
 AK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028595; x=1760633395;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UHR4Astf0JroyyZ/x3REtpgfEQ1dvBkAA1KgBwwcXRc=;
 b=ILV0UfFnMZ60lIT6xbp1Kam8aYnTtciT65chVZUvKZuvxMfzps8BDvj2x6RMimKFp9
 w13/fcb6KzzipW9BtS7wpVHXsM/12e6jMrURWpxy3Hh7xQ6qepiVh2+BIXEe/5u3re3h
 CNlBK+AzrdEO9XKKUZ4Ffpkjv+WEYJGHNtOktAZaLCS2vvUR7mhl/iRNuyvTzpJwyEg1
 Szxvl8jRQLcjQH/5QJf3Ue2/kgpt/HxEGMEXqhjsStsu0J4bzOVQXaq0llSTb8rJQ1ED
 4wuVR6MX3Q36I9nXXTTLhfPwf8A4rddSByjq1bmRLHX4FypPoiMAr+2dxVCcwiUa48B7
 L85Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXcsEQMrEb+aAcI8/rKZ4ucxH5nLBZvrP4BZwmUC4vV/fNVjmh0KLfOR8r5XO9BfsUuBPA83FWS3Iu@nongnu.org
X-Gm-Message-State: AOJu0Yy19D6Xnc3RaZl8H+tb5d0rNAoFd9yF5AeWanM47WnKEPTwIL5z
 wDOgxad0j8GowFkM//bx8oKkXwyIS11C/v+kyeeObGAtPgxGkqW5LJrRGWD9hkLt22Y=
X-Gm-Gg: ASbGncujfHT/G3KI3ND8Sg62rC7733DnpArJB5TxRqVuM74bvyTlS1iOAr4wbhLW7Ov
 Xcw3jCTL2Wa/lyuvwhcBhWgXDb4zWgzNtoXgiRPzY5ewCpo4OeNPkS8ZKX2vaNkPDnaaJaFLTKQ
 XSzVMqTHC9JqLF8wn8noiT/xnQ0z7W+1v4TonZFN1TWKEo15LG377lpBVHUoXXHvj1BQ7snoPp4
 t7I86v7SNxLhk91s/iaY8FkPICbO+49meIJ91sLRXheZJ/rTX/Ysw+9rF/+T76IuUyZRI4/fkZY
 LAjDbX2i8xy6O5dzKDmfj+jCGvvKgI0YzCZ+HwPyZ2bTcR7k9CaPV/PVQm8mvb5aY0ywLw0J45C
 6O1owtbNVDubSg5SjKu7nrXB++7wjbPvuo1FF6jV9BsAqei6F3yAHZSgzq/prCA==
X-Google-Smtp-Source: AGHT+IEVVs0SxDwa7t9gnRXCHLnAdDGss3pzLUpjVqEElZKVIgofwUkFGlF4iNsgq9+QilBJNQKBbw==
X-Received: by 2002:a17:907:3e8c:b0:b46:cc3b:65fd with SMTP id
 a640c23a62f3a-b50aa99e1ddmr843680666b.29.1760028595326; 
 Thu, 09 Oct 2025 09:49:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d900e3ecsm13023866b.67.2025.10.09.09.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 09:49:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C36235F898;
 Thu, 09 Oct 2025 17:49:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Christian Speich
 <c.speich@avm.de>,  qemu-devel@nongnu.org,  Stefano Garzarella
 <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
In-Reply-To: <aOeMWq_RbN8lLwSk@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 9 Oct 2025 11:20:10 +0100")
References: <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
 <87y0q6mscw.fsf@draig.linaro.org> <aNpBqlRmdOac7U99@redhat.com>
 <20250929042410-mutt-send-email-mst@kernel.org>
 <aNpaSpF_qY6z03Q3@redhat.com>
 <20251004133102-mutt-send-email-mst@kernel.org>
 <aOeMWq_RbN8lLwSk@redhat.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 09 Oct 2025 17:49:53 +0100
Message-ID: <87y0pkvx3i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, Oct 04, 2025 at 01:33:48PM -0400, Michael S. Tsirkin wrote:
>> On Mon, Sep 29, 2025 at 11:07:06AM +0100, Daniel P. Berrang=C3=A9 wrote:
>> > > Well that's because e.g. kvmtest actually depends on pci-testdev.
>> > > IOW it's actually supported.
>> >=20
>> > This again just sounds like a downstream 'support' rationalization.
>> > I'm still not seeing a compelling reason why the vhost user generic
>> > device should be disabled by default in upstream, especially if we
>> > mark it as an experimental device with an x- prefix.=20
>>=20
>> We can do that. I am still somewhat puzzled by whether making
>> it unsupported/experimental addresses the actual need, which
>> seems to be to expose it to end users?
>
> My interpretation is that simply having the device exist by default
> in QEMU builds is the minimum bar. If we declare it supported, then
> that is a "nice to have"  guarantee for long term.
>
>> Once something is used in the field, we can't take it back
>> whether we added x- to the name or not.
>>=20
>> What are your thoughts if it's not marked as experimental?
>
> In general my view is that we can't protect against user foolishness.
> If they provide inappropriate configuration options to this device
> and get broken behaviour, so be it.  If they file bugs against QEMU
> our assistance will be very minimal - they get to do the debugging.
>
> On our side as maintainers, the important question is whether exposing
> this device ties our hands for future code development.
>
> eg would it unacceptably limit our ability to refactor things in future,
> while keeping compat for this exposed device ?

The arguments it exposes aren't really going to change. All it does is
allow you simulate what the boilerplate sets in stone.

> If it would be an undue burden, then it would be worth marking it as
> experimental to give us the freedom to make incompatible changes.

IMHO no I don't think it would be a burden.

>
> If exposing the device has minimal burden anticipated on future work,
> then no need to mark it experimental
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

