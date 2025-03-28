Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC79AC3600C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFxL-0002yG-Hu; Fri, 28 Mar 2025 16:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tyFxH-0002x2-1i
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tyFxE-0007rv-QB
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so2283016f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192323; x=1743797123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwY4WJryALHSQoXzXfLC9JfmzrSmGh7ppOY/ir+1Mdk=;
 b=BY5WXnI6noQvR+piRfg+v2SVUIFtrdvqlIwHQS5JkUo1dmbbPtj9WYh/KuFmhc+0rC
 GKg0kyQj7+y9XMDF40eAbGjV+TjS7eFwU/oQTe6cv0EnshJP30QuOe2Ett4434X6KbLp
 vEVCDCmX7U5XBAVKMWpRVRJOzzWr4QCzSCKRV8E+KJVp27S8WMtVaIzcW+6aNJRlqbUx
 mBreGl+KnrCjHggwlrGiZhYEXeKCwiZtXvJs7tQxkrW71W4GP7mGeuqHEQFOwaalvpXF
 RTf5bzH9h5a2fIx7TVDaS8V2fBHo0YEU0HKlNIdOCCtsF6HMjRK14D1ZHzk2rly0P7DB
 m5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192323; x=1743797123;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VwY4WJryALHSQoXzXfLC9JfmzrSmGh7ppOY/ir+1Mdk=;
 b=gWLqHO61RHQ8jNJVzVAmyZHuX565ysFCU6CBaBp2Fmm6Tl8nZDc9TtwTRd7zgsPhRz
 P7onKBoIwrEbhbRG6t30BS8IfEMk8BXA1Uqhxz32vyqZ3gpkFenjayluwPnFzM9cc8bF
 qN8krJ0yJmJhxnCfO5KtMmgrei+3hhSrYams9OnOYG9yNxIP98sONE03Ui1KjYKWmbzA
 gBL0Li1Eond6vJT0v+6E64pq+Jn3lwy7EoToHeEJGnQRd39PllzXQiHPu5hELQU04jke
 HYaSPm1xKpzyAuWLV3Csu2Wv5WDv15I5tIff+h8xpIDo74OnNKd4wI2l2TO3EFIp7t/7
 GrAg==
X-Gm-Message-State: AOJu0YzD8QDmZWoK62gjx7Cavg18MV11H23mQsR9lc3lfKhPX4WQBcER
 GNeI+ow/cedDZqEO8bJcUk5dqiivxyv+7i6ZOkmFfp31s7m+EszHnIL29aU52hU=
X-Gm-Gg: ASbGncttP/9biKa/CcsPOTkhJtyFs+ed5pru8iclHRSzRGGjqkZzAP6YwiIl0Ta+zrD
 U5ruFvuLJ6jTvYIQlppJMHcSzPvx1etEuGuhZrWb0fYtSfe37im58JCabNI+dRJsBgoQSC+nZY/
 jCqyqBThBcTarYYALrHPPQc5UuAh1Q+ZC+upqqh2xLwlUSX4PWCga4exBAqORKZXKqnSa3FFzip
 IUljqjVzOcEXQEU33wKCfX0UGCFmJkIvJYAyVJnELyn1yBSMtKCWM3754eNmzC5X0jyfK+uAdkW
 X5dblAauViVmhbeX/1CcoC1WjgbOhjR9GEQ99Ja/xPZi2Ic=
X-Google-Smtp-Source: AGHT+IE9/eiT5Qwo6vJg1Tzqi0CiIbqcA1+ZKfMH8S5v2cQMwj5Y/PA4nr+13qs/+Cb/jXPIY/+fSw==
X-Received: by 2002:a05:6000:4282:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-39c12097a74mr512017f8f.0.1743192322654; 
 Fri, 28 Mar 2025 13:05:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b5dsm3518993f8f.3.2025.03.28.13.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36F9A5F839;
 Fri, 28 Mar 2025 20:05:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 berrange@redhat.com,  peter.maydell@linaro.org,  qemu-arm@nongnu.org,
 thuth@redhat.com
Subject: Re: [PATCH] tests/functional/test_aarch64_rme_virt: fix sporadic
 failure
In-Reply-To: <20250328183816.2687925-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Fri, 28 Mar 2025 11:38:16 -0700")
References: <20250328183816.2687925-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 28 Mar 2025 20:05:20 +0000
Message-ID: <877c482a67.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This test was randomly failing on our CI, and on dev machines,
> especially with QEMU debug builds.
>
> From the information collected, it's related to an implementation choice
> in edk2 QEMU virt support. The workaround is to disable KASLR, to avoid
> accessing protected memory.
> Note: this is *not* needed for the similar test_aarch64_rme_sbsaref.
>
> More information is available on the associated GitLab issue.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2823
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/functional/test_aarch64_rme_virt.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional=
/test_aarch64_rme_virt.py
> index f4ad4d33d58..a1abf584f0e 100755
> --- a/tests/functional/test_aarch64_rme_virt.py
> +++ b/tests/functional/test_aarch64_rme_virt.py
> @@ -87,7 +87,9 @@ def test_aarch64_rme_virt(self):
>          self.vm.add_args('-fsdev', f'local,security_model=3Dnone,path=3D=
{rme_stack},id=3Dshr0')
>          self.vm.add_args('-device', 'virtio-net-pci,netdev=3Dnet0')
>          self.vm.add_args('-netdev', 'user,id=3Dnet0')
> -        self.vm.add_args('-append', 'root=3D/dev/vda')
> +        # We need to add nokaslr to avoid triggering this sporadic bug:
> +        # https://gitlab.com/qemu-project/qemu/-/issues/2823
> +        self.vm.add_args('-append', 'root=3D/dev/vda nokaslr')
>=20=20
>          self.vm.launch()
>          # Wait for host VM boot to complete.
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

