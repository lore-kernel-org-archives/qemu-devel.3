Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E662C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJaRG-0007cp-0P; Mon, 26 May 2025 12:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJaRE-0007cg-JT
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJaRC-0006Jh-TH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748275948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SMfSof+ktGe44h/Yry05m8e6gpqdF+0MQ1BO8hsKn5w=;
 b=KnsyQG16OHlOzpER2F2wenH6FjIRovf/IFOHpd0mEOiXk8/kBxUAl+SYBoF00n3biWTPVq
 aT279NVA5+81+d4IXvmAf0tuCGUHHnY0XM5nKzh8BYgcaufJVZy9k3QKxYK3DNSO1NWsgd
 OBtooqeZ8CZjz4FYL8aJlCD5aL03u1M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-WFsRapM_M2avzyOK6otlFQ-1; Mon, 26 May 2025 12:12:26 -0400
X-MC-Unique: WFsRapM_M2avzyOK6otlFQ-1
X-Mimecast-MFC-AGG-ID: WFsRapM_M2avzyOK6otlFQ_1748275945
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6032d5dfc34so1897984a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 09:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748275945; x=1748880745;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SMfSof+ktGe44h/Yry05m8e6gpqdF+0MQ1BO8hsKn5w=;
 b=XvfF5OqsRnpawUPTrmzbNser5WEOQUdJc4XbWCXyIR6cqEl0Fs8idxsAlet4yAnj7A
 5ygHeaml+SFboXEiE4NE/Y9tZDCqXXBY80/Fox5cQechVyCVqw2ae6+Vv/7as92oTwPk
 k6F6FldWCZ9bR6ImZewSW/KEvlyYumvxELC1n3CtOQNN6T70Wk4pr0MDu6/KUPJGEy8/
 AFjIAEyADiWc+nEby7cAOpUm7EWi8WOa9z6IlMpjsSnlwcGDrQ/9Xc0B2dPE5dSWgtbX
 FhpMqYWpwHAMRBo6eOFtjyoIjBw291YKKNyYS9SxLEJvCFazgAk+yOlnzXFTzXrvAw8U
 4oJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC7ipeG0F8Y9nZmn5zMkFgqw2Wf/ueHSoYF5TigvXR6dvHHICOp/ulqLYLSxCPa8vWMRoCgKj3qzyn@nongnu.org
X-Gm-Message-State: AOJu0YxbeOAsy4GU9V4VQnkBW2v4y/C/9TjS22Eu5mIhfoCZNX+Fs/JQ
 fnrY9URAMtckB2sBPO1RhXnRuc5HCQhifGb60X1KBYp4+5uCsgXnbxmxPiBtw0mm84GCkPFXaKr
 V8WqKp7oZlPfb9OwkbBAw83OptmTCVy/jLPWitVkMvuW85Yz6TiD3Ix/+
X-Gm-Gg: ASbGncsn7xJz+u8AdbzEuU0PMdNmNyEuvsA9fkmTIht1FF3KBo608Hcq1f+qFoBDvYy
 dwONuqbaB3XAgxi6JDWPYSW4dNbfr2olejqT/klvzueTd607jcGPJUnEzWWUkFusDbMduAxgtjU
 PFWbTLu0R3vO8ohcxfvfIjc7UeXrQXREeqePITfZ/nbtnbvV6vyemjJNFzwDQ4RtO1NOTQiTC84
 7NGNmN+rxnrULAA36Xl4TWtjui7XfCKZH+PS81uBB7pMsjDqkPCYsyyfDfr5PUqJObW/DaswXpE
 JV4fsvhDwU1dgIfZ
X-Received: by 2002:a05:6402:13cf:b0:601:31e6:6983 with SMTP id
 4fb4d7f45d1cf-602db4afef8mr6668106a12.29.1748275945320; 
 Mon, 26 May 2025 09:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX8xslheOCDpMwwmLJ1kqAn1eD3qkBKwcHIhqfCzPzl5x2QcmbLtdU1mfX0UavWl/oGtfeXg==
X-Received: by 2002:a05:6402:13cf:b0:601:31e6:6983 with SMTP id
 4fb4d7f45d1cf-602db4afef8mr6668084a12.29.1748275945006; 
 Mon, 26 May 2025 09:12:25 -0700 (PDT)
Received: from [192.168.182.123] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6049d482cc7sm2021832a12.19.2025.05.26.09.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 09:12:24 -0700 (PDT)
Message-ID: <e994b189-d155-44d0-ae7d-78e72f3ae0de@redhat.com>
Date: Mon, 26 May 2025 18:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/55] QEMU TDX support
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/8/25 16:59, Xiaoyao Li wrote:
> This is the v9 series of TDX QEMU enabling. The series is also available
> at github:
> https://github.com/intel-staging/qemu-tdx/tree/tdx-qemu-upstream-v9
> 
> Note, this series has a dependency on
> https://lore.kernel.org/qemu-devel/20241217123932.948789-1-xiaoyao.li@intel.com/
> 
> =============
> Changes in v9
> 
> Comparing to v8, no big change in v9.
> 
> V9 mainly collects Reviewed-by tags from Daniel and Zhao Liu (Thanks to
> their review!) and v9 does some small change according to the review
> feedback of them. Please see the individual patch for the detailed
> change history.

Queued, thanks for your patience - this was a huge effort.

I'll wait until the kernel side is picked up and then send the pull request.

Paolo


