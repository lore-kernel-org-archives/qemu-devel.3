Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8B9CEE359
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 22:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syewM-00060I-Ty; Wed, 09 Oct 2024 18:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syewL-0005zv-JO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:13:53 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syewJ-0000Au-L1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:13:53 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso259889a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728512030; x=1729116830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZCWICugwjIMWakeSLtKR3MsCUkXYUvXz7jce3M53Fs=;
 b=GbQm9EYroFr1OM31b+iM7lB9yUt7gEekAx6JUO98FWpIUaZSR+hLx4NrxGKfiPzDUe
 ViUicTzI+Cv7pwahRX25P8yfNrm0MI21TydYDao3mdLCcuAwpM73HfZBWWcMv1y74kpF
 iFTaU7BPdRLWMSCYOv93icjQbv5VecQ/3+33NhHoSWzIZhb1gRfdpTRu7cjenzL+Wx49
 tVVSHq1WKARRrGwtpZUz+rDLXz98UW63oSChkDyEINaRk8j/lqGgLCUsSfmht0XvgN/i
 7TifkbKIZiQeEjO1Pg1AY3jwKsLoZ0ywyqoaiWc5+VpsDx1O8MKSYPoxQNs9k7iQqiXv
 Y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728512030; x=1729116830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZCWICugwjIMWakeSLtKR3MsCUkXYUvXz7jce3M53Fs=;
 b=NuDYjMzAA/m6QZcRwY+wtzVroGRJ52B0+dfZdpxX20/OWA4RySYcalYUAcrhREV7+R
 nH//fN06iWjXUat3C8RqbzI/JlJ21NUXIMbQxUshx/RU+ZHyYE4KX238cpyi6ciJdxm5
 4+P7zS5JU0bAzwL70FgowsJZL0zpuob2pr7xxPuM5jzjRYrFgk40JRA2NS3lP47OPgRn
 vzA9MXByhfrE4+tunNs3V9BLU9xrQXk9W/aC4WArZrqUICvXTZJjr+7mvCq6YdrkqWyV
 l5cbTvhBeWg5siCFiwIH+pP4bj6cyL7dF0VzWFmLitcz78x7HQOX3MDt2WhCzg+eHvLT
 9gsA==
X-Gm-Message-State: AOJu0Ywnz4bs1q7HWEmvYSO7+k7FxFA3Lh8tbaoj/Xl1ilmCk7Nse+u5
 jKxv4kJGiaRaVSeqhDLqOtg0pwF1qFLlmYv0mgEy40TqwHmhIrdH+HZ1FbjDsAZfy8EIVQklnNr
 yu3o=
X-Google-Smtp-Source: AGHT+IE0y7h2omov0oOfORj4CkJqp1ubdREbLll33rqKfltJbqWfvx64MdiTzRm9qUTqStmkIVvjMQ==
X-Received: by 2002:a17:90a:ba98:b0:2e2:cf63:224c with SMTP id
 98e67ed59e1d1-2e2cf6322d5mr332969a91.35.1728512029640; 
 Wed, 09 Oct 2024 15:13:49 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55fc87fsm2222991a91.7.2024.10.09.15.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 15:13:49 -0700 (PDT)
Message-ID: <fe76f462-ef6f-46dd-881a-31d75bdfca5d@linaro.org>
Date: Wed, 9 Oct 2024 15:13:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] build contrib/plugins using meson
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 9/25/24 13:48, Pierrick Bouvier wrote:
> Contrib plugins have been built out of tree so far, thanks to a Makefile.
> However, it is quite inconvenient for maintenance, as we may break them,
> especially for specific architectures.
> 
> First patches are fixing warnings for existing plugins, then we add meson
> support, and finally, we remove Makefile for contrib/plugins.
> 
> Based on the proposal of Anton Kochkov on associated gitlab issue.
> Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
> 
> Plugins are now deactivated by default on 32-bits hosts (since cf2a78), so we
> can enable with meson without worrying of warnings when building plugins for 32
> bits.
> 
> v2
> --
> 
> - removed warnings fix for 32 bits as they were incorrect. They are not needed
>    anymore as plugins are deprecated for 32 bits hosts.
> 
> Removed patches for individual plugins.
> 
> Pierrick Bouvier (2):
>    meson: build contrib/plugins with meson
>    contrib/plugins: remove Makefile for contrib/plugins
> 
>   configure                   | 18 --------
>   Makefile                    | 10 -----
>   meson.build                 |  4 ++
>   contrib/plugins/Makefile    | 87 -------------------------------------
>   contrib/plugins/meson.build | 23 ++++++++++
>   5 files changed, 27 insertions(+), 115 deletions(-)
>   delete mode 100644 contrib/plugins/Makefile
>   create mode 100644 contrib/plugins/meson.build
> 

Gentle ping on this series, to know if people are interested by this change.

Thanks,
Pierrick

