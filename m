Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E760BC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG4E-00080Y-HL; Tue, 08 Jul 2025 17:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEsm-0003Je-Uz
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:25:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEsl-0007nE-8t
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:25:40 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6070293103cso8010629a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752006337; x=1752611137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4y0Se23pGHN7QDFGDD2v+scmtqBfXFRB7VhnG6jKf7Y=;
 b=QOdvF43WZ9oR6oCgw2KgiiJv70sJbSWsQvUXmnkKBRBQuki0VvZ5tC6TlsZqlI6YSA
 AFGCfmb87ybzAAPbyyFqFwwg1x3Si9Y7p4exrgsAiN2zGuDgns1bBI90wNscvr4fvJy1
 bSIMQ94S1047gfzQYTGUlWKXqObBe9e3hhMDUyxS0zA7ZicZgUP+LPdtua98CAUDzS6C
 xxzPqeGvIsn+2kNWFef0dMEX8IUjJo78sREn/9H4Z7QvULaI9u9qwWwABroOM+lzFWAc
 s2Smvdq7IT6e5WbRnv1cBfPyW+wAauKPkKXtHBfQOmPCi3Vv0QwX/edE0Kg9wrC/SeXG
 2lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752006337; x=1752611137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4y0Se23pGHN7QDFGDD2v+scmtqBfXFRB7VhnG6jKf7Y=;
 b=lwlFSkCd0lQP9g9O7tQlNRmlIx+SiMXJtS8bMnSGiseLZE3wfg5mCRa7DUhDEhD7kM
 Q141VNhiHQNbtF+wGsXTxk4wZx9sa2swPMTcfHRRHZ9OlrqFyRi9gI5xNvsXi8phWn1i
 tMXOTVOXrUWm9b7QgDTB52u/0Oxr9f2TEJzvsJwnHh6uXLnMD3gj7oyVNLFLOzkYXAbO
 ismGzaE79tx1eH7YINx7D/aklNp1DT8YY9k5gN753LpPRJuG+2Mljn36BwRmHDjEZppa
 vPzVWqVDf1wy+GeZ4SF6FdP7yakX5eCldlxAI9srXKtfBaM4d7zsteMO7hwzE9K68TdA
 KtJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaq7age7R0Z1jmnv76iodQKDJwTV5nXhHME2FQ0+cJr9890KZkOPSenhwdbdFAAJET5mIWuNTvJ/vH@nongnu.org
X-Gm-Message-State: AOJu0YxnmesQ6vBttYzhu5luebQVLPhJ0S/MbzeH80W+ej492nLhc6i/
 rp/ZFEvkOWpHSif5Q5azEuMw4WI1zJaz8p2QVu91KS2rZJ12OAXxV0MtISuyYvvPFOgUaJV3ZB/
 iu31A2t8=
X-Gm-Gg: ASbGncv7eAaP17XsmH37FThlH9fkbyE6xgCUNyEFTLySq4D7ILCnBwRIzHjkV6CIUU6
 K/k98ykUGgCim8fec0dszSXsYnV+8JqU2sLQd4I16IdR31NrGOEl9yI9km3DD5uraJr5oME5wxy
 JUX4c1uIlvxDKW962Yyn2l8xTZVex8LtMYNK0vsDTXpogPWkKAqvTLZ1Q66OxmlN8wp3IvXPjzS
 s+3k8zzTL9PsDpbMr2iDL7kc/GB1wGi7wL9wMhAyk7+DX6a5BcoCatF0/fX462bjF3wpDSygn7a
 r8Fd3bYMpbIUwLPUwYYDWGYUTxqxwAhVzSyQ8Lvwdpt6ykGRKWMM2wi3Rm6IvdyrhrK8+/wS2ju
 cA/I4xZv3rbJIjHn4YFPlOjrAPi9f2Q==
X-Google-Smtp-Source: AGHT+IGE3RFds1RsdX2V7WIeyYcWV0cwBK+dV6e8XlQc6P+Pv7pzZmizjLUY29zz7lvyn9NwwzGlSw==
X-Received: by 2002:a05:600c:400f:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-454b3b8a453mr93939645e9.1.1751958843571; 
 Tue, 08 Jul 2025 00:14:03 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd44ffb9sm13061975e9.14.2025.07.08.00.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 00:14:03 -0700 (PDT)
Message-ID: <526f5090-eeae-4eb8-8d1c-e006d9501f62@linaro.org>
Date: Tue, 8 Jul 2025 09:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/5] qom: qom-tree-get
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 12/5/25 15:47, Steve Sistare wrote:
> Define the qom-tree-get QAPI command, which fetches an entire tree of
> properties and values with a single QAPI call.  This is much faster
> than using qom-list plus qom-get for every node and property of the
> tree.  See qom.json for details.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   qapi/qom.json      | 56 ++++++++++++++++++++++++++++++++++++++++++
>   qom/qom-qmp-cmds.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 128 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


