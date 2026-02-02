Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5594E7314C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 09:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmq3m-0008Nz-39; Mon, 02 Feb 2026 04:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmq3k-0008NW-Sr
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vmq3j-0003CX-Az
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770023844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLjUO1WUQymYJ4448GU27R0/6JlmGYLn6AOEgcqfAWE=;
 b=KylQkn7X2PQx8853hv0mtpHJ4jJG2hhEabu7ftekpfYWlmT6f4RnArGzTy/OW1B8lrv+eU
 6Sw1zLPkGrNoq2gN/0HZDnciFGXbiifEUmd2pjpofthQuVaHruPtjGiIndl1nuw85A/j3Y
 EwOJk2mA4NEmgo8AS3vQAYVgVQWwcws=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-rSl2_dE4Pce5pO490TAMxQ-1; Mon, 02 Feb 2026 04:17:22 -0500
X-MC-Unique: rSl2_dE4Pce5pO490TAMxQ-1
X-Mimecast-MFC-AGG-ID: rSl2_dE4Pce5pO490TAMxQ_1770023841
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8d78d3fabfso495427466b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770023840; x=1770628640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YLjUO1WUQymYJ4448GU27R0/6JlmGYLn6AOEgcqfAWE=;
 b=PRsyugoSQGQ3p4SvK6AiuBFaM2rO8hrB+pfybk76NutkvqDR+8F/jBZ71ri7GUQqfz
 KZkz0Dklu8Dcev0ClW0vSKo6LogekgqxGJRkldRVcxMcxYAzZhWcL2+R6+C9Uftxw7hD
 jjKODyZUPAtBOc8CUEtWsyvjwehWUyRoeZyiKQjlh8CeT+/i5RjbxfPOekf1zvlavxUO
 eaT0k2jE6m4YmlkJERSKPiu12hkYXH/rMBa3i1VLRxLkyCYcbcMZwHfR4VCqfw6eFBRw
 Zin18YJgtMgHzx1wkApWXKYrc8XYaFf5ogBsG6k5ejJdGa75QlQPbCQ5RtkI6DusgcRb
 u2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770023840; x=1770628640;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLjUO1WUQymYJ4448GU27R0/6JlmGYLn6AOEgcqfAWE=;
 b=byUBeEoOWsCAOsW9k1FD6Cvi2VxI4tI2zCdUQOjDmlzJTCi3BUhYtC5A5lxwhpXwQc
 GiSMOrDpG+63iv7yBBf19cHpDq7hQDxSf2PgJzMB/eb/TgQTksTRftYYFdMzMfhMCj4g
 +Z0JyPndZ1RPPEzI9OjwP+aoEUbQAHLuCKl+nHDzi8nUogNuaVTmWZo3/jiYtghkaufT
 SNAtOsPQYE8xEs25BEPKF44i0Kc2/RdjFfHfKjOaRHVV8sagJReYv0r/BJw5N12khDm5
 nJab4aj+zR4WVDONX420B+c8mcptLTOAjbVNj4tJFjG3IJ2FcMP6AUTz6D7Pft85N2aA
 hq+g==
X-Gm-Message-State: AOJu0YxbG8fFE/w1JifEBG3EXjOGHeNVq7qCj3uVm0nRIS1jX+xVvaPm
 0OJAm/qI7YBqCsak0KnOS0CzEgqnnuVw43rPpN76R3AXSQD0rxrh7oKMgIcqWjtRwbuIuZIYLfE
 StbKnJJym50JMKXny2DPKucq8NBSysDBP6L5bLDmavv0SB93JfmcbTovpWpTYjpzUMFQ=
X-Gm-Gg: AZuq6aLNXIkEIBDTZ8gzab4TWtI3582xAoX1HooWtTQrkWCp9Kv4icviJ5vtfNJY6ir
 yTN27byGLX7oNsuj86T7CrRk89oh1OTwHFi/Nl0FxZKOtoMqi8jwfcgeCCIqhMermQgicmEQrCq
 p0LALOK81h9ToJd9RQTRFYNZxkF+c08Kv4WUF1fE2SAu9MO3C7g1FX/eMMyDoBcI0SY7++sRter
 Ja7tm3PTjMEsaTQOA4b0aaHix8oppgoelNUbL/ixvoU6Gzpigw/Y6EYds6fFuLpf2QsvPBvp6dM
 m/yRydLXwjentKMr9BNuBKNIDL2u2Tg8jRBqf19AbihnYLV88lX4YFrVH9QRmMWqvcLd5PSm7xt
 SofxhLRl6IXVgSC6O38fkqVheppi6u22useV5u1RdEWTJeGYWp8mm2muJAHOepyo6J1L6tvRKTr
 A4KLouy33VukUbKg==
X-Received: by 2002:a17:907:97c6:b0:b88:5385:59d7 with SMTP id
 a640c23a62f3a-b8dff5e9051mr669585966b.4.1770023839752; 
 Mon, 02 Feb 2026 01:17:19 -0800 (PST)
X-Received: by 2002:a17:907:97c6:b0:b88:5385:59d7 with SMTP id
 a640c23a62f3a-b8dff5e9051mr669584966b.4.1770023839317; 
 Mon, 02 Feb 2026 01:17:19 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b8dbef87254sm823247966b.12.2026.02.02.01.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 01:17:18 -0800 (PST)
Message-ID: <65ef332a-3e94-4c36-85e5-85cb2481b9bf@redhat.com>
Date: Mon, 2 Feb 2026 10:17:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] tcg/user: do not set exit_request gratuitously
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
 <20250908101241.2110068-20-pbonzini@redhat.com> <mvmqzr8hjrp.fsf@suse.de>
 <CABgObfYWC1OHHyfWCxzV92K9jAfpOGnpNLNoA-FC0-_yKNRAFA@mail.gmail.com>
 <mvm1pj3h5vm.fsf@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <mvm1pj3h5vm.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/2/26 10:06, Andreas Schwab wrote:
> On Jan 29 2026, Paolo Bonzini wrote:
> 
>> I assume you have already tried to revert it?
> 
> Sure, that's how I verified it.

Yeah, sorry for the badly worded question---I meant reverting it from 
master as opposed to just reporting the bisection result.  I'll send a 
revert.

Paolo


