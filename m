Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333E6C9832F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 17:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAW3z-0005Ry-7v; Sat, 26 Sep 2026 13:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAW3x-0005Ra-GJ
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 13:19:49 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAW3v-0002wE-WC
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 13:19:49 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso786216a91.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790443186; x=1791047986; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MSuWrFYvZc9iZpl3uagoVZK7cAqdcdr0t2bP8iHXiVw=;
 b=WCThCmG1Uoo5/fMcNO/MlFYFjv+FkM1e4vfhSfJfJ7uEp48//sivFbtBaZ6/xXZYfM
 yPfvGbArIYHlRxQGHv3nsaTT6+JtReeH1MyrK9/MrVkdinU4wwugH7v1V8YfWRm+F+ix
 DKwAlRpTEqI2orBiK21bc27vNvX0m6Sur/99yIy7jm2kJ+/StLdEv7xvH3mxEFZ+rzRg
 hLyXGLF5H4WeEn/INDGCNnd89NW48eRHydeDUAlxwBC4HKu4de7p7iaspKRFSQo9VmfD
 9tWY/em5DqX73HbjLUwvqjkuOOaz08eUcL0nxml2b+6I5cTfUSXUtAGjZ6Or2GQU9Dr3
 uEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790443186; x=1791047986;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MSuWrFYvZc9iZpl3uagoVZK7cAqdcdr0t2bP8iHXiVw=;
 b=dKwEfyBK4Ep+e9Kizx1eTlnvj89aKqRdDXLl0Pi/aw8HP5mChcJj+d4JCkJYmCBVgf
 GYB7xWKICjFnQER2bxcgszO3/lGXkEDJwNKI1noxgxq8ibZT6DwJnw+gG95kuztF6QmT
 uBKmJFYAzyv4Uxto7Xoe8Ey6TJkWU+gRPRZG7OE8kMgwUpbRr9OXn74BcmctnyBo4dSs
 KJ4YofLVsEdf3pKZFQpKFMB61yStNVwhoPU/r5V7IL8AkPjTl2MTy+WEL5JiZ7UTRdRC
 xab5N2USxIkKQUZ8bvRgiOy107U3/pB3c/vi/POFrGjAaNavYsetQfReXpn8vfy1FEWF
 riIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiu4c4TKCa5EiYAag7mxi57hhShJ25nHAV8ool80HxIiP7HvWywjlJqAneHvEUUKEUAR6IQuu9atrb@nongnu.org
X-Gm-Message-State: AFq9FYKHIfZyhfWWfSjCLF68Iiu7rHZbl6GQCLj872Yuibp2UMn3EpHi
 MKRt3TNRdv1ToexGSGFeEYKEaevpnR3oRbluCrOwmmMnytt/ZPp13CXNcb23Rzh3IGI=
X-Gm-Gg: AYBFou2eR3Iarou2Xx6N1kxqHskDIb4jJWGEFBMb0Q7MNYaolXQL3ovrcIUbAmNGuei
 j8kHx+m1TBUPtMwZmBNZimvAFah8G6ZWKziCkQ1wnUZvj3FqNzXsbQ2/IOM5WakEbh/vVOYC0ZZ
 S2TQGBMMsiUPfrrYksxrTYcu7ivgUrC7/BrnRM3OJ18igOdlJVsWPxty9Xybt9u9UIf4DPXntZw
 ILlQ3Ko/ix0k3l41DE80ccq6/rpZIUChlAO2zkxY5GoRg1MP1mUCuafrSxUzBVjnig6Jvyz+KSL
 ieGIlsArDmFxDRJZqLpzO5cfpM8V0IDpiebjhHsVl86dkB0GCr21O+9RZDnuG/H0BnMi/bIq2tU
 8ln3aAirg46U0fLbOY9CYr/cqJ5oX+6ZZp/nzS5zxPkxvvw17WzxkCAnYGbGpfpXyOIwmQTtM2Z
 1djjuJ22a8uHCQlPcxIo/NXWeLlMVlBqHkxAMVgehgjwIh7MH76ZugN8y1ZrENy3MWPf7g5ytcB
 rmVPrk+PnTXzcdZ71GF/56MuNrDBT+8/2xwZ++a
X-Received: by 2002:a17:90b:4c4c:b0:3a0:c135:3e5e with SMTP id
 98e67ed59e1d1-3a0c1355d67mr4207370a91.27.1790443185945; 
 Sat, 26 Sep 2026 10:19:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0c2e986easm11572891a91.1.2026.09.26.10.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 10:19:45 -0700 (PDT)
Message-ID: <c44ca462-e938-4892-9c31-2b60a0cc44d8@linaro.org>
Date: Sat, 26 Sep 2026 10:19:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: fix lea address for instructions with an
 override prefix
From: Richard Henderson <richard.henderson@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260926072815.467722-1-mark.cave-ayland@ilande.co.uk>
 <b85730f0-ced2-432c-87a8-3b21c6342ad8@linaro.org>
Content-Language: en-US
In-Reply-To: <b85730f0-ced2-432c-87a8-3b21c6342ad8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Or better,

>      switch (ovr_seg) {
>      case R_DS:
>      case R_ES:
>      case R_SS:
>          has_base = ADDSEG(s);
>          break;
>      case R_CS:

            has_base = !CODE64(s);
            break;

>      case R_FS:
>      case R_GS:
>          has_base = true;
>          break;
>      default:
>          assert(ovr_seg < 0);
>          has_base = false;
>          break;
>      }

r~

