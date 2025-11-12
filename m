Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE8ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 10:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ8OE-0003DS-FV; Wed, 12 Nov 2025 05:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJ8N9-0002sd-Pe
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:46:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJ8N7-00061G-8f
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:46:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b3ad51fecso574960f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 02:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762944399; x=1763549199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fY6/u6Jwa8h3/BB+niDAFw0E5h5ZClOAT4h+ZxnU6dY=;
 b=H603Ctx3fKJN8rDgk1wwXFwrFuaLzI3PNxnFOTfGUAZElTp9k3K4LNq/dqcBmnk7aY
 jhR7tUEQsGEVum2fyxAPcKrMbe8GxGK3ICTW6KklbALthkWL8CFJZfavM08qmh4P9J4u
 79XWpgx1cUbzc47Ft/4I1Yk+I0ToLN7NP07ruZanH0qNjIURazSKSbESaAQbv+KCJSun
 KwET6/UPs3/oVK3LtIt8vQSBf6VHXzeQD+tvDBxahx4i/6x9srK1d9tHCHMLEXeCal5p
 xahXrlU+uH4qx2NBJZFcTK7Vx57wD5iXqudRtCas7uhX5a6q/HEPqdFDBQIrmVjJSFpy
 leBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762944399; x=1763549199;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fY6/u6Jwa8h3/BB+niDAFw0E5h5ZClOAT4h+ZxnU6dY=;
 b=VPqbis4G5XtY9Y4q6GVEli8jb9H0CE2F6Q5mz9erLSmV9uqtq6NUuusozXsaMTItME
 l/K6Vcalk5IGWXsuB0OdUlFBWoNeslYQ8YBXOxX7vqaLH9sD0siBDMhApVIa4/tHrR5Y
 wZ5ikuqjga9lNuH+t3FDmi1ICE5tXrxkktcQINjrFvN2S7Urdv2gEkrKWavoNqyMOlwv
 W/Dbem18z2lYOa3GjBSz9BoBZFZrdiDpjmwmr289b4WJL0D4N6cMZj7iZPdPZRNWd5di
 k1qDn47Ms8L3oUqm4LWMnNEchbNRDJgajRTDvTdhZrMPnIJu3KYrAjeOhlnGeQkrthIH
 8/1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwoubXrnglUudtZ4BUo3SNqVQtVdVV+AgGW685uw8nD64c0tAZJJoUbmPnYmgVTgDRqcgIqj7yzuaF@nongnu.org
X-Gm-Message-State: AOJu0YwkM0O400zRZo+aXcU9QpGWRs9HtgQzaEePLQH0btFeyvPbCAm5
 MXrdtJ6I/MykrP55/6A1LcjTurPMEGAtAadwdYM8d7sGtbqtGTtZvIqrLptHLE/PwuM7vdDZU4h
 iX2pPhb4=
X-Gm-Gg: ASbGnctDeznA4XTSapRSvIsU5hPxA51Xb++CW4uaH9YakE43fYNwHsdIo16aFa0a63U
 HjUPIylRYDeBpj4mnJO48SgkC3lR4nHh9cX9nfuQcF2xm0r6P+Exwy7brBU6eSt4ghrP/9VjR0n
 +zgn8iDu/1fUqvgFLZvUM9qFJPCEnA2P9ATLfdjGwLRwF0uot2wgNBq7McTCGDor/2BIJfrdwG7
 yQlHP93nQyj85Jg0BaX80VD8tZg14UWAxpHxoCcxr2AeHA+4ceEDuK3yCHDkFoUfYHFpLJjX1D/
 6Crw8IA+L7/yNMdg8QPL7CLtz44yUZ5ukWP1sZDQuw4CKLh6ZOODCAcHsyEpF9QyRxUzkNvkenx
 fCQNqfBHLFodF3/6HRGmW2kPI179Bqp3zrTB6+2rnpfoiaITFNrDGYZ2PTxnU7/U6YMutGS5Kez
 R1cX/QtR378r4xgrHdnQvxvEYLMzKEZwYKmrrEE7+J3ljSejb/nNsLKJZUDw==
X-Google-Smtp-Source: AGHT+IFsOK+yedoy7PqjQjo0YGpOuAYC/A44V3Blb8enO0NaxbsbYIMUa82pHYLib8Ud+y7xubdNIQ==
X-Received: by 2002:a05:6000:22c1:b0:42b:4139:577b with SMTP id
 ffacd0b85a97d-42b4bdb9903mr2038045f8f.45.1762944398606; 
 Wed, 12 Nov 2025 02:46:38 -0800 (PST)
Received: from [192.168.8.105] (17.red-37-158-52.dynamicip.rima-tde.net.
 [37.158.52.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67921c3sm33852951f8f.40.2025.11.12.02.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 02:46:38 -0800 (PST)
Message-ID: <ec1d438a-ff14-4848-a20b-3ae5ae9b0758@linaro.org>
Date: Wed, 12 Nov 2025 11:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Functional test patches (fixes for pylint issues)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20251111102158.92091-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251111102158.92091-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

On 11/11/25 11:21, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 593aee5df98b4a862ff8841a57ea3dbf22131a5f:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-11-10 16:49:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-11-11
> 
> for you to fetch changes up to 0fa4b130a8d4fc46fb7b0b97b34656ac0c69c3c9:
> 
>    tests/functional/m68k/test_nextcube: Fix issues reported by pylint (2025-11-11 09:39:03 +0100)
> 
> ----------------------------------------------------------------
> * Fix some issues in the functional tests that pylint complains about


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

