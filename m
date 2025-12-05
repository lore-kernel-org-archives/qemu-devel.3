Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE80D33980
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXaE-0000gN-9P; Fri, 05 Dec 2025 10:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXaC-0000fx-MT
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:18:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXaB-0002kn-6k
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:18:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so15509365e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764947933; x=1765552733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKHnl5+R0/Gufi2h7UqVhbpXH64b7kJd7knoUSvJkwI=;
 b=lRwrOr8Ui0tJMDrHQF3PNT5dreDo6GS7m6ufRNlySH8f161IZ/rub17+m7GCLyfzbI
 zS+X0ld1s/Q15vkMRc6INc3jMrwUi3dGm0CLPgPyFSQ3+ee+g4L935zBOQbKffjroRG3
 qHFqZQbc8AiqG3LuejVeu08gJlAioAeyfrEeC0ZWrxuMwH8UEVub2z8nEaiCl3wF9xvK
 3RGrYXm2MnRuAdRKKc0/eCo6yuq6048j/URkmTVz+n2EtAYDtYRwAi92IlA/ZHq7Q9MC
 /qcuow2LXU4pYY30qan1DcdxAGUOKIU2OkVLTDRKoaWyCp+et4/S0t98Vn8HQXnvgS5v
 HzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947933; x=1765552733;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FKHnl5+R0/Gufi2h7UqVhbpXH64b7kJd7knoUSvJkwI=;
 b=cQx5yZARbw+u/XbpRgSmbtc8lWkSqkXiguZT8b46CbHWFWR85s7K7mj/JyBJz8z4il
 ZRyDTqWlvc4yqHzqE2Ufn45tEYb9Ul1IkCh2J7kDUjfRLGZPrUxm15Qan74TeYVal+TI
 E5r9tncdP/QFFuUpOWixauXW2BOUbmgVpApSg7QueD/8bI4ktOIoAV8WgKKSSo/WR4J/
 vPU8qtyxtxg1fBOQUyUwzeDS9cqYKzn7eTnv5/RtkcZG9P5edMcemVfn4tGVOhKGgzBU
 V3A8jda/8nrG7O6ErNrUFkfIGO0sVjtNMuylR9OTG/G3gS+IIqRy0rNhL0QP+wGcye22
 w6KQ==
X-Gm-Message-State: AOJu0YzRAvJl7JuXsKTyjfNSZomvNux1qEm+co0kpNQvZs3/qlwmAKTC
 QW/ZQ3M+/Re55WEp10WZElAvA0VvpsBHhtpt7MxBx4pSJL/5dMtkAnxxgSWf+a2Uk2I=
X-Gm-Gg: ASbGncuuCL07j4LLrsfuQ0nVGpUr7pa9hvFTz8P0di1mjAHpn2ww79A2WtWl6w9X6ql
 3nwdFAP8m00zrhujw5rnwP54JgfCqz0rATspXqG83bMOcBIPe2IyduOdgV6NlNIaGLATn6f9XLd
 tR5iDlXlgvroqXpmf1h7p156mQMfCm4xeWhRzflILgvk40sworJqDiilmZiRdwKxlUzA15ExajW
 nam34u5uNiOr/AdK/1OQlQaz52GXyx5TzxYZY8tZEaZ87sXSohrzLNyV/aTCO74///w4HKg8z/l
 7j+xgY9hWV84OML9EmT4I3Wb0J1coGHU8MErwetVkfZcpsENj+6Ssual8olsoXFFLBsToS3bG0E
 Zbfc5Li8GwVX7SzgW19eP0yvPxw5WUqHLCaBvMUxmSsZochQJvUwKe1TJOmv5DsMbTK9X0EXe8i
 BTEcsHjgoHQ/I=
X-Google-Smtp-Source: AGHT+IFL1qaCaEry81hZK0b18KafydtveNfo9UQcJE3sYTAiMum0RVe7Rwjp3aKZKlR/5tgzXyFIfA==
X-Received: by 2002:a05:600c:1c15:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-4792af404fdmr139042565e9.24.1764947933500; 
 Fri, 05 Dec 2025 07:18:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b02e7fbsm60218945e9.2.2025.12.05.07.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 07:18:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 194135F7F6;
 Fri, 05 Dec 2025 15:18:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?S=C3=B6nke?= Holz <sholz8530@gmail.com>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: unbreak
 --no-prefix-symbols
In-Reply-To: <20251205105614.13673-1-sholz8530@gmail.com> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6nke?= Holz"'s
 message of "Fri, 5 Dec 2025 11:56:14 +0100")
References: <20251205105614.13673-1-sholz8530@gmail.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 05 Dec 2025 15:18:50 +0000
Message-ID: <874iq5rm79.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

S=C3=B6nke Holz <sholz8530@gmail.com> writes:

> Since 8a545a336d, `name` is unbound if --no-prefix-symbols is passed,
> causing this script to break when that option is set.
>
> Signed-off-by: S=C3=B6nke Holz <sholz8530@gmail.com>

Queued to pr/051225-10.2-final-fixes-1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

