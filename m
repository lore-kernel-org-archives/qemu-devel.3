Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923C8C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhS01-0000M5-Kk; Tue, 05 Mar 2024 05:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhRzq-0000EI-Pg
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:26:08 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhRzn-0002Ry-8J
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:26:06 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412eced6d1aso3092395e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 02:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709634361; x=1710239161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7E2GTSB8Zju8NT8XoAqhhgxVYaqC6EeA5A/XxJgFLZg=;
 b=LbvzAyuqGlII27srZPjjfYuAWZjOX6a75eE/nO3RlY4ZReNKxDTdNaC8eICjFyX5Nh
 pP1isvdyzQZC7tqWYsdCwAxtNKav6GusY9BwRNe2Slp4s/6YzZmyEcBm2xeUQDesmEYR
 Sy1qXKHffqbI1TD0AeOwkIqIeylkcozZsrjelQoNdN0fowSG3c0t/Dfd4+aXur2BNSiJ
 h/8zFVSn6UkNwrWHgWFoKwWeZ9UCAEFVZinnOdFR3ehpIwJyiXgA8dhvo0Vomd9Di9tW
 x7qonB5n4kHgvAREUgs34kts/uIJR/zW4YSMocmtabzVYp3MRFIahxg8XBKK+K4rZjqJ
 FPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709634361; x=1710239161;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7E2GTSB8Zju8NT8XoAqhhgxVYaqC6EeA5A/XxJgFLZg=;
 b=Fvep3e1A3YZszU7T93nKrXVsfiK4XIXKk1D1mjxN7Vw4IBndp27auWSGcszTPOaQGy
 gYjo9hEhRGGywMRtElzxUccNnjdSIJ1+Fe5wmL+0wEQ2NJpcL3p5QBt1MToFxKsLuJmI
 xqQF4GQu1WL5CBC7xqrJW/R+AZdUzQQAUvCucZcjkuZLabYUyRlXA+HgfnUV2Y7aUMPE
 1Wffh2xg3UPJGPAuNcd3CEEgdnxXKCzef0orMIF4hRC44v9WjQ1qbFPjrLjA06z1GwAe
 1msEydqu4xd9Gfw9k3AIPYMR5QpjiuvXIaq4eAhxS3Ia1BdmtEuQMLNfgzFUch+lemA+
 PH9g==
X-Gm-Message-State: AOJu0YxKsu7Lb0BipQQUhrd1Qlhiw9G6ZgrU7n+uTIPpg7Ux248IX03Z
 Aqz6TuXGQ6w1WY2ONz2Lp0YJBaYsCT6v72fDGkNhZmNwNJWGXrstOgBGTHtHRJkWh72MOmoPh8g
 h
X-Google-Smtp-Source: AGHT+IGNSgZ41PRTgPLfwt6d3pN2SQ6CogAkInlhDqo3aPFUdrdctz7yabSt7ksBxB1qCzmJJ9Mcgw==
X-Received: by 2002:a05:600c:518d:b0:412:f007:63c9 with SMTP id
 fa13-20020a05600c518d00b00412f00763c9mr102242wmb.30.1709634360905; 
 Tue, 05 Mar 2024 02:26:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05600016ce00b0033e25e970c2sm9909131wrf.88.2024.03.05.02.26.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 02:26:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3863C5F892
 for <qemu-devel@nongnu.org>; Tue,  5 Mar 2024 10:26:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: KVM/QEMU Community Call 5th March Agenda Items
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 05 Mar 2024 10:26:00 +0000
Message-ID: <87edcpvutj.fsf@draig.linaro.org>
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
  5/3/2024 14:00 UTC

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

