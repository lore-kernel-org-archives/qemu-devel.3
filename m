Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB1D1D485
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBJk-0006CL-8d; Fri, 09 Jan 2026 07:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veBJ7-0005hS-CE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veBJ4-0001BG-T4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767960568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z8Oy2HdKz+jorEMRBnm2EuOPjz+pXynn9DkCLEKOX9I=;
 b=COV6AmfiMiHmXIqhEECkLQBVCcp7vGt/S9MNqT7oeGlcrWwVe0CPhCEfYK5LaYJT92W+id
 VKwakwyxUuBLMuy73LOtUQwtB4Lg2yTFss7KPwu9mbWgdSXh+Y8vOCgKZTAeLzqu4UEQ5m
 O8kqSvAC+OTTz52flcpohykkY5kpzHY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-wfNtYEk1NEy6_Qgcc9lqUA-1; Fri, 09 Jan 2026 07:09:27 -0500
X-MC-Unique: wfNtYEk1NEy6_Qgcc9lqUA-1
X-Mimecast-MFC-AGG-ID: wfNtYEk1NEy6_Qgcc9lqUA_1767960566
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430ffc4dc83so3468407f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 04:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767960566; x=1768565366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=z8Oy2HdKz+jorEMRBnm2EuOPjz+pXynn9DkCLEKOX9I=;
 b=PKQez7uiNhle9SXTsomRZtv0LOpXbku9KQULOgOfWYVyvhMplYEcyKBGk0TBFmi2FN
 bEZOR/4CKo1Vh8Sq0IOBypGyzU+ywSWkJDnNYexFsA/roJVUmz1Y6Sf8EIl5nXBcHosa
 bXEeNgILgC1IDCrk3ARM6vZIgZo12t+J1AaCrKtJSbL2RvbO3lfxgWmrMA7ooJFzqRUX
 HM/48QdH5AZXbT5Ihj/ZBEyz5hty+lUKPR5fTHC456SPEj0zYU6aITi7WTx4Q6+1AHZ3
 mkQw0r1Zwjj8iZMfQUrO8x+zr9S61p5VvKD/nx++f9nxzVB4dSGU+sHEvEQJnTRA3O2G
 6YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767960566; x=1768565366;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8Oy2HdKz+jorEMRBnm2EuOPjz+pXynn9DkCLEKOX9I=;
 b=LbZt06JK0I2wShMQP2m55ZwY66ydr6K/qEzYuQLCdKZNJvMkT2LP1K96kqik/83ifV
 Yi0mvEEMoNTp3WIS+UX3DQOkpKoJ3e6oH0Cbhp6TG5vQ/vmPIOhtWwJP8GHqOBO/EOlh
 pik1P8tJCUO0EIndOe+fvkRa/nYWW+J8//Flsmk1+emMhYkf0kEXLtCJvu7aZJmkTley
 4VAKHAyncmmoUPMhdPaRfrB0lIEM1BnntAw0ArPIsndUmNeLsxhzBiy+husx020/CNee
 VuwHn/z2nUG5vrWZ6H8Q9OEjgi9fWdtwWQSGFZfZBroDnMm+OmpyS67XNmIUcm3aOujC
 tKww==
X-Gm-Message-State: AOJu0Yw9G5CCevjURysWjH//Al2BK89FwncbjtylFhIRpp6pGEQxQgvb
 QE8rcJ1x2248MsDwMIv7BBgvbkwT9MqeffLoS1QZ+7tyA6DHr/7Fv6+Ru7qhFa+/TquNEwKDsto
 +mYo3eBX3HeT8dpx2m6jzkQwaEV3u/iTjfXplx7j7hBBKMpIbdh+hwvFT7FarBs0i
X-Gm-Gg: AY/fxX4twbMgn3mWEh1ITNSdNHDuSVfiz9rR5mqMf2o/QkabqdOvT91MWUqsBmwgaCf
 KbvEw9s/hIy/tDcOACxBJNnfLwcMNA9NtULU1Yd5OqPODfBCzMZ60LBA48BwKWdZxoR5gU3rpnu
 qtG7HGfoQvwV0ZdXvFCTl66VhLwLtpBEKNC0OKj8M7x3NiSlCtiEGWyZY6GeYoCcRiwDKR9p3EB
 rZlwsIxPZFVIbSNa98Waz5O6S0Fx6RMeGlkiIQA3hQRDYCkAjwCaN7AmWWIQ90PSV5P+/pHqY0I
 xE4Z0JACPIbrtz6Yx9jPS+yI2dpcA9Vc7WJ3q6MyAPJVLt3IZw2p7OysQVzv8ta/rr9YRwZnWQN
 lLjW6qMCliSSpC0cInKSgRCBbZEXX/7hV2xKwxIrjQf39jFQR6srv0GvUM4d1YaRgTJjx9BEnf7
 BZYP8uSoE2gAvzQg==
X-Received: by 2002:a05:600c:a317:b0:477:9976:9e1a with SMTP id
 5b1f17b1804b1-47d85bf063cmr82501975e9.6.1767960565687; 
 Fri, 09 Jan 2026 04:09:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzZDIiD3YTzKPpn5Kla0oSBx1QdyE0RX/8yKlMy8hjF+QysLqxEFtDaZ7aLL0IU1D2f2yn8g==
X-Received: by 2002:a05:600c:a317:b0:477:9976:9e1a with SMTP id
 5b1f17b1804b1-47d85bf063cmr82501675e9.6.1767960565300; 
 Fri, 09 Jan 2026 04:09:25 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f4ddsm213412155e9.2.2026.01.09.04.09.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 04:09:24 -0800 (PST)
Message-ID: <6e60a89f-6798-4ea5-bbd0-553130786cec@redhat.com>
Date: Fri, 9 Jan 2026 13:09:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/24] include: define constant for early constructor
 priority
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-3-berrange@redhat.com>
 <d3ca3fb5-e972-4446-b32c-f20fd8825cca@redhat.com>
 <aWDqie0eYZ8GeQHF@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aWDqie0eYZ8GeQHF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/26 12:46, Daniel P. Berrangé wrote:
> IMHO the root problem is that it is pretty dubious for us to be
> spawning the RCU thread from a constructor. Constructors should
> be limited to minimal initialization of state. Spawning threads
> is outside the boundary of what I'd consider reasonable for
> a constructor todo. I didn't want try to tackle refactoring the
> RCU thread creation though, hence this gross workaround.

I see.  Maybe we could (just as gross but smaller) do the RCU 
constructor late.  Not something that you need to do now, of course.

Paolo


