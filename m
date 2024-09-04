Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A466CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 13:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpvK-0004T3-Tl; Wed, 04 Sep 2024 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slpvJ-0004My-6G
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:19:49 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slpvH-000601-Iw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:19:48 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a867a564911so776409766b.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725455985; x=1726060785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbBu4b6+elmCiHAaLmfEHxHal9ntRwgddOfReecfq6o=;
 b=uEm8L1SqRkVP67YYE1iQ3ZhQAih2aY/Ph4ZABMbYlZdkeLCG53TO6vQny2CSTLE3Yq
 cw+1sYU9iLUAO3rL6RVCHpxlwAjPkhn5rGgSZWkA+HBtVxj7VvR48JIbUWNc6tmS1z//
 fYFYYN3x77C0ELHn9KfHN67ZC3wOEWQAuF1kQS/IJrbmlB++62RcOhcIbWJUEiGA2y8x
 zbhdcsCZaLSCvHXvGnPiz9kl50lbvZwP9ggqOF639frQrKY/tGI3AvsJubjtdkdZOPvR
 rdiYOUfSJfFHJgRykdU+ELrHO+Fk0Pq+qNHKiBjeJNWnu7DBJy7XEoI3zPkinDkHDlzW
 TEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725455985; x=1726060785;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vbBu4b6+elmCiHAaLmfEHxHal9ntRwgddOfReecfq6o=;
 b=C79Y+YOiQAEPq+rpjPm+PWnj/z5ZOd5e5AvgLUVt3WKhoJiPZVVRPj6XJCFjrt44Vw
 AJefaQXRYIkAP32QmSBKpoL3T25iwNsB8lPLrxzVrCx57OXe4LKJH3wQbwWAyaFOaKTu
 BGoa4hUM+QiCmi8tiyirrCPJgaHN5RFe2PVZN8cjzEPvOtBBrreUVAwqCxS9Nzy08GPo
 VdN8XlBxtdmPR+xYh1k+1OFOZeYXIoUPFdxDa6cN9NsaZBp4cp339SlfIHzr6IwEcaxh
 Ry11CD1BxsZz2X5HdmJY0vDFddnMesCssSQFT9PvazgTNjUEIkxTJyCU39qraYkrEfYH
 MD2A==
X-Gm-Message-State: AOJu0YwH3QXou3W/rzpCVuFWu6s2Iyl3KvDUujLMAS6sD2bkmjd8uUjf
 W6ks6qkgi273IjwsCba9rVqcWyO0ZpcEkmYHb56Aj/u8b2mzqGWC4On+XhryF9M=
X-Google-Smtp-Source: AGHT+IHQSFz8Mqk2D4VyXoLLFB9q64aEMYBaBPB9O2fpw19Zmpy01E2H5LzQ/zjHJI6IPeIwyv4ErQ==
X-Received: by 2002:a17:907:868c:b0:a72:5470:1d6a with SMTP id
 a640c23a62f3a-a89b956d186mr1109939066b.35.1725455983919; 
 Wed, 04 Sep 2024 06:19:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89892231c4sm799713066b.221.2024.09.04.06.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 06:19:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B1DB5FA1C;
 Wed,  4 Sep 2024 14:19:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v7 6/6] tests/tcg/multiarch: add test for plugin memory
 access
In-Reply-To: <24794f87-bbe7-4cdc-9370-3d593fd819a3@linaro.org> (Pierrick
 Bouvier's message of "Fri, 30 Aug 2024 12:08:48 -0700")
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <20240724194708.1843704-7-pierrick.bouvier@linaro.org>
 <87jzfz3dlf.fsf@draig.linaro.org>
 <24794f87-bbe7-4cdc-9370-3d593fd819a3@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 04 Sep 2024 14:19:42 +0100
Message-ID: <87wmjrtv2p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 8/29/24 02:03, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
<snip>
>>> diff --git a/tests/tcg/multiarch/check-plugin-mem-access.sh b/tests/tcg=
/multiarch/check-plugin-mem-access.sh
>>> new file mode 100755
>>> index 00000000000..909606943bb
>>> --- /dev/null
>>> +++ b/tests/tcg/multiarch/check-plugin-mem-access.sh
>>> @@ -0,0 +1,30 @@
>>> +#!/usr/bin/env bash
>>> +
>>> +set -euo pipefail
>>> +
>>> +die()
>>> +{
>>> +    echo "$@" 1>&2
>>> +    exit 1
>>> +}
>>> +
>>> +check()
>>> +{
>>> +    file=3D$1
>>> +    pattern=3D$2
>>> +    grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found=
 in $file"
>>> +}
>>> +
>>> +[ $# -eq 1 ] || die "usage: plugin_out_file"
>>> +
>>> +plugin_out=3D$1
>>> +
>>> +expected()
>>> +{
>>> +    ./test-plugin-mem-access ||
>>> +        die "running test-plugin-mem-access executable failed"
>> I'm confused by this. We seem to be running the test again and this
>> is
>> going to fail if binfmt_misc isn't setup (which we don't assume for
>> running the TCG tests).
>>=20
>
> The test stdout is the expected output to grep. This is to avoid avoid
> an "expected file" and a "source file" somewhere else.

Is this really such an issue. For the system mode test I just did:

  run-plugin-memory-with-libmem.so: 		\
          CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIARCH_SYSTEM_SRC)/validate-me=
mory-counts.py $@.out

> Could we use compiled qemu-user to run it instead?

Yes - although that would be inefficient (and you need to pass that path
in somehow anyway)

> I'm trying to find a solution where "expected" is not duplicated
> between several files.

Move it all into python?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

