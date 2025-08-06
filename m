Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED35C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujl8C-0007QC-C5; Wed, 06 Aug 2025 16:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujl89-0007Ox-7s
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:53:01 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujl87-0004yR-IA
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:53:00 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b427f4a9652so208482a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754513577; x=1755118377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqL2V0LXadgKcNe1lvkmywiAnDzhQh/mHa8qYCBv1WQ=;
 b=OufXVzs4DoDe1f0WMOXHAPxWMMyAorvZWAIKg1afemuYq/Vn1rK56pItL4wPLieF1K
 wkmF73UFOqLE/C9pxFBU14XYKQ6By0Xc5+r8zQn2YD/BO449gtm0g6SxciRYmXdzgr0i
 VLRnAntibWxtIdP50igy1MQ5dOolbrmoh1mUvVSi4jriDWl12X3c0sU3uNbhCfNx0wl4
 +zdCQ7Y8raFeJOFbepjmBL8yNbsI4ZgwVP/puhHl8yGXfKRPwvfT7UO/66Va0zvOUZZK
 /5OMLj+InOTPIjPnYraAB4QNITRAXVCUcxiF+Py5FugdORza4/3lWEhA5toJAoyaYk5X
 j+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754513577; x=1755118377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqL2V0LXadgKcNe1lvkmywiAnDzhQh/mHa8qYCBv1WQ=;
 b=O8GXlOzHv3JKdkG6GW22gmFXTFiqjazP9l/PztLssL4efsJBKWUQi9TiO3jOrgO5Kk
 lwS7rxrVRv+m6npteB4uIBxIhzipKYndbkIW3l0AOdZwv2NJqvQ2Luy7IHLjUEajdhJu
 YVI4fgVfBFigxModddR+11pBaenTd2kFBZB357enYOhhOtb3Kc9y195umwpc6uZ3LyQs
 ze41PtvO/aDnq+wigLhJi3h2h9N2e/nNwj0wyArHHPS6adPMzc822ibTyozHkwFmedbw
 fZEBXxH6XFaee4RkgrP3wh0idVQS9LfnKttOW7tzA8O0zfa7aa8qdxw2VLHBSz9deVgZ
 QPFw==
X-Gm-Message-State: AOJu0YzAhDryYIYP6UJ5OFvfADNmxk11R4PGGOtphve/kM6sYL2PPdgl
 HdZYTWgrPleg9Yk7QPReqxQHcUy9pgw6RPWcg2I4uT4opUyzJkDESrhNQ6XtU12gcHA=
X-Gm-Gg: ASbGncuw5ZRbGubLmvAVxlkjO6YmyHlVnZbLk243oyT5E/sdIzYRCSRdtRFcnVnb8Ul
 xnJfhs/IEUacxMIJg5BG9KG/qMKhx7SWTw0k4HPRMC4qSHml5M1LoEbyglSF+3ITUdXIFz2etQu
 ulcxhTQ4LHet95bhMFoEuLrhrhgT86R1U/+uMhErdzfRb89vroDJvESAmo6/ARRaHwW1n3uAtWT
 cQm1yexjIOw48UaHw+Y+YEobouunJcoQDasFXctsIEatiZVCJbLjWMlJwnhJfpMGDG8CN3yClU8
 qJRTL2Qzh5KNJfANNDnlgo8LW8vArP2o+TBnJEeGWdWCyBD0EX9nbq1a0OYlK+l5ssAPE/yON4e
 EtaTNrsABpellrlDDDyAhbJQ94/MWR/cVmy8=
X-Google-Smtp-Source: AGHT+IEvLzeB9SfZOtEQ9JI/BMY85z90kkdy0V8h/dzILobIrZ4zHIUcbN9MYCHv/t2zUS1oGOjgBQ==
X-Received: by 2002:a17:903:41d2:b0:240:8704:fb9 with SMTP id
 d9443c01a7336-2429f582b30mr58711275ad.53.1754513577539; 
 Wed, 06 Aug 2025 13:52:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89a3acfsm166673035ad.146.2025.08.06.13.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 13:52:57 -0700 (PDT)
Message-ID: <4ab89a81-0463-492b-86d5-1c7af1e6453a@linaro.org>
Date: Wed, 6 Aug 2025 13:52:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] meson: Fix brlapi compile test for Windows builds
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20250806204624.510091-1-sw@weilnetz.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250806204624.510091-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/6/25 1:45 PM, Stefan Weil via wrote:
> brlapi__openConnection returns a brlapi_fileDescriptor which is a pointer
> for Windows builds.
> 
> The test for brlapi fails with cross builds on Debian trixie
> (x86_64-w64-mingw32-gcc (GCC) 14-win32):
> 
> testfile.c:4:30: error: returning 'brlapi_fileDescriptor' {aka 'void *'} from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
>      4 |      int main(void) { return brlapi__openConnection (NULL, NULL, NULL); }
>        |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----------
> ../../../meson.build:1607: WARNING: could not link brlapi, disabling
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> I think that this patch is trivial because it does not change
> anything for Linux.
> 
> Note that this patch only fixes the configure test and allows builds
> with the Braille API for Windows.
> 
> A similar change can be applied to chardev/baum.c and will be sent
> separately because it is not required for 10.1.
> 
> Note that for 64 bit Windows there is an issue because brlapi_fileDescriptor
> is a 64 bit pointer while QEMU assumes int for file descriptors. But the
> good news is that the resulting code seems to work nevertheless – at least
> the people who asked me for Braille support on Windows are satisfied as
> far as I know.
> 
> Regards,
> Stefan W.
> 
> 
>   meson.build | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index e53cd5b413..d6abe1917e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1586,9 +1586,11 @@ if not get_option('brlapi').auto() or have_system
>     brlapi = cc.find_library('brlapi', has_headers: ['brlapi.h'],
>                            required: get_option('brlapi'))
>     if brlapi.found() and not cc.links('''
> -     #include <brlapi.h>
> -     #include <stddef.h>
> -     int main(void) { return brlapi__openConnection (NULL, NULL, NULL); }''', dependencies: brlapi)
> +    #include <brlapi.h>
> +    #include <stddef.h>
> +    int main(void) {
> +      return brlapi__openConnection(NULL, NULL, NULL) == BRLAPI_INVALID_FILE_DESCRIPTOR;
> +    }''', dependencies: brlapi)
>       brlapi = not_found
>       if get_option('brlapi').enabled()
>         error('could not link brlapi')

Looks good,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

