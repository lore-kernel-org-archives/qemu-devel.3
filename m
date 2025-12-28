Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08313E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 10:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZnvb-0005sC-FL; Sun, 28 Dec 2025 05:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZnvS-0005ry-EB
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:23:03 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZnvR-0004iM-0J
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:23:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso34625955e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766917379; x=1767522179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hwpUEdjLWhhNd+PQLkDlil1MVgSXRWF4oHgr3CVuak4=;
 b=m3SGGzKhxaUZiPkF9eAy61GrWLmGRq58nq3mwDecNHt83np+Hel1yQ/J57rjGxk4Kc
 TPaALTudiBhzo/4ZOAdziJ1M93yP6WtiXa8oTwCjA5MRr79KhLTQ5mLIujq32ojBqNO3
 LElNBamQ7okTzwAIjnG2knfTu/RejLm/alPlxkB0du25Zt9NpYOs9xxD37Kt8g1vF3SD
 2jufcBu7pwW4GW6CkNcJq/ppda+6H96LKSxAnVafUUZQa0hI9ckxyHM5BQq4JyuTi4e2
 VmXwnmPJJwpexcoWR/Cu0+8PKTmZSBSrTiyDpympoZXHWLpEuHwk7F8/Fs+eICe2gg8q
 YEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766917379; x=1767522179;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hwpUEdjLWhhNd+PQLkDlil1MVgSXRWF4oHgr3CVuak4=;
 b=i+9SUg+IbvhW+uagsbAzxxA9z/N5P6SNsLvTi9BbDAUvciYDzfWbn8CtrXttpErrwb
 l1px4/xggC5EC3RnmpEiFjpkQcSbkaNS54mfXBdgH/PsBgcO50DpJdHKi/bkMQv4cKVH
 3n5scfVzXe6KpJNrTo5LCyqMpIYTWZApg4ixDWfGYluxvhfvgN15DORLZzT7XBluf/K/
 jmdwX0QgmbmyIuNR0Lgui8mkFmU7ZHlCzzVswCvquq/Sf/mhxHCajh6KczZKQjKiABiO
 a+VBZpI2gKvIt2xokR59P3UMJD8CJTob9hCeVD5NPQybPzbPrp+Ze4ncYefCmWS5RtsZ
 DIzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVc3QLSnlfN3HKjt6geQpCcLkwUSH2a2Qq6ySIIFuutP6LUsU3RTEtWlU4bEJR4LJD2JQT3ebC1kVJ@nongnu.org
X-Gm-Message-State: AOJu0YzsZg6z1kv8kAV6MCyiV1Ncxf4wWzs+bwYfrj9ZUj0ThbXLSW7H
 lRn0KeT0euVcNSX+bRmZjaODuRt4JCwyKBFbsCT8g1/bIbV6b79zpXZl2TYgj2Au1zA=
X-Gm-Gg: AY/fxX6AeynITqtgt2GFQBfgRQekMqDwtrzhOM/SJm8wiQhedU6SJ9JhtsI/qT9wn6X
 DkmOOTuJSGMe1XYeFl5EH96l5J4uUXyooBKmUTwpWzWqFs9OOB8SUhcI79MVupSc3puTTFwvtD4
 tkqNGxgLWqrk3Z+VjFWAlakgchGA6hZihWqNqtyQJnmGX71+/k1QZdZux5mPB1iM1sygqLuvtlZ
 GmJW4M0yPxyxCi87A+lvr3h4oWJZMb0r7gtWJ2rtRhtBAFkvdnJidUpSDa4F+2Ce5TgWpEmTVcS
 UUd8ZKQHylM5J3jcE7srGUMeyp95wIlyzXgbCt/dJp1oV4q0/BC/Zml94XFnzACi6sxwi6WUoE3
 ADfYsTwo7qYklfiLL0IwB28Rjuwl8bBFup5oif8iRdEisWUYVqVva9161o0P3+tbzl2weo9doqO
 aK4CUI8yCekQ3vgYxkiPBi7sl6CMgbPcxXCn//pw1ncBCWIZC4DYMbHppYr6JoVuYRFd/DavAd
X-Google-Smtp-Source: AGHT+IEDlhEl8YGdO01hic8aF60gkqQYUF4Erl1+wbBfs1+7Kg4eBMHSrmVKUompCpMX+Og3yvW34A==
X-Received: by 2002:a05:600c:8116:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-47d1953bc47mr268334495e9.6.1766917379258; 
 Sun, 28 Dec 2025 02:22:59 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a9687dsm225418855e9.3.2025.12.28.02.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 02:22:58 -0800 (PST)
Message-ID: <035358ad-bdd4-46c2-adb3-cfda875eb06c@linaro.org>
Date: Sun, 28 Dec 2025 11:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove old email for Bandan Das
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>
References: <20251226083207.506850-1-stefanha@redhat.com>
 <a387daeb-187a-4620-b607-a90edb8213a5@linaro.org>
In-Reply-To: <a387daeb-187a-4620-b607-a90edb8213a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/12/25 12:47, Philippe Mathieu-Daudé wrote:
> On 26/12/25 09:32, Stefan Hajnoczi wrote:
>> Bandan recently left Red Hat and emails to his old address now result in
>> bounce messages. I contacted Bandan and he asked me to remove his old
>> address on his behalf.
>>
>> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   MAINTAINERS | 1 -
>>   1 file changed, 1 deletion(-)
> 
> Thank you Stefan.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Patch queued, thanks.

