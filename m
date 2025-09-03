Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7353ECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 14:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uto1d-00018E-Vf; Wed, 03 Sep 2025 09:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uto1c-00017h-31
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uto1Z-0004q6-W2
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756907981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6Sr4LPeuhVaxzD3VvmMyYOP4t7wOQNLsdQaVXpHUftw=;
 b=A0idlBIV26t53SY6NPzHN+kgu8gsNvA2VC7tNKAYYXDavqnO40pRk9sFAB5sLw3VtBi2eF
 hhYeMvGlB0T1XPpyRYLcIeXvWP8LNXg32K0x1WTdtv9q0ZR4HUJpdw17IVM7DCAkz1tpWR
 r0XYN/VJzXDbVPZdt28+HUMAw7BLeNM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-BExEc5WaM_y7odUEMrnnsA-1; Wed, 03 Sep 2025 09:59:39 -0400
X-MC-Unique: BExEc5WaM_y7odUEMrnnsA-1
X-Mimecast-MFC-AGG-ID: BExEc5WaM_y7odUEMrnnsA_1756907978
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b8af0b986so7616445e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756907978; x=1757512778;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Sr4LPeuhVaxzD3VvmMyYOP4t7wOQNLsdQaVXpHUftw=;
 b=RxJ/Tj+Gcmtq0Q+WHG505lHMQvamM8Y4c6OYlUZB/COZO2TBCf5sQQGEbBXs7YQZVR
 KkaPewKpWOXREMQ4qqzB6l3VN3WKw4BHBf30aaLWeim1uL6/RJyETBRv/zvzjSFS2lTR
 tlksl38HuSQkHZa8tTOE3GE12Kfy6Z8bFNEnqo6OViiauNoGtlvZWjc7fGMRM9yim+SH
 P3s6iuUlgtL69m5fPVYI5inCjRTNVRol23HohTU417nc4mM4SysDAAaPhiFeSvGh1eXD
 L5mJ3pEZlxj5zaJDtkWSWIM4ahiRV0z6caJlCywZY81pMvWRDkouHAtCykaKKtf0rQ3X
 NlBg==
X-Gm-Message-State: AOJu0Ywhk3lmQcK2FcCELezbtBajdntgHQavxCzactem7sQiVd40ewL9
 f/wodm+0kUXNn3nszbPDMh1Rwx1Pj1mC+ew1rgu1Ap1I6NjJ8uVJGRCwfDFfA5cTPKcdvfiAfAE
 N1Qxk9YKxinmZdjV+hWm4aBe8jfBQ46v8p1lb6VwQnsDv+I7oYMVShqUz
X-Gm-Gg: ASbGncvgxCRKrcn2l3ECoV8ZDzDnW6NsfPSNw0c8a1n+lybZG/Mhzhm607SJ0kVB3iQ
 fk+PkN8CtVrDOMrVI4skJW/mQAQOiNS2HWJ5w+bxi98qMcDadJ7wqapKvl2ihH1RuYCzJwAkCbh
 ezENQu4v34VK0kWHpSW35TiQ3V09UEHKNL7kSHlBPqH5l4l8wYciUkJqMNKqBJE4Saw1h9ec0Eu
 aHXvKzuoXBPosmsuMft3YWLCXPTmzZLqY22lnSa5gMsMl+prG78MXyWFStK9oGKio4kqOlinK01
 FejU/viyDKOYGycTlfJISM2mQDq56OcCgpJApjrG0hnhT2p7zosbM5mpLFGRCptJMMpdsce0MFO
 YEfEjaM6x75MwmeGLeFb4Y8Ype/Owi2ifsKUP6mlMInl4LHAYNt8HqnD30JCbp8VlH+4=
X-Received: by 2002:a05:600c:4f83:b0:45b:7deb:3f0f with SMTP id
 5b1f17b1804b1-45b84c2256bmr143241935e9.2.1756907978292; 
 Wed, 03 Sep 2025 06:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoCcQgY7XEj4fg/SZrc2TJX45FxjKGGm5bYB2CN3SFATgK/aR1lXRiQib/EDoePqQ1a9jjXg==
X-Received: by 2002:a05:600c:4f83:b0:45b:7deb:3f0f with SMTP id
 5b1f17b1804b1-45b84c2256bmr143241725e9.2.1756907977922; 
 Wed, 03 Sep 2025 06:59:37 -0700 (PDT)
Received: from [10.32.181.22] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3deb99d10a0sm2255197f8f.37.2025.09.03.06.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:59:37 -0700 (PDT)
Message-ID: <1546553e-a21a-4a0a-8bcc-6c4e23ff35e2@redhat.com>
Date: Wed, 3 Sep 2025 15:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/30] lcitool: use newer Rust for Debian and Ubuntu
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250506152927.222671-1-pbonzini@redhat.com>
 <20250506152927.222671-2-pbonzini@redhat.com>
 <CAJ+F1CKZr2PZbXvi8OZ9O=QaGv4WUmLPofBzqDv4VAV64y9EnA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJ+F1CKZr2PZbXvi8OZ9O=QaGv4WUmLPofBzqDv4VAV64y9EnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/3/25 15:54, Marc-André Lureau wrote:
> Hi Paolo
> 
> On Tue, May 6, 2025 at 7:30 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On Debian, the rustc-web package provides a newer Rust compiler (1.78)
>> for all architectures except mips64el.
> 
> Unfortunately, rustc-web is not compatible with the cross/multiarch
> packages (it will remove all libstd-rust-dev:*).
> 
> Should we switch to rustup in the meantime for debian cross-compilation testing?

We should just switch to Trixie, which however needs some work in lcitool.

Paolo


