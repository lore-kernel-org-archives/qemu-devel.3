Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733FEC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6w31-0004Qn-RN; Wed, 16 Sep 2026 16:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6w2y-0004QP-0x
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:16:00 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6w2w-0000Oo-42
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:15:59 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf03so85759a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789589756; x=1790194556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WImQE9HG9jNDpws/IHnxznQT65cqjjh0HyOsZ8JIRr0=;
 b=LuzPOQf1LHRX4ilJAGBKvegfsAxg8m6YsmPQ/DTE3wWEXmiJpcDI2bEmpgfKM+q18Q
 n2C8pXH85IYcQov2kuM0Da2pxEHi/eInrdQL1z37SnesTeOix+IhiAUQk7Zjynlc3Kl5
 tJyEFTnGeoKoj8kLoS+4RcR2bRJ9Q5+yNPIT/N6fIRtccCDmLiqg5eDYEQOhDuB/M+oa
 bDaBlm35j5Jud8KMIGthW5dMEgy4+u5NckOhlV69Q/dXgXCrb2N/i04yvdZeOqbyGAcn
 ZpyCBGEl0BKJnWYWTbpGH47WiA1e3dx00bbA/U4+Nenc2HAYvSbexQFBhMI0TzY4Sfkq
 5zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789589756; x=1790194556;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WImQE9HG9jNDpws/IHnxznQT65cqjjh0HyOsZ8JIRr0=;
 b=moOvHOf7BC3A7+6TmCWsuDL+iG0XMOl3LE7h+EsLlNFY0ExkgQYNKTL5heQlDINlTd
 iDgevadIXAwcxJTqAfdMQ/P5roLsy4QNpZNuqwdZRJLL86eXg1fCEBUs611r+6SGppSt
 wWmF8fwrE7BaP/osrc1K/sxT8EYr43Db7YxiZBD26wbv1xHN4B//RYToOmIZj4Jb3a1I
 ZsPdSo+bx31qh3+PjraqzTxK7/odnj7nn8FvQVvgJg+y1G+M2d29V8Ey2+7+BQk8PL4f
 rhVcHDQVCNZSGvuWthlHkkPpRqL/LJ2f//GzxPnhl/onBwKdWKEccuznH4JIMZV79U0X
 pgxA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhbTCOMHAaFrlneaBYJ8zAs5T6ghCnNteBExgti4YjIgAB+2w3bGnS/TkWby3xG3PDLPLlrJqhC1MH@nongnu.org
X-Gm-Message-State: AFuF++k7gryqGK571FWRK6/vQlVcoZJtLSslJuf8PyQ8Ua0qKsJGbVmu
 Er9glOih5W7NcZyzS4rGUOnvDxTyoCmWWzMygb1HJmmfg6yyjn+7fbaYflHbdG0DYCk=
X-Gm-Gg: AYBFou1bcEerhF283OzPrc4ppmBQQhv5tl07AtC3qTf4S58wndJ/Kpjgzqe/h+wEJ7t
 M2a+CrKZxyHVOzrlord/+SX2O1OLNKD8dWv4llloDOwndFCt0NGwnbpus4gefkJaOl9cYNt1SRr
 0fTejeEhJWtX86rAnmPZZ4960TqsBqvkylQQ6Ng6DJ67jKDoBzr0fMH3jLP14WQUfpqLsnlwbkH
 EbV0Y6rsiJujI5ID26LB34IgrQPO+Jmq0htCustAz5IAgC2lju4MpJAEACBxeFqpqzR5g/2LvVI
 2NyxkOO8+s60yU7tZysPIsZ2LVmn3xORPcW7McauRiMUk/NGk7NknAJf9HKiRWd61eqQ7h/FaqU
 H6zqibhv10ahAZ2hOvn37HSJBjubvYKCqyLwQnrTq7kySh1FrwWh/IS61yXDod/BpsOEzfexzC9
 T3TUX4jP/F1MnESq63+uz+DORdyownQk1iX+ModvR85/gCJ+I+cxQoemzyOX9VuL8QXGBkEOpZF
 twBin1jO9GXowd6XmgabwBPw2utVbOaTurx6P8WUyS5KBxNf4vEc5NOcbk9gw==
X-Received: by 2002:a17:90b:548f:b0:39e:b7:cbea with SMTP id
 98e67ed59e1d1-39e1e4d1fdcmr9246022a91.18.1789589756270; 
 Wed, 16 Sep 2026 13:15:56 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:2521:7533:da60:6a28?
 ([2603:800c:7900:ed00:2521:7533:da60:6a28])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395cfb0b1sm7601274c88.5.2026.09.16.13.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 13:15:55 -0700 (PDT)
Message-ID: <2541e000-0bac-4a06-86f1-f286a2eec5ee@linaro.org>
Date: Wed, 16 Sep 2026 10:15:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] tests/tcg: prefix meson built docker tags with
 qemu/
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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

On 9/16/26 05:30, Alex Bennée wrote:
> With the meson changes we now build the images directly by calling
> docker.py. However the Makefile.include builds prefix all the images
> with qemu/:
> 
>    # General rule for building docker images.
>    docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>              $(call quiet-command,			\
>                    DOCKER_BUILDKIT=1 $(CONTAINER_COMMAND) build \
>                    $(if $(DOCKER_V),,--quiet)		\
>                    $(if $(NOCACHE),--no-cache,		\
>                            $(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
>                    --build-arg BUILDKIT_INLINE_CACHE=1 	\
>                    $(if $(NOUSER),,			\
>                            --build-arg USER=$(USER)	\
>                            --build-arg UID=$(UID))		\
>                    -t qemu/$* - < $< $(if $(DOCKER_V),,> /dev/null),\
>                    "BUILD", $*)
> 
> So to ensure we don't end up building every container twice make sure
> the naming conventions line up.
> 
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/tcg/meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

