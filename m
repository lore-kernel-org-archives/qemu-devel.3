Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88357E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 09:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIlpt-0007av-Pv; Wed, 04 Dec 2024 04:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIlpr-0007aL-16
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:38:19 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIlpo-0007Fq-Ti
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:38:18 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e2c52c21so2825197f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 01:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733305093; x=1733909893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKXTe39m9Xo25dEwnbfKd6UTjrI60vtBDK2a08V1/+I=;
 b=tbZPK1nRKqPIsI7stVdXBy6DMp2gg3/Tz2lyRVvyNGm9gdCH4bjB3F0hHJjY7wjEH3
 mAqAIaj255MLEa1ettBFsweGgeFoLAf7bPtfsiUYCdw9zDV2qjiZupWeb8ONDwtAjRi5
 BqHq9Innu7nxhWtiEAWxNBanj2b7tOunDlafvY241W9qfXzxieJLXpvr0qJ+eZVrHU+h
 qBivOsoHwEix+PsdroS0L7boqYWgtdmjhQgJc6OYHAhpL3aDTwaperGP0nsKXVnHeNKC
 a4EpIo/ZPclXl5lUZfJe1/+Ofl8tablSgV5ARxKm4JK9rPo4jiz99nelq0fDqRM8YVrJ
 4OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733305093; x=1733909893;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AKXTe39m9Xo25dEwnbfKd6UTjrI60vtBDK2a08V1/+I=;
 b=NqhlJrN9ay5hw/7KbP4rMIQPcr586zLE12LYWkaCqWqNcTxti5xBS8oOOZpWWFxt1r
 eGR80sCmEUhaCeonea7ucDejH4mobQKJMuT+P7t3yzfq1sDMh3EPJ8trADsLvDHshmOT
 Auz9doUD1kTFcHXwzZzlW/FyH2Q5099IKeX4Qtrqprao1TepvRRoqWXVu4z8+SRJndyA
 WUYlRtgmpUokjbVb5TY/3pdAl/8+l5VRdIzP2afieKqACbqau6t4MFydJqac4L307hji
 mAqnHtw5z1QFNoqxBbZLfd0qQapDVeT4TG/9IeGprOINHxpBfvb+73svQdR8ftPDoOjH
 mcSA==
X-Gm-Message-State: AOJu0YzCRxUEnOR3OkTxDMDEGMF+jgwYpGH7WkRMWS7dysr04BIkkrRQ
 PdiJRRZ5L3dcoEFnpztHGbv1gqB9F1UISxqNPaaay6xhiKQ9lavq7SkQbLUBkDs=
X-Gm-Gg: ASbGncssoKkpkyOOiViidXZvKD6Jt6gkw8CWFny4MZ2vt3demwD6tKJWosiHpWH00aS
 KZAg0GyWbYtjxXv8g3jy0QEJt+G6hm4dCK5ti1VDzRa4RyKHh1+rvc1Oj6cfutZ1xYAjEvl9NFj
 HA9Pli33j/BMG/7/zb6Re8jRreLxkAROBQBpoGw5k6K3LlnXTgk/hWIu7qjrC+/D49jtzdvrpu8
 HUXEmN3Rsv0x8TH5xShBuUL7QoYcLw6FvYxuyuPwtgAZZ6a
X-Google-Smtp-Source: AGHT+IElkqDtR98CNeevNusnSti9ZlzlJLle4We06NRDw3S8ewEBWPZhuB/WF9Qgmce9P6yVqf6GCg==
X-Received: by 2002:a05:6000:2488:b0:385:f98f:2cc4 with SMTP id
 ffacd0b85a97d-385fd53ecffmr5239842f8f.44.1733305093444; 
 Wed, 04 Dec 2024 01:38:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e3cbe250sm12296071f8f.94.2024.12.04.01.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 01:38:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E55DD5F897;
 Wed,  4 Dec 2024 09:38:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  mathieu.poirier@linaro.org,
 jean-philippe@linaro.org,  marcin.juszkiewicz@linaro.org,
 gustavo.romero@linaro.org
Subject: Re: [PATCH v4] tests/functional/aarch64: add tests for FEAT_RME
In-Reply-To: <20241203213629.2482806-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 3 Dec 2024 13:36:29 -0800")
References: <20241203213629.2482806-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 04 Dec 2024 09:38:11 +0000
Message-ID: <87frn3bxfg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This boot an OP-TEE environment, and launch a nested guest VM inside it
> using the Realms feature. We do it for virt and sbsa-ref platforms.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

