Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505FED41C2C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 10:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBADN-0006MR-1X; Wed, 13 Nov 2024 05:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBADJ-0006Lu-Cu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBADF-0007fc-8U
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 05:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731492179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6zq2lDDnLs92cJJXGTtFAx6GsfiGr/nauiqDKLW5M+M=;
 b=ZO4ld7GMOSCVLl9hEHeFS3jZJe88b98x5ujQROTuCyOhrRAV8huFfHS/xhfPcn1RO+FFVC
 Om6kt1B9uFMDQ30LMIu5OUjmbb8FdyjGlzd0F9rAxf/OUNiAdCuDUeggokc4TKRept8aVN
 0QOFFY6K1nyOJUx7j4Y2n3e6gOuPKFM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-x4X_VgVhMgKQEgMSrEUvhw-1; Wed, 13 Nov 2024 05:02:58 -0500
X-MC-Unique: x4X_VgVhMgKQEgMSrEUvhw-1
X-Mimecast-MFC-AGG-ID: x4X_VgVhMgKQEgMSrEUvhw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso3513416f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 02:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731492175; x=1732096975;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zq2lDDnLs92cJJXGTtFAx6GsfiGr/nauiqDKLW5M+M=;
 b=Q4xq5odVlUuUSD+JIZ92j7FvjyrEEcpaIWyKNHhIegGU8t+Ye8pfgnQmLzP8U+YGP8
 mJAV0UHqTt1AX5DFOvnKiqCmOBAfJVqpb43VcQIfwZD7MOwSLgaiEZYHbDuC8O07YWfM
 ilnZ7+wAPIP+WAvHIv2CqJlmOsXP0qNqrXVeGrm3lYD73nALkFR/eMiTBQ8hPGgajNxS
 p7AfbOt6Gt1i0tcKe4OP9tDVxfjpamFnyGNie2zCGrT4t9aOEi3rU1tz5StC9lkJtL9Z
 zfOrQ3hpDkJZYDK1LqXV6TbPbD9qIbLIky+kYtQG/oxVbVJQDJldQZQ/9zOPehnGbOUR
 hWnw==
X-Gm-Message-State: AOJu0YzIJ0hP37fqfjrMdvrjPFc3hO6Zr7KhAkbEwEyH+eQHbjVsOoxE
 ulJWlcAxawcKmHgiOBIwoVceJSs6XdTdh2XMT3S/hEhZVbKn3um/LWgx7jvZJ6M7yVjM2VhZojn
 +Z+LWcz6i5D91wlHl0O90/lPOeY2nSHCc+24A12nRWC7n0dz36181LXVLmUp7pR0=
X-Received: by 2002:a5d:6481:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-3820833ad51mr4291325f8f.40.1731492175411; 
 Wed, 13 Nov 2024 02:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSGFi5Xf4wUzbLlfSvlARlh9juObh68O1G67FQ909E4JQV9yTrfT2GY0/ymTutRDyDTR81fA==
X-Received: by 2002:a5d:6481:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-3820833ad51mr4291300f8f.40.1731492175013; 
 Wed, 13 Nov 2024 02:02:55 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381ed970e18sm17760416f8f.10.2024.11.13.02.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 02:02:54 -0800 (PST)
Message-ID: <6e0f3ee4-0e79-4d26-8ffc-10c893ee8614@redhat.com>
Date: Wed, 13 Nov 2024 11:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/11] rust: build: establish a baseline of lints
 across all crates
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-9-pbonzini@redhat.com>
 <ME0P300MB1040EF4DBFD69EC355D1A708955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ME0P300MB1040EF4DBFD69EC355D1A708955A2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

On 11/13/24 08:14, Junjie Mao wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Many lints that default to allow can be helpful in detecting bugs or
>> keeping the code style homogeneous.  Add them liberally, though perhaps
>> not as liberally as in hw/char/pl011/src/lib.rs.  In particular, enabling
>> entire groups can be problematic because of bitrot when new links are
>> added in the future.
>>
>> For Clippy, this is actually a feature that is only present in Cargo
>> 1.74.0 but, since we are not using Cargo to *build* QEMU, only developers
>> will need a new-enough cargo and only to run tools such as clippy.
>> The requirement does not apply to distros that are building QEMU.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/Cargo.toml               | 66 +++++++++++++++++++++++++++++++++++
>>   rust/hw/char/pl011/src/lib.rs | 18 ++--------
>>   rust/qemu-api/src/bindings.rs |  6 ++--
>>   3 files changed, 71 insertions(+), 19 deletions(-)
>>
>> diff --git a/rust/Cargo.toml b/rust/Cargo.toml
>> index 1ff8f5c2781..43cca33a8d8 100644
>> --- a/rust/Cargo.toml
>> +++ b/rust/Cargo.toml
>> @@ -19,3 +19,69 @@ unknown_lints = "allow"
>>
>>   # Prohibit code that is forbidden in Rust 2024
>>   unsafe_op_in_unsafe_fn = "deny"
>> +
> [snip]
>> +
>> +# nice to have, but cannot be enabled yet
>> +#wildcard_imports = "deny"
>> +
>> +# these may have false positives
>> +#option_if_let_else = "deny"
>> +cognitive_complexity = "deny"
> 
> Just to confirm, CC <= 25 is to be enforced for all methods, right?

I wanted an opinion on that.  option_if_let_else has been more of a pain 
than a benefit, sometimes it suggests code that is worse or does not 
even compile.

So far I've never had any cognitive_complexity error show up, but pl011 
used it so I have kept it in Cargo.toml.  If we start having too many 
#[allow()] for cognitive_complexity we can remove it; for many of the 
others, instead, we might even change deny to forbid.

Paolo


