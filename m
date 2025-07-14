Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE081C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 14:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKLF-0005f2-79; Mon, 14 Jul 2025 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubImj-0006lS-JH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubImg-00046x-JK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752497992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n25nSnVkU5GWJyRngy+6SHPj7oMPrluHwavtIra3af8=;
 b=gA7t4Y3K25GebvNemQvKfvuZXfcad2kRyj8lqcNvP+p57WRh4zEavl9Y5xgvKT/rj9J45D
 GLgbhcNF350JolXm/B0CKyhXCoXssMYy7X9mZbe/f85NBkYHYgS5ziUpxGcDdLD/3hynfY
 ULYnHB4eXj86G001d68niMB2LoJ0XW8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-BXiKh7FwNbuw6Ji5osB5Vg-1; Mon, 14 Jul 2025 08:59:47 -0400
X-MC-Unique: BXiKh7FwNbuw6Ji5osB5Vg-1
X-Mimecast-MFC-AGG-ID: BXiKh7FwNbuw6Ji5osB5Vg_1752497986
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b5f97cb8fbso628843f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752497986; x=1753102786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n25nSnVkU5GWJyRngy+6SHPj7oMPrluHwavtIra3af8=;
 b=k4YkNM+FwX5k3lGgmKu1u+K0uP7o84nt38YN3SWBrInXnrdgagqcgoVBKnDZOztrbq
 uC6KZULZ6gBkWOk52o+wf3Wxus8RxAtly7lsN7EUxeX/W3KTfK66yvV108dbMFNma4Ob
 Y6MODGo/cPeZH3QbY0qsZXDNMCAK3l9iVSVZxYnhnUkSn18n2kIziZ47tJG6OfU9DLq0
 7776Rc+rWS2npxfQCK6V9R+jy2ytTjMYQBy5EO3ARj7wonVFstsHmKS+nn0RZBMdmblJ
 SXb0XYEwklbbowhsuja1jj2kZix8Ns6E0YLEtCQRRIUmNAQEA8ZmcSEm917vxTmiTr8E
 DYgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmq0SymVBsDaMr/t8rE4tBNaySt/CXiUJxv+rQaeDgCqWZzOJ6/+9xJhpzm2EnmGM09+0M1jFw+CuL@nongnu.org
X-Gm-Message-State: AOJu0YxzhFuNgNjdbDIhfS7TZq096foRGpV/P30LA4peUprxfJSK0gXr
 rt8L3m5CgNq0CsLVGH1evzPKhXS063KyIFCj6oA3djWQjmeswhdgH1VT0nF0/0zf10j6RskXef3
 W2CULwpYZb1JlW9ibCEG0uxKW2n59s7dMx1wBaO5qKaA3kIrjYxifh7t8
X-Gm-Gg: ASbGnctEiijVoiG67t8fc9jSiI/A0zfLIgmyHUC8EMlpmx7ubntuxdb8K3YdeKHZux3
 xU9GKstZ8kC9z8AVs7Ug6oDtF0QfnRdgGRiuSj/UVEZweFRXOOQ1KomJQnd07IVpRUxSQvFH2pd
 JXzejabQ6RcL7qJmQzLp/IWzFAqNzHj4oEeha0fdgo6hezwrLQDZwd5cbpxpPn4lCqxyMJcRl9v
 gLx/A0EcgOejYegqKUbYNIj3XC5Y8MJ/OZ6woOo1xMpwrqjBgPf66lEUpOUK3OqDNLowQDvppLT
 Coq4efeWsGEB+NIsW+IYF6qVGd3dTNDBCc/7XFL+IqgOcxk0vW0YNRuGFNckkxOqHzR2XF/fRLC
 LUrQW
X-Received: by 2002:a5d:5f52:0:b0:3b4:990b:9ee7 with SMTP id
 ffacd0b85a97d-3b5f18959b5mr10515401f8f.22.1752497986249; 
 Mon, 14 Jul 2025 05:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7OAXP65ilRKBLq6w/UglKMd/lVLu2OfwVGlOURR6YpWBx6VA1+63a7+T12qt3x8Jjat8l0A==
X-Received: by 2002:a5d:5f52:0:b0:3b4:990b:9ee7 with SMTP id
 ffacd0b85a97d-3b5f18959b5mr10515378f8f.22.1752497985815; 
 Mon, 14 Jul 2025 05:59:45 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-106.pools.arcor-ip.net.
 [47.64.114.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560bdcce9dsm70491145e9.20.2025.07.14.05.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 05:59:45 -0700 (PDT)
Message-ID: <b356a6b0-28dc-4ca3-8531-b47b7f60d7d4@redhat.com>
Date: Mon, 14 Jul 2025 14:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding the TODO list for contribution
To: Akshaya Sankar <akshayasankarr@gmail.com>, qemu-devel@nongnu.org
References: <CA+A3OQ3jcS=r0n_gEMAxrtTDHkCjibL9SPWY37WDBq2tqC-1SQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CA+A3OQ3jcS=r0n_gEMAxrtTDHkCjibL9SPWY37WDBq2tqC-1SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 14/07/2025 13.30, Akshaya Sankar wrote:
> Hi all,
> 
> we would like to contribute to this open source community as a fresher / 
> less experience, and would like to know about the small contributions to be 
> done as initially. We have hands on experience on embedded, c, python and c++.
> 
> Kindly guide us if there is any TODO list.

  Hi,

thanks for your interest in QEMU! There are some "bite sized" tasks in our 
issue tracker, some of those likely can be done by new contributors, too:

  https://gitlab.com/qemu-project/qemu/-/issues/?state=opened&label_name%5B%5D=Bite%20Sized

  HTH,
   Thomas


