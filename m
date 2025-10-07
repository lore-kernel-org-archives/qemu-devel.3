Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D680ACCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 19:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6D8a-000700-25; Tue, 07 Oct 2025 15:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6D8X-0006zk-Ra
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:14:13 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6D8W-0007UF-5q
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 15:14:13 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-330631e534eso7266734a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759864449; x=1760469249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ErslzeFBJa6jktWMgwGm25LO4H6am+R6a27+e+h+51w=;
 b=YvmN2cor+0RSkfF9qQYZPpfGI2lQSSkKXDT5o1TyZs4kLSavbamB4r+XgBISCXN1/U
 FLmsRwLOaogMPvA7k2dTzf8WOhTC2plYQhIf7AmA07WmGU9qPUUGrHsZwuClqmVX3h9r
 d1QgJTkBQUxc0R2Y3NOu342S7KJz550WGHiFq11PgNbdYfvvI8KBkCH4Gg8G6hWmovvc
 sYYAob8aH1F5NN5sgU1KgE/J59qwmB+Y8yiRvCusiovca2ahOjuqWWJOCYXiSn114uCp
 bonQ3XuHmVdmm6JT4B6/8jllc5Dn0NUAiccjFLG5+hdMiwRL65zYhGZYz/JQopdxIjjL
 byBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759864449; x=1760469249;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ErslzeFBJa6jktWMgwGm25LO4H6am+R6a27+e+h+51w=;
 b=M2BFrobI8ipOGH69tR9+hA0khue7JCyMOYmkgar5TBW0xhh49d5rqpBVvmio95TMvJ
 Wj5TWA82cYmm8V94XzMFKQKz6HEyHR/sITiP8W32xE6EKPsZO8PjRHrQBmJzpW+aL3DK
 XEWWIfCn7iqE5LRvRiXu3J+qNR6ejdNUmz4yruTPUNnBJAfLNJn+x1acEPKVlf8nBKWW
 oinebLoXcYhYudbahupfCD7MgiFe+sY8syAsEcp6h0cmrPxb1f0e176aLSAco0gcoWt2
 zfC0L7A4UPn8B3y70ST5ExPFNXTEQ965CdpCtplAj6D+Q2fruIBh9uq49GVxsqMyhjkZ
 ghDw==
X-Gm-Message-State: AOJu0YxbQtbpNKqTcem2pyCMA3Qwup6SrBen+XOcFK4BWFr1u8JTYiw4
 P4I9NcebQDXJjWwKRVXDtFMIrjhe60UekmRLNGOiJ+kbOGvUYz6xlMyIEoThQC/EcyohBnvh0YD
 aREfsriY=
X-Gm-Gg: ASbGncsReYSZT3VrYU1zCMVkVFFioUw3virx7HQK0dT8J/AbUZ421Sji8iafmtrrwWx
 Xg/nWPVufzXKQMsHUDRQrYo9OwVxXKrcJSY4RVtcgasSHkNqCAs7f4iDWeTVHUVHTBb6vpq60Ep
 tXHIvA7ShrWUy3rYqSPUnwmpZraBa/0UuNFnJKgbV3hS9dNukhShaivBihLYfv3ojcPG0s1Dzwd
 CyDCC8GfI5z6/ln5n5g4ENbtsCd0BUkJyuPwQm/vXUVa8kdtcq/3Vxw9Ve3dFbh+Pj80+947H3i
 sxvXSSMTG+8y5AhXOfjRlZyL8tbVHvFzrOkVwTtR/soyH5MvLKkye5oKLZCjHLi2diRxKNmIU5U
 S2S52olpfGIBB/i3sg66Ex2vcdIZwcQbaVr8tP53LJZroBE6vpew1vkUQWcimHP5n
X-Google-Smtp-Source: AGHT+IEiosfUmIogiJavQF+ozSaGh2zUrlX/n2lV65Xr2Dl215ncab06cE51SpoS1VLiWSjrEsvivA==
X-Received: by 2002:a17:90b:38d0:b0:32b:c5a9:7be9 with SMTP id
 98e67ed59e1d1-33b51386061mr768869a91.25.1759864449473; 
 Tue, 07 Oct 2025 12:14:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b510ff99dsm446338a91.6.2025.10.07.12.14.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 12:14:08 -0700 (PDT)
Message-ID: <56e886af-08e4-4c08-8fec-0ca49c42581f@linaro.org>
Date: Tue, 7 Oct 2025 12:14:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: make --enable-rust overridable with
 EXTRA_CONFIGURE_OPTS
To: qemu-devel@nongnu.org
References: <20251007153406.421032-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251007153406.421032-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 10/7/25 08:34, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/docker/common.rc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 752f4f3aed..79d533ab2e 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -53,8 +53,8 @@ configure_qemu()
>       config_opts="--enable-werror \
>                    ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
>                    --prefix=$INSTALL_DIR \
> -                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
>                    $enable_rust \
> +                 $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS \
>                    $@"
>       echo "Configure options:"
>       echo $config_opts

Thanks,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

