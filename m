Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640AACCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkkE-0000kj-Ew; Mon, 19 Oct 2026 06:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIkkB-0000kR-LG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:37:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIkk9-0001Rh-Ry
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:37:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso15496005e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792406244; x=1793011044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zm7oir+fRv/Ck6RiJaa/XQ5jO1620I7UtHhr1YZ4Fb0=;
 b=l9DlBUOdx8wiFj6IDDGHVfVaC8Gc2q9wtlPP5YwMhDyg94sv6ayXWhRhAH65Pj9bYJ
 ScoWN9EtglwMja+lp1BuDVofvao6h7Db3oKupjXCb0grqw38FWrrU612l+anFoSn9kAF
 VK/MbbQJR9c21EA6nTGb2KuYkxynYV4uQtQyxFKnXledki41g8uQ2xO6sj6B4fQsG3m9
 AkiWEO2c+6w7VsiLzAHs/rxPLYLaL9nWh5U6387Qt/cUjhQ3V8ftM9ewPZyG5HPrss9H
 +t2CEZTmpC1+OmUCzg2WxF0ODR3HHlAHK3DBIvm+BdTrfqCW2W2pEqYMUEbeaywMXYYV
 rB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792406244; x=1793011044;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zm7oir+fRv/Ck6RiJaa/XQ5jO1620I7UtHhr1YZ4Fb0=;
 b=2IiLVj62veKI58eiePi1lKh+lw4kf/ymAwmNlee93AgMzKzHtK2T+RuI3gZ9tlafZ7
 9hyzTa2jG7PyNfw/y/7w7OXlgLZiz1Ug8MUquxLCMEa43HxhSgWcSWEyWjyh2LDBLI07
 +yJFf9WBedcFR6DHhNdbx8MA88AYTLwr9hpHTJoWGfG4LdEVd08xbcu72TJrB6q8Pwh6
 dT8ZAq3qmBcCVm7ztJrCVxGUxzZKzX0/E6wYCxQPW/C14SxfaOKL3IyjugW3nJ77acJ9
 YlP7hOAnh46IjjwjLc1reMRoF6eENMrGbKUZkA6sgSv+Xcxh4SM5HJPpip0+7rUzrU4G
 HrLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFE8BfQzSXSD1vFdTKWtNZCTUwpdW+olav0jUe10fkzD/KHF9REgj+uIjgf+/90Exzm56k4cx51nvs@nongnu.org
X-Gm-Message-State: AFq9FYLa5QtmPRP8radv8wqQuM7OcG1hcCJdWfhGlVL7yv8Efbd3GgXi
 ERFWLb7KnIKgOX+LMEJf5Pw1VwtVmnguZpDuumw6TW6lIZREAwQq/d6Ilz//Vc89A7RChD5Dyx6
 KmA6c8PQ=
X-Gm-Gg: AYBFou1p1oD1kD4hxPjwflis6qK3GS5BUgVCLVWjkK8bG5DU6e41AyU9SN6k9FC2OlD
 V6YqVWkN8LPSRguny9O0hNYWWo2e59RPkteb6leUO+dIBQJ8Fdu3MHs5XFpMA165agaW6SJXrAT
 Q5TTAhBwy+vnBNsOfb90yYlsuWqIYiBHVpyve5tmt22v1uApjKKwp7ERBXo28+n49EvYFiryKHK
 TfQno1bihovCi0MGJ0PfXsyWLU10iZCNjmtT+BNjDlbsMkf1fx0ViarH7D0j3ozvH/Rpb4QsbV9
 DPY+DDQiAAYY/mMWTiRa7XSxBZ0JC7FSeaTwx0/kPsBBsN9Et+Q9xqj+qtFBmj7czYccDOvpZGs
 5O5W1PSKhrmL+TBJKPWakV05LWepv5z6dHlIvpnGgf9gIEXZhzJkqBBS7+izsd8qSz8Dc3g6aD/
 dwbihM5bONXP47dscwY8jBO3eRSO3T8tUoVEboS5B4vuxPv7wFTU78oDXOuKSFQkxkG6V6V7NQ2
 W1iViiilHGOyHLYGRHdsOZVwYvoltNlNZxKWCpiMsb8k7pR/zy9UAYJ479S7Q==
X-Received: by 2002:a05:600c:8b6b:b0:4a1:e7ce:10a4 with SMTP id
 5b1f17b1804b1-4a1e7ce1832mr48550435e9.29.1792406243915; 
 Mon, 19 Oct 2026 03:37:23 -0700 (PDT)
Received: from [10.89.180.227] (cust-east-par-46-193-64-64.cust.wifirst.net.
 [46.193.64.64]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce02d619sm179411855e9.3.2026.10.19.03.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 03:37:23 -0700 (PDT)
Message-ID: <56c20d8c-cc4b-497e-891d-e06cd79808dd@linaro.org>
Date: Mon, 19 Oct 2026 12:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v4 00/13] NBD patches through 2026-10-08
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261016185029.1275855-15-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261016185029.1275855-15-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/16/26 20:48, Eric Blake wrote:
> The following changes since commit a19f59a72d96056d9a8f48cf6c77f5787491e414:
> 
>    Merge tag 'pull-hex-20261015' ofhttps://github.com/qualcomm/qemu into staging (2026-10-16 07:50:02 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-10-08-v4
> 
> for you to fetch changes up to 137374d861a3507e18d9154c5266e20c92371e20:
> 
>    iotests/iothreads-nbd-export: Skip on s390 (2026-10-16 10:23:05 -0500)
> 
> [v4: Drop 2 patches from Guillaume Vinke while we sort out testsuite issues]
> 
> ----------------------------------------------------------------
> NBD patches through 2026-10-08
> 
> Several fixes, including:
> - Eric Blake: Update MAINTAINERS, support qemu-nbd -s -l
> - Fiona Ebner: Report flush error on qemu-img convert
> - Denis V. Lunev: Fix postcopy dirty bitmap migration
> - Eric Farman: Several iotest improvements

Applied, thanks.

r~

