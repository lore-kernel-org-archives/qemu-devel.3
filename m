Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C51ACDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcR67-0006Cs-4n; Wed, 24 Jun 2026 13:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcR62-0006C2-EW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:09:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcR60-0006Q0-Ui
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:09:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so536690f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782320943; x=1782925743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cq4M1VpcUT74H3Kh9aWtx+LbzLN/EflOjYaP9XjYBR8=;
 b=t4aGBK8fA/gTpQS8oSKNgoG+76/wzZ655nQNwtZe47trRPBIOYUcG/wpfVHoqbsr6k
 ik1r0YeQeCMyNRoLjF6j1OsU5lRthBN9oWYTQdq1mWE03I1gOOEhFyIfSxzHO7o0QeBy
 ExYqPqgxzaxYWg6qfOjl57+ZdbIujb2gQlKziIpHzyp/xYJ8ezQebYJzveY/MnjUcoz/
 fYCmMuUuj/xfk+h9yKZWzH9Sg195H4EjjspXd+UgONy9sC+Pjv0nLlctUm8qqcFvsnJo
 onAYu+retBwb46bwYlQUst7QmBHcEc4k2UAe65qUa3+eAzCmr+5Uu3O+lTBHy8y63KvQ
 7Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320943; x=1782925743;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cq4M1VpcUT74H3Kh9aWtx+LbzLN/EflOjYaP9XjYBR8=;
 b=YozILxzySSF+NVFxth/NxuufQvP6MhUquF7GZBHCspqGUgz6Rj1ZTCXqUCLeNwimBJ
 Tof8osiwSSSy0aUtrW83enqZamgJxIndoXsHcEzzGfV9Txw6LMetdzXbW6xroMU9asog
 VsorlepUdDRMiSqtUCpsQz94doswXhUIYGqGnLSJOhvFyPyTEKRaE7b2wSHKRSE6t0ZK
 QsN5Nsy0bfkrEhH6xGKdARvEAuX8JYP9Ebh6s7ltgkGmVpo5/XkfACt2WS96cGCWRSFa
 Q80MH89J//kDRmQLbCYmyKdaUe0OGly+Ie0o5ZO9L/eVLhMjHI78N+ZC4LLwk2WHpSqS
 Vz5g==
X-Gm-Message-State: AOJu0YyT+NdcewGss5xDbQf3wKcbDnxZYpwJ/uDIW5d87J+PBmJ4RfNF
 qRST6OA/X8F4rjNjBWvtTqo4IMccdY6VYkiK1JXt6IsBbU7cUZjeHj3wN8SitqSKSpjilh6nTXd
 8oJ07oFo=
X-Gm-Gg: AfdE7cl2WxAPfpHO2xscZaB7cElTmuRFnnYpamUaqqWrIeFyjcjRhbOLjbLegFE8dJ7
 UOFmCaxlxb2g3JKCX8ToNldDVolxzb1v4yhOF99ErUSK0OzAzIeMIW6FbXL4NhikrEPRDz/FnTz
 GQjlAdm4zY3vdpiUnfjgdEUcCX+gU3RmslqJGmvhpuOOUzO9OSuQwwKR/EggWRUQF9FT5Jlt+eI
 A7KpPykHMGQ1SDms7scU0liYkDSCmRnsxg72VVScUemjWn/72ATgJWGye1VXWuSdq1aCpH441g3
 sazqYriSwRa4RJ61GuwRPQUdp+DPBI8yiKksuOZNDJeWyais4VqU8mCux9z6P99I30mntHP+MQb
 qEr1GZJrnI4JHITFOHkJzqk8mFZ8MTymzKeTCkLAnkSW3DImAYt5xZgAxj9A8X6aebUZZHVyPe3
 yZSfdHahjV8hCTzyx9mVfqLTQ=
X-Received: by 2002:a05:6000:1e42:b0:46a:44e6:6f0f with SMTP id
 ffacd0b85a97d-46adb39b73dmr10349079f8f.35.1782320943367; 
 Wed, 24 Jun 2026 10:09:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c225b2988sm7859813f8f.25.2026.06.24.10.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:09:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 39AB65F807;
 Wed, 24 Jun 2026 18:09:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 2/6] target/arm/tcg: Allow vector FP conversions with
 FPRCVT
In-Reply-To: <20260624-jmac-fprcvt-v2-2-dc6cf8e512b6@linaro.org> (Jim
 MacArthur's message of "Wed, 24 Jun 2026 14:37:26 +0100")
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-2-dc6cf8e512b6@linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 18:09:01 +0100
Message-ID: <878q83kgr6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> FEAT_FPRCVT allows the vector forms of FCVTXX and [US]CVTF in streaming
> mode which would otherwise only be available in nonstreaming mode.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

