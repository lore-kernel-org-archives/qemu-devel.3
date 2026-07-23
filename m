Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA29C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmupt-0003RL-PK; Thu, 23 Jul 2026 10:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmups-0003Qo-3K
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmupp-0004fy-8y
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784818539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+UjhYQXIr/TJaejsJ1x4zrIGFc6DGYhQPUV4f858yBQ=;
 b=AfJ9lcqnMjMMqGJJ0wbPCs/A9zuQbjQFAsVSBh7NcECb3YiaFyk6CDhELTy+ff8wN2/4tr
 9XxjC0t+p3EOb057VLGeZ95D+8ET2y2MmUQcT+aD8L/s3o68xBWR4YJ8z/3Sgj5c2ue64+
 I7hbWtR3tfxdocZCzBydmpV7b808+zI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-eyO6V0s2OC2G1KXngcKkzA-1; Thu, 23 Jul 2026 10:55:37 -0400
X-MC-Unique: eyO6V0s2OC2G1KXngcKkzA-1
X-Mimecast-MFC-AGG-ID: eyO6V0s2OC2G1KXngcKkzA_1784818536
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so521784f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784818536; x=1785423336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+UjhYQXIr/TJaejsJ1x4zrIGFc6DGYhQPUV4f858yBQ=;
 b=s1UkE+WXVhN+Wj5IXe5l8kgGAdUxPdJsvRzYMnOStPShE/aHckZnDpX1Jd25CLV5b7
 YZW9Jg7gH0+RmRwINGAUyeNtzSsprJVe1ENNZ8vMWs2vsoKcn8bVgpADdaIl9FvNSr+S
 vowS+7o+QXolcqrakgNXFhj2mxgegKvBsJ+Q9GuRINPYq+ghhPRlQUDWbMrrmODIyQ7T
 8LZ5lLNTCzt4G3JbI37Lp+wcqZSPKNExkIH9/tmTm+oun0Flz7QpclBjlno5DXpvOkjf
 yg1SR5KfppqXW6m6V4070tnKoIszIP39QNiOlLxmHbBejjDJEWWinhPiOK0FZlEFrZBz
 dMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784818536; x=1785423336;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+UjhYQXIr/TJaejsJ1x4zrIGFc6DGYhQPUV4f858yBQ=;
 b=pXKvHBy29nWSKHQyks+tXow2LTVklcvWqI8CUTS/o28yDLT+c2CDIAOacl3lU3aykL
 gZuKc/eq8f9nJe4fTrP9J2192dv64poEdu3NlUSGOfNMX5FG/TDvc5c56s2YOszea80Q
 GmBRzvAIfAPumh1CaaA/whMHzrUqIEV1vI7XiMtxA1KeLnnkz5MASJBKW1qbFSo+V9VX
 3gljJBAbSF/GkuJBSaZ3uDtSgS02PFleKP0nwy1KUQDGzQNE78rwnBn4XbZtDDj7pj0y
 iq2K39wEsK8mve15ain4NxK73HNLV+9vtvmu6jw6I2mJogO/vKYx6Nmd+5PmxaV6OzmO
 sjZg==
X-Gm-Message-State: AOJu0YzpWG5d9EUZ8JK4fZo9XOumVBMyZUbKClfm0q9giHwulmfHtdfG
 LJofPDKbX33Scs1aEoMhE5l1wt62cIO11vtDdMIEJacpwfnIMTGu/tDaCGQMOnOvIpOAZi7AW5k
 ybRklp44QPF4jKImzKg872gSSRnmS230msyqQK5MuAMyiJUUeCUXuq+YY
X-Gm-Gg: AR+sD11S3IryPK2/bkwlmtStjet9YTh4dP4s2uys6XIbyQkWjwr1qVzw5BGFOcJLUTF
 KJpkPID2+0YQlxUmiiPSis7TRJdeL5xEbf0UQPIgESgm0TzGF6dX7ReXTwRLhIPFO58yINbl65E
 g7cz+qSFOiSkmpYaD1ESmzmnW+l+U1fSdT1aRERWcwpLnhYbFn0SkgCAfFmX04hd8bVGEDbj77M
 HPcEpQy/5qV8aSZ2108lT9AXNqPr5mbiOAjyZMDmaXbdISYR0u6TbKj0HHideCvRklDoaN+3etd
 hASc40jYyIdaN2RrB481Cw9kmXftqWyW4pNOd5fqVHoRRb1WNFYybQTVZbfwlI5/5TASfCiDMLZ
 uYsuTZlpdc2xaSRbcV2oSJ25g9s+LHEKtYfu5po4=
X-Received: by 2002:a05:6000:2388:b0:47f:7526:598 with SMTP id
 ffacd0b85a97d-47f8da5c900mr4664981f8f.12.1784818535707; 
 Thu, 23 Jul 2026 07:55:35 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:47f:7526:598 with SMTP id
 ffacd0b85a97d-47f8da5c900mr4664948f8f.12.1784818535209; 
 Thu, 23 Jul 2026 07:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb81dcsm15794666f8f.12.2026.07.23.07.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 07:55:34 -0700 (PDT)
Message-ID: <472bf0d9-eb2f-4f42-92ff-968cbae0c6d2@redhat.com>
Date: Thu, 23 Jul 2026 16:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode DMA
 (re)map for passthrough BARs
To: Wencheng Yang <east.moutain.yang@gmail.com>,
 Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Yangwencheng <yangwencheng@gmail.com>
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
 <20260721110247-mutt-send-email-mst@kernel.org>
 <20260721230004.2c03fede@shazbot.org>
 <CALrP2iVwJqufzvjOdiEiE0FPTHkMjMjhA4H0siaLAuAHmw2wLQ@mail.gmail.com>
 <c3b5a5f5-0c3a-4793-9dd6-206ba0b6ed72@redhat.com>
 <CALrP2iVpdgxARSOtCOAj54tiy_+YrNBTu_DS=e_5HVGfC_-ffg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CALrP2iVpdgxARSOtCOAj54tiy_+YrNBTu_DS=e_5HVGfC_-ffg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> Applying the two patches above might help reduce this time. I'm currently
> running QEMU 8.2 with kernel 5.10, and directly cherry-picking these two
> patches resultsin conflicts. I'll spend some time backporting them and
> see how the results look.

Oh. It might be very difficult to do the backport on such
an old code base specially for Linux. And there is more to
it as Alex said.

We would be interested by the results with upstream though.
Could please you give it a try first ? Then, I would rebase
if possible.

Thanks,

C.


