Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846A8CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DVa-0001BF-Dm; Fri, 10 Oct 2025 09:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7DVF-0000zo-8O
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7DV6-0001Mi-1C
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760104173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PZGiARDnJ3OCsDFm1//p6e8yVlJRE1MyXnt0eHikekk=;
 b=S5BwNlj1QFMK2GWpq/EpWRqhor1aQ6f3y8xDIE5E/B/UVR+yRwToahorxowH2afJU6hHeq
 BMDIUKintuQOfh+y2WuIWdXQUmoJFMbjNcw92AGzOHiBkpW03kih7MwxEXhRyMuD1nhUNp
 5sIIhnJkL9PZ6KhtQHsTHs1Zm1jsVDw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-3iynBSv_Pj2koCnSI1m7NA-1; Fri, 10 Oct 2025 09:49:32 -0400
X-MC-Unique: 3iynBSv_Pj2koCnSI1m7NA-1
X-Mimecast-MFC-AGG-ID: 3iynBSv_Pj2koCnSI1m7NA_1760104171
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-634700fe857so3445409a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760104171; x=1760708971;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZGiARDnJ3OCsDFm1//p6e8yVlJRE1MyXnt0eHikekk=;
 b=VMQU4fuE73SBSe69kpVK3+X1Emq89bnctWcn3Qww9wbOP6jvFv/1ojOyvMVGEwemx9
 hQ0/e5CiBldnOlGiKTwQa/SIXGPApilQoGfVORENX3jvoO1W+BtuWoR/fNQLoS27Jd3d
 /idPYIM8Guz/D5Qd+Q5wn7LrF0GRxEFgX5JbswK5QqFtiVYM+wxReMmnRf0yWmV8hj9r
 dcQ6TQygJWiPj5ROCe0unTeoRseBcbW/02KyxMvN6i1PVssuG2WNZg+8AswDWHH1s/0n
 b1YhYYAau7F4wohttdWeeUIo1wxF2XGPM1ljmZ/bL2r/iOF3yE706YoXfyoXJXaldyfB
 a2Mw==
X-Gm-Message-State: AOJu0Yy2qfFSxkZjkkmQjsYbgQOok0DT1b5yI4TsSsvOo/Qx5ySLo7rk
 2tbIh7sRw/mzbNe5NH4VBPUhT5TvMMSx6eUoUOFB00F4tL3qjEuh9PyO2C2YiF0A2FMH/hxENOk
 ikd4OGiMY8silwVQJT3mN0HNbtphLs7wvc2YTarLdB1cMvhrTzRMZkPnB
X-Gm-Gg: ASbGncubjJylZqu3OtjRthceD5XPOXbzkJIN9H3ZsRu3qdMnjRkpLmvcw/Qj3fbnULM
 A6K4zNPpgkfWc1sQS7jeAKVbC3n5UOrgpO9uHz3JyDIE+bJi5sCo2n3VyyEx9SMSINRtdhWXChO
 UVR52P6E7kg9JAMANFLdDVHFKes1C/GAJd6rP/axUFD3vzDsV6NliW4srqRNf6KmQUZ6UfbS2kh
 YSaFHkjeqgqAXR1Se4kGngj5K5TPHWWacFZw+AyrWYGGbXornnQ9PdYjEJMCm4aRytr/FQRjykI
 JyRUaive4cCPfzrejwzneW+Cz2J1IGGyjPDb26ygxfxIWzFr7UyT+NBifNSZHLnnJ9DqVI03ie8
 K+d/fKQ5DVIVdsWn0DSY2tIQKEeaaQ+gQGx7CMaJRPCly
X-Received: by 2002:a05:6402:40cd:b0:639:f9af:6b28 with SMTP id
 4fb4d7f45d1cf-639f9af6f1amr7600208a12.7.1760104171022; 
 Fri, 10 Oct 2025 06:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjgls0VMN6gygbW87z1TgGJQHtnVGNl8gc+xpQsa1nAbnx5DiMVWeXGZMo5NSpmOqNE4HZgg==
X-Received: by 2002:a05:6402:40cd:b0:639:f9af:6b28 with SMTP id
 4fb4d7f45d1cf-639f9af6f1amr7600175a12.7.1760104170582; 
 Fri, 10 Oct 2025 06:49:30 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.231.162])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c32249esm2309432a12.41.2025.10.10.06.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 06:49:29 -0700 (PDT)
Message-ID: <12439b02-9273-41b3-85f3-c98e319194ec@redhat.com>
Date: Fri, 10 Oct 2025 15:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tracetool: add mypy --strict checking [AI discussion
 ahead!]
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <87ikgpn9oz.fsf@pond.sub.org> <aOY-PFGNPY7aOwkJ@redhat.com>
 <87cy6vhqz2.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87cy6vhqz2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/25 14:38, Markus Armbruster wrote:
> The boundary between legal and illegal is a superposition of fuzzy,
> squiggly lines, one per jurisdiction.
> 
> We can only try to approximate it from the legal side.
> The tighter we try to approximate, the more risk we take on.
> 
> In addition, tighter approximations can be difficult to understand and
> apply.

I agree.

> [Strong argument why type annotations are low risk snipped...]

Note that type annotations are pretty much the upper bound of what I 
would consider a mechanical change.  I would expect, for most cases, 
that "include the prompt in the commit message" and the boringness of 
the change are together already a satisfactory explanation.

At the same time, I decided to try with a more complex change to 1) 
avoid a slippery slope; it's easier to do so if you look at the hard 
cases from the beginning, and Daniel did that very, very well; 2) probe 
the limitations of the tool and ascertain if it's even worthwhile having 
an exception.

>> There's a definite "slippery slope" situation. The incentive for
>> contributors will be to search out reasons to justify why a work
>> matches the AI exception,
> 
> „Libenter homines id quod volunt credunt.“

Yes, and that's why we should strive for simplicity if we are to have 
exceptions.  If you cannot convince me with the prompt that your change 
is mechanical/non-creative, don't even bother making complicated and 
probably wrong legal arguments.

Paying a certain price upfront (i.e., now) is fine, but in the long term 
the maintainer's job wrt AI should be and remain easy.  There has to be 
a cost, but then the same would be true with any policy other than 
"don't ask, don't tell"---including zero tolerance.

Paolo


