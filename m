Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E16C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSh1-00086b-LJ; Fri, 07 Mar 2025 03:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqSgt-00081h-N5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tqSgq-00087R-5w
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741334655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TQFGXIErLIhUEjgjgIIDlrkpiWE2sEhJy5D/MzJZXeo=;
 b=Gs0zZ/7gWhuHwaGzszOSSJsqezt+22qRdGSTKrkX3uzGuXXuQmHFzBKe7CIdDDDWwj3eXc
 l2iM2PtSQqpJtMHLZ6UioclD3WecF5LBc8JzuuLrnnK9+opX7eBmfVsmDWfXNbPv05biTU
 rRp2DhJx6XinAvwvM7LAIAMi7Za9luY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-0Uglg4fIPfqEhp3DXWb9Jw-1; Fri, 07 Mar 2025 03:04:10 -0500
X-MC-Unique: 0Uglg4fIPfqEhp3DXWb9Jw-1
X-Mimecast-MFC-AGG-ID: 0Uglg4fIPfqEhp3DXWb9Jw_1741334650
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bbfc1681eso6777585e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 00:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741334650; x=1741939450;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TQFGXIErLIhUEjgjgIIDlrkpiWE2sEhJy5D/MzJZXeo=;
 b=HT6eRH0CY+KbH1ODELl5PN9t10UOnnMQaZrRBmmnuraH13idGrCaa7qSVJwA9K4Pq1
 TpyGYSKYWx5/Aeh4p6jWK1GIzi2rFKdVMIOIgJmZohZ8xn5z13/AxJYQOYQv9xnDtDa2
 E3ZWUn9nG4CRfYE9CuFLEpq4/zpNkDAZe3JhcaSSpgXVSVgty/QpTGNvW2tvDup9AJE6
 FmeW/r5+sXLxFOwgtJ4iEv5S26pgqCVG+veqvxdwvpKCXp5ImRyOkvGiPppV1FSEk8uO
 Y4ggEuvCOcsCuMFOMQcOHWJVa07CnuEiSJxMCvOsHODY0Rh+q9bsvCLk2OxJtNy6qHc9
 8QAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIUVqSDHV9TxlrCl7fVeGtFaj5y0mlU2DwgSUKvvcT3kASucrNidSCQV/ZKovdumPku3GznIDayWid@nongnu.org
X-Gm-Message-State: AOJu0YwSH8cgmQrJlvHTwTiL2SH/yLnfMt8IMtoNC/Ero0sf8ohunHf0
 sPEse7Li0lT7jgiDfyCrtZBItIK5mJoR8CxW8ujaV/i+Xa9UX9PjAC2ZWakI5mfLTJtQmWvvO8n
 iTIQeA/SFe04bFXKhNFqf76w4J2hzP9qcEGrcAKRYVBMH0U15Ecwb
X-Gm-Gg: ASbGncveLuXRU/3ZyViR7aYP7igqRq9FCpHjTZ5/HDs18vG7lqYFDtrAedObOKXcK3g
 mFmv7vpe+IXxTKCoRd3ZV9jBuXuK+zWdUXYHVpvFr+/4i4W6kGnjjljzt2xLzkXKMfOtjnoJniR
 OFGzhVcx4emPz+tfleu4pg+qhAeaVU4vU3GpeYFymXD7Cdj4HevZIvWTkrgSUBfmEuy/Qghdsov
 ONKmMlKzOzODQxDTMI9kg2SuUr5XZigD5rIvI1gQbrj4CVrZpkv+iHZqPBBArb9gzDq2o/DMDoA
 Z9fqvN2UBZASnXfRVA7arG6r370Xs6EmD3eCmZRmQ9uqpzxrEVgrRGYrK5kbqBPUlhaSu5TOfmM
 gCBy/1A5Dsc1a+v5K/AETJhxkvsPD+QEQADCuzw==
X-Received: by 2002:a05:600c:45cc:b0:43b:ccfe:eee5 with SMTP id
 5b1f17b1804b1-43c601e188bmr15584845e9.17.1741334649736; 
 Fri, 07 Mar 2025 00:04:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5ei/TqyXLfslPlzo5NyabEszoU+HBxhqRW/jBKz6/SIPv0K/6i5bceCrwexlBN2123HBK8A==
X-Received: by 2002:a05:600c:45cc:b0:43b:ccfe:eee5 with SMTP id
 5b1f17b1804b1-43c601e188bmr15584615e9.17.1741334649385; 
 Fri, 07 Mar 2025 00:04:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:7400:ab0b:9ceb:d2:6a17?
 (p200300cbc7217400ab0b9ceb00d26a17.dip0.t-ipconnect.de.
 [2003:cb:c721:7400:ab0b:9ceb:d2:6a17])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93cb9bsm43773375e9.31.2025.03.07.00.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 00:04:08 -0800 (PST)
Message-ID: <b4921d1d-6d68-45c9-83a7-6cf4f30ceedb@redhat.com>
Date: Fri, 7 Mar 2025 09:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix race in virtio balloon test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250304183340.3749797-1-berrange@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250304183340.3749797-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 04.03.25 19:33, Daniel P. Berrangé wrote:
> There are two race conditions in the recently added virtio balloon
> test
> 
>   * The /dev/vda device node is not ready
>   * The virtio-balloon driver has not issued the first stats refresh
> 
> To fix the former, monitor dmesg for a line about 'vda'.
> 
> To fix the latter, retry the stats query until seeing fresh data.
> 
> Adding 'quiet' to the kernel command line reduces serial output
> which otherwise slows boot, making it less likely to hit the former
> race too.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


