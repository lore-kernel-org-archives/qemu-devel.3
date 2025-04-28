Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0432C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NuX-0002tq-9x; Mon, 28 Apr 2025 08:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9NuO-0002po-K6
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:48:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9NuM-000234-HJ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:48:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so43010305e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745844504; x=1746449304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOvMzqZNEauJSa0sSwRAbDp3dy/gPDK9FygL0uEUWOs=;
 b=LVGxflfTAckAiXkZQtmR/f0qIj2PMFNavW9MCApn1aQlxO903lI7kiB+QR/78X3wNr
 CEpy57UcUDzcRpAHKaI0udklePEAfyCauRiGGYRyDgmiJCzN3Cmk/WaQZq/Vf6MkLnGf
 fSyIqFFlEabS5GmM7XFONTvEs425jIifNoad3jYuBz+qTcDMDazGXxqHBz0cyZpNgRub
 TzsygbnYUEpiIdICycYTmkxAfoDlnimCRbXpQxPy2paEY63hoO+8JOluVAGRfsXjzo7G
 8JIk6oUgAqHAyyF4Umzti0Ygh5KnAfxN0vhpafw9822rrN5n6NX2CsNXWZSrmvPQZ9i3
 cRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745844504; x=1746449304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UOvMzqZNEauJSa0sSwRAbDp3dy/gPDK9FygL0uEUWOs=;
 b=U9jysTBe445hGkASEGIxSU6v6IiElqWJ6XgTLPvYfBIR32Iw3+Zx8e0UuUFVqckC2l
 +N8+Dx+0WwN2cjdSJLWbTO7jR38tiJgNpP8SA7rUWUDHMO1WhHaYnuBBb+yb2nw9tnCQ
 Dh3EL90QHS8FQkh406VZ+V5Zi26a+q3bp4VGVlFpRe0G6N2Ey37nLRpAVsWci0b1OXJb
 Jzd54inoHBw0hEUChWxmcWLKX75j0n6Tsp1yfZ+l7cWOz4elCYlHXxu1+OwBVvPvf9mi
 hDC7AYI7k+/k9NFjsG5KsEgxletn9n3fFAszEZIvl/X0J9JhcgRv2STiuMUBhUwE/0T8
 e1Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW62d9mGmrer3V8EaSodoQAFvlviEExxxWMYqCPBwMIP29yAs6+h/9sqrmhrEmpix2fOkAAVdYJ8yc2@nongnu.org
X-Gm-Message-State: AOJu0Yzf4q6ml4HLtv7GqmA/iOikm9qzWWZAbRMtQ9whdU45FaRpLINB
 lPMjHzWbX+xxkHn4fB4MKOwx0coXpXYymv6QFsVPJop/01JY2RRbNXMpnnwfXg0=
X-Gm-Gg: ASbGncs80FwCKtRu5n/1ueGwnRM7EGEBb/mq6Q0wG+kEX1jXiQ4pAQD9R7Za97UfmU6
 M6hDUJ7lkVCaK0aOwpPZ3xWiJBK3JT3+f3UzOIC2aP6M1CwF/EYxLiHq4i4NNAAof53lS7rcygT
 2IyveResyvdLX4eTNY0Zh9nbbQlOys01U9sJsR0Q+Iw4HfduH5rBKOgciz6iP9SEcWp6HBjgoQx
 qzCtFmGAEAsSYAT91VTZeSNhThA4KRkwplS/JlbieQqyc1+llzbL6cNdZogG+ZvaKLr8hlox37v
 dO8jeup4kN7IMefTXbNEFL2r+hS+95n/EnONcaawtlX7TE/P9GxivOJs+IJUF8lMKEGi1dPYrvr
 rdmFYPwfc1ryqCQ==
X-Google-Smtp-Source: AGHT+IFKV8R2KbibiXWrd79bTADpS6SVJDNaGz0iZt4NrsogLRW3srdxdXNe5TQkOeQsn6q39y1Ihg==
X-Received: by 2002:a05:6000:2409:b0:39e:cc5e:147 with SMTP id
 ffacd0b85a97d-3a074faf8d0mr9497043f8f.55.1745844504293; 
 Mon, 28 Apr 2025 05:48:24 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da02sm11152704f8f.93.2025.04.28.05.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 05:48:23 -0700 (PDT)
Message-ID: <e8213635-d917-4a8a-afd5-0d7c940bbf15@linaro.org>
Date: Mon, 28 Apr 2025 14:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org, Mark Burton <mburton@qti.qualcomm.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8734dswnm3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 28/4/25 13:07, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:


>> The second thing that libvirt does after 'query-version' is
>> 'query-target'.
>>
>> So what should libvirt do once multiple targets are supported?
>>
>> How do we query CPUs for each of the supported targets?
>>
>> Will the result be the same if we query them one at a time or all at
>> once?
> 
> Pierrick's stated goal is to have no noticable differences between the
> single binary and the qemu-system-<target> it covers.  This is obviously
> impossible if we can interact with the single binary before the target
> is fixed.

My naive impression is "management applications" aims mostly for
virtualization (likely 1 single target). Heterogeneous (more than 1
target) setups imply some kind of emulation.

Are *current* "management applications" interested in managing
heterogeneous machines? If so, we could introduce 'query-targets'
(note the 's' suffix for plural).

Some users (EDA industry) are interested in using some QEMU transport
layer (QMP?) to dynamically create machines (see [*] for example).
IIUC only a subset of current QMP commands is needed for that.
Maybe we can only adapt and enable these required commands for the
heterogeneous binary, and keep the current ones unmodified for the
single-target binary (where you can run a single target at a time,
identically to current qemu-system-FOO binaries).


[*] 
https://lore.kernel.org/qemu-devel/20220223090706.4888-1-damien.hedde@greensocs.com/

