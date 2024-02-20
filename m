Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658D9C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcOnJ-0007Mh-Hd; Tue, 20 Feb 2024 07:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcOnH-0007MQ-SW
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:00:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcOnG-0008WD-1M
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:00:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41270cbef8eso1693605e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708430411; x=1709035211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6XEXRsswOYgDdQr4i7Bva1/OwHDXGzyO8UfoMj/465k=;
 b=wMgOgOkM0Xk/GI3bw2E5u7ih08nME4KQqe0vDnB1SBNnbCACdG2YkBd8esgGXd6cLa
 f1MQ4ZsdVGttnzAzxyRucdm9IWsfBnjeXliR6WHvhVmknYn915+H2l46TEn8WOPZ8MoL
 2uZihzvK1joyLe/msbOEjh58pL7/9v0KOJNzVp5GnxYTB5TSl1RvwECdKpPMJ6QNIWYu
 H9d6rz+ay+BEvbTnEAuSpEqIYhkckPgNVbn8zjcrwTB2Z1TEnKw+Ey96eJMuC3RUXqe3
 rdNNQ3LUNXIhUBON1oD0PzLCuGn1bWDZQ3PJ6+CVxqXwalGQ6iP86Z6mokl4A+5l6equ
 1ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708430411; x=1709035211;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XEXRsswOYgDdQr4i7Bva1/OwHDXGzyO8UfoMj/465k=;
 b=u1feBmknwDG6npxJT2mZZuMlWoovmjVFrMTeOY4BNFX3q/cbUfDR63bz4M1YWKZPD/
 i90+zkWL/inDRxv5lQ6EVFxAlb3slD3Ib7zsq3QjYcKE8J1Gk2UvGTvOoWQdiE+FMh7s
 x5WBIvHg9+qQqWG6Cm2W0jFQI7/MummlVHwKCyEaEDaSz8bNgKBMPr0Hr9QpZA5lKXwn
 92V3X+uBolCOzk62VjFe2AA73XGWzA1tWleK9yYFZhSYGUjxAEyCQ0+s1PJqNhKCH5+p
 7rrgEuw3ci/1XsUcndMuBG13dhBjVlxjXGXW+HO+NGQq8f7bq6pmNjiKCIECMsMPRrSb
 MYpg==
X-Gm-Message-State: AOJu0YxwIODDTwWo8Qj4EfQUMsX64Ib9GZE7dB9+QUFqk3aMceQ1tLbH
 QA3lQM9Ws4NPdVCQbeG14VEiWuc93UX+VcTCBoUBXthNhyckxQ/HXHjoh/oImGhXbzoBuZhuoJb
 b
X-Google-Smtp-Source: AGHT+IHsmO9VBu9FFZIVekfxSggJzVznO/f25GhdgwwvoGC6oYR7/uEzl56dLIamnMbsgJO4dnvjNA==
X-Received: by 2002:a05:600c:4503:b0:411:ae8e:5945 with SMTP id
 t3-20020a05600c450300b00411ae8e5945mr10709089wmo.36.1708430411236; 
 Tue, 20 Feb 2024 04:00:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k35-20020a05600c1ca300b00412393ddac2sm14830475wms.6.2024.02.20.04.00.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 04:00:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A06B35F8B9
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:00:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: KVM/QEMU Community Call 20th Feb Agenda Items
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 12:00:10 +0000
Message-ID: <87ttm3cpmd.fsf@draig.linaro.org>
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


The KVM/QEMU community call is at:

  https://meet.jit.si/kvmcallmeeting
  @
  20/2/2024 14:00 UTC

Are there any agenda items for the sync-up?

I maintain the invite on our Linaro project calendar here:

  https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMWd2=
dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDAyMjBUMTQwMDAwWiBjX2s1cDJscGd2YnB0ZGl=
ya3U1c2kwMWJsbW5rQGc&tmsrc=3Dc_k5p2lpgvbptdirku5si01blmnk%40group.calendar.=
google.com&scp=3DALL

If you want to be added to the invite list let me know and you can get
spammed by your calendar app as well ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

