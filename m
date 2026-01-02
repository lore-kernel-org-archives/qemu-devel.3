Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F60E9410B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 09:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbb6U-0004gw-90; Fri, 02 Jan 2026 04:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb6S-0004gW-2P
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb6Q-0003cf-CF
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767344745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZDDmBvy1YoTWuCH5t25N76KvQhF0yMF2OcfXLH3iDuY=;
 b=JKq1RWl35BONGdU0IhavGS+e0BtZHnRWV9IdlMjBRZkgx+JYGz1s17DxNVIsbLSVGXUf1a
 XS2+oOKmKvjs33HDk23hW0VW6zEnhE7PZ9g051jxLXB5P1rSaByrM7yWtNUh9TKuKLcvDK
 ycByBphd9iQYrK2xKAWm9OYaMLXFEqY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-F-QF7XiEMAe01TIXNadWsA-1; Fri, 02 Jan 2026 04:05:43 -0500
X-MC-Unique: F-QF7XiEMAe01TIXNadWsA-1
X-Mimecast-MFC-AGG-ID: F-QF7XiEMAe01TIXNadWsA_1767344742
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47775585257so83078685e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767344742; x=1767949542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDDmBvy1YoTWuCH5t25N76KvQhF0yMF2OcfXLH3iDuY=;
 b=b3gRuDOYx7cGJoKQ1PL9BagkhtKqiGPgtDxrVdtp8DWwbFT47EmslClkB/MtEc2NKg
 KyGdoH5J1fhQTo5JKN93x+5cp+5r5/EroP47Gwx6dQW1X88WfPYPM5Aysft4CGJNNohl
 ybkzIseWL1ZcAt9YPacVDjfrucaSdkUL2JFVpW1jBj2QQPpj+cbBCc8VUapRnEqR/7La
 hrXH/0s/708g4AFy5Sc6BHtbMugEzg40LJQOspyLdZXtHJHPGfjWMT0St/xqVxI5AqK8
 sLivF6DjMT8PUROPNqp12ZwN/zZm+cuRe+M1eEm001wzOWLdlLmChs9yQ4ffl+bqJUSH
 5C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767344742; x=1767949542;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDDmBvy1YoTWuCH5t25N76KvQhF0yMF2OcfXLH3iDuY=;
 b=tQ+a/x6Zi+Qu54hf62g3VySuiLnSUkHGshDv+zh5Y8QeYKGDn4DEUFkvhq5kKOIjCh
 Pr7Gxw1l1BrP2pN10Ph8FVD2A4/wr1RVL0DVcM3QXY367gt+HxyKg5VH5yeL6U57MzMj
 MEpegDVG6mKg5GO7DWsj9bchUXX6OywcvDTMsxE5oBtjPcN3h2Dgaz2fl4IGTEpzp2fH
 fnYGfj/b4oD0cgSOMtqi+/VfEVDVF5bWUqUYkucYo1F3rRQCYXiJxYfuGceaUL9AC6lO
 TP9SSrPoWBkTk8Oe4Y6l2T7ONzZPxxb5uo6H4jLfitQ3Qsnqwgv5W1xcZHvbSsdw9fxZ
 ZMaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG8WlCw7MVMbnfH+PZ9U8kStryGbQ08PPHTFmYTKtroR9Me59UkJ9qRLIfwcLciYDzuGZ9guWcacPO@nongnu.org
X-Gm-Message-State: AOJu0YwIIF8zyGzi6ix0e7Z5rUP32/roOv8Z96hedWD+bSdVoC7MhVua
 yf/UFvMtavYfV76LrW44hGPbJ22WrpD4j6Qt+M5pl7Mn7heiX8UlmfUrxt71dXsH9YQQUhLQtyx
 TD+ttWXL4Db34qKBJ2sXLy35VKNhDYTeje6AAGfrE9z2k3wRwQEXfKMVv
X-Gm-Gg: AY/fxX4eASnfT7ELYMdYKtt79xAIIRYkXwRxCuqlVDckCH+tXhOyK1T0F+Y8UqyB8TG
 /5BrpD3MWvis4TxXusWH4RHDD+MJs65UO6fVjRv3HC/zaNaBJPdbXpCQofWUx1my8Fye6Ahkw08
 ZyfsXNkmA/9jy8465+CdnlE+jiAtlBMCp1SNf2Z5b3nRVPrZ4PrWxejLv4oovrw+F7ij994TGys
 nL/FQcWOQ0BmkGf+1sC1rfSbUqrEXGcpbNRn7kvxaN8ewsow+iWAiLSZ4iaS/1t+KzehNKFbVYm
 zlcJbQJ0hZmBPdfLCKS9skiqSnahqztJb6wEvSsswgi+rdkxLgIkG4ChTjfR0DqQIIZmiD8f6oy
 gNLy2BvE=
X-Received: by 2002:a05:600c:35c4:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-47d195869e7mr569229185e9.28.1767344742473; 
 Fri, 02 Jan 2026 01:05:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAatCGy/Isqmx0aiwX6RuAbfeDeN1x4X65Nf6ywt/0/Lo3zr4VWFXcZLvAHoDLJJJ+vEAKjQ==
X-Received: by 2002:a05:600c:35c4:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-47d195869e7mr569228705e9.28.1767344742056; 
 Fri, 02 Jan 2026 01:05:42 -0800 (PST)
Received: from [192.168.0.8] ([47.64.114.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193621c8sm731340155e9.7.2026.01.02.01.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 01:05:41 -0800 (PST)
Message-ID: <c83e856d-eed7-4927-8283-08da53ade4ca@redhat.com>
Date: Fri, 2 Jan 2026 10:05:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] MAINTAINERS: Fix coverage of meson.build in
 tests/functional
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org
References: <20251220173336.3781377-1-armbru@redhat.com>
 <20251220173336.3781377-3-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251220173336.3781377-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 20/12/2025 18.33, Markus Armbruster wrote:
> Of the 29 meson.build wihin tests/functional, only 8 are covered.  Add
> the architecture-independent ones to "Functional testing framework",
> and the remainder to "$arcg general architecture support" when
> available, else to "$arch TCG CPUs".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


