Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2FDCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 13:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzEFD-0005Sy-Qw; Thu, 18 Sep 2025 09:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzEF2-0005RL-Gy
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 09:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzEF0-0005e9-Lq
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 09:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758200401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9IjNrTO6l2WUeHwBn4ex1xGULTIDfvUVC0KDvPXUEN0=;
 b=eyIjIFnkUEuEIjn14G7UmF3SHd6ihftq9E4GC0p3KI4sT1fb86RdsmSRZ0M/5fu+0u44sY
 DiJEw1cOglEVZ5NkRUOLfo4ODznvSFA/Yd1j/6QaG9Wyf7A+ekOQuKmDUheNawSeou1ITn
 Kycc6fhJ/r+NRByTKXaMMZI3DsW81Po=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-MtychEAkOJWwivVHaW0mEw-1; Thu, 18 Sep 2025 09:00:00 -0400
X-MC-Unique: MtychEAkOJWwivVHaW0mEw-1
X-Mimecast-MFC-AGG-ID: MtychEAkOJWwivVHaW0mEw_1758200399
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45cb612d362so5257145e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 05:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758200399; x=1758805199;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9IjNrTO6l2WUeHwBn4ex1xGULTIDfvUVC0KDvPXUEN0=;
 b=EGM+aFWWwsmZDq//36zQIWJpLKUkdCcfiZmxa0uOzJMP7tD5FHWtaop/1+73OnfogY
 sBSsqpa53tjAMFV4FA3tqygFERDHu7Fhk8ssp63FYpuwbRdtG8JdilKqt9BHcgelsOrf
 Cios2xrloOkdtrG9we+wUcRokk/DHbVGCbmBAbAvpeHiXEZrRhlqlE0OBCC10uencNpG
 I/cBufGle5FdzlaiJBYe/fwRmdHxoaJeG63/YoSxsLBfx2982wDcjTLKV2aWte0hy/Ws
 S+K/xEEzjoC73nUg4XmhxR9KoqFUZEjhRnJcuNjy5BENjYhx+DdkLyTZ/pVMD9s5jiRF
 2h/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVocJdrs9/HKH+Ao3OmdeilTN+xF8ACfJlJETCP2gkCS24ocHkzNx0a36b02JBKf1kUHe2GMQjxuDiz@nongnu.org
X-Gm-Message-State: AOJu0YxiTPxOnuDmXc7xLA9pWvRbYthHTqJbOF0FK4VE+LnrJFy+61F5
 89oF+g6jj1B3DAex+16YVaxVC/tlQjqKVe1KVqXqopB2yQx1YpPpI0ZhhO2WBRNfei9KOQKK1Xx
 VpmDO6mPyGxe8nn/7cQrXIBDQM1S260fgajCoYCnUGo/s5mtxx5BgnUIQ
X-Gm-Gg: ASbGnctYQCDYDjHJqhs1N0jT64PpLocXffnHO0z1IDMRWjZ3KkhupjkNKHGcHpx61uq
 M+fCQ7TF5u4z/5nTTB+lp46NEALRqv6bcJGyMEUy1TqywkjLXwyEABEu6C/iQo2GtQncyZfsCGK
 VVv9hxtRrgb60fRSm3Jg+cha1zAwHjj1EMGFc5XOp54Q+qTClxrlG/2p/4x1u59m0AUldKcI7ZI
 i2B16u2oTdOxM6FO/mQqpW6X3lu3L7w6t0hiJ1h4ht7NeWmDUoNP42J8DZQAqjYRR7i/Zv8Vh2v
 QhzKgx0lGmWZsDSyLCz1fcqzQ7GfHX7YS/PGrriaKCCU7tlADAAaCNlUXoGcBcWrYttOJDtpdcT
 lppSl5g==
X-Received: by 2002:a05:600c:4507:b0:45f:29ed:2cff with SMTP id
 5b1f17b1804b1-46206f04fabmr45079535e9.35.1758200398882; 
 Thu, 18 Sep 2025 05:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjUJ1rWAfQMiG3wXuY2x09r+Jt1DuScyy2pg2gRqmPCWpXiQsOGbE9hG8qKoiXgrfcVApfug==
X-Received: by 2002:a05:600c:4507:b0:45f:29ed:2cff with SMTP id
 5b1f17b1804b1-46206f04fabmr45079325e9.35.1758200398501; 
 Thu, 18 Sep 2025 05:59:58 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee1095489asm3136001f8f.24.2025.09.18.05.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 05:59:58 -0700 (PDT)
Message-ID: <155ba08a-4bf0-4c62-995e-0321859055b8@redhat.com>
Date: Thu, 18 Sep 2025 14:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: retry when seeing ConnectionError
 exception
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250918125746.1165658-1-berrange@redhat.com>
 <20250918125746.1165658-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250918125746.1165658-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 18/09/2025 14.57, Daniel P. Berrangé wrote:
> This base class is used for many different socket connection
> errors, corresponding to ECONNRESET, ECONNREFUSED, ECONNABORTED
> and more. Most of these are things you might expect to see every
> now and then as transient flaws. We should thus retry the asset
> download when seeing them.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index 2dd32bf28d..f8b87d2153 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -179,6 +179,13 @@ def fetch(self):
>                                  self.url, e.reason)
>                   raise AssetError(self, "Unable to download: URL error %s" %
>                                    e.reason, transient=True)
> +            except ConnectionError as e:
> +                # A socket connection failure, such as dropped conn
> +                # or refused conn
> +                tmp_cache_file.unlink()
> +                self.log.error("Unable to download %s: Connection error %s",
> +                               self.url, e)
> +                continue
>               except Exception as e:
>                   tmp_cache_file.unlink()
>                   raise AssetError(self, "Unable to download: %s" % e)

Reviewed-by: Thomas Huth <thuth@redhat.com>


