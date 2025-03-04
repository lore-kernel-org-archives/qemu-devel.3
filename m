Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661F7C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 19:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpYI4-0001Ek-PW; Tue, 04 Mar 2025 14:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpYI1-0001Da-Ba
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 14:50:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpYHy-0005BO-W6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 14:50:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22359001f1aso136321655ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741117847; x=1741722647; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM2XhBEBMmXr37co2iMR+7XpC441yu9xO0EZwz6jTZw=;
 b=P+aka4b6qVI7kf+hlzZ6MTtLsWkDPksZ1ZDVZrJaqXriEVHLY3w86lqhU4emlYbQME
 mhPIDjh6He2xeSwLBA83TJ/BhqboGwepjeUQKGopmPx/4KuIWbeU4ns88kXB2P0+GpJj
 Yp+LqYr/EE9rvy+zPZV7y9yUToXu9YUCxmYLiKgDx8K8+e4Q6OnHAgttG0KJ7Fs9iwF2
 jFSN8KrEJnWmu1x390EtlOhXPVX73srDOowXr2Ol4eB7/Ty5mit1xrymLfeC+AXqZA1v
 5tEBpAe9uVUivQDpdHDVlCaXsD3M5oegUzwXK8U6PbEF7vWfOn76YZzLn7n/AsljoXL4
 B1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741117847; x=1741722647;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NM2XhBEBMmXr37co2iMR+7XpC441yu9xO0EZwz6jTZw=;
 b=ezY1MnuBHMkyxUwaGNLhXl8V0ewnFaUZPjjW/ZRjieV011hZp3znHnyKrtGlJNdtFN
 VWPiexU5QzAolU7pO1thYZwxVUME+GHW6kV6tghIQQP8L0xOAe/frcZpEi+v64bcEwLv
 4JsujWdzWAL/FlFYZeNXGl7PiBy+fuGHKobumDc2legXXzd4Q5j9NJhdqr+xPdani71Q
 at1zl/6R74dHxMfrI2mbUSpWwj3nOUqds9c2UIaTgfcDRL95EGz6oXR3ATeGQJhCAy7a
 uPfjSK3e5RlUNALSf277Os1EvT7gm/htXx2W9FTPZS6mIzbLT1jduFdKOtoGXvL/OOzQ
 H4Fg==
X-Gm-Message-State: AOJu0YwoVfJJxM+xUe52DBcYSbtWUDpUcmkvPyvBM1MN1Bm97qom6g++
 aVZMB/qJNNHe5LZUVNTgE2pnYeeVIPoTMKqvD7HJWox9jhBscLsW7pLlFUZpGuoYN0Uekeb8ZYd
 AT+E=
X-Gm-Gg: ASbGnctg7YkMH5rmYbRrXwO+UhpQRnDDIWfZ+wjmwNbv4C/LtOuf5c4r5AX0IaOFG6M
 f9cNJz4wg9Bp6vaVq206VruGU0FsE/xZudt7cTC629d5VKoDgtTqtOffT5ZRkrl894QZwdfR5B3
 k9+mOBYFP6a85FxXUdYorTupRS9wr9ADTk6pN748kd9WBADkGy4wYc32haU8ZGsnYVcW3NT0IAK
 j4VpcxUOaPqADY+kK6fN2+MiHguaMTNAQHsWItYFeL554Az59GRJdqmDuGPnKnGBurKHZWSwyu9
 kdJkSgI8W8qy2deTw40knuf4xIW0mDSxytJb2gBOO867QOd3YQL1eM8ghA==
X-Google-Smtp-Source: AGHT+IH8OOeHpEKyqqz9mSVA1JuQWu1/ZSyQEs7q8E5/ej0UPELOCSW2JDE+jRtezk8b2chhZRIM7A==
X-Received: by 2002:a17:902:ec86:b0:223:5ca8:5ecb with SMTP id
 d9443c01a7336-223f1d21226mr4930105ad.42.1741117847454; 
 Tue, 04 Mar 2025 11:50:47 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504dc489sm99042585ad.159.2025.03.04.11.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 11:50:46 -0800 (PST)
Message-ID: <cc07f761-4c89-4eff-96c2-00ba54633634@linaro.org>
Date: Tue, 4 Mar 2025 11:50:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Windows plugins MSYS2 regression
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Hi everyone,

I noticed some time ago (between Feb 1 and Feb 3) that QEMU plugins 
segfault when calling any API symbol with MSYS2 in mingw64 environment, 
compiled with gcc.

I reported this to MSYS2 project [1], suspecting a faulty compiler or 
runtime update, once I could identify that it's not a regression on QEMU 
itself. Indeed, older releases now segfault as well.

Recently, QEMU enabled Windows clang builds as well, which are not 
impacted, so QEMU plugins are still available this way. The regression 
is *not* related to this change.

It does not impact upcoming QEMU release, as the problem is not located 
on QEMU side, but is worth mentioning in case someone would create a bug 
report for this.

[1] https://github.com/msys2/MINGW-packages/issues/23577

Regards,
Pierrick

