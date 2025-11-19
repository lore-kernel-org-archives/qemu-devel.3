Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB0ECF3959
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 16:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLl91-0006w5-IK; Wed, 19 Nov 2025 11:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLl8v-0006v6-3e
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 11:34:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLl8s-0002A7-HU
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 11:34:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so30566195e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763570088; x=1764174888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZ2nkAraUhOcSrDswA8/AWsqV/sLM9Y4J+LHDSuAEJ4=;
 b=Y3f4R+nCb9RmoKer8iJUn29cqu1PSaz5yu9IKinxDwlXU2q3oajnCwKFhfG1rnVRi+
 PpdgZXYTEKG70XuNsuujHRCoj0ikGm531u1hCtbLZPJqNa/dZ3B56Ezji7L0XIGLMF3R
 uSQIBIvpNA1W+cEBVIxjL0nTBjgyRS3iE5NOS3V/8oNMvaUTWoht6VZjLdAxaSZP52yO
 LvVwG1Q/klE3GBIEc+cLkmX30Yd506RRW6JbFKpiZqDwPi3R4o4yESpWz7IgvKhnCORT
 5N4LTjEkl98Xbl3zbQiV3/znplUYpemu87+UtOsKdADdm2eor4p+dsXnjFEtLqIH5cbt
 OgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763570088; x=1764174888;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZ2nkAraUhOcSrDswA8/AWsqV/sLM9Y4J+LHDSuAEJ4=;
 b=HmcVPO9RsQ06FoP/cK9YZn7y/3ChJJZYK3casrfBNPtIhwC+wfLXsZQPSvWeM5eWDs
 I2XXH08MVuAcR796rla1lu4BcRqSYFbzEeZu84Keg2OMMsv8mq0oMEM9n9okrqftPA2V
 gM48+Gjh6ky0FdMQsGSI3ytLpNj9RKB7JX3n/SqcdhQb/BW+v9rYGEHGfwEOOWPrPMLg
 EXI9F+yOPRk+ZFb19/jSVHFK3S4BQrOFyEhI1ONqABAT42WHJN/NcIxEi7/5c0PlsnKn
 GC1XBAAZYCIn8ZOYqthPyoBhKbEJv+zdJ3s9tDVM0a01kPJu9kvrgRP1Pi6JwVjemQLO
 MVtw==
X-Gm-Message-State: AOJu0YxAchMPo4PO8Hvh8qpzQbdrIRwE76mrVglQ89nfIfwmV2SaWpTR
 Io/XPpKCQQ8wV/LZ0kn/1LmFUwss+jzYwGMrHBzOROpZl2yJudsUIhibCz7OQ31+dub1d0iB2x/
 7/J9b
X-Gm-Gg: ASbGnctV93wWiSkbr4WTHgsi5D3wD39ACqaNG3o6gKUNpglnQvFr1JEJ+hsuCocSBRz
 nN2jeLvxie+lSQJgkEK60lB4U5ltXaPI8Zi8hl0wF4lCw81RmsotitBeetQYUdKZpVJx8H51qji
 Fv+eAnCaHhdQw0N6rRbkHGMZ2Tz+fB79yn5YPg2Y8msxWFSZ4zQWk/hIUd5KBjSDaarAipmUmKL
 Fxuc9FyyDicKBOJ4y7hqhaP+n9iowQX8DXbzro7aMjFgjJeEvGne0+taRWFosptXvvAbO40Mq18
 Mcl6IyEwHtu0ryTrE9Gi+cEcse8fHL2HwN1GWhBPag8BeOXh2Ijc+HPFij2MRBY0tQlkYW0CLsn
 EAbYKiUYE7nrI74tPTm4/0TaC8kaPR1zW/ea2s2WdaOUjKbPywbD5ucpew/B7re4msAjJRcett9
 0qafZzXzkZ4qYkrhc6nECqYw==
X-Google-Smtp-Source: AGHT+IFUwZH1ncl45ey1UxUI9+2ef93KGQM1QATLQcDxJCYHaV/7xD0QWMBaIZQDWl91joQqfz+D3Q==
X-Received: by 2002:a05:600c:468f:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-477b0b8505cmr41322065e9.17.1763570087865; 
 Wed, 19 Nov 2025 08:34:47 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1041defsm55041935e9.15.2025.11.19.08.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 08:34:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A6DB5F7DD;
 Wed, 19 Nov 2025 16:34:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Kohler <jon@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Tejus GK
 <tejus.gk@nutanix.com>,  Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Subject: Re: [PATCH 7/9] contrib/gitdm: add mapping for Nutanix
In-Reply-To: <B70EE8D5-E859-42DC-B9E3-BF95BA21993F@nutanix.com> (Jon Kohler's
 message of "Wed, 19 Nov 2025 14:14:54 +0000")
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-8-alex.bennee@linaro.org>
 <B70EE8D5-E859-42DC-B9E3-BF95BA21993F@nutanix.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Wed, 19 Nov 2025 16:34:46 +0000
Message-ID: <871pluj80p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Jon Kohler <jon@nutanix.com> writes:

>> On Nov 19, 2025, at 6:39=E2=80=AFAM, Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>>=20
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>=20
>> |-------------------------------------------------------------------!
>>=20
>> We have a number of hackers from Nutanix, make sure they are grouped
>> together.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Manish Mishra <manish.mishra@nutanix.com>
>
> Note: Manish is no longer with Nutanix at this time.

No worries, the Cc list just was to catch someone attention with the
domain in their email ;-)
>
> Neat! Thank you - Jon
>
> Reviewed-by: Jon Kohler <jon@nutanix.com>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

