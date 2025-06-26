Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0928AC77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 06:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfgM-0006Xw-Do; Thu, 26 Jun 2025 02:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfg9-0006OM-8K
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfg6-0002N1-Ph
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q1jWGIOyAoDc81Q1gUvVIux0jXH0jqzlqnZ7CJjPgEM=;
 b=TgKwsiI9Ja7CFxst9LNNSryesdZiRpn9fs1wuI5nx3wdWCHPzrIDFvWwUkv8ImKy4JYMVR
 RxS6WqvAeQ5SsO785rCBAPmXLC55bpUVFOEugxgTh5QOjWm/AQbrPeXXUdtlEIOygtIzVL
 ONKCVDVxXFIcLUI5GvhMwiHn/QPZznc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-6Qz-CjLfOiOnHIFOMHZPkQ-1; Thu, 26 Jun 2025 02:01:39 -0400
X-MC-Unique: 6Qz-CjLfOiOnHIFOMHZPkQ-1
X-Mimecast-MFC-AGG-ID: 6Qz-CjLfOiOnHIFOMHZPkQ_1750917697
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so3553815e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 23:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750917697; x=1751522497;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q1jWGIOyAoDc81Q1gUvVIux0jXH0jqzlqnZ7CJjPgEM=;
 b=oEJ4JIFYHZ/yhDmNWeJ6VQLB4AfVph3jHt/9D5ntagq9AF/Z3WKktKI5FwyNE5pCxz
 hn2o4+Weww5VSJgziAYMtYDzRUo9qqaMywOVpKxg8+nZh6yOFRUFpEAHgTjl8LmmgB41
 8hh1CsNMWUlBzAWki+CLWJ+TsPNz1VRsJ4MFBqqSsJjrZm2GpjOCRb0+/xMql+crtGdQ
 ImnpvSYyJsM2ym4XjCVCAuPNsXkThb+ABO/lIcUFI8wUDAQjVoKgwQeu4Kd+v85JXThG
 Q9b+3+hV6QyPnHzsSb0G4kVtbQn+loEIX4gCauTxmvfQR9OwIg3f31xZB/bCbPioBkXw
 C5Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmfc4mRgXpmEk/Bt2n1j5o5u3Cch3oMGIj2uQ5sgQePWHZRaaUHWIwfx4f/sIgXJSvVWj/ODcaSW+h@nongnu.org
X-Gm-Message-State: AOJu0YwUbLEqwu8+RZWfIfIeL9oEYgPxo3ISy8FAUc+3ZHipx+ADC0XS
 gydeq6fQCqhJ0eHdaNIkmTz0WzTXbx+gy32bo1Ld3zgi7B5/prqruZedU8Tl0+CvKkCzBBx7kT7
 bLxje1QDTRApzKPBXZ2TFOjwQje16O4BHuZtmVSldOSfl9Lc9p3Gt4bd+
X-Gm-Gg: ASbGnctudOhrsN7GdpcowkJqNPhUfwhFVnIYW8jsR6OmgLDi7UpJF7YaDQjYHbacoGU
 E60E6oh93pNBJVpc9Exd57HsqxFqQLOUUQpcqSfIEEtnXmjFr+Psbis+ZP2H2aae1MdrHsf5ZWd
 +23iA1I8/UK17f+dZ04ropY3HAuOZ3kwr3GNDIMDVJLOpsaxZIbkXGpmjuCtPC1aBEy/erYQxOe
 41lW/GeQ1CTrpn2vPIFxMCkiZx8aIJNFi6rvpr7J2hQ/B3KRiNeKXCJzei4r+sZSsBIKxB6VAtc
 jiEfL9dgJq3k/zBljfDryu4jOVfQXk08rNP7SS7Fd98zhcr+xZKaU+15y1cm9uk=
X-Received: by 2002:a05:6000:2207:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3a6ed5b880amr4756318f8f.5.1750917696873; 
 Wed, 25 Jun 2025 23:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHegrIfMcIA7VUPUaSoNOdMEKv2V4ovkpIkN/vPfBypTWhN3ZDIjwm8ftTy/x1xiLdK4+EtuQ==
X-Received: by 2002:a05:6000:2207:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3a6ed5b880amr4756282f8f.5.1750917696436; 
 Wed, 25 Jun 2025 23:01:36 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80695efsm6214837f8f.40.2025.06.25.23.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 23:01:35 -0700 (PDT)
Message-ID: <5088018f-cfb5-4256-9f70-6a578a2d53b7@redhat.com>
Date: Thu, 26 Jun 2025 08:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Warner Losh <imp@bsdimp.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
 <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
 <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
 <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
 <CAJSP0QUKx+eLjF5J2+JGrry_x-jx1p5HStCOTfOgQg+3nOpSeg@mail.gmail.com>
 <CANCZdfrxE=GScjtcd87cd-fgRf3uk87T=Ow718cFrB24=iC8iQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CANCZdfrxE=GScjtcd87cd-fgRf3uk87T=Ow718cFrB24=iC8iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/06/2025 04.53, Warner Losh wrote:
> [...] What's the
> anticipated load, measured in downloads per day say, this testing
> generates?

Ideally, the functional tests download the assets once and then cache them. 
However, it's currently broken in the non-shared CI runners of the 
qemu-project (it's working in forked repos with the shared runners), so 
expect a fistful of downloads per day (I guess 5 downloads per day would be 
a reasonable number to expect).

> Speaking of which, has someone done the update? I'm a bit behind on my
> qemu stuff and haven't been paying attention.

AFAICT nobody has sent a patch yet, so it's currently still broken.

  Thomas


