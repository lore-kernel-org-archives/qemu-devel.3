Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CB2CF3182
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 09:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLeTG-0001Hz-0E; Wed, 19 Nov 2025 04:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLeTD-0001HD-4P
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLeTB-000214-G5
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763544439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QozEmAjxUGXec2NEr4d9cBogEu7Ed+MhG7yY8tiycUY=;
 b=AwvZiprH2ndDkJz0vWsm2pk9BjefKWQKMih1/W33KoOdEh2N0MWjj0ugoz6c7JLR49Pxod
 1vgu2FEexahzkyeST9ZgtDsD8SNYjdWrrPd8XjbkcqS3FG0VtNNApWQl+ziBSbrbJEvSo7
 +zqr+kLNzQT2fD7rZMyrMOO+c9kNnO0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-FFW0A__YPe6-LABTZ3Ykng-1; Wed, 19 Nov 2025 04:27:17 -0500
X-MC-Unique: FFW0A__YPe6-LABTZ3Ykng-1
X-Mimecast-MFC-AGG-ID: FFW0A__YPe6-LABTZ3Ykng_1763544436
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47777158a85so56244965e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 01:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763544436; x=1764149236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QozEmAjxUGXec2NEr4d9cBogEu7Ed+MhG7yY8tiycUY=;
 b=fyJbQM3dchTyWUhLvJEAcmnMy8+Cohf+zsMZW6mXWAxhON00QUlV1ORI52NLUDZ+kd
 5hQAhbl6EaodU9r8NdZnTXvWIGFKfbhcD31yXqV1HvvaGRkCgPTjKBS/rwod4UCfcIkj
 /o94T5dC6XbM3MsuL9NRXfZypQghzbCINrdXSL4dTDq0ia8hHnVd/4RbXRi1EAK784+E
 6bDGL0SL/9um2wFI6z8vqDcbfURoR7HcDvTX3+N0V29BbUfCIdijH9r8fwhxhFfhqNe9
 LP9k8WXwRLmVZy4huOGJh+GJxW0jTp+wCM3xg2zfBb1xPLh9dvkYHgfAYcQEzK5/q4Py
 lA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763544436; x=1764149236;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QozEmAjxUGXec2NEr4d9cBogEu7Ed+MhG7yY8tiycUY=;
 b=xRCW6G0OVw7M+c9guSAEDExVbD0gPOV4it1bJAxUKLVdXuBYze49+RaIuZu7Z0PoOA
 vUT3mzmqnCbeAQcVrZIPCBAwUf0Uu8Kj7sr14R5r2fiStUBmOfwoQyKuJ6nbVp+9HJRA
 A5ppAFeOAGNZqetgMXPjbOhMhVi7Koik1oOQh1bopPrLxvLFlFdcLp71gyhcLc/85meb
 +P0UkQXhgMozmcUXrM4JkhfUZjtUc77TRnjw8UdesUjDdWeJk3BPTVUc+eHngHIKXQfI
 t8BlERhrT7Tk0vk3jDE6vQ30EeGVpA79/yiBpJlg/0oRS5lLipaZp9hxiTkTZnnBdF24
 Kssg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhRIvYeiu5U2rphX4Mds1qpI1o8hlhu+OWxnqfnQeBAQREehRirgHSep5jrji4Pj1g+IwXTinsffv+@nongnu.org
X-Gm-Message-State: AOJu0Yw16TmrP0LsW89R34LbHmSBsiTlwoGg6lv4mhZO36XTjU6/abxm
 LdPHJtA7vQiHOOBD/D2DMcI2129dAgrm5yqM5HDgTh2HpmsYsZHevxKKqM+ejH2HDVMbqnTIoqj
 c9huZysQcDhv0mHVa2L30DifJvLk2Ir91fupi4gQrFrYNSDQ4Ws3vbUcq
X-Gm-Gg: ASbGnctTCzAecnNh6PD+RwN+/8Ia0gPSvKegdaPsQDN93Y6BbW6FxQxFV+rkPvSJ58D
 wG6pVk3PFThlqoFo4jPgeYgViHj/rq+465bVE2O9zxhe8TUAkMrM1nA8Lof2yFT3MKd2gT3vvd4
 PBmVQ55Uw4BrsR0tv2KjsNqKzgaM7ju+q1XzWtbwOQPZgTXnSzUbJZD4VoxSALWqBmNEKNQm+r8
 958AHOWuH3zgox+EN1aHrKqLcOlWNfB+yYO1N8r3G0cm0IVQDU+JKWetKFLOngRoCYQBGOtz2td
 4Ea7jAG+uXASLqt8nleOGqsCeDVTddSqYjpWSzHL+JhLlMHI0jcofdRN1aoYcIczoTGIsCavdaB
 IAe2Tpr7JIM/sHW4/KJknwhW12rZ/h+rnXPE=
X-Received: by 2002:a05:600c:3514:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-477b7348d9emr1271245e9.12.1763544435875; 
 Wed, 19 Nov 2025 01:27:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzTMtDFoziR9Uuq2zFHGbnH+NIoCqqyJ/84VByVRwHPnmcahAIEXYIGyFp3O3aYPMVgtVnaQ==
X-Received: by 2002:a05:600c:3514:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-477b7348d9emr1271005e9.12.1763544435477; 
 Wed, 19 Nov 2025 01:27:15 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96aa472sm40300215e9.0.2025.11.19.01.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 01:27:15 -0800 (PST)
Message-ID: <bedc5336-1359-4624-a3bd-519824eaf043@redhat.com>
Date: Wed, 19 Nov 2025 10:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] python: delete qemu.qmp
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-23-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-23-jsnow@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17/11/2025 19.51, John Snow wrote:
> Begin relying on the external python-qemu-qmp dependency instead, to
> prevent desync between the internal and external libraries.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
...
> diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse.py
> index cf7e344bd53..e377ef6942f 100644
> --- a/python/qemu/utils/qom_fuse.py
> +++ b/python/qemu/utils/qom_fuse.py
> @@ -47,7 +47,6 @@
>   
>   import fuse
>   from fuse import FUSE, FuseOSError, Operations
> -
>   from qemu.qmp import ExecuteError
>   
>   from .qom_common import QOMCommand

Nit: The above change looks unrelated.

Apart from that:
Reviewed-by: Thomas Huth <thuth@redhat.com>


