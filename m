Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE75D4A60A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeTu-0000xr-Sp; Fri, 16 Jan 2026 02:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeTs-0000ve-RR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeTr-0008Ra-4K
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768549370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6apU0W3/qZqsdU2jfr+ErDgYzVg8nO9i6OMfKCmDMQQ=;
 b=AsipQCcEobgHfP7mwMtRpyyb8NQbZHNYVxYBDCg257PjzYZ9yDAflhfwGhLJgJKB4+UL1u
 i7A0E+mMACkslAWq/5ZbYilElFRLBLT8TkJDp9ow/AhbMD9P7tkWyZwJm8GxJAwLwIO0iB
 gbVFseiBVbxD40ev3GjASONMA1cwLfA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-b5vJv4DGPZeApsUK-R7Smw-1; Fri, 16 Jan 2026 02:42:48 -0500
X-MC-Unique: b5vJv4DGPZeApsUK-R7Smw-1
X-Mimecast-MFC-AGG-ID: b5vJv4DGPZeApsUK-R7Smw_1768549367
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b870d3327baso183323766b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768549367; x=1769154167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6apU0W3/qZqsdU2jfr+ErDgYzVg8nO9i6OMfKCmDMQQ=;
 b=BoCGZoaY0p6RNjjnKexE0ZfSamK+Tql7ug+C0Lyso6haLcDM50fSBD0/2m+E1n3DbF
 EoVL/e0QtgynPk9ebSso6UEhXf3vwbaM2FfU2ClecnAfC5h0+GfM9r6egEfwTJNWJYB0
 rktOO9XrpYNVivk1vHBJTMVEhnFrO44SYWoV4NbDfZ5c6v12PPLS+18VyQpSWtvBV6HG
 ZyeF2WBPBMZIR92AJQCzIsKtV6/HzHi5RT0/mbbkcbDRSYMnnUfFz+E5keRvtvcjb6bz
 +7dQmwa3Ghh8ZF7kFPibRRjVlgo4zNv0h6smdXmFxL1NfuK66MfHAtj1oyeExMLS7Fy3
 f6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768549367; x=1769154167;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6apU0W3/qZqsdU2jfr+ErDgYzVg8nO9i6OMfKCmDMQQ=;
 b=TG8oB1AXJK0aSbftLBFuBsBTUpDdlPOy1WJL45T6GiURgvNOO2ExqY5ZJwwS+iDC4T
 qCqkeyr1UGH62d8cOETrACn0Pze+bGl5ol7WICBp81AEtt1wBqowGq/JfC6js0hFDjm4
 iKnJtXgmNDid+vohKjTUIvZgz3fBZgTD5UeiRGb1Nup9/G0drN3XdTx5ssjof2RSPNjF
 m1MVjLxyN2oQr0BU7EOZ86t0lon7+qpf40J3wLwPCNoBLGifec/X3aXnX3xfySmwtU9x
 iU5U11agUnEg8PDM/voUyEHpQBlvb/N3D7gbpXc+8f3E2TJRj0o1Y3gQuC88Lk5SPPO6
 +A9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBpjWlXwKYZRc2tyYzf389qb0RiWtaq0K0vdx5aOxwX58vYZtC3Jq76xl5AUXDonCrxyUT2E1MPfSN@nongnu.org
X-Gm-Message-State: AOJu0YxZBjEpN7D587rI+K+h6LtZ5xHFnzhVouSc1/uO6qX8wzqP6Afl
 gps9xZ8RF/8fNcmlKwRirqgQN6NetuufERVRTr2VN1L43DmSi9j4KjDpNdiKUNsOHWNu1TkWhrY
 iO76NGRlu7zSE7dmQM26tTyDFwiLzRcH2Zl1nWfxurmlzB3Q0sXmhidda
X-Gm-Gg: AY/fxX42kIyYAQLbkwujjV2B9Gvj3pprrqhi4vlszo30nfkS6cCk2Dc0JhTjM22PP/K
 6w2fPdbxVCYcPsmuBkiGg3q5o+OrMN2l+V5DCwoEVNYrLi7wDoRw3P/3j0jLcsrE453GgdnfJmc
 2WxQfeBwQRu+4WDA68NBdErk8Kn8JqaoVJeJhxYYyYh+LoK3tDPSMpWxhSKWXeh+wRzQ4LVzl2y
 ekjaQTfSDqvUqdyWkAd9/44c2gMXJEPF+08O3IwJsl7xfNbaF2eITMBY54CJnvqYHlZ8RiLc/KA
 fqsyG2/odykwtl9qusW6vNIaaRPoFXqkw6+4XJtrSop5cpZKc3KlKnmgLxGeoiRcbNDyyHyFh1W
 1Insj0Ms=
X-Received: by 2002:a17:907:f818:b0:b84:1fef:329f with SMTP id
 a640c23a62f3a-b8792e0f4bamr192123466b.26.1768549367258; 
 Thu, 15 Jan 2026 23:42:47 -0800 (PST)
X-Received: by 2002:a17:907:f818:b0:b84:1fef:329f with SMTP id
 a640c23a62f3a-b8792e0f4bamr192121566b.26.1768549366871; 
 Thu, 15 Jan 2026 23:42:46 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a2f1a3sm163767266b.62.2026.01.15.23.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:42:46 -0800 (PST)
Message-ID: <8b9e8961-b553-4163-b65e-752effef8c1e@redhat.com>
Date: Fri, 16 Jan 2026 08:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] tests: add nbd and luks to the I/O test suites
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>
References: <20260115164756.799402-1-berrange@redhat.com>
 <20260115164756.799402-10-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260115164756.799402-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/01/2026 17.47, Daniel P. Berrangé wrote:
> This introduces new suites for running I/O tests on NBD and LUKS
> drivers, giving new make targets
> 
>   * make check-block-luks
>   * make check-block-nbd
> 
> as well as adding their tests to 'make check-block SPEED=thorough'
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/devel/testing/main.rst    | 4 ++--
>   tests/qemu-iotests/meson.build | 4 +++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index dc4f7202a5..8067d0a3ed 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -233,8 +233,8 @@ to run. A slightly more comprehensive test plan can be run by defining
>   ``SPEED=slow``, which enables all tests for the ``qcow2`` and ``raw``
>   formats. The most comprehensive test plan can be run by defining
>   ``SPEED=thorough``, which enables all available tests for the formats
> -``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``, ``vhdx``,
> -``vmdk``, and ``vpc``.
> +``luks``, ``nbd``, ``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``,
> +``vhdx``, ``vmdk``, and ``vpc``.
>   
>   Each of formats also has its own dedicated make target, named
>   ``make check-block-$FORMAT`` which will run all available tests for
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 66b09d6b97..744d0b6e88 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -15,12 +15,14 @@ qemu_iotests_env = {'PYTHON': python.full_path()}
>   qemu_iotests_formats = {
>     'qcow2': 'quick',
>     'raw': 'slow',
> +  'luks': 'thorough',
> +  'nbd': 'thorough',
>     'parallels': 'thorough',
>     'qed': 'thorough',
>     'vdi': 'thorough',
>     'vhdx': 'thorough',
>     'vmdk': 'thorough',
> -  'vpc': 'thorough'
> +  'vpc': 'thorough',
>   }
>   
>   foreach k, v : emulators

Reviewed-by: Thomas Huth <thuth@redhat.com>


