Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75361FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 18:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbk0h-0000Zu-AI; Fri, 02 Jan 2026 13:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbk0c-0000Yy-1k
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 13:36:23 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbk0Z-0003US-Ry
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 13:36:21 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso16362879b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767378978; x=1767983778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOXWujS7VIn0EAfL1fKGv8JLn2R7dNSkrqZVX5tc8JY=;
 b=PvtcCSRRw6jZEYgCGJ757UgLDxhc7OqguOta/8MXTB1FGCcZPPVnmX/cGbeFy6ZdmI
 dd+ptrC7vykiOpZvy4uBZE7VRdyxjFVoQwiXtCNEwztuBrrU+oi9Bsc8bQjjNA8wg2RL
 uDqbxdMYPkFS0eqxtvk8wsmXhU2FQ3wcci0sBUUM5eI4cYIExLs90epQWokT7ol+aIre
 HorQaHSD88+OSspSYBpciCMFHNzB8cKygRNVs2BAGQVylGXzWeZCg4JV9J/84oYILAJj
 4xaSqvumiy08fgOsZYDBABAvLeBUB21eUzg+nfYB7JO7P44huku8uXcCPxdltscbcBSF
 PTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767378978; x=1767983778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WOXWujS7VIn0EAfL1fKGv8JLn2R7dNSkrqZVX5tc8JY=;
 b=VHRDx57EiunfuT/v8+YQc1bgyzB5tsoHAebUsQcyj58rA8DPj/+a31tkCrTEiiNj+8
 OWhm/qB0k/WUbJoNp2reAZcRlSG9pv7MqbrhJOdgyHeDiM0rMs8rKTN/bI9NlDnaXKzg
 q7+NEHSTCFhQkqyjSlcDUpelyGgJlYvZTqPlswrlpIfwIfprCEkV8dZmVX67FQlsItaR
 4S8B+5A3KgJ4xGIMmQSPQJk/OSHTIX0MvJGnzk9YpKY1XhszoaS4E4bUZV9QlDfaPxc9
 8xKIlOMGtuTN9/EXcZaCIR8dhQvKScOlCYmobx2JTLE4nUa4oSSg+Pd0aal2nu9q2an+
 D5Fw==
X-Gm-Message-State: AOJu0YyFtIoPekpzCiWy+lsubz9JvkzkTfB+Ql8qYdfKjAzQuIb33uuc
 afRUrlH8jCsb5ap8hJ5tgnSEMSOOg9YNXfrNq2fA+DHEVh5xRL8ObrZlQR5np8GjkoA=
X-Gm-Gg: AY/fxX56AopGvuik/UtvVqcfNKpjZ7FvUdTfMWcRnMzC56Dn4rc9JiG4aOEW0CNFHFx
 LPqMHfGorWiNkPZt3+SH9XBR+1H7WqzGrTqepET5aG1WQQMF/a+j3hIvwNbuZnxnAjGnfoA0qYv
 WrfSZS8oLmYeV+WXC5FFrtdegH3v9+YugZaXTvEEn+Qtmg4IcquEhx60vJSrZ//dbjdOxM7S+S/
 Xi4SWZbXN8Kjqi0gmCmArGHHHzSC73/wpEn/UrJMpGiNGPYNES2oFY/rsePq0np2GPM4LwkPYHu
 Y1X1QBgko9Xk2X7kCc3xFX7lYOzzW9bUT2Xove6za1OFZVEO0VJKhHPZK3KK9fbvx3vNGcsNk2T
 tMAlDSC+bS7GLs5C5w2VOIP9aRkTNKSaAa5JuyAElaRN2qCWJ3zcPVGzWjz/rye90mKAKrQrc0U
 CCetMFy4n0LoI/ysSj2rhAcfiddGLEkpYnuyjSOe7nA21mDfUNYyZlidDA
X-Google-Smtp-Source: AGHT+IHVC6kusus7RKMCafSmgK8Q9Vbd49+ouAjVuVuZLVSctvcKz+D3QVJju/s0pM+wYTM2ipdtCQ==
X-Received: by 2002:a05:6a00:2345:b0:7ff:d378:98f with SMTP id
 d2e1a72fcca58-7ffd3875007mr36047257b3a.37.1767378978029; 
 Fri, 02 Jan 2026 10:36:18 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a93b441sm40510897b3a.9.2026.01.02.10.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 10:36:17 -0800 (PST)
Message-ID: <f35b6016-4a8a-4f25-9578-c47588c73b1b@linaro.org>
Date: Fri, 2 Jan 2026 10:36:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] plugins: enable C++ plugins
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
 <87h5t4xpya.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h5t4xpya.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/2/26 2:35 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> Writing plugins in C can be sometimes tedious, especially when using Glib to
>> keep track of execution state. We can directly use the same C API but write our
>> plugin in C++, benefiting from its great standard library offering strings,
>> smart pointers, data structures and synchronization mechanisms.
>>
>> It's common for downstream QEMU forks to provide C++ for plugins, like this:
>> - https://github.com/panda-re/panda/tree/dev/panda/plugins
>> - https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin
>>
>> Hopefully this will help more people to use upstream QEMU, and as a benefit, get
>> their contribution back and help to develop plugins ecosystem upstream directly.
>>
>> This series first cleans up build system for plugins, factorizing details
>> between contrib/plugins and tests/tcg/plugins folders.
>> Then, we perform codebase cleanups to fix conflicts between existing headers
>> and C++ headers.
>> After that, we can update the C++ standard used by QEMU, to benefit fully
>> from latest updates of the language.
>> Finally, we define an empty C++ plugin, making sure we can keep track of
>> possible regression in qemu-plugin header.
>>
>> Note: This series is *not* a trojan horse to bring C++ in QEMU
>> codebase, nor to define an alternative C++ API for plugins. It's just enabling
>> more users to get the most out of existing C plugin API.
> 
> I don't have any fundamental objection to allowing this - as you say it
> keep the existing API and just makes it easier for the plugin authors to
> use C++.
>

Sounds good, thanks Alex.

> It would be interesting to see if there are any other changes that would
> also be useful for other language bindings. I suspect the most relevant
> would be Rust bindings for the plugins.
>
It would be an interesting topic, and I feel that the right way to 
provide Rust support would be to offer a new API (using existing C one 
internally) embracing its philosophy, instead of direct bindings to the 
existing C API. Some people already explored this and it could be a 
great source of inspiration:
https://github.com/qemu-rs/qemu-rs
It's definitely out of the scope for current series and C++ support though.

Pierrick

