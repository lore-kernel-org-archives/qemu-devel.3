Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1844C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEunC-0003yD-An; Wed, 05 Jun 2024 13:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEunA-0003xW-F5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:51:20 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEun8-0002sW-JF
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:51:20 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7026ad046a2so34309b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717609877; x=1718214677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YNWvgzls6aTiLbYKjJgpnxN4ND2a1tUuYX0J8a/VPbU=;
 b=PYSdVE87reuGWH3cKZYDQbcg4oBQH+oIB2J1JKi/+YJ2MxyKy6QrWBMk3A1HJ8SnP1
 +/b1Gy8ga28AIsM+T2t+GSKyrDHuKWdIwiEmXSjuqWtRaGyvYKz+6R/wMIlJrPKuFCkZ
 oVI+z4X8QmfoQBb/feRKD3pU/pv3mAgpgMfAxi0jItLCu7+iAgn0N/hrfFuhwDmS8RUU
 4fVjxVQhiQz6ostrZk+sNGvPoonnUaulKEHZzra93AZpEpbBROqY+YEaX0WDDKjBkGZ0
 3KyTHdbGsk0fcwZMH6QX7GVdzpdpom9hlsL6pfClkmrKL68y4Hn79LmokmuQG7ZPT/vy
 9W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717609877; x=1718214677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YNWvgzls6aTiLbYKjJgpnxN4ND2a1tUuYX0J8a/VPbU=;
 b=Ln8JxJFXhF5XrKeFrEZUfWLtdDwqAl2TtpvhGPv1m8ZnuA3X/WduwM74pjAkPWRkgj
 uya9+SMPe4Yi0RB1hwWvFkiiydk77wDcbhHa+QtzxTLFtF6LNUrNZlX7waEuYuw0cief
 fZ4WiCmwwe2/rW9BsApkZIqOQkJUahDnQm3U4ZqnGEcrsfDTmrYHYlrKgqCdKp8B+4zE
 BKUNFkpfnY7E8joDGCzMe0yI7q/VWEIT8oamDQNJdQAiaNTQxZ89uZeN7QmiyUbQMlMo
 3ZTjJ2IB2mpnJsG7TNIp1f3jAWDvHiU0RQ5ys7J4DAfhkw3u/XD0a+XY3gkBb4AQDj53
 Etxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZNES1UUWor0n5z1K2QfMS5YpwcnV7/iY7QZHqiQp0Be9YpRQVqKhopVZo/IFfy+zDa9Ib2qQK1m/WAbHZmdiR/Jzcu58=
X-Gm-Message-State: AOJu0YwC6UAWv7cnTaCu5hNkM51LnEDBUVLd2z5HyqxHmNPKg3FXqnvt
 uMhfH0vDhqVomRcfQV3LkQpHuB83+zMnf/EZ2HC1NbSc/aJGIE7vabSIwb8fHY/E5AOu41RpZzb
 E
X-Google-Smtp-Source: AGHT+IHBKYzheE95bCNnY3kYfGCTyWnyZSjQsB8Ej5lfWYHeTTl0ebAxFztTR2T+/aUy5+8D6VMwqQ==
X-Received: by 2002:a05:6a20:2588:b0:1b1:e35f:3eeb with SMTP id
 adf61e73a8af0-1b2b712f787mr3749045637.46.1717609876811; 
 Wed, 05 Jun 2024 10:51:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242af1288sm8872378b3a.134.2024.06.05.10.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 10:51:16 -0700 (PDT)
Message-ID: <9e700c57-7fbb-4073-bec2-4d6328a16650@linaro.org>
Date: Wed, 5 Jun 2024 10:51:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/acpi: Generic Port Affinity Structure support
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, qemu-devel@nongnu.org
References: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
 <20240524100507.32106-4-Jonathan.Cameron@huawei.com>
 <20240605172025.00003ebc@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240605172025.00003ebc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/5/24 11:21, Jonathan Cameron via wrote:
> On Fri, 24 May 2024 11:05:04 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
>> These are very similar to the recently added Generic Initiators
>> but instead of representing an initiator of memory traffic they
>> represent an edge point beyond which may lie either targets or
>> initiators.  Here we add these ports such that they may
>> be targets of hmat_lb records to describe the latency and
>> bandwidth from host side initiators to the port.  A descoverable
>> mechanism such as UEFI CDAT read from CXL devices and switches
>> is used to discover the remainder fo the path and the OS can build
>> up full latency and bandwidth numbers as need for work and data
>> placement decisions.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> To join up the streams.  The tests added in this series failed
> CI on s390 bios-tables-test.
> 
> https://lore.kernel.org/qemu-devel/ad6d572b-f39e-43ff-b11b-74fbe8ae3148@linaro.org/T/#m0f6531d67ba28663bd35b359e32ddfea42db2dea
> 
> has my current theory on why and Richard is grabbing the SRAT table
> which will hopefully have this as the smoking gun.
> 
> Comes back to my normal question to management.  Can I have an s390
> for tests?  Where are those up to date big endian test boxes for
> every developer to have on their desks?

In this particular case, it's easy to reproduce within an emulated s390x chroot.

Annoyingly, while the gcc compile farm has a big-endian ppc64 host, the OS install is 
obsolete centos 7 so it's no longer possible to build there.  Nor is there an s390x.  So 
there are no usable big-endian hosts there.

We have an s390x for qemu CI use, obviously, but I can't give out access to that.


r~

