Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D079C369B5
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4H2x-0003h3-Oo; Mon, 14 Apr 2025 06:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4H2b-0003VK-Ig
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:27:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4H2Z-0004OA-Sz
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:27:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so3702089f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744626466; x=1745231266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nw6FxYmwHgRNC4ScC/+LyigaJpiSB50GMw0KegQkYgE=;
 b=iHY0DXcvV03JTD0qvs9JfhTow7j6cfRokGAAHotszuA/DaU+DFSz2Y6vXH1M4E7I8W
 RJXlfz21+2t1hWfCcjfR03ThNKnPZyC6dOMbN27ThrXhhTOt7i96Jm6oM8afkLGtrk3n
 fVTJrF/JvkgJxiF3Qzigs6fNwpx1GW6ip1rBSCUFZ4QgA8KQaqD/Pahz5foOuFupsT5E
 69MPfRofKRhE7Sij2xZ+jd80Y78kP7vJNdfAKBVdZBoo7HXubtALmCALylDM48m0cQWF
 sSWEy3Gn/GSJ8tjwIYJwwJZt7Rhz27lXkH6RFEM9mSiiLeWfBuzpBBtWvVhM0SPTMePg
 xxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744626466; x=1745231266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nw6FxYmwHgRNC4ScC/+LyigaJpiSB50GMw0KegQkYgE=;
 b=HEoX4Cxl0m5otSUeDly67/IPfGX3XRJq9RroDPQct5yy/fbdqQxbZmz3NHebNM2IaE
 lPMDn8URD39424/LO+6DrnH8hlQWVsLNx6CqckN7oIsH36bCwqjnaWFcVB7ipm0mnYbZ
 NMZ91cB0fOpJu7+gxSqwmPvLjDxZeHLq2FWOrAbkAOoDmDkdBg01bIrcagqsK6VklP+I
 qtl1Gy6uOu3da/5/IdjQjQhB/KEVI7FAjL5UOs1rhFVJQKkW6soOenJIjHrYmpjPUJjY
 pgjW9kg0QQhAFmBH+9wxve6d8ByjHgtheNUQX55Rk5ONcJXXpVbOaSNbxpx59tyZR3zr
 cnGg==
X-Gm-Message-State: AOJu0Yx3PO9FKiHQxdUlvcblYrYQK7U5L5cfYFd1TkpBx5y94hPDtiEm
 K4yAtcBcaYjVYSvk76Q/LWpMKJ/nX1fpkYMYrdHTM3eA8wIc45sc+v7pAAKax+8=
X-Gm-Gg: ASbGnctT9zgUXBjzAmyXCt6YQd7ua61O0vU1oQf+SFaQp7rUhExJNMlmcT5ZtWDlRtF
 ZQEPJBenxKHzbu0UexzTRBpJpgRBZb08NAZc/fggYleSSwORQx/Df/K0L9XyiNVXv9ZJrLVMsSS
 4Mm0zZvn9YE3NIl4GeL+zTieqe+ydYIz0vZZHMhERRL8R6yPgj/X2MQkmphdKbfPyZauoX4pklC
 57WV1K9NFLs7BRdR4xsJkO0ngC+6EMgbojXxovXfA93dCdqJYVRFmGuE0cjh2hKb28Zlg26Tlyj
 cF9AAMo/39JZ6NeGluSWdtQ8VUhuXd3UDQyELQ08l7JwYJix4nZVPeQ7LC6lFMEbaIUWKjbXfVw
 dqhy7OFDdHWWiGH1ebcA=
X-Google-Smtp-Source: AGHT+IE8VUtvhsurQq3hKMpmDBPQJ6fgvtij4XStQQn7oAtKoqMlE93th2b99P625Ngx9nrZoE5V1Q==
X-Received: by 2002:a05:6000:1acf:b0:38d:d0ca:fbad with SMTP id
 ffacd0b85a97d-39ea51f46d0mr9230109f8f.14.1744626466020; 
 Mon, 14 Apr 2025 03:27:46 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2075fc83sm179431915e9.26.2025.04.14.03.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:27:45 -0700 (PDT)
Message-ID: <14350aa4-95d0-460a-bab4-ee82dfb2460e@linaro.org>
Date: Mon, 14 Apr 2025 12:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] docs: Fix some typos (found by codespell and
 typos)
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20250412181147.1046898-1-sw@weilnetz.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250412181147.1046898-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 12/4/25 20:11, Stefan Weil via wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   docs/about/deprecated.rst  | 4 ++--
>   docs/devel/codebase.rst    | 6 +++---
>   docs/devel/qapi-domain.rst | 4 ++--
>   include/exec/memory.h      | 4 ++--
>   qapi/qdev.json             | 2 +-
>   5 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


