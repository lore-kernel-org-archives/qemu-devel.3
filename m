Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4623CCD183
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4eO3-00014H-U2; Fri, 03 Oct 2025 07:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4eNy-00012g-RM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:55:43 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4eNr-00025H-K9
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:55:42 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b551350adfaso1965738a12.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759492526; x=1760097326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p0jbnFaCbMDHIZMwpuk0zUD4EsGJsCI8NfQtsqavRCA=;
 b=GyTylTBF2cVkC4A/J8l+mbHvoDD7usmRJURNTPohVx1RmeSv4ZRhiU1xqosOxR8W/5
 smGz0D9d7VRMxOkR0hrmq39qBGzKCRUr2EFVIZ0vsVPxYmcPNidGN7aOxdyary4tYHc6
 PC2H2Fiww4VuRs7NfF7PdiyORvXAmmvZ6YOStJV2CwrtWAq60GkjOkEkuC9+H1dKU5T6
 iV+VJR6LekrBStB7dwo4FyAf11b6zxJbKYhDIfuHgQjt8CpK6cmIU0OsnLal6tRkNpk3
 DUvSsA9FHd3sW4CcibD39jR6stjRWuOVvRJfigDu6Nx4y3eISEBSYGCqo59oflhX5e2G
 8PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759492526; x=1760097326;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0jbnFaCbMDHIZMwpuk0zUD4EsGJsCI8NfQtsqavRCA=;
 b=Z3C6cuTM7JndHzyyJbbGrpDA/u71FAnYXJ/jBxBBAkuZCZ2CG8zPkAesGgabjmNTFX
 +g7OE8iqV4AQmkltHpFlUyBRdV2mOZSnc/NdKopBlt96Koe0/kvYI0ZLDq+8yarWD0yP
 IuE3eTfh/uU+MubagrnLQ1FSJx6Fmu4H0Eze3f9g7MbJT6Ku8s76sRP/isPw1r2KE4hk
 HsVY4Jsp2dnqpv8WTTtf1YS/NmeLYHG390iyR5K4nk2wB6XtPJOJc9a6CghpP4iBqkUD
 q152Thf0AuKF5zeSl23S/rf8OAJcDd/mfeTKFUKgrxN7hT5wQm48GG1pEF6trjJjgnOr
 5dXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU7T0lDoTOOEtp1OM+2b810HFJ/ddOROT1y1kcjWCcPHbW3xpzH4Q37icokLFfq0oFKtjZy6Qvbmze@nongnu.org
X-Gm-Message-State: AOJu0YyEUIp3ZCKdDLAiYfGabRh54Hme/G+p7FSwRfaRqNfwBilNwfkL
 dNmsEz2K35MUx//J9Qg62ulfoI5y6pEMYTDHVhZg/FBCYdLSp6LyETa0RW0l2GLPHOnwRCJjW8h
 ZULUrdsU=
X-Gm-Gg: ASbGnctdSfSvzqKNvD7SMCDhg5SO/3wfN29yP3Kr8oDkc5DVmJzB4DVA3asFobHSIS5
 tmUZM4Iazr4zooSoaGRJaCUMNG2FUOD1Uddt/W2E9a5BRVaMXz++9izj6fnHHIY7z8iVyf8IiUx
 D3GLsVU46X+7d/3Hok3XRXK4nsGZTxs+fMTebxNBOXvEFRgI+eiR0SV21O3OPnzqEuJu1XsoeaD
 ZzA+aP6v94dINnrJcqaOBHW2rUz8ZqH6RQhlMPrAiqrFjW7qE8CTzu1PuBYYCPO70L6omUhMHS6
 hZazJ6G2dqulubsMYp1ElMphYopjT0rWMgwezKbkqikcn0kthwPK+Bangse2aSxujdu+mqBzcqk
 ZbjU5fAiWnpdhw1j3cZ3NRDxSA/8Pnj015eHpaiysdmcOGD5BI68MWFpKtjQZedAfT/xYPMtLKO
 I=
X-Google-Smtp-Source: AGHT+IFBM+RbXh19ynnCR6F3Z6XF68LguzwXbe68md1ZV7gqEx/+3iWzJNFg2ORGKY6A4Evwv7RN4w==
X-Received: by 2002:a17:903:3c24:b0:263:b8f:77dd with SMTP id
 d9443c01a7336-28e9a6b1caemr32052015ad.57.1759492526272; 
 Fri, 03 Oct 2025 04:55:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d126204sm48679865ad.40.2025.10.03.04.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 04:55:25 -0700 (PDT)
Message-ID: <49533199-6585-4da3-b164-70e1570f9d82@linaro.org>
Date: Fri, 3 Oct 2025 04:55:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] QTest patches for 2025-10-01
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20251001215254.2863-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/1/25 14:52, Fabiano Rosas wrote:
> The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:
> 
>    Merge tag 'rust-ci-pull-request' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/qtest-20251001-pull-request
> 
> for you to fetch changes up to ca5be51a51fc6b6402838310ae8d0162fc03ecef:
> 
>    migration-test: strv parameter (2025-10-01 17:09:23 -0300)
> 
> ----------------------------------------------------------------
> Qtest pull request
> 
> - Fix for qtest_get_machines QEMU var caching
> - Fixes for migration-test in --without-default-devices build
> - Preparation patches for cpr-exec test

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

