Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E7EE6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDZH-0003sv-CS; Thu, 21 Nov 2024 15:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDZA-0003s9-Ro
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:14:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDZ8-0003V2-VL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:14:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso11449645e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 12:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732220053; x=1732824853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H29pBxFxINBXffnl9w0ik8vTGfUDqj/9S2AFg+FGLZs=;
 b=f2Fbl/tNMmU35iQ+CGljl0xnTTL7ZjhTpLIAbqrjH3mIu9aoK50ZVCwy556SzN3NVl
 y81xvJPfbtTMbas9U2iDyO5aG557krKsxFcIPpP9sE5ojGb8SzsIgjO6W4i03e/zuVKg
 iroKf/YOYW2JB2HDLB/VZjz/6f8N6KLf6MTqy4cTC6+l+ILv0Tp+RDbQo+lQ0xVoIGtc
 C2ThL0AxiPLZrJ5QbuROpnghNkBUVtU6RF9AKQr5J+o5SzDjJBm2y6jiBX/bn39A8Nzw
 +g7HPz8q8/qXhfktxOo6CsDhk7j6ADn1cb1YyGF+4zQuMYHNCyhQVSKqH2kVSGruovaZ
 RAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220053; x=1732824853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H29pBxFxINBXffnl9w0ik8vTGfUDqj/9S2AFg+FGLZs=;
 b=ZTF1rUmPe19jWvcFKVZGpWwtFxALtNOSgATsIxk0AwuE6aN5FzwRpoX+IXujPCke3h
 uEX1jOx1TIAt9qUsPALDjHY2PC/kO191hOxZeGBB+PG6a15kC3LAiqbiN7j03UhsRwZQ
 pow8vbkeW9nJK5O7LhFIxH+FQbY1P1X8DKaRiYdaRDC9omTNgB0qLSJILN/vWQbkla/u
 EL7Tit6PpDNPvBSGYB/wsg6Mvlm3ZP3rSlYdQCp3DWY0AfEU6h2BCh5ZzITsTs4F7JyE
 s8Pz99OARuMjbgXRwPlWn5C8ZFLW7fHclLLYbIVcYASv9/Re5GhukHp4TvmHuCK9HJdr
 iBRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+w+kVrvYgFG8wwFQ+dbA76rcB2uX68MAwHq291IWaeU9nKyVub1KZLJmNyM8xFd5qw2ki9CT1/oAF@nongnu.org
X-Gm-Message-State: AOJu0YwHCTV+2+xrDYwUU58B7qqC35sQUiSNfeJrhk6paDaHnNxTxspo
 aydcAScykSiNF7Laiz+z/l584uE+8REdp67CJtqHnZwdFTUAE/nXPCyWzay2LEg=
X-Gm-Gg: ASbGncvmoar0TG7/G+TEVgVxgGmvCNguWuRnzZ/8mQlNo06J5mQ2f7b8uCwlCekMwSP
 jrSoOtks0KhR9PFf58NcNPNFurxM+effyO3uxHnGTEGaONUnOejH4HqF3pMY4pBu9YGrzvelFBk
 pXvqpxD41m3mp7vjCN44EZfjUFoqpnpl0uMkBSJloooMOMrJloNETNw1hnqzs+CS8C2XvFtmMtJ
 WWMT+FGNjK8ArrJWbT2hP6LyhEsFHOXI4QgqGoIBK47YoJXUNxQL98/p6fgPE/vtnrZ
X-Google-Smtp-Source: AGHT+IGh1wVNvgrhVdfQCPlyxGVuv1ORCaJMPPcTENcOFK4Rz413TP3unmm7ZepiamQNUq04S7CYRw==
X-Received: by 2002:a05:600c:524b:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-433ce4b2f57mr986875e9.22.1732220050407; 
 Thu, 21 Nov 2024 12:14:10 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde10eabsm3501175e9.13.2024.11.21.12.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 12:14:09 -0800 (PST)
Message-ID: <a967912c-3568-4079-b25e-0cf03deb659b@linaro.org>
Date: Thu, 21 Nov 2024 21:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] qom: Remove container_get()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-14-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-14-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 21/11/24 20:22, Peter Xu wrote:
> Now there's no user of container_get(), remove it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object.h | 11 -----------
>   qom/container.c      | 23 -----------------------
>   2 files changed, 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


