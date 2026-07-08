Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F972C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTvS-0003CH-IJ; Wed, 08 Jul 2026 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTvO-000370-Lu
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:10:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTvN-00057m-8Q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:10:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so4222785e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783523455; x=1784128255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xEybf6aAIrIJkGLruZDuk+pHRzKCkcWKr0A5tTc36BI=;
 b=U4wTgTGvA/zjHGbjy7vL6ymlSxIJcY/vOGitQaFZxezUwtJPvyJqymatLjuiaznvMK
 dJRhUcTD40sfFseo6VUhu+jDVGltQx1CzDc7rW8fWzsYa5zETN/zkSd1d+E7ZLdZflFt
 yR6ctEg6Kb4B3EOehcuyhujeqBccGTzl8rcRaxc3LYaGyX4MDKrb9K2mV459qfrzNt0E
 4sPk7gsBxFgdJYUnK2xDA+QrhUMzjeouKnWqx8dxOwFsbe0YDsJLn0G7pj3T9QBLNfM4
 zMASqNgQYQjo2Iv5wSjX4Z1Tp20NctOzXjoJv2nQxDk2Ryjrgy05lKBgN02uNAcluEmY
 buVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783523455; x=1784128255;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xEybf6aAIrIJkGLruZDuk+pHRzKCkcWKr0A5tTc36BI=;
 b=qB1lWVPyilTQYTTLV2NlOG2vxSkaLJXHcuBVBoNjzkVyAbjnCFQN7vw1VQa8YsWFB7
 a9JIFV7STKsCq2LSGphJUlia559XHbLeq1/3oERIlHfjYPFq1zEgHhfa9ujAqVNnVVPY
 6GlAKysLprzkYxm50+2qWRYVE7fHF+NcnclrN5Aw6vKqwIQ/UrEKX3YwvxiFgwKImxbS
 oVlvGKiayjjeP9p48gUOlz+cLrccSuRDZ8sNSELkKjhU8J0+lEUOvbNv+wb/N2n81VLD
 izKLtq7sSTFmyurN1rlCANMn+/XdFoGTaSlrZodnRov4Ui1hfxGxQbfToCdhfi7KtR0R
 9jhw==
X-Gm-Message-State: AOJu0YwCVqlYJA4B5sXDhO30KjF59dE4kpUaMpdIMGTKcVSckOEnQaa6
 WJ/vlidEHBA3ZcO1azxIgzaE4CXGbLyxs/QpDetr/oUFe5uqt6Nspp45TvGpm+U4Mo+uCtVEhiD
 mZejNgjA=
X-Gm-Gg: AfdE7cmRfyNP1kUPPlMqydbAoByaGDse1Q6ocid40nvue3x0LfEfOGDZdkzKKmoNWbf
 XJjsIO3hCCVXbchBZ6kjGYT2cqUMsOMkUFcbgGXUCGT/qMQFfELRdAeeROPEC0kQp/NBK+ChAGk
 YmAMRJ9Keqno/aPEHiVKRJoTeORUR1eYPyydkY7z8HRbHLKmMLPPg0eiaWhGMVSGP4zPyivHMSX
 usGNX4u/xQ1T4dnSPSDDltjfmR5QiZnEfloql9KjIwCf2l3VtbgCDup1ArwTz3ExMGsqhzvkBu9
 DINyMkg8ihMq5mz5/Rh+7+672iFef4KHjUKfId2w+9tqeXhbOEiazX04qj6gQsSSpe7iOUZH2gm
 HrmcBAbujEmz/TbnohB2qNV+GAG8JkQs53nyh1JUcvddKNdDJc469GI0Pk/yQ3zIfLaNPtcwX8r
 H3nprHG5VsZIqf
X-Received: by 2002:a05:600c:8b8a:b0:492:e5a5:5a46 with SMTP id
 5b1f17b1804b1-493e6875f48mr33026095e9.35.1783523455531; 
 Wed, 08 Jul 2026 08:10:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f294a6sm272251465e9.1.2026.07.08.08.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:10:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D528C5F8F3;
 Wed, 08 Jul 2026 16:10:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Marco Liebel <quic_mliebel@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,  Sid Manning
 <sidneym@quicinc.com>,  Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>,  Marco Liebel
 <marco.liebel@oss.qualcomm.com>,  Matheus Tavares Bernardino
 <matheus.bernardino@oss.qualcomm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] contrib/gitdm: Update Qualcomm entries
In-Reply-To: <20260707153003.58914-1-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 7 Jul 2026 17:30:03
 +0200")
References: <20260707153003.58914-1-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 08 Jul 2026 16:10:53 +0100
Message-ID: <87o6ghtt36.fsf@draig.linaro.org>
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Add an entry for Qualcomm Technologies, Inc.,
> include previous quicinc.com contributions.

Queued to gitdm/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

