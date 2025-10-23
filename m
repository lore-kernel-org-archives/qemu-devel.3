Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2430CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 20:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC1yO-0007qr-1C; Thu, 23 Oct 2025 16:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vC1yL-0007qQ-9P
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 16:31:45 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vC1yJ-0002UA-KB
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 16:31:45 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d2f5c0e8eso270564066b.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761251501; x=1761856301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+IKGgL+cXaIH6YcZSPFCQd5D0/2SIkY/v91pCZE2q4=;
 b=U1pu+Qn4wnw/WlOzsyGMiD+26PVy6k3qPOt9/rliGAh/sIX1h49P7igVO53fLDtQAR
 YsICTYRuubO8f7CNLjGuOf1acGY51c9GrpAWZCXX5w5Q6jsQ8BozLRmRrLv+anFiJ4Ll
 YAhHzRMldUanSCKhsJpkI8Ta8T2tmGXPzyAfhTj9NeeavPxW/jcPpD/5K1+OWmcoWO/q
 ZPO/dHlVgq07FB28ub3M+GEIzTHDi2asmimP0y8QLR5TMVeZqYRpWPm7RsTSAurPgAbi
 vFayw8eHAXpLPNL0CCupU+ICHOAJOzmfOzb1xMuYXDHMvWvLVx18NW6bDaEPAKK36Mm+
 k9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761251501; x=1761856301;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t+IKGgL+cXaIH6YcZSPFCQd5D0/2SIkY/v91pCZE2q4=;
 b=QKCof1lCj3WDgjmfGllEN2uNznu9ZzC4a9N5BSRcjohjMz+WYcKVXVLuaVuDeg/fcu
 5wAiruUEepjuJ1MCTuDajsvqmTOrJwm6EOnK24eLx0Qp7D4QepeefuHm+IYOzeukuwF3
 wF2B9izdlfV4anZjmd8IlL8sP0CppmtVKZCyAh4cfkFUbVdCeaAAbVlz9M9w26P50064
 tYPLF/gx7fW5vvqDLATHIIlrc0d+VA6EWPy2Sc+BZ3CtkjBCZtFoLp/NN+CXB2V6lH39
 T/FwZZjiXtPyMdKNUs/ijSYJsm70L014ZpS5IYW3Jj1M0MgTUbUrUtaQkMi0odrKAao7
 Qgvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3WZVvrAg22wxPz71Q8lueRiNglPpwXgK2PJjw8Rw1YjXbN8NVpUWw5OKT6clQIGwCBGV9o+XRuHuD@nongnu.org
X-Gm-Message-State: AOJu0YxuA/q94aimInjBIQtfZIxcyMjVC3Gukgpk2t8D6Mi+WC6/Ctfl
 hiwofCZx85r7RhLuIzRuWZttcue3jHICcoTtQkCa09hkm+xPu93tcXR0qXiE1TkS3Ns8khxDG8g
 Xh30PAtw=
X-Gm-Gg: ASbGncsXUJGr6ixXldg0axe+jfoJLJ7SGI7o7k9yHOelYQcGbTOw5lTx4uTSKPhJnMU
 /RoVWLixY6nzKyVhJE8KnUq8g8qtp2nPNyU+PT3klKFeNl8pG6fwEJkD+TW7qlWUkBIlsWNdODD
 /RJ+70xRtODTfo4WZT5Se/03XzSCyxKWcQjXmUZH/A+8FFbhA9E8/rPsL+B9mqYIgz+ma+A6M+x
 YrQqIN0zXB5/hzaD/lKHNXONSUbFC7rZupXsSrgSMwcV4AypTOjsocfMCQP4hfapL03AJpj1TS0
 nM9vJZMoMZPjaodvZ/CdKKGKmqbV9aoZ15BpKtR4k6/hl6LU4eWpODlCbD8ex6YPshd8x/wXfPz
 fVBsjlwO8rH2pxruxE7vFeE9B5wlu2bNJ2bo9EvDaloMOS3J48lZwO+hJbgo/5zQKgKEiT57qdJ
 f7ihAS7CNlCEA=
X-Google-Smtp-Source: AGHT+IFFMRmS9+5P3kqM504/u2J+A1NKivD2aDYRQIMgbLJtB95+tjNjzNS6Z1HtbCJByfPX+JTrJQ==
X-Received: by 2002:a17:907:3f98:b0:b40:6d68:349a with SMTP id
 a640c23a62f3a-b6d51bfb148mr407889666b.39.1761251500725; 
 Thu, 23 Oct 2025 13:31:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d51417143sm318878466b.42.2025.10.23.13.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 13:31:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5327F5F825;
 Thu, 23 Oct 2025 21:31:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: AWS CI Oddities
In-Reply-To: <d98deec4-c95a-434c-9ef4-d7a0fd41a42b@linaro.org> (Richard
 Henderson's message of "Thu, 23 Oct 2025 14:03:07 -0500")
References: <d98deec4-c95a-434c-9ef4-d7a0fd41a42b@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 23 Oct 2025 21:31:39 +0100
Message-ID: <87tszpl5qs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> https://gitlab.com/qemu-project/qemu/-/jobs/11827686852#L1010
>
> ERROR: Job failed (system failure): pod
> "gitlab-runner/runner-o82plkzob-project-11167699-concurrent-9-ther90lx"
> is disrupted: reason "EvictionByEvictionAPI", message "Eviction API:
> evicting"
>
>
> So.. if I'm guessing correctly, the job is doing fine, 28 minutes in
> to a 1 hour timeout, when it gets kicked off the machine?
>
> This has happened a few times the the last week or two.  Is there any
> way to fix this?

Is this because we are using spot priced AWS resources? Is our CI
workload a low priority as is job?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

