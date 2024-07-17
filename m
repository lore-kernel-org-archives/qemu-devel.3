Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8D6C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 18:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU9HC-0002fx-B1; Wed, 17 Jul 2024 14:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sU9H7-0002cM-0b
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:21:16 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sU9H3-0003hR-G7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:21:12 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77ec5d3b0dso848778366b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721240466; x=1721845266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KCY004z5Dxza3lmHFA+LT2cLTN/q83On+S26fRepaFQ=;
 b=V45oawnAvcyBAnXwNrf/w5c1kWPTLCdHxVrzF5b5+RF7oUncV+MHB8xPuV36AbEd34
 906JAr+kttNPmuY/V9kDA6K9Myk4wmyHHZPF8qfNsucboFs3ly3XGAFRlvdxstXgoeBk
 culCZoq9c9Jy2Xp0BA94LXQ9fmP+P/bv9J3gmY4T5YnNExzhFNkGTZNyNEzciGvO3qc4
 YdkZ3QJnWApPGb83oaN1cA75Mdb0yRFn/ngpnejZdZzamVf6DJXtfyUm4x3lm566yBCD
 OHUbt8gyJyU+/NckUVw6aG2cxVDBA0Pkx8REwZmyX777ckUOvFTZlu5ztfp31Y/DkAZC
 pFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721240466; x=1721845266;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KCY004z5Dxza3lmHFA+LT2cLTN/q83On+S26fRepaFQ=;
 b=DWqCRgOXQZLzig0X3044Ml07Og3BAJa8QnYA5Xx6LPfkUNETlxua1eXX/HFbfcVMJI
 nHPWf7ay6/7qQWMYOybSwrztQJD3BAe7xezb6djHMzhjKwd8CuK3RPgaBBZE6YoUyiWA
 Sb880vRL8nm+jH5hlPM4mUpLLd2tTuS2pkHSDZNh9Ow0PWozElUsnXQrrV46LivsqSJz
 fpZlSvkqav3RuoSSkWdgoKP4nosqXM74sAAaJdQLsGaNcldgq+xRqfskhrIPQy+F04Lq
 Ptd5C0Lt9z2V6QcfVIWMfFBrw4FfbXKOP2NZ7zXpLqvtn9E2bo/GTHcl2nGj0IfwRwTw
 RVtQ==
X-Gm-Message-State: AOJu0Yxk3dvbOULGBbzOkay0USMZvPxquKWEKMD/i8djriOorGTwfngr
 OsFQBHHtcRG3hUp6L6rl7BEYBoVTc8IZJOJZs6iw29Pg9FErJ56h+9WyKos9hvY=
X-Google-Smtp-Source: AGHT+IH2jA/eltcgC+pBp9hSb5Rx9MMs/LadV8BPMZM976p3hlJyXshKhydnm1VViM5z+6z8lLrG+A==
X-Received: by 2002:a17:906:a06:b0:a77:c080:11fc with SMTP id
 a640c23a62f3a-a7a011ae5f1mr160713566b.36.1721240465466; 
 Wed, 17 Jul 2024 11:21:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc7ff8a9sm472021866b.163.2024.07.17.11.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 11:21:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 98FF45F738;
 Wed, 17 Jul 2024 19:21:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Anton Johansson <anjo@rev.ng>,
 qemu-riscv@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/8] semihosting: Restrict to TCG
In-Reply-To: <20240717105723.58965-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 17 Jul 2024 12:57:15
 +0200")
References: <20240717105723.58965-1-philmd@linaro.org>
Date: Wed, 17 Jul 2024 19:21:03 +0100
Message-ID: <87wmljg9rk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> v4: Address Paolo's comment
> v3: Address Anton's comment
> v2: Address Paolo's comment
>
> Semihosting currently uses the TCG probe_access API,
> so it is pointless to have it in the binary when TCG
> isn't.
>
> It could be implemented for other accelerators, but
> work need to be done. Meanwhile, do not enable it
> unless TCG is available.

Queued to semihosting/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

