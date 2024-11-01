Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A3D5CC99
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 10:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6oVL-0005Oo-Qo; Fri, 01 Nov 2024 06:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6oVJ-0005OK-U6
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 06:03:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6oVI-0004gv-An
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 06:03:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso10811135e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 03:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730455418; x=1731060218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2M4HTEdz4D/kbmA2v4+xV/MfOGFlQrYTedlaqO+uK1g=;
 b=kgN/xgUyuzQeC/6K9ZMELWJ+lXjPOaWA8Bci110bew4QGkh7TXbG8+UWCiv+jgFBxE
 e/l2mFSMCZ3KjFp6hnIQCQlmmuhV2ZtR4KZ2iWCj/A6CvsbEb1E4GxoSAbIbyMpoihoK
 f6jhozu+YEHcF9Q+4rtI8GQsMbojiMCbZfESWpVFaCXDovMfix67QOFWLg3z0kwW3C2c
 FwtygBg2hm7zeGsixTlLrWyALaViEiPxwcNQDR1zGyDnYCHvmVlPRD304N29Beu3fe5/
 CSMsx+4eTt1iWOpnLw8Om0zdboFLMWJ+qGi1QE0UkxBk34ac3swaU8jyHR1l1hvGrhZk
 bs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730455418; x=1731060218;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2M4HTEdz4D/kbmA2v4+xV/MfOGFlQrYTedlaqO+uK1g=;
 b=qXx+vVNNbmsY3C6k2JXSHd3/Ysu5kQtfwoI+99EMIn8UNIzPX4hy8m1kw50FQpXvwi
 cCpHU40qI4wH8MB4hMgLs95qxaMA8BU+O/IH1sVJiwsF3661gMiLs22Nmth7OG7HOFAx
 JXmTQNAsRb8p7pc1S5Ic4ql+PN0pXyNXT65NpCrdtMXTSUn2VtxnXLQFA8EOjRchwbqT
 LdxhLuSPYq+p9OzjPx0AAk+omXUjqYFhg/4W4cHcO9mrq6tyBOUjxhssBOSKsr5c6psI
 pMOdTIB+8mjKkxuQwK2rNP4ILV2iweuX+DHluOyogMRENUbq2H0g+vXiLmKA3iCsAJT2
 fH6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9wkvguh53chdl9Tf52PCwgsPXi0r7zhjZO1D5YI3oF36g7pDCjPeqbXuAzgxpjEnKkm6opFWztdN6@nongnu.org
X-Gm-Message-State: AOJu0YwOeCMeLEPcdHxNQqW5S5C5ZG/Pbqkhk2+1O+f2M7u566ZRTrU3
 4chCdDxhxm8YfOmBgrrAVmPoZQZB/5bXMW6ZRYKWAxA3B9rUHzv3vANC6cHaRNY=
X-Google-Smtp-Source: AGHT+IGi2wlF3g03D8SUCEARaUREQw/2U9ziycwQY0JuiNUCQbIReq+PO4ma2W7uAlSbqsqICiXVTQ==
X-Received: by 2002:a05:600c:3150:b0:431:3b80:6ca7 with SMTP id
 5b1f17b1804b1-432830849dfmr26504005e9.13.1730455418067; 
 Fri, 01 Nov 2024 03:03:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e94cdsm54376195e9.28.2024.11.01.03.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 03:03:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94D3E5F8B3;
 Fri,  1 Nov 2024 10:03:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: peter.maydell@linaro.org,  huth@tuxfamily.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] ui/input-legacy.c: remove unused legacy
 qemu_add_kbd_event_handler() function
In-Reply-To: <20241031233452.1388728-3-mark.cave-ayland@ilande.co.uk> (Mark
 Cave-Ayland's message of "Thu, 31 Oct 2024 23:34:52 +0000")
References: <20241031233452.1388728-1-mark.cave-ayland@ilande.co.uk>
 <20241031233452.1388728-3-mark.cave-ayland@ilande.co.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 01 Nov 2024 10:03:36 +0000
Message-ID: <87bjyzi83r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> Since the last keyboard device has now been converted over to use
> qemu_input_handler_register(), the legacy qemu_add_kbd_event_handler() fu=
nction
> is now unused and can be removed.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

