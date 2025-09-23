Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908AECAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zHH-0003yy-Es; Tue, 23 Sep 2025 05:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zHD-0003xq-41
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:25:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zHA-0003CW-SJ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:25:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e21249891so2363255e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758619530; x=1759224330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llkGKNmGq5aG3/Zafvt8p8JW7e6NWt1HXUks4Cnu7E4=;
 b=ZiUgJ7K88aYWSvYpKMyld5VddvApVHU4eYZ+mFkbvRWf+sd9LnuJv9Q/uFNGSTcYRO
 8YYSI52qXWFCzWJy4bOCydZDVCc5h5tUaOV8lcw5lWOqoHw9HOMuXCrKnOLMyh7Zardh
 IyhUz3ZUqKfXAiKvsPAAh9KgIbAwti7wsOL8jbtAToCyatBW/TQkXL9qE02cpwiVrVRs
 XKnCR2G3Uei7zDS5yqm/InFLoL8sLAstlSqhy+bCCsj5NbhV4Nj4ahliumqyUoz+INOc
 toDGC7DDvQrA43HTyJwyK0NjqXvI+gyXVSry0aqP6vfh6Maa/BbyE1fxkI2PmGvKNO0w
 LZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758619530; x=1759224330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llkGKNmGq5aG3/Zafvt8p8JW7e6NWt1HXUks4Cnu7E4=;
 b=gP2Wh46KdP4d0Z/HgbWot7gcmttWjv7ZnAC4M5+BcTNdFANkunS4txDg1dMqIe+c6y
 K4XGOBrDdDxjziC6xZJNmNkS/zyjbsIkp1b3wijuKVxfweoIVAj41ybI56cb8gp/8adG
 8YN+kVyOTwHD+QcrHLAM946EvgTuDCPOr76LEA3NX8ARVN5vZeZYgiZlBsLp46iHR8FV
 v9NchkEBV5SQ6tqhEF8ypntkgh5jqjQhY0WGqnwVR7j+44d6H7QDq2ZrAiMxs59+mSyV
 E9eFBX6lL4Ja4mjzl+CKdoWx2Gzg1xObJIYAgWfDoiHiUsluMpC/HTCDVA3hcjC3BkAq
 +9qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfD/7jpRg50y70DLiM5woFiv0ei4FMIvALqcQJJCob4Bavv/t8KWVi3O4E4dGkk48h3x72XDSerrtp@nongnu.org
X-Gm-Message-State: AOJu0Yxmk502IO1ON3hsPtBT8Ll/c1iijc1iXjBfKVng50U3FWI424cP
 ynxzT//pBgNKEBWlEDUDFLE3TKrlspVMkEpmOW7kewRE+pq1Ga60T1SzSxkOKJ+3nWs=
X-Gm-Gg: ASbGncvwyNgm5P4WbRqddVAnRJT/5MJK+gdeFmZ6NaGGzAdf9+/EdabekpZ0e2Fjjdz
 o14y3zHovy2n3uHRAvHiS5t5pj1wr7/eJ2TY2wdc+W7Vza4+gqM+7PGk3+6tMb80U+TxTJ8acLJ
 l3CpYchTfqWgUpwQlrrfUeERobb6cGVdelJt10zyabSsgVMOqvHijhk/cCOlTb0Se4RPYV4ZU3y
 Qs6pzoYzUqdu8KdtgNWGOs1fiUH6sScofWA5zO2l9yzNea8Z5LueRmVEhHMzLY6J1OF0ikz6fHJ
 wtl5JBNLsDK90EDeM4Dfa8tw6BWajHCaqaG4qYTmazXUGLWPXv8D0ibZY4TZldv2tqxAhRC6GkR
 IR37nKFshMEnHjO0qaEPEE/98laUY/mu/loVHXlW2tpbFCv6oUpqLEeeRFvOMdxs+4A==
X-Google-Smtp-Source: AGHT+IGcy7O0YKJxKIBbmv31vtkNfUvTnixGwv6udsRBOh0c98GFVcqo7OMFsVZt5E5IT/5dHrXZww==
X-Received: by 2002:a05:600c:450f:b0:465:a51d:ab with SMTP id
 5b1f17b1804b1-46e1d9943edmr17526775e9.15.1758619530170; 
 Tue, 23 Sep 2025 02:25:30 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fd84338ca2sm8062228f8f.42.2025.09.23.02.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:25:29 -0700 (PDT)
Message-ID: <cdb37c70-f5e3-4117-8d24-ff462e6bbddb@linaro.org>
Date: Tue, 23 Sep 2025 11:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] hw/remote/vfio-user: Clean up error reporting
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org,
 vsementsov@yandex-team.ru, Jagannathan Raman <jag.raman@oracle.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-6-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923091000.3180122-6-armbru@redhat.com>
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

On 23/9/25 11:09, Markus Armbruster wrote:
> VFU_OBJECT_ERROR() reports the error with error_setg(&error_abort,
> ...) when auto-shutdown is enabled, else with error_report().
> 
> Issues:
> 
> 1. The error is serious enough to warrant aborting the process when
> auto-shutdown is enabled, yet harmless enough to permit carrying on
> when it's disabled.  This makes no sense to me.
> 
> 2. Like assert(), &error_abort is strictly for programming errors.  Is
> this one?  Or should we exit(1) instead?
> 
> 3. qapi/error.h advises "don't error_setg(&error_abort, ...), use
> assert()."
> 
> This patch addresses just 3.
> 
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/remote/vfio-user-obj.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


