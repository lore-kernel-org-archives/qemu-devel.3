Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E08C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cqf-0005Bl-Ss; Tue, 15 Apr 2025 05:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4cqc-0005BG-88
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4cqW-0004QT-I9
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744710286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HyDlSIjzPn4sfH9bqolKk6MqM/UoXDRRP74isyMcyUw=;
 b=duqkw3V9sd+xRCT70IT5/Bj/+lYJtekp2UGhcENSXSUsS0Zie7yiRa4F7ebZA2xsqtnxoH
 zyM96C7FWgWu3Aiu1GRzH7R4Ytf0SiAZAh9aoTRgc/+J9JQWXAd3UxN2iYi14RV0HLnBwf
 jScRkY2BU/pHJK0QEaq6eLkcU/tjeGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-bDAWoMEVMyONZaqE7zHM1A-1; Tue, 15 Apr 2025 05:44:44 -0400
X-MC-Unique: bDAWoMEVMyONZaqE7zHM1A-1
X-Mimecast-MFC-AGG-ID: bDAWoMEVMyONZaqE7zHM1A_1744710283
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d01024089so43648215e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 02:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744710283; x=1745315083;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HyDlSIjzPn4sfH9bqolKk6MqM/UoXDRRP74isyMcyUw=;
 b=WJEpt8J6iJSYqvs9HzJD0iDm9i6uJN29b7HmYUAIfaHsAnAt3Q7umlBXgiBCjNpQjj
 1T4QL5+XoK72DRy+5rdOodiLIRJ9vBLpD/a7Kcy8yvXQZjDzv109mLZtXpZ3KNhphRqo
 alStc90oFigs8Lk2+3DrT/Cl69LpAMuCJvKAIUlfcvGmfeMSqHmzIbxMzEzyt0HrGg+5
 cIZ1G6OYBrJe4rIIxfRE6qvEyZDwRLmGxJw2a3q4HsciVF4xZIpUCGQNL4axD8MqZBUb
 HJdwKfQbOH1UTzudTrmLp+H0rROuv1I1GR+e8spENyLdUreU6xSdDK9lIi7V49lwDe1H
 xl5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS2+4zsFsmNI2hgKwUIu8PqIukseDb4b6ay9Mu1rx8kAHR14qbu5s6I0iZNMPqvBPbxSvuucBQH6W5@nongnu.org
X-Gm-Message-State: AOJu0YxIXwdbSbcJn2V1jSgTCpOBAua5dVlCyhIL/wIqtsPyV7ujFLus
 hCAh84jMv/4jbWWO+GIA+XJrK55QIINB8DboNU6083ny1XuYBHLfSmCdfEPP1ax/6F23Slpde5+
 xJWbjv00YAZIuMCmqDiO+AWMTuzA1gMzhs9PJ4QWoIcCscbPZf3Vr
X-Gm-Gg: ASbGncvXPMyO0Tg9SoX6gz2Ol2WRAENNnL10AxAL97stm0EGxfUQZufKBVYlBfMQkeX
 gU+Kqh98Of+FL/LObkLJE0GLO9QCKC0a+KD0gWdmOBiwYtn/zcVX0F9VoQ31/4e0WtTNyOsjjXJ
 Dyofi7Vzj53e1BUNLI3LoRns+4RwY3B8f5SEk7wl7F9dM51SvkUusVmtTEnmgkOgSjGHfmYskJ1
 fE/kvgCLfxT8Xt+Qxj0IxSUEF4Tr9ZpjGNwS/ymnbcg3Ed4mHj6p0zz8DhFeHa8oMph10dPvYXY
 sMJzFGQUXh58pCnUuvv3HGvJGHxsAkFTHwq8uaSlUIE=
X-Received: by 2002:a05:600c:1f94:b0:43c:fb95:c752 with SMTP id
 5b1f17b1804b1-43f3a925de9mr165197455e9.3.1744710283032; 
 Tue, 15 Apr 2025 02:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGf9Tr/0LOVWzU6PLEXhFdURKyzBTatRb1tD7W3cuMFGdOVT0Sx1ncExhR/9BuFJuh/yLznQ==
X-Received: by 2002:a05:600c:1f94:b0:43c:fb95:c752 with SMTP id
 5b1f17b1804b1-43f3a925de9mr165197275e9.3.1744710282695; 
 Tue, 15 Apr 2025 02:44:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-176-89.web.vodafone.de.
 [109.43.176.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2338db88sm205549295e9.6.2025.04.15.02.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 02:44:42 -0700 (PDT)
Message-ID: <f96a9e7b-2bb9-4f0e-bbb2-3aca8bbbab02@redhat.com>
Date: Tue, 15 Apr 2025 11:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x: introduce function when exiting PV
To: Gautam Gala <ggala@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, seiden@linux.ibm.com
References: <20250414154838.556265-1-ggala@linux.ibm.com>
 <20250414154838.556265-3-ggala@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250414154838.556265-3-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/04/2025 17.48, Gautam Gala wrote:
> introduce a static function when exiting PV. The function replaces an
> existing macro (s390_pv_cmd_exit).

You describe here what you're doing, but not why ... so may I ask: Why is 
this change necessary?

  Thomas


> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---
>   target/s390x/kvm/pv.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 3a0a971f0b..66194caaae 100644
> --- a/target/s390x/kvm/pv.c
> +++ b/target/s390x/kvm/pv.c
> @@ -59,14 +59,12 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
>    */
>   #define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
>   #define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
> -#define s390_pv_cmd_exit(cmd, data)    \
> -{                                      \
> -    int rc;                            \
> -                                       \
> -    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
> -    if (rc) {                          \
> -        exit(1);                       \
> -    }                                  \
> +
> +static void s390_pv_cmd_exit(uint32_t cmd, void *data)
> +{
> +    if (s390_pv_cmd(cmd, data)) {
> +        exit(1);
> +    }
>   }
>   
>   int s390_pv_query_info(void)


