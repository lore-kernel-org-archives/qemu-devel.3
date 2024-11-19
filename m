Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B190D591A5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRib-0003QM-Py; Tue, 19 Nov 2024 12:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDRia-0003Q3-84
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:08:48 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDRiY-0000ZE-Rs
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:08:48 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa20944ce8cso1017199266b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732036124; x=1732640924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UFP5FAdUDeZzepfTiBkyXn3t4a1Mu/xz6rvilz3UgJw=;
 b=gUsn4JQE/iiuiYK5W1JCd4NKpbhd2gykpqkwyzLeXzamwGAbRNgYRdvNoKPRuG8Gzf
 yCs/0UfOiT3xaswGRATIIm6c+HO4TUNth/t8mDdforH2oJKBdhBFV0zWu513Xwusaeea
 4oqmXVKX1N7wm+AMzlM+ArVY6uaUyPFMZeNLx/tWxK3OVUrx5HepEjAFmwcxb3FgYEVV
 xEwBffph+pRLeOyqyHXk6EtqvNtk9OkR9z7jJ6QBSOriP8ePI/spripmJ5VrITxxQnRx
 gyc2BDNLqbNLsuG9nFxPpitIbhGTGVfcZ+h9Vo8pVi++jAaQA22FXV5BgHVUyawT4K/D
 eplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732036124; x=1732640924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFP5FAdUDeZzepfTiBkyXn3t4a1Mu/xz6rvilz3UgJw=;
 b=NsCRXzoUb2nq6drMtaVb0PcCtcb/ABVVoYftJjlaO5kkMrSiRZ7zyaUqEaq2tmbApU
 23o0O0YwpJtm5rXnQLDoUATADYGupe8K5JZZEBCtNFag82xRvjrTyeFJhUVBsqrF0h0i
 +2cC39fD5ggdUBwJjKsl4DiOSxnE0u4n29/SwG1HuCJQs48QfBJVBDG3UWoTV+7niAe2
 ns39SYXGSgPhGgu5QASd6doUcOroSEWP2jluWV6lkUjENzoeAlLY3mFFD+1tGKxXzn5R
 vSrfDNLVb0UUbDthORqgtOf3mctK2HZbHq911B3r+VtqHKCcuJ6iPpDdSHRiAt5U5Y01
 QpeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVi6m8czThNhnOHuEQl6czXC+xRn/sGw9AkO2uSvy59UD4cOwWmPjIcxq+4sBM9UMArtujF7zSNgdy@nongnu.org
X-Gm-Message-State: AOJu0YyTtbioaTkXIcalyJt+e5OXCZH7o5CfaQZaxQW4i6Xp4sFc+Zsk
 1DtNAJ6y+G86Sd/MTm8fNwtYi3L3lmdugHov1LuLGGbWbWYtFZadL5zr1g49wW0=
X-Google-Smtp-Source: AGHT+IG7DwQQVyg5Pb+QzmDsJ8H6pJjzAJrPmphSqs2fpYUpNTn8dm1jxCDde32Wk1Kr8P9PPsJRVQ==
X-Received: by 2002:a17:907:e25c:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa4c7dff462mr372842266b.2.1732036123748; 
 Tue, 19 Nov 2024 09:08:43 -0800 (PST)
Received: from [192.168.69.197] (sto95-h01-176-184-18-155.dsl.sta.abo.bbox.fr.
 [176.184.18.155]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e045143sm673191066b.136.2024.11.19.09.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 09:08:43 -0800 (PST)
Message-ID: <092e853c-15e5-4003-9a48-ee3ac9200598@linaro.org>
Date: Tue, 19 Nov 2024 18:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] tests/functional: fix mips64el test to honour
 workdir
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241119150519.1123365-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 19/11/24 16:05, Daniel P. Berrangé wrote:
> The missing directory separator resulted in the kernel file being
> created 1 level higher than expected.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_mips64el_malta.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
> index 6c6355b131..24ebcdb9c1 100755
> --- a/tests/functional/test_mips64el_malta.py
> +++ b/tests/functional/test_mips64el_malta.py
> @@ -129,7 +129,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
>           screendump_path = os.path.join(self.workdir, 'screendump.pbm')
>   
>           kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
> -        kernel_path = self.workdir + "vmlinux"
> +        kernel_path = self.workdir + "/vmlinux"

Safer is to use os.path.join(), anyway:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           gzip_uncompress(kernel_path_gz, kernel_path)
>   
>           tuxlogo_path = self.ASSET_TUXLOGO.fetch()


