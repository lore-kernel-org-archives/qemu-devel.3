Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E071C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6OED-0002PK-6s; Tue, 15 Sep 2026 04:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6OEA-0001vZ-20
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:09:18 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6OE8-0002Sh-Gh
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:09:17 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so2226363a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789459754; x=1790064554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C93NDc8vKqZoRpwpL7rR0IlKISRmjl1MDRhlNgpz9xY=;
 b=BoqZC3aKj8wus5J4lYK8KsKgm0JrRV4Brb4vZildIZkP6/un1yYSJYrm7TFGtZLg9W
 IrJDD6XNsaK2248Zo4oaAVqyfQarRkii6EMXEYqse7qpPlofiFiuJPqA0kPTrA5bvSBU
 zzwVicN6O6zuo//n+lEXIWmjpaJq9gURejTZ+JH4Ko7wW9nX1YtWaijxx8wDQuPQNth9
 b0+ACfq/YeHOKM2okkzfFxjSCN+q+nhqvPzA7ylqbQueO4i4EDoyQHQjQvg+0HbOh/4z
 JkkWpZiUokkeqdizUCbzbrd0T5vl/ZgfSDmqt7h+f+YCU9wsEdmTskb2zuu9lueBuTDm
 1uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459754; x=1790064554;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C93NDc8vKqZoRpwpL7rR0IlKISRmjl1MDRhlNgpz9xY=;
 b=QTH9l3dOfTHKE/oK4PrVhWNjz18OnDW93QsM3GPtA0O0BcX7x3HU6q4/YKtUtvw9fx
 nr39sXguh/04R5ULz2gcN6RZ+j0oVx86cSpYIGRWb2YbnfhqyVkPsbkPIQ9lVKf6xvfz
 Acrzf6mihN7SSQkH3kurpIa9GKu60vKMhimHwg/vr9/Fa+FaFoJ/0ohMr5TywdEvzbTd
 7GkjDvlycZEIo4qPo+2/D27tCWB1sGcMv1OwQjmihVcRD0V8oMFUlOy3iTvsUVsLKx5D
 prIGmwOwKLPQVEeGHmCfeqWxyG7OOrZB1IqPD9IOs8qjV569knqch7YtICvLbCaEb/h4
 TQEA==
X-Gm-Message-State: AFuF++mn9XTrNmZksc9c/jpKhfOyiReRnBL5aMoL3c+gIqO7OwIBUkEn
 g/JO4+ibkUR4/aFGtYlz+qZbmSSlATpHCf3lnIGYsblzNT0psDlJsTfN4y7u8jqhnxnHy13wn2H
 abh3g
X-Gm-Gg: AYBFou3CM5LhcT1rMQBivgJJoM6T4wjPX4QGGwdGk8xZr12EbG69ZnB9M9LxWt44sE3
 t9TIIQBmKuXWSNGWsTYHqMrTZZDhnFkMHkHrs+1V+WtzalgF94WyXfY1XdNYtRLX7vLZQeQmXN0
 x2j+6KQx7BdLcJ5DfgYsJlXJOmstJdhAUscxmp6CWu6brAGK0P4pRF5l1pZU3axzafrB7WoOrBB
 dDzWWegOWQoBtmSg7McAsNsjJkz1hLZFtEjtjVs5DU3tKsKBKqXQxSPlaaR8Zt2cpaa0aI5Hv9K
 ziQD3eG0OiG4acscy+qSC5K6iUoCv6bYFWZOqMLRp7VgB0rqXodHBk59HzQBhUFWGuxvId2CBlk
 lErmaxRp0IU8QZSu/GieyaYy1+ehyNy9lv9hvDk5DRMP4AvF6HqYGaFL9m0PdSUBVUkOj/A4GqD
 twQNLprEbERxtb9pYMF0gsnEm9XyOJZQNzuiJGYlU452wdyxyfwT0P2ESIjeFyYHXaUT+u7r5Tg
 Z5zEjKJF0RaIMVu70f9xyMe3aPOgeKlVDECds37aylmrJWLTcJ/orvhdm6A3sVXLE3QJQ==
X-Received: by 2002:a17:90b:1649:b0:39d:f60b:8121 with SMTP id
 98e67ed59e1d1-39df60b8c29mr8637273a91.17.1789459754068; 
 Tue, 15 Sep 2026 01:09:14 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:c119:8717:353:53c6?
 ([2603:800c:7900:ed00:c119:8717:353:53c6])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a598aasm29093409c88.1.2026.09.15.01.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 01:09:13 -0700 (PDT)
Message-ID: <8897d12c-096e-4032-822c-ca752a0ccc01@linaro.org>
Date: Mon, 14 Sep 2026 22:09:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: qemu-devel@nongnu.org
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
 <1a8155b3-92f2-452c-bd0f-884c3e0bef69@oss.qualcomm.com>
 <858ea3b2-689c-4110-92e2-237b7aa87fb6@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <858ea3b2-689c-4110-92e2-237b7aa87fb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/14/26 08:09, Pierrick Bouvier wrote:
>> If vdso rely on this, we need to keep .mak files for now. They
>> definitely would deserve to be buildable using meson though.
>>
> 
> For vdso, we could simply build them as part of tests/tcg and tcg-tests
> target, without having tests associated. This way they are always built,
> and people can update them by simply copying them if needed.
Why would linux-user depend on tests/tcg/?

It seems to me that the cross-compiler infrastructure belongs at 
top-level, not in tests/tcg/, for use by everything else in the tree, 
vdso and roms included.


r~

