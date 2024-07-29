Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2C9C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYROl-0006BH-GK; Mon, 29 Jul 2024 10:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYROi-00061i-Qn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:30:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYROg-00067y-Mb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:30:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42819654737so12072305e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722263444; x=1722868244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rY2n23et44aB7qdptSjbeajeR1qrqGD0x+7g7kYGakM=;
 b=u6Z4a1Zw8Tltq60sbjry6OupnTdOUKqPFUGuGW/dWHue7BDyBFQbip10iWRoPtjJvE
 WlQ5p0MhKHW87fLj9cWXaXhil674MdaK7AZ7Z5oNz48q0ORqFQNcRzTYjE1psCSlPEUv
 YgPNIHOwgpnsr2bm4gI7xcCAF6JNB1h4wvRDGRinhGeyFPvOn88nqcXzja/orDfWRbkX
 ogW4mqFk+82Pym9zQ4cuPjXWgQmiwVssVWztZ9wuat6zWL/WcMh73YjYcT7q65r3KKg1
 Bd5kZNQPe943Zua5U6gCWXvpWwyCzgVHqr1CATJDlbV/QtYCnUGUcELcy+YlDFy/YD/e
 NpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722263444; x=1722868244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rY2n23et44aB7qdptSjbeajeR1qrqGD0x+7g7kYGakM=;
 b=Ns0Ko0WH87IVNPgei0P+uE1+HmqFycCZwZtqDXC/8qZ/xDo4IdMdgBentTIqJtSDIN
 WrTjTy9K8UNV5WWka1xf4N/2Ttre+0zDMRRFxXKdBe+G3Ebnz5PjeWeD6z+BJIt5NCUJ
 He6bdFuI9ScNFCcPHYQ+Z2dy9MMZm9Y6tIJ3BB+fAEcjWOwIb2QTnsgqQC8Lp0VY9LIG
 q2jkudA7XVB2sJMHxzWW1DdTKW+1FrWWEJjBlX0iosDq/6s76rAddzzyfXcmdtGh7TXB
 I44ApWWCyZGDAmmBoJS3u/0bJrWKyiwSgnE5Tqs4MXVnF/97bNViKPelHqVig6Eznz5u
 a5qA==
X-Gm-Message-State: AOJu0YxsV461T2G9B0ydCz7JKS8NiFIk5dEO6Hpj38I6DA/dptPQHNxX
 RzR9L3huOs+Lg8+AudUCuWiGGbyrGbIKdO4PIVKMxy4u7sjSluqBEEa3MFIkV98=
X-Google-Smtp-Source: AGHT+IGq0fSVAwHv4OaK4OWs7Vywf6SlOWHyK6+AwAZf0EkIVNcIOlCk94dUeRggFzL4H5+PgzKFcA==
X-Received: by 2002:a5d:5305:0:b0:360:9cf4:58ce with SMTP id
 ffacd0b85a97d-36b5d08be6emr5432284f8f.46.1722263444476; 
 Mon, 29 Jul 2024 07:30:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm12355366f8f.106.2024.07.29.07.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 07:30:44 -0700 (PDT)
Message-ID: <3de32a83-ef85-495c-bb0c-553e3e798692@linaro.org>
Date: Mon, 29 Jul 2024 16:30:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] docs: add test for firmware.json QAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240724-qapi-firmware-json-v7-1-12341f7e362d@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724-qapi-firmware-json-v7-1-12341f7e362d@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/7/24 14:45, Thomas Weißschuh wrote:
> To make sure that the QAPI description stays valid, add a testcase.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> docs/interop/firmware.json is currently not usable with qapi-gen.py due
> to various non-functional issues.
> Fix those issue to provide compatibility.
> ---
> Changes in v7:
> - Drop already applied patches
> - Remove "test_env" from docs/meson.build
> - Remove explicit "python" invocation from docs/meson.build
> - Validate patch through Gitlab CI
> - Remove Hanna and Kevin from Cc again
> - Link to v6: https://lore.kernel.org/r/20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de
> 
> Changes in v6:
> - Style cleanups
> - Improve the comment for qcow2
> - Document the new enums as Since: 3.0 (7.1 for the loongarch64 arch)
> - Link to v5: https://lore.kernel.org/r/20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de
> 
> Changes in v5:
> - Add Reviewed-by from Daniel
> - Add patch to drop Example section
> - Link to v4: https://lore.kernel.org/r/20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de
> 
> Changes in v4:
> - Update "since" to 9.1
> - Add comment to 'member-name-exceptions'
> - Document enum members and drop 'documentation-exceptions'
> - Link to v3: https://lore.kernel.org/r/20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de
> 
> Changes in v3:
> - Drop already picked up patches
> - Drop include of pragma.json
> - Introduce new enums FirmwareFormat and FirmwareArchitecture
> - Link to v2: https://lore.kernel.org/r/20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de
> 
> Changes in v2:
> - Add review tag from Philippe
> - Add Fixes tag (Philippe)
> - Add testcase (Philippe)
> - Link to v1: https://lore.kernel.org/r/20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de
> ---
>   docs/meson.build | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/meson.build b/docs/meson.build
> index 9040f860ae1a..322452c87787 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -99,3 +99,8 @@ if build_docs
>     alias_target('html', sphinxdocs)
>     alias_target('man', sphinxmans)
>   endif
> +
> +test('QAPI firmware.json regression tests', qapi_gen,
> +     args: ['-o', meson.current_build_dir() / 'qapi',
> +            meson.current_source_dir() / 'interop/firmware.json'],
> +     suite: ['qapi-schema', 'qapi-interop'])
> 
> ---

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

