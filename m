Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C83C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xY-0004ts-DQ; Thu, 24 Apr 2025 18:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u84xW-0004o3-ED
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:18 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u84xU-00010o-Kq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:18 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227cf12df27so15582815ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533335; x=1746138135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=in7ycEaQX4319N33+Vm62vX461QLG8559UsiXNL2yRs=;
 b=l653YYYK/doFIjxT7pzND0jHhNzHxZ36dVEizrElzwG7Nfr2czHyLsrM9c++elcHGV
 EqipIfWGQrnhC11mOwl9ND703rTVyfA6Z88krqHWAAXeFLN1SRy3g84lAdFdOoQ6s2cx
 u32nrA5V+TGHIzzolaIa4UCgXp/ouxuhVIz9ta49LMviZY6EVSzZtddz4394tC1yM1Mm
 6OTdnur0zKnksM3S7iY+067jLIwcmKysRTLRH7ETGPms3oRpgu6Gmfv99NJgKWAPVmDY
 JHqBjttHnpKWpWAwR/VC4ilibL65rAFJv3BREIeRDMpSWNgpBuG0GdwjCPOUxTF/u14m
 FtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533335; x=1746138135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=in7ycEaQX4319N33+Vm62vX461QLG8559UsiXNL2yRs=;
 b=ZgGeCH+PpQ1oNfS+vqBxum9aAgJb+zSR1qaaZxlpkE2urmdXh4fKXBiD0xcblV/VTV
 UKDxF1Ctawn5nPKXdu9oPdFnT0Ur06ITOLiMaNdYgAlOa7Dkh64Y2/SMMOzuPO4UV9vA
 XPOU2yj/vgouqdfUGF9+ljFb/Qr0vHl50vZnW92THnXRMO7DqTsXt0OYrCX2fRTyX6tr
 /HyVXgBnGJ2J2ORF6GqFxrDSVjEammo4dKBu8j+BrHwjRD4vNLGdJ4e1tHzKlBOZeLIt
 NBhgBjHWniUtIzvSM+chsFWjCsHANfO2C2kt/nll0Us9bfy44lvqlRTUp+Qfhyh7o53d
 7VNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3n4vS5ovKO/JBurVZFVrNDwTVKDSH7MTe/FxMGSfjFIYtFaUBbh8B2SSl3PzbIPTMdNz1msdMAJiK@nongnu.org
X-Gm-Message-State: AOJu0Yy5zJ+qbF7qv8JnSPwZlPXoJaPt/bex5V4+ssf0ZfP2E23cKO5G
 j6oe5FeRJb3y/dAnYusVcxebPCOp3nAlNeeL9dEWqXQGIGFP3faLL7OsFum7XR4=
X-Gm-Gg: ASbGncupkAN9GcEBy5SaOg/Ta/KyTHgaSNN1GCdUZ4pxnj4vFh3zC45bynZaFz+iAeU
 yVqSPinbrTri/QIKCuPz7Rvm/v9i+iN+oGse1BoaEI1RpEQllFmXy1wSnnil/oPxIP/yakgqYF7
 ICpiXS5ZuglD/y5Vwa3O2EHexqu9E6yXoircUYQd8eK66uGCbA4T8goUu1YjGGc6R2SmTjAVGlG
 2y3IujlfgCesHRpadArKTWRHkHgnuOsocE7aFK88kgk+sBf2GoEinU/4+65W0JpV7h7j+Bshtui
 MuGrusHdkZ3yNcAbaiSdWGpAM9QpDkUhcSmNbs4PUZ1aIUDgFd+q/w==
X-Google-Smtp-Source: AGHT+IGefSXTK3qrUDtnIVZrpLU0Ie54Z0mqzP2zXB5Tj3FT6JZWf8FIlfjJTQv1xkYwZwjQc942oA==
X-Received: by 2002:a17:903:320b:b0:223:5187:a886 with SMTP id
 d9443c01a7336-22db49724d8mr54941435ad.22.1745533335203; 
 Thu, 24 Apr 2025 15:22:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbde17sm18927165ad.83.2025.04.24.15.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:22:14 -0700 (PDT)
Message-ID: <c758f0a3-3228-498f-a2d2-e829b53cba58@linaro.org>
Date: Thu, 24 Apr 2025 15:22:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <b0d553d0-be66-40cb-8fde-1b1554720db8@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b0d553d0-be66-40cb-8fde-1b1554720db8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/24/25 13:43, Philippe Mathieu-Daudé wrote:
> What about function name clashes? I.e.:
> 
> 389 ##
> 390 # @query-cpu-definitions:
> 391 #
> 392 # Return a list of supported virtual CPU definitions
> 393 #
> 394 # Returns: a list of CpuDefinitionInfo
> 395 #
> 396 # Since: 1.2
> 397 ##
> 398 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
> 399   'if': { 'any': [ 'TARGET_PPC',
> 400                    'TARGET_ARM',
> 401                    'TARGET_I386',
> 402                    'TARGET_S390X',
> 403                    'TARGET_MIPS',
> 404                    'TARGET_LOONGARCH64',
> 405                    'TARGET_RISCV' ] } }
> 
> $ git grep qmp.query.cpu.definitions
> target/arm/arm-qmp-cmds.c:238:CpuDefinitionInfoList
> *qmp_query_cpu_definitions(Error **errp)
> target/i386/cpu.c:6418:CpuDefinitionInfoList
> *qmp_query_cpu_definitions(Error **errp)
> target/loongarch/loongarch-qmp-cmds.c:30:CpuDefinitionInfoList
> *qmp_query_cpu_definitions(Error **errp)
> target/mips/system/mips-qmp-cmds.c:28:CpuDefinitionInfoList
> *qmp_query_cpu_definitions(Error **errp)
> target/ppc/ppc-qmp-cmds.c:192:CpuDefinitionInfoList
> *qmp_query_cpu_definitions(Error **errp)
> target/riscv/riscv-qmp-cmds.c:56:CpuDefinitionInfoList
> *qmp_query_cpu_definitions(Error **errp)
> target/s390x/cpu_models_system.c:85:CpuDefinitionInfoList
> *qmp_query_cpu_definitions(Error **errp)
> 
> Prepend target name to these functions and dispatch generated code?

In general, either we'll:
- unify implementations
- create a dispatcher function (based on TargetInfo target_arch()) + 
renaming existing symbols with suffix _{arch}
- we'll create a specific interface for the concerned symbol if needed

In this case, given the implementations that are very similar, maybe we 
can unify them in a single function using
target_info()->target_cpu_type().

It's not a problem at the moment, and not directly related to QAPI 
generated code. We'll have to deal with symbol clashes when we have 
deduplicated all compilation units. QAPI code generator does not have to 
solve this.

