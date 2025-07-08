Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCBAC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGW8-00061b-Ey; Tue, 08 Jul 2025 18:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGH0-00028h-Or
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:54:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGGz-0003WM-Aa
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:54:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so4624305f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752011684; x=1752616484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aDNks0W2ST+2Kyd9cJMAZ/wepY6H0agLxlKceiXmheA=;
 b=d4TQmVF1jj2s1rQkFEsUQ/SyNklzxufAsqHfn0Tk6mnWoEPv2BFx76h+FxCTM65oLq
 EC6AxlWNlu3pGnGWZjKmEs9Xv7MQmX+l3TYz+VdvbbG4zniqEFtYx1fW3HQHEWFSM4f9
 yntZFQ8GYapEzxQ3z1Tc3GNhZDw9H/g0gmJgW3+Xxpn+K2dB6zOSZbPmRdQQ8tTFEkWh
 H8k+vcRQZPXFXU3bXdwfoJZJZtBaKbAiQmAGoiTl8aBombgcz0s3QjlmUIsyAWOEBgEL
 V0rE2an2UZCTTEh+l6vBp/gSZHEo8evjYArlKG7PagZk7ZQdODWCcQZXK/+w2sLWoDAR
 I+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011684; x=1752616484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aDNks0W2ST+2Kyd9cJMAZ/wepY6H0agLxlKceiXmheA=;
 b=T047eR0jos7TWDLzd5JNey8e4wC62E2k6NJOtFN43lzgZ31GjlBT/YnBCo68oofbGy
 cGj6UO14GriED3npZ3P9jrRn0y6oQTNYaXYXy7tLI/50yPQChn8I3cPG5HZukcE44/8c
 CZSd4AbsZGo0w/vT9+AJ+o6vZf7hA6XKxvHrPMTagKw0hL0fmMCT7x5iyiHLfrMXWSbn
 8gmO2I7l/IfDFWvo73KcBjL0SI0BOFNjwsR3QoJFrEUiQqO/epITXzecEM1u74Oddfxn
 YkTv1eZY/BjYHrT4hufx2iIgvYARD/4ORkv4nb+yCWw8Yl6pE+r5IMck7XA1wijh0gTH
 LArQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyS8wOU+ZME5IXvFepXml5hKYNep1wagipheD0go/t6fYGHuG96pp1OM3u/KYHyzf5DuPPnC7wmQhr@nongnu.org
X-Gm-Message-State: AOJu0YxdWztidagFF9K+IoinR+kqzacs0/MhIXdYScooyMsV5RZeqy5E
 HAxTOE/ElHHManRIZKdU1ny2BaYHtrV5SSWPOSoentPr2tDvogW9cmRFAhM1yNLcQnI=
X-Gm-Gg: ASbGncsSPxZYjvNu95y/yLqsgbjKcbdTVhIOLw6fwPnF54c3TQJ7Rm3wBo4Q+8WZqxI
 769RTcLMMQqL18PNsmtWOcOel2fKTHx6mGC4piwPKSMrc1vBArQ6vJFMVlviu85X8eBGga8IFVz
 RtSmCLg7FkG+dGwKA8TPwRsPIlOYY0R7T5MjhL0+9Kj5to3pl0dRa9smACEvtmOqvZyrm7i98t3
 LpEpp/UEbQWrPEMrFmZdqaSXcmhRH0BQvZVZ8dKDpjYw3bgMoZTW0BGljUBrgyLpVdvKuugwZUw
 yMzzuZLKTGFU2QfdI67rqlNYTY0g6VeQ6OOItv7fpg8Ani3FoCvLp/zGyIuE12iRMnpsU9SnS8a
 kvlbIMaXSfGodHEmp2SrSEO3EvShRQbD3
X-Google-Smtp-Source: AGHT+IGX8fkmP7bZpLC9aHt8LgOJI63mAe/+oEhUZe1r6aI4f7KD+puqGT90Xk7iTGXGtgS6SHspdg==
X-Received: by 2002:a05:6000:2b08:b0:3a4:d953:74a1 with SMTP id
 ffacd0b85a97d-3b5e2fed713mr570126f8f.23.1752011683620; 
 Tue, 08 Jul 2025 14:54:43 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5dfd4657dsm2429768f8f.17.2025.07.08.14.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 14:54:43 -0700 (PDT)
Message-ID: <44e6c0e9-927f-492d-9a2a-c26f2509e409@linaro.org>
Date: Tue, 8 Jul 2025 23:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] qom: qom-list-getv
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1751995472-211897-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 8/7/25 19:24, Steve Sistare wrote:
> Define the qom-list-getv command, which fetches all the properties and
> values for a list of paths.  This is faster than qom-tree-get when
> fetching a subset of the QOM tree.  See qom.json for details.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   qom/qom-qmp-cmds.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 103 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


