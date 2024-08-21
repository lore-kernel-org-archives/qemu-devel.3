Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1965C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgb1c-00050o-Ul; Tue, 20 Aug 2024 22:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb1X-0004ww-Nk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:24:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb1V-0005xA-My
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:24:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc47abc040so49453235ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724207069; x=1724811869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OnEq06pl3BtFuL6wrZezgdiu8fb6CgrOsqDNulEkgO0=;
 b=kKIvy+VcRP1455NXrtl9SLa48vMz+2aLoG0pD8Aapy5QzxEqEbU8mMrpzJBuzXiVJa
 eq/sh9XtevBjTBoEzdc9Mil98ZV84AL1A8RXIEAOsGO2RbCvhZSdBwqHOfdiwebHZnb8
 5W0bXejvr6eEwh4nmiBnPQlGnb+rGWdcyefoQa+kkQSzXqvqMI6HG1XL7vfhwprBXFrR
 Jj62aBHjdRC4GO/oADvHRbN/2qPTIYmpGhUDE3t9xqGozqzhv6mw58YUx65N180QGc3C
 tpkrZGjAMs2qYpo42DGXkz1X68NPJp4D5Rp/igZTqOZxs1lGEnK87hlTfK9Xybl5FUXE
 SjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724207069; x=1724811869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OnEq06pl3BtFuL6wrZezgdiu8fb6CgrOsqDNulEkgO0=;
 b=uYYPyUVXwpTyWZMl94A705pvNs7HI8847jgw8EobCZIzFj2AOvXiYk+xBpUmIcvE7y
 4EFjWs3at0gT8rmTnGxS0xLcXU2NvhVDUZYmQDWUXaJlj8sUNuRJMqiTq/zrYl3YMJHI
 yZSElviB2DekjAMLC+ooqhsfkYikb1BG6ANoLiYO4cfizj2bk/rCsT/3Odo+8R8uQvcT
 ZRAEpsmQNvabJsUKP6vAorl52fovDo9j53l8l7bl2XXvj/+HbJTs31T+Zf3wnsOSFKxX
 87Xfrjl/wzE9r5pCci2hb3P2EAnCctMnMSGelDv4vGTiLFt40spHpVLTrD+VCZMaO1tZ
 y8Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCXTDxXOulLsIj/ANi32+9Skhk3t/8Ry1302kfDEsLzJBV0RIAnPGNpY5I6hjOKLA6oE8sqyrNkNY2@nongnu.org
X-Gm-Message-State: AOJu0Yya3zEDmvo/8qy040Pq0NmzqEi2BzjvTm2fef/KSf3/3HoySAqz
 OtUhsBbaeqgiWPe+V+hoIp69L+K3djiED+jn8j2VFq5DD8sEdtQZ6Vfwv6KT1CM=
X-Google-Smtp-Source: AGHT+IEuxkuXE9guHfqo+E/4J1RIV//8hIFjvgJ8TCTHnxLumX98acMEBGpmv+sqxCPQXGW+PxZhlg==
X-Received: by 2002:a17:90a:cb82:b0:2ca:8a93:a40b with SMTP id
 98e67ed59e1d1-2d5e9ec9ad8mr972246a91.31.1724207068646; 
 Tue, 20 Aug 2024 19:24:28 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.140.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebb79a6dsm369032a91.46.2024.08.20.19.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 19:24:28 -0700 (PDT)
Message-ID: <7746fd12-edaf-4c20-ba6c-2b390d8441b5@linaro.org>
Date: Wed, 21 Aug 2024 12:24:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Migration patches for 2024-08-20
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240820170741.27055-1-farosas@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240820170741.27055-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/21/24 03:07, Fabiano Rosas wrote:
> The following changes since commit 075fd020afe3150a0e6c4b049705b358b597b65a:
> 
>    Merge tag 'nvme-next-pull-request' ofhttps://gitlab.com/birkelund/qemu into staging (2024-08-20 16:51:15 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/migration-20240820-pull-request
> 
> for you to fetch changes up to 4c107870e8b2ba3951ee0c46123f1c3b5d3a19d3:
> 
>    migration/multifd: FreeMultiFDRecvParams::data (2024-08-20 12:44:13 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - Peter's fix for a leak in multifd recv side


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

