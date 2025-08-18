Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A00CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untkv-00011r-8l; Mon, 18 Aug 2025 02:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1untku-00011b-3a
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:54:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1untks-0002e9-FS
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:54:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so18093655e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 23:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755500044; x=1756104844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ghgZOH29S+/dbDbydIX/S6PdIF4enaWVlwWE5yGAncs=;
 b=yBVJI2gnn8aYESL8TClVSxDuzaLmnchDfYpwV4muzVn943GaHsrGDch7MgCvN6l4y6
 bPD/Zle08LRI+iM/PpqDGRvRXfET+2pP8QtUqsX0VoOZwXCu38PJfAUdu9IwVvLZ5ET6
 9RpCO4M45X18fx5DycFHvQ17pJkIpgqsZSYm90SZdHtJO7VZHdgHYxleC23xjrsNv0Qm
 Sahyv9WI96mQ9fiA/0OBepucSc0zk/idEGQ/g/Et25LRTJU5jEwTKR74E4dajD1YTE7B
 EIyrY2BTP32I3TxtSrTUEXjf6jRMt77sytIXxMfHEFKhVu2IJ19BDUTmSe8+ZW1ZCzU/
 7e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755500044; x=1756104844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ghgZOH29S+/dbDbydIX/S6PdIF4enaWVlwWE5yGAncs=;
 b=ZTCl3aK72U0GZRlEt05kuf/ogTFMCJDLeJicO5ZrUGXhBkXItJHSNi5GFsRZuKOFEC
 K6aGglDDIgMITxBz6gHXb8vM3w3j/AMPsLg08Jl0D2fIUmjQuLHPPeBnGuL8WO3OTbOa
 ZcE8DrYXosiToMMgxAfvKPE1JjtDBVetS2WSaWrOFJZoBtPsL1oGpdsvICtOBdjQasQL
 BfwHdLYnE8NNVLF1Uz4fNooVh+kHxHLWb1BRJRs8y2XutCtP05Az0X+589fVqm4XPeYA
 c8x60Elzo1Nq3ySZ37kW1mo1r4Jq5CMdf8X2KjuwnpevL+lSwp/+8qq786h7b7ONC3uB
 /FVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWku+mG4M18SeNkizWl3Uk2CswQW/1C8NGOCK6sr+DRs76+iKSODEn/1j/IWL3gt9JMxs8YYgQMmVLx@nongnu.org
X-Gm-Message-State: AOJu0YxoJvCMd3nStgwscSyGWl/YDxsflLSl4Zu8HtKzemeKFY1Fwr3C
 Wk05grY/v/NHK5I/qzjnXDOH0dlKUSkF0/yxxGoGCwhWhY3tHx5yAXKkU4WXsPl1quc=
X-Gm-Gg: ASbGnctSSaLPXs4PcJjx4PGXyVFH5oec8P6fG9dwwVW+fr2Os8kRefB6DQBooWch4WJ
 kE0wQme/oLtRXSo2vObgfgnB3iZqRMx9CUfBIpDVdlpsJYvFiMldS0juFynKinoxddg0yvLoozh
 4Onm6YBopU24p62aALucbC7y/EZa+y8oZAV1R3tuGrASoGkbuU5pPIp6TZYwOUzTm0SSUZjm1u3
 SXzVAAmM8aqKZtUJ6qL34ACcFO2vFY9iod8Q9l+R/29vu/pVHXjDfC5BFotL/rp1ZnpJpJGk95T
 ACyV/DKq6xXXY1HrbjSfpmqgLKY47KIByt0vKtW3XBVqninwyxswcY1OtZG5/JObkgQhbY+ceHO
 nhkXeiDhSYtmwknuoigXfba7lgaazuXwTs5ozLdNZq9wZKLHrmY90d0EcJ9jE69aDbw==
X-Google-Smtp-Source: AGHT+IGEXppWESSDor+lhVFzi5KRhJ3BkQaY4rWOrzMBT4p+lJTiMtOmq9IQuW9F3iB3dvlzhYl2GA==
X-Received: by 2002:a05:600c:354b:b0:456:eb9:5236 with SMTP id
 5b1f17b1804b1-45a21808b2bmr97792695e9.15.1755500044080; 
 Sun, 17 Aug 2025 23:54:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a223206c7sm119095685e9.16.2025.08.17.23.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Aug 2025 23:54:03 -0700 (PDT)
Message-ID: <d617bcfb-f98a-4b46-888d-c2f66fc462f4@linaro.org>
Date: Mon, 18 Aug 2025 08:54:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] vhost-user-gpu: drop code duplication
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-6-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250813164856.950363-6-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
> Obviously, this duplicated fragment doesn't make any sense.

Better safe than sorry.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/display/vhost-user-gpu.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


