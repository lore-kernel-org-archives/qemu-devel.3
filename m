Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F4C36001
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLhk-0007yk-BL; Thu, 20 Mar 2025 15:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLhU-0007s7-Gb
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:37:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLhS-0006rQ-Di
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:37:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22423adf751so25502965ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742499425; x=1743104225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rDZynczGmYKcos5/gHlvWtMBvIJwWjWcZ9dirhIBp64=;
 b=HGyUvI8pJjL5dCLRuAInnFIHvVEscvbxeSM2vtfAhL/AuChvdA0l5gbCSorzVVxFyF
 1qMEHfPQ1NG7VI+EA9f4mN/VJdnSo70F11TWnTimDaq5RfJbPkaH0aZbRzILAOpdBUI6
 oIrUgRKXIMu5rkRPv2NeA9n9qWpD8q0BXYjr5Mt2vPqPp28iLlsJF1OfVBCRYX7ITdaD
 7O9Jw7hYld1jNPK8yO3xVegfETd9FHljEI6XT13uQKBxCKa1Yn9eBwqavR3kNQ/5d4Aw
 Rub0WNHAPAxXwvPmsGrkB0t5xf127eF6y81mDknI38pAZ0yw5FibBOuX8IQdHUx7WYT8
 ghjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742499425; x=1743104225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDZynczGmYKcos5/gHlvWtMBvIJwWjWcZ9dirhIBp64=;
 b=gw7LrRjf8KaXhn0tZoGjVLlyQQ6kfi4tVtMSk0i4oPCcAhBhaxMYvexMaFfxaB/FHz
 hi6FEPRPntY+5mtsIiHDZZcEPaFB3rcpERwMcWHqPnjfJ0bK3pBWCY+E3L99jxivSaYB
 B988F0ROOBUHuD4zG5uROcjdWOtGlySxaecevRAfF57UuY95RS2WzqwE5KHlbDFi8jtt
 cFOtn8kZGhjdPdVfvZBYhVYww4dB+Nqv+1zikkhaJaSKWXNY6siBiyjLD2LMORnm9kFN
 A6zYc6vyLm2Z7oGPfL0k95YHUPRneTZctUL8cHYNUeltIpOxTnSLxsghVX3uYkwfhzda
 dgVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/7jsRsLaaIvPf1MAkbZANR8lzB2r53D9fbolWwmXhOcYd1pPtTitdIxorwV/I0Z5bo4Zukq5BuAKJ@nongnu.org
X-Gm-Message-State: AOJu0YzOcw98vXR6eADiErHe0IP6kZZrNfHjIv2DxqWUocEGZN+gVKGj
 AaMeO77FlGqTcXwzeLRP5xbKuJcRczuwFGNzqj0tGky/4VePlWy4z4qP9Eyo5qQ=
X-Gm-Gg: ASbGncuIgnDIeFPrDMspZ2x/d7k3PYEWzcDBNiT68WS6gMdJh5teH7dwL6QHCaR9bsW
 fPLYPkMW5tko59kcfuCEndLKOVxJWHeJpxrOETIfjRpB4/u+QuCu2c9+/w7qNXZDj2Stquk/WWh
 gWaRP3ZxKEwrsTNKstWACwoRdWihHvQ76eF1nB0cr4eDR+jc8s0bhZqVqbtLzpzyugEuXjFGWDU
 eGtfF/3RVtZbRGP5iQiTd1Dyby2WW+1FjIEmnoJ5Dr7nMQxDDellT1vpWI3mPVn9+lYcLNIjOfw
 LocmNUGn2JA1WsmZHaCASSQNHtWdsBrDCBCUEXsA7KZnjbDGyKqDLqghIA==
X-Google-Smtp-Source: AGHT+IHs5e3rSO7j7v6qa77hnKJSY9N7Ot7ICPFp6kuHOGqbiXXF3V5Wbzpk20ZeKnp5qzTqX/BUXA==
X-Received: by 2002:a17:902:d488:b0:21a:8300:b9ce with SMTP id
 d9443c01a7336-22780e2a48bmr7776605ad.49.1742499424885; 
 Thu, 20 Mar 2025 12:37:04 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b80cdsm1732055ad.129.2025.03.20.12.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:37:04 -0700 (PDT)
Message-ID: <40345494-3bfb-40c2-8837-75bc410361d2@linaro.org>
Date: Thu, 20 Mar 2025 12:37:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] include/gdbstub: fix include guard in commands.h
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250319182255.3096731-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
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

T24gMy8xOS8yNSAxMToyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGlu
Y2x1ZGUvZ2Ric3R1Yi9jb21tYW5kcy5oIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvZ2Ric3R1Yi9jb21tYW5kcy5oIGIvaW5jbHVkZS9nZGJzdHViL2NvbW1hbmRzLmgNCj4g
aW5kZXggNDBmMDUxNGZlOS4uYmZmMzY3NDg3MiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9n
ZGJzdHViL2NvbW1hbmRzLmgNCj4gKysrIGIvaW5jbHVkZS9nZGJzdHViL2NvbW1hbmRzLmgN
Cj4gQEAgLTEsNSArMSw1IEBADQo+ICAgI2lmbmRlZiBHREJTVFVCX0NPTU1BTkRTX0gNCj4g
LSNkZWZpbmUgR0RCU1RVQg0KPiArI2RlZmluZSBHREJTVFVCX0NPTU1BTkRTX0gNCj4gICAN
Cj4gICB0eXBlZGVmIHZvaWQgKCpHZGJDbWRIYW5kbGVyKShHQXJyYXkgKnBhcmFtcywgdm9p
ZCAqdXNlcl9jdHgpOw0KPiAgIA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

