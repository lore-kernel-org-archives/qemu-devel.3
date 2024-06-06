Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398BBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9nJ-0007uf-HS; Thu, 06 Jun 2024 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9nF-0007uF-Ri
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:52:25 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9nB-000290-UC
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:52:24 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a68c8b90c85so92986766b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717667538; x=1718272338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MlQZejaBOjE1uqizk4CojgeYwkdk7jkyDKqIm2GJIgE=;
 b=eLrcEeS8kn5Ln4hLQLEoP5H8nCzIgjH6Ean7Lmz8uL8J4tKS2jgDzKKyVEww/CDFNG
 BrRkk1ZfXr0RsJO0rh3TXUhviE+GlmAP6uk4BlY+vo8TucmmPMOm8gR94kQ42RsCCz7E
 9UnBOpmZaK3+0hA9kThDPDVKKJ85Jp4QVJ4bAJ0+Jr83UCrfVTMtEIsd5MUMfru63uvg
 DN3h16OcB9E3EpeXn2++ASq35SrLO7tz83JvoF098sylX6v9oUgUFtgfSm94UoQW4jlN
 KXDUzibNM2UdK1bU9G/ELbKY1e0NmkKdIZFMaqAN3JeVtd+dGhCJ4kI09+LlXLAVO4r7
 o6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667538; x=1718272338;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlQZejaBOjE1uqizk4CojgeYwkdk7jkyDKqIm2GJIgE=;
 b=abFdy32mVuGlOwN1lKEHQsV+nqp8qA0iL0bepskpMiT5xmOaGvEwEcltZ1c/ZrpIDR
 7ESzfxlikt6oNe+k0RiM1n7c9GUHk/aetX5M7KPeLE+l/BGlKS0PiffaHTslC0s4oyho
 SxMsyBBHqOQOpJRvf880yOMjL9rm1yIqKYP41QSQ3BVhzyJ0YhkZ4Jbg6dhYOvFplQD8
 CwD38c3SCacU6cMWQZ/d9LRTqy9vUbQRuZqz8uaxnRZaNWACdcidUANd8oqZ/cfuSlfu
 KMxhbpzkTtyiuBG9KKnneQz2oJQ2fDB3QtZ5Q09tHimIdZCIpzv1Jv9xzWvAsw3geSh/
 LyQQ==
X-Gm-Message-State: AOJu0YxPud2AbNcmOweH62EKxPPRgsWQZOSnjwjhM3ZiC22igJosjV+c
 MbHCXlC45aGDVY38UMK8vlFicpA/FUGUrym9bSMiPR7Ft/+L4359YxT5lAUe9NM=
X-Google-Smtp-Source: AGHT+IGobA2wGKw5ZmInwzU+RuCY9SE71aM0GARvy85XVp+VI18spfVO6jTXoP90iULfoUdaIKFO5A==
X-Received: by 2002:a17:906:2b9b:b0:a59:b02a:90da with SMTP id
 a640c23a62f3a-a69a002af78mr391285366b.68.1717667538571; 
 Thu, 06 Jun 2024 02:52:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805c96d9sm72985166b.52.2024.06.06.02.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:52:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A3B505F7AD;
 Thu,  6 Jun 2024 10:52:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 7/9] target/i386: Implement TCGCPUOps for plugin
 register reads
In-Reply-To: <20240606032926.83599-8-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 20:29:24 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-8-richard.henderson@linaro.org>
Date: Thu, 06 Jun 2024 10:52:17 +0100
Message-ID: <87tti6l7ou.fsf@draig.linaro.org>
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

