Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE377C4450F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkc3I-0002XJ-1N; Fri, 17 Jul 2026 02:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkc3F-0002X5-Dj
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkc3C-0003WI-0r
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784269676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4mfscv55YpDSJTnI1EZ8eNaVomgfGB2KfRF+1SDGOvY=;
 b=L5H3R6H4Q4gi8ULj4SAubKKuzFwy4v8sbH85ipuG8h+7vg5xXvhVC8S9CLwnhSDEOfmsir
 rme+RN29KDtTN8J1WwXSoT4F8BeRXcIxxKRwqV3gtRtOUA7nw1jQDYotndYw5P0kz8JxjR
 OwhMKIHlTfFOnoxmpb0rXmVyVVwSyws=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-kDEng0IUNiOvpYuLUwMLpQ-1; Fri, 17 Jul 2026 02:27:54 -0400
X-MC-Unique: kDEng0IUNiOvpYuLUwMLpQ-1
X-Mimecast-MFC-AGG-ID: kDEng0IUNiOvpYuLUwMLpQ_1784269673
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so6373285f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784269673; x=1784874473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4mfscv55YpDSJTnI1EZ8eNaVomgfGB2KfRF+1SDGOvY=;
 b=TLWdZHuNM9abTnbjzUOZaRHy7cbPMUQdWEPGY+qS11ciIDEixHRIC8+oX7MpJyGdu/
 w5ygdwD/8gxGEeeR+2PGOY1yQMsyZ5gZjLCDISFUC8KSgUXgJJ2SVdwZUNcmz4np3YGi
 eA2E8DYiowruiU+pa4wuJbZFNBGJlJzUfAwERc3puvk/4dXW1PGwx3j/GaTr9XdLASKB
 pN8FH6TAJNoHLM5kCmulaKnCUxd60OFeoELaXk7xNglzYdTLXLHrXwNGs0oVCK40NFzh
 b/3GKufrXLvD0/KC9h7rQwc1ZtjpeYKafaVzh1R0kK1zBsHHS+D5RQcXCxDp50lKpGx8
 6ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784269673; x=1784874473;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4mfscv55YpDSJTnI1EZ8eNaVomgfGB2KfRF+1SDGOvY=;
 b=GIUmPx1svaKBEH3zydHJJwUQz2PQyFujkMuqfAwZHx0RsiQQYaBU7Kzm9/tSECPcOf
 WGgBWqadq2EdvThA1n+QXczsU57vBczS/Ka/rBCtQ0x44W8sVtPGpnixqLRMNtOMR215
 38O1/Nc03+19odnE5GO/czUiW0EZnV5tW23WCgnMlxynheP8y2iK0kxmCb/ajRG5FNe0
 vkxBz7P8DBVD/uznBHj0HT7Fdipz2gLZIKkdgkzL0Xu0OPL2dbR2eYY7o5ozvjLwNcys
 V9OiHpubs/ZVzkB7yj5xd4xUwHMdurAUIkIAzY6ZHif+K2DNTiIJenr9K8sq5e/Jt7WY
 e9nA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3UFKl6nIagiOH5/4jT8jL2uAXwikBt0xi9YiWyxBCe2FNcF521XUwVJyy0ld5ZaeUPOkXO8rSj5a1@nongnu.org
X-Gm-Message-State: AOJu0Ywqw5rxTopXDCHmH2ELrCrCe+XtFrLUoSltEF5rouWCboTIjGVY
 M4APUg4Yl33qeRAcKDO6gaSfhPLQ+nO/LtPZewFHgCB2HKDOHg+XtEYj8qICyDgWEsS3Dk+z7Tk
 MXMLx+PDN+7qQhsQ+Umcos8Z4L4AySrVnW5NndBhZfOuZKtV0g1wkmMu7
X-Gm-Gg: AfdE7cm6Kjk+qsyGqVdO0p3HJ5gZ0xrDIcd2dtMcVvxT8OIWHzZAAyn1RHCO+DTMOHz
 5peNW2uo9sy8Uj6DGidOrJnFh6H1wCerhob6D1BZRfkzKM+FFOJ0byKyatfhyqZkiYa4aIRNeIl
 GjgnTY6eX1SmwQADVa1qWXkbstC0EPd1GwKIQQUdfY0bb9batPHRwn4lXLgnZjDiG2rkfJLd/lO
 bzmmcc+FOWoTj4ri4U+uD8bMc2jfyesrWSTRfNkHBfwp4yWHQapdbYkKyVxMipizm2OCo8UUOmp
 CaNnzD5bUvYChBudzlDoi70ZqTasZjiciKaSQRK8ztJ9IxcasJ7F3hOW8AB8eVwIEfw895vwbQ=
 =
X-Received: by 2002:a05:6000:2906:b0:475:f0c2:75ab with SMTP id
 ffacd0b85a97d-47f62346b9bmr1530209f8f.60.1784269673466; 
 Thu, 16 Jul 2026 23:27:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2906:b0:475:f0c2:75ab with SMTP id
 ffacd0b85a97d-47f62346b9bmr1530185f8f.60.1784269673023; 
 Thu, 16 Jul 2026 23:27:53 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcf8dsm1291642f8f.27.2026.07.16.23.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 23:27:52 -0700 (PDT)
Message-ID: <7a059e40-0c37-43f5-b6d1-51d8f4b30ff8@redhat.com>
Date: Fri, 17 Jul 2026 08:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: build hexagon-softmmu to enable functional test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260717041916.3949105-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260717041916.3949105-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 17/07/2026 06.19, Brian Cain wrote:
> Add hexagon-softmmu to build-system-debian's target list so that the
> existing functional-system-debian job picks up hexagon functional
> test.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index e2553e7326f..831d9a26742 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -70,8 +70,8 @@ build-system-debian:
>     variables:
>       IMAGE: debian
>       CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
> -    TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4eb-softmmu
> -      sparc-softmmu xtensa-softmmu
> +    TARGETS: arm-softmmu hexagon-softmmu i386-softmmu riscv64-softmmu
> +      sh4eb-softmmu sparc-softmmu xtensa-softmmu
>       MAKE_CHECK_ARGS: check-build
Reviewed-by: Thomas Huth <thuth@redhat.com>


