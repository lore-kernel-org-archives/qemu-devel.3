Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AB6D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzx3-00017v-Of; Sun, 28 Dec 2025 18:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzx2-00017m-Hc
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:13:28 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzx1-0000Lx-5q
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:13:28 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3ece54945d9so3074097fac.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766963603; x=1767568403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5OvVuwR2t5Q0J5F7TjeGzVw+vGBC+n/xT9HjwrvjvoE=;
 b=aYyNmdyFXyvM+15d3/dIveg65sOyvKgnSllxA44UHLB2k/X+2Hsk96T90ZDU0R7NOd
 2DkIBDXg5Vt21CAjicqE5Otfvd7TRVRy0sPtRBhXDkbc2I+kqD9TT1BGXU4vCRQZkygO
 7GyC9PKnBehVxhufDyOJjItYvrPZYfyufYFZbQuB2O8Yl/jQXR2D/T+HnAcvpTqLuKhR
 9MCXtvueU+zPfhGBrkQZneEZdQUzVPtDwbgBjE3DRYUJFpfe+ABQnxx+nYCc/Zy6AOwf
 o8iKjtZrlRlkVIhWx5P/jSzGcdembmuzaAQiPyE2PY4nD3Tn/lDdoymmzIxiDv2Mnt7y
 +Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766963603; x=1767568403;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5OvVuwR2t5Q0J5F7TjeGzVw+vGBC+n/xT9HjwrvjvoE=;
 b=EKq+9LJLjdvVl5hdt/qJjkhuDCuXWG2ORGbMTzeWmyy3I79gOZ9AgfibxEn82hkvTR
 nmNvQlo5oBQ+TmNdOVRdk4mS8687wI/c4N7nZNYxa6Nd2RB5SNMIPunJWKfH3zjceATn
 Uc6Lf6s9zhLS8PY0FfioHXElNShEH+iV8tCXN59J7KOeF3LuE6dhyYcO8Dd4OXC8IJOK
 b5DxVDorcri0t/kOr760q1IP4b3pazBQLe8XG6sWLi36kClrGrsUHOh15vV91Kdd5yWL
 Ib4N2xGiLxkvDuQnrC+Oh0Rryv0RduDMN5cojqPUwJmYCRAGSbuMpe4Ym9AXk1+aIXzP
 jL/A==
X-Gm-Message-State: AOJu0YxDTDRVG0HT07YbWNimkiX7/1ji96OxSO3kE3kzXkDM22pKcEnC
 YRfTMlYcWJVpL8QUT/ZolQ4EVxlEh+ajoBhGPRmb5Q6QVnJFMGe60fajWF9zueEhO4fUuuCEoct
 CeWx/
X-Gm-Gg: AY/fxX5Zg1z3AdUrbkSBO6ANgxI/h+46rag61BfH0HK82ltA4j3L1RKxYBA5FNdczpR
 5cAWtMM+HA7pc8IDfb1XAgpPJigwZ17/iOLkRL8yqAV2+1ScojoNzSgETaH1Y3Ha6X9O23qvXZw
 QIL0hBiVfkJLX3eGTEMZswejnQczNDnPp79FhickpAWo811lefCV5umQjhbJGBh2Qarzf9HfIrZ
 CtysiqePJE3nQN1xjnSrZeguOZUOSVzukoYtWC91RoR+pMVjnTJ+TJ2FNX9mxR0uBCu8771FNyO
 X8r6lQopX4/cH3r+NznEsiPXJ2mhOPEzbAckcQad0ACTx/L3Jyc8tw04nezsVk1qzZvKjKq6WGw
 p5+obwu/uCaW/4X+vupAA8WmVVz1TInS2k5qPNGj13e4BjHoBI3GytTnrWNL+UgtYFGXZHKCP6e
 jgJIydA+qanQV7Bn8OTyM0VGlpBR6a+jNnE4C6nYDIkV73jLfNs0c3
X-Google-Smtp-Source: AGHT+IHJcK5Pje/dWCqy42Prs3U/+53OXsVNaHhRzoA5hpkwoqr8+paVFOPBD4FQdgjlHvVRbCA15A==
X-Received: by 2002:a05:6820:169f:b0:65b:2795:cb0f with SMTP id
 006d021491bc7-65d0e9e79d8mr11450378eaf.9.1766963603434; 
 Sun, 28 Dec 2025 15:13:23 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f46c775sm16882184eaf.5.2025.12.28.15.13.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 15:13:22 -0800 (PST)
Message-ID: <1c2fc596-7196-4901-b9aa-91a1a6efd71d@linaro.org>
Date: Mon, 29 Dec 2025 10:13:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: fix CAS2 writeback when Dc1==Dc2
To: qemu-devel@nongnu.org
References: <20251226213707.331741-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251226213707.331741-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/27/25 08:37, Laurent Vivier wrote:
> According to Programmer's Reference Manual, if Dc1 and Dc2 specify the
> same data register and the comparison fails, memory operand 1 is stored
> in the data register.

Where does it say that?

All I see is the pseudocode

CAS2
Destination 1 – Compare 1 → cc;
If Z, Destination 2 – Compare 2 → cc
If Z, Update 1 → Destination 1; Update 2 → Destination 2
Else Destination 1 → Compare 1; Destination 2 → Compare 2

which *suggests* that Dc2 is the final store.


r~

