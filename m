Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFE0C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7e7z-00066Y-Rg; Fri, 18 Sep 2026 15:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7e7s-00065R-DV
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:20:01 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7e7q-00050Q-8Z
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:20:00 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ed9866so10210815ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789759197; x=1790363997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZN39TrEZ6/K7wx2nY54LaprGUSsNhTtCk04bkv8LAFQ=;
 b=ojpFt+mipDvMJZ30zGLfhsG7QUqKoAzT1YM79gL5bBJyMxe5WqUk1QlUGN1imzpeQ1
 om5OPwPpWBe1StflnKpU81/vHLkOc565AlwMTW+Ko+Wmtbz6ImFiou0E/aQVGvDB37MJ
 Q3z/woE60r11AV38tCTxTVNcEvj1arHZwqXu8irnf89TFdvVnm0M80jGfrMMwMJtvAu8
 WJ48gIA5sBVFaZwr87+rlayCH1bhrzJfM0ACC++NGzBQmIMyq33Si7xdscKphPERmnCp
 RUuRkM/IPRggwOLMZWYtnYE5rV/aOStd2VOEMevGw0IJR+vE52jvHD3UboXdB9FUUDuf
 96lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759197; x=1790363997;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZN39TrEZ6/K7wx2nY54LaprGUSsNhTtCk04bkv8LAFQ=;
 b=d+0bD0JkKcnnXUuMyPweB1ASbzHJz3/8mJd7e85MpK3N/t7ZilUKJm1wFIwD7R3h9O
 +fU+XzVOfMttBexZAbme1N9foTFObzf9fQueRwlWIghRFqWNYv7fqRJu3E+I+DrWNYWb
 DuP0kktg06qsmk+YupUSTPDDTWpd558HkgCauWNhixRTG9n+xW6ZqSscHlII+a3jAzWM
 ZNHa0Flp8MmgYz73e7Gh7TfZwgNtTgYbej3gN90uJO735BfTrStVxPUZq2n6vkg5cRJ6
 AI9tRYu34vFsY5aoZwbnoQn7lyHK3yTdOPIUrxG0I/VqDRZGH29fJmeXDinjPL5SgmoH
 YAPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp8CAUzVVjfraMNvaTsoiURmkb1lamApoKbisT/GI69Ms+Si7nMFlDtGYkV50tGq9qgtBr69U7F5Tr@nongnu.org
X-Gm-Message-State: AFuF++mdvXJbFfvldOAgNjrshktTUeZOmaY9JO73FSn8A5T4GLA0f9X3
 HWzpe37nMzuy7BEto9TcpRTo9+CNkoUn5ECR7A0IqL76p+KxOsmXI+ZIupSE0Yp6iZQ=
X-Gm-Gg: AYBFou3dyfKrB9V9YwK+X7J1yngWPKzMQvTCJy2ltlwzGkSOQthjImCbPD2vXSXQm59
 qJ369cjUvusrsnkjcTKEO3r5J8XJtCIo+Zt0Fe3u+mEJJhVTkfl2yjaFNsYrEFqd9hBNOkOZHUC
 IQXIRzAfDIi7riXgUnKRKv6hYHScycIxNweQs9+D1fmZcLGKGu2z53BeyliAb+JKTlbjl+Hh0ir
 Up0GLK5oDZBkQvEkIrvpRikUtoSuCpzteBVWObl+TO/+MctGouKV7bkpM5piu5FD5vfvsH77cdf
 O/8bd79JN3b4vAKpJtyXjFCg9MDv+hmv9KZCP74V0aQC2Od5Kja6amj5VgIf+VyAcf+/ABmYLbg
 sMt9eslFwJv1QEwwghhLZ7PXpx5vs/kqVpxx+MQ4vEUPfpFrXAIBO/zdUzxz7vFWwC8pL8ra+qh
 wz8iKEc8KCQnJIX+pwdjuNbaUCaJklOgB4adPzRP+9xkuggTKuhxtrKoogwZ3mDGmfMgeKuWdie
 +A1DOXuGMM1086BEwsjVhkZmBdfuM7XrvmT/OprYXXcnuGjrF9WkFWkJNPOnj80yePStrPI
X-Received: by 2002:a17:903:2349:b0:2dd:c100:a5de with SMTP id
 d9443c01a7336-2ddc100a706mr8363315ad.50.1789759196704; 
 Fri, 18 Sep 2026 12:19:56 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:317e:3514:d7db:974c?
 ([2603:800c:7900:ed00:317e:3514:d7db:974c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c342b3c67sm369413eec.10.2026.09.18.12.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 12:19:56 -0700 (PDT)
Message-ID: <590a4134-dea2-418c-8613-4209369828f7@linaro.org>
Date: Fri, 18 Sep 2026 09:19:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] Misc 2026q2 v4 patches
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/17/26 18:23, Warner Losh wrote:
> The following changes since commit 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7:
> 
>    Merge tag 'pull-ufs-20260918' ofhttps://gitlab.com/jeuk20.kim/qemu into staging (2026-09-17 15:18:09 -1000)
> 
> are available in the Git repository at:
> 
>    git@gitlab.com:bsdimp/qemu-from-official.git tags/misc-2026q2-v4-pull-request
> 
> for you to fetch changes up to 1f71ada86d7ad43c7241a6ae96912139ec3a6a7e:
> 
>    bsd-user Update random_seed on thread creation (2026-09-17 22:07:42 -0600)
> 
> ----------------------------------------------------------------
> bsd-user: Upstream most of the remaining system calls

Applied, thanks.

r~

