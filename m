Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F116C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U7O-0007W1-JW; Mon, 28 Apr 2025 15:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9U6w-00079j-5l
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:25:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9U6u-0007iF-0g
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:25:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2295d78b433so56079635ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745868346; x=1746473146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0J8v9DNKygywueCRdyX/mMSkZhWURCDm00BQmhtFzQ=;
 b=L++KuDUtFB5g0JGEpcv54qCj5nyRfcyaHiGHP7B7tk/aRiq0Niv5nWkrvhv9LvHBkt
 5xCeCblP6iWdIcfjEuftpsUvgPmu34nZWe+LVwiNYI7oZsJv7uYbV7M/zxoTsGdgWTrf
 f3S4WWNNgvyylzH1rrcImvDBCYfzkC4ltgBYbAc/Esn6QQIhb04/P2FuUaRyKbkRXFBE
 WBdDRk4lr2u5XtymAQHp12D37jkBMogFabfzXl1cQFnFAhkSCFr+m5Fkq43uaDr68iQR
 sb6TiYpE5iVaz4nuvQZ+2DgSf4UCkOgJvnvjQhXG2GcEPxUheGMZUGBAS5CAzB4w6lIu
 L6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868346; x=1746473146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0J8v9DNKygywueCRdyX/mMSkZhWURCDm00BQmhtFzQ=;
 b=hil36UfK6KDPGWJTKeLysOhwkb5Y1C0z1oIBk+KjT5CYqcKLMI5BvhyhnQh+/L0fw/
 SocExo4lv0JNjnmRVk0MSqvOEh6tDSSv0n2VVCYdaAH3+gBHla7G6Naj5fpRqFpjBu2s
 +05i4Wu0cvtGZGh1LSOJdRNhOBskSZUoIjBMldaOJsdGle9EcLIcLzjAzCUA01kg8O1Q
 5MPFtoy8tth9ccHZb2E0mJeTK82fvwyMJFCtoL9QcamwNalBhpOcefGlPqI6vKF1oisQ
 OfjPULrh47Tqcu2kJauB0dQzCRL+TMdX2qxlyF4uEK+XF5ggKHANHuUQOke4OERmU6VL
 gysg==
X-Gm-Message-State: AOJu0YzG7dVMXSGxL+cGsdYt5gvbe7uJ5xBeweAl+4kWKoa1PQ5VQL1k
 FLYc6H80/5+eJlDXHZjAD7yugEvFiFtxwqTsPsxg09fYqmvrQCjnoEwzpNoI+g8=
X-Gm-Gg: ASbGncvc7SEhSPeqzJ2VUIULfKQL3Q9RqKeUqtv5RFWDPGxsQACCER1V4YnbI4huUhH
 TH9LTWPsCGb9t6782RTdr9h0ehvIoUVifcvVOG60GLM5+1jIbfxJM5waDBawFzjGOW91sMTBo6u
 VhOdKDvtkO4mhV+iA+Tx0rRiUy7ExXXHw982eeJlY3zXJqC0eIMQcIBqoQYg043+uUG1KxIOtA9
 kRGWd7KxRrnb3gK9fSozDsIfknEzkzL19/zdFr7j4qLBD48W7ca5y1xpg1i+Mm2lPiwXBjV5U1G
 c5LgXzAC+2uf3226NpQ48Vwxf6Eh+pE3o30rt6F3AW6hK6L70FnPSQ==
X-Google-Smtp-Source: AGHT+IEYR6dPWLX65HwUc8Qcj8L4EZ7D0KMeuovaSuZVPspQ0SnTBSyg3wHG/sIo3oGJ1Gz4num++w==
X-Received: by 2002:a17:903:291:b0:225:adf8:8634 with SMTP id
 d9443c01a7336-22dc6a8265dmr136229065ad.51.1745868346125; 
 Mon, 28 Apr 2025 12:25:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7763deasm7646225a91.23.2025.04.28.12.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:25:45 -0700 (PDT)
Message-ID: <1718b3de-9187-4fd0-87e7-ffe91393caf8@linaro.org>
Date: Mon, 28 Apr 2025 12:25:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <CAJSP0QUXuAUxMLOz5Zw1zwk0zwBRwuFM=qCufwf0TLr+w1YXvQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAJSP0QUXuAUxMLOz5Zw1zwk0zwBRwuFM=qCufwf0TLr+w1YXvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Hi Stefan,

On 4/28/25 11:14 AM, Stefan Hajnoczi wrote:
> On Thu, Apr 24, 2025 at 2:35 PM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> Feedback
>> ========
>>
>> The goal of this series is to be spark a conversation around following topics:
>>
>> - Would you be open to such an approach? (expose all code, and restrict commands
>>    registered at runtime only for specific targets)
>>
>> - Are there unexpected consequences for libvirt or other consumers to expose
>>    more definitions than what we have now?
>>
>> - Would you recommend another approach instead? I experimented with having per
>>    target generated files, but we still need to expose quite a lot in headers, so
>>    my opinion is that it's much more complicated for zero benefit. As well, the
>>    code size impact is more than negligible, so the simpler, the better.
> 
> Do you anticipate that Linux distributions will change how they
> package QEMU? For example, should they ship a single qemu-all package
> in addition to or as a replacement for the typical model today where
> qemu-system-aarch64, qemu-system-x86_64, etc are shipped as separate
> packages?
> 

Different distributions will have different opinions.
In case we decide one day (which is *not* short term future) to replace 
existing binaries with a single one, it's probably a discussion that 
will happen.

My personal "anticipation" is that if we unify all targets in a single 
binary (which is not happening tomorrow), distributions can always 
create a qemu-system-common package, and depend on it for all targets.
Thus, every qemu-system-X will simply include the expected symlink (or 
wrapper script, or whatever) to the single binary.
Or they can recompile the single binary for every subpackage they want 
in case they want to absolutely reduce the code size for a single 
target, even though the sum of binaries will be infinitely bigger than 
using the single one.
In any case, it's not something that will happen soon, except if 
everyone in the community becomes convinced of the advantage of building 
QEMU as a single binary, instead of per target binaries.

Even if this never converges, there are still benefits left for what is 
done right now:
- Faster multi targets build: less compilation units == less time.
- Smaller multi targets build footprint: seems relevant as disk space on 
GitLab CI is a recurrent complaint.
- Clarification of code: I hope C developers are objectively (i.e. not 
personal preference) convinced that less ifdef soup is better.

> It would be nice to hear from packager maintainers in this discussion
> so that there is a consensus between developers and package
> maintainers.
>

Sure.

Maybe there is a misunderstanding, but at this point, we are not trying 
to invent anything new. We are just looking for a way to build QAPI 
generated code only once, so it's possible to link together object files 
coming from two different targets.

My mistake was to not mention introspection in the cover letter, but 
thanks to Markus and Daniel, I understood the consequences of that, and 
my position is to keep the current schema and serialization methods 
*exactly* as they are, so consumers don't see any change. The only place 
where we need to do changes are scripts/qapi and qapi/.

> Stefan

Regards,
Pierrick

