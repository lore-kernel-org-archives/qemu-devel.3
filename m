Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D521C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R1m-0008Pk-3x; Mon, 28 Apr 2025 12:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9R0o-0007yP-O9
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9R0d-0007p2-CJ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745856424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/fwsxu1I4ZMIeUJ1W3AzUxd2DhR5HYmvP2TyV5v1i/M=;
 b=WVdYv0Yktv4vv8LkqlQZXpdWkAaNNn1X3JTEjM589pqzAfPVsqu43VPtTgrKA/ZsEGqA5v
 Qyp2Wyy3eSXTnLKtokEKfcAvkByFgsbORZKs5aSRwlL4ZJ3aY7u+o/0HU0XTe5KvU8Nvme
 95lgdndB4jPk8R5+DPnKnMBcuddt/zU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-3voW7gwtNhm--dH1zUNayQ-1; Mon, 28 Apr 2025 12:07:02 -0400
X-MC-Unique: 3voW7gwtNhm--dH1zUNayQ-1
X-Mimecast-MFC-AGG-ID: 3voW7gwtNhm--dH1zUNayQ_1745856421
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5f4cb765d67so539445a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856421; x=1746461221;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fwsxu1I4ZMIeUJ1W3AzUxd2DhR5HYmvP2TyV5v1i/M=;
 b=T2UHcnWQU/qgzXiunIadxg2AMxRG5CdWZujZytS5WkMlUurEiQXWtc5C7fDiD0IC0Y
 E8NT1g8G6OLJRfqz6en7OGp3xKEXamr5Jy8B/n1PbkuJvoK4uJpCjhVyDPasaoALDGv+
 uiHm83rPbwQuoVLl36yC8d4eMdoEIdMD4ZTq8sizXkNuV7ZycPmO/uOGDg8YjvD7/Iq9
 3Ws/C5Z+gegJL6ysXp8dNxGLbMTyVXn8qb2wF4rox5UG4DH2sN7J6AwOYtkARpQ5aNPw
 ivw0hKq3+AjgtcrdBBz1h2COdIKCJQ/t6dqjoQrnr0MvtsVXmv09GhPufiuecuqy1cBu
 9/oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmTjAavCsOhPBu03bh7cBtd7mnizaiVTqainNRO2YnKe+os3kNFq2TSAmwgLOYavMGy6skwO9BTZVc@nongnu.org
X-Gm-Message-State: AOJu0YxW2KfbZY5pMuQN01sSRQ01D4MkQJVw5oV9ytXt5yEQYNzxN1OR
 u+PhQOR5rcbyq+pyF0z+Vh/s0CTi7+l0t+4OpWLGNpbeGdEodINunXhD01JpVzS2T7xkQ8S7Zmy
 bHG0+UbydowjOvthb9XdCNVIaSn6bEoPUkPzvSk7Im91K6B+3CSGOx8npx4u8TV0=
X-Gm-Gg: ASbGnctbQnSXpf3nVBt3UUjxqPnH/cEHzlu1PDOXvPQb9nspSuh2NtbrscqHX7cH9Ng
 DHv3LcWvY+DZhXiwPhtLGaKUVFFukPUlaEvLx5YtzF4Xs5ZAee86CNrLtnEIulR4WYnz1dU0SYq
 jX1fdIWMD9EsLP1vvgmTpPu0hS23phIh3nW+nLFfW7fH00VZTzjiyZiyyF2tGdkKqK5xsprg5wK
 ANZyJNOD/9EUlHy8Qh9fECHbxW7kqSNh5ivdTFjNC/6JNxt/Si26XnANliNT+Rpj6vNuYqzrKVz
 4Rr3T2RJI09ibDMcNAnpKC1kuvVsEVqFyenpzG0yQFb/3w==
X-Received: by 2002:a05:6402:354c:b0:5f6:4a5b:930d with SMTP id
 4fb4d7f45d1cf-5f726752eb7mr11067021a12.11.1745856421280; 
 Mon, 28 Apr 2025 09:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdOVHomKBZ3O98xozoa4tELaV5kKbMm51xcEuvqmOS2uXGS7/WUi+/wV0LJXZyClragMgOYw==
X-Received: by 2002:a05:6402:354c:b0:5f6:4a5b:930d with SMTP id
 4fb4d7f45d1cf-5f726752eb7mr11066990a12.11.1745856420945; 
 Mon, 28 Apr 2025 09:07:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f701400570sm6119134a12.29.2025.04.28.09.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:07:00 -0700 (PDT)
Message-ID: <7c5a4093-f8a2-49b5-9d28-6a8648716bff@redhat.com>
Date: Mon, 28 Apr 2025 18:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] _posts: fix two typos on the 10.0 release
 announcement
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250428131853.455851-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250428131853.455851-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28/04/2025 15.18, Alex Bennée wrote:
> We already had EL2 timers, the new ones where for secure mode. Also
> fix a transposition on s390x.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   _posts/2025-04-23-qemu-10-0-0.md | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied!

  Thomas


