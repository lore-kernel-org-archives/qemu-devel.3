Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA3FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6UC7-0006Xm-IT; Mon, 13 May 2024 07:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6UC4-0006X7-FK
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:50:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6UC2-0004tD-NM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:50:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34dc9065606so2351057f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715601009; x=1716205809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PPIyx545d458eNHQD6JkMOiCwoNfLT04ZIEcojiQsoM=;
 b=XRRVPSqzgw+blcy46woOmtMvgLVw327BiiyXdmVdWhKm+VE1e3g4woVAcQXjgHg713
 AbzRW1okPB4cKttpwk3YAS6jqAXPxc/y2IPSJh1BDAaXQNmMRX92ABVBvOM5IAzpQh+0
 68BZVymDMBvgTCutGPtO/f5y+MDIBCybVjThiLa3o4fXjbDDI+JVRSq6JcEDC2sHsPvA
 KsEvnyzDXXcliyieZTOWlODYuIYP8f6qRTzG98aKJ/5PV5OJaCSoI3SCIV3WICH1FrXG
 sh2X6l1H6FJ08c93gBhkBq6AotjpTi2rLI38JHsF4DEKNQYqocYJ5nK6gDCf2ZlWGVru
 I/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715601009; x=1716205809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPIyx545d458eNHQD6JkMOiCwoNfLT04ZIEcojiQsoM=;
 b=SfF6OKBJ+WdlbNWQM/tEsyItP1uJZB3dq9533sRnK3eGtbmsAGi2+/SiaHdsjwPPeD
 3JMeHgzprbDZiMQvVMkoC8mX1O2wp+qTh1PPDYRBX0q6iOMEsc8BRiJGui8BMDNCbXE2
 nItmgkZccPR7aVeoCcJIW3Y2OxTFxxsHGArMBSt0JSSGt8mc8vajoooCXOxhre1OML0z
 4AxlAt1XSVMLH99D97wWbyNubm22I4+IYNIK+tRTg5R0yQYKD7ATPZebED/r0IdKB1sF
 952OBq8wcuZ8IuU6H9SULkegtxw+FDKMEtS+RNeWOxwdOkDzTc0H+2bO5J7W0wvoBOyj
 Iiyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9fzCYhrW/MY8LlFoqdXIKxOZ9Cqqvjg64kYxZRvYWoyLsULPHFNcc8mMtUpBElS34BC36DDM9xi2PAqpc+0K8U8X/uO0=
X-Gm-Message-State: AOJu0YwUImtR2KF0gAA0tn44GkrGVj4gMB1Y6ycHs+sPxcZVVzP+WM7Q
 lNnOF5I9fCfDwY/ZduA6a24dpYlrQi9ZwQOCXUKmm9Eknm0kKX2EwOO7nqBgUKPs0gFDV5tQSid
 bedE=
X-Google-Smtp-Source: AGHT+IG8v3Utodt0OX2c8BQtQ4VtAuqf3n702p41PGdYQaxfj83YYWsnoE2LdCf3X6fq6r6JR7ElmA==
X-Received: by 2002:adf:ef52:0:b0:34d:9d2c:8ea5 with SMTP id
 ffacd0b85a97d-350185d93b2mr11942585f8f.28.1715601008927; 
 Mon, 13 May 2024 04:50:08 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a77easm10902523f8f.53.2024.05.13.04.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:50:08 -0700 (PDT)
Message-ID: <9fbf78a2-0182-4915-9d70-20117db8fdbb@linaro.org>
Date: Mon, 13 May 2024 13:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dockerfiles: add 'MAKE' env variable to remaining
 containers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240513111551.488088-1-berrange@redhat.com>
 <20240513111551.488088-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513111551.488088-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/5/24 13:15, Daniel P. Berrangé wrote:
> All the lcitool generated containers define a "MAKE" env. It will be
> convenient for later patches if all containers do this.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker    | 1 +
>   tests/docker/dockerfiles/debian-hexagon-cross.docker     | 1 +
>   tests/docker/dockerfiles/debian-legacy-test-cross.docker | 1 +
>   tests/docker/dockerfiles/debian-loongarch-cross.docker   | 1 +
>   tests/docker/dockerfiles/debian-tricore-cross.docker     | 1 +
>   tests/docker/dockerfiles/debian-xtensa-cross.docker      | 1 +
>   tests/docker/dockerfiles/fedora-cris-cross.docker        | 1 +
>   7 files changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


