Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC34CD8CAD
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 00:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX6uS-0000Uv-LO; Tue, 09 Jun 2026 20:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6uR-0000UL-MA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:35:07 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6uQ-0006Oj-4L
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:35:07 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c858b5de728so3943316a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781051704; x=1781656504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OwyS1Wiic2VNAU1rCFnLe+H3c+LW6I/Om6kCehcZheY=;
 b=FoXwtlvmLB9yoTE1aUF9PySf0aeXk7h2CxiS8ltr0dRpNo7mS+lhNpdV6TvoU7LnkI
 qb0KHnZWzoeHMp+JzLok9Nmo/rpEDPNB50wir/2Xo7/Eh/qIlj3KF8RGBxt0qp0djAgo
 Z2y+BxabGXll9b1AEqZCne/5cutpyfcdT90mgicEnuZ50+pQ+jUaIOqniaoKI/Awi2kv
 ByTd50y/uAJNNHhinaSGvoQa+nmFCjBLKdd2IgG12erx+msL9OcltxFyNjVHfYf/RnFD
 0InjVy0bm25QQcoergzPepvfZumAVMopoHqCFGp/bDMSviSyFDn9kyWGpo6h6pWvls2C
 7Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781051704; x=1781656504;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwyS1Wiic2VNAU1rCFnLe+H3c+LW6I/Om6kCehcZheY=;
 b=nWFugDunfL0NPFVtucLFQEGxAoty1d3/M5wOFZal54HP5WRtysIa9dGw+XoW8iYFm6
 cwBZ/fZJHFC+IPBE1VRYeHOBRBaHXQY1AhFfICBix5Ukw0nwzy9S1tUSMucSe2DFCuxf
 DoHVWd44jG5LTSkEBYqpFw0s0kkPeRL/tZtLfzkyQrPpc88cmcASqE5oyMkTP95rn9Qs
 EUrwpAym3mA7kqCOu1Ro4ublx/P+CXI3MUyFsmsAgop2crJN5z/F2g0fEagv16wCyQV0
 L3VFnD+hKj515gHJ9HCGdAOEbidOpa7tyXrorYJfBpouj70WOmQkCI3lLqceNsbn7LUO
 86kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SJyHsogCwucCu3VZJb/7vCqxuOgY6HjIuskSPpnIgo8o1LYc2ekkjyiI8Dp4JhL02PY6W96GIiApp@nongnu.org
X-Gm-Message-State: AOJu0Ywl8/g8RzVK5IaIjq34RCN+7PCDHfVMr18aNe8P6vF/JDGDgWuS
 fuhx4IszjOWiZOQD75bfMEoZCJxULXmJr1zdaglOEWJ22czXsAvXJEig/sIJ+2jlHxw=
X-Gm-Gg: Acq92OGeiFSC2ql4l2coTwZs2Lr5oQeG1CWIc8XvJvdfOi4rHJ0CBKWXoxKLWlpqT2+
 9vYnvUSRt3OvbT7J9oItGNIwu+mjY140aX/9d+3rwHkT+tJKLwMGcQ53Qev9Y5gV93zj6ySV1ey
 PKcgrKShNSipXerTSVtNfQiKsojehifkKSYBLXZCO1268HIwq6l/N2ms47cYYhQghR+tc03l14O
 IOuTkRTAY4ADe6M0We3KidKI3JeZAQweItidoEgqB3M8Eq5sa7kbLlBF1gWxSnDnD4qHCrzK7Sq
 G+5WrZs1B/sdSp6cFdgOgEZdycZW2JERn+IuLXFeH2Lu6Dl2YwarpaRbZLbOtHBDlAQBI2fjrpb
 YzwECuyuSjYlvo5eeyHn6NRRd76Zp+zVi98VCOjV5iu9K6kCug9Unuw09lICzQtFzLmVSFLk9x8
 sE2JVkJRrjBCF+thfHeumI9rIu/f3qhW9j6T8Hl4tSHprpNxU=
X-Received: by 2002:a05:6a00:9093:b0:827:3d52:5d1a with SMTP id
 d2e1a72fcca58-842b0a880f2mr22791657b3a.0.1781051703917; 
 Tue, 09 Jun 2026 17:35:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282883647sm26291191b3a.36.2026.06.09.17.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 17:35:03 -0700 (PDT)
Message-ID: <bb67f565-e26c-48af-bc0e-121b17464a5d@linaro.org>
Date: Tue, 9 Jun 2026 17:35:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] tests/tcg/multiarch/system/memory.c: remove unused
 variable
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-2-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609214745.772536-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/9/26 14:47, Pierrick Bouvier wrote:
> Caught this since by compiling this file with -Wall, -Werror.
> 
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘init_test_data_s8’:
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:18: error: unused variable ‘bottom’ [-Werror=unused-variable]
>     97 |     uint8_t top, bottom, *ptr = &test_data[0];
>        |                  ^~~~~~
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:13: error: unused variable ‘top’ [-Werror=unused-variable]
>     97 |     uint8_t top, bottom, *ptr = &test_data[0];
>        |             ^~~
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘read_test_data_s8’:
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:384:14: error: unused variable ‘ok’ [-Werror=unused-variable]
>    384 |         bool ok;
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

