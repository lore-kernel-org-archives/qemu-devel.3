Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24F8C88E77
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ErV-000203-4y; Mon, 14 Sep 2026 18:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ErT-0001zv-Sc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:09:15 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ErS-0003at-Eg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 18:09:15 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso371041a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789423753; x=1790028553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fXa55pJMZVxdQvYucCZg4TxUj5w4FJqgY4RPKboeu04=;
 b=q3ieaQdpSbLZc2eXaqvMQnDHZI8X2ININN8wHbOtvWnIsP+hML1us+XDRVPSCyANQU
 SUQa07FNF9kJ3i83bk5wj0yqIlzkhhclxNBoKCjoOL/HiKddY73aa0KZsTUFg5HcUGoz
 optqVY2662NrM94UtgOfNn0rLvhztaUbaI3sJI2+a1WIr5xAEmGAYpqqXwNJjGdMfPeS
 HWdfTQrMDjOUDcThJKiDXFXZ2hzWxFc+G6y4kg5BCDsp9MCHwuti6K/9v7IZL50ZTIrA
 16+9QLeZsDBQJqgLYFZ28GKaVOTnHGZXkhWBvqc+1VPX+ZJkCk/zSQesPM4RDNv7UsXM
 R+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789423753; x=1790028553;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fXa55pJMZVxdQvYucCZg4TxUj5w4FJqgY4RPKboeu04=;
 b=M+k1hxVXxMpPqhyoIm+LrA0td2u9BylBGZ/MNU3I9nACBnqpmDWxQqVNPbsilON+h4
 Fmqe+UzZtLCzpbUehE5IS8m/9l+8E+SvJKgp8460SnHMvelut6Skk1/uyZgmzOAaVFzr
 eb9U4RI8VvtmGO/QlVKEaToZbCRTPa44T0SxhDO+IueICMyWw3wFXPJTgO8SVPW7wi3W
 JhQQif/0J5jEnjpnvW7UG5cjrg8s4C4Ac7V48mey+fGRjpC3rdLSm3IdVsQII0Sk2O0H
 Jb+b2VMdOyW+66WmPmhsIkjcUTwQcK68XlIQXBdCUyiUmwsgs/lxWqglJxSSAZBY6/lv
 9j8w==
X-Gm-Message-State: AFuF++k064RS3qomDsz6EZv2NJCC1WlxJ0YiQBwlfIPRs8RYl8VNXBAJ
 5L7WDG7OS1YzsVzZKHup/WliEAEJBkQ16MRumN3PScp93jRBsUOJsn7f9RCNBoBGC/w=
X-Gm-Gg: AYBFou1sbl5aD8bhWlYFB/RedsKanX2ieD6sWKi/EWkyvYEWvBwi+Ra46H/HbsfPeln
 D8HnwRhntj/iiT6ury0BfG98DqNIsnYtaBg4Lr52aEsnA5isghAAwIlBtl1uSlGWLUJSRLzzaBV
 U2R4IZMfF3z/f1hhCJ6rffz23FfOYtWhWMYaq1nh2NenVLxm0ugw9GUErSFhLjqnGpvOeyy0qlL
 9SMI4meDvFpAn83zwwKIBC2UUUz+ibfvVnyUuqfkFBqL3O+ulBeH4iV3/RKJUWWjfgKcTjrcJgy
 RgS3fdovj7+js4V5gD0+0xyqqb1odTQzpW+iGdz/84UYZEtbbOczY7rYCcKXX73v8pJ5I2hsu99
 cpAYPwZLphHZIFAbeBjNMBTC9EtDTwBb666Ht8KNrCaLX7IWn6O38cOZ5ofNyHhllv297pHyAsU
 BN79016I6S96IG3jnoVNyPNJwvwEVQ6p/acFwuiwZMWrExvu2CmMnL5NPa6o7LUdXMncXBIAQA3
 YTh5iVEMhjWqncHhur5TuxqFlf6rCXyXDKJNz2Uo5bzH20yg+y6AV2nB0K7Qg==
X-Received: by 2002:a17:90b:4a11:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-39dfe188cd9mr1556974a91.19.1789423752672; 
 Mon, 14 Sep 2026 15:09:12 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4b1f409sm32959275eec.0.2026.09.14.15.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 15:09:12 -0700 (PDT)
Message-ID: <e5b33b04-e10d-4b56-8917-cbc1705475d0@linaro.org>
Date: Mon, 14 Sep 2026 12:09:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] qom: report & filter on security status in
 qom-list-types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-13-berrange@redhat.com>
 <7a47ed5e-fc50-4f13-8fac-455c6015d38e@linaro.org>
 <aqhTQ4pad4OOWCcV@redhat.com>
 <0ff70c1c-cf73-46ec-9ae6-e2130bd1eb91@linaro.org>
 <aqhXANB86gps6UYR@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aqhXANB86gps6UYR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 9/14/26 10:20, Daniel P. Berrangé wrote:
> By setting  'has_secure = secure', it means that the returned
> list will include "secure = true" in the JSON, but we will
> entirely omit the 'secure = false' field for insecure devices.
> This is essentially a short-cut making the JSON smaller by
> omitting the implied default (insecure) value from the JSON.

Ok.  This could perhaps do with a comment then.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

