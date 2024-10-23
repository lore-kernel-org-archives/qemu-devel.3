Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B876D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XBN-00074o-Br; Wed, 23 Oct 2024 04:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3XBK-00074T-Vj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:57:31 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3XBI-0000B8-QE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:57:30 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0cee600aso813741166b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729673847; x=1730278647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eu9HNFhzHWeZ50qGe67KBPhEI+rp9HKwcRfZHlrfZvE=;
 b=srM9wbe5mlkaJYiDh8prFYS7fy3/3Cfk5QzzDG0QIwMxnfUwRuPffSQweSO755d4fC
 r/SN/0E3Kot4Ai9ocdLpGO9TOqDUXy0y1JDdH2jCgzh9Xm25TlzOxoicAuwGAHFvaV/o
 3bPZ32rqSJksbffLDzOJt7ApzvJF9auYUAmGA4HLsax4Y6Rp0tZizamnlLT2VtBAs+ji
 D5am0EJV0Yyug9/msB1mjhLQTNuCV2TKsfUpyk0gv1b53GSPk9eYpAuO5YnsMY//PXH3
 lHK/uiysW7+FICRVWUre1y2R5IM4FiTyH0HifnMXZpIxUV2HVOP1zJoMrvZmUaqR4Bjw
 VPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729673847; x=1730278647;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eu9HNFhzHWeZ50qGe67KBPhEI+rp9HKwcRfZHlrfZvE=;
 b=mf5v8w0X1payCwXXkHXeh2BcDEfJw3GBq6HEhf+h3BB6W0RV7ehxeGFjFkGsDoGd5A
 FWIbRJ4JYYsqX2IO6JPacACvW435LyRWln/dXuq4EEBSQJRgYrLcpWnE0CJlOLBtfagT
 S1viNH43mUQlf4m04ShquvKwOcXWOJj4cExA87cW7q4uerobtsNKqO3qruxMSgBvoCDH
 QJkzdhY/3pQPfHZlIW1hysl5O0MLvAkSpUVFJ9GcDzl04gGDOwI3T823POLTYPzN2RZU
 Qvc7iuRvS0EYBo0FzehRS+vD6KqwWX/iHbWcXirCSTQhx9EnBXBWQWPAR5Vtl585O1EB
 44Ew==
X-Gm-Message-State: AOJu0YzuczOsgAaRtNDj5ebSGgtfopJH52507rMIUevra/SMKy+r7oPm
 h33DvFn2dCnabQnYkaR4yu7aRAsIvQQ+pomK/2jOwJya+XF388y4BhetonipfhQ=
X-Google-Smtp-Source: AGHT+IEkbd1iXj9Aj2fc5MX0hN+gYpbHOqjyyYU3Qnv4GxuUq7DNedPP9W0UoyidBwlVqvNsEo9Fjw==
X-Received: by 2002:a17:906:478c:b0:a9a:3ca0:d55a with SMTP id
 a640c23a62f3a-a9abf9ae37emr157756266b.57.1729673846839; 
 Wed, 23 Oct 2024 01:57:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d638fsm448745966b.18.2024.10.23.01.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 01:57:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 665CA5F89C;
 Wed, 23 Oct 2024 09:57:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Beraldo Leal <bleal@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Yanan Wang <wangyanan55@huawei.com>,  Thomas
 Huth <thuth@redhat.com>,  John Snow <jsnow@redhat.com>,  =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org,  Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Riku Voipio <riku.voipio@iki.fi>,  Zhao
 Liu <zhao1.liu@intel.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/20] meson: build contrib/plugins with meson
In-Reply-To: <fe33c996-3241-4706-9ac1-85f00cb8f388@linaro.org> (Pierrick
 Bouvier's message of "Wed, 23 Oct 2024 00:51:32 -0700")
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-19-alex.bennee@linaro.org>
 <fe33c996-3241-4706-9ac1-85f00cb8f388@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 09:57:25 +0100
Message-ID: <87sesnkxhm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

> On 10/22/24 03:56, Alex Benn=C3=A9e wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Tried to unify this meson.build with tests/tcg/plugins/meson.build
>> but
>> the resulting modules are not output in the right directory.
>> Originally proposed by Anton Kochkov, thank you!
>> Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Message-Id: <20240925204845.390689-2-pierrick.bouvier@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   meson.build                 |  4 ++++
>>   contrib/plugins/meson.build | 23 +++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>   create mode 100644 contrib/plugins/meson.build
>> diff --git a/meson.build b/meson.build
>> index bdd67a2d6d..3ea03c451b 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3678,6 +3678,10 @@ subdir('accel')
>>   subdir('plugins')
>>   subdir('ebpf')
>>   +if 'CONFIG_TCG' in config_all_accel
>> +  subdir('contrib/plugins')
>> +endif
>> +
>>   common_user_inc =3D []
>>     subdir('common-user')
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> new file mode 100644
>> index 0000000000..a0e026d25e
>> --- /dev/null
>> +++ b/contrib/plugins/meson.build
>> @@ -0,0 +1,23 @@
>> +t =3D []
>> +if get_option('plugins')
>> +  foreach i : ['cache', 'drcov', 'execlog', 'hotblocks', 'hotpages', 'h=
owvec',
>> +               'hwprofile', 'ips', 'lockstep', 'stoptrigger']
>
> lockstep does not build under Windows (it uses sockets), so it should
> be conditionnally not built on this platform.
> @Alex, if you feel like modifying this, you can. If not, you can drop
> the meson build patches from this series to not block it.

I'll drop from the PR and let you re-submit.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

