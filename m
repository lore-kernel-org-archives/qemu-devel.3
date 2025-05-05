Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0F0C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBt5x-0001j1-3j; Mon, 05 May 2025 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBt5f-0001c6-C7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:30:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBt5d-00023a-Ht
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:30:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso36093615e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746441023; x=1747045823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yLs7kvc2oZkf8NbNmbNu6zRC2INcjATOG4XLPe4rHNI=;
 b=EsulIzrbnnVX5ZggndQoFm0NaDICmdn5jJmOiLVgxJu68JxvBT9/2e3nE24/JnByyk
 qouxMrskTJbw/p15uCZ8OUKiLixEVVrKEF+d25gTqj7asaLr3a+PJqCFWAOGip789DAv
 t/S2RpNqd9jT2ugJnrYkzIdU2ptlOAEyHjleA6ajkxhLqkQ/Zn0yCB3c53XhlCFc8pmm
 u+IMh4KLD/vUKw3lWeeyDUJgcV7uqWM0xikyvXWUSpW3LG3XcvG5aWzcycuaLvKAW6bd
 rj5SgrjNoJFiZC67WE09yjoJKLvr2xqwm/IqpxN5cGkV3rAjwRgi9JzmMJnMANuomffN
 XcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746441023; x=1747045823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yLs7kvc2oZkf8NbNmbNu6zRC2INcjATOG4XLPe4rHNI=;
 b=kqpl2g19ivtWGz1rGtUujTSPjPByu/+QloJKIZnQRYSQKuN0L57jMn/f9oSN/oQ8Gl
 k7QUmQGX66GvA2S4DfCRwIB/LaqoaOK8fDVxCkJbrsBus3r+qHCiZBjJVRedhknWcrx3
 FpEb8MVeEk51X/pYBbdyiOJh1I2e/BqguAHwYfjIORPYYUaX310+IJJ/3MUtIGRHPVzL
 ZF88yks6ibv67lVoJvdu3ChPSyeLapcMtaBwBkZ+drV6YRTT02xiepdGyOp905+1oVaO
 AL6WkKIJyFlmIU5D/VLYjTsQaa4Wx2fEoPCIVVL+CdyzyvR63/RKZZZ3TNN3BQ/Q8ono
 NJqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWblX5oiO1NdzrYcXMrXXzU3BLxOKjcJgXAv3UV8fXJfc8mNLFiwUS7rWTiQ7Ife+VtyNxtdhRDQrv6@nongnu.org
X-Gm-Message-State: AOJu0YwHfD5GR7dS2vpiRT10KscuN6pneF7J8VRMtaMwxdEC4Q1uyPmn
 tsf5JaxRtUv8z56R9cHl+udnoi6yoQhyT7VHBWLOEsEHo4ygiORV/uUdpXkUJNE=
X-Gm-Gg: ASbGncsa3ipAILviE5Emh0WPymNF5rcp313ykmmmj7fOEKUr3O8suzjqtmjXdYHXsZo
 usEUtiAGYZpP7QyLKzbobj9k+kAnHgj073ZnaKf4SziAxEX2CMkIrgcIZmvoTJuve/MSNgiivHO
 rCsAYaIG4z5uEkHkQk/C5cC4gJOK4q/VzzujXy3x1Swp6JzkC16e+1zDTnCGrqJIcZEvIz1y3dR
 kplLZCGJ+yONBpMj73Mvs5jMcOcRnIIFnvM2yFgbyEKG6R5oj4MMsnzQ5vwt8kbaPMTOkNbPS7C
 G4v8N/+h3Q3Wg+lYn57nMCuh6AM/kW/AtYlm/nVCuBF4mABp7X1rkzavaMg5xZMU0k1Z4OHkOqZ
 EHrn4gzUCtpMrag/MGIKSqn8=
X-Google-Smtp-Source: AGHT+IEClfOT8Up+JU4Z3XFq6ZphfV87NuAutdzikUnC4QMEpY65kADW9yTuRq/CPiArUatODTMu7g==
X-Received: by 2002:a05:600c:83cd:b0:43c:fcb1:528a with SMTP id
 5b1f17b1804b1-441c48aa481mr60346775e9.6.1746441023214; 
 Mon, 05 May 2025 03:30:23 -0700 (PDT)
Received: from [10.194.152.213] (219.red-95-127-56.dynamicip.rima-tde.net.
 [95.127.56.219]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3b57sm10189693f8f.36.2025.05.05.03.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:30:22 -0700 (PDT)
Message-ID: <b96164ca-70fe-484d-a30c-31590aa87a0c@linaro.org>
Date: Mon, 5 May 2025 12:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC
 machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20250429140825.25964-1-philmd@linaro.org>
 <eb7983a7-b6c4-4dc2-8143-6301b19fde1e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <eb7983a7-b6c4-4dc2-8143-6301b19fde1e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/5/25 10:23, Thomas Huth wrote:
> On 29/04/2025 16.08, Philippe Mathieu-Daudé wrote:
>> Since v1:
>> - Fixed issues noticed by Thomas
>>
>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>> as deprecated two releases ago, and are older than 6 years,
>> so according to our support policy we can remove them.
>>
>> This series only includes the 2.4 and 2.5 machines removal,
>> as it is a big enough number of LoC removed. Rest will
>> follow. Highlight is the legacy fw_cfg API removal :)
> 
> There is one more occurance of "pc-i440fx-2.4" in tests/qtest/test-x86- 
> cpuid-compat.c which could get removed now, too. But this can also be 
> done in a separate patch later, this patch series here should now be 
> good to go, I think.

Thanks!

Paolo, Michael, if you Ack I can post a PR squashing in patch #1:

-- >8 --
diff --git a/tests/qtest/test-x86-cpuid-compat.c 
b/tests/qtest/test-x86-cpuid-compat.c
index c9de47bb269..456e2af6657 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -368,14 +367,0 @@ int main(int argc, char **argv)
-    /*
-     * xlevel doesn't have any feature that triggers auto-level
-     * code on old machine-types.  Just check that the compat code
-     * is working correctly:
-     */
-    if (qtest_has_machine("pc-i440fx-2.4")) {
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "SandyBridge", NULL, "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-    }
-
---

Otherwise I can also respin.

Thanks,

Phil.

