Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EB6CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8UR-0001Cx-E3; Wed, 13 May 2026 08:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wN8UH-000192-Nn
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wN8U5-00023M-Sv
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778674480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+uANK8ciqiINtN5gYWrAlkEpfIVlhaHzI4BCgEsGASc=;
 b=Th0lSAlkxF1pHCnSZd29dIC6JCDpNwetk6EdClOVp1rO2U2qQIhjlX7kwyPdg/o8wq/TCq
 NgjF33UyZw2c8xjrmkcKBA1QSCpprK5IWXIFnYq+8haBVJYfogTFEhu2LZQ6BFdIjIbeNQ
 O4VdOvzih/wm0VOieXbAg4/MlmS9Rko=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-KIv8BMg0M8u92NhYqCwNUA-1; Wed, 13 May 2026 08:14:33 -0400
X-MC-Unique: KIv8BMg0M8u92NhYqCwNUA-1
X-Mimecast-MFC-AGG-ID: KIv8BMg0M8u92NhYqCwNUA_1778674472
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4411a69f565so6089803f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778674472; x=1779279272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+uANK8ciqiINtN5gYWrAlkEpfIVlhaHzI4BCgEsGASc=;
 b=Glv973N8iECOldFuwxw6VtmfIdxiyrYwbIp0L/rq84C+eH64AEAKHGexyLC92ZmWpu
 Vbsd7WLgOcD9j3b2U/LGZKmrIo2ldTb82aK2YdUpe9y53Q5Eld7IS0pv8zLZuAjjRT1F
 67U4hL7BQYiBu6RWXCfHh/9SObTwB+gt0hM9BFpRAXyABb/n8krUw20rl7YDQT+y6pIS
 /9tckiPufw4BAxRC2XGvwiqu5GJ9pqyWu8zga45Xgpof7KOnQUzTaQeAQZd4UhOGL37S
 BHEug5/BjBxU68iL6duyg7+rSVweOSD5xMkgpbXiQCK+kTo1TsRQY/8ptSJnyGTN0iN4
 aKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778674472; x=1779279272;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uANK8ciqiINtN5gYWrAlkEpfIVlhaHzI4BCgEsGASc=;
 b=njxS36has98pwumZgbqpNjIq/Lxh4mlakyYBr+EAtVg8ENzzd51lcCe8WPq/pn5s/T
 xHAgiYf8RAiqz5T86590mztIGTD6EUt0B1szmfYQNSUSohVMDeMEVEpwsBKyRRbkNtxk
 j+cIk+vCNI5SIWtzKpXVYKpod2vysbOPIiSdocp0lbRHUPGTONAsyiqEEjShHN+vHVmQ
 AQ+gaH6m4VZzLJLV5tWJmhCtmOrPTXpp4J5pZolLm+S1z/ASxbPqCaX0jBTfjkxhJ/yX
 d4ADg9jVcHfs2ukRiCzjPAvrJNJ71bDkwNUXxfX4UNbvFIOHNBc8V/YbF/7vixIcpXxB
 ZvJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SV/CmibllkpWF7ABMU9gFxmRi1Raku+GaPsvPv1aDyLNKjcNeQqbo83S3BzCb8+nGBHrrZ2qsN769@nongnu.org
X-Gm-Message-State: AOJu0YwixzAjeF61wR9qSWM5vNKwRo39pMHE5Z4ugB5M90OxrXxBGMIi
 mx9hepe5p4jfllpdwcEPQGEeDbaPe3IeHH1lGIllBDUsP76C/47eExz9CSpv4QKjU6cjyyxOZyH
 Y6NkKM1Di3ZdonAcDzHjYthbU+jLJATr3f1GTK5dUW7KZExwQujTZ/7x5
X-Gm-Gg: Acq92OEwH9xS0PJK2L6SFlEdUfwIeYvnUGh9k8gMMd74PeYrjHF2e4h+9x5EodBGVSy
 tMV1dkF8R9fm7Uu5MaIoQ0KHZSqHEi9hp+mb9vJ+COeM2TxWfrn/WGWNr1KyhkngxsupGpYom3q
 6746Auw1U7K2QlXlc7P1GXEHKXkTi89OY08MQ+g6F9m3Y/GgbDv7aYR/9BUPzHhdXD6PMG6VJnL
 hXdc4pqH8WBHNLoDJ06wyeHHhm7/E9BrJajkPe0kO+JgbnLJCdEzXoiJW+uP/TKrhn6wWon9Q2o
 +dx8I7oQPd3yr93n1ddOUBk7iz7TIArPpGKkfFK9Cu66flMbKME5kMULzdfHj2xAnwn5DnFpvwv
 9Kp64cDESaoKCuPCEpw==
X-Received: by 2002:a05:6000:2401:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-45c7a7dc644mr4383356f8f.37.1778674472121; 
 Wed, 13 May 2026 05:14:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2401:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-45c7a7dc644mr4383303f8f.37.1778674471719; 
 Wed, 13 May 2026 05:14:31 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120f1f9sm41334559f8f.24.2026.05.13.05.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 05:14:30 -0700 (PDT)
Message-ID: <df489daa-bed3-4b33-b04b-59cc9ed33cec@redhat.com>
Date: Wed, 13 May 2026 14:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/16] tests/qemu-iotests: mark 185 as a flaky test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-15-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260513120003.226790-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/05/2026 14.00, Daniel P. Berrangé wrote:
> Introduce a "_flaky_test" function for I/O  tests which accepts a
> GitLab issue URL, and causes the I/O test to be skipped unless the
> $QEMU_TEST_FLAKY_TESTS environment variable is set.
> 
> This is used by test 185 which currently fails in GitLab CI for
> unknown reasons.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/185       |  1 +
>   tests/qemu-iotests/common.rc | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> index 17489fb91c..a62ae8d329 100755
> --- a/tests/qemu-iotests/185
> +++ b/tests/qemu-iotests/185
> @@ -50,6 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>   _supported_fmt qcow2
>   _supported_proto file
>   _supported_os Linux
> +_flaky_test https://gitlab.com/qemu-project/qemu/-/issues/3270
>   
>   size=$((64 * 1048576))
>   TEST_IMG="${TEST_IMG}.base" _make_test_img $size
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 731e4b2b99..298bc483e0 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -1088,5 +1088,21 @@ _qcow2_dump_header()
>       fi
>   }
>   
> +# This must be referenced after any _require_  lines, so that
> +# test filtering happens first
> +_flaky_test()
> +{
> +    if test -z "$1"
> +    then
> +	echo "A GitLab issue URL must be provided for a flaky test"
> +	exit 1
> +    fi
> +
> +    if test -z "$QEMU_TEST_FLAKY_TESTS"
> +    then
> +	_notrun "Test is flaky (see $1) and \$QEMU_TEST_FLAKY_TESTS is not set"
> +    fi
> +}
> +
>   # make sure this script returns success
>   true

Thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>


