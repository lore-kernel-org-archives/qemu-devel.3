Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23B6C982DF
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 20:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x81s1-0003JR-72; Sat, 19 Sep 2026 16:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x81rz-0003JF-J2
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:41:11 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x81rx-0001ch-Lx
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 16:41:11 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so1086857a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789850467; x=1790455267; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HCgTGktYuvqgNh8Ea96hkde/lMNNj6kLY+s6nRbT54o=;
 b=eXldj+uGMddDfr9Kd2mv2NbY2Aad5L7xROCSpY0V1/PiVPrjYba1wK2vp10OePXHuk
 wEWpY5l/3vjVuFLCgMA3i8hsNI9lGs4f6p4vwsJ+AxCKqX8PrvO+aT+pfbzWqS90k/8Z
 QJ4FaHuJWRs1sQ6P12Dk1f0396c+nyPKuAtQYYLFsxglxA43TdtvYy8O2vVjSO6/l/1C
 RgKOLoQHBu4D4mvSS6debma2j6O+JR6cd1S5Z7rq21LzCj+TPE0g399o/m6+D7EuaVId
 iKf6t3rigzg/RoSvxfvX+U16wAraPZ9Xr75Ulw2qd7BEtn9FGRfPX6qrraxb9OHauWwe
 IjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789850467; x=1790455267;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HCgTGktYuvqgNh8Ea96hkde/lMNNj6kLY+s6nRbT54o=;
 b=o8SUVhhf6I6nJryOj2oxW4gwistZZP0Ly7atOI6WAnR9WCA4dCTYSOySym/a1SdLKQ
 QwEz2qH3b9xOvAKSq1G3VSskm+EEiGFbCM/ZjcUmx+u9r9GGGQFSl9i0p7oNc1ImXmV1
 QUOd3FkkcWaAu9X2IZ/4VnD95GhbntbCNPcsQt0+SD3ksn8S1iZ3W55eZmDiFFaaqi6j
 Pc3hfz4ffEOFeVdhAUJXdrny+6Ntmuqov21imUqRuBFA4NH7ng/gf9l8wVas+mzzVq4W
 C2PWgWpctZdtnHzX3YMqaTrgrCGWeuJT+XcXRa6VLyLn1EUKK+ISs9YUaBU9IUWFOUyi
 1T2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBye535KSnwpy4kYtOlfFBr/SaVWZE7o7HJ6QXFfQZur3+ETZwxktmmNivYt7kTx7LpgD03ZUmknm6nw@nongnu.org
X-Gm-Message-State: AFuF++ljTW8GUz118VJM7qDT6BmF3Dm6VJBAFtkS6WVRzJBKYdeHcnXH
 f7kGqZbpEQLS6TGraOP8890NvGfqpKjvlfMb5RoiGtmBzkcYNu4m06ulq72WnQOGuz4=
X-Gm-Gg: AYBFou1i22ueEL++gCrzQqAcHpI3a4lOL4hVG8UBc/7daNQSjXjwn+b3gVQOnX3dJJ6
 VHteRfMI9ca4rH4rnPIVlPS+IQ9jzdUfsdtyvTeYMxheRK9qKbxAKhc2Jvj0JXYLkIXXlgKGdF+
 LgiQNBSm3gTdnvXtJMoAbZ6ic0V4WRBGIxc8hGScR7fQFCwkceqEuV8LOxZHcPmlWyhR6UzyhQw
 nxeaH9NYzniFd12ykcGOqFhFnpP6TSVFMCD+fA8N8rK8UE846lsWIEHzf6/7a5C9YCc4mFXPh63
 20uaCNqsZn0QoPRFKM0C8g520En8BuUI4zAho/rHiMEpHTDsnIwU4Rrk53sH48Mbw8QmbqUX+ks
 wefQMZ7jv2jC/XX3wat6oq2UIqBfwB9+sa7wYiVKW0t1MB89QQ48TRUcAlspdAMZphT1pC76pZJ
 SfN/wbaw2WxTbGeAOOL1njmUw4zcPJMx7cTijm3bxrpAiPMRSnGrep5zEygm1wOfsTQVcp1EqYi
 imwjwGXd94NpqotTYMpofWkHGEkmtaxDbuWUtla2oMcxnH92MlioGQgOPLffw==
X-Received: by 2002:a17:90b:4b87:b0:39e:6a7e:ee1c with SMTP id
 98e67ed59e1d1-39e6a7eef39mr4724345a91.40.1789850467332; 
 Sat, 19 Sep 2026 13:41:07 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:126b:fa43:b140:ff23?
 ([2603:800c:7900:ed00:126b:fa43:b140:ff23])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6ca50694sm6828205a91.2.2026.09.19.13.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 13:41:06 -0700 (PDT)
Message-ID: <daab8aff-94ab-47ca-b410-8907c3f00645@linaro.org>
Date: Sat, 19 Sep 2026 10:41:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] TCG tests final fixes for container builds
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/18/26 09:32, Pierrick Bouvier wrote:
> The following changes since commit e8dca265c91b45f4cde746e5094d7b763444eb6a:
> 
>    Merge tag 'pull-11.1-more-check-tcg-docker-meson-180926-1' ofhttps://gitlab.com/stsquad/qemu into staging (2026-09-18 07:52:24 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20260918
> 
> for you to fetch changes up to f115b35ed817df6ddbc96f47cc0a537ea76e545a:
> 
>    tests/docker/docker.py: do not add-current-user if $UID == 0 (2026-09-18 19:29:56 +0000)
> 
> ----------------------------------------------------------------
> - [PATCH 0/3] tests/tcg: fix more container issues (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260917221117.274619-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

