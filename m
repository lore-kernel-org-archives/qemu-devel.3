Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46403C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 19:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ASd-0007zP-FS; Sun, 28 Apr 2024 15:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ASa-0007yj-SN
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 15:45:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ASZ-0006e7-AH
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 15:45:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41a1d2a7b81so26436115e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714333513; x=1714938313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Gh8GzAcioBNByCYlgjjR4rZlLa9JFmG2fIHRZS+Txg=;
 b=q2YvDOCyoAeFImXBmHr3euH73xBq8RNkn1q8iIQMpcl8OAhyl9iHu9KUl/cgBTBkM9
 riaFsP54gXMXm2OawVEDhp7S7fbYIVjwS0aEYXZvhEp4xBploj6EPUULWSonILzUthF7
 K/2Dl/2ShvwLuPee/hgVrZtRX161GiZqU2tW5QG6tWnZuw5GN4YYTXMpQMpCZMyRPrl9
 4tR6jQ889K9kEK6xunFIKArbeAVSth7+LT+YNULDZIL3XjEA/1+UeZw3i9UB2xkFdN4Q
 odp05XYfwkkPS3vRerS8uhCP+zx9Wk+XgXVsbVhcS1Y32iRaZK8q7XOQxvQMB1Qy2qbo
 9pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714333513; x=1714938313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Gh8GzAcioBNByCYlgjjR4rZlLa9JFmG2fIHRZS+Txg=;
 b=VsUn03KPSRpuWoklRmUKwXhTf+0u8RH/TsrcobhKMZzDi1Z180sOEWEBdaKOnYVwaO
 Noh5qHb+x610b7I4BLSYi+n+NH90BtDK76WkjF/TIEMxokeTqls8kInMV+OythIqL30I
 uOOWQefEhO+GlTLy5Jiiy7g+xbQW8YmH2hA4wl7cNbgi8jeHCF2zLlRI0KS/CwgwIx0F
 fRcUiTjKBeWkvrphDCT5cYYI6lI9Kb5axU+sez42VQkAcixhCd37bCfeQir4tPfMTyDx
 cgW/dGjCXKU6LdKn1sP0KFLe2FXNi+hTELhFn0/sCl04k7xzfW1WveXQS1nT7LIgCJeT
 Y7LA==
X-Gm-Message-State: AOJu0Yx9xaFSk7SByLZeaG0RmJ7vVRLbLqhftGxXkzhRND31mt5H9KFJ
 qG1Q8ag+ICljo4AHhl3bbUPfe9jkaJtAG0dX675omtU195JTzeVSAoHXbST1Zbc=
X-Google-Smtp-Source: AGHT+IHvWo8DuEKQsFeU2N2suj5PAbjNX8o7KK3fW+y5jcYVjPtdLt330r8fGxwDwiywZhgPUvf+Hw==
X-Received: by 2002:a05:600c:474c:b0:41b:8041:53c2 with SMTP id
 w12-20020a05600c474c00b0041b804153c2mr7494915wmo.15.1714333512968; 
 Sun, 28 Apr 2024 12:45:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 n40-20020a05600c502800b0041b4c293f75sm13709769wmr.13.2024.04.28.12.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 12:45:12 -0700 (PDT)
Message-ID: <0740a98d-dc07-4e39-ae20-08f44facfdc6@linaro.org>
Date: Sun, 28 Apr 2024 21:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Revert "hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()"
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
 <20240428-iov-v1-2-7b2dd601d80b@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240428-iov-v1-2-7b2dd601d80b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 28/4/24 13:11, Akihiko Odaki wrote:
> This reverts commit 83ddb3dbba2ee0f1767442ae6ee665058aeb1093.
> 
> The added check is no longer necessary due to a change of
> iov_from_buf().
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/net/net_tx_pkt.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



