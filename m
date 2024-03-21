Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE20C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnM4A-0007Uy-EK; Thu, 21 Mar 2024 13:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnM48-0007UU-12
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:18:56 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnM46-0007Z9-Bb
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:18:55 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dddbeac9f9so8035295ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 10:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711041532; x=1711646332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2tmTZrDBjxE6lExAyOPcBmlsnOAnDptfD48lW8AcXzc=;
 b=GP+zDBE7ccPcyKNe6ZLzyDOtskXZUCCUN2XQCYM6R7jTAakNUE/FLmm4THNAIzb24n
 ltsKcn//xeSEN3Vdu6turKCigNIyQozVisEcefyTH1HS2zmye9hpZV4vt4N8RAbuBgG/
 aEJyrYjh4rVKTgdb+qojGBxBeWoj7awy0aIFmVze7aX+SG70psy9dPoeTtYOoT34IELE
 SMPj3unvXyX/Lhd4RDKWDV0Zu76IdD+SaXI76vw0lnmDzm/dh3V1AL9nIxgv82IlJqIa
 t6ia7Y0fE1HpmJ04k371viSzODwXgarHUdzqRmDj8qIgbCzJpxNzeYQLvQ1WXylkWIPR
 n1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711041532; x=1711646332;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2tmTZrDBjxE6lExAyOPcBmlsnOAnDptfD48lW8AcXzc=;
 b=dy72CTC6SVeH6M0g8LKMxTjzsuDxP9EB/ZtPnQ6M2f2YFmIv8D33xbrUkXYPleKBoK
 YbXEnaSC/wIVEj432xV46Mi1VL1iGXz+61djSAJCM/2ifk90AeHDy34xgmw/g9MqkCFO
 H4Q10+MEi472u8K6Ih5rZCI6Hjpqzy10vj+zIdYULySJZAL8u63xKT+lp2PLCOKVqrfZ
 q2smC300tnVNlx3cnUU23yMiE5xxQ8vw+9bpnMskboMcqgx+6+x8PDC1BH2b4cefjx/I
 91TMnrD3VVF0wMr1m3ID/NS4jf/YW2JeB3cJ34GAgezxwawS6k2QlO0hY++BozMYZHJC
 +ymw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcPuRCPwWQas3HPu6LHYBOEWH4oGdWIRNwU6UKj+MEuENQLBR2Gx1TyYFEG8i1CF8fEoprk+t2s9S/WlmdapuYYv1QM4g=
X-Gm-Message-State: AOJu0YwrDDmWwvdsfdL6KjDdWs8ySpo/xLl2VZ05jc2XY9yZaBwuaVDe
 BiNypeXZaFgwH7FqgXTUe3SBw3PocJwcmvufK4I1Rvvw4UVg6K0Z0LKsasrR+j4=
X-Google-Smtp-Source: AGHT+IGqtIXHSSAVq4tzJsK6l1TlD6JVoYXGZ1RXJg5VAO+rzmmioNp2S+ohu7eaPFDTrDPEKTAeEw==
X-Received: by 2002:a17:902:e84f:b0:1de:fbe1:bea9 with SMTP id
 t15-20020a170902e84f00b001defbe1bea9mr44868plg.19.1711041531760; 
 Thu, 21 Mar 2024 10:18:51 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 u6-20020a170902e80600b001dc71ead7e5sm66332plg.165.2024.03.21.10.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 10:18:51 -0700 (PDT)
Message-ID: <a896620e-d0c1-47c0-9609-56a30c4f4f3e@linaro.org>
Date: Thu, 21 Mar 2024 07:18:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: change QARMA3 default for aarch64?
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
References: <5e6e2c5b-70bc-4a9b-a5ce-353607e42ac6@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5e6e2c5b-70bc-4a9b-a5ce-353607e42ac6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/20/24 23:32, Michael Tokarev wrote:
> Since commit v8.1.0-511-g399e5e7125 "target/arm: Implement FEAT_PACQARMA3",
> pauth-qarma3 is the default pauth scheme.  However this one is very slow.

That patch only introduced qarma3, it didn't make it the default:

  static Property arm_cpu_pauth_property =
      DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
  static Property arm_cpu_pauth_impdef_property =
      DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
+static Property arm_cpu_pauth_qarma3_property =
+    DEFINE_PROP_BOOL("pauth-qarma3", ARMCPU, prop_pauth_qarma3, false);

Per the first line, default is still qarma5 (which is the slowest, afaik).

I have not done any benchmarking for qarma3 at all, but it still *looks* significantly 
more complex than impdef.

> When people run aarch64 code in qemu tcg, an immediate reaction is like,
> "this seems to be a bug somewhere", since the code run insanely slower than
> it was before.
> 
> And this is very difficult to find as well, - the reason for that slowdown
> is usually well hidden from an average soul.
> 
> When the reason is actually discovered, people start changing settings in
> various tools and configs to work around this issue.  Qemu itself has
> overrides, pauth-impdef=on, in various tests, to make the test run at
> saner speed.
> 
> After seeing how many issues people are having in debian with that, I'm
> about to switch the default in debian build of qemu, because impdef,
> while makes certain arm64-specific protection feature less effective,
> is actually significantly more practical.  I dislike changing the
> defaults, but this is a situation when it needs to be done, imho.
> 
> But before doing that, maybe it's better to change qemu default
> instead?  What do you think?

I think it might be worth having -cpu max default to impdef.

Peter?


r~

