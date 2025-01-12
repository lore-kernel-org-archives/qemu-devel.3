Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB1BE7719C
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 17:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX1pD-0007uF-JC; Sun, 12 Jan 2025 12:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX1p2-0007tj-NL
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:32:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX1p0-0000Sx-O5
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:32:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso25381765e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736703140; x=1737307940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1UVOydxaBftTDJA9IS2xai9YhUYwPPnbCWE3Z0cGEos=;
 b=mwdMb+5cvvRlk7sfByOtKkS5DgMoxxPSK2I52vgqNv6Jwk0rLOsEehwQv/3vyfa6UO
 oQDf7I3+TFhxJ69yWZp/9vlEtErj06IvqOtBTX0u16htjp2eIMue6LrhN2pn5LTrPpgR
 VHsptFBPkoyFHmYurcAhQKDnokJn0DO6m/+iA5hU4mHNqkXWj8Ak68A3IwU+65P6sHhm
 LT5voxc/BvjpZv4lyjBH4b5qDI00ta67+5mjmbc+WN0Y31luk+QDy3Ze0GAXGKhLcbKJ
 R+3EFpGZRPJKZV/wMjVdqKTKD1QnDeX1cj0ZI6wQGvXJv8C58bV7Y63r2DttGI/jSdaY
 h72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736703140; x=1737307940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1UVOydxaBftTDJA9IS2xai9YhUYwPPnbCWE3Z0cGEos=;
 b=s4CRAKHC1LOjpJ2Lb8ZnDB9Wb883sW9JlDuQJricSRUT9yG+2AYmDSF1vaRWbfE1ck
 AO0KUGZp4kJtdQ0comrsMtRoQsR+3+PrDqm6Qj6l8/fysyikCrUyzeZw5bMloPoW7uxX
 wM6JB0wPmXwEAspn3OSFJxdsfRh9c6Xspd4L+BeLPnVsJK7nOhmGuFADzN5rrPNzZxit
 frj8W85if1srrAR4alv3wn0ecpY9BVyBt6975JBaC8eLlUK+pQhKcCN8cE1O0spxCJ9P
 R99tjPn1BwMUSxbdB4zOMyzukt2aaI6L0un3mlxCsYbwt9L+vs2ZuOXcW2Js1T+UbDY5
 pRQg==
X-Gm-Message-State: AOJu0Yy8090J9hSwudnS0D+n5PedCrLQRSvSOD/I/2IMKgHS5QuRUH0i
 AZx7JyusaThX9mMYNLyytR8wDwIwCqFHHQV0A0fkt9dQaf7c4vUU/ZPkk9AvmxY=
X-Gm-Gg: ASbGnctG+EmHsTaNdE+Q/T98mUH1jFZYOAdCKheO9gtUxBP+VBY6TyLOKOM2+m8pAEQ
 /3b1LnS2jxt1ZG/yMDI5br/gSRcTqecFHQPsRWuSYPDCLZt/MLU4BBJA3xO0DN9iDTo56XfE5/q
 I/90GS4MoD7c4/cbiV4U8vtvuYE+19A+csLBJ6EU8SyMgXqnP7e5qzGMdrBlElo/90Q9BweBoxR
 4/DS2B0YJ723ogdKkol1GaXOJxe51+iczXEz9lPTnnaRnTRtoBG1VjK49SM1lE0oZJFGVPf2A2e
 Y8QTTfmquVarEjhmniShJGi9
X-Google-Smtp-Source: AGHT+IHFUTM6Id7P83aAS9QsAOgf/6TcYIGBszhhu24Fer1eQ2bzoQTEREuq0Fh997gB7OtcN0QBiQ==
X-Received: by 2002:a5d:6d87:0:b0:385:ef2f:92ad with SMTP id
 ffacd0b85a97d-38a872f7f80mr15690677f8f.10.1736703140233; 
 Sun, 12 Jan 2025 09:32:20 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383dedsm10266969f8f.35.2025.01.12.09.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 09:32:19 -0800 (PST)
Message-ID: <dd12a227-0990-42b7-b241-301bca90915c@linaro.org>
Date: Sun, 12 Jan 2025 18:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/nsis.py: Run dependency check for each DLL file
 only once
To: Stefan Weil <sw@weilnetz.de>, Bin Meng <bin.meng@windriver.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250111215244.1680931-1-sw@weilnetz.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250111215244.1680931-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 11/1/25 22:52, Stefan Weil via wrote:
> Each DLL should only be checked once for dependencies, but
> several hundred (781 in my test) unneeded checks were done.
> 
> Now the script is significantly faster (16 s in my build).
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   scripts/nsis.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/nsis.py b/scripts/nsis.py
> index d0914c88a7..d0ac61f6ab 100644
> --- a/scripts/nsis.py
> +++ b/scripts/nsis.py
> @@ -37,10 +37,10 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
>   
>           analyzed_deps.add(dep)
>           # locate the dll dependencies recursively
> -        rdeps = find_deps(dll, search_path, analyzed_deps)
> +        analyzed_deps, rdeps = find_deps(dll, search_path, analyzed_deps)
>           deps.extend(rdeps)
>   
> -    return deps
> +    return analyzed_deps, deps
>   
>   def main():
>       parser = argparse.ArgumentParser(description="QEMU NSIS build helper.")
> @@ -92,18 +92,18 @@ def main():
>           dlldir = os.path.join(destdir + prefix, "dll")
>           os.mkdir(dlldir)
>   
> +        analyzed_deps = set()
>           for exe in glob.glob(os.path.join(destdir + prefix, "*.exe")):
>               signcode(exe)
>   
>               # find all dll dependencies
> -            deps = set(find_deps(exe, search_path, set()))
> +            analyzed_deps, deps = find_deps(exe, search_path, analyzed_deps)
> +            deps = set(deps)
>               deps.remove(exe)
>   
>               # copy all dlls to the DLLDIR
>               for dep in deps:
>                   dllfile = os.path.join(dlldir, os.path.basename(dep))
> -                if (os.path.exists(dllfile)):
> -                    continue
>                   print("Copying '%s' to '%s'" % (dep, dllfile))
>                   shutil.copy(dep, dllfile)
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


