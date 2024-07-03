Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD7AC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvco-0006Oj-5u; Wed, 03 Jul 2024 04:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvcm-0006Nq-FR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:46:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvck-0004cM-Sb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:46:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-36789d19ffbso656797f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996357; x=1720601157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3kyB10XBC9AVxvUjL42/f7HgNS/nv4mX9emJS68o0Go=;
 b=Wj8NGvftFCK9+GOKPZPwM5yvYKXvpNknB+KICU9mVEwoWwDyKYI8CWMxMp5FzI7IGt
 +sOuKRp+lrc763lllY0hpLuNU3ybxkEGkem3N32EMjU1fFbUynwlX8UB3NG7TBAR4sab
 399UGss624+ABPOSVa3mUFrYHRdxyhKWWwjA9UaCvoI7hacoy6/xolZNrv7v5t7hQxS6
 y7GsV+i6S2ZdhxbVJkIhFkuS6h6qKIqjt/FCwVcQVj7Ghvd+Z1fnPOm3O96Tkq+2VvEV
 z+EEpZMOfpXTGOReG8b3PYmum5nsuaTi48ZObDsfHVHmYzoZ82EpU+FZEnPSakAa4XOC
 F6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996357; x=1720601157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3kyB10XBC9AVxvUjL42/f7HgNS/nv4mX9emJS68o0Go=;
 b=Y+QuuIDxt3ZsB3P2fSrmr1AgyC89t2P4z+w/Odx9IAg1GnBTa3eBIbGjyUXItd8LIx
 /f+1OjqwV9eb9c3jJqf8uPhNkNt/T0zSpF6GNbiBmsURXsGngpbX/T0g7xWvVncMlV6b
 DNcqbO+S898h6+YL80q6G4kDnsG+inrMhpiyxc9XgDdmpECOhDryb5DqSPISyugumT45
 GIpe4Q8NSyy8SxewbWWpDfVAuvgptN3HHifhPRx/BS2HL5D3qDFYVKNbluuSErZLGNaS
 EbUVDBuYLib4rX4d+BRUle62AVLQ5H0TugnZbJtDW9dsCp5nwJJv2vGWcOSY6uRT/IlI
 uCcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzqzikQPN6BwOmeLP4RvdtxBRBxLlGQICq5EBTqrCwdd0z0eYl1C4N1yWJox0m2kqT4yYQBJcFE7kpp9iUxvZamp677Fk=
X-Gm-Message-State: AOJu0Yyl/C1o6y6colYXdu8mo8r9acgVEdwFRUn3fKxy2hBAaSeNcFm8
 ycCCvdBsJEDpu/iJax76AjAzTcSeNYrUZjkhLUE5AJL4sXJi8yXvNEPgCuPAVoU=
X-Google-Smtp-Source: AGHT+IGe3OnmxzlVrN72bK/cBSnawIaGZ120FBse7MrFvYYEfWRRgnRFrYbO4eoddK6lkWN+55cNZQ==
X-Received: by 2002:adf:fc82:0:b0:367:9522:5e6b with SMTP id
 ffacd0b85a97d-36795225eeamr494001f8f.45.1719996357373; 
 Wed, 03 Jul 2024 01:45:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd634sm15460700f8f.9.2024.07.03.01.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:45:56 -0700 (PDT)
Message-ID: <024f9336-6722-41f8-b6eb-2380d9e7cd81@linaro.org>
Date: Wed, 3 Jul 2024 10:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] qga: move linux suspend command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613150127.1361931-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/6/24 17:01, Daniel P. Berrangé wrote:
> The qmp_guest_suspend_{disk,ram,hybrid} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-linux.c | 265 +++++++++++++++++++++++++++++++++++++++++++
>   qga/commands-posix.c | 265 -------------------------------------------
>   2 files changed, 265 insertions(+), 265 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


