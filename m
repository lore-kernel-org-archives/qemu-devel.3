Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F77C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 17:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiz4P-0003Nm-Du; Mon, 04 Aug 2025 13:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uixCq-0001c3-NG
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:34:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uixCo-0003X7-Uk
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:34:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so39782415e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754321669; x=1754926469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVYPZNnvNJ/HBv7j/eFsJIgttF7Sj6s2V2xediSLMxU=;
 b=Jvc0uRN4pXHz40BjhXo+YVbA44uR+UKZKlzvGzc0WImWd12JLVYRIfsIxDAp7ppBtF
 mWi4y/C0uyCg4bPlocQh8O0CnQFbPbW9mz5Gq2FJ69IO6x/Xf5SBTIn31Ey1Wwz3lLRb
 w9cM5Y283ABVcB+GmG1slFaztObY4KwZuiFHZppbfneVLWTRc0OdGi5tszAVOyYS8/Q9
 UaHIFijtr6rV1s2Crbiu35qP006qI3Cipi9kL2nvAD92zNSc2EqNWgWT59Z1fxBmk0Dh
 c92DxeQpHFCb/wIp+SYc1y/V+8em+V1qMqVaywrnCrYgmpkJZGfeltE7tI6iHranLYmF
 V5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321669; x=1754926469;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gVYPZNnvNJ/HBv7j/eFsJIgttF7Sj6s2V2xediSLMxU=;
 b=JVZpSqaklPwjZiG8W8SCVn6gPkm/Bz/eSwF5yXefT2L7Z55rSW0WWOXoK6WTu1JyMW
 Ly879RsLOS20cK0W8k2K8LU96P1qgZvZNF2yDZ77+tRVRQQTW51ayQWRk27DrykbcDAV
 SmYNKpmau+q7MRTljR/072n0HknZ6SL9eJbnIROYLLhA7nfHk6C8YQztL6QadaNCvz9s
 Phs+eiikXoutwkV5aFSXL0wiSZu2aOIdMBMCARslTqtqM1B2czfE3OkMMF2nz2NEbtzi
 WxSgQGKl2TzG8pW5d8NxT+zSf1LTxdQKvMy3CtyqMEZZNeAaiU9pmAHjtPFR7TefHB3S
 QeTQ==
X-Gm-Message-State: AOJu0YxOY25DJdhybrDTR/JXyasdZyxLmf5Fxa0eFgOCl/r5pM3FnBFD
 mrKD5pqueOJYzKqn9Gxx7zzteQLMRcmHqHIxEM5k3kkb05XyrBfd1tbHHd4d4pXFzn0=
X-Gm-Gg: ASbGnctlp89kdLad/unqKBz0SE65qertJLPnRRhAwBQs46wIblx7OX8tEQ8ADroJZND
 wXpiKQC837mSO0GDKkM6Y2I07dHB9Dj9OTjgQS4HwwpPVFPunvRlTLS+JV6TIIfNI2bk6sumFLg
 kCv9khcqEWSBNxoOcPk2VsitRFNWk1YloEti3kqDZ2wzKWMsmf++LlxeyYRtgYsWVObYBhQWfbn
 KYFQ3eakmuos8lnvYvPYzu4/p7Xq8T2uX6kURlXe4o4fCIIyz3BFjA0RNC1dTKkv0wPtQz2bUFa
 il45+cdGgBM9wbvBSzc0Yl0XbG9zQ29eji2J+BsFojGuXOLbMYqPitqFqhVdIRgYVXOa2DDo3i8
 bXWmizv2XzKijVFZMDAWoviI=
X-Google-Smtp-Source: AGHT+IF1YAKOkGXcH8kN8YTqAANw6T4uBTFyvrm2RpQmkwO4+C3R5b4UMfS2ekEv2pAl53EKRBns4g==
X-Received: by 2002:a05:600c:1686:b0:458:bb0e:8cda with SMTP id
 5b1f17b1804b1-458bb0e8dc1mr53677375e9.17.1754321668781; 
 Mon, 04 Aug 2025 08:34:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bc39e694sm91742925e9.19.2025.08.04.08.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:34:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2518B5F88A;
 Mon, 04 Aug 2025 16:34:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME
 ZA remote gdb debugging
In-Reply-To: <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com> (Vacha
 Bhavsar's message of "Tue, 22 Jul 2025 20:14:03 +0000")
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 16:34:27 +0100
Message-ID: <875xf36qyk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:

> This patch increases the value of the MAX_PACKET_LEGNTH to
> 131100 from 4096 to allow the GDBState.line_buf to be large enough
> to accommodate the full contents of the SME ZA storage when the
> vector length is maximal. This is in preparation for a related
> patch that allows SME register visibility through remote GDB
> debugging.
>
> Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> ---
> Changes since v3:
> - this patch was not present in version 3
>
>  gdbstub/internals.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index bf5a5c6302..b58a66c201 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -11,7 +11,7 @@
>=20=20
>  #include "exec/cpu-common.h"
>=20=20
> -#define MAX_PACKET_LENGTH 4096
> +#define MAX_PACKET_LENGTH 131100

This is a rather large expansion for something that ends up in a static at:

    char line_buf[MAX_PACKET_LENGTH];

I think maybe its time to get rid of this hardcoded define and make line_bu=
f a
dynamically re-sizeable buffer along the lines of str_buf and mem_buf.
In fact make it a GString and we can get rid of line_buf_index as well.

>=20=20
>  /*
>   * Shared structures and definitions

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

