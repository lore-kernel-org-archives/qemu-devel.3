Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C455C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgRb1-0007uK-K2; Fri, 07 Feb 2025 11:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tgRaz-0007tu-Vp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:52:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tgRay-0004FV-60
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738947166;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2DMxp5NqGuhlDKNQ2xuPhKVtGPCQC67oVHERu9c1Xs=;
 b=TXSI+iw/Kq6O/jBG7e8TLBiajYRo+pM1kp4c+nTeC1kB+s0IT4vzCapl+VjsgYZo/5yKSG
 m0SVm+Epy7ufvyXcFJLrSOfa8S8ruAevSF5LN4PVQudFTxSP33bIp2e2d6PtDiiHTB8IIg
 1qRCL+JHmk30KU32rRZaZxtww5BWAA4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-BkUaSVXoMTG21WO9WuaP3Q-1; Fri, 07 Feb 2025 11:52:45 -0500
X-MC-Unique: BkUaSVXoMTG21WO9WuaP3Q-1
X-Mimecast-MFC-AGG-ID: BkUaSVXoMTG21WO9WuaP3Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso17698455e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738947164; x=1739551964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2DMxp5NqGuhlDKNQ2xuPhKVtGPCQC67oVHERu9c1Xs=;
 b=gImOR3z1bpuRIjHfSe2gJSav6DnKt5ZfJc/hclxWOP6tQr/iX8+TP1W1PbG3qJFA2W
 20NgilaIza1naa0AsGhavXKg8ujk5zDxXQOqB9idyfwdmHoE8bTjQkAarBSFJI7fk3Gr
 LTnnlVzM1aAJu4vO/JnGKorBBnQ/9kunEBaf3+jd8FDXFTCPCzoCh++V2HjB5eoE5Gxt
 sDYKhi/22zHKfSy3uRFdskumK+Z6ruVPgk9v4pAcd0bwPXo7mME3z60ypA2edMEEyh3O
 KhJmF72wJZa9qkup+2soJcNW3SmIXCUxgp6j1YqaLD6PNBulNzZlSn4Mf4kmgUqieV9/
 nQlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ/7YJd7RZhopCipIoILDd8rGOVI+hVhW86ACqiyEtDW16HfgMI3OQ+jbXhBJ9vNqBno7YmXvTtbDP@nongnu.org
X-Gm-Message-State: AOJu0Yw9uu+Rb6FrRmyGiSwe+zRXt7HdzXaTGkkFQcW/y+Auy/CQo9hZ
 adQZMFWo/iAflN7zWYSsUjK2zcOVcU6lVIhxq3yAH8xdLZW+5q2wwpu4Mt7hrl9bnjQaOLruwBP
 UyLxvjpKBL62hhRevvNOwQMTK0Lbd9WTg8tLbTBRX3qJrUPrW2NN0
X-Gm-Gg: ASbGncsnjE4YUEovNMR80KDQpZfLawVdPdI7VxnMbRkM+WBmfD4a4lUD8EvQgTxsTKt
 2gxhjeWZS1pA1qQXdkKpldXmq+WvWILoF9u9em8dyZGoBSBS6upp/4oBBggUTxgjKf2t1bK11Wf
 FAyAgKjiQB1jP3jj042NhLFDIfCt7T0OyistF6CI3YglL0rdXKlijKGsi34xL4szrwsv3SFRjSU
 XbX45+DDs0oh5xv63kIF32oUTmS3Dgr9+CApUFubqE4v+IVAZQmSFRlfPT51ljK/oEAKwyJowA4
 yc/lMoywN3HlLH+HfO3LoC6awD1ZLqcLNJFgoLPPjhR2UzWmodrs
X-Received: by 2002:a05:600c:354a:b0:436:e751:e445 with SMTP id
 5b1f17b1804b1-43924980937mr41889435e9.5.1738947164475; 
 Fri, 07 Feb 2025 08:52:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuqQUrbtze1GaOZGsPiEvj9Dr9LVUzsKvtLvbaLot6HBEWfQZlb0HRLRFBIDNGKSSqtvZ13g==
X-Received: by 2002:a05:600c:354a:b0:436:e751:e445 with SMTP id
 5b1f17b1804b1-43924980937mr41889175e9.5.1738947164052; 
 Fri, 07 Feb 2025 08:52:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da964e2sm60760295e9.4.2025.02.07.08.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 08:52:43 -0800 (PST)
Message-ID: <fdd6c6db-fd02-4dbf-af74-2b5e7ca5ca71@redhat.com>
Date: Fri, 7 Feb 2025 17:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250207060822-mutt-send-email-mst@kernel.org>
 <CAFEAcA8j_ra21a2cuJKSxcL81qoT5aUHmb_mOs1J7aVjdR+eXQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8j_ra21a2cuJKSxcL81qoT5aUHmb_mOs1J7aVjdR+eXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter, Michael,


On 2/7/25 5:40 PM, Peter Maydell wrote:
> On Fri, 7 Feb 2025 at 11:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
>>> This is a follow-up of Peter's attempt to fix the fact that
>>> vIOMMUs are likely to be reset before the device they protect:
>>>
>>> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
>>> https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
>>>
>>> This is especially observed with virtio devices when a qmp system_reset
>>> command is sent but also with VFIO devices.
>>>
>>> This series puts the vIOMMU reset in the 3-phase exit callback.
>>>
>>> This scheme was tested successful with virtio-devices and some
>>> VFIO devices. Nevertheless not all the topologies have been
>>> tested yet.
>>>
>>> Best Regards
>>>
>>> Eric
>>
>>
>> Looks good.
>>
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> How should this be merged?
>> I supposed I can merge the 1st three and the other
>> two by the respective maintainers?
>> I don't think there's a dependency here, right?
> If we're happy with the design of the series I think it
> would be simpler to take the whole thing through one
> tree, rather than split it up. I had a question on the
> smmu patch which is mostly about clarifying what the
> issue is that we're running into, but in principle
> I'm happy for you to take that patch as well.
Thank you for the swift review. I will respin to add some comments along
with the reset function and the relevance of exit phase + add more
details in the cover letter.

Thanks

Erc
>
> -- PMM
>


