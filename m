Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82897D185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdoUU-00081s-D8; Thu, 08 Jan 2026 06:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdoUO-0007hX-Cw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdoUL-0008Bg-Ni
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767872856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SaI/aL8I0FpGZJhJPB9AdwRHxp4ofIUJYepRqrYR+uY=;
 b=ZMPtrNLwCptsoMgxws3EDC1kHiQuYT5hUBQ+ImuVJAkUViz/s076ujhUWeoXudKs8Xa+PJ
 W+EmekabcSbtTzOcQR8iMWJgLZwRYVYO35cYYNvDBLVuFLBwI4VHdXhe6SSjpGiVCKeOP9
 LbWQQKHUtq/++XdFhOYp/XprZAslBVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-yBuRgS4bNWO4121etA78Ig-1; Thu, 08 Jan 2026 06:47:35 -0500
X-MC-Unique: yBuRgS4bNWO4121etA78Ig-1
X-Mimecast-MFC-AGG-ID: yBuRgS4bNWO4121etA78Ig_1767872854
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso24945245e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767872854; x=1768477654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SaI/aL8I0FpGZJhJPB9AdwRHxp4ofIUJYepRqrYR+uY=;
 b=AUeR+XonWBkcL8Cu5cVfxOW3An54P60Ao9XkUmRpXhLiowZtIlfQRzDovSwA14sK3h
 +yi0k7ZeUgop+1nTDc5cpOzgZ2mIK90DBu/ccj+uq3438HFgG3svaTlppvtNtfME1lf+
 qBi8mpNpx1Vmbiz6MUGg0cLCq4CRrXM+rscGz0VmlYn9P8Er/R/pFCMFxxZW/5SdqwD7
 cFsmO/n1YrrgkhgzVFrW+zFy8ja+gIU4rHuFWUQYXH77BrtDan3TzXdx/5Ft2fsiSzvd
 Fps8pKEjYa7WDC5aJ7o9TtfIJ82pqSU7lzIjbo5oMgyKgUEzhKJUvCSTYx74Kfgvl42t
 ww9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767872854; x=1768477654;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SaI/aL8I0FpGZJhJPB9AdwRHxp4ofIUJYepRqrYR+uY=;
 b=MHWQ9h3UHxweKY1jYWmakb7TXBLvn7K6XjtFWO4r9NALegng+b179O6rk0ldZ1EZ47
 K9UqOEJfTY7Wf3Uf4QVxgGVeEEP699W8NH2Ua41yedOZtANNXKUZ/GY6V2ysz6HNVUfU
 +zvek8BJoB/ryLpUGmvL2QVjVtrqtJs8OKuw6k/MlfR0+v4WkAeCuFHA1AIGAv0e9j75
 AgCozS92tTtu/09LzWscaNXOnI6obvA2HWjiyQwyzERdL488/RDx7AivWTBswzAkTsXN
 PMIHrppLwZradgZP3PzYlL3RcVFyR6K2YpHz0mAUJIepJ9aki+nvWeZtVAmGHvjBdGtZ
 BIFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ5O0GEh9EdsA/G5PXRkHtIH6/Fc0/wybhszYv6OLjKdkRUqa/ipwk8vvT3v9bDOEz7F2ZK1ycW+t5@nongnu.org
X-Gm-Message-State: AOJu0Yypvnuq2vy2kxBAPPDmL8f4XPYL+NV5PEbB+yVmhnaeA3vXh6z+
 dU828YTZTZ2vb8cNhndbkoCWDDv+NEArKJpQsGj5BGRWz4i34A8wOYUNmrAsq+V6kUx4gmLGi+s
 UMQLwt5DeE05n0oK9jETyw/f5y3VwVZnnwapfOx3GI091OHg3bu7PqF94iU7WOwOA
X-Gm-Gg: AY/fxX5nLcnu94/DSkKnJvuhe0RNT3wVgkaeRRqmKtgJUNsJxhKGGXp3ttfv+tLy7zV
 mcTIikcba5mE5ROrlvMbnoad9CUJWrQYVVH/Bh5Ve/tXOjuVX2TNiEWJY222+ptpAqosim+zpDr
 yKp/TA3DzLeqVfGZiI4/aKhM4limegCgmDyvck1IxGIBKxSn3qyiDZffJNXDiifYv4BGmmnnRpu
 nsm+itue9ZgwU3NDR2CfhoQNKDwEQdlY5e3H48ZqfgxIU3qG6pCJdVCL6gluFytWhmXID4DSBVS
 Ys50y6GwN1EPFCy+q/Fr4wrK4yV/jfiiHCjSlJQyYGv4cEVogX5l9TjlbjbXqJNavutImiH3CpS
 1wyIVXOg=
X-Received: by 2002:a05:600c:1e24:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d84b32efemr64595715e9.19.1767872854248; 
 Thu, 08 Jan 2026 03:47:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUuQW8UftEXOc07AkZEKSvIjlsaBHFjgtc7WZkwc5Wp7cqH69ZqPsn55Wegb/l22Cm7ey7fQ==
X-Received: by 2002:a05:600c:1e24:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d84b32efemr64595535e9.19.1767872853864; 
 Thu, 08 Jan 2026 03:47:33 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695956sm149986985e9.6.2026.01.08.03.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:47:33 -0800 (PST)
Message-ID: <0b2810e9-0cfc-4229-858b-0ae2a4514018@redhat.com>
Date: Thu, 8 Jan 2026 12:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/50] tcg: Remove INDEX_op_setcond2_i32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-21-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-21-richard.henderson@linaro.org>
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

On 08/01/2026 06.29, Richard Henderson wrote:
> This opcode was exclusively for 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |   2 -
>   tcg/optimize.c           | 205 ---------------------------------------
>   tcg/tcg-op.c             |  47 +--------
>   tcg/tcg.c                |  32 ------
>   tcg/tci.c                |  10 --
>   docs/devel/tcg-ops.rst   |  27 +-----
>   tcg/tci/tcg-target.c.inc |  16 ---
>   7 files changed, 8 insertions(+), 331 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


