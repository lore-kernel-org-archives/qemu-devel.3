Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C81CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ilg-0007Ou-2z; Thu, 25 Sep 2025 06:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ila-0007NF-Sl
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:59:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ilR-0004tB-Ed
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:59:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso1952025e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758794384; x=1759399184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DSMsVMSuVqbn0MVrXiTsee7P2G2jv2y3uJhG18/ISak=;
 b=Lb4Wwqce4ZK0YFJMs+YvrMwQzRU1sg/x9cU9GD/lqqUYC8vE/VU/Ogran9agDdOKbY
 2PToaBAO+jzN6DiWo0p+QeGwJGJ+yualAz900lh759avknNIC/fx/MpT7FpWZhFa9FQ4
 Cm9WvXPiyjJK5TuCJ6YYRjWw7T1WB3lWelS6aLH+9sR0kyZz7zgDD3kfIzJ9Fohrh6Fp
 Ge00qsN0Q+tUPeN8RO18t8Jp80ppX7qdejZm+KM0kcpizBOUgvV2Kt0VvXC+KPYAYikj
 lcmo1ri6BZJjNUSJZOThTKHtVCxYue3qmNc3gSiA9AH7kHv+7khg3E8T2ivPpGVx4ixp
 nUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758794384; x=1759399184;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DSMsVMSuVqbn0MVrXiTsee7P2G2jv2y3uJhG18/ISak=;
 b=pqKRc9G7RqBdKGaMhJAOyP5KLpcIzyL70y+ilvUFyobzAGwRh6qOAcwEZfE4V60J/d
 PGq/K0KqpE7EWwAUkXVcpHFwRMzfnxkU63lvKqcgSVwhNzBCNNIQT9tsZL78SBxwL96/
 ZIZmNwq7iAkfGDODCV7QbgrkYCS/QcI1RvtKmJJZt8oNJl1+nIA/z6mCUbl0LETiQaMK
 YeZJmm9PFse4zFxQiYxD7fEHRQdkfT5wfnUr9ZLmhCk2q9naJXsqobF4f+ql1cMplA0p
 ERZPOwfCWtLm9hc2HthyOOjxBIO4jGSdleHLA8wXzpHALVgGzBTGpYpcbrgCXLftdZqN
 Irmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRNt13F9MFadLi3w95fmtz8fE9jO+Et0vxsG9Sx13vdNZMRpUSEjoisstHiSPJdji2xzN5bNLv3wGZ@nongnu.org
X-Gm-Message-State: AOJu0Yy1qU7Fi9hCh+95nn4wAoEgr7NBx/Y0ZBfYaPQpVMVGjYaiZ3pP
 4JHeUgt34Xw7Wyewovv5OzOWD3NBMA4PtI0N/VPsdJ5JBKfi1Xkav8tF1NuesDowQtU=
X-Gm-Gg: ASbGncv5WXTPp+K3DuXNy1Um4CiYhEc26N7ETyv1HSxzX6vbOzhgQ9F4Xoda3n3Kf2t
 UkBSUMgmeCRHidbkAkSk7CFrQgpvR2eAme0I/R/FaQ85CIeGTRzJUCN/B3qwW2G3u4xxvJilfMu
 zTLEdvCKgDGPrjyJXjMH8tI7JR1flaQO21YVOxfD/e8450VTfqPGb/Z/ru9Sea5UjLdyQujjcoR
 IybEco5mnSHmtg2C06C8aAoFaY8ajnUT1iYost1fBU0gXdJ/IecATuzwxALNy/XXAOzGNU9ctc3
 4od3hjmbx5mbzBLz/F80bIE+CPdGEWFjqrxcjCHNrYmrEvGENjgRcA+GEpDde7BF8SHhuq6ySAl
 aeqA9lLj4ykzO18BT3RYTj3D5H1Dvyt/FG248IDV/ANPmHuAflb7JycDC5a+seEkxIA==
X-Google-Smtp-Source: AGHT+IH1fmptLdpN6+SFnC5ISCzo/kvMgH0aTDECMRiCWqvwBstPBDAx8qOaO3T54VjK0NqE8AeHwg==
X-Received: by 2002:a05:600c:a01:b0:45b:7ce0:fb98 with SMTP id
 5b1f17b1804b1-46e3299ed75mr34499555e9.5.1758794384473; 
 Thu, 25 Sep 2025 02:59:44 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab6a514sm69360255e9.22.2025.09.25.02.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 02:59:43 -0700 (PDT)
Message-ID: <fd1243ee-a480-4653-9650-4df383c5af3b@linaro.org>
Date: Thu, 25 Sep 2025 11:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/23] util: add support for formatting a workload name
 in messages
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-21-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925094441.1651372-21-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/9/25 11:44, Daniel P. Berrangé wrote:
> The error_report function can include the guest name in any
> messages it prints. The qemu_log function has no equivalent
> behaviour.
> 
> This introduces support for a "workload name" in the new
> messages API, which in the case of system emulators will
> be the guest name. The possibility of defining a workload
> name for other binaries is left as an exercise for the
> future.
> 
> This change has no impact on the output of the error_report
> function, but will change the qemu_log function. This can
> be easily seen with the 'log' trace backend, and how it is
> now more closely matching error_report output.
> 
> Before:
> 
>    # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>    qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>    blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>    # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    blah qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
>    blah qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
>    blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/error-report.h |  3 ---
>   include/qemu/message.h      | 10 ++++++++++
>   system/vl.c                 |  6 ++++--
>   util/error-report.c         |  7 -------
>   util/message.c              | 11 +++++++++++
>   5 files changed, 25 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


