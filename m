Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED936C35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 17:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvJXw-0005RZ-VC; Thu, 20 Mar 2025 13:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvJXt-0005QT-1M
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:19:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvJXr-0002ys-DO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:19:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so8834625e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742491141; x=1743095941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=beTK8DxgIUhFcq3agsZj6vIksVFyTpqowsQfErU0rZ0=;
 b=uWPok88McxybAo7j5G5Mc4QE/PqMM9b/5IeekLMIISiteM8LKYciMWw4nX2WIdGAiV
 vDm84rAFIH1a9T/tlRCgyS+P/pWFaLbuqARx3k0ZKxcTR6kYeqlnziCjwPvds4MLCKqn
 Nz4xv/wYAHTlu/lPwmh6HpAycGrv1t2wRp4Mf9WdNNxCn7ql0FBavE0wS96rha69nuh0
 A9JsF/OKRXRY6/ZCREgSeM+OG2KjPamgJrC7t27WSrrIj16xr4SdxCOsc6D5dmZals+U
 I5dNx1MjPYyidj3Syfbs/nDTVRH0T6R/UxMgMfe/Pdb4tf7/MB7+peCnzVDSFAActmzQ
 ET6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742491141; x=1743095941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=beTK8DxgIUhFcq3agsZj6vIksVFyTpqowsQfErU0rZ0=;
 b=A52p+Wa5KGdjIEZeH0pNNCCX6VtNDz+8q/G7p2b9Yz1vcQGs9oU2OXtDoVbPbknONY
 5IkndqqXEvWctnDKRglQ7N4my2EZNpOfnHxHGtK2j3ZPbkArSCVcigywQ0LHRopnL8wF
 5F5OHWsVTQD5FbJjgCxaZ5PmXzdaqwbyYSljvDzSO03qQXFl08KIyijRgwV6rkYat/84
 OL5muHPeWvIJuFlRDYL7/N6P9n9iutpMaEQjfqXE4s5k8pXrx8LYk/0c9gUEuj3UV0nT
 yiGh6ahgN1S5tqQrq+YWvfNb73K59WVhuuqDEVkds2ma6b/qPUrrdtpKJF4eZEVPeAqK
 JkTQ==
X-Gm-Message-State: AOJu0Yz/NjlhPr1soHJK7AqihItfqZ7aeVM926HSbq3FjayiTtjJKRex
 PFPdpUAj84Y4qaxIddHGM45ABQ68WoaifQVW+8Selu9+NwHDSgcCa6MTC5aQV3wfwgRjTboy+6c
 P
X-Gm-Gg: ASbGncv37ltMT7BN91NKBAVbYpvcGxdg5fgXed1UvefMh8HudiKk+5H0cRt0aQBlNdZ
 424DfE7vybXez1+jp79eEPydALujMOu8hWE3cPRTYsR0DZgCHJZU7/KG8p5u9Rqq8vcHIzbwn7Z
 w2AuiUIKhol+ry+HPMh6h3pgnMhF8+OMSAohFwPova4fwo51V0+eDdou+0DF3NA3VSgjhxc+61x
 /srAumtJrqEYEQVRcGp4N7KHCGtqRZjjhqil7Ru8mV0l01mzUcqKYPabt+PGSXDAttG2TyHKn1Y
 JrBypWeGP8UVlrcqAZqZFwI7l7WPe8UrZyY1s2Oub2pFTwlM7wn5SQsx+AtIdENFqWxEw814yyw
 adXsa4NWpvrbb
X-Google-Smtp-Source: AGHT+IGybu3iBqYZHlImbQMwMP5ppp9w7Lb48Gut4uSRbK/nKfGOPgIc3156OOtx9Y6XTArafxZ6Tw==
X-Received: by 2002:a05:600c:1f14:b0:43c:f5e4:895e with SMTP id
 5b1f17b1804b1-43d43781539mr67372225e9.1.1742491140623; 
 Thu, 20 Mar 2025 10:19:00 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd18621sm3717335e9.12.2025.03.20.10.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 10:19:00 -0700 (PDT)
Message-ID: <c46c1134-0057-42d2-a9dd-916bc3ca000d@linaro.org>
Date: Thu, 20 Mar 2025 18:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 0/6] qom: Add object_class_implements_type()
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250320154722.27349-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250320154722.27349-1-philmd@linaro.org>
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

On 20/3/25 16:47, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> object_class_dynamic_cast() checks whether a class implements
> a type name, and return the class casted appropriately. This
> also works with interfaces, except when an interface is
> implemented multiple times (by intermediate abstract parents /
> interfaces).

I had a chat with Pierrick where he said diamond graph often leads
to problems, so it is safer to not allow multiple inheritance that
way; and returning the casted class is simple enough.

I'll see how to do differently, effectively not pursuing this series.

> 
> This series factors object_class_implements_type() out of
> object_class_dynamic_cast() and use it (at least the meaning
> seems clearer to me when reviewing).
> 
> I could get it working with object_class_foreach() but for
> some reason fail at writing a proper test. Posting the last
> patch as RFC so we can discuss it on the list.
> 
> Regards,
> 
> Phil.


