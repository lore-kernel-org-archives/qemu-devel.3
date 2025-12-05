Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E64D374A1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 20:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRcpX-0003x9-33; Fri, 05 Dec 2025 15:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRcpR-0003wQ-2r
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:55:04 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRcpO-0005Ph-T7
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:55:00 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3f13043e2fdso999519fac.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764968097; x=1765572897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=feD3rNZOfVpbNZylBVnBLNXKS+B3PzlitU3gZGLcwZ0=;
 b=v/fBqxyQVy/M8FSPqWc/0NG/OzTcr/v1HHjMswnckURyVlFKxwf6U6W4vDU4W7N4r1
 p2/lhODgv+JucJv6IyjvkkY90tAWmFWjvQdcRcL83pgoQZsnNNZ5YlUTnQU3tdttcMAB
 RvURciu4KdFILen9wzRopFXBy/R1cfhyb5ptVu81O+ENvB+mDfz0AOPT/UG1Gp67tCvc
 G7z4cxy9DJpzww95wlMbIkQ1UeaeuQbgiDC5Llc6C6yL8yqBdew40PO62iq+fb2qG51K
 C4y5ap+gDmGcfDE1QecvJ7jd63s8tphQtsBLv2LiAju+hRaS53JqkESrP6qymMIZWhri
 F0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764968097; x=1765572897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=feD3rNZOfVpbNZylBVnBLNXKS+B3PzlitU3gZGLcwZ0=;
 b=r1MQn+G1opPG6K8frSws66dnfGitodmFKF/Ly5pbUidyMLfEvKdu2Kdokeo7B3Ecp3
 Ry+WCUIO0Zgm2LSxxaAarCUAT17Ngjaj8UuhQWSdqy6a23tkqzOzgQA0QlWcvao+G0ww
 osWiymqfR/WnbBrpP+gUMC6rIvPeq/pEH5iXeASBDacjy1OxGdr4T14RUvb6QxVx960z
 auDHCE/BHY+rl9IJC+ElA8pLAgIcmI+AnRrpJ99W0bDoY8aF+HCOhEpqqIUwbBjgOXQe
 eVS0nC5snAVchiHfenp6E/s9Zofz9LN5eFngLYiPf6DEh2Li+k1Djv8QXLUmUSNkJPdN
 P0Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiGRLu7K+JcMkTrqj4Ti0us3OVeuGfi1F2uVcVy6TPeF7KmIDHJsAeetHYpvaz7SmmRsoNUUmDpYRI@nongnu.org
X-Gm-Message-State: AOJu0YxpuE0tK+xk8ViSZ+YoEaib+YmM691m0vVj9yM6/9YHbR+eHvR2
 /BudhsCzCxtzAjceJ9qK8tmdZL/D9vrbfc40U3QhxCQqCVpfLrGBbnsY5nlAave7j30=
X-Gm-Gg: ASbGnctCqmdjWjHaGmUHugyNFZiNh56OrwquKuApu1CrTtJkBpmzS3OBY/rxy0wHLId
 oAE6UTRVsZb1l2jn+HVNyj/MLOr95Z2wfdCHq8QmPnObFGgdhOTKup536uheNsuiUhmW23si6Nj
 qZmGKXHSTpHFPYaKgMtpZmMry/T2ojpVND2cQQ/n/SsoqsfOedUKs+a92oToJEg0TYwdAB3Sf25
 QHp2Je7/vz0rtoEQ6WwSiDWjB0JYkq/Y8o5IRGaALHCtma58lfb+5CdsVxSq68vLTpcf+B5IWmj
 o6JzNPE6HJ3FFU7YonyTgCgYlIEAiqr2eIv/kdoDijc+YGY6TY3v6ehIhZ4CZHNJl0yWoP/sdLK
 y8ffe/ZwqL1Y9TFiTa3sVpfRnoNs2167jFhFsXMbZssTnr8rfdxOvzcpDCS7WdpvJtwLpcUZ9ep
 ta59VONlhf+phHFm2CBkFcBl/52jVkvJMfhWOPX29EE5sdjlCvGanvwk/7fe1J7FmI
X-Google-Smtp-Source: AGHT+IG+ggC2S/WTz2H8N2RZv+47IOtKjN3MobWt6UIYS9emqDMpMrSHjExk1E3hiz1gZ25Y9VMz0Q==
X-Received: by 2002:a05:6870:40c4:b0:3e8:8e57:a7ac with SMTP id
 586e51a60fabf-3f54415a618mr132573fac.55.1764968097237; 
 Fri, 05 Dec 2025 12:54:57 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50b584778sm4024025fac.16.2025.12.05.12.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 12:54:56 -0800 (PST)
Message-ID: <6c30a89a-1f11-4ae3-b424-ff4944a665bc@linaro.org>
Date: Fri, 5 Dec 2025 14:54:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] Final fixes for 10.2 (gitlab, testing, docker, docs, 
 plugins)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 12/5/25 10:41, Alex Bennée wrote:
> The following changes since commit 864814f71b4cbb2e65bc83a502e63b3cbdd43b0f:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2025-12-04 13:37:46 -0600)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-final-fixes-051225-2
> 
> for you to fetch changes up to 704db3e250f5c646b3f51bfc7975b66b0f47d767:
> 
>    aspeed: Deprecate the fby35 machine (2025-12-05 15:37:18 +0000)
> 
> ----------------------------------------------------------------
> Final fixes for 10.2 (gitlab, testing, docker, docs, plugins)
> 
>   - drop out of date --disable-pie workaround for aarch64 custom job
>   - remove explicit pxe-test from build with no libslirp
>   - update the FreeBSD test image
>   - don't try and run check-tcg tests we haven't built qemu for
>   - skip iotests which need crypto if we haven't got support
>   - transition debian-all-test-cross to lcitool
>   - update build env documentation to refer to lcitool
>   - update MAINTAINERS entry for custom runners
>   - ensure discon plugins can read registers
>   - fix a bug on uftrace symbol helper script
>   - deprecate the fby35 machine


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

