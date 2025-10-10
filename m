Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C13CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76XD-0005wE-CP; Fri, 10 Oct 2025 02:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1v76X9-0005ve-IH
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:23:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1v76Wz-00030O-8K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:23:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so10072395e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1760077385; x=1760682185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DoQY3hrgNJ0Us+w1dvCnXtWTfRZ+g2G9b6eMrDobGWk=;
 b=vQRrSgDAfieU79zzhI19BJOeZ8sdpBQdG2+EuRJBQvPDSyShAbKjTLNShAhiomoHhu
 23phIxLnytjbHTxf2jZ7rrqXzMKUDGWORy4T+LKhvkSe5lVsn38y+fGd9/lxpwn/1Tup
 fOANIspNI3IqbQvIP6+YWAap84wfMNKhSbw45Yi+Ik3iuUCaqZWk4On6z5mh3KB2Pp+a
 BS5Osx12LI8I+Gw/6JzogDIZk0/Nb9xwOwge8B9Mt+HCsA39v0QbcS8ZNKX0rJkw7Mpe
 zGfCcjRawh1ufMja6n3K/C8OEYuauARohbRdt3GCe5nZq2b2tWj+6Ui/IugsMnJtDJpa
 /kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077385; x=1760682185;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DoQY3hrgNJ0Us+w1dvCnXtWTfRZ+g2G9b6eMrDobGWk=;
 b=Ki0YNHrNzjvFXzoXqiClhrSCTfDaMj6JwJijlgOa5QW1k5lpsF+jrOaBplf4lNAMtQ
 +OlCU+ZLOTz3LhXP41qWpRR3O0JkhIBOFcZmjqCaQ2zaAusYYMRnjvhWMWP/xhlDv5iz
 8PW9gtHIp0OEFfVt8RPcTtKjxFwGebfVqIcDw1grovcafnGihiijQhy3g6czGLHrtXx0
 7MfPatsQF0vg2jTQK3WG7pWiX61YOM2OxiE7TxvgfcjZw+arxBYAc3aX8Q1+eGy8A/q0
 kMmTb2Zt/FfYM3WBIspg9ZdmI8OwtEw+qJKptbz9VLSRI7EnkUsohq9zy1SUrHrO7ued
 LTSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj3AQUsjte0s3Ob89MB6lEV3WOqsV70OAsFO7CHjzYF4ou0i1wTUXk3VrDUn6T3WA6IAHlbC+ca4QQ@nongnu.org
X-Gm-Message-State: AOJu0YzhfVSZxbF/SGvYlNRZHRlCws7o5SjIT23v7mg38Bd2zgzKFUVp
 k83ytL+716TW+GxpdO8uTiYhhMonfROhsL1zjc1FhgB0Ja14oA3Vom5g1iWeS3P5+fA=
X-Gm-Gg: ASbGncvzGAUZawkwWOLXdqdOeVxHM/dKJpOl8D6sAnnry0OqrQ4pYtPqj3l4v/liaD7
 Kw+4t0oruNw5dO9BB6xkEHV9DCijtEAfZXs7MWUEcXYYTl59P9WeMc5TkyIlZh0N1QaQRvuOikV
 jlff8Dt/qzVm0SrU0rEU0NaYA4m5Qpk7iybUsbNATAvjEcqKMJ4zn/3087UlcGoCV0U28aJmirE
 Czy6Ebd3BX2lEQx3g+ovwaZE+9fi+XhONHQA4n7G+rewRi02ik+bAFvUq7zt6HvmR9+Lu8eeeig
 Eh/p66wflR4v86xRuL31BcfgrsWT1yGVAQNavA4Ay5QWIgnlfUYfnkMl0lQE89OOD5vfevD8QEe
 3Jxrb8j8PeUVSVlqLj16Lzh920PF3HDAuYY1Gumrd3iHNSsvWMw64/0XjBgg2cVyoTEaF0P+TlH
 QenoHCKq0t+oZ8/Av6Ax0NDVh1tLqQ645rW1wbdbFBStNpTbN+zzjQsJQlGgSb4N/kQVliZnJDh
 Pfl
X-Google-Smtp-Source: AGHT+IGjMuZYSHjbZYjI47stjWxiZCXl90UWm2M72FvfhWdwaw+N4CaTYPw6Zk86Sn62vCB4ydtIhA==
X-Received: by 2002:a05:600d:8110:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-46fa9b01fb1mr74364855e9.30.1760077384089; 
 Thu, 09 Oct 2025 23:23:04 -0700 (PDT)
Received: from ?IPV6:2003:fa:af00:da00:8e63:e663:d61a:1504?
 (p200300faaf00da008e63e663d61a1504.dip0.t-ipconnect.de.
 [2003:fa:af00:da00:8e63:e663:d61a:1504])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489ac60sm30509035e9.16.2025.10.09.23.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 23:23:03 -0700 (PDT)
Message-ID: <cef783e0-d6b7-484e-bebf-5f87a398171d@grsecurity.net>
Date: Fri, 10 Oct 2025 08:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix CR2 handling for non-canonical addresses
From: Mathias Krause <minipli@grsecurity.net>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20250612142155.132175-1-minipli@grsecurity.net>
 <5f9cc1ba-4b6f-4a87-8aa8-cd684c9fa3e1@grsecurity.net>
Content-Language: en-US, de-DE
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <5f9cc1ba-4b6f-4a87-8aa8-cd684c9fa3e1@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/21/25 12:17, Mathias Krause wrote:
> On 12.06.25 16:21, Mathias Krause wrote:
>> Commit 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
>> accidentally modified CR2 for non-canonical address exceptions while these
>> should lead to a #GP / #SS instead -- without changing CR2.
>>
>> Fix that.
>>
>> A KUT test for this was submitted as [1].
>>
>> [1] https://lore.kernel.org/kvm/20250612141637.131314-1-minipli@grsecurity.net/
>>
>> Fixes: 3563362ddfae ("target/i386: Introduce structures for mmu_translate")
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>> ---
> 
> Ping!
> 
> Paolo, Richard, any take on the patch? It's a regression fix that can
> easily be verified with the KUT test failing after the commit mentioned
> in the Fixes tag and succeeding again with the below fix applied.

Ping, once more...

