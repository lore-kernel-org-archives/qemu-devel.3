Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0F1C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRR7-0000Da-K2; Wed, 12 Mar 2025 15:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRR2-00005f-Rw
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:08:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRR1-0008H5-7E
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:08:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912c09bea5so146368f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741806484; x=1742411284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J07MozC0HSvPwgVpGRaOACOG4XsfBkgf+XmXoNJE1Dk=;
 b=SmTY+WsTzb2k2ZwjOG94pUoDJOMNFAqC0Y1oFhwvEwkW21yQo88x6LMwcuJMPeIG2u
 aevfC0I4BR1NunT9cazpYYPOStVIsUqR3kV3ilmIwuMzzoZ+vnDdJRFoo+Wdhh0qtkvG
 MtegrL0YHmuJLPZ/VSFwJw2HjMZ1ZO4oTa6R17WOeGdf04r5rSqT6ZSbeaFIlA/zyUDV
 gJkgFoFnuaxDLTdx2o00sffE9keNaj7/IXTzwo92+pr8wk8Q1KZAax6oiB5gn0WPKprC
 RnGqfymjKKRoWo1nHQGHkcagrCEFIEWL9M3fsI3iZi5+K9emtzCerZAODKsWHRMsKsKt
 Bw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741806484; x=1742411284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J07MozC0HSvPwgVpGRaOACOG4XsfBkgf+XmXoNJE1Dk=;
 b=AhlsBMi6NIcbjnk7wIn5fJAZmjxDf0BdDKvDBQBghkAPN+d+Y6pNgi2ePftEAef/3j
 26AtJmjvBGRefilLFRr1uVhMBnKBcTg3j/zh9hPOHXGKHdIJhzMJQfgsgFZkqxn54IRx
 Z3QqSJFZevbXzR8vOdYkiO3TyJOHrJSYcoW0MiycbZCuuXhoY8l03ZcRDYRyMC1PF98l
 MR3jWdSA9JLJ2vSas8zReeLmnyvmrOzRGqG9gPoxGw2z+68wA2ay3KFDUC8GEh2PBkhd
 tXhX/mydZKvFD6RVefjwc57MmlGQ2Kr1FXx95IxgKg8iodgL0y835Y53LvriZicmX63p
 UEug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLUyDW62/Eu0vxFNvbeDXfdOUjHpH7YxjT+SPyZzy3wcN6KxqxPDmAdQxE59MA2TZoyuJXT/7+qioQ@nongnu.org
X-Gm-Message-State: AOJu0Yx6ZMNqOPEfu8hVsayUg672ZkMqdDvgidhgnch4P+mOgYPWUD+8
 UbNkJH8OENlfaIacXgdGl9ZWhm4o1gGZs07qWbFH59yIi+ZtAfqvHFG2RqUr5ys=
X-Gm-Gg: ASbGnctXb8UxEwDuluE+w3HgpkpobPWPi1yikkYuxwM4r6fbkwkRfuf9SFN+gCz4ws9
 vxXgbiSQVC956L0str0qiIux4AIMiyaBrLoZghlFgc2wURh3K5PdneLenrOkZvj2UWQJKZCSwDb
 3QOjF8VFUHMz13qbul7ThAeH9MclMQK0fzf+MSbXL/ct3QNjw1naTeni8NBx2raByMExbGwFAYW
 HItbkW98Gc0kJNjMySLM0MU9Ger3MOlK4oyFSyu9Hf8aAcXgBZ5clF6b067CCTMlLwUqx/CASMe
 sJeQ6lkcijR8ISO4kNlHVTPXVr8VYJTdz7FjtSpqI/W7BZnw/Ac6kkWxNxsuL9dXHIHGwXibCAW
 Lt+eGpDTjOr4z6mU=
X-Google-Smtp-Source: AGHT+IFxD6C+AF8db4UNMTIAhLtAV8cjaVSE1ib1Gr5cwI2qhgTi4zUFOfaLEQLo8OhP+rmVrw1P2g==
X-Received: by 2002:a05:6000:178c:b0:391:3768:f448 with SMTP id
 ffacd0b85a97d-3926c5a51cemr8181076f8f.49.1741806484578; 
 Wed, 12 Mar 2025 12:08:04 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcb8sm22251183f8f.33.2025.03.12.12.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 12:08:04 -0700 (PDT)
Message-ID: <8b67e2ee-4e11-45c7-8301-221dd92114b7@linaro.org>
Date: Wed, 12 Mar 2025 20:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] error: Strip trailing '\n' from an error string argument
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, vladislav.yaroshchuk@jetbrains.com
References: <20250312143504.1659061-1-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250312143504.1659061-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 12/3/25 15:35, Markus Armbruster wrote:
> Tracked down with scripts/coccinelle/err-bad-newline.cocci.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   net/vmnet-common.m | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


