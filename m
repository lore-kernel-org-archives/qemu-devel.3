Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56835C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBd5i-0002Z2-IB; Mon, 27 May 2024 12:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBd5e-0002Yd-FF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:20:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBd5c-0003s3-TJ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:20:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f44b5d0c50so22046875ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716826847; x=1717431647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UFoTAkMYsbDmtp0/E0RWsLpmiwwxgq4OtjtnxBpYSnE=;
 b=ev4LmlyZXUWcZ4zPtwo0YWjGO+K80PweImdLRVLvP/2m1nJ3vKmUToQNAaV4Q7m5R9
 2o6eqH14Sio0CYC3CoqqG3yCJOLZfyFdZf0+jm1ZBz+FQbtch86SSvGuhQIlo0oxDWe0
 /TQPfMhEbwXe1R+QaNae1Lj+x7XUan7fh+8t80vllvSrvrS2s1JayF61rEYwC2iqU3PY
 rNtobvVWArbK0IB4uuhg720M1V7wo00sxseTMEARGkSUF+RsxicSL28H/ngFy+8k4nHC
 K9hP0Q4IcWKhfwptZbvvV+a6EmymxhzC4XUMUSTLaBFdwInxnvK/eIGMcIhbPpcZqu/V
 +Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716826847; x=1717431647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFoTAkMYsbDmtp0/E0RWsLpmiwwxgq4OtjtnxBpYSnE=;
 b=EeFxKi9Hc39IqjTf4E6rLKrUtTW8EHz8BvrRYBtDf7euj7vTBrO53Unv4PzSZotvNI
 4e6I1yDrXTCWyG8cOpxMFIi6ftyx9n5QfMQNNcuprf29YwoAqSnbqlwT4IQDo60YBkpR
 Umj4vVRb8K+33NZcfSEL0TKKyaFkeslW+BJgWz+cXbWKetqcdDVMEhDuh0L8ietwApnb
 at6xU0PhbcyoYxz3brae9Wkgyb5A3T3qwz3tpK33azNGtD5qqjRGoYsm/HnGEq5gReNc
 GlFf0x81jHgFJErEwwYIZyqDHcrXs0tPfOOGtihastyhefHdhi1OaHiLveeqcHPhVBp8
 uu7w==
X-Gm-Message-State: AOJu0YylDD/nQD2wrbbz0AUFaLSJbDkQVX9ZjA6kFTa0DnJil5iXRCp5
 ptM55kzGFPJca2ePyD5EAYlgj/zy8dFldyIzopYHNKbzSWlYvzF8tD7lo54xTvk=
X-Google-Smtp-Source: AGHT+IHoDU4y3JJUAe96xyj+x0mXHKW96ObHDR6eqMRn1Pbr9Z+lVox6kqisVAKHJZWvtBS0LPgwDA==
X-Received: by 2002:a17:902:6547:b0:1f3:2457:f82a with SMTP id
 d9443c01a7336-1f44872bbe0mr100296925ad.30.1716826847406; 
 Mon, 27 May 2024 09:20:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759e56sm64673085ad.7.2024.05.27.09.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 09:20:47 -0700 (PDT)
Message-ID: <b871bf81-ed1a-4720-ae70-9dbc517f155e@linaro.org>
Date: Mon, 27 May 2024 09:20:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
 <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
 <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
 <C27AC9E0-AB61-483E-BF07-B435AABE3D13@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <C27AC9E0-AB61-483E-BF07-B435AABE3D13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/27/24 08:29, Bernhard Beschow wrote:
> I think the kernel's output indicates that the MMU is active:
> 
>    [7e849b05] *pgd=2c552831, *pte=109eb34f, *ppte=109eb83f
> 
> AFAIU, the value in brackets is a virtual address while the pte's are physical ones. Furthermore, the `info mtree` QMP command tells that the physical addresses are RAM addresses:
> 
>    0000000010000000-000000002fffffff (prio 0, ram): sabrelite.ram
> 
> So I think we can conclude this to be "normal memory" to speak in ARM terms.

Normal and Device are attributes on the page table entry.
See section G5.7 Memory region attributes in the Arm ARM.

But it's unlikely that the Linux kernel has messed this up, even back in 4.x days.

If you want to make any progress, you'll have to share a test case.


r~

