Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06975C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seqnC-0000Sk-Fa; Fri, 16 Aug 2024 02:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seqn9-0000KF-FL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:50:31 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seqn7-000837-D0
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:50:31 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso2516671a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723791027; x=1724395827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sqzkOTDqgWz3fF4bePmGaPrZAMlWTo/OaY3OabFcfkU=;
 b=UEomAhr++OEscAgcfoNbBcdhy5akLBWYZ6ZkR4uEnCE8J6ErAL9m5jwW/qkCuY1LvP
 v5CvaKNn2Jsw7K1nv9iPisVORSOEiEEXzNlv5rGQGXiSuoK+0Yo8lY1H4r1fDxUdyf5h
 Xyi3NFUadDbZBw3L7Z8xxqbt745efFu8Pl5FOJFpb4XkXPJkT60OstsmNo8KsgUv5+FT
 YEPp3o5rwlurKHTuaoAl1AgoRiBUQraVvzR94GTMG5PkIr+Q2KfH5ITddLVnIBN4wOyV
 qzrmifQxEKTCDBUzmlTrjwTC38lStfGQDY5gFzMmsEujriWQ8VjtXUXqeuzmyY09VkbN
 8UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723791027; x=1724395827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sqzkOTDqgWz3fF4bePmGaPrZAMlWTo/OaY3OabFcfkU=;
 b=ptW/3pbPXxSW9qvRdu83nbdV1MDxV7Xt/qVB3XvJXDQh8WO1jn8coWlw+dQMNTzlga
 zMtgASTaW79LiOkyn34GyaywBFmhQSNUdWjZk5lcyzdZcL/mHvBvQ0Xh4+DVw6TrECcg
 Ui514xsEXaBh1PpggwqBNrZef5/YDv8dwp4W+YKZB8siO1wP8vlKYyY1pJog4osdJC7T
 +WiN0NhlrIN/SxEfNpMk/Pav64xssj+u7Ep+mu24LP1TXqeXzUCNqih1pU4o5xi3+ZW8
 UhsPwaY7AD8MBGSWXvejg9J1mHEvDXNmup5vRPPBQAqdIpm3ouaah383n4JCjkzCp2qj
 XebQ==
X-Gm-Message-State: AOJu0YziW4swFuZdlcVCsKiMm6drZVufW+8jILbFGRyVzhMzP+rfyJQH
 7Tos16oekJzpHIgYFcDqbHEhCl7bMxIGc80QrAPmcS2gYoFbXBbDOr5YhHV7pys=
X-Google-Smtp-Source: AGHT+IHMuOhUSJyatxj5t8SBU+REvdmKchN8Okqn36Uohx4vGVwsX47DF14R+hbU7WZE+hSw1Cb7+A==
X-Received: by 2002:a05:6402:254a:b0:5af:3af2:e2e3 with SMTP id
 4fb4d7f45d1cf-5beca77021cmr918418a12.30.1723791026672; 
 Thu, 15 Aug 2024 23:50:26 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-185.dsl.sta.abo.bbox.fr.
 [176.184.30.185]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc081ea9sm1817133a12.87.2024.08.15.23.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 23:50:26 -0700 (PDT)
Message-ID: <742058e8-dc26-4d67-8b92-41a62ae675d6@linaro.org>
Date: Fri, 16 Aug 2024 08:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
 <f31bac22-5fcc-4f01-9eb3-c9512daa41d7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f31bac22-5fcc-4f01-9eb3-c9512daa41d7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/8/24 20:04, Pierrick Bouvier wrote:
> On 8/14/24 23:00, Paolo Bonzini wrote:
>> On Thu, Aug 15, 2024 at 1:37 AM Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>> Contrib plugins have been built out of tree so far, thanks to a 
>>> Makefile.
>>> However, it is quite inconvenient for maintenance, as we may break them,
>>> especially for specific architectures.
>>>
>>> First patches are fixing warnings for existing plugins, then we add 
>>> meson
>>> support, and finally, we remove Makefile for contrib/plugins.
>>>
>>> Based on the proposal of Anton Kochkov on associated gitlab issue.
>>> Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
>>
>> Is the bug actually still there?
>>
> 
> Maybe the changes you did fixed the portability issue. I just added this 
> "solves" because it's where the idea to compile with meson was presented 
> initially.
> 
>> The Makefile explains why it was done this way:
>>
>> # This Makefile example is fairly independent from the main makefile
>> # so users can take and adapt it for their build. We only really
>> # include config-host.mak so we don't have to repeat probing for
>> # programs that the main configure has already done for us.
>>
>> In other words we should also take into account that there is a
>> documentation benefit to having a Makefile that works across Windows,
>> Darwin and generic ELF Unices. Anyway Philippe, Akihiko and Alex are
>> the best people to decide.
>>  > One argument from moving contrib/plugins to meson is that the Windows
>> case depends on libqemu_plugin_api.a which is built with meson(*);
>> that said, libqemu_plugin_api.a should be installed - which would
>> justify it being used from an "external" makefile.
>>
> 
> You need meson to build this lib in the first place, so I guess that 
> 99.9% of the people writing a plugin will have a qemu source tree (with 
> access to plugin headers), and first compile the lib.
> 
> I am not convinced by the scenario where people build this out of tree 
> to be honest, but I may be wrong.

Consider users interested to use plugins (not really develop them).
They should be able to build the plugins with their distrib QEMU,
not cloning the whole git tree. (At least this is how I understood
when Alex explained me the plugins power and simplicity for users.)

