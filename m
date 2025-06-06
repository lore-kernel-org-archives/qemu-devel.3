Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DEEC5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQGd-0007MD-Qe; Fri, 06 Jun 2025 02:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNQGb-0007Ib-AP
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:09:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNQGX-00042o-Sb
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:09:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4508287895dso18272805e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749190159; x=1749794959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cByiSStoffS6mXs4MY0CM6SaegGyJSJRDeB/IrgUMGc=;
 b=XCPJS7pvwrfzEcOI5zOmWGeHepeJQfCkz9thbL3TOz28vUy/ZgEhmRNEprHoLzEz6z
 SoJBWuQQS1/58FlwjwPtxlYmBOJvQC/0cVYFrDn0wrHp/05L9MgE+evwDnSpaYI2ixGQ
 jAEpeqgzwsJ8CvW4hTXa4VYXkw/QCGEydj4mdpODQ+/K2LVUjCZCf9V+YCUZd8eikVqO
 sR7fe6ZnruBh7323TbdDlFmDDA3Rdv5TIwhZd/y8kW39TELtIAlTQXRBAhwrv5uXSAhx
 6rucZRRo38Fdw9GdCK6BIc20iRRlGr0d+8kkDhF7r5p1mNo0vxsALmXMSyqpS1ZPj4ir
 Trjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749190159; x=1749794959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cByiSStoffS6mXs4MY0CM6SaegGyJSJRDeB/IrgUMGc=;
 b=esHwcxy//dGtvUdpwym9DBWBclMmxiSPQjpHWiwaHLQAW8tCaOMqvKPu39jXu9CSGP
 dh2lBHB425SIlAs8bnm+m9KfF7oI5MfiG+MLl3kBYwxw7UPXeBN0AW5OEZuc00nnijBT
 8uBbCfcIvbPVFt0gtUjdU5XUQBA/cUdd8w9sxOpoZ6S7b2DdtMTpsZ6CGjGRw0rNh1kZ
 7npanhfwgFb6MQ/vOq1Iy0NwmhQXhBVh7nAl81yGF5SNAWMWE2FGLLnvStktkJILzXan
 sZ71FltIPpHN7kq8xg7bpY7BAQdVYMynllkIvVJjgJSoP59ZpIbOTbIyNHJsy+lGsabf
 gL+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXOi6dD+9Fr+z8Od3NViGjzBlzCGD5qDsb2M423ADy2Jhcp15f6NPdHmHPW937N5OCQAhFSb1zAg+g@nongnu.org
X-Gm-Message-State: AOJu0Yx0iZ1w030i3AJDmpH/tgHARf4jIpGW1f+y1ZEPCFyP1EPP8z7c
 8wi1giJg0T3CBL2RvmzCvqKmatgDxzAxW9yIKY+h3E1UACy+2xQD8rRPwcTOZilhneI=
X-Gm-Gg: ASbGncutxNF+cDf/a/0U2YjaKAA6j5I6rjz2MpR4ixXJ/xgPVGwTPCOjHdxmuSS3ngK
 wxNcOcfGUlGKAes6vS1C+zXKwDVHRQrGfPVrUnZ0owoSSuITtdd767GFuP9Z4R8obSythCrRVkj
 dPqaqmdywP9kdjcBDSkRYG3mnspEzjh02BrdEnff2tEu3Klz7l9sw0oMJf74uthb0cuAT6KCDOt
 1FFLJjIxf0TyJyRwfqtqQd+Y5QzZWY60g/gEGooy2WJRuJXh1rKEXJXjniSJCnhpb7s1VJt3No5
 whUOwCJKty91Ep+HXlyg32lYYtDf65rLTvUdd9L+NmXlzXRA+wZ1K5gxE9vw2Ka9cK4gfmj1Wwo
 fV4/aMZdxTXQAEio+NXc=
X-Google-Smtp-Source: AGHT+IETxYUzKDWGubJi3X5S6kX5+VSnUrrjX/zHOxm9iVKzy1RXcWZ50GOgT5cICFQkLRQRMmEP1Q==
X-Received: by 2002:a05:600c:1c99:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-452014ea237mr19528365e9.3.1749190159484; 
 Thu, 05 Jun 2025 23:09:19 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229e0dcsm972282f8f.15.2025.06.05.23.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 23:09:18 -0700 (PDT)
Message-ID: <0f7673d9-31f4-495b-a118-f53ed6c6fc37@linaro.org>
Date: Fri, 6 Jun 2025 08:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/unit/test-char: Avoid using g_alloca()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250605193540.59874-1-philmd@linaro.org>
 <20250605193540.59874-4-philmd@linaro.org>
 <7832d31a-2707-4cc4-9838-f2ea4b6b2cea@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7832d31a-2707-4cc4-9838-f2ea4b6b2cea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/6/25 22:53, Pierrick Bouvier wrote:
> On 6/5/25 12:35 PM, Philippe Mathieu-Daudé wrote:
>> Do not use g_alloca(), simply allocate the CharBackend
>> structure on the stack.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/unit/test-char.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
>> index 60a843b79d9..f30a39f61ff 100644
>> --- a/tests/unit/test-char.c
>> +++ b/tests/unit/test-char.c
>> @@ -993,7 +993,7 @@ static void char_udp_test_internal(Chardev 
>> *reuse_chr, int sock)
>>       struct sockaddr_in other;
>>       SocketIdleData d = { 0, };
>>       Chardev *chr;
>> -    CharBackend *be;
>> +    CharBackend stack_be, *be = &stack_be;
>>       socklen_t alen = sizeof(other);
>>       int ret;
>>       char buf[10];
>> @@ -1009,7 +1009,6 @@ static void char_udp_test_internal(Chardev 
>> *reuse_chr, int sock)
>>           chr = qemu_chr_new("client", tmp, NULL);
>>           g_assert_nonnull(chr);
>> -        be = g_alloca(sizeof(CharBackend));
>>           qemu_chr_fe_init(be, chr, &error_abort);
>>       }
> 
> Would that be more simple to declare the variable, and use &be in the 
> function code?

More context (see reuse_chr ladder):

-- >8 --
@@ -991,45 +991,44 @@ static int make_udp_socket(int *port)
  static void char_udp_test_internal(Chardev *reuse_chr, int sock)
  {
      struct sockaddr_in other;
      SocketIdleData d = { 0, };
      Chardev *chr;
-    CharBackend *be;
+    CharBackend stack_be, *be = &stack_be;
      socklen_t alen = sizeof(other);
      int ret;
      char buf[10];
      char *tmp = NULL;

      if (reuse_chr) {
          chr = reuse_chr;
          be = chr->be;
      } else {
          int port;
          sock = make_udp_socket(&port);
          tmp = g_strdup_printf("udp:127.0.0.1:%d", port);
          chr = qemu_chr_new("client", tmp, NULL);
          g_assert_nonnull(chr);

-        be = g_alloca(sizeof(CharBackend));
          qemu_chr_fe_init(be, chr, &error_abort);
      }
---

