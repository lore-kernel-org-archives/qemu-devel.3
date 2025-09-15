Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D7ACAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy67g-0007aY-K1; Mon, 15 Sep 2025 06:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy67d-0007Zp-Sx
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy67Q-00066c-Ne
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45f2a69d876so7358025e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757930840; x=1758535640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WndymZA4HVXt6LIz7FmHpmeuzG3wCd/8zjNhhzjcMZk=;
 b=RFUvNGSWIix/WG0B8+EF4gHeyvRlaRjWG/Ao+VmOCz+UpN+KdZ3BW9wzx45/cZuC7x
 3aCbCEfOe/curFFwuW9qdAdxFgy6xhrzMSMQf9tcie1M4aYmp+U3RSx1RdeYDPM+KNYW
 HXozgl0obAa5ugivxJFvmGhpDRCi2jPP/+XBk6c1IqsWk+sX9xTAl+hQ7BfrvX5hViVU
 sMnue+3Hs4+6LUPPBTJB9nY/c3EwlGIF/UiwTj/90VxM0ugGSWfTxmBzkJYcpoDaVYOD
 1yDMBhoPHiBeFAwRrc/1XcmoipLnTrhgEU9Jr/Xw9TFAk3orWl8GQ9uMzltz6mymEleN
 cu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757930840; x=1758535640;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WndymZA4HVXt6LIz7FmHpmeuzG3wCd/8zjNhhzjcMZk=;
 b=pjA+CxePCOFHvpZfn+TitUlRMeGrjFvdBZF6BopYrTfAd2w3NT+6r0enSj7HjzPIEh
 L4Guzu0tocOn0hMdRzLIec0oVv5qgemYdFcKLe2DxOH8AHf0ZmP9j2TE4qbKrNB85we7
 hJZl87O5j1QgqPP3QBSg586cI0mVQsKAgK89e9gN17hlrCYsG8T6pItGE6Fim4d2bCeD
 BXwG3Ps7h2qUUOEifBcaykbV0K53H9d6QLQFgq5xgUsZwa6ooavSOybl6EQt8ay7F5sQ
 Me98sZV2XQdWswK9h0HWsNSh8MMusXz4lQg/QtsnzVh1hXybTbCmiWZANRYU5bPtpApv
 86Yw==
X-Gm-Message-State: AOJu0YzdMHg/vH/0qSvz5wyuJ/KF7kt3EKB2Xc7a5vHynrnKGFGMn8n8
 psCVNVsDez0VHljMfGLv8I36gOB4yvS8olSn0GEOBjfFo8dGQzzUWJlmdTULis0orNNvvUki+e7
 39l7yjZ0=
X-Gm-Gg: ASbGncsnFJrHWpZL+wC5Dho8Vx0HIYbwPRjwwRWqCyjAUdNm9sKpjuulhl2P4pVW4F5
 wvLe3YsxObBp+aHxnA4+jM8c/FiI2DeCqdm3G1gHiX05o2TvkFaA1LOXWE5jkfj9NiLW9Kj7rsv
 0YH6ybQZnGhgg23a7K31jsQPBgbDzVoZGwso0wqR7eNo0FGnwf2cLQXIfXCeOx2F7ZceAukNC5y
 qisgxjkMCnJEFO+DeVredR5Cg8K1t4+2vi6oKrO3hqjrkJWfBwxbzrpSBFrXj5OEAlSbr/RGZxp
 GEJFOvK7laL9NIi3CmBSCQxZCUa7EH0kAMqKCM7H4b28Okmcny6TnhCGO0690MecG9jEcEnmhts
 6EMtvFWC7qXDiXLfRkhpMNRIdSTSjiZ+nuA==
X-Google-Smtp-Source: AGHT+IHQH+hAD5E2m6ScHuOonE0VUIfe9/GYxVM7UCTXVKiPtCh/I4bZj+eqtOiq+nLMcSRh7FFRhQ==
X-Received: by 2002:a05:600c:5813:b0:45d:d96e:6176 with SMTP id
 5b1f17b1804b1-45f211fe9d2mr82011145e9.25.1757930840288; 
 Mon, 15 Sep 2025 03:07:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5a16sm174074845e9.12.2025.09.15.03.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:07:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 350E95F867;
 Mon, 15 Sep 2025 11:07:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/6] tests/functional: replace avocado process with
 subprocess
In-Reply-To: <20250912182200.643909-4-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:21:57
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-4-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:07:18 +0100
Message-ID: <87ecs8rpux.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The standard python subprocess.check_call method is better than
> avocado.utils.process as it doesn't require stuffing all args
> into a single string.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

