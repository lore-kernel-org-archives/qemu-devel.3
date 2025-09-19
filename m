Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73F2CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 20:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzi0x-0002Wc-0C; Fri, 19 Sep 2025 16:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzi0u-0002Sa-JW
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:47:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzi0q-0004dh-4y
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:47:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-26e68904f0eso5859575ad.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758314841; x=1758919641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LUA+8tq/Yho03D51r1jWQCbPgNInY3P1m0qCT/UcC8o=;
 b=P8nbZsxEa8BSL9x7710zbF94MOGDn2CmE57UoPnMH+oNYObOUDXVerSnJuRLuvmAnW
 F3j8rR4oYcbbCvpCDGf7aA76+1EA+5Uk5cLp3kT1vLbfCoEeEMt5aGu0XBxngc8WmV0C
 2jMIdbIuRxx6/Zlcg2YzYqarWjFSkT1GhQ6yizKDNKjWryOd3y1/MW0EcrHhwKhguyZw
 jY1KFzufPAOhpWFyFiWGTdIB/8GFkZsZ8/5mru6M+lGBpxjQUyRcjVe40rEjaoQuN1A8
 ZyuxJCifo4hKD3tYXcv10+u7jOWjCbx727twNWxvj4VPzZoecojHMyVZDhWKB68DhJ0c
 12pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758314841; x=1758919641;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LUA+8tq/Yho03D51r1jWQCbPgNInY3P1m0qCT/UcC8o=;
 b=tBWjEJImVUtcTGjgwf+6OdDvTWP29Me1NA81lCwelfZ0DAcnsqRYJPBy7J7y4Xu1ni
 CiZQQj2LLBgT+JSKxzA/EKpafXVs2Xqbr8XUyqJ1sktf5jPnonk19Z9XOjTNcA/Ro7Qa
 hZcRy8jvadLxOG8w48WCmCXmfYjcyZF7SgCIdduVTnENeuyKYhBuDLD3V7In+nNYu5m3
 b3duhKpLDKfTDT/f2GzDG4sdOrhm/sxmcI3KQMlu+RVzSvhueIKlaZbuMgcEnSoN4KDy
 9/0noSTsn4nG3+S0GVVNjMqnIXfwGaEsTybW7FfbNqGgWcRa+TDW33fH2TyT8PrlMTa7
 LoYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHZwCjZgHU7LokeOSS/XgP6xNKd5u67LlXJDbZJOREgqR7EB/IBSjERDhrdudCzH7BmKmxewCXtgAF@nongnu.org
X-Gm-Message-State: AOJu0YxwJq8tf9060jRcT4DRcgIuC4hYo5HFqjeRHg7o2FdDdRMn/15e
 gbznracYAFC2mSPwwL31oGo9rDPoHAd/DvseZS6UXj8xIuY1iDNAojMKAKE2gTFXMBY=
X-Gm-Gg: ASbGncu6CQs2VpgOdz1zycGROoudD3NkIy4iSIPl/cqpuq1g8c3i8PEaCTxdQz07ghv
 3NaDZk4406UZ/bR6lncyURH38IEY84+ugn5NxbS8WiwacFypQptCTeDRZzokARPQUNkF5es5vT8
 2/NMPk4ZE5W+HmOjwZmtqCUcuXQbzEtL03f28KJuJtpNEctS5NoTTCTkWbuvPiYNGPxIYYaEKgo
 dw1a4PVJVbda7QEssTSKmYisP73jlUX56AykIZaMKd0DidOZHU1E/ItI8jGcTKTn0Bz5YE8UbJq
 4HR0K9W3BzoDxGbpJb9tTWarN6ybgRIJrTJSn6yfILHhZ45eH4AjOBVtmOO5GrOMvo9tWTvDOLk
 oTWRghU/VWiLd+H9+FfaDRr5p7TBRIGAkLVVp
X-Google-Smtp-Source: AGHT+IGMVrAkNej6eiccTkou+8/zO6DrOx5WaJEH7zw31BxA0z0A0q/nr9FV76qmCJ0zbBmL5nUiNw==
X-Received: by 2002:a17:903:3d10:b0:262:79a:93fb with SMTP id
 d9443c01a7336-269ba534dacmr67352005ad.32.1758314841115; 
 Fri, 19 Sep 2025 13:47:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269803601a5sm63686175ad.141.2025.09.19.13.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 13:47:20 -0700 (PDT)
Message-ID: <35851c99-262f-4109-a153-fdca86e05239@linaro.org>
Date: Fri, 19 Sep 2025 13:47:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] 9p queue 2025-09-18
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Mark Johnston <markj@freebsd.org>,
 Peter Foley <pefoley@google.com>
References: <cover.1758224558.git.qemu_oss@crudebyte.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1758224558.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 9/18/25 12:42, Christian Schoenebeck wrote:
> The following changes since commit e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6:
> 
>    Merge tag 'pull-loongarch-20250918' ofhttps://github.com/gaosong715/qemu into staging (2025-09-18 07:08:08 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/cschoenebeck/qemu.git tags/pull-9p-20250918
> 
> for you to fetch changes up to c921e5496f23221335bea0c9104364409cd0b2b8:
> 
>    9pfs: Stop including gstrfuncs.h (2025-09-18 21:21:29 +0200)
> 
> ----------------------------------------------------------------
> 9pfs changes:
> 
> * Add FreeBSD host support.
> 
> * Fix glib header inclusion.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

