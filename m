Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93266CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4He-0003OK-9l; Fri, 12 Sep 2025 09:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux4HY-0003Np-RY
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ux4HR-0006wA-2c
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757685453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gjzsEbkW8mOEkGA7waZh3ZR3i5cmv/Ld+aXv3wor5s=;
 b=JLKwFZKeOnHWT1ObT/ZwTupJVL+s/Jn7nUwEU2HCxQ5l1N5U+ExOt1OgrT08ShGD24ib9V
 +WJ2NhnaRb7O8Nn+dZlHXaUaDgCrLOYuoaOpht9NkAmGnReDj+W1pCb3TmBe8/dTRlgmDF
 /bRk85wE9bqKDK3F04u+YdSAHn6m6MY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-9Sb4Py2sPsiomFAALmstoQ-1; Fri, 12 Sep 2025 09:57:31 -0400
X-MC-Unique: 9Sb4Py2sPsiomFAALmstoQ-1
X-Mimecast-MFC-AGG-ID: 9Sb4Py2sPsiomFAALmstoQ_1757685450
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e7c2273e69so240110f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 06:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757685450; x=1758290250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gjzsEbkW8mOEkGA7waZh3ZR3i5cmv/Ld+aXv3wor5s=;
 b=qI8bRnYipLuPoSxvVvQcT28HdTa/dJMwYdUk09T476MuH5ww1e+DASxpMNjxsC/lZ5
 ww/L4Ge1H5rDG4hG6Eh7sv+TKEPGrDgcABWxvflOCnSikB6UOpXrhSZ49wASdYriHOCs
 XwJ7tT8UesLgOPdUlrRPNApm4gD7WyI+f7EoZiAjkh719hGxxU+dZT8pzqscd7gShvGD
 EDao1pEsQZck3BEfchLqaTZr/4Ib/uNMoMx3H/+FWjVAHF89MvqG6RpefV1S8xIrliTa
 C2MztcyN8FLXecBntSvZSYSDGv0gfRUvEteFaWq6PDpbnpu4/1Bs2l5ab3/jCMSsetZz
 gd0A==
X-Gm-Message-State: AOJu0YyAXbIRkn3UgxnLQf6+/YjrF19QMxGiZWl+0RzgD5ebYHdhMabo
 IGLGzUOuREaQfgaiQQgDDxbyuAHFdImjWvqgfMMFhoRCuQOO0H6uHZaOvp73BAbw/TWTMG5Bn7Q
 6ZOYrA1eRZdOa4/n0A42o1OY6pP7v2DQ79sfbdSZWGdoDw8raByzIUhKy
X-Gm-Gg: ASbGnct+KNtPJgqe1VkO4vb5A3kj20HvXG7nZ75o4ED62tbtqAnxvegfVctP8nHNSLX
 OiMsdfzFbaogPWyzy/caZiHMS9n5dzJzFAeWuMccqYYmE0UORK9R0KjukXXe43Ba0njmM2SaJYY
 6s+fOtu2wt5gjs7fZr0VrkaQgyAd+ApAIYuXBmqlYfdtF0YqhFaJkxALKn9Zn6McwFnlGKTLF6l
 /ZnIrWruZp+TBZWzwoQ08D6Fi+z0lV+EHNOItqgnWurjDwGcug3Bign5Z5YoxZ3QDrrLkZ2VMQx
 H3KDHX0YNF6R8MnC+zBhSgEIJTK5C5F3XvqLUNIbHOpwHf6AC0LxnEQsTtqKp1r5acvXH8KgapW
 zfatZqLT2EzyA
X-Received: by 2002:a05:6000:24c5:b0:3da:37de:a3c6 with SMTP id
 ffacd0b85a97d-3e765a35a88mr3332492f8f.59.1757685450450; 
 Fri, 12 Sep 2025 06:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV30eqki6ioKAO7PgHWrzoJvIN5iHD8C01pXpCpAhvrjtfUa+ZQI9pNPgzxGv6B3/SWHmScQ==
X-Received: by 2002:a05:6000:24c5:b0:3da:37de:a3c6 with SMTP id
 ffacd0b85a97d-3e765a35a88mr3332463f8f.59.1757685450057; 
 Fri, 12 Sep 2025 06:57:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760778915sm6731516f8f.12.2025.09.12.06.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Sep 2025 06:57:29 -0700 (PDT)
Message-ID: <39761dc3-cd86-4cb2-9765-44bd0bdece1b@redhat.com>
Date: Fri, 12 Sep 2025 15:57:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] qmp: update virtio features map to support
 extended features
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <cover.1757676218.git.pabeni@redhat.com>
 <bef09bed78378da9c32d9913eefb83bd42ba8808.1757676218.git.pabeni@redhat.com>
 <87cy7v7pon.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87cy7v7pon.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/12/25 3:42 PM, Markus Armbruster wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
> 
>> Extend the VirtioDeviceFeatures struct with an additional u64
>> to track unknown features in the 64-127 bit range and decode
>> the full virtio features spaces for vhost and virtio devices.
>>
>> Also add entries for the soon-to-be-supported virtio net GSO over
>> UDP features.
>>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> You lost my
> Acked-by: Markus Armbruster <armbru@redhat.com>

Whoops, sorry!

And thanks for persisting with it :)

Paolo



