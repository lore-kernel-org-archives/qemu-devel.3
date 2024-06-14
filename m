Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E05BC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI52c-0004gS-UB; Fri, 14 Jun 2024 07:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI52b-0004gJ-Gz
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:24:21 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI52Y-00033D-VD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:24:20 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57c83100c5fso2165872a12.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718364257; x=1718969057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z4GAixjB8/ofO0DIs37kEwakYradaDpWHGxDxmII6Sk=;
 b=bcqO2lVv5IZalF9jN432fAknhITpiWndACr6kCtksFZ+YB7k1lCmI7e1FjPhzxecQR
 Wow5T0xaPLcf/u8I+Z41lwpEb52jdBypb4Ck02BrvsywtDq4SH+kKfMJ9QWBQoyJisnQ
 /+8OwApsZcQugWIypl7v2xbga15p/fNmv58skZaYflEWdRsDMcv8LIIRBS0VaC94Fo0n
 iPTBxn94TWrTHMmKhhN2Klh9MVKUpPPYziSbITkfEJCF2GEo7p0aoP5wQk4xjD43peb8
 9qMRaTt4b1POvwTHsVP68zxPo9vU9rP4hY3q1osMKMY6WaHWgXz+ZhkqCzsLRIKC/9x2
 s0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718364257; x=1718969057;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4GAixjB8/ofO0DIs37kEwakYradaDpWHGxDxmII6Sk=;
 b=Lb1fb3fPwrvu1NjiBxtvGgwsBAUzjvOdXTA3i9+ovK136yGxVjyZ/xGpegmYwwlvgw
 tOFRqIIA4X5DqECipD5t/v2c9Uv9ACsX09GPzTQVaRBAhQNVDzx4iWeK9kREDz6ZcpMw
 xV+kzq/32mMI1Kfu2CfHPDz475OspbrTzOOv9CB5esHpVwcQoEoLkJ/FQlFqbBd9X1i0
 xlyl/O2lu1KLmo4ZZJrqa/y5YzDWq8peM24Fsf8AoZ57g+5QjmWU/ORAeia6DZ3FbzoX
 XnyA2MSUBDkAifI5lRk5ES1SrcH96GOVeEt1FRPmYyIJSD8OGqo9lclBgAR1+5Kc3Ni3
 Kz4Q==
X-Gm-Message-State: AOJu0YxfUumupsgHVddVMaGf2kwPcCgVyKo0vdx6XKiF8jpKN6DcjSPQ
 IeXRt0IU3Aiw63ppAE913naRFqUEodarNroQ+jUYJW5k45uVy4REAmkx+cUqP73tEJECIx20k4X
 c
X-Google-Smtp-Source: AGHT+IFTljzQ+04fI7a6lvItZyNiOtq05ZVQq7nQjPZDvg40vhLeaB/T0ybbD59JL2W0KuzJ9NyWqA==
X-Received: by 2002:a17:906:f0d3:b0:a6f:54fc:d921 with SMTP id
 a640c23a62f3a-a6f60cefe17mr147816166b.16.1718364256643; 
 Fri, 14 Jun 2024 04:24:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f413a2sm175657366b.151.2024.06.14.04.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:24:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7FAA5F794;
 Fri, 14 Jun 2024 12:24:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 1/9] gdbstub: Clean up process_string_cmd
In-Reply-To: <20240613172103.2987519-2-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:20:55 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-2-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 12:24:15 +0100
Message-ID: <87a5jnvkbk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Change 'process_string_cmd' to return true on success and false on
> failure, instead of 0 and -1.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

