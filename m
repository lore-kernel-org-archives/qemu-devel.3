Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8EFE51FF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDfy-0003Bp-31; Fri, 24 Apr 2026 06:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDfw-0003Bb-7W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:22:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDfu-0003ed-6w
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:22:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488d2079582so89354195e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777026136; x=1777630936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+FW8Jg6Eq4djFbldDrmhVNfd8hiX5kUllkN+OnwNRA=;
 b=QVxPg721HRQ+dmxE16XlifopJEjLbEHQUpOoDvk8vm0hdf/yHfQyTPI+96TuyQW+xg
 amKD2aoK9V+tiDmni3+6P5R61psf+i2b4JSL1i88yNZHAd43YUF5wN9eGu6BATMSt8F5
 S+rU4PqlFKglNiiHOYeSMehM8/cE4beYU/ooT5XsJmQ6Zq5mEQO54BCQ1MBdY3G3EaML
 Dv2u/WhXtZkBg1jsNW91J/1vn5TJidPoBTs+H41APPezfSFRXzSVcniPjS7EOcJWRoI/
 Piaatlf+l3sRTVVwpPaI/BMmB/WldQiupc7Fkebt5PMEyvq9qreegvD2AsRoUsQcLAs4
 3tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026136; x=1777630936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+FW8Jg6Eq4djFbldDrmhVNfd8hiX5kUllkN+OnwNRA=;
 b=KNslGGIIklEwAGowEh+j+bxqP4gnbw0jCpJSUEzVZeQB7XiF1+Rx6ld4K0OkTkEn3e
 8EPSSsAI2mKD0z1406CgTLMBAKqomFIwP/QPLnCvKW9Lotjw0xjNnPZ5r1owbCbHEg2z
 8kOKMZ5iHIuyfc2aLaefoSES+ZElHytd7GBYUmRoT4cMK9BHS4LbL13GMFPM9afvA+4x
 O6woMbFa5TxVPCrh6ktT6g8nM6Pb1kiDiTZd6wY7YMOcdJ29HAi1IUSirpKqp7tQsKnl
 ZbHqWRX5YHao1k0HX3zKRILpOflvdvoSqMzP5SUZkr13/DzsRhsQVWGcvP3jUaNTktsC
 v6JA==
X-Gm-Message-State: AOJu0YzIkMkDokKf4575iDp0/r+r2JQv/tTs3u76A01lF977w/s9aBae
 RSeyigPn51i0INKRNiDV4MazI5kcYh3VYEsBhLUVd/nwFazpyEMFKuF3iq3ro9fB3b8=
X-Gm-Gg: AeBDietzVRma4RN3ojlEc5nFBljOLMMVNTXO1PcNK557c371r7yV8QTDSsNfZCKJJuI
 sQ4F3FKWvfcthOWgFqVEThyVif1DSy2FC5jcaDuHFw2LUIaMk8KDENhyy2Dj2Obz7Kxk5fL4Bpo
 zGcErPwCZoZy//M6zVhH/5F2BrWGIUOtR30N0SvF/CMea1nd07udCrFOI4+4pg8qV2Iu0j54Uvi
 yxzg8rqF9M6OlXTOQ/P7KP8NdgqCFd8PLF8/Lgqot3Ist14QLGO3DRDXaNFAeErYtJ105F1exfj
 mZITWmoSjV5ppZbcclZUjTcINfQLgC1ihPmvUUeKTiSSOY8Ll73bPNCi+0me33W+UmuMYptFSGK
 vHyCuq5XebDxfvXnG0nQpChnXbAsQNJF19D872l56WLARD3b4EH58DQwS9SdxItq8nrt3n5HWlc
 mzLRtF63/A3aPcTct8R41T0khA+8fQYIYnD1m95ACkWtt7u6SyggcxJ5mazVlJvfRZOg+twgvXu
 7eU
X-Received: by 2002:a05:600c:1d19:b0:48a:525b:e157 with SMTP id
 5b1f17b1804b1-48a525be257mr288730655e9.13.1777026135884; 
 Fri, 24 Apr 2026 03:22:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4411c9f4f03sm29331345f8f.1.2026.04.24.03.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 03:22:15 -0700 (PDT)
Message-ID: <fd5734e1-b4fd-4020-808e-90773d8d9403@linaro.org>
Date: Fri, 24 Apr 2026 12:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/27] monitor: Remove need of per-target handlers
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260414003001.97571-1-philmd@linaro.org>
 <87v7dgsn5x.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87v7dgsn5x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/4/26 11:49, Markus Armbruster wrote:
> Doesn't apply to current master for me, and patchew couldn't apply it,
> either.  Got something I could pull?

My single-binary tree is having various dependencies on this series,
do you mind if I merged it myself?

