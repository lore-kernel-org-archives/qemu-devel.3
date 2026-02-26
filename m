Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2A9FD8FE0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vveiu-0000sE-U8; Thu, 26 Feb 2026 12:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vveik-0000rS-2o
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:00:14 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vveih-0006VU-8n
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:00:13 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65f9763e8d1so2416477a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772125209; x=1772730009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBuUFvcmhE991ryP8Kr1P2g448wAv4g7tcPs8O0sdD8=;
 b=sYq1aw+P0wIrd73tKxW8+7zIY+lxJQgRBDHx8jXSTCaQOmW73ZbksEh5CBP6lRp1++
 8Oy8CsloAhRtHTmRO5YNgRzQES3Yza3tzuF8bKl3bmhovZXM5pabEqeQ8R/GX7BKCITx
 1DXcIHDz+J+8yFI7ibQJYi8sz1Z54Y7GTbAOVGD7jPMoEfxicTHov5jsywQXtjjxgcLD
 k6BKYxkL3jfIFPfGVkKw/5kpqaDiqFQ6NffAL1hE6/xZ6HwYmQBxfP/rdq4jGD5Su//o
 vXAfdixssTmmpb/aSMr3OUzf8qY5NFUoiOkcHSTm/DzmUWfqDLGeVCS3ehry52xrhKLX
 ugRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772125209; x=1772730009;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EBuUFvcmhE991ryP8Kr1P2g448wAv4g7tcPs8O0sdD8=;
 b=oPchlixIMZeMGr5qFt3o/7C3WslCQxVZX7C9lIDUiQPz9T/C4eYwu19sAIB01DNu/Y
 HyU6Xu47EHWeL7FXs0+sXJj42aFEna+T8qmpaoE4HNtbChR0GuZ6z/AXPpzE5G5lkw2s
 NN2x8HSrWKSUjAH/QWX4oLF9dWMgqTHySlQbVu03I3c0fCGLGcsYETBYVHpwaPto67mh
 pQIZhV8RZvr24pGWQi8+ZAMWepkz3pwiwpIkPTVRfZF4MBxc5LqwKRyeA83DAjYkUa+v
 WXeZyawsQB6OAxfgR9uaOQFdyw2ELMbnIFPFsU2FJgpztzUV+eBqr6klSfevmCgr0P+k
 iQWw==
X-Gm-Message-State: AOJu0Yzu8I82qkJkBNXVSrMAJpjh3MaLG8/iSuGXiqQid86CIyIwGyx6
 wSgmBIsgnk+BUCublNuuB1Jt73kU35Rl/5Xq3wlYi1Qx9wLOBgsOMRjLOWZFhpAoA8A=
X-Gm-Gg: ATEYQzw47dKi5ihZQ0uz4R8/1i0eP2uqB2HNL5A8uDxO0CjHlfBxsR6ImOzLnCPL0Xq
 a8QlAsT6MJulilqODWS55hoxUlGTTAIbLU5L32jJIqsL9AmNut7CkTbf9WAhIs8JaDuax2Hkx49
 ORIBo4Am1z6IX0eiwzTzuvlXWAm3yjCvZP9doPDXTSFa5VK6ZHHz0NGPD//Waei8q5k4QGQaN05
 AKXEpvOUq3iQZZW0C9H/JbIKajlANvmc8QezL1JiNHLrVnFx/F7cEUAgPuyOVPjzvExg+0EDkyw
 38yYm9vG8Da7nB+zERSVITSNTkV5+eGIgZK0HjXiftMulexng5IofWHicECR6rLPMKa92jy1keW
 p27rozSy5RbgviCfrDTXrQgfZnnQheW1NzpJ8AeMuC7c5+bN2G8ahJkV69Wb9gsBXzp3d3BTkWY
 XffLD1sGm9HGBAnxEi6jkKfMM=
X-Received: by 2002:a05:6402:2110:b0:65c:5a7b:bd99 with SMTP id
 4fb4d7f45d1cf-65fb6e904e3mr1764465a12.31.1772125208950; 
 Thu, 26 Feb 2026 09:00:08 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6d0fbsm683914a12.20.2026.02.26.09.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 09:00:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EA445F802;
 Thu, 26 Feb 2026 17:00:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 1/3] tests: upgrade most non-lcitool debian tests to
 debian 13
In-Reply-To: <20260225193856.959771-2-jsnow@redhat.com> (John Snow's message
 of "Wed, 25 Feb 2026 14:38:54 -0500")
References: <20260225193856.959771-1-jsnow@redhat.com>
 <20260225193856.959771-2-jsnow@redhat.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 26 Feb 2026 17:00:06 +0000
Message-ID: <87a4wvzbhl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

John Snow <jsnow@redhat.com> writes:

> Debian 11 was EOL in 2024, and Debian 12 will be EOL this June. This
> patch moves all but one of our tests, debian-legacy-test-cross, onto
> Debian 13.
>
> This patch does the bare minimum to upgrade these tests and doesn't make
> any attempt at optimization or cleanup that may or may not be possible
> with this upgrade.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

