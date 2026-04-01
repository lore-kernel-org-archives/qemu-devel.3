Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7DC107636F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7oFw-0000Me-BF; Wed, 01 Apr 2026 01:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7oFv-0000ME-76
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:36:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7oFt-0003Z7-OK
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:36:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82a7ebc729dso2752147b3a.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775021799; x=1775626599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1M6Up2+Ug61oKW/s9KrBHYzfAQr/Gp5A2pMaUqfVV8=;
 b=EFjKFxMGg2VzmGOjIW1c1yz8CFh8/IwS3KjijYF0ENYpG8HdludfLjOgH1O57WqPus
 6hQMLtrP3dPbpoXq43r38Sk2VwifrAa79vX7CsJmSG/WG74cF7FZLchVNKOdpBlescIU
 R8WN+OqQDk+aBKzGBRdFF3amwGXBDNj+Uuy/5sj7WVzhVegJ4L9QHgvqy2DRjQO7VeU6
 wTLx0lxm4yOamvzIyCf1D9n0KuUGZqz8FxT5Okbg11yN8BUxC73IkRSit22LhsWQneMC
 qNjmCPMJRrSe5A8dklbD6WgzlZF2lkpD2j8OYCcZ2yfsVCXaokuoTK4v55OWQoKrC8Km
 Hfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775021799; x=1775626599;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1M6Up2+Ug61oKW/s9KrBHYzfAQr/Gp5A2pMaUqfVV8=;
 b=kSCcnjlxb7IJ5A4836u1YInI2agfMDBLNVaAxxyDAJPkmehx4vCW/WTDnmN5EG8UB+
 y1OX9a6vOXz4s9l+lJsOsXAZutHyFExl5IoPeTyH/uxgqD3N47wUk/phAGNoKyF1ZiIU
 fr7bSbh7dqFC0RQMzN5rgzyk77aTKHbdrhUSsAGN8w7idtXPM0jB05TdmxhqgFAZDr9h
 J5YIi8drV0571QzCP87YUxfssVrt+ICE6Ljf4oaO+8WwUofmdBvfJH/bRnQHAvAvJW1x
 WlfCKcmdBOyhuXFoKTASJo9GtGvm/71VJQ27wWJVwCq1EOOBBBgPxuNOqs7f6TYUHcfz
 5ypg==
X-Gm-Message-State: AOJu0YwbeR/tA51VZs4JYt0w0MKotiwOq06CKkF5UERcHS24A2eYlewe
 GEeiHD+6LaPj+kr+vWC6sxauXqbvegE5+Uiy1BOPi+ICWJDQV7+UJAIyvoLWwhnF1QpG1tvjnxl
 gMF7K6eQ=
X-Gm-Gg: ATEYQzxy7i+FZI3GLknmuDnAOCldrFhKm0Q/ThT9Gp5N0jkDIvLxf0Lpug4kacU2HWL
 9oF2EElEyglo7onO5QttwiTesD0BLl3LFmMJ6QDHFfmdTrg/vze2dFJUJ1n9Onzue8lspRXvXyM
 AH0a9+qy57eMeUt/borLkyaec4XMJWp84VF8NwRzIMlHIERG0Tya+hdVRTB84ULfIQ6Ivy+2jck
 /LrPDH/40w3UpLCIVx+jDF3PVXfnqQUve/cmoXa4/ww8CqKZuT1MEPJP+uhR/ImT3qL4Qn1cle9
 b5fQuil5464GkwyuUa9zvOjVERJB9pkYT4Rc8zOO1m/XAK3yCldEFCnGXotU3Yu4+7Ri/vjPSUD
 xd7xMn9nusA0jUrZ7NnSAPlN2Q/bQL2qPdbRllOu5+kgVcQefGpyFsJpqpLceaCSjkuMBSfYUJV
 qZEKmXgE7h7dOM86VtGCClhiF4uY8syOUgw6C22/L20XD/JNXVKT/GMF7mF5QBimD8BHxUxiIRA
 qw=
X-Received: by 2002:a05:6a00:301a:b0:82c:ac4d:742b with SMTP id
 d2e1a72fcca58-82ce88eac01mr2609035b3a.12.1775021798996; 
 Tue, 31 Mar 2026 22:36:38 -0700 (PDT)
Received: from [192.168.68.76] (122-150-206-150.dyn.ip.vocus.au.
 [122.150.206.150]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca846d8a9sm12907536b3a.19.2026.03.31.22.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 22:36:38 -0700 (PDT)
Message-ID: <cea62347-1b83-46e6-b887-6ebb1592f4e6@linaro.org>
Date: Wed, 1 Apr 2026 15:36:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/35] target/arm: migrate basic syndrome helpers to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/20/26 23:05, Alex Bennée wrote:
> We have a registerfields interface which we can use for defining
> fields alongside helpers to access them. Define the basic syndrome
> layout and convert the helpers that take the imm16 data directly.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 75 ++++++++++++++++++++++++++++++++-----------
>   1 file changed, 57 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

