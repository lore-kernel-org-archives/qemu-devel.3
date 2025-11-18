Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222B2CED620
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLMUo-0001GO-Hv; Tue, 18 Nov 2025 09:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLMUc-0001FR-OQ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:15:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLMUb-0005Kq-9V
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:15:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so39870785e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763475334; x=1764080134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPPN/SgsEjpRIAMOospb5gUQsRigfozNLCPEAbnVMvQ=;
 b=Q1vuGf6WJ2ljkpdErKCWPthUqrImIWaOdEa1kfc97PmMXxA21sESKx87EeARMzunl7
 4L22zsneUaQj25gs/OyKWdNCUPDuUBetlcdwlgy4P4xKvCEMpgW2NxCepsuWXtDRhu8e
 P4boyiUr1SPjzwylpg5xHWvYb95qbspaCel+u9skPob4/Y0ethNdLZJX3iv1GanRiGfB
 pJm+Pjaht9+tA8WZ908w47pXBL9Y1m10MkYHUMBGv8Ywi19pvrORDPeIDOMwTG6dnRQ8
 YTzwUKkx2fDGI1eJtj9uQzjvT+eW/O8FwV4Gs4/CY+HrFP9iYUtQx/f/2tUlPZkFnFY7
 KGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763475334; x=1764080134;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XPPN/SgsEjpRIAMOospb5gUQsRigfozNLCPEAbnVMvQ=;
 b=rmn91bb9KdrHI8DIdodOE5IHn/W1vrbogOal6Sf9VrZ4IgwNP/+lIIpkcU9+BIjT7M
 vvUeY9rzOHr5I2Lc+WDsrEzo9AIJoNeudYjoLar71KedDRhi/31se2l7/XQbHoskg4Ux
 a3Dn2tBVqKYwFFGbRICEcNHGhfitnV5Pi0zzFuEnckyouRxeYDQ3ei8R1MarZ/CMgvfc
 IezJlsCuXEVXNrky8+RESD+P5qjIcO3O5vg9Lqo1Zq7ide9o2oUeh0/6UGtzCoHqxjth
 Rn5d6Jzyt3acszRGZNEzXD5litsqEU7AFiQlIXtvaOV6BUnvgB3DltdH2YCaAIHXWuOQ
 qZyw==
X-Gm-Message-State: AOJu0YwsW3QQGl8htPpeNagcpujagFrRDSB923PH/Y9CzReLOGgQi5Yu
 a7uCTBI7DlYAjwUZuAZo/vM9QENVFUeanDPS2EKLhaFSer0jJmzbd7LedifwQwy9OKzrVLEqzYD
 XD6sl
X-Gm-Gg: ASbGncsVAEV9E5q9zKLO8m7VNpTczRViNuhLzppFSQfLJbmeMeC7CaT02EowT6ixqMB
 nv7OUubeo6mQQvjyMaANKgf/B62NFdOtXstNtKqiyr7TTnQRcwumcqldR3hXmTt8G7pswUA4UR7
 qL2L/MB9noFQYmn4ZPImBo1j64hJMtLr+o2+sRDzP1eRRu7H4ry0Auilif+dqQVKnJ7fpfNF9ja
 W2xYzl1VvAgxkoGNgodhDRwGmE7N7Z2GPvqzqMl2re86ApI/2fGSi9RCvWMmrwADgxXxn7lEzHx
 P4oU/eyHCdGDNq9vqbPZ+0twSOM7d9Vhikl0duoMr1Wpxyp3t0TdTKPKAmCbAB2QYqH0olxlBx6
 9RxdmpqI7Uf9/M3TMAfX4ddynOEWBvxa5WcMBg49ra0SwOL+HokAbtcS2ijiu9ogXF9pS4j1Dxm
 AX
X-Google-Smtp-Source: AGHT+IFxlSc7MCGcLUufoC/g7tVpjVj67sl51StVUmmGHhhJlzgMW6tvAZQBiNP1zsIT2hQnbSgm7g==
X-Received: by 2002:a7b:cc92:0:b0:477:a977:b8a7 with SMTP id
 5b1f17b1804b1-477a977b94amr20577275e9.19.1763475332861; 
 Tue, 18 Nov 2025 06:15:32 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a973dbabsm19989995e9.3.2025.11.18.06.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:15:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B29F5F886;
 Tue, 18 Nov 2025 14:15:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com
Subject: Re: [PATCH v2 2/3] mtest2make: add dependencies to the
 "speed-qualified" suite
In-Reply-To: <20251118102942.551194-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 18 Nov 2025 11:29:41 +0100")
References: <20251118102942.551194-1-pbonzini@redhat.com>
 <20251118102942.551194-3-pbonzini@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 18 Nov 2025 14:15:31 +0000
Message-ID: <87tsyrjukc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Thorough tests may have more dependencies than faster ones.
> Dependencies are now looked up based on the suites being
> executed, not on the suites passed as goals to the makefile.
> Therefore, it is possible to limit dependencies to the
> speeds that need them.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  scripts/mtest2make.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index 891037e1d66..692e4867ec7 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -59,13 +59,13 @@ def process_tests(test, targets, suites):
>              s =3D s.split(':')[1]
>              if s =3D=3D 'slow' or s =3D=3D 'thorough':
>                  continue
> +        suites[s].deps.update(deps)
>          if s.endswith('-slow'):
>              s =3D s[:-5]
>              suites[s].speeds.append('slow')
>          if s.endswith('-thorough'):
>              s =3D s[:-9]
>              suites[s].speeds.append('thorough')
> -        suites[s].deps.update(deps)
>=20=20
>  def emit_prolog(suites, prefix):
>      all_targets =3D ' '.join((f'{prefix}-{k}' for k in suites.keys()))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

