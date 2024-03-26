Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD110CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3YI-0000RG-EI; Tue, 26 Mar 2024 05:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3YE-0000O0-39
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:57:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3YC-00073s-Kj
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:57:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4148e20fb7eso4671315e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711447019; x=1712051819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3s6GaCi/IxM1yJCmi6lVc+625wH0zfxnaJRbtTOCr3g=;
 b=SxmMJ68Ui1Z2IzXdiCiBnHsuMWs0oQ1vWHe5e7bVvIgh2jO9+/QJ9OMLnwZO553MW7
 Gn8svzfpovpmhC+kbTwu1rM/RdUKv51jYubXcjVS80fijLoj9l/EBnVYZnEYZMNmUI8E
 xjg1eq7vvX21odYAjV+yoQo/C0mYuAwJGIho0GwBOtePoy64Oc2VnuYBOcXKAWXiKLnG
 iKScet2rDNxHdkuPGAZTkFaFjqlRyfTquP4GttBlAuhXf+nagGc2PgAap2KOoT4+z0dK
 4rQTtc9fLhGcQl4PkdNVq2d2jdxv8IG5ECPLILc9Hb46yIr9wbEBdl8yQ68/5Q3JV/D3
 9KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447019; x=1712051819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3s6GaCi/IxM1yJCmi6lVc+625wH0zfxnaJRbtTOCr3g=;
 b=KLJFJqd5UC55cY1iN3SrR9WOdxq5Lg/u3kuP/3RR8BCPsGsB76TO//boOtUaPz631J
 gdOhzeNfRGXDq3YUxf6o4/npiS6L4xoA9WdSplWBj3ACSUC6Ste9Z69+rmiHq2mV0lvt
 hZVhZyMbMHiV67RjH1fd+fMfxdz0Ezdc9WHuvelpL+3feMdMn4KYAyjfUDWOpW0WL74w
 xCz0rl2kBwjzvHsjsTMMT1ZcfnF9KlPci+WbRYOXr4KEVF2dp4ZZ5HLqm+ghdeDrRMOV
 rbCy5nGeBQ++O95WXyt+sWUjJfAH60w8dGzgMbhXyFSG5RxE7uVU+vtCbQhSJ6v/0OEd
 4Qgw==
X-Gm-Message-State: AOJu0Yzb12KMh5uTBsYhsK5VSOUc3+dDrv3fH45B3vut1G7xqablMCh1
 Y5xwgvg53WFEBlskjW+C8a+A2EXGVblywUv7uAlnzYmBSVFQ7UcXWUVmWUn0rFU=
X-Google-Smtp-Source: AGHT+IFbS8ehk95HhsOiffhtzWzpe3AHzd/C0MGoBVFe1wiA0HVWPj8VWWjyMTXPqMQZVBoRpIa67Q==
X-Received: by 2002:a05:600c:4792:b0:413:e8db:2c9b with SMTP id
 k18-20020a05600c479200b00413e8db2c9bmr7489635wmo.40.1711447018955; 
 Tue, 26 Mar 2024 02:56:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b0041462294fe3sm11043010wmo.42.2024.03.26.02.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 02:56:58 -0700 (PDT)
Message-ID: <51ce7e24-7708-48fd-a9d9-5164b6fb2430@linaro.org>
Date: Tue, 26 Mar 2024 10:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fixes for "ui/cocoa: Let the platform toggle
 fullscreen"
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240323-fixes-v2-0-18651a2b0394@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 23/3/24 07:20, Akihiko Odaki wrote:
> This series contains patches for regressions caused by commit 91aa508d0274
> ("ui/cocoa: Let the platform toggle fullscreen").
> 

> ---
> Akihiko Odaki (3):
>        ui/cocoa: Fix aspect ratio
>        ui/cocoa: Resize window after toggling zoom-to-fit
>        ui/cocoa: Use NSTrackingInVisibleRect
> 
>   ui/cocoa.m | 90 ++++++++++++++++++++++++++++++++++++++------------------------
>   1 file changed, 55 insertions(+), 35 deletions(-)

Thanks, series queued.

