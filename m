Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688C3CEACE5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfdI-0007SK-7S; Tue, 01 Oct 2024 12:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svfdG-0007Ry-7m
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:21:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svfdE-0004Ej-Qc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:21:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso70183525e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727799706; x=1728404506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bu2QfQgGq00OzC+5pHkgRKkffhGGxuRnZ93hVeMgr7k=;
 b=OrVLC1PY5dKWkPxAqbF/jXCdfTMeFTZ5AODHpRrGifP1iI8yUnyHdyB5a4BBoyfkA3
 fJ5I/OotirC7L/Qd6g7j82G+R5nQumj6OCdds/GVdHGnbZTZ927cHAjrdeNi9karIX/A
 Qyom8WDHbl4GjULV2YvlxXd8fZ+BcVPespjIVpuw6C51ZF4E/LLqO2HlkYM/AhWcQLZ8
 kIWJSmzW3roBXwrQeaOq39i8Y8L6fx7yO1Eu1C/OtFiex7E/pj+rH0UKTCBCtnkATIIN
 3MCVwMIKSUimEATz89GsYbiLqI0Umj6BqWtWGMc6SpdOkZUJiQiDpDHeR89TckK1nn6X
 Gf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727799706; x=1728404506;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bu2QfQgGq00OzC+5pHkgRKkffhGGxuRnZ93hVeMgr7k=;
 b=GMlmK/MWioJyvCLO3k/QTQjezaltsoI372cLT3I1V9tbTW41x1HIlpugtDSVRmNoxN
 YEWySWsxq1np3sHsGUJNbKjRLe3DTyg0+tRCPUii44OKvFBm2GCbCVrY4pVsNhU1n4K5
 Ah/Kv7CIS300ZAXO45SStSO15VX/V4u0d4lWhQr8J1um4B0gKMlZzgICRVk19eMpkMhx
 kw6H+NyWjVXs+cquX4BkdfhJV6BIFOEYrRjXArqJBjL9IOAaatCcX365LRqTPKlqbV4c
 zepMWqrqozqtt8Yn4itRqBIX3Qix0ibmXCEKZkEuAbMsuxSk/dplFTXFTCXcjwrgoxQ5
 mDVQ==
X-Gm-Message-State: AOJu0Yyn1bfhayTPET2YvkhT4ZU2XOdV7rL+8IrBULk0CQk4nDmRsEYI
 0jtOSv6LTnobrs8j+WqFAZkq6Quk3f7+ncUMwxTjZkG83jxD7IlbDDvkxDrrUUg=
X-Google-Smtp-Source: AGHT+IGz+8hdBKR7sGzu3elHZqary+Y6b5fewA8o8SqTbSDDikuPcIiRF3pOskC2EyVx92wqw3AgYQ==
X-Received: by 2002:a5d:5341:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-37cfb8cf2c2mr156283f8f.22.1727799706411; 
 Tue, 01 Oct 2024 09:21:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd575dd04sm12099304f8f.114.2024.10.01.09.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:21:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A57375F714;
 Tue,  1 Oct 2024 17:21:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  Thomas Huth
 <thuth@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Phil =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: what is the right way for an avocado test to do "wait for text
 that doesn't end in newline" ?
In-Reply-To: <CAFEAcA8N8NoaPMKQN=_Ph1mmgE1DEn=7kDOuOVMUX4zBEaBmug@mail.gmail.com>
 (Peter Maydell's message of "Tue, 1 Oct 2024 13:43:47 +0100")
References: <CAFEAcA8N8NoaPMKQN=_Ph1mmgE1DEn=7kDOuOVMUX4zBEaBmug@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 01 Oct 2024 17:21:44 +0100
Message-ID: <875xqboktj.fsf@draig.linaro.org>
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

Peter Maydell <peter.maydell@linaro.org> writes:

> One common thing to want to do in an avocado test is log into
> the guest. The obvious way to do that would seem to be:
>
>          self.wait_for_console_pattern('login:')
>          exec_command(self, 'root')
>          self.wait_for_console_pattern('Password:')
>          exec_command(self, "passw0rd")
>
> This doesn't work; Thomas tells me that's because the
> wait_for_console_pattern function requires that the guest outputs
> a newline, but the 'login:' and 'Password:' prompt lines don't
> have a newline after them.
>
> What is the right way to do this common thing?

Well the easiest way (which I do on some of my test images) is to enable
autologin so you get a shell prompt at the start.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

