Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163B2CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 15:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJCVm-0003pv-IV; Wed, 12 Nov 2025 10:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJCTG-0002MO-Ce
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 10:09:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vJCTE-000750-EP
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 10:09:18 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47721743fd0so5509765e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 07:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762960140; x=1763564940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qEN0Nqv2JL7nJEzwv2A8fmEjvJqvrO8INDU15jCsKSA=;
 b=dZell2vehUpIMZz30JF/63AEBucPujvnElC3oUotCjXen5/6h7gn8uJvW909c5ZEA2
 DhLiVNIuLP+b6XupHIW76rlV0aIt5uUOT1TD4RlVr7xPpFyIoFJD86f8hDKtrtYZs2VJ
 dQX4PYheFu0KK1h/U8nTgBLfq2RjbCfa+CMBFe3U+TEHhG7z0ZLb3CkePvf5lqBg+u1L
 OiQeZCXySTzThUuqc0laZh1BBentFxcuwtMhJY1K6Cv6EEDHh+sUET31bwdQJX5H9Fm7
 0beTwLeHO9EZtgi8yGLUbyRJKmin+9qFyjLgbKNH2xbeHQzbmL5nX9qKKpdRpRYLmhAs
 bx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762960140; x=1763564940;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qEN0Nqv2JL7nJEzwv2A8fmEjvJqvrO8INDU15jCsKSA=;
 b=K4LFVr8mPKPsqfx/ejO+WP7wpDXCgcqWxxGEwim9XC52uU8+jJVb6TcMoYd97soTNl
 vuXJiNH1h1wqUW67RfBJyFnLejw67WMs5OieeHB0BOcCm6/vSmhKD7dlwBwOLRV9QmyY
 OMj3HnxEoyyPdX3i+8UZaAvMRPFJHxBAai4hed4VKsR2CFJGuRrabFW3Nc2ihHNGKJYM
 QIATIEXmOpLRiCMXzJQT32bwv8A2DZ/z3gcWnrbDG/NErHN1UzbUFk77Mc4yND3EOaK2
 u2lETXtVzmb6N+XSH9L6qU/AY3CorzEwHMOXai4+DDQUd41gFtpWwKFlxo9YY4Qr/QEQ
 2CqA==
X-Gm-Message-State: AOJu0YwE7rBj4/RYsWMqFIHiui166RRQeepU8L3/XpqX4fAw2haTLsRq
 Ky52K/Tq8XkfSb+kL+4MzKAVEKdjA/fw4U3sQ9irfsW3fn403lMoEUltbEhlv/bx37I=
X-Gm-Gg: ASbGncsxqEQppRNNzgVncbL/oXOK1nHVQ2K+N4rGuH/D4pPmc2irjUL2ug0dPomf7d/
 coxpDjRcfPJMTudt+pBLyYFMsEZuwyJwjgpinPKt7tJAp0iLXxa3O9POiAOm5wEkuN8ZebP2jWj
 EDopmKP/JWXXbnpn4LDECrFoEYrVzQ3JsrNHt82YqVOqxLysO57G3+seOjBAatHHS/5Muv4SDsG
 1ld/js62JVglBNI6kG2vj2v6RcFROF8rCIwxAvXit86Kyz1I/9d2k+QYxh63zDsq4YuoC7MYixR
 lOc/goAeEpjpfHp3+0P36jWGRQiKc6bO/BfMXnzl+WG6S/Ggy+006rK6UzbNcXGKu5ghmxHjaw3
 OOi741LmNp4KwuuAheFn38W7ZIiIRFSSqNmNjkphMyZOofvj4IyMe0DnSQ4OKe+kauOe9anjs9M
 KBu6J6wHBH5fX8zKbDLv1d2EZ1hyUb0HgfNWb53h00FOVQBcG76QyhrXu9Wg==
X-Google-Smtp-Source: AGHT+IGa/bOsJ2ZnJYJnett7KY7mZhOf9sKXK3UDY+qLOsl4nglzaordZYg2Pg/JxwJlktIdtL51FA==
X-Received: by 2002:a05:600c:4fc7:b0:477:7d94:5d0e with SMTP id
 5b1f17b1804b1-477871c33cfmr27011805e9.27.1762960139965; 
 Wed, 12 Nov 2025 07:08:59 -0800 (PST)
Received: from [192.168.8.105] (17.red-37-158-52.dynamicip.rima-tde.net.
 [37.158.52.17]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e7006bsm38068515e9.12.2025.11.12.07.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 07:08:59 -0800 (PST)
Message-ID: <efd7a408-0a62-420a-9798-9f123a54408b@linaro.org>
Date: Wed, 12 Nov 2025 16:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/28] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251111213238.181992-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 11/11/25 22:32, Kevin Wolf wrote:
> The following changes since commit 593aee5df98b4a862ff8841a57ea3dbf22131a5f:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-11-10 16:49:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 909852ba6b4a22fd2b6f9d8b88adb5fc47dfa781:
> 
>    qemu-img rebase: don't exceed IO_BUF_SIZE in one operation (2025-11-11 22:06:09 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - stream: Fix potential crash during job completion
> - aio: add the aio_add_sqe() io_uring API
> - qcow2: put discards in discard queue when discard-no-unref is enabled
> - qcow2, vmdk: Restrict creation with secondary file using protocol
> - qemu-img rebase: Fix assertion failure due to exceeding IO_BUF_SIZE
> - iotests: Run iotests with sanitizers
> - iotests: Add more image formats to the thorough testing
> - iotests: Improve the dry run list to speed up thorough testing
> - Code cleanup


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

