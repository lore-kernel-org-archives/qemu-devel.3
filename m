Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32D5CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 10:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuTe6-0002GS-ET; Fri, 05 Sep 2025 06:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuTe4-00029J-3l
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:26:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuTe1-0000Iv-68
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:26:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so12339595e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757067969; x=1757672769; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwZNAkA27h/XsnhDDTMtCFEtC0ytWh9MXZPPKPfD1pA=;
 b=o3riZMDMVpVaPk3Rc9L4y2Oeq5md8vHf3oBpob6T06RMGsjnEDHcP+z8rDwTP2ueHk
 IoHFjS/fBFaOZ5NDc9F35dhjTNzDBuE9nTqYKkQpV30i93pyZYwXnmFpoTEfLY8ayaae
 UgKbGwXL1iMLusg8X2O+peRbZHvdSysrdH8QGb66ewvq64BZOym0bfB/peH48KMmTU00
 n2hOMwG1XxivxInCn6jpvo4jX/pwJRWgdsw58+ycT80roKjCox093gUPZzff95JkeMDR
 H7tLgC0499iTMbAt5GpeYrn2I7ZgTmDbDUFNnLCorxiciD0EqhmrvCTW8GUaxgt1qJQs
 iC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757067969; x=1757672769;
 h=content-transfer-encoding:subject:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fwZNAkA27h/XsnhDDTMtCFEtC0ytWh9MXZPPKPfD1pA=;
 b=r9gL6gwHb7nKg3XEBAWqoWcwX24IwznuM9PyGazqX8EbGG76wAcMTGq+yF34KF+EQD
 Gc7lJ1tsHJTwjj1Fvt/REVl/JVZhEw1/DEu1ZKno5bgO/uTKob7MagSkr/mDUHlMs2FE
 +V/jrc3y1YgKbAye10pElfA650krlRjd2CWf0i6SL1cEIPDLmLTlc0OzLVvR95DeMd/f
 Z/fVs/Qc1pN4FY6PJBC0Ad5VUphpC16s9Z92TwLx8ZyjYUr74ugFSWXfeM8aoDc0xQ25
 E2bvgCYK0BrVr5hd/DkbC6JHcYFbR2lktXx4U8CCx7bQzM8Mxd2hm5QSRqQ7UYtW4b6t
 P3LQ==
X-Gm-Message-State: AOJu0YwQVwljzZpupGhf9ZWjLwvE+/A0I7PvJzDfwW+F3peUHGABYHVB
 YFwozraiWCUHl8w/cRD1+58QjyXmuoSaAg1SA1fMTi3//F92mPz0X6VQfhZhaSoVdua0oxc4Jns
 pKPAPRpw=
X-Gm-Gg: ASbGncv7+XZWws67iYxgbTWjGIjOXa1RFi5MY/pzRtBS+xmXVJ8T6Ug33f3Hu+vhbA6
 rQqNvKMpOuWeQwXXrjNvPT71+4T+QIej6B3nDhItF3NbT1lQ2w+eZRevpdbWsIURsK1pywqHk6S
 xvBiQ4vjZBJJzQf6bKjYSLWPQGISfXLkSHgSpmP5Azejxh2NvhwYSXmVilvJOkr8ICzd4nfREfY
 mWmHXiylaDlUxFGusSXQj0AdZ9/M9hIobW996PQQ0Sa4zWbMLXQOLLniu4d8xvFrPoj/IV/QL5B
 7HT+SWKZ5KGOWFf9ubivAqci3YBTTrXvxiUUq5b8K7vFrKg8lN5eQASBMXHOa/l0mMAwB9g/OzK
 pE7ii6uTY6xhSRdjn8iL7UIuGjBDPuQCicTpE
X-Google-Smtp-Source: AGHT+IHM3oeCKZ7XLe9piMRVO/PjQQfv3sqyTRxwbotgU6QpgScOYHxwZ8sx62gMCw15SfgnK1b9Fg==
X-Received: by 2002:a05:600c:4e8e:b0:45c:b601:660a with SMTP id
 5b1f17b1804b1-45cb6016789mr73134905e9.23.1757067969459; 
 Fri, 05 Sep 2025 03:26:09 -0700 (PDT)
Received: from [10.175.133.6] ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e68c83asm349337995e9.20.2025.09.05.03.26.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 03:26:09 -0700 (PDT)
Message-ID: <7ceb8d59-be3f-4dad-9e2b-9db62fbf92cb@linaro.org>
Date: Fri, 5 Sep 2025 12:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Failure of func-x86_64-memlock
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Hi guys,

This test has been failing on my laptop for a few weeks.
Any idea why?

There's nothing logged in tests/functional/x86_64/test_memlock*/*,
which itself seems like a bug.


r~

