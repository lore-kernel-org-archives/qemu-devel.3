Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ED8CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78bA-0003BP-1M; Fri, 10 Oct 2025 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78b7-0003BH-Sl
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v78b4-0006m5-MP
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760085324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lNCnmxR8479VBPTkJleXmboATl2Dkzph501mbTuC3dE=;
 b=Av5sEBC9xBFz0b/pyM5omVU69D152Si2ihjgu9274Nu17F6a5jvppWeixg2prqKDtXNsTI
 W/zgvuT+Ag33YyOx1EYPdsoFr/Iqp1PRPk08huqsVHIZr2S7TcuI4Yhr/HbVcmCv18LZW2
 dbd4q15DK+9tPSo2Tvy7GVKgT0KnPB0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-RDYJBln3NqmLzUVX5WqssA-1; Fri, 10 Oct 2025 04:35:23 -0400
X-MC-Unique: RDYJBln3NqmLzUVX5WqssA-1
X-Mimecast-MFC-AGG-ID: RDYJBln3NqmLzUVX5WqssA_1760085322
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ed9557f976so1594842f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 01:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760085322; x=1760690122;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNCnmxR8479VBPTkJleXmboATl2Dkzph501mbTuC3dE=;
 b=MtcWFItvI5R/5RpQCUWbH2Y16Xcl7nQdwIzEA2DudMXRFs99MKIMR8fV+UiJDaa6cb
 btl9UKXBuUgbQYRGOlTsk3uOSuk6vbtL7mYD7XbpVEwbNZdl8RqwaLSShSZ5+3MRYa8c
 VrUDbrYsIxkMB+TOuYZzIamWgJk1SCzXRc0Nfi/QprKaDnK4unTSKwfwK7EZGZeSaNB6
 0juVcv6Y3z6ULDPuXdytw5kUaMa+AkSQX9URo+l9gum+7vjXbBlFCfyjzRni5VfjBELF
 t7XefJzdl/qMB0vfPf4upaqSysMKjLI47ovkbMOnaioBhy3amBmZYApZqYyUGOrkcECh
 9gyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Ym7PsD7GXdY024At5+wR18jpWyqQRynRIWSF9pUHuZrVHsiLe8xXo6Ke5I7c4ME65naSpoXFolDy@nongnu.org
X-Gm-Message-State: AOJu0YyrWhJgJ9uT0UschVmOsxYlO683oD5pYTPQK1/miGkemsVPuu3D
 lPBpnfDpieo0RtcKUHv8niSB3MBTOVRT5eVXWyKZ4VIbAjhZWKvQEVmQYZ7KEh/axaamxWRvQhy
 7AR+7zz/s+8ErlTLFwM5xZPYzkAiDhKzA5IW1MKd+q+q6tOh1lymBs8/+
X-Gm-Gg: ASbGncveTLAELo8P8gkAYW4raw/p7yg8nOYO7bqcjSV/TxpqmAF1AQepwMcpX5emriL
 /qtyeujAOoXh2haIl+YiKFJh0q8YlkyemFjWAVq3GSkFAFe5jvRqbdH6X21Urvl/xVL9EkA0qmd
 Fzg2EDRpe7b/MQWAGn1YN/++ZiUc6rFAvqxW+gzqC8H5Wf8x8R6rLz9m38f8+csajwUzdwRH+g7
 L7/KMTyaSM4E458FigVScvOvOgMKNgHGQLcg/5NJ7+iFenGhHdx8TX8Em3NRfzHYwA8gkq4Q02E
 LrjKhLzyt7iKobIABB78SyyP+EPcct6e8kv+db07f+67jNh+bZYeewYmIdYN5P0wNPo96jymhyC
 mviQ3
X-Received: by 2002:a05:6000:2504:b0:3ee:141a:ede5 with SMTP id
 ffacd0b85a97d-4266e8e66a4mr6621715f8f.57.1760085321666; 
 Fri, 10 Oct 2025 01:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU5yfB7C/ZWl6j74RcnK7sn0wSiR5SNaw+Fz84NA30Cbe/NSrVbydinoDhrjAfhE0xgFYMkA==
X-Received: by 2002:a05:6000:2504:b0:3ee:141a:ede5 with SMTP id
 ffacd0b85a97d-4266e8e66a4mr6621687f8f.57.1760085321211; 
 Fri, 10 Oct 2025 01:35:21 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5825aasm2979944f8f.14.2025.10.10.01.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 01:35:20 -0700 (PDT)
Message-ID: <e9f99985-1432-4e74-8fdd-5f79ebaef15d@redhat.com>
Date: Fri, 10 Oct 2025 10:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iotest 233 is failing
From: Thomas Huth <thuth@redhat.com>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-28-peterx@redhat.com>
 <9ad2350a-d640-4fcf-8804-d085a0f87ed4@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9ad2350a-d640-4fcf-8804-d085a0f87ed4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/10/2025 10.00, Thomas Huth wrote:
> On 03/10/2025 17.39, Peter Xu wrote:
>> QCryptoTLSSession allows TLS premature termination in two cases, one of the
>> case is when the channel shutdown() is invoked on READ side.
>   Hi Peter,
> 
> this patch break iotest 233 for me:
...
> Could you please have a look?
Never mind, Daniel just told me that there is already a patch available:

https://lore.kernel.org/qemu-devel/20251006190126.4159590-1-berrange@redhat.com/

  Thomas


