Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CE8C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliho-0006dz-Dn; Tue, 12 Aug 2025 02:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulihm-0006dl-Oi
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulihi-0001cm-1o
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754980906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L9FH0kZ+NjskoxupWY9dq+x/CoWvJSAF1Y1rRXflOTg=;
 b=h7uOZVA7S893QVsktsUvJuxro9R6rY0FFzB00J/wB94X4n3L9m9KAPsvJRmmD/+WpvP7av
 1r/RKPjDZD1G0/SmIZnzHlv/bY6ckfwhQ4Y2T4tn8W4GqSNjBnWYKySRGECLdD1J1p99Yk
 fRFP3A7ATYXZ757jG1fXBhAsSRS9ef8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-TSG8a2HVMbekCoRDcdktyA-1; Tue, 12 Aug 2025 02:41:45 -0400
X-MC-Unique: TSG8a2HVMbekCoRDcdktyA-1
X-Mimecast-MFC-AGG-ID: TSG8a2HVMbekCoRDcdktyA_1754980904
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b788d00e26so2779174f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754980904; x=1755585704;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9FH0kZ+NjskoxupWY9dq+x/CoWvJSAF1Y1rRXflOTg=;
 b=itgGg2i7BKBiBNOYq5jGtfXBGpBSSFixQZ7y9lkc/Vn9XdxM7SxToL2a/YW72yu2t3
 dq+WAKNwrXU4hHOPY6I3Hs9Dkt1wyaHCpyYXNPKDiEoVJHXf2kckn/Ofh1V1ypfpxxtM
 Lhux0MXhsCk4oRq07uUftb9aWjUuuiDfCK9iRxw8CJMH+4VP/EKSWlpckzFREf9mqtkD
 2LSZmQ2bvp8nN1NGDM+Nu0AQtxqwzEgK+pSpk5oV8tCGqzHIqd2JvwBq4yUN1xOHeb/N
 UGA2JIy7yc67lkX0ev+Lpps0dL2dJG+8yJ2N+DAD5fUKIPzg46OvAIjIh74oRErJ6UXv
 3k8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh72VoGGSFKmxq3TzA1Zr17Y7Xyi/1+ZRCVD9HspGd0Ex1PFUM7t4TFUdFRFvARWLtcjCpdZJG1LSD@nongnu.org
X-Gm-Message-State: AOJu0Yy83kCjocRiYDQi9C/mibyX+mo5Y7xQrLrtnCiLCOC07G7BOU/n
 MwshlUWYhDNGPmo4/7h6y06diDzgtEN6HexwMRePFqUfWb4dzdX88BK0cfLm3cQk/uYb+TdgPEf
 DO3cTNOcQExCdWfRY0Ijzm1tx5K2ZxWc+BKth6nU3YZTPCgezhzs/+jzm
X-Gm-Gg: ASbGnct+ofR36sS13/BtyIU3oP5rnEDOE/yKmDBqoxR8HYkA+UkVWeneKU6qBSPdiOB
 7DV2BZR8CqZB532BX+Uu+TSp00vkAFlDUyPbPkGi83n6N+/zEalw31/DWUbViJNRev0L80+iuAA
 qNCYPY0C3gNNWCwOp/+NaGbpdC2UPj/Qs3uA14dpdZN+t1lZtKy3kNLvhBWGYckSYrEpRa4W9J9
 V+9nfbaIeAtsEQleiXbgZ+7OkCqWVefZWTs4W2CbVFod2GVsvUT6XQrYm9rXg0ReDQlAf0EfZ9H
 cDg8NissdTDIQKF1NYqfvaDA7zzUN4hn9lvH+Xx/yx/o
X-Received: by 2002:a05:6000:3105:b0:3a4:d9fa:f1ed with SMTP id
 ffacd0b85a97d-3b910fd973fmr1650312f8f.13.1754980903828; 
 Mon, 11 Aug 2025 23:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHapFaZar5gtY4FTj+ZHgXxpSpfl4CCbIuhwYrRE4g5UaHGctJx0nkUxEs7fuvDEKaR2R8OMg==
X-Received: by 2002:a05:6000:3105:b0:3a4:d9fa:f1ed with SMTP id
 ffacd0b85a97d-3b910fd973fmr1650296f8f.13.1754980903400; 
 Mon, 11 Aug 2025 23:41:43 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.234.144])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm42859401f8f.15.2025.08.11.23.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:41:42 -0700 (PDT)
Message-ID: <f85bd476-501a-4693-b830-6ab7a7168d94@redhat.com>
Date: Tue, 12 Aug 2025 08:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Don't disable Rust for too old meson version
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
References: <20250811142923.89983-1-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250811142923.89983-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 8/11/25 16:29, Kevin Wolf wrote:
> If the user explicitly specified --enable-rust, don't just fail if meson
> is too old for Rust support, but do the same thing as if meson was too
> old for the C code: Just download a newer one.
> 
> In order to avoid the additional download for people who aren't
> intentionally opting in to Rust, keep the automatic disabling based on
> the meson version as the default if neither --enable-rust nor
> --disable-rust were given.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Are you going to submit the patch yourself?

(By the way, I just discovered that IGVM support is incompatible with 
Rust because you end up with two staticlibs...  I'm not yet sure how to 
fix it, other than by compiling libigvm ourselves).

Paolo


