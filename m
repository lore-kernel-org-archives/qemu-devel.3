Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26798D3C932
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3DU4-0000MG-2w; Tue, 22 Oct 2024 07:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3DU2-0000Lc-RT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3DU0-0003SB-P9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729598126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MT9LPovizU10DrLUw31ld4DXRW76G/cS+vGzmnbr6Ec=;
 b=GUZzH6vEdJlNTrTvRcu0PUnv78MxVSjPjUKKpPuHGnVWhY07Sak0ndUMzRDbBVjUb2gOgV
 lPrhSe5Tl4v/KDtvvNXWfaSAy6mwdTL2iymynaep36OVYVdzoC04gj5YD+lUXD5n2DvOen
 l38t5xei4qeCavm8HB0zSDW7Yx8poiA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-eGrCMOMvNhe8vukuS0lI6A-1; Tue, 22 Oct 2024 07:55:24 -0400
X-MC-Unique: eGrCMOMvNhe8vukuS0lI6A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso2691403f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 04:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729598123; x=1730202923;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MT9LPovizU10DrLUw31ld4DXRW76G/cS+vGzmnbr6Ec=;
 b=eXMC4h/TRj5M1idZD0D4CtYN0B3wdYQLEvMBjA+QwRh71HgQQAJNaabwnsTGtRdL+b
 L+PNs155V1vsv9jveil9mDw951Iz/2+bc0/c6GqX5Isl8KcIpOca3hDhinS6lel3khCJ
 J3LqBFczgTqfnG5LhSKIIM5FLSwFRbpkKRiS/y2sUbHJM/xIeDZy/IYgIfL9xRqEmpsu
 ddAWIJnpfYp8x4dBKG6NOj/RYZSbR2zsq9y9ZZuDyC2+bL7P1/IK5jYa6NUQlQpxaqnI
 81AnRqTDOqFUtmaBInp7GK4Msu/RuOXzzhjw2kxkZoBilhneQRtt2Cb9/vtwCN+kVUlI
 M8Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjjFeVad+HulTLUSqkzTSSZBsll0CKVAC7ZyexmTnD7q23pGrKCec6t9X2kGgrl85H2zl6bwhV5wpU@nongnu.org
X-Gm-Message-State: AOJu0Yxq6a4B9ptpZ9VRJde4Ok1o+RoLK7VUmZse91DWoFCqgzdnwPIJ
 AM0FiCv/zOje95ez1Ko3BMW0TKtbsBllM2uQkcGTbwMeD2c+N2aS4zkYn1HYCHxe7ckQm3c7giC
 sj7UHAQLMU74ur3LD5iDjrzyOWQLYwFTL92in+YewFoIbRL2Cw0GN
X-Received: by 2002:a5d:4e52:0:b0:37d:39aa:b9f4 with SMTP id
 ffacd0b85a97d-37ef0b8fc82mr2082903f8f.26.1729598123577; 
 Tue, 22 Oct 2024 04:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESeQAx483sZTvokSR0ueXEWhW5TSxAzVUEOFP0JKmCX1jXJVd3kDIs5gliH5Uz/PQ2exgyBg==
X-Received: by 2002:a5d:4e52:0:b0:37d:39aa:b9f4 with SMTP id
 ffacd0b85a97d-37ef0b8fc82mr2082879f8f.26.1729598123179; 
 Tue, 22 Oct 2024 04:55:23 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a48882sm6448725f8f.30.2024.10.22.04.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 04:55:22 -0700 (PDT)
Message-ID: <8972a17e-6a21-4480-9848-44b384672186@redhat.com>
Date: Tue, 22 Oct 2024 13:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, Michael Tokarev <mjt@tls.msk.ru>,
 ncopa@alpinelinux.org, bofh@freebsd.org, emulation@freebsd.org,
 virtualization@gentoo.org, dilfridge@gentoo.org, hi@alyssa.is,
 edolstra+nixpkgs@gmail.com, brad@comstyle.com, Thomas Huth
 <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 dvzrv@archlinux.org, anatol.pomozov@gmail.com,
 Miroslav Rezanina <mrezanin@redhat.com>
References: <871q16fq9c.fsf@draig.linaro.org> <ZvWPH1f6ZnvH1iYZ@redhat.com>
 <875xqh4kt0.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <875xqh4kt0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/27/24 09:28, Markus Armbruster wrote:
> A deliberate approach to explore some before we go all in could mitigate
> the risk of taking on too much technical debt.
> 
> We obviously need to write instances of each interesting class of things
> to ferret out the problems, and design good interfaces.  I'd recommend
> to write few instances, ideally one, then let them mature some before we
> create many more of them.  Prioritize gaining experience over quantity.
The "first" device to be written in Rust, pl011, will already require 
developing C<->Rust interoperability for QOM, device properties, 
character devices and memory region operations.  The first two are there 
only in an embryonic state (the bare minimum required to create a QOM 
class in Rust) and the other two don't exist at all.

I agree with you we should prioritize gaining experience in those four 
areas, over writing many more Rust devices.

Paolo


