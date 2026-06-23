Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0708CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Qg-0002wm-H7; Tue, 23 Jun 2026 08:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wc0QX-0002wK-26
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:40:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wc0QT-0005b5-N4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:40:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso57508455e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782218423; x=1782823223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hSVCyePbAN8FPnbd1k//0Ae/iHcFxowrb/AcDanF0U=;
 b=CxyK1MJFtwuWluEfWTj+1sqIvhOV3/+6Ru3NIqL8Njk1RTEruEhGwLobHAGIA4y0br
 PIODVola6gN2c/VsvEnTOXdhHc12wkwf4JJAvZQl9Nh/DlLzENBd+2BmxvbHY054A2AS
 N408j64ncl0+IjGqcC1HFpscK0OYKwZIF3/fYPYxvO3qaBXBFpVUgLjj4Yr7LfvfyBCG
 Stos7dhRW+KJ+Obls2lE7t0SrBpwHlM09UA/Pfqcb9Mn7oO5AEXoqW+K/NGzabnu6Z53
 6vnyNV0wfcLg6fRScc+44PlLxrgxVDXmNbw/9gJUTKO3+4aYTrOJGxdsDAC9r5meR0aI
 ovzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218423; x=1782823223;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4hSVCyePbAN8FPnbd1k//0Ae/iHcFxowrb/AcDanF0U=;
 b=a0tZWkoPqX10TwHUiBGId9lQt53D0v4UJSX17qrhPKEF8dyfDRUfjISJCwreHzK7E2
 Dd8iNWUARlwGOXjH76ftD1bPPLag2gUhXosLWxH5uF7i8VuVuvfKv4aYzazBLYPGNxG8
 Ushucwl1/O+GiUGI7jrwxwrrdOrS+UJn77WJ0+YSclvHSl1zzLGp4z37Z9tsBiEQ5Ypp
 1tR595z17nhUQjEJ+FiLpqh6kYa34BHCa2VhOutH1Hu3FF0zQKxyzGBvTQ3BbzfrNoct
 38L5obz5LujA42PT5x6anfir2LoeIws80R1OWVxXAGgamN3QYaMXpOCuXb3xliWpTT18
 sAQA==
X-Gm-Message-State: AOJu0YyPwqr8Tk+FxsMISZTnzrJobu/cPwZKyNmWmF1DNw3390ciU8NW
 o0igTtyW4zszB1rUFY3/FlPnmJx+UXyA80q8FHLNspcN3cYH67robDOtrMdurtbMMSI=
X-Gm-Gg: AfdE7clmh8EbHx4F6B4bwEDlfXE7GB3v/CY1mBfGz991id031WaiZd0FFPShuPK/YD6
 KW78V6sZKLr3IOsGxoEGv0037CepD9br1KfAizhYUBwrW6G02uKhLR/ftOjK7i61bC8eBSZFy1e
 4kJ0VpQVnY4B1XbTea/P/SP2bxziapQpcLrOVbmdcldYE8wcwTTSv+KAqALRw0jB+3AF/uxYyT4
 E4v8N4aUZYFD846x91kF3VMSI7gvHRbSrKGp0DNp3yg4ewE4he5rSFf0qGY50vw4e6nLG+o6cIC
 It+oDsKzbIFKU19iO+Hen1H1hUjS3NvBN5ZHKyeDyxCCmWGGfTG5g8cBkmjxnPzOBplDK6s7rsc
 oPSCmEE0yFPn71Qj0CLjesDT2YM0KYQrPGCX1paNNAXqU3fIKPmpNNnN/UiM9dw7Ljqo9svT4Y3
 UaczvGKkj06uDa
X-Received: by 2002:a05:600d:8496:20b0:492:59c7:8db1 with SMTP id
 5b1f17b1804b1-4925b38efe5mr28740215e9.9.1782218423500; 
 Tue, 23 Jun 2026 05:40:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fe7ba08sm373820455e9.11.2026.06.23.05.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:40:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E77C25F80E;
 Tue, 23 Jun 2026 13:40:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] semihosting/arm-compat-semi: Fix =?utf-8?Q?auto?=
 =?utf-8?Q?=E2=80=91strlen?=
 detection for =?utf-8?Q?32=E2=80=91bit?= targets
In-Reply-To: <20260619-fix-sign-extended-32-bit-addresses-v1-1-47ae14f8e8c5@maquefel.me>
 (Nikita Shubin's message of "Fri, 19 Jun 2026 12:52:19 +0300")
References: <20260619-fix-sign-extended-32-bit-addresses-v1-0-47ae14f8e8c5@maquefel.me>
 <20260619-fix-sign-extended-32-bit-addresses-v1-1-47ae14f8e8c5@maquefel.me>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Tue, 23 Jun 2026 13:40:21 +0100
Message-ID: <877bnpmnuy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Nikita Shubin <nikita.shubin@maquefel.me> writes:

> The switch from target_ulong to uint64_t broke the mechanism of passing -1
> (0xffffffff) in arg2 to signal validate_strlen() to compute the string
> length automatically. For 32=E2=80=91bit semihosting, detect when arg2 is
> 0xffffffff and replace it with 0xffffffffffffffff. This causes an overflow
> to zero, restoring the original behavior of automatic length calculation.
>
> Fixes: 6dfbf9b6cfe ("semihosting/arm-compat-semi: replace target_ulong")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

