Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66B4C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 16:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb0xJ-0002AE-DH; Fri, 16 Feb 2024 11:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb0xH-00029g-MA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:20:51 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb0xF-00007V-Uv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:20:51 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d0c7e6b240so30204881fa.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708100446; x=1708705246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Q1LtY8IHY+WTjlINQfJ6sJbZKnbUB75zr9/ihsIzUc=;
 b=GIIIx545ewgP8PkTZ1AKj8LqDVjKLjS2dTrXjfU7GU35ZhGzEtWI8gyOhVCydWU3Oz
 iSuo4NVT67bBIMUtKm895eBnr5RpakYCEMlQV57BfmXcPopCDoWGG/j+2b4/OIO5H1O/
 YJJK6I1e7m+cTsV42081+e8EAsuxEl/50EKA7sI29bfeId5K5AkUPpY5iKszIW5Q4VJH
 ZzZewLKXx3teSRihz+ctQFHMTnrI6kvOGoGXlib23SFN0b1y49uiO11gU7vqRzMZnaUC
 bNxYHuEpEAfUcY4q4tyUBwmTTl3g6kXkw1zWeaNIlwuaPQeNHcswwagWFb0KmOUN4CK3
 eloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708100446; x=1708705246;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Q1LtY8IHY+WTjlINQfJ6sJbZKnbUB75zr9/ihsIzUc=;
 b=V3BRtNB7ymmpYTT4lfK8wypgiWGM2Ju+2avFQnZRznnbaQPgNEJ0mmShNxjqYDmne8
 rIKPEhIF4swSxBETjUg4rSdqnxRsgF3LGdYJFDzwq9cYgBTK/rKgg4BHW5ACa2xz/ZPg
 gNP0CUstOxZKgYqvym282L55e/2NXWDIF0r8JFToMVTCWprub+PrysL5nwj3ht/EN3qC
 jEUdF/MoDn0ZuT3o0DgR2PDKcpSYjRLGPV6ouJIjb0A6NntKQI1fCiUFHSC++o8HUjpn
 kkwH7bSkoAi2Ct4fAo39PH5OwBr87q4zvjPhVUrYpfu+C8mFewlYh1eFq8PNnHPYoG72
 QnZA==
X-Gm-Message-State: AOJu0Yz87pdeRYEMNf1trLg27AvsK3qA2YbFoLoJeOuMpe7jfN/FMv5W
 S0NZmSOnOIjoPuWMsLc5qYDvzjM+d4Fj4hsE6C/NcLdJQ0MP51KBQ+t7pWr1f40=
X-Google-Smtp-Source: AGHT+IE6Qy8JbBSIAhrDaZL5oMZviNPe6zBtxBg0kLPffNEkAGh/r7lBou2Y9SwTjHt2wfdo0iXn9w==
X-Received: by 2002:a2e:7a16:0:b0:2d0:f96a:23b4 with SMTP id
 v22-20020a2e7a16000000b002d0f96a23b4mr3545574ljc.7.1708100446544; 
 Fri, 16 Feb 2024 08:20:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm2053967wmo.16.2024.02.16.08.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 08:20:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D805B5F83F;
 Fri, 16 Feb 2024 16:20:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Yanan Wang <wangyanan55@huawei.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 00/18] TCG Plugin inline operation enhancement
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 13 Feb 2024 13:39:50 +0400")
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 16:20:45 +0000
Message-ID: <875xyo4bz6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series adds a new thread-safe API to declare inline operation
> inside plugins. As well, it removes the existing non thread-safe API,
> and migrates all existing plugins to use it.
>
> Tested on Linux (user, system) for i386, x86_64 and aarch64.
<snip>
>
> Pierrick Bouvier (18):
>   plugins: remove previous n_vcpus functions from API
>   plugins: add qemu_plugin_num_vcpus function
>   plugins: fix order of init/idle/resume callback
>   cpu: call plugin init hook asynchronously
>   docs/devel: plugins can trigger a tb flush

I've queued these into the maintainer pre-PR series I'm about to send as
I need the callback fixes to make the register code safe.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

