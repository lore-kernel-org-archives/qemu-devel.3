Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1EEC369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 21:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBK1x-00087D-MS; Sat, 03 May 2025 17:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBK1w-00086u-I5
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:04:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBK1u-0003xW-10
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:04:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso562855b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746306252; x=1746911052; darn=nongnu.org;
 h=in-reply-to:content-language:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ln4+Swpx0ergGztzxS2pfrdreU5e4JDmyBO1bJ0AnE=;
 b=K1TqhoMFQ6TwE5IWcFRP7pxdjPz5kIP/M6gX1K2ahoEOEVYnthS4qbIxytyKmx0cWK
 8TupsYRhdysOLta1+YYyGPH9Ix1jKBUCPZuaXtPyWcEEUrTtjj0fFCKj/VgKubVG5pcC
 9/trYWA07VNUAK5J702cqRef/WA52cfCQjrftbhpWaQmtW9+rUcRfK6nUrbYA7BBQqGy
 qXfnznmXzkxu4UHNtuDqfZE9N5/+Xt+leyikyQkM3si/g8h6YYR8zJCqN+uryu/u/cXn
 Y1x1LYSZEDcLGlPzWea1DoMEmARDrHumfUtHaXFP/J5H2joK1BY8olqHovg1QCAUJTU/
 TW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746306252; x=1746911052;
 h=in-reply-to:content-language:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ln4+Swpx0ergGztzxS2pfrdreU5e4JDmyBO1bJ0AnE=;
 b=HyRvjCB9BuTpf72rTgbqq1Dhl1tzZU5b7wXA5yQtWDCnHTHwYqJUEumg19FcDeNgeU
 aGvYkcnwIXm1/qG7A4cUM+VP7dROwMDXvYkeigxYMnKdsiiB4WLI7Vf0gfeaENsOzNRw
 lRaXhVx4qPnx/d+5FbTmbgAc5FilVi1K8jIkqXUzRpDKQHGksYGn2JME/9GyevsHGm6r
 aUnGYI1psRPfmXPkYD26bl95VEN6T9AYuzlfdwuiKDQNysqHbPlrGWWEidz2JpMubDmB
 beijsXiCiYJPfqFsAUjH2iiQp8ZEqFvlrsA/4o3RAd+OccPTJdJT4UgZb7udFVfFnhSs
 sHtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2MV35tZxCkgFIsKxtCEe9mzy3WYicOlNw8FezIGOfAtGCYzV5TeJaECCICX3PAdyugekDuXR3TjSK@nongnu.org
X-Gm-Message-State: AOJu0YyDQOOOcwFuX6vndDb52ghwBzIP6AtOXCFKQ0dh6VBr/5lCc6hW
 QXJeck3der51lbd8gNsAAuWLkifxDsPeAeDdl4N0yhlfKf1JG9SH20a+v7EWTQ0=
X-Gm-Gg: ASbGncsD7ozJF5LzSKAvNPZv9nwsppnmwRsOVjapfC1SkLvtBgDTwgDbOKzW9zTopuO
 9NdzFm7RfUPGj+nIEnLQ0nSCRu6KD5MI+pXZ/Ta56runEZRtaU2+beJmNBD3s6NQGnWABJXnKcX
 z3gcXPyEy0l3rFWdv9pzm0Y35eeck5Lw8Fnvs9JAu9NrSSxHW2QQPFpSqajEqbC5soQ4MH/4+oo
 juymMQ1hXeepSefmM4dmc/addHWeZqOvCDOuFxpmydURJf+dPHwyJBnoCIrCLpPaedw562OKGza
 ESwabc/wSICWqVZInE+5bC8GsyaWQnuq3yhxgzhKHwqs8eVDS21bZA==
X-Google-Smtp-Source: AGHT+IEJ9+aaM7xVS2SLc10GN4s1TkM+4MpsKEBg5MJuVWRfbGLGNTglm31HY1Q4leu8QTvkpY/UpQ==
X-Received: by 2002:a05:6a00:338a:b0:736:5dc6:a14b with SMTP id
 d2e1a72fcca58-7406f0df42bmr3012179b3a.13.1746306252010; 
 Sat, 03 May 2025 14:04:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058df43c8sm3777960b3a.84.2025.05.03.14.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 14:04:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------vV4ktiVv0UocRJkCslkMijrh"
Message-ID: <5ebb1a1c-efdd-4dcd-8027-aa3dc031b755@linaro.org>
Date: Sat, 3 May 2025 14:04:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 2/2] semihosting/uaccess: Compile once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250502220524.81548-1-philmd@linaro.org>
 <20250502220524.81548-3-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20250502220524.81548-3-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

This is a multi-part message in MIME format.
--------------vV4ktiVv0UocRJkCslkMijrh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/25 3:05 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   semihosting/meson.build | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/semihosting/meson.build b/semihosting/meson.build
> index f3d38dda91d..a0a1c081f43 100644
> --- a/semihosting/meson.build
> +++ b/semihosting/meson.build
> @@ -3,9 +3,7 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>     'syscalls.c',
>   ))
>   
> -specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
> -  'uaccess.c',
> -))
> +libsystem_ss.add(files('uaccess.c'))
>   
>   common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
>   user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))

Fails to build with:
./configure --disable-tcg && ninja -C build
FAILED: libsystem.a.p/semihosting_uaccess.c.o
../semihosting/uaccess.c
../semihosting/uaccess.c: In function ‘uaccess_strlen_user’:
../semihosting/uaccess.c:43:17: error: implicit declaration of function 
‘probe_access_flags’ [-Wimplicit-function-declaration]
     43 |         flags = probe_access_flags(env, addr, 0, MMU_DATA_LOAD,
        |                 ^~~~~~~~~~~~~~~~~~
../semihosting/uaccess.c:43:17: error: nested extern declaration of 
‘probe_access_flags’ [-Werror=nested-externs]

CONFIG_SEMIHOSTING conditional must be kept.
-libsystem_ss.add(files('uaccess.c'))
+libsystem_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('uaccess.c'))

However, it will fail as libsystem cannot apply target configuration for 
now, so we need to modify its definition (and libuser while we are at it).
Please apply the two patches attached (only the second is needed 
strictly, but it's currently stacked on the first one in my series for 
target/arm). I'll post it as well when updating my series.
--------------vV4ktiVv0UocRJkCslkMijrh
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-meson-add-common-libs-for-target-and-target_system.patch"
Content-Disposition: attachment;
 filename*0="0001-meson-add-common-libs-for-target-and-target_system.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA4ZjNmZGQ5ZTI2MmQzNmIyMjU0NWQwZjI4MzA1YjlmZjdjZjQ5Y2I1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+CkRhdGU6IEZyaSwgMjUgQXByIDIwMjUgMTg6MjY6MDggLTA3MDAK
U3ViamVjdDogW1BBVENIIDEvMl0gbWVzb246IGFkZCBjb21tb24gbGlicyBmb3IgdGFyZ2V0
IGFuZCB0YXJnZXRfc3lzdGVtCgpGb2xsb3dpbmcgd2hhdCB3ZSBkaWQgZm9yIGh3Lywgd2Ug
bmVlZCB0YXJnZXQgc3BlY2lmaWMgY29tbW9uIGxpYnJhcmllcwpmb3IgdGFyZ2V0LiBXZSBu
ZWVkIDIgZGlmZmVyZW50IGxpYnJhcmllczoKLSBjb2RlIGNvbW1vbiB0byBhIGJhc2UgYXJj
aGl0ZWN0dXJlCi0gc3lzdGVtIGNvZGUgY29tbW9uIHRvIGEgYmFzZSBhcmNoaXRlY3R1cmUK
CkZvciB1c2VyIGNvZGUsIGl0IGNhbiBzdGF5IGNvbXBpbGVkIHBlciB0YXJnZXQgZm9yIG5v
dy4KClJldmlld2VkLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25A
bGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPgotLS0KIG1lc29uLmJ1aWxkIHwgNzggKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA2MSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9t
ZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkCmluZGV4IDY0Nzc4ZWRlYjJjLi42ZjQxMjk4MjZh
ZiAxMDA2NDQKLS0tIGEvbWVzb24uYnVpbGQKKysrIGIvbWVzb24uYnVpbGQKQEAgLTM2ODUs
NiArMzY4NSw4IEBAIHRhcmdldF9hcmNoID0ge30KIHRhcmdldF9zeXN0ZW1fYXJjaCA9IHt9
CiB0YXJnZXRfdXNlcl9hcmNoID0ge30KIGh3X2NvbW1vbl9hcmNoID0ge30KK3RhcmdldF9j
b21tb25fYXJjaCA9IHt9Cit0YXJnZXRfY29tbW9uX3N5c3RlbV9hcmNoID0ge30KIAogIyBO
T1RFOiB0aGUgdHJhY2UvIHN1YmRpcmVjdG9yeSBuZWVkcyB0aGUgcWFwaV90cmFjZV9ldmVu
dHMgdmFyaWFibGUKICMgdGhhdCBpcyBmaWxsZWQgaW4gYnkgcWFwaS8uCkBAIC00MDg4LDI5
ICs0MDkwLDU5IEBAIGNvbW1vbl9hbGwgPSBzdGF0aWNfbGlicmFyeSgnY29tbW9uJywKIAog
IyBjb25zdHJ1Y3QgY29tbW9uIGxpYnJhcmllcyBwZXIgYmFzZSBhcmNoaXRlY3R1cmUKIGh3
X2NvbW1vbl9hcmNoX2xpYnMgPSB7fQordGFyZ2V0X2NvbW1vbl9hcmNoX2xpYnMgPSB7fQor
dGFyZ2V0X2NvbW1vbl9zeXN0ZW1fYXJjaF9saWJzID0ge30KIGZvcmVhY2ggdGFyZ2V0IDog
dGFyZ2V0X2RpcnMKICAgY29uZmlnX3RhcmdldCA9IGNvbmZpZ190YXJnZXRfbWFrW3Rhcmdl
dF0KICAgdGFyZ2V0X2Jhc2VfYXJjaCA9IGNvbmZpZ190YXJnZXRbJ1RBUkdFVF9CQVNFX0FS
Q0gnXQorICB0YXJnZXRfaW5jID0gW2luY2x1ZGVfZGlyZWN0b3JpZXMoJ3RhcmdldCcgLyB0
YXJnZXRfYmFzZV9hcmNoKV0KKyAgaW5jID0gW2NvbW1vbl91c2VyX2luYyArIHRhcmdldF9p
bmNdCiAKLSAgIyBjaGVjayBpZiBhbHJlYWR5IGdlbmVyYXRlZAotICBpZiB0YXJnZXRfYmFz
ZV9hcmNoIGluIGh3X2NvbW1vbl9hcmNoX2xpYnMKLSAgICBjb250aW51ZQotICBlbmRpZgor
ICAjIHByZXZlbnQgY29tbW9uIGNvZGUgdG8gYWNjZXNzIGNwdSBjb21waWxlIHRpbWUgZGVm
aW5pdGlvbiwKKyAgIyBidXQgc3RpbGwgYWxsb3cgYWNjZXNzIHRvIGNwdS5oCisgIHRhcmdl
dF9jX2FyZ3MgPSBbJy1EQ1BVX0RFRlNfSCddCisgIHRhcmdldF9zeXN0ZW1fY19hcmdzID0g
dGFyZ2V0X2NfYXJncyArIFsnLURDT01QSUxJTkdfU1lTVEVNX1ZTX1VTRVInLCAnLURDT05G
SUdfU09GVE1NVSddCiAKICAgaWYgdGFyZ2V0X2Jhc2VfYXJjaCBpbiBod19jb21tb25fYXJj
aAotICAgIHRhcmdldF9pbmMgPSBbaW5jbHVkZV9kaXJlY3RvcmllcygndGFyZ2V0JyAvIHRh
cmdldF9iYXNlX2FyY2gpXQotICAgIHNyYyA9IGh3X2NvbW1vbl9hcmNoW3RhcmdldF9iYXNl
X2FyY2hdCi0gICAgbGliID0gc3RhdGljX2xpYnJhcnkoCi0gICAgICAnaHdfJyArIHRhcmdl
dF9iYXNlX2FyY2gsCi0gICAgICBidWlsZF9ieV9kZWZhdWx0OiBmYWxzZSwKLSAgICAgIHNv
dXJjZXM6IHNyYy5hbGxfc291cmNlcygpICsgZ2VuaCwKLSAgICAgIGluY2x1ZGVfZGlyZWN0
b3JpZXM6IGNvbW1vbl91c2VyX2luYyArIHRhcmdldF9pbmMsCi0gICAgICBpbXBsaWNpdF9p
bmNsdWRlX2RpcmVjdG9yaWVzOiBmYWxzZSwKLSAgICAgICMgcHJldmVudCBjb21tb24gY29k
ZSB0byBhY2Nlc3MgY3B1IGNvbXBpbGUgdGltZQotICAgICAgIyBkZWZpbml0aW9uLCBidXQg
c3RpbGwgYWxsb3cgYWNjZXNzIHRvIGNwdS5oCi0gICAgICBjX2FyZ3M6IFsnLURDUFVfREVG
U19IJywgJy1EQ09NUElMSU5HX1NZU1RFTV9WU19VU0VSJywgJy1EQ09ORklHX1NPRlRNTVUn
XSwKLSAgICAgIGRlcGVuZGVuY2llczogc3JjLmFsbF9kZXBlbmRlbmNpZXMoKSkKLSAgICBo
d19jb21tb25fYXJjaF9saWJzICs9IHt0YXJnZXRfYmFzZV9hcmNoOiBsaWJ9CisgICAgaWYg
dGFyZ2V0X2Jhc2VfYXJjaCBub3QgaW4gaHdfY29tbW9uX2FyY2hfbGlicworICAgICAgc3Jj
ID0gaHdfY29tbW9uX2FyY2hbdGFyZ2V0X2Jhc2VfYXJjaF0KKyAgICAgIGxpYiA9IHN0YXRp
Y19saWJyYXJ5KAorICAgICAgICAnaHdfJyArIHRhcmdldF9iYXNlX2FyY2gsCisgICAgICAg
IGJ1aWxkX2J5X2RlZmF1bHQ6IGZhbHNlLAorICAgICAgICBzb3VyY2VzOiBzcmMuYWxsX3Nv
dXJjZXMoKSArIGdlbmgsCisgICAgICAgIGluY2x1ZGVfZGlyZWN0b3JpZXM6IGluYywKKyAg
ICAgICAgY19hcmdzOiB0YXJnZXRfc3lzdGVtX2NfYXJncywKKyAgICAgICAgZGVwZW5kZW5j
aWVzOiBzcmMuYWxsX2RlcGVuZGVuY2llcygpKQorICAgICAgaHdfY29tbW9uX2FyY2hfbGli
cyArPSB7dGFyZ2V0X2Jhc2VfYXJjaDogbGlifQorICAgIGVuZGlmCisgIGVuZGlmCisKKyAg
aWYgdGFyZ2V0X2Jhc2VfYXJjaCBpbiB0YXJnZXRfY29tbW9uX2FyY2gKKyAgICBpZiB0YXJn
ZXRfYmFzZV9hcmNoIG5vdCBpbiB0YXJnZXRfY29tbW9uX2FyY2hfbGlicworICAgICAgc3Jj
ID0gdGFyZ2V0X2NvbW1vbl9hcmNoW3RhcmdldF9iYXNlX2FyY2hdCisgICAgICBsaWIgPSBz
dGF0aWNfbGlicmFyeSgKKyAgICAgICAgJ3RhcmdldF8nICsgdGFyZ2V0X2Jhc2VfYXJjaCwK
KyAgICAgICAgYnVpbGRfYnlfZGVmYXVsdDogZmFsc2UsCisgICAgICAgIHNvdXJjZXM6IHNy
Yy5hbGxfc291cmNlcygpICsgZ2VuaCwKKyAgICAgICAgaW5jbHVkZV9kaXJlY3Rvcmllczog
aW5jLAorICAgICAgICBjX2FyZ3M6IHRhcmdldF9jX2FyZ3MsCisgICAgICAgIGRlcGVuZGVu
Y2llczogc3JjLmFsbF9kZXBlbmRlbmNpZXMoKSkKKyAgICAgIHRhcmdldF9jb21tb25fYXJj
aF9saWJzICs9IHt0YXJnZXRfYmFzZV9hcmNoOiBsaWJ9CisgICAgZW5kaWYKKyAgZW5kaWYK
KworICBpZiB0YXJnZXRfYmFzZV9hcmNoIGluIHRhcmdldF9jb21tb25fc3lzdGVtX2FyY2gK
KyAgICBpZiB0YXJnZXRfYmFzZV9hcmNoIG5vdCBpbiB0YXJnZXRfY29tbW9uX3N5c3RlbV9h
cmNoX2xpYnMKKyAgICAgIHNyYyA9IHRhcmdldF9jb21tb25fc3lzdGVtX2FyY2hbdGFyZ2V0
X2Jhc2VfYXJjaF0KKyAgICAgIGxpYiA9IHN0YXRpY19saWJyYXJ5KAorICAgICAgICAndGFy
Z2V0X3N5c3RlbV8nICsgdGFyZ2V0X2Jhc2VfYXJjaCwKKyAgICAgICAgYnVpbGRfYnlfZGVm
YXVsdDogZmFsc2UsCisgICAgICAgIHNvdXJjZXM6IHNyYy5hbGxfc291cmNlcygpICsgZ2Vu
aCwKKyAgICAgICAgaW5jbHVkZV9kaXJlY3RvcmllczogaW5jLAorICAgICAgICBjX2FyZ3M6
IHRhcmdldF9zeXN0ZW1fY19hcmdzLAorICAgICAgICBkZXBlbmRlbmNpZXM6IHNyYy5hbGxf
ZGVwZW5kZW5jaWVzKCkpCisgICAgICB0YXJnZXRfY29tbW9uX3N5c3RlbV9hcmNoX2xpYnMg
Kz0ge3RhcmdldF9iYXNlX2FyY2g6IGxpYn0KKyAgICBlbmRpZgogICBlbmRpZgogZW5kZm9y
ZWFjaAogCkBAIC00MjgzLDEyICs0MzE1LDI0IEBAIGZvcmVhY2ggdGFyZ2V0IDogdGFyZ2V0
X2RpcnMKICAgdGFyZ2V0X2NvbW1vbiA9IGNvbW1vbl9zcy5hcHBseShjb25maWdfdGFyZ2V0
LCBzdHJpY3Q6IGZhbHNlKQogICBvYmplY3RzID0gW2NvbW1vbl9hbGwuZXh0cmFjdF9vYmpl
Y3RzKHRhcmdldF9jb21tb24uc291cmNlcygpKV0KICAgYXJjaF9kZXBzICs9IHRhcmdldF9j
b21tb24uZGVwZW5kZW5jaWVzKCkKKyAgaWYgdGFyZ2V0X2Jhc2VfYXJjaCBpbiB0YXJnZXRf
Y29tbW9uX2FyY2hfbGlicworICAgIHNyYyA9IHRhcmdldF9jb21tb25fYXJjaFt0YXJnZXRf
YmFzZV9hcmNoXS5hcHBseShjb25maWdfdGFyZ2V0LCBzdHJpY3Q6IGZhbHNlKQorICAgIGxp
YiA9IHRhcmdldF9jb21tb25fYXJjaF9saWJzW3RhcmdldF9iYXNlX2FyY2hdCisgICAgb2Jq
ZWN0cyArPSBsaWIuZXh0cmFjdF9vYmplY3RzKHNyYy5zb3VyY2VzKCkpCisgICAgYXJjaF9k
ZXBzICs9IHNyYy5kZXBlbmRlbmNpZXMoKQorICBlbmRpZgogICBpZiB0YXJnZXRfdHlwZSA9
PSAnc3lzdGVtJyBhbmQgdGFyZ2V0X2Jhc2VfYXJjaCBpbiBod19jb21tb25fYXJjaF9saWJz
CiAgICAgc3JjID0gaHdfY29tbW9uX2FyY2hbdGFyZ2V0X2Jhc2VfYXJjaF0uYXBwbHkoY29u
ZmlnX3RhcmdldCwgc3RyaWN0OiBmYWxzZSkKICAgICBsaWIgPSBod19jb21tb25fYXJjaF9s
aWJzW3RhcmdldF9iYXNlX2FyY2hdCiAgICAgb2JqZWN0cyArPSBsaWIuZXh0cmFjdF9vYmpl
Y3RzKHNyYy5zb3VyY2VzKCkpCiAgICAgYXJjaF9kZXBzICs9IHNyYy5kZXBlbmRlbmNpZXMo
KQogICBlbmRpZgorICBpZiB0YXJnZXRfdHlwZSA9PSAnc3lzdGVtJyBhbmQgdGFyZ2V0X2Jh
c2VfYXJjaCBpbiB0YXJnZXRfY29tbW9uX3N5c3RlbV9hcmNoX2xpYnMKKyAgICBzcmMgPSB0
YXJnZXRfY29tbW9uX3N5c3RlbV9hcmNoW3RhcmdldF9iYXNlX2FyY2hdLmFwcGx5KGNvbmZp
Z190YXJnZXQsIHN0cmljdDogZmFsc2UpCisgICAgbGliID0gdGFyZ2V0X2NvbW1vbl9zeXN0
ZW1fYXJjaF9saWJzW3RhcmdldF9iYXNlX2FyY2hdCisgICAgb2JqZWN0cyArPSBsaWIuZXh0
cmFjdF9vYmplY3RzKHNyYy5zb3VyY2VzKCkpCisgICAgYXJjaF9kZXBzICs9IHNyYy5kZXBl
bmRlbmNpZXMoKQorICBlbmRpZgogCiAgIHRhcmdldF9zcGVjaWZpYyA9IHNwZWNpZmljX3Nz
LmFwcGx5KGNvbmZpZ190YXJnZXQsIHN0cmljdDogZmFsc2UpCiAgIGFyY2hfc3JjcyArPSB0
YXJnZXRfc3BlY2lmaWMuc291cmNlcygpCi0tIAoyLjQ3LjIKCg==
--------------vV4ktiVv0UocRJkCslkMijrh
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-meson-apply-target-config-for-picking-files-from-lib.patch"
Content-Disposition: attachment;
 filename*0="0002-meson-apply-target-config-for-picking-files-from-lib.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzNGZlNGQyODkzOGRlNGRmOTkyM2EwODk1OTZlN2I2Njk3OWViMzRlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+CkRhdGU6IFNhdCwgMyBNYXkgMjAyNSAxMzo1Njo0NyAtMDcwMApT
dWJqZWN0OiBbUEFUQ0ggMi8yXSBtZXNvbjogYXBwbHkgdGFyZ2V0IGNvbmZpZyBmb3IgcGlj
a2luZyBmaWxlcyBmcm9tCiBsaWJzeXN0ZW0gYW5kIGxpYnVzZXIKCnNlbWlob3N0aW5nIGNv
ZGUgbmVlZHMgdG8gYmUgaW5jbHVkZWQgb25seSBpZiBDT05GSUdfU0VNSUhPU1RJTkcgaXMg
c2V0LgpIb3dldmVyLCB0aGlzIGlzIGEgdGFyZ2V0IGNvbmZpZ3VyYXRpb24sIHNvIHdlIG5l
ZWQgdG8gYXBwbHkgaXQgdG8gdGhlCmxpYnN5c3RlbSBsaWJ1c2VyIHNvdXJjZSBzZXRzLgoK
U2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5h
cm8ub3JnPgotLS0KIG1lc29uLmJ1aWxkIHwgMjYgKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkCmluZGV4IDZmNDEyOTgy
NmFmLi41OWM1MjBkZTM1OSAxMDA2NDQKLS0tIGEvbWVzb24uYnVpbGQKKysrIGIvbWVzb24u
YnVpbGQKQEAgLTQwNTYsMjcgKzQwNTYsMTkgQEAgY29tbW9uX3NzLmFkZChxb20sIHFlbXV1
dGlsKQogY29tbW9uX3NzLmFkZF9hbGwod2hlbjogJ0NPTkZJR19TWVNURU1fT05MWScsIGlm
X3RydWU6IFtzeXN0ZW1fc3NdKQogY29tbW9uX3NzLmFkZF9hbGwod2hlbjogJ0NPTkZJR19V
U0VSX09OTFknLCBpZl90cnVlOiB1c2VyX3NzKQogCi1saWJ1c2VyX3NzID0gbGlidXNlcl9z
cy5hcHBseSh7fSkKIGxpYnVzZXIgPSBzdGF0aWNfbGlicmFyeSgndXNlcicsCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgbGlidXNlcl9zcy5zb3VyY2VzKCkgKyBnZW5oLAorICAgICAg
ICAgICAgICAgICAgICAgICAgIGxpYnVzZXJfc3MuYWxsX3NvdXJjZXMoKSArIGdlbmgsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgY19hcmdzOiBbJy1EQ09ORklHX1VTRVJfT05MWScs
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJy1EQ09NUElMSU5HX1NZU1RF
TV9WU19VU0VSJ10sCi0gICAgICAgICAgICAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBs
aWJ1c2VyX3NzLmRlcGVuZGVuY2llcygpLAorICAgICAgICAgICAgICAgICAgICAgICAgIGRl
cGVuZGVuY2llczogbGlidXNlcl9zcy5hbGxfZGVwZW5kZW5jaWVzKCksCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgYnVpbGRfYnlfZGVmYXVsdDogZmFsc2UpCi1saWJ1c2VyID0gZGVj
bGFyZV9kZXBlbmRlbmN5KG9iamVjdHM6IGxpYnVzZXIuZXh0cmFjdF9hbGxfb2JqZWN0cyhy
ZWN1cnNpdmU6IGZhbHNlKSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVwZW5k
ZW5jaWVzOiBsaWJ1c2VyX3NzLmRlcGVuZGVuY2llcygpKQotY29tbW9uX3NzLmFkZCh3aGVu
OiAnQ09ORklHX1VTRVJfT05MWScsIGlmX3RydWU6IGxpYnVzZXIpCiAKLWxpYnN5c3RlbV9z
cyA9IGxpYnN5c3RlbV9zcy5hcHBseSh7fSkKIGxpYnN5c3RlbSA9IHN0YXRpY19saWJyYXJ5
KCdzeXN0ZW0nLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlic3lzdGVtX3NzLnNv
dXJjZXMoKSArIGdlbmgsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWJzeXN0ZW1f
c3MuYWxsX3NvdXJjZXMoKSArIGdlbmgsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
X2FyZ3M6IFsnLURDT05GSUdfU09GVE1NVScsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAnLURDT01QSUxJTkdfU1lTVEVNX1ZTX1VTRVInXSwKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRlcGVuZGVuY2llczogbGlic3lzdGVtX3NzLmRlcGVuZGVuY2ll
cygpLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBsaWJzeXN0
ZW1fc3MuYWxsX2RlcGVuZGVuY2llcygpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
YnVpbGRfYnlfZGVmYXVsdDogZmFsc2UpCi1saWJzeXN0ZW0gPSBkZWNsYXJlX2RlcGVuZGVu
Y3kob2JqZWN0czogbGlic3lzdGVtLmV4dHJhY3RfYWxsX29iamVjdHMocmVjdXJzaXZlOiBm
YWxzZSksCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBs
aWJzeXN0ZW1fc3MuZGVwZW5kZW5jaWVzKCkpCi1jb21tb25fc3MuYWRkKHdoZW46ICdDT05G
SUdfU1lTVEVNX09OTFknLCBpZl90cnVlOiBsaWJzeXN0ZW0pCiAKICMgTm90ZSB0aGF0IHRo
aXMgbGlicmFyeSBpcyBuZXZlciB1c2VkIGRpcmVjdGx5IChvbmx5IHRocm91Z2ggZXh0cmFj
dF9vYmplY3RzKQogIyBhbmQgaXMgbm90IGJ1aWx0IGJ5IGRlZmF1bHQ7IHRoZXJlZm9yZSwg
c291cmNlIGZpbGVzIG5vdCB1c2VkIGJ5IHRoZSBidWlsZApAQCAtNDMxNSw2ICs0MzA3LDE2
IEBAIGZvcmVhY2ggdGFyZ2V0IDogdGFyZ2V0X2RpcnMKICAgdGFyZ2V0X2NvbW1vbiA9IGNv
bW1vbl9zcy5hcHBseShjb25maWdfdGFyZ2V0LCBzdHJpY3Q6IGZhbHNlKQogICBvYmplY3Rz
ID0gW2NvbW1vbl9hbGwuZXh0cmFjdF9vYmplY3RzKHRhcmdldF9jb21tb24uc291cmNlcygp
KV0KICAgYXJjaF9kZXBzICs9IHRhcmdldF9jb21tb24uZGVwZW5kZW5jaWVzKCkKKyAgaWYg
dGFyZ2V0X3R5cGUgPT0gJ3N5c3RlbScKKyAgICBzcmMgPSBsaWJzeXN0ZW1fc3MuYXBwbHko
Y29uZmlnX3RhcmdldCwgc3RyaWN0OiBmYWxzZSkKKyAgICBvYmplY3RzICs9IGxpYnN5c3Rl
bS5leHRyYWN0X29iamVjdHMoc3JjLnNvdXJjZXMoKSkKKyAgICBhcmNoX2RlcHMgKz0gc3Jj
LmRlcGVuZGVuY2llcygpCisgIGVuZGlmCisgIGlmIHRhcmdldF90eXBlID09ICd1c2VyJwor
ICAgIHNyYyA9IGxpYnVzZXJfc3MuYXBwbHkoY29uZmlnX3RhcmdldCwgc3RyaWN0OiBmYWxz
ZSkKKyAgICBvYmplY3RzICs9IGxpYnVzZXIuZXh0cmFjdF9vYmplY3RzKHNyYy5zb3VyY2Vz
KCkpCisgICAgYXJjaF9kZXBzICs9IHNyYy5kZXBlbmRlbmNpZXMoKQorICBlbmRpZgogICBp
ZiB0YXJnZXRfYmFzZV9hcmNoIGluIHRhcmdldF9jb21tb25fYXJjaF9saWJzCiAgICAgc3Jj
ID0gdGFyZ2V0X2NvbW1vbl9hcmNoW3RhcmdldF9iYXNlX2FyY2hdLmFwcGx5KGNvbmZpZ190
YXJnZXQsIHN0cmljdDogZmFsc2UpCiAgICAgbGliID0gdGFyZ2V0X2NvbW1vbl9hcmNoX2xp
YnNbdGFyZ2V0X2Jhc2VfYXJjaF0KLS0gCjIuNDcuMgoK

--------------vV4ktiVv0UocRJkCslkMijrh--

