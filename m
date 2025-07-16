Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246E3C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 04:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubtxf-0001jA-Ak; Wed, 16 Jul 2025 00:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubtwa-0000zO-EL
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 00:40:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubtwW-0003lA-Pw
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 00:40:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so3477734f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752640830; x=1753245630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dMq3VXb+MxY7wP+GgRoDyZgU1oB1M8c6lVbeUr1XbAE=;
 b=oMF9yMLotZQXxQAJvRlaYnHiCxAT8g7bnkUmQuFmMT2mN5pfuSAdv9Ld710YaGkJ5/
 U0XVGpxw5+Mr9hvwel0UUm4Pwh3QlHpRROI6XpedVW97aI74K/txO2STEUkNHQPyxVGi
 jZWNcwQ05p9GBs9C0TGI09+l9DTlMAtOo5yVMJHzILw5Fm2oVUNbGUFGDKD1hp3lzz3t
 DYnYEeZzJZrb184y5SJzjDraqbVcbnyVVV2wktCmilie7sCYfuKW5+lHJtQtqJPPX+4J
 cMJDVj7EeHMYqi1Al1Y1I1CM6wFoI+H83rcrADvqhrESvTsj1cYzPYYOMzkfxxCj8p3M
 Mexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752640830; x=1753245630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dMq3VXb+MxY7wP+GgRoDyZgU1oB1M8c6lVbeUr1XbAE=;
 b=ijyJljxd/s5xbEB44mvQjGeXbqTNBMjwHorxGRLQAc5i0wwdzDC9Ij6Y9XYW2A4S9l
 uGyb3ZXluiM935RBkQAGnA4BxcgD/6aJ67mRwOuFndL3zYY3fyMqrBicl6DzH0k5mt9u
 1h1JSBEy5u5gKsJMpRiFGmoz4kDw/6VnGebFH4jVcaEHSwSw6PqOvPHke5ZgdEOE6lCz
 EVNgcvP5OEVT51rzhn62iSJoSIXr7wh2k6byuF8fkvTcLK+TsiT/RGUBU/R0Wg2CE0aj
 OfMDNWVsBHlGPgU5uPIvdXcU31fCr1HIjAH+Z6Uq7IyH1616SRS6npOKx2gjv5qsa8Mi
 9LiA==
X-Gm-Message-State: AOJu0YzdrHQs+RI1zqCriaOX4Y+KqwYphgeknHo1s0LEndiLViPvybXD
 ggBhrBx9BWuvhhIS9som5xRvaGuQOkUyuDg8s6F2u6XbIlYwKOtSKVCrIKlTg1vm87s=
X-Gm-Gg: ASbGncvv7lmmGUzE5RJGUkgIK3UJgC7qc6kwT+nemUW9PlnzM4QelCNCcoce61bCJIr
 16P7owH0d/w9vDYGtF2oJuEPhmuqVaGaqpqRnugnHGa/GnfC5OmOQ3uLFG3OzD6Ncz+TTdFXItA
 JFwJb5eeckbFKdd1JFTfDOrwA78fPZjmjY8TAd7pThjZjeKpfv1dUrmHuTWtSqnO+XdEdW0jYP6
 oioOwHWHET+/bqVuTIryN8kMLP6Iq8fOXSRWkm7HEUOfdPDzj3gNu09MeIphNuhRy7qHqjeL799
 lGo6tynArTOhvSvMFBofTmlGSa48qI9HvTeaS69hYHDLY2KUwAyfUGqTpd5Gj0UpixMsNS6Yv7E
 6KFoULrPTLjVxNcghBgb636yOJ7lYpYl7cxBf2HD5BlryS88GuWM+qEZorCbf3ndDsKUbTME=
X-Google-Smtp-Source: AGHT+IH6X7Hjw8RdG+p2PSknTRqUO53icrkUaXmBWCgIvHPapew8ZmTV7u/r9+YJwHrwcfbWaW6oYw==
X-Received: by 2002:a05:6000:250f:b0:3a5:2b75:56cc with SMTP id
 ffacd0b85a97d-3b60e4d4c15mr650883f8f.23.1752640830395; 
 Tue, 15 Jul 2025 21:40:30 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562797af47sm21893195e9.3.2025.07.15.21.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 21:40:28 -0700 (PDT)
Message-ID: <7b8f77a5-c9cf-411d-9bb9-b9c72e9e98b6@linaro.org>
Date: Wed, 16 Jul 2025 06:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] Net patches
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250714053423.10415-1-jasowang@redhat.com>
 <20250715195028.GA242340@fedora>
 <CACGkMEs=VtoeLUeXHy9Uyqb+YsRrZDXO7tOJVKrhGqidsjOn8g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CACGkMEs=VtoeLUeXHy9Uyqb+YsRrZDXO7tOJVKrhGqidsjOn8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 16/7/25 04:21, Jason Wang wrote:
> Hi Stefan:
> 
> On Wed, Jul 16, 2025 at 3:55 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.
> 
> I sent a V2 of the PULL:
> 
> https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg03794.html
> 
> That includes some enhancement of AF_XDP. Considering you've merged
> V1, I wonder how to proceed.

Same happened to me last week, v2 got merged cleanly on top on v1
(at my surprise).

v1: 989dd906ed5 ("Merge tag 'accel-20250704' of https://github.com/
philmd/qemu into staging")
v2: 84d1639f286 ("Merge tag 'accel-20250704' of https://github.com/
philmd/qemu into staging")

> 
> Are you ok to include those three patches in the next pull before hard freeze?
> 
> Thanks
> 
> 


