Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02680EE57C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soP3Z-0005OC-Ve; Wed, 11 Sep 2024 11:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP2N-0008HN-Hb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:13:44 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP2L-0001P4-RJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:13:43 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5365928acd0so6657870e87.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726067620; x=1726672420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/MkPLXzdBZAJfog27o+b6g3OKiyBb7zWDOK2MNzYaE0=;
 b=UTiBaRcVnq+MdZQOyqM2b+STzowkkoAWhIAEc7CKr0UJD9KRM6Z5gTLQdnzSMYekX8
 94mmZpJAeoJPkkEIf0ciCTOKzOQtLzhN55cMY3Ssr2Os9VJWgmOaeJvQJMu88tibYr2+
 y37o3KK0JUCzHt8AjrNz4Yk+eudSIB+qR38H9OGM+jYzgk17U/y7jftVqiO031I4xycc
 EG176+zbi6XI7va3fBt11uovoX1XUbVzcT3kEHAKyAS87F+cUnlQBy69ID2wc+Ai8x6+
 28JAkV25IzuX1HXEk59ox2ixChouiJhFHx1hEiF0mrXfNhqTOmCh698Pys/MwN8F7KLr
 rQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067620; x=1726672420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/MkPLXzdBZAJfog27o+b6g3OKiyBb7zWDOK2MNzYaE0=;
 b=o1H0vvG8g1s8GH2aBUWR6hxitqsfpdpKW+1y+LwZ6OnmWtTc6mFFE+Rom4z4bErLPW
 n4OodwZ0rDeSIIKCBZXemOPKnAXOJof7koHlvDpbquzPJbp6fT85zOaKoq5CcfuInSqS
 z5o51oJMVRgYyB77aZN862OISdWyUkvdEm3jbG+Mf4Wkm0Jm3k4Z6pWjSJ0mUG5CtDAT
 peBmmneoec17j0xP+Qji2bv+UC2nN1PKv4Odfk9G0RGjF333uKRdSfcp9glGzcc7xXWn
 mRT0Lrpyhm0QvawauKPl477wD45o3b8G0qYJzFKFYZ7e8LGUkxW/Wzi/NUzBtZg+3czE
 0gow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTxWyl1pGsm8r/ZMnVCObtiKXGIc64WF0RYfCRGDFNTFh/RCB+BpNXVCeYI+sbYe63M4i5KCGuxi+i@nongnu.org
X-Gm-Message-State: AOJu0YwxMavrEo6m+vKH4P2tXHdUYB/k68gyGK6mrRYnY+wNiwK6xUg5
 MQy1bhRZpsQK88BN6mqv98N4+rAZgrTk4jEfTDtPUrA6YU5igZ5Wm8xbZHTZzPM=
X-Google-Smtp-Source: AGHT+IHf3fQc5jOkuczKukJz+sKxAc8jtWXpk4l0N1z8V/5hahwsY92N4TXi25BbV3ohl+BvvaFpsw==
X-Received: by 2002:a05:6512:3f15:b0:52e:f2a6:8e1a with SMTP id
 2adb3069b0e04-536587b51f7mr14479490e87.29.1726067619785; 
 Wed, 11 Sep 2024 08:13:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ce96a7sm623444966b.158.2024.09.11.08.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:13:39 -0700 (PDT)
Message-ID: <bbcd989b-be54-41eb-8c8f-7d79c9ee8e2b@linaro.org>
Date: Wed, 11 Sep 2024 17:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qga: Improve error for guest-set-user-password
 parameter @crypted
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, eblake@redhat.com
References: <20240911131206.2503035-1-armbru@redhat.com>
 <20240911131206.2503035-3-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240911131206.2503035-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 11/9/24 15:12, Markus Armbruster wrote:
> The Windows version of guest-set-user-password rejects argument
> "crypted": true with the rather useless "this feature or command is
> not currently supported".  Improve to "'crypted' must be off on this
> host".
> 
> QERR_UNSUPPORTED is now unused.  Drop.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qerror.h | 3 ---
>   qga/commands-win32.c      | 2 +-
>   2 files changed, 1 insertion(+), 4 deletions(-)

\o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


