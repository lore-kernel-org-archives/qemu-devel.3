Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF621C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 21:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD8Uy-0000w8-5i; Thu, 08 May 2025 17:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD8Uw-0000vu-N4
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:09:42 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD8Uu-000310-OE
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:09:42 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b1fcb97d209so2406682a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746738579; x=1747343379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+CTyW4erm0mU3TkRLQQ7QNHC2FOJHqKozGF2GSdmSk=;
 b=CZIU+s1T83UKPnE4KeXxELxVzP6VUMmDm9QGCYmxr24gWabbUMvknE1HogmvSD8szp
 hmmdtQ/57WEfAeyU71iEq6FLeMCidb269+QMAONBOFgVqq5tr5V6A/hZ9E8sMJltx8tp
 KHdMWKWXgHNiTKgYisqjiy4poxqi88AHiPfcGFAiMJAu5oO4zsuDvGzatjvV8bSMyrh1
 jVIBjgNELtKZ7Z8O/peRBaynDJ7cIVtbX1NMoLMjfR7ryCBF5RcIZvN9iLnavTsCeKOK
 Exu2gd80D5iBoYqixpBNqsjQBb930ycQYIjWtfNb3DXJH1ki0B+N+lHEZhXmsQH0PC3v
 58dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746738579; x=1747343379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+CTyW4erm0mU3TkRLQQ7QNHC2FOJHqKozGF2GSdmSk=;
 b=rDPgZvQ7pXAuMIMJZI9p9L746/1FNeloNub9FYuhVqPmYHVRLuH5e7aa5XDpHRIuo7
 iJA/TRlZtaBpeTPkPd4FtCJq0uPs+gVaJMlurS1SaN2Jrq/36lhuuI1C9p5vyBx2US/9
 75EdGat1irx+4Vp8j2QS7DWPX/jr1Sui+dn6qp9Xc+pKbp81dOabhcgabbw95SL0F6Ct
 PJmeGeHyX4zXbufjiP22lCSCbbslaES10YxlI6OaVH/SsbBwtcY/jFdtcdAByHE2zKyV
 D1DNOkrJ3d2s1mUqWbw7QiBbuAGFUp28ukwBZ6DOeZdc08qlvxtASD1iHxKhh3deK2IA
 qF5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMWHhKtb0G97bi+ecfSFyt1/bsx2zu00bYGnbfAKVlK8K3ui6E6vI61Y3oCAQEc1Q20A4HCleiU98H@nongnu.org
X-Gm-Message-State: AOJu0YzGkGTR/hRay4DOECjurVBnyNOPn/HmAxNokw0kmvqW/jSuA2Qo
 G19Rh6qAeXkHrVficz13Q59pHb/eXmMa5LI5/d9hvljPZYqREr+MCrDJD9BVQKU=
X-Gm-Gg: ASbGncvkOrmPWZYGefgBP9u4cEEoo9tIfRllWDrvPeSO5KmFQtmSm0EXZ79R5sgCF4S
 jddO40IznoIRwgnwZGDBEUewd8NDPqjsjDArtyazGjCz2OlKddBEve7TngMVKF5FZSJvj+ldTTb
 4Av5GgF9LYUnpH9YaIDaCT/5vPlhktEA9hVedbgiXRjsyMmr6ZdIieUcqVvhfeMzOOwIHb4ofhk
 SqMX2tq9n8nQXmNNLn8FJTF9puXsbERoQsKQ9d27hIXRDuMTTPr+avckORtSe5wrd9MxgFy+hdD
 GD6lGY5FOrXzyvYxCuxLa8suGILbQq+P2agkQ+9mB4re9Tg/uOkaXo7ofzW+eDIm
X-Google-Smtp-Source: AGHT+IHbvpH57IdUqagdM7XxJVFdbgHLA2m0Bau3lmF6ZhFKeKsK3cVcRuMp+gSa40s4ITgW9ngzcw==
X-Received: by 2002:a17:902:d4ca:b0:22e:3d2e:d94f with SMTP id
 d9443c01a7336-22fc91cbaa2mr12813235ad.0.1746738578899; 
 Thu, 08 May 2025 14:09:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc8271af7sm3949785ad.151.2025.05.08.14.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 14:09:38 -0700 (PDT)
Message-ID: <c7623b1c-01c1-46c0-bfa6-dc34aa4e722d@linaro.org>
Date: Thu, 8 May 2025 14:09:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from the
 schema
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508135816.673087-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250508135816.673087-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 5/8/25 6:58 AM, Daniel P. Berrangé wrote:
> Pierrick has proposed a series that introduces a concept of runtime
> conditionals to the QAPI schema, in order to adapt the TARGET_*
> conditionals currently used at build time:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01699.html
> 
> For the sake of comparison & evaluation, this series illustrates the
> alternative approach that we've discussed of entirely removing any
> concept of TARGET_* conditionals.
> 
> With this the QAPI schema varies solely based on CONFIG_* conditionals,
> and is thus invariant across different target emulators.
> 
> In this PoC I've taken the minimal effort approach to the problem.
> 
> The QAPI schema has removed the TARGET_* conditionals and in order to
> make all the emulators then compile, the stubs/ directory is populated
> with a bunch of files to provide dummy impls of the target specific QMP
> commands.
> 
> This is sufficient to make the current QEMU binaries build successfully.
> 
> To make the "single binary" concept work, however, would require
> additional followup work to eliminate the stubs.
> 
> Instead of having stubs we would need to de-couple the QMP command
> impl from the machine internals. This would likely require greater
> use of interfaces and/or virtual method dispatchers on the machine
> class. This would enable the 'qmp_XXXXX' command impls to exist
> once. Then they call out to virtual methods on the machine to provide
> the real impl, and/or generate an error if the virtual method is not
> implemented for the machine.
>

Thanks for posting it Daniel.

I think your approach is pretty neat, and yes, it's much simpler than 
having any compile time or runtime conditional to deal with that.

When we talked about that on previous thread, I thought the idea was to 
expose *all* the commands to *all* the targets, which I didn't really 
understand, considering we have target specific commands by design.
I understand better where you wanted to go, by extracting concerned 
commands in dedicated files.

The only downside I can see is that some commands have to be there, but 
return an "error, not implemented" at runtime. Fine for me, but some 
people may argue against it.

A concern I might have as well is about how we'll deal if we want to 
hide some commands in the future, based on various criterias 
(is_heterogenenous()?). The mantra "define all, and let the build system 
hide things" mantra means you can only have a single definition existing 
in the binary, by design. But maybe it's not even a real concern, and I 
definitely prefer to see problems before fixing them, so it's definitely 
not blocking this approach.

Overall, if I had to choose, I think I would pick your approach instead 
of the "runtime conditional" route, it's just simpler and saner overall.
I would be happy to see you take ownership on that, as long as we can 
deliver something in the next weeks. I can help on anything as well.

@Markus, @Michael, which approach would you prefer to be followed for QAPI?

Thanks,
Pierrick

