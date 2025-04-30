Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232B5C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 06:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA0mc-0002fg-NF; Wed, 30 Apr 2025 02:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA0mb-0002ef-3H
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:19:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA0mY-0004JH-VM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:19:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c33ac23edso63553265ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 23:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745993937; x=1746598737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vuhBp4Bb9/u3esjOMbm+MmphIZYAAo2JtX/e+Db0twk=;
 b=KW8xM3xgOIgaPnZo+Bv7rZCGCmO6G2tXH4oEbkFZB4TvLzFvR84YACa8bU5YwIN/29
 2mzlPG6FxSMjuTPst4xSwOgeleZtJWPXwoS/B9MEppdPViLnL9H4WZiUPUN/5c6NezC6
 MZ9K9PA+2M6blxlCQyeZvBzoKGsf76QleymptuyrXHA9RX4vnY9go6OBp4yxewanwsW8
 YAOAjKBjwWPdmRY7AVaEasR6QQR9xZPSJVHZyjd0AKsI46/mqeRgono2KEcgLWrx++6O
 AyQyCCqQPmDI4h27ILGgHkeCtuBqGp38/guaBvEwChvYsbYk+qiy11iUPRQVut447cxD
 4vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745993937; x=1746598737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuhBp4Bb9/u3esjOMbm+MmphIZYAAo2JtX/e+Db0twk=;
 b=XeH0JrUx9jJjmT/qlIBKrGqt0asYrqD1hm2npc4pjU1bnhyMmBAcLmOtSs4y5OWJOq
 I6zme8euSFC4zcGEyJgPKPnL/eH45vIGJUTDQXVRrmNcL2OZYLXC87NNjN8sjO/qBVws
 fzhsBEIe5Kf5SegeSdTugWWEWhgDw4yvs2iEEKQQdb+8UjsILnLEeXeAxc4eoju0iJLp
 9k65YT5K6ENm4joh6ddoTBdJZawQw0RNTAjJ5WhH7DNDqLf2P5cV36yMuXV+ki47NwXp
 PryY2v18pgUx7TFbuxoVDsSq0j4KoXnOotHecvxJddcZT+RGBXWFFg69Xzk1TkcGYFuH
 6LFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDNGkDsbKBbgbtBfOHcWRofUC5Igz6Lr8j5K3Hirp9mlfpe7ByeULxGpjWT4KgI8+Us/P/LJUa4ymc@nongnu.org
X-Gm-Message-State: AOJu0YxBOAy5znntK6LTylzAdSZl2i/g2zDTkAHn1WGM1hXzBL3Hbbkq
 6OEIeaz31g8l+gXGAiwbaLexSL10DbELqHTRBhj4VkbgKNELh9Bi4y1mKJZvvdM=
X-Gm-Gg: ASbGncvX48CjZAawwTQM+jcdJAk/24Ai+23PGENPrMoWW1O3BwvtvH6BlQ4xcyEpL0T
 P4T690GL4/9RdUDlk7UWna/gpYL3RlWSfAhsUsFnC9mT2OwAsDJo+K/QrGfAuUjZVKxDbkdvagE
 I7kds4Cg2SRe7JFuIsNrdJ3jp9t3sYXi/AhDRim3zqVXR7p1XJlyCGB/NcWQrCWbnjm78GXH1q5
 /AfHJWtx2l+OOaXkIHlJTEPI/YpiKqupjpaXU2m2hBCMqMBOfwGADMqnj8m5bF1OW0kDuzEvszm
 dIJFXEl+zOjsIzcfTr2760tPYrFaUBNYsWc795Ht3LdqMjXJVdOLbA==
X-Google-Smtp-Source: AGHT+IElr6hCatS6et7EOJVTaMT+DDQMUI21r+TIcoQR0/ArUeSyMTjS1N5Rw2sEmzNNgsfO8rb7tw==
X-Received: by 2002:a17:903:198d:b0:21f:bd66:cafa with SMTP id
 d9443c01a7336-22df34d3eabmr33981645ad.17.1745993936869; 
 Tue, 29 Apr 2025 23:18:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7bb6sm114000485ad.139.2025.04.29.23.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 23:18:56 -0700 (PDT)
Message-ID: <07577537-f506-47d2-a4f8-076a1458b5e5@linaro.org>
Date: Tue, 29 Apr 2025 23:18:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
 <3024f643-f4df-4342-8d9f-d5929e3ec2e5@redhat.com>
 <407aa670-1f96-4284-80cb-6f2b37d65c93@linaro.org>
 <86164d5c-bbd7-4402-a28f-1218e67fbe87@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <86164d5c-bbd7-4402-a28f-1218e67fbe87@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/29/25 10:40 PM, Thomas Huth wrote:
> On 29/04/2025 21.48, Pierrick Bouvier wrote:
> ...
>> I'm not keen to have a default target set, but it's a personal opinion based
>> on fear of "implicit smart choice hurts", so I'll be happy to change my mind
>> with a good argument for it.
> 
> No default target, please! We've seen this with the default machines - it
> looks convenient first, but only gives troubles in the long run. Preferred
> defaults can change in the course of time, but if you have baked in the
> logic in hundreds of scripts out there, it's hard to change it afterwards again.
> 

I'll be happy to not change my current mind as well :)

>    Thomas
> 


