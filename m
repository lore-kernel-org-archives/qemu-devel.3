Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30CDC8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDoi-0003Z3-Di; Mon, 30 Jun 2025 08:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWDoc-0003Vb-4e
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWDoZ-0007X1-72
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751287247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S8kIo0AvkNU8rFNZRCThHbrtGTWgnPPqH48Y2FbJaUs=;
 b=OEwSJBnqZhnQimQcssVdG45bXQucyGjKuokRgjmv/6OpJLwRJG9ZMzlP7kkfDzuUR4Qila
 j/dKsos8+aEeHDDynB6eGNUoEbP5FA0uXH0u4/kXbTA6Vc0k4asMOpStZZBTDnj/3lWwI7
 fYeQlt3u3HJU81VwvF7xyR+h8f3o9no=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-VDBM_jCWO5GEFK344y-yYQ-1; Mon, 30 Jun 2025 08:40:45 -0400
X-MC-Unique: VDBM_jCWO5GEFK344y-yYQ-1
X-Mimecast-MFC-AGG-ID: VDBM_jCWO5GEFK344y-yYQ_1751287244
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so2857003f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 05:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751287244; x=1751892044;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S8kIo0AvkNU8rFNZRCThHbrtGTWgnPPqH48Y2FbJaUs=;
 b=g/vf+peFr1/rtGXzkWcvkc0XvpGzEcCG73eydJE1t4L2yGYC1pH+vJ15v98Tfz0zDw
 13onstfx3tMLBY/n9DLsPP4Ylq00T4u+f1H5qG6TYPKqeHqxh/RaeHoopl54i9eAK6Fb
 mbqTa6GvCzr+61bppss8z/uIhLfVsLjwHQ/yhU9rhU0G+q78wHRkZ0D2+n97D1BGSqpk
 eh6ewi2cs0vw98RzcOte1UmDwNMejB/pBUJDAkKfg26trcZr+1xC8037Mj/QrW0OOv7M
 wluk39yEw+aprBPq7f4S6WurpUsNwqVgNAtk4opZePdm2tpRGmJKkQ9MAycFmRWaVfM3
 GTlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkgmceD1ZOQFwOIcjT2xBsVFSs+6yLjW8ICtZ5PjM2En7+QvxpW8ohgY674knI46++BjfMttB9Llmg@nongnu.org
X-Gm-Message-State: AOJu0YwthLQ9UaONFtoJt+hKQGgFU7RGy4nyu/rxrBH/lnsn0G9DoUUk
 1t0MBTrPkPfZ+Rsrg2ZVYUmyrPpylq7gXR7LhLIELDGkVMHMtEt8xpKiKhwyIQVh8sgJyGnjieN
 J3/HFVtd0M4qLpOSJbcriSk+ZfMoM6v7y5OZuDoAjHwE5YtOw9UIc2nk5V9zmGGP7
X-Gm-Gg: ASbGncsMIUSyDCbdj4NZYF2boCMgZu6H+GDyeOsyfa9U69d0zPNZS61GP75fbSTzbCt
 Y+iF8IPyqrPJi+70SgGoHRpgw2Fl+3xocn0TdC8izKwgx/j89heVOPnIkddiWeDfhay3IiTfeDI
 ZMzyEbA4zl5voCYcembUhtE0wNKkNYfEq8CSU7BALgy2PZC1r9lLx1m9kz/rCcLEti2zhNZZ/pE
 NNAi3nkwecikPdvwv12KyZs6YHmTFkwfbdEFMJjFbijCdMNtXcT2h28TFO0J3F55xK6HEhbQIns
 pgc3ReJ3dTZ41ef7TlAMyl35JWTzONJQnLdXL0ashT5wGmrYu6iCQyV1rC1l6E4=
X-Received: by 2002:a05:6000:4b1a:b0:3a4:f6d6:2d68 with SMTP id
 ffacd0b85a97d-3a9186574femr12167679f8f.56.1751287243859; 
 Mon, 30 Jun 2025 05:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG04b427pH9FoaIwnaMuegyTaOkg8dAeSUycQz8vubnamDBoBz4sBydAuIhMkwzuM1WBLQuHg==
X-Received: by 2002:a05:6000:4b1a:b0:3a4:f6d6:2d68 with SMTP id
 ffacd0b85a97d-3a9186574femr12167654f8f.56.1751287243377; 
 Mon, 30 Jun 2025 05:40:43 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad20bsm164708055e9.20.2025.06.30.05.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 05:40:43 -0700 (PDT)
Message-ID: <fd6a98de-9098-412b-95f3-bcd9f15ae661@redhat.com>
Date: Mon, 30 Jun 2025 14:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for QEMU Wiki Account
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
References: <bd4e4c8e-1686-43d7-8c46-66e6c0c79695@sean.taipei>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bd4e4c8e-1686-43d7-8c46-66e6c0c79695@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/06/2025 23.29, Sean Wei wrote:
> Hi QEMU Maintainers,
> 
> I'm new to the QEMU community. While going through the wiki to get started,
> I noticed a few issues and I'd like to help correct:
> 
> - Some links point to documents that have been renamed or removed.
> - Commit IDs and filenames could be hyperlinked.
> - Some sub-pages might benefit from a short summary that links back to the 
> main page.
> 
> Could you please create a wiki account for me so I can submit these 
> improvements?
> Thank you for your time and for maintaining such a great project!
> 
> May the source be with you,
> Sean Wei

  Hi,

I've just created an account for you and sent you the credentials in private.

  Cheers,
   Thomas


