Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB86C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ee7-00043N-TA; Fri, 18 Sep 2026 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7ee5-00042m-QZ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:53:17 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7ee4-0003c3-5D
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:53:17 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 41be03b00d2f7-cc50d1b048eso1014096a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789761194; x=1790365994; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjdXuaG3iJg7i7k9uMXqziqO22/cGEXfDziw3Ph4U7M=;
 b=CDLVBf0TP9S4FbP5/4nRhgv+Zlpmh+O86KNwvfNLskR3EXK1JX/iUp7CFhbD6lFqjX
 DKd+csQVVOqXsvLu9htJ1SVFuNWTvAYigfV5A2FCDzuV22pevEq+a/lyfH1dPXX75wVi
 7FNXayEbXCv4MXP5fbm2+4AG/bevkFdSo4TOpo5froBpOxqiKQTHKP4KoXXbCsSP9A/+
 WET2LE9qN/JwvCOjPdMNyjav1cdvWQgVlPTJjbVBE2T09VH4Osn9aBn+f1FLHC8xXV1p
 9BgvkVgNQ0cR9b0Mi3mZyVCtdL29v+0UfzX4M2tYLfJ7biOZeQE2bybGJ8fouRU7Wiv3
 fDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789761194; x=1790365994;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjdXuaG3iJg7i7k9uMXqziqO22/cGEXfDziw3Ph4U7M=;
 b=l4cmg27T5vCCPEw4lo9iXKcpr6561xVj8VPjE62muiEh7NzI9gkqQVfTXG+UMSSxLB
 senNChWQh0LTVwORhlM1D+OkdkLTBJPDtUmOZE15+xzdQTz1ppIAgefoYMsvB3lB5uKZ
 PA2diA71V7rT0z9KJEUhIrTqqap17IR2jGQCvPeE5MN9Csm4KIfNUeOExLAi4XkfCgTF
 ePm8+lbzX/XhVGrXvXt38WXOHmxke5QfmmsY3lTrZ+rdwFygVWC51EE7D7PKwNYgJUEg
 XiHkmuKcQXCs+vRMl5KocoLtK7cjXGpgH9rC2CkIxYkyZDKUyHoS1CsFuqAI1B7BZbCw
 8dWw==
X-Gm-Message-State: AFuF++nXvkXcXz2vHKqKgZDBS1PBdP13MdIYE/ujPxiE5izVfylpcNRx
 VlVMV+ckDy9eK/XPT20zQpD2ke+keqsRuI7j5JaT1QnWMTbsqVw8f7zLkv91B9ZlfPQ=
X-Gm-Gg: AYBFou0V0ohFHZOUzGyXUwEZEn4SHf2TB431aOTzkhm6+S9tomnGA9F4tOXO29ApMNW
 UnGN24RITQU55hSwMnw2eLegNmRlSvp79e5HFOLSbIb6BBqQWrh1Y+IVwSEBWdmX8+wfkQVeVdm
 y4QH26d0t56MSfL3HsUvfo4rJqY3Xu6HJvQmzweL8j6VPxjCIBjgMZdR2D4bFy1AzpR/MeQ4nBL
 FZs+aSQucO+dkMLgMo2shJL6Tz7d2w+C/2jk2ypZ5qeeCyz7RGsG1+JA9rudGb/rOE1Va2RSGJy
 8rh7zImmifsVcXPPLNcSmiISxlHfAsRXn9coQGuO7FvBOzdqeCbWu1kVUSuvTJc8SoIJdjn104l
 ARqStsoGF8hX3r8y/82lvi7B15v6pNSqwtpVFDGB01EqJUaJuEqYiB0QZ6mAn2L0x2qUo74lD/p
 ili8x5l/Oe10wWxzxw4VYUE4Wj3fI62KLl4PDBttrcWslwnHSP+kcT1kn/XGQjl8qjAlrqsSTyy
 bm/kXr6wAH9/6WGfEhgRw3ZzzGAVaOVmKW/FS+Nwa3GOkragUigQnUkgHv3AQ==
X-Received: by 2002:a17:90a:6c8f:b0:39e:5acb:2849 with SMTP id
 98e67ed59e1d1-39e5acb6103mr3999418a91.17.1789761194449; 
 Fri, 18 Sep 2026 12:53:14 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:317e:3514:d7db:974c?
 ([2603:800c:7900:ed00:317e:3514:d7db:974c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c33142a37sm878920eec.15.2026.09.18.12.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 12:53:13 -0700 (PDT)
Message-ID: <6752efa2-799a-4c9d-aa4a-ee96bbe1810c@linaro.org>
Date: Fri, 18 Sep 2026 09:53:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
 <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
 <87y0cy6ace.fsf@draig.linaro.org>
 <7393baca-7746-4211-94cd-e0400cb864b2@oss.qualcomm.com>
 <5bc81802-f243-4faf-822a-04adb5717563@linaro.org>
 <8c2c4869-d31a-4551-bcea-49f4f45a8fe0@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8c2c4869-d31a-4551-bcea-49f4f45a8fe0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/18/26 09:22, Pierrick Bouvier wrote:
> On 9/18/2026 10:58 AM, Richard Henderson wrote:
>> On 9/18/26 07:07, Pierrick Bouvier wrote:
>>>     # finally create a top level target to rebuild all tests
>>>     alias_target('tcg-tests', exe_targets)
>>
>> FWIW, that used to be called build-tcg.
>>
> 
> Would you prefer to change name to that?
> 
> I don't mind personally, and if some people were used to it, it makes
> sense to provide the same.
If we're going to provide a fake target at all, we might as well keep it 
the same.

Though being able to run individual tests from the make/meson 
command-line is probably the biggest new feature, plausibly obviating 
most uses of "just build all the tests so I can run the one I want 
manually".


r~

