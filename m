Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6346FCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvsoS-0001PB-SK; Tue, 09 Sep 2025 03:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvsoN-0001OC-Ry
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvsoI-0002oT-5L
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757403035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v4jjMFokisxlOpdRVyPs75YnY73qC2mqfFx4mTfIkTM=;
 b=Jdy4/+rWC5PBSzgbfYD09ZxEfZyoUXztQik9pUbzHB56JvBlfXWtR81sETPuCFBKo6Ou1R
 qFsKl7e8Wqh81nbJw3ScsfuuYywnFjRr4y13WN+PLvVUuyef5rjcizcFJf4F/Dche22aLb
 UchIY769TJvpcoRSbzpWjWb6vcDQhUM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-iMn8iuuQPCaVUBzOfue6Lw-1; Tue, 09 Sep 2025 03:30:33 -0400
X-MC-Unique: iMn8iuuQPCaVUBzOfue6Lw-1
X-Mimecast-MFC-AGG-ID: iMn8iuuQPCaVUBzOfue6Lw_1757403032
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3df07c967e9so3258676f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 00:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757403032; x=1758007832;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4jjMFokisxlOpdRVyPs75YnY73qC2mqfFx4mTfIkTM=;
 b=iXeRRCvuPUaOBXFDUAILitvKXzOG48RwxBYZ2QdAch6U27rgQN5qtaNnGYkdhd+5Ea
 Kri1E04Clk7+cLRngyAia97guOj5snHmmNElAJqwtvOsUS4Njgf0g/nCGQ+5jZxhW4O5
 Z2eM6YP9LUlUDRxNPcSB2MSy9VvGScn/c8w5lguk/RK0tl2F46Qbomj9rOQ0m30kunS6
 LsVJtE+ceIu4i8aSvTYL6vu4b0iV7h1n0qiCtvEvA9F8UyUcZlTmzpanDJNmAFBdNx4x
 +OgLnB3DQiCSw9o9J383lSS6upZ8gYoWGfhJ6RWuF3n61S4zhuIWsYmkxE9fBmZ5bS99
 gkOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZePZ/G4A6U36j2KAt0lP8Y0i1TmhWEywiGMc2Nl5lpz4imxP3sW6e/BIIqdPA68i6lYzIhUS9e8pl@nongnu.org
X-Gm-Message-State: AOJu0YxApHBhvfiaEHjIGFw98cwocAWzJ0/zZ9ZNndNokVIR28XibLEr
 kDKSkD8S6iVyXHHR8wNCU4i/dG8M+XQasE+T16mvkwX8OZ15UuzB6vCHznFUpG7fnz1oCfPvr59
 +Sd8U8F5bnNo/P+oYfEYTkcNxI8yf+HlG04wn+X5Y4nvGnezuNB2FxJOA
X-Gm-Gg: ASbGnctqRuC36CIcMb/hqHgSCvIk9E9W27KsLJyZWu1jUmx27MTY7RK1/JhUCyLxf+A
 YbqkSsgotm0KWgtQzSfZgKUpypQZiBlI6n56AhGlwCPZdZlcp3unot0ExXYOECBDmK8qDePUjH8
 Y4f4YelXx0K3EbwqIWC7hiwKB46UaXko1o9qcdl9U4U/p6yYsdcEnuxGiqxcOOiDUPJmDS1GvLi
 22lxSnZErk8kJ4t9mtbFqAAcoHGZ/bxaP7nQmBR6BPJt+gy/Rj2xqVWs9SSjHIv7U4RtuleBB/j
 aMy9uckI2PiFO53zTeYSBNfmcOmBhtjespnlTZ/l7aye3JUBNIW+A2tZzT93Y6xp4gSGSFHNdAv
 mo119FQ==
X-Received: by 2002:a05:6000:2f83:b0:3e3:c5a8:a1be with SMTP id
 ffacd0b85a97d-3e62bae289emr7376012f8f.0.1757403031938; 
 Tue, 09 Sep 2025 00:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkj8G3xwWvx6i70fLBbw4+YGSNc58fiBErrC9Hk704jxMhQ3qNtBGTXn1cbPGluOuIq9xQNw==
X-Received: by 2002:a05:6000:2f83:b0:3e3:c5a8:a1be with SMTP id
 ffacd0b85a97d-3e62bae289emr7375990f8f.0.1757403031484; 
 Tue, 09 Sep 2025 00:30:31 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9c5c89f2sm287528025e9.14.2025.09.09.00.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 00:30:30 -0700 (PDT)
Message-ID: <0c17958b-cb28-4e5d-9dd3-cb849a288674@redhat.com>
Date: Tue, 9 Sep 2025 09:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] Revert "meson.build: Disable
 -fzero-call-used-regs on OpenBSD"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250508144120.163009-1-thuth@redhat.com>
 <20250508144120.163009-6-thuth@redhat.com> <aBz3Rh6S5emirSPz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aBz3Rh6S5emirSPz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/05/2025 20.26, Daniel P. Berrangé wrote:
> On Thu, May 08, 2025 at 04:41:20PM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> This reverts commit 2d6d995709482cc8b6a76dbb5334a28001a14a9a.
>>
>> OpenBSD 7.7 fixed the problem with the -fzero-call-used-regs on OpenBSD,
>> see https://github.com/openbsd/src/commit/03eca72d1e030b7a542cd6aec1 for
>> the fix there.
>>
>> Suggested-by: Brad Smith <brad@comstyle.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Note: Marked as RFC since we likely can include this only once OpenBSD
>>   7.6 goes out of service, see:
>>   https://lists.libreplanet.org/archive/html/qemu-arm/2025-05/msg00559.html
> 
> Yep, we have to wait a bit longer, unless someone can confirm the
> fix was backported to 7.6

Now that QEMU 10.1 has been released, I'm going to include this patch in my 
next pull request. OpenBSD 7.8 should get released in October, so 7.6 will 
go out of service at that point in time, and our next QEMU release is likely 
in December, so we should be fine. Or has anybody still concerns about 
including this now?

  Thomas


>>
>>   meson.build | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 6c61e1dcaec..5f0e6a65cb0 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -699,11 +699,7 @@ hardening_flags = [
>>   #
>>   # NB: Clang 17 is broken and SEGVs
>>   # https://github.com/llvm/llvm-project/issues/75168
>> -#
>> -# NB2: This clashes with the "retguard" extension of OpenBSD's Clang
>> -# https://gitlab.com/qemu-project/qemu/-/issues/2278
>> -if host_os != 'openbsd' and \
>> -   cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
>> +if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
>>                  name: '-fzero-call-used-regs=used-gpr',
>>                  args: ['-O2', '-fzero-call-used-regs=used-gpr'])
>>       hardening_flags += '-fzero-call-used-regs=used-gpr'
>> -- 
>> 2.49.0
>>
> 
> With regards,
> Daniel


