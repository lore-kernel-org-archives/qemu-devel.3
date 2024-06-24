Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB537C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 11:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLhtV-0000Yq-3v; Mon, 24 Jun 2024 07:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLhtS-0000Wm-Q1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:29:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLhtR-0007xI-5S
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:29:54 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-70346ae2c43so3325749a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719228591; x=1719833391;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bzBW7KxL2vtgTSUtPo2iWV1IDl9ycCmbCGXl/Q+pxyI=;
 b=tzPRru1MbEO/bu8+eONDtZLn/8WFrYof91w70OsM3oST7ODZqa2Lo2Cbm7ngag6Wn7
 QbbfJOEpCdBKrCfdMqMVXtCtBtBkaI1oMplHz7B4GNHbDvQQrQpLDnmXNG8DbY27mfDS
 sMC5rCJaWHhk3PR0qiZ/e+gZKs3YWGlcP7+HBZMV0epD28qTQkg2xmPn1/7sEQ3rmL9N
 fnpT0m6BNFr+fUcSbbwVEl65zazEut5LcUN2QF+OxmLaBZAqnOFXvbr/faDkrYjrk3dL
 /BFH/kO7p4WhLXFMQQTSbcY8gCB76tnpXTpVVX6ndCxiokNMo5Uu2LZTR9JnVjmHnnbU
 S/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719228591; x=1719833391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzBW7KxL2vtgTSUtPo2iWV1IDl9ycCmbCGXl/Q+pxyI=;
 b=k8eBJeTYS9jeaq1Nsb+zmLk9T2/xHmFbEgdMyS9ovefSdfZMvl0DDCU2c/PoitbjIt
 EHZmnPXlPbRlGFGoBHpcHKlRZfDUcdOZc5f39uG3uQCBh5qwSxR+S2I4SyHuIj1z80KL
 HxZ5sCXH4Za2WkQHkBWEFaaGeNie+BzVih+r+7585Y+Y2SWTJ7RhK5ugLUbIQVLb+NKT
 Lxd012KsLa0ofO8Vtu15Ze/UnM3snUXAYHqjOcZRZx63glhICoQ6+VOuCGTOi9xT490+
 brMeGKM4TCHyh/ognd+V0yopNmOmW4nE8dbfOfp6M7xQkSp5JZvE1Za30KsLHK/ekRtC
 cCFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE/yQsZcKcUEk69d04Seisd+cHwsT+lWROFYCta1buVRr1OrnH4Df7GggNAdefHe2TdWA2X9gNBrvoJSqIBmVwo+CFAWo=
X-Gm-Message-State: AOJu0YxOFhPFgwpLASPm8nqiwRKkICRnIcHoyJfJs0iPZJN40NlrvZna
 JtD4zRLbrBbM3auxupok8XCCEsIalkn0Fjf/mZhWxrtIaLpTFRbBYt80dqSwBkU=
X-Google-Smtp-Source: AGHT+IHYKOBdBtioyMqV4BOp0Aa2dthDEiyKrMj4L6IXy5Ky1tkZJvYAYnwWNGVyKGidagkPmwByGA==
X-Received: by 2002:a17:90b:1e0a:b0:2c7:cd4f:d765 with SMTP id
 98e67ed59e1d1-2c848a5a2e8mr6362058a91.21.1719228591158; 
 Mon, 24 Jun 2024 04:29:51 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716baf4c053sm5362426a12.78.2024.06.24.04.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 04:29:50 -0700 (PDT)
Message-ID: <95837863-77fd-4816-b777-6da9b2b7dc66@daynix.com>
Date: Mon, 24 Jun 2024 20:29:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cursor: 8 -> 1 bit alpha downsampling improvement
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, lists@philjordan.eu
References: <20240624101040.82726-1-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240624101040.82726-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/24 19:10, Phil Dennis-Jordan wrote:
> Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
> turning alpha values of 255 into 1 and everything else into 0. This
> means that mostly-opaque pixels ended up completely invisible.
> 
> This patch changes the behaviour so that only pixels with less than 50%
> alpha (0-127) are treated as transparent when converted to 1-bit alpha.
> 
> This greatly improves the subjective appearance of anti-aliased mouse
> cursors, such as those used by macOS, when using a front-end UI without
> support for alpha-blended cursors, such as some VNC clients.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

