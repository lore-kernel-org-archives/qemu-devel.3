Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4504CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 09:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9KIy-0004SD-BW; Thu, 16 Oct 2025 05:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KIw-0004RX-IR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9KIu-0001RR-Hf
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 05:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760606985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iFzKmK8KHh4gorMYiNODUyNdwfHUhF/L26Rme0u2aMs=;
 b=Ltdw0m1Xn1ULM4boV2ay8heqoGSF5T5PM/6JKtaaYgm4QRDZkf6H2RNvWEQj6KUdq/zQOA
 zUJQJPnEg4JJYSQMjb4bpaYnmpX/QwgigwY3oxn7KV3UgFq147PEpAUZCgCIsUZQ8wso7X
 7Lr8AUrBHS6IigK0SFj1r8f9YNPgy1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-iEKBtYJXN5uheiUVBJgU8Q-1; Thu, 16 Oct 2025 05:29:43 -0400
X-MC-Unique: iEKBtYJXN5uheiUVBJgU8Q-1
X-Mimecast-MFC-AGG-ID: iEKBtYJXN5uheiUVBJgU8Q_1760606982
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47108163eeaso2243185e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 02:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760606982; x=1761211782;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iFzKmK8KHh4gorMYiNODUyNdwfHUhF/L26Rme0u2aMs=;
 b=gX+QZiIuj3nwXX5GQWQyj98LfoUspZr6efsHSmTcuRj0FENu6F/VTNTJzcj2Q5tnZU
 L90r7+75VO/QD9forFLungvLCeZPYuMu4RLHD1x/HI6hVg0qQ8tUcLYcxvFl25dPQ3Ui
 UVgJ2QzoDrJsoYk1zwrFs+FywqLn9B5Ohq07t8JcKuHgg8q8z91fszazmDv5lL2tOkmF
 j8Gdou8SMN34ysTNFip5FBaWYSnV+MPFmHr+sJm0/jNTrkJSFuka3fqvxUHP1aVk4zDT
 5ZyERRuCKFfPYYgzMOvSujj0UeTHMOAQhyujk6EssFC8O+EohmQRfa2sAhzE5P1cKaDh
 R70Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx9ij3QQtzO9Z5CEOQ3ulhxNyrvSSp26Rgwl9jW1lhBBqhaA48XEBp8zirMmID94ShbDx06uMZPCYP@nongnu.org
X-Gm-Message-State: AOJu0Yw6i1Jmy3+0L63bhkE2jplwIIYCJ9WpxY69bREr2GSC63/xsbSs
 jkRbW/mJz8ic9bymaL83Nz+90OT0h5tl8PoOcMvVXuEQjOzVE4P3tHZSUyjYAbHnQxQdpopP0eA
 ywNkZHEbUFLKpHeeK+gCLR33tQBkMNg8aVoTJk8XiJtqTWGu0zEUcv301ke8MalBy
X-Gm-Gg: ASbGnctNZDJS8YNziorU2B8xlt4rd3qaSj0VSsaRqI1L9rumAqDE2PT18fAXCGt5NcC
 b8o9eXspCZF1cI41udQdyVcweFzskANge2mzLe/vJp2Tb9S1/EOjRRu9GDDQPr6atrZpBENfM+b
 CcXoE3zCjyyy2gJOEMnAsJ7Si13Bydmw9jiFoLlyovUqi5MI6jkvuy143xUSaQHKJEyF4EeR5N1
 oXLIwNm4DhbUrZibB3s7hPDe3JEJzhnxipKadHjIrTFWwTnbJ7p5MSIvnjGpW7RMI4pKlHtR4ia
 xKdU0UDHT6EtLc55el0cVdWTQErQv/3efStpNVP5Oe8p0XIXOTTh3pnEsGz/hkN2aGd4T6+j4gy
 V+i9WieGmGuXltNSXAupPNrMesgqVmK8HrZv9jfGE
X-Received: by 2002:a05:600c:c116:b0:46e:3709:d88a with SMTP id
 5b1f17b1804b1-46fa9b17e16mr183294605e9.33.1760606982082; 
 Thu, 16 Oct 2025 02:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0mfQKB/aEb2E5SpUb3sZCwx0kia2RMoWt/MQ3jr8oC7TcgttEEvyqhnyXCy7tV+CJkrlxRw==
X-Received: by 2002:a05:600c:c116:b0:46e:3709:d88a with SMTP id
 5b1f17b1804b1-46fa9b17e16mr183294465e9.33.1760606981694; 
 Thu, 16 Oct 2025 02:29:41 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114428dbfsm14905895e9.5.2025.10.16.02.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 02:29:41 -0700 (PDT)
Message-ID: <8bf630e8-9c3f-4d2d-8f68-a4abcca54f64@redhat.com>
Date: Thu, 16 Oct 2025 11:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: ensure GDB client is stopped on
 error
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20251014140047.385347-1-berrange@redhat.com>
 <20251014140047.385347-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251014140047.385347-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/10/2025 16.00, Daniel P. Berrangé wrote:
> If the reverse_debugging_run method fails, the GDB client will not
> be closed resulting in python complaining about resource leaks.
> Hoisting the GDB client creation into the caller allows this to
> be cleaned up easily. While doing this, also move the VM shutdown
> call to match.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/reverse_debugging.py | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


